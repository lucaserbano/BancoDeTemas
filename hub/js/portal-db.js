/* =============================================
   PORTAL-DB.JS — Funções de banco para o Portal da Cliente
   Depende de: supabase.js (define window.sb)

   Segurança:
   - Todas as queries respeitam o RLS do Supabase.
   - Cliente vê somente dados da própria cliente (RLS em clientes, posts, objetivos_mes, post_comments).
   - Admin pode acessar qualquer cliente em modo preview (RLS admin read all).
   ============================================= */

const portalDb = {

  /* -----------------------------------------------
     AUTENTICAÇÃO E PAPEL (ROLE)
  ----------------------------------------------- */

  /**
   * Retorna o usuário logado, ou null se não autenticado.
   */
  async getUsuario() {
    const { data: { user } } = await sb.auth.getUser();
    return user;
  },

  /**
   * Verifica sessão. Se não houver, redireciona para login.html.
   */
  async exigirLogin() {
    const user = await this.getUsuario();
    if (!user) {
      window.location.href = "login.html";
      return null;
    }
    return user;
  },

  /**
   * Retorna o papel do usuário logado: 'admin' | 'client' | null.
   * Consulta a tabela profiles.
   */
  async getRole() {
    const user = await this.getUsuario();
    if (!user) return null;

    const { data, error } = await sb
      .from("profiles")
      .select("role")
      .eq("id", user.id)
      .single();

    if (error || !data) return "client"; // padrão seguro
    return data.role;
  },

  /* -----------------------------------------------
     CLIENTE
  ----------------------------------------------- */

  /**
   * Busca a cliente vinculada ao usuário logado (modo cliente real).
   * Retorna o objeto cliente ou null se não houver vínculo.
   */
  async fetchMinhaCliente() {
    const { data, error } = await sb
      .from("client_users")
      .select("cliente_id, clientes(*)")
      .single();

    if (error || !data) return null;
    return _portalMapCliente(data.clientes);
  },

  /**
   * Busca uma cliente pelo ID (usado no modo preview do admin).
   * @param {string} clienteId
   */
  async fetchClientePorId(clienteId) {
    const { data, error } = await sb
      .from("clientes")
      .select("*")
      .eq("id", clienteId)
      .single();

    if (error || !data) return null;
    return _portalMapCliente(data);
  },

  /* -----------------------------------------------
     POSTS
  ----------------------------------------------- */

  /**
   * Busca posts da cliente para os meses especificados.
   * Retorna apenas posts com data_publicacao ou pertencentes aos meses do portal.
   * @param {string} clienteId
   * @param {string[]} meses — ex: ["Abril", "Maio", "Junho"]
   */
  async fetchPostsPortal(clienteId, meses) {
    const { data, error } = await sb
      .from("posts")
      .select("*")
      .eq("cliente_id", clienteId)
      .in("mes", meses)
      .order("data_publicacao", { ascending: true, nullsFirst: false });

    if (error) {
      console.error("Erro ao buscar posts do portal:", error.message);
      return [];
    }
    return (data || []).map(_portalMapPost);
  },

  /* -----------------------------------------------
     OBJETIVOS MENSAIS
  ----------------------------------------------- */

  /**
   * Busca objetivos mensais da cliente para os meses especificados.
   * @param {string} clienteId
   * @param {string[]} meses — ex: ["Abril", "Maio", "Junho"]
   */
  async fetchObjetivosPortal(clienteId, meses) {
    const { data, error } = await sb
      .from("objetivos_mes")
      .select("*")
      .eq("cliente_id", clienteId)
      .in("mes", meses);

    if (error) {
      console.error("Erro ao buscar objetivos:", error.message);
      return [];
    }
    return data || [];
  },

  /* -----------------------------------------------
     COMENTÁRIOS
  ----------------------------------------------- */

  /**
   * Busca comentários de um post específico.
   * @param {string} postId
   */
  async fetchComentarios(postId) {
    const { data, error } = await sb
      .from("post_comments")
      .select("*")
      .eq("post_id", postId)
      .order("created_at", { ascending: true });

    if (error) {
      console.error("Erro ao buscar comentários:", error.message);
      return [];
    }
    return data || [];
  },

  /**
   * Busca a contagem de comentários para vários posts de uma vez.
   * Retorna um objeto { postId: contagem, ... }
   * @param {string[]} postIds
   */
  async fetchContagemComentarios(postIds) {
    if (!postIds || postIds.length === 0) return {};

    const { data, error } = await sb
      .from("post_comments")
      .select("post_id")
      .in("post_id", postIds);

    if (error) {
      console.error("Erro ao buscar contagem de comentários:", error.message);
      return {};
    }

    // Agrega contagem localmente
    const contagem = {};
    for (const row of (data || [])) {
      contagem[row.post_id] = (contagem[row.post_id] || 0) + 1;
    }
    return contagem;
  },

  /**
   * Adiciona um comentário em um post.
   * @param {string} postId
   * @param {string} corpo — texto do comentário
   */
  async adicionarComentario(postId, corpo) {
    const user = await this.getUsuario();
    if (!user) return null;

    const { data, error } = await sb
      .from("post_comments")
      .insert({ post_id: postId, user_id: user.id, corpo: corpo.trim() })
      .select()
      .single();

    if (error) {
      console.error("Erro ao adicionar comentário:", error.message);
      return null;
    }
    return data;
  },

  /**
   * Exclui um comentário pelo ID.
   * Funciona para o autor do comentário e para admins (RLS valida no banco).
   * @param {string} id — UUID do comentário
   */
  async excluirComentario(id) {
    const { error } = await sb
      .from("post_comments")
      .delete()
      .eq("id", id);

    if (error) {
      console.error("Erro ao excluir comentário:", error.message);
      return false;
    }
    return true;
  },

  /**
   * Salva o comentário da cliente sobre objetivos ou orçamento de um mês.
   * @param {string} clienteId
   * @param {string} mes — ex: "Abril"
   * @param {"objetivos"|"orcamento"} campo
   * @param {string} texto
   */
  async salvarComentarioObjetivo(clienteId, mes, campo, texto) {
    const ano = new Date().getFullYear();
    const updateField = campo === "objetivos"
      ? { comentario_objetivos: texto }
      : { comentario_orcamento: texto };

    const { error } = await sb
      .from("objetivos_mes")
      .upsert(
        { cliente_id: clienteId, mes, ano, ...updateField },
        { onConflict: "cliente_id,mes,ano" }
      );

    if (error) {
      console.error("Erro ao salvar comentário de objetivo:", error.message);
      return false;
    }
    return true;
  },

  /**
   * Atualiza o status de um post (aprovado / reprovado / em produção / publicado).
   * @param {string} postId
   * @param {string} status
   */
  async atualizarStatusPost(postId, status) {
    const { data, error } = await sb
      .from("posts")
      .update({ status })
      .eq("id", postId)
      .select()
      .single();

    if (error) {
      console.error("Erro ao atualizar status do post:", error.message);
      return null;
    }
    return data;
  }

};


/* -----------------------------------------------
   FUNÇÕES PRIVADAS DE MAPEAMENTO
----------------------------------------------- */

function _portalMapCliente(row) {
  if (!row) return null;
  return {
    id:            row.id,
    nome:          row.nome,
    handle:        row.handle,
    especialidade: row.especialidade || "",
    avatar:        row.avatar || "👤",
    seguidores:    row.seguidores || 0,
    meses_ativos:  row.meses_ativos || []
  };
}

function _portalMapPost(row) {
  if (!row) return null;
  return {
    id:              row.id,
    clienteId:       row.cliente_id,
    titulo:          row.titulo,
    linha:           row.linha || "",
    subtema:         row.subtema || "",
    formato:         row.formato || "",
    funil:           row.funil || "",
    serie:           row.serie || "—",
    mes:             row.mes || "",
    status:          row.status || "",
    data_publicacao: row.data_publicacao || null,
    gancho:          row.gancho || "",
    orientacoes:     row.orientacoes || "",
    roteiro:         row.roteiro || ""
  };
}
