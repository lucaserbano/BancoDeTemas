/* =============================================
   DB.JS — Funções de banco de dados (Supabase)
   Depende de: supabase.js (define window.sb)
   =============================================

   Todas as funções são async e retornam { data, error }.
   Quando error != null, algo deu errado — a função
   mostra um toast automaticamente.

   Mapeamento de nomes:
   - JS usa camelCase (clienteId, data_publicacao)
   - Supabase usa snake_case (cliente_id, data_publicacao)
   - As funções aqui fazem a conversão nos dois sentidos.
   ============================================= */

const db = {

  /* -----------------------------------------------
     AUTENTICAÇÃO
  ----------------------------------------------- */

  /**
   * Faz login com email e senha.
   * Retorna { data: { user, session }, error }
   */
  async login(email, senha) {
    const { data, error } = await sb.auth.signInWithPassword({ email, password: senha });
    return { data, error };
  },

  /**
   * Faz logout do usuário atual.
   */
  async logout() {
    const { error } = await sb.auth.signOut();
    if (error) console.error("Erro ao fazer logout:", error.message);
    window.location.href = "login.html";
  },

  /**
   * Retorna o usuário logado atualmente, ou null se não há sessão.
   */
  async getUsuario() {
    const { data: { user } } = await sb.auth.getUser();
    return user;
  },

  /**
   * Verifica se há sessão ativa. Se não houver, redireciona para login.html.
   * Chame isso no início de cada página protegida.
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
   * Verifica se o usuário logado é admin.
   * Se não for, redireciona para portal.html (área da cliente).
   * Chame isso nas páginas internas após exigirLogin().
   */
  async exigirAdmin() {
    const { data } = await sb.from("profiles").select("role").eq("id", (await this.getUsuario())?.id).single();
    if (!data || data.role !== "admin") {
      window.location.href = "portal.html";
      return false;
    }
    return true;
  },

  /* -----------------------------------------------
     CLIENTES
  ----------------------------------------------- */

  /**
   * Busca todos os clientes do usuário logado.
   * Retorna array de objetos de cliente.
   */
  async fetchClientes() {
    const { data, error } = await sb
      .from("clientes")
      .select("*")
      .order("created_at", { ascending: true });

    if (error) {
      _erroToast("buscar clientes", error);
      return [];
    }
    // Mapeia snake_case → camelCase
    return (data || []).map(_mapCliente);
  },

  /**
   * Cria um novo cliente no banco.
   * @param {Object} dados - campos do cliente (camelCase)
   * Retorna o cliente criado ou null em caso de erro.
   */
  async criarCliente(dados) {
    const user = await this.getUsuario();
    if (!user) return null;

    const payload = {
      user_id:        user.id,
      nome:           dados.nome,
      handle:         dados.handle,
      especialidade:  dados.especialidade || null,
      avatar:         dados.avatar || "👤",
      seguidores:     dados.seguidores || 0,
      meta_posts_mes: dados.meta_posts_mes || 4,
      ano:            dados.ano || 2026,
      meses_ativos:   dados.meses_ativos || MESES_ANO.slice(3) // Abril–Dezembro por padrão
    };

    const { data, error } = await sb
      .from("clientes")
      .insert(payload)
      .select()
      .single();

    if (error) { _erroToast("criar cliente", error); return null; }
    return _mapCliente(data);
  },

  /**
   * Atualiza campos de um cliente existente.
   * @param {string} id - UUID do cliente
   * @param {Object} dados - campos a atualizar
   */
  async atualizarCliente(id, dados) {
    const payload = {};
    if (dados.nome          !== undefined) payload.nome           = dados.nome;
    if (dados.handle        !== undefined) payload.handle         = dados.handle;
    if (dados.especialidade !== undefined) payload.especialidade  = dados.especialidade;
    if (dados.avatar        !== undefined) payload.avatar         = dados.avatar;
    if (dados.seguidores    !== undefined) payload.seguidores     = dados.seguidores;
    if (dados.meta_posts_mes!== undefined) payload.meta_posts_mes = dados.meta_posts_mes;
    if (dados.meses_ativos  !== undefined) payload.meses_ativos   = dados.meses_ativos;

    const { data, error } = await sb
      .from("clientes")
      .update(payload)
      .eq("id", id)
      .select()
      .single();

    if (error) { _erroToast("atualizar cliente", error); return null; }
    return _mapCliente(data);
  },

  /**
   * Exclui um cliente e todos os seus posts (cascade no banco).
   */
  async excluirCliente(id) {
    const { error } = await sb
      .from("clientes")
      .delete()
      .eq("id", id);

    if (error) { _erroToast("excluir cliente", error); return false; }
    return true;
  },

  /* -----------------------------------------------
     POSTS
  ----------------------------------------------- */

  /**
   * Busca todos os posts de um cliente.
   * @param {string} clienteId - UUID do cliente
   */
  async fetchPosts(clienteId) {
    const { data, error } = await sb
      .from("posts")
      .select("*")
      .eq("cliente_id", clienteId)
      .order("created_at", { ascending: false });

    if (error) { _erroToast("buscar posts", error); return []; }
    return (data || []).map(_mapPost);
  },

  /**
   * Cria um novo post.
   * @param {Object} dados - campos do post (camelCase)
   * Retorna o post criado ou null.
   */
  async criarPost(dados) {
    const payload = _postParaBanco(dados);

    const { data, error } = await sb
      .from("posts")
      .insert(payload)
      .select()
      .single();

    if (error) { _erroToast("criar post", error); return null; }
    return _mapPost(data);
  },

  /**
   * Atualiza um post existente.
   * @param {string} id - UUID do post
   * @param {Object} dados - campos a atualizar (camelCase)
   */
  async atualizarPost(id, dados) {
    const payload = _postParaBanco(dados);

    const { data, error } = await sb
      .from("posts")
      .update(payload)
      .eq("id", id)
      .select()
      .single();

    if (error) { _erroToast("atualizar post", error); return null; }
    return _mapPost(data);
  },

  /**
   * Exclui um post.
   */
  async excluirPost(id) {
    const { error } = await sb
      .from("posts")
      .delete()
      .eq("id", id);

    if (error) { _erroToast("excluir post", error); return false; }
    return true;
  },

  /**
   * Verifica se já existe um post para este cliente com a mesma data de publicação.
   * Usado pela importação de posts históricos do Instagram para evitar duplicatas.
   * @param {string} clienteId
   * @param {string} dataPublicacao - ISO date string
   * @returns {boolean}
   */
  async postJaExiste(clienteId, dataPublicacao) {
    const { data, error } = await sb
      .from("posts")
      .select("id")
      .eq("cliente_id", clienteId)
      .eq("data_publicacao", dataPublicacao)
      .limit(1);

    if (error) return false;
    return (data || []).length > 0;
  },

  /**
   * Verifica se já existe um post para este cliente com o mesmo título.
   * Usado pela importação do banco de temas para evitar duplicatas.
   * @param {string} clienteId
   * @param {string} titulo
   * @returns {boolean}
   */
  async postTituloJaExiste(clienteId, titulo) {
    const { data, error } = await sb
      .from("posts")
      .select("id")
      .eq("cliente_id", clienteId)
      .eq("titulo", titulo)
      .limit(1);

    if (error) return false;
    return (data || []).length > 0;
  },

  /**
   * Atualiza o campo `mes` de vários posts de uma vez.
   * Usado pelo carrinho ao atribuir mês.
   * @param {string[]} ids - array de UUIDs
   * @param {string}   mes - nome do mês ou "Banco"
   */
  async atualizarMesPosts(ids, mes) {
    if (!ids || ids.length === 0) return true;

    const { error } = await sb
      .from("posts")
      .update({ mes })
      .in("id", ids);

    if (error) { _erroToast("atribuir mês", error); return false; }
    return true;
  },

  /* -----------------------------------------------
     OBJETIVOS MENSAIS
  ----------------------------------------------- */

  /**
   * Busca todos os objetivos mensais de um cliente.
   */
  async fetchObjetivos(clienteId) {
    const { data, error } = await sb
      .from("objetivos_mes")
      .select("*")
      .eq("cliente_id", clienteId);

    if (error) { _erroToast("buscar objetivos", error); return []; }
    return data || [];
  },

  /**
   * Cria ou atualiza (upsert) um objetivo mensal.
   * @param {Object} dados - { clienteId, mes, ano, objetivo, ... }
   */
  async salvarObjetivo(dados) {
    const payload = {
      cliente_id:         dados.clienteId,
      mes:                dados.mes,
      ano:                dados.ano || 2026,
      objetivo:           dados.objetivo,
      orcamento_anuncios: dados.orcamento_anuncios || null,
      tipo_anuncio:       dados.tipo_anuncio || null,
      datas_importantes:  dados.datas_importantes || [],
      funil_topo:         dados.funil_topo  ?? 50,
      funil_meio:         dados.funil_meio  ?? 30,
      funil_fundo:        dados.funil_fundo ?? 20
    };

    const { data, error } = await sb
      .from("objetivos_mes")
      .upsert(payload, { onConflict: "cliente_id,mes,ano" })
      .select()
      .single();

    if (error) { _erroToast("salvar objetivo", error); return null; }
    return data;
  }

}; // fim do objeto db


