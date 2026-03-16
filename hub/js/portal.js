/* =============================================
   PORTAL.JS — Lógica do Portal da Cliente
   Depende de: supabase.js, data.js, portal-db.js
   ============================================= */

/* -----------------------------------------------
   ESTADO DO PORTAL
----------------------------------------------- */
const PORTAL_STATE = {
  clienteId:   null,     // UUID do cliente sendo visualizado
  isPreview:   false,    // true quando admin usa ?preview=1
  cliente:     null,     // objeto cliente
  posts:       [],       // posts dos próximos 3 meses
  objetivos:   [],       // objetivos_mes dos próximos 3 meses
  meses:       [],       // ex: ["Abril", "Maio", "Junho"]
  contagem:    {},       // { postId: numero_de_comentarios }
  comentarios: {}        // { postId: [comentario, ...] } — cache lazy
};

/* -----------------------------------------------
   INICIALIZAÇÃO
----------------------------------------------- */
document.addEventListener("DOMContentLoaded", async () => {
  _mostrarCarregando();

  // 1. Verificar sessão
  const user = await portalDb.exigirLogin();
  if (!user) return;

  // 2. Ler parâmetros da URL
  const params = new URLSearchParams(location.search);
  PORTAL_STATE.isPreview = params.get("preview") === "1";
  const urlClienteId = params.get("client_id");

  // 3. Determinar clienteId e validar acesso
  if (PORTAL_STATE.isPreview && urlClienteId) {
    // Modo preview: verificar que é admin
    const role = await portalDb.getRole();
    if (role !== "admin") {
      _mostrarErro("Acesso negado", "Apenas o administrador pode usar o modo preview.");
      return;
    }
    PORTAL_STATE.clienteId = urlClienteId;
  } else if (urlClienteId) {
    // URL tem client_id mas não é preview — possível tentativa indevida
    // Verificar se é admin ou se o cliente pertence ao usuário
    const role = await portalDb.getRole();
    if (role === "admin") {
      PORTAL_STATE.clienteId = urlClienteId;
    } else {
      // Segurança: ignorar o client_id da URL e usar o vínculo real
      const cliente = await portalDb.fetchMinhaCliente();
      if (!cliente) {
        _mostrarErro("Sem acesso", "Sua conta ainda não foi vinculada a nenhuma cliente. Entre em contato com a administração.");
        return;
      }
      PORTAL_STATE.clienteId = cliente.id;
      PORTAL_STATE.cliente   = cliente;
    }
  } else {
    // Modo cliente real: descobrir cliente pelo vínculo
    const cliente = await portalDb.fetchMinhaCliente();
    if (!cliente) {
      _mostrarErro("Sem acesso", "Sua conta ainda não foi vinculada a nenhuma cliente. Entre em contato com a administração.");
      return;
    }
    PORTAL_STATE.clienteId = cliente.id;
    PORTAL_STATE.cliente   = cliente;
  }

  // 4. Buscar cliente se ainda não temos (modo preview ou admin direto)
  if (!PORTAL_STATE.cliente) {
    const cliente = await portalDb.fetchClientePorId(PORTAL_STATE.clienteId);
    if (!cliente) {
      _mostrarErro("Cliente não encontrado", "Não foi possível carregar os dados desta cliente.");
      return;
    }
    PORTAL_STATE.cliente = cliente;
  }

  // 5. Calcular os próximos 3 meses
  PORTAL_STATE.meses = _proximos3Meses(PORTAL_STATE.cliente.meses_ativos);

  // 6. Buscar dados em paralelo
  const [posts, objetivos] = await Promise.all([
    portalDb.fetchPostsPortal(PORTAL_STATE.clienteId, PORTAL_STATE.meses),
    portalDb.fetchObjetivosPortal(PORTAL_STATE.clienteId, PORTAL_STATE.meses)
  ]);

  PORTAL_STATE.posts     = posts;
  PORTAL_STATE.objetivos = objetivos;

  // 7. Buscar contagem de comentários para todos os posts
  const postIds = posts.map(p => p.id);
  PORTAL_STATE.contagem = await portalDb.fetchContagemComentarios(postIds);

  // 8. Renderizar
  _esconderCarregando();
  if (PORTAL_STATE.isPreview) _renderBannerPreview();
  _renderHeader();
  _renderBloco1_Objetivos();
  _renderBloco2_Orcamento();
  _renderBloco3_Calendario();
  _renderBloco4_Lista();
});