/* -----------------------------------------------
   FUNÇÕES PRIVADAS DE MAPEAMENTO
----------------------------------------------- */

/**
 * Converte um registro de cliente do banco (snake_case) para o formato
 * usado pelo JavaScript do hub (camelCase onde necessário).
 */
function _mapCliente(row) {
  return {
    id:             row.id,
    user_id:        row.user_id,
    nome:           row.nome,
    handle:         row.handle,
    especialidade:  row.especialidade || "",
    avatar:         row.avatar || "👤",
    seguidores:     row.seguidores || 0,
    posts_publicados: 0,        // calculado localmente a partir dos posts
    meta_posts_mes: row.meta_posts_mes || 4,
    ano:            row.ano || 2026,
    meses_ativos:   row.meses_ativos || MESES_ANO.slice()
  };
}

/**
 * Converte um registro de post do banco para o formato JS do hub.
 */
function _mapPost(row) {
  return {
    id:              row.id,
    clienteId:       row.cliente_id,   // snake → camel
    titulo:          row.titulo,
    linha:           row.linha,
    subtema:         row.subtema || "",
    formato:         row.formato,
    funil:           row.funil,
    serie:           row.serie || "—",
    mes:             row.mes || "Banco",
    status:          row.status,
    likes:           row.likes || 0,
    comentarios:     row.comentarios || 0,
    data_publicacao: row.data_publicacao || null,
    gancho:          row.gancho || "",
    orientacoes:     row.orientacoes || "",
    roteiro:         row.roteiro || ""
  };
}