/* -----------------------------------------------
   CÁLCULO DOS PRÓXIMOS 3 MESES
----------------------------------------------- */
function _proximos3Meses(mesesAtivos) {
  if (!mesesAtivos || mesesAtivos.length === 0) return [];
  const hoje    = new Date();
  const mesAtual = hoje.getMonth(); // 0 = Janeiro
  const resultado = [];

  for (let offset = 0; offset < 12 && resultado.length < 3; offset++) {
    const nome = MESES_ANO[(mesAtual + offset) % 12];
    if (mesesAtivos.includes(nome)) resultado.push(nome);
  }
  return resultado;
}

/* -----------------------------------------------
   BANNER PREVIEW
----------------------------------------------- */
function _renderBannerPreview() {
  const el = document.getElementById("preview-banner");
  if (!el) return;
  el.innerHTML = `
    <span class="preview-banner-icon">👁</span>
    <span class="preview-banner-text">
      Modo Preview — você está vendo exatamente como
      <strong>${_esc(PORTAL_STATE.cliente.nome)}</strong>
      enxerga o portal.
    </span>
    <button class="preview-banner-close" onclick="this.parentElement.style.display='none'" title="Fechar banner">×</button>
  `;
  el.style.display = "flex";
}

/* -----------------------------------------------
   CABEÇALHO DO PORTAL
----------------------------------------------- */
function _renderHeader() {
  const el = document.getElementById("portal-header");
  if (!el) return;
  const c = PORTAL_STATE.cliente;
  const meses = PORTAL_STATE.meses;
  const periodo = meses.length > 0
    ? meses.join(" · ")
    : "Próximos meses";

  el.innerHTML = `
    <div class="portal-header-top">
      <div class="portal-avatar">${_esc(c.avatar)}</div>
      <div>
        <div class="portal-header-nome">${_esc(c.nome)}</div>
        <div class="portal-header-handle">${_esc(c.handle)}</div>
      </div>
    </div>
    <div class="portal-header-sub">
      Planejamento editorial · ${_esc(periodo)}
    </div>
  `;
}

/* -----------------------------------------------
   BLOCO 1 — OBJETIVOS MENSAIS
----------------------------------------------- */
function _renderBloco1_Objetivos() {
  const el = document.getElementById("bloco-objetivos");
  if (!el) return;

  const cards = PORTAL_STATE.meses.map(mes => {
    const obj = PORTAL_STATE.objetivos.find(o => o.mes === mes);
    if (!obj || !obj.objetivo) {
      return `
        <div class="portal-card portal-card-vazio">
          <span>${_esc(mes)}</span>
        </div>
      `;
    }
    const datas = (obj.datas_importantes || [])
      .filter(Boolean)
      .map(d => `<span class="obj-data-pill">${_esc(d)}</span>`)
      .join("");

    return `
      <div class="portal-card">
        <div class="portal-card-mes">${_esc(mes)}</div>
        <div class="obj-objetivo">${_esc(obj.objetivo)}</div>
        ${obj.tipo_anuncio ? `<div class="obj-foco">📌 ${_esc(obj.tipo_anuncio)}</div>` : ""}
        ${datas ? `<div class="obj-datas">${datas}</div>` : ""}
      </div>
    `;
  }).join("");

  el.innerHTML = `<div class="portal-3col">${cards}</div>`;
}

/* -----------------------------------------------
   BLOCO 2 — ORÇAMENTO DE ANÚNCIOS
----------------------------------------------- */
function _renderBloco2_Orcamento() {
  const el = document.getElementById("bloco-orcamento");
  if (!el) return;

  const cards = PORTAL_STATE.meses.map(mes => {
    const obj = PORTAL_STATE.objetivos.find(o => o.mes === mes);

    if (!obj || !obj.orcamento_anuncios) {
      return `
        <div class="portal-card portal-card-vazio">
          <span>${_esc(mes)} — sem orçamento definido</span>
        </div>
      `;
    }

    const topo  = obj.funil_topo  ?? 50;
    const meio  = obj.funil_meio  ?? 30;
    const fundo = obj.funil_fundo ?? 20;

    return `
      <div class="portal-card">
        <div class="portal-card-mes">${_esc(mes)}</div>
        <div class="orc-valor">${_esc(obj.orcamento_anuncios)}</div>
        ${obj.tipo_anuncio ? `<div class="orc-obs">${_esc(obj.tipo_anuncio)}</div>` : ""}
        <div class="funil-bar-wrap">
          <div class="funil-seg-topo"  style="flex:${topo}"></div>
          <div class="funil-seg-meio"  style="flex:${meio}"></div>
          <div class="funil-seg-fundo" style="flex:${fundo}"></div>
        </div>
        <div class="funil-legenda">
          <span class="funil-legenda-item">
            <span class="funil-dot funil-dot-topo"></span> Topo ${topo}%
          </span>
          <span class="funil-legenda-item">
            <span class="funil-dot funil-dot-meio"></span> Meio ${meio}%
          </span>
          <span class="funil-legenda-item">
            <span class="funil-dot funil-dot-fundo"></span> Fundo ${fundo}%
          </span>
        </div>
      </div>
    `;
  }).join("");

  el.innerHTML = `<div class="portal-3col">${cards}</div>`;
}

/* -----------------------------------------------
   BLOCO 3 — CALENDÁRIO VISUAL
----------------------------------------------- */
function _renderBloco3_Calendario() {
  const el = document.getElementById("bloco-calendario");
  if (!el) return;

  const colunas = PORTAL_STATE.meses.map(mes => {
    const posts = PORTAL_STATE.posts.filter(p => p.mes === mes);

    if (posts.length === 0) {
      return `
        <div class="cal-mes-col">
          <div class="cal-mes-header">${_esc(mes)}</div>
          <div class="cal-sem-posts">Nenhum post programado</div>
        </div>
      `;
    }

    const chips = posts.map(p => {
      const cls   = _chaveStatusCal(p.status);
      const data  = p.data_publicacao ? _formatarDia(p.data_publicacao) : "—";
      const temCom = (PORTAL_STATE.contagem[p.id] || 0) > 0;
      return `
        <div class="cal-chip cal-chip-${cls}" onclick="scrollParaPost('${p.id}')" title="${_esc(p.titulo)}">
          <span class="cal-chip-data">${data}</span>
          <span class="cal-chip-titulo">${_esc(p.titulo)}</span>
          ${temCom ? `<span class="cal-chip-comentado" title="Comentado"></span>` : ""}
        </div>
      `;
    }).join("");

    return `
      <div class="cal-mes-col">
        <div class="cal-mes-header">${_esc(mes)}</div>
        <div class="cal-mes-body">${chips}</div>
      </div>
    `;
  }).join("");

  el.innerHTML = `
    <div class="cal-grid">${colunas}</div>
    <div class="cal-legenda">
      <span class="cal-legenda-item"><span class="cal-legenda-dot cal-legenda-dot-emproducao"></span> Em produção</span>
      <span class="cal-legenda-item"><span class="cal-legenda-dot cal-legenda-dot-aprovado"></span> Aprovado</span>
      <span class="cal-legenda-item"><span class="cal-legenda-dot cal-legenda-dot-reprovado"></span> Reprovado</span>
      <span class="cal-legenda-item"><span class="cal-legenda-dot cal-legenda-dot-publicado"></span> Publicado</span>
      <span class="cal-legenda-item"><span class="cal-legenda-dot cal-legenda-dot-outro"></span> Outro status</span>
    </div>
  `;
}