/**
 * Converte um objeto de post JS (camelCase) para o formato do banco (snake_case).
 */
function _postParaBanco(dados) {
  const payload = {};
  if (dados.clienteId      !== undefined) payload.cliente_id      = dados.clienteId;
  if (dados.titulo         !== undefined) payload.titulo          = dados.titulo;
  if (dados.linha          !== undefined) payload.linha           = dados.linha;
  if (dados.subtema        !== undefined) payload.subtema         = dados.subtema;
  if (dados.formato        !== undefined) payload.formato         = dados.formato;
  if (dados.funil          !== undefined) payload.funil           = dados.funil;
  if (dados.serie          !== undefined) payload.serie           = dados.serie;
  if (dados.mes            !== undefined) payload.mes             = dados.mes;
  if (dados.status         !== undefined) payload.status          = dados.status;
  if (dados.likes          !== undefined) payload.likes           = dados.likes;
  if (dados.comentarios    !== undefined) payload.comentarios     = dados.comentarios;
  if (dados.data_publicacao!== undefined) payload.data_publicacao = dados.data_publicacao;
  if (dados.gancho         !== undefined) payload.gancho          = dados.gancho;
  if (dados.orientacoes    !== undefined) payload.orientacoes     = dados.orientacoes;
  if (dados.roteiro        !== undefined) payload.roteiro         = dados.roteiro;
  return payload;
}

/**
 * Exibe toast de erro padronizado.
 */
function _erroToast(operacao, error) {
  console.error(`Erro ao ${operacao}:`, error.message);
  if (typeof showToast === "function") {
    showToast(`Erro ao ${operacao}: ${error.message}`);
  }
}