/* -----------------------------------------------
   BLOCO 4 — LISTA DETALHADA
----------------------------------------------- */
function _renderBloco4_Lista() {
  const el = document.getElementById("bloco-lista");
  if (!el) return;

  if (PORTAL_STATE.posts.length === 0) {
    el.innerHTML = `<p style="color:#9CA3AF;font-size:14px">Nenhum post programado para os próximos meses.</p>`;
    return;
  }

  // Agrupar por mês
  const grupos = PORTAL_STATE.meses.map(mes => {
    const posts = PORTAL_STATE.posts.filter(p => p.mes === mes);
    return { mes, posts };
  }).filter(g => g.posts.length > 0);

  const html = grupos.map(({ mes, posts }) => {
    const cards = posts.map(p => _renderCardPost(p)).join("");
    return `
      <div style="margin-bottom:8px">
        <div style="font-size:12px;font-weight:700;text-transform:uppercase;letter-spacing:0.6px;color:#9CA3AF;margin-bottom:10px;padding-left:4px">
          ${_esc(mes)}
        </div>
        ${cards}
      </div>
    `;
  }).join("");

  el.innerHTML = `<div class="lista-posts">${html}</div>`;
}

function _renderCardPost(p) {
  const contagemCom = PORTAL_STATE.contagem[p.id] || 0;
  const data = p.data_publicacao ? _formatarDataCompleta(p.data_publicacao) : null;
  const statusCls = _chaveStatusCss(p.status);

  const badgeStatus = p.status
    ? `<span class="badge badge-status-${statusCls}">${_esc(p.status)}</span>`
    : "";

  const badgeFormato = p.formato
    ? `<span class="badge ${_classeFormato(p.formato)}">${_esc(p.formato)}</span>`
    : "";

  const badgeComentario = `
    <span class="lista-comentario-badge ${contagemCom > 0 ? "tem-comentario" : ""}">
      💬 ${contagemCom > 0 ? contagemCom + " comentário" + (contagemCom > 1 ? "s" : "") : "Comentar"}
    </span>
  `;

  return `
    <div class="lista-post-card" id="post-${p.id}">
      <div class="lista-post-header" onclick="toggleCard('${p.id}')">
        <div class="lista-post-meta">
          <div class="lista-post-titulo">${_esc(p.titulo)}</div>
          <div class="lista-post-badges">
            ${badgeStatus}
            ${badgeFormato}
            ${data ? `<span class="lista-post-data">${data}</span>` : ""}
            ${badgeComentario}
          </div>
        </div>
        <div class="lista-post-expand-icon">⌄</div>
      </div>
      <div class="lista-post-body" id="body-${p.id}">
        ${p.linha ? `
          <div class="lista-campo">
            <div class="lista-campo-label">Linha editorial</div>
            <div class="lista-campo-valor">${_esc(p.linha)}</div>
          </div>
        ` : ""}
        ${p.gancho ? `
          <div class="lista-campo">
            <div class="lista-campo-label">Gancho</div>
            <div class="lista-campo-valor">${_esc(p.gancho)}</div>
          </div>
        ` : ""}
        ${p.roteiro ? `
          <div class="lista-campo">
            <div class="lista-campo-label">Roteiro</div>
            <div class="lista-campo-valor">${_esc(p.roteiro)}</div>
          </div>
        ` : ""}
        <div class="comentarios-wrap" id="comentarios-${p.id}">
          <div class="comentarios-titulo">Seus comentários</div>
          <div id="comentarios-lista-${p.id}" class="comentarios-lista">
            <div class="comentarios-vazio">Carregando comentários...</div>
          </div>
          <div class="comentario-form">
            <textarea
              class="comentario-textarea"
              id="textarea-${p.id}"
              placeholder="Escreva seu comentário aqui..."></textarea>
            <button
              class="comentario-btn"
              id="btn-comentar-${p.id}"
              onclick="enviarComentario('${p.id}')">
              Enviar comentário
            </button>
          </div>
        </div>
      </div>
    </div>
  `;
}

/* -----------------------------------------------
   INTERAÇÕES
----------------------------------------------- */

/**
 * Abre/fecha o card de um post e carrega comentários lazy.
 */
async function toggleCard(postId) {
  const card = document.getElementById(`post-${postId}`);
  if (!card) return;

  const jaAberto = card.classList.contains("aberto");
  card.classList.toggle("aberto");

  // Carregar comentários na primeira abertura
  if (!jaAberto && PORTAL_STATE.comentarios[postId] === undefined) {
    await _carregarComentarios(postId);
  }
}

/**
 * Navega até o card de um post (chamado pelo calendário).
 */
function scrollParaPost(postId) {
  const el = document.getElementById(`post-${postId}`);
  if (!el) return;
  el.scrollIntoView({ behavior: "smooth", block: "start" });

  // Abrir o card se estiver fechado
  if (!el.classList.contains("aberto")) {
    toggleCard(postId);
  }
}

/**
 * Carrega e renderiza os comentários de um post (lazy).
 */
async function _carregarComentarios(postId) {
  const listaEl = document.getElementById(`comentarios-lista-${postId}`);
  if (!listaEl) return;

  const comentarios = await portalDb.fetchComentarios(postId);
  PORTAL_STATE.comentarios[postId] = comentarios;

  _renderComentariosLista(postId, comentarios);
}

function _renderComentariosLista(postId, comentarios) {
  const listaEl = document.getElementById(`comentarios-lista-${postId}`);
  if (!listaEl) return;

  if (!comentarios || comentarios.length === 0) {
    listaEl.innerHTML = `<div class="comentarios-vazio">Nenhum comentário ainda.</div>`;
    return;
  }

  listaEl.innerHTML = comentarios.map(c => `
    <div class="comentario-item">
      <div class="comentario-data">${_formatarDataHora(c.created_at)}</div>
      <div class="comentario-corpo">${_esc(c.corpo)}</div>
    </div>
  `).join("");
}

/**
 * Envia um comentário para um post.
 */
async function enviarComentario(postId) {
  const textarea = document.getElementById(`textarea-${postId}`);
  const btn      = document.getElementById(`btn-comentar-${postId}`);
  if (!textarea || !btn) return;

  const texto = textarea.value.trim();
  if (!texto) return;

  btn.disabled = true;
  btn.textContent = "Enviando...";

  const novo = await portalDb.adicionarComentario(postId, texto);

  if (novo) {
    textarea.value = "";

    // Atualizar cache e re-renderizar lista
    if (!PORTAL_STATE.comentarios[postId]) PORTAL_STATE.comentarios[postId] = [];
    PORTAL_STATE.comentarios[postId].push(novo);
    _renderComentariosLista(postId, PORTAL_STATE.comentarios[postId]);

    // Atualizar contagem
    PORTAL_STATE.contagem[postId] = (PORTAL_STATE.contagem[postId] || 0) + 1;

    // Atualizar badge no card
    _atualizarBadgeComentario(postId);

    // Atualizar indicador no calendário
    _atualizarCalChip(postId);

    _toastPortal("Comentário enviado!");
  } else {
    _toastPortal("Erro ao enviar comentário. Tente novamente.");
  }

  btn.disabled = false;
  btn.textContent = "Enviar comentário";
}

/**
 * Atualiza o badge de comentário no card da lista.
 */
function _atualizarBadgeComentario(postId) {
  const card = document.getElementById(`post-${postId}`);
  if (!card) return;
  const badge = card.querySelector(".lista-comentario-badge");
  if (!badge) return;
  const n = PORTAL_STATE.contagem[postId] || 0;
  badge.className = `lista-comentario-badge ${n > 0 ? "tem-comentario" : ""}`;
  badge.textContent = `💬 ${n > 0 ? n + " comentário" + (n > 1 ? "s" : "") : "Comentar"}`;
}

/**
 * Atualiza o indicador de comentado no chip do calendário.
 */
function _atualizarCalChip(postId) {
  const chips = document.querySelectorAll(`.cal-chip[onclick*="${postId}"]`);
  chips.forEach(chip => {
    const jaTemPonto = chip.querySelector(".cal-chip-comentado");
    if (!jaTemPonto) {
      const ponto = document.createElement("span");
      ponto.className = "cal-chip-comentado";
      ponto.title = "Comentado";
      chip.appendChild(ponto);
    }
  });
}

/* -----------------------------------------------
   ESTADO DE CARREGAMENTO / ERRO
----------------------------------------------- */
function _mostrarCarregando() {
  const content = document.getElementById("portal-content");
  const loading = document.getElementById("portal-loading");
  if (content) content.style.display = "none";
  if (loading) loading.style.display = "flex";
}

function _esconderCarregando() {
  const content = document.getElementById("portal-content");
  const loading = document.getElementById("portal-loading");
  if (content) content.style.display = "block";
  if (loading) loading.style.display = "none";
}

function _mostrarErro(titulo, texto) {
  const content = document.getElementById("portal-content");
  const loading = document.getElementById("portal-loading");
  const erroEl  = document.getElementById("portal-erro");
  if (content) content.style.display = "none";
  if (loading) loading.style.display = "none";
  if (erroEl) {
    erroEl.style.display = "flex";
    document.getElementById("portal-erro-titulo").textContent = titulo;
    document.getElementById("portal-erro-texto").textContent  = texto;
  }
}

/* -----------------------------------------------
   TOAST
----------------------------------------------- */
let _toastTimer = null;
function _toastPortal(msg) {
  const el = document.getElementById("portal-toast");
  if (!el) return;
  el.textContent = msg;
  el.classList.add("visivel");
  clearTimeout(_toastTimer);
  _toastTimer = setTimeout(() => el.classList.remove("visivel"), 3000);
}

/* -----------------------------------------------
   HELPERS
----------------------------------------------- */

/** Escapa HTML para prevenir XSS */
function _esc(str) {
  if (!str) return "";
  return String(str)
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;");
}

/** Extrai o dia do mês de uma data ISO (ex: "2026-04-07" → "7") */
function _formatarDia(iso) {
  if (!iso) return "—";
  const [, , dia] = iso.split("-");
  return String(parseInt(dia, 10));
}

/** Formata data completa (ex: "2026-04-07" → "7 de Abril") */
function _formatarDataCompleta(iso) {
  if (!iso) return "";
  try {
    const d = new Date(iso + "T12:00:00");
    return d.toLocaleDateString("pt-BR", { day: "numeric", month: "long" });
  } catch { return iso; }
}

/** Formata data e hora de comentário */
function _formatarDataHora(iso) {
  if (!iso) return "";
  try {
    const d = new Date(iso);
    return d.toLocaleDateString("pt-BR", { day: "numeric", month: "short", year: "numeric" })
      + " às "
      + d.toLocaleTimeString("pt-BR", { hour: "2-digit", minute: "2-digit" });
  } catch { return iso; }
}

/**
 * Converte o status para a chave CSS usada nos chips do calendário.
 * "em produção" → "emproducao", "aprovado" → "aprovado" etc.
 */
function _chaveStatusCal(status) {
  if (!status) return "neutro";
  const s = status.toLowerCase()
    .normalize("NFD").replace(/[\u0300-\u036f]/g, "")
    .replace(/[^a-z0-9]/g, "");
  const mapa = { emproducao: "emproducao", aprovado: "aprovado", reprovado: "reprovado", publicado: "publicado" };
  return mapa[s] || "neutro";
}

/**
 * Converte o status para a chave CSS usada nos badges (mesma lógica).
 */
function _chaveStatusCss(status) {
  return _chaveStatusCal(status);
}

/**
 * Retorna a classe CSS para badge de formato.
 */
function _classeFormato(formato) {
  if (!formato) return "badge-neutro";
  const f = formato.toLowerCase();
  if (f === "reels")      return "badge-formato-reels";
  if (f === "carrossel")  return "badge-formato-carrossel";
  if (f === "post único") return "badge-formato-postunico";
  if (f.startsWith("story")) return "badge-formato-story";
  return "badge-neutro";
}
