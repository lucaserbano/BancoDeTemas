/* =============================================
   APP.JS — Lógica do index.html
   Depende de: supabase.js, db.js, data.js, ui.js
   ============================================= */

/* -----------------------------------------------
   ESTADO DA PÁGINA
----------------------------------------------- */
const STATE = {
  mesFiltro:    "Todos",
  statusFiltro: "Todos",
  linhaFiltro:  "Todas",
  editandoId:   null   // ID do post sendo editado (null = novo post)
};

/* -----------------------------------------------
   INICIALIZAÇÃO
----------------------------------------------- */
document.addEventListener("DOMContentLoaded", async () => {

  // 1. Verifica login — redireciona se não autenticado
  const usuario = await db.exigirLogin();
  if (!usuario) return;

  // 2. Adiciona botão de logout no header (se existir o container)
  _renderBotaoLogout();

  // 3. Carrega clientes do banco
  const clientes = await db.fetchClientes();
  CLIENTES.length = 0;
  clientes.forEach(c => CLIENTES.push(c));

  // 4. Restaura cliente ativo (ou usa o primeiro)
  if (CLIENTES.length === 0) {
    _mostrarEstadoVazioGlobal();
    return;
  }
  const idSalvo = localStorage.getItem("hub_clienteAtivo");
  const clienteExiste = CLIENTES.find(c => c.id === idSalvo);
  if (!clienteExiste) setClienteAtivo(CLIENTES[0].id);

  // 5. Carrega posts do cliente ativo
  await _carregarPostsDoClienteAtivo();

  // 6. Renderiza tudo
  renderSidebar();
  renderClienteHeader();
  renderMetrics();
  renderToolbar();
  renderTabela();
  inicializarModais();
  inicializarCarrinho();
  _preencherCartMes();
});

/* -----------------------------------------------
   CARREGAR POSTS DO CLIENTE ATIVO
----------------------------------------------- */
async function _carregarPostsDoClienteAtivo() {
  const c = getClienteAtivo();
  if (!c) return;
  const posts = await db.fetchPosts(c.id);
  POSTS.length = 0;
  posts.forEach(p => POSTS.push(p));
}

/* -----------------------------------------------
   SIDEBAR
----------------------------------------------- */
function renderSidebar() {
  const el = document.getElementById("sidebar-clientes");
  if (!el) return;
  const ativo = getClienteAtivo();

  if (CLIENTES.length === 0) {
    el.innerHTML = `<div style="padding:16px;color:#666;font-size:12px">Nenhum cliente cadastrado.</div>`;
    return;
  }

  el.innerHTML = CLIENTES.map(c => `
    <div class="sidebar-cliente ${c.id === ativo?.id ? "ativo" : ""}"
         onclick="selecionarCliente('${c.id}')">
      <div class="sidebar-avatar">${c.avatar}</div>
      <div class="sidebar-cliente-info">
        <div class="sidebar-cliente-nome">${c.nome}</div>
        <div class="sidebar-cliente-handle">${c.handle}</div>
      </div>
    </div>
  `).join("");
}

async function selecionarCliente(id) {
  setClienteAtivo(id);
  selectedIds.clear();
  _updateCartFab();
  STATE.mesFiltro    = "Todos";
  STATE.statusFiltro = "Todos";
  STATE.linhaFiltro  = "Todas";

  // Carrega posts do novo cliente
  await _carregarPostsDoClienteAtivo();

  renderSidebar();
  renderClienteHeader();
  renderMetrics();
  renderToolbar();
  renderTabela();
  _preencherCartMes();
}

/* -----------------------------------------------
   CABEÇALHO DO CLIENTE
----------------------------------------------- */
function renderClienteHeader() {
  const el = document.getElementById("client-header");
  if (!el) return;
  const c = getClienteAtivo();
  if (!c) return;

  el.innerHTML = `
    <div class="client-header-info">
      <div class="client-header-avatar">${c.avatar}</div>
      <div>
        <div class="client-header-nome">${c.nome}</div>
        <div class="client-header-handle">${c.handle} · ${c.seguidores.toLocaleString("pt-BR")} seguidores</div>
        <div class="client-header-espec">${c.especialidade}</div>
      </div>
    </div>
    <div class="client-header-actions">
      <a href="mes.html" class="btn btn-secondary">📅 Ver Calendário</a>
    </div>
  `;
}

/* -----------------------------------------------
   MÉTRICAS
----------------------------------------------- */
function renderMetrics() {
  const el = document.getElementById("metrics-cards");
  if (!el) return;
  const c     = getClienteAtivo();
  const posts = POSTS; // já filtrados pelo cliente ativo
  const pub   = posts.filter(p => p.status === "Publicado");
  const agend = posts.filter(p => p.status !== "Publicado").length;
  const avgLikes = pub.length
    ? Math.round(pub.reduce((s, p) => s + (p.likes || 0), 0) / pub.length)
    : 0;

  el.innerHTML = `
    <div class="metric-card">
      <div class="metric-icon">📋</div>
      <div>
        <div class="metric-value">${posts.length}</div>
        <div class="metric-label">Posts no banco</div>
      </div>
    </div>
    <div class="metric-card">
      <div class="metric-icon">✅</div>
      <div>
        <div class="metric-value">${pub.length}</div>
        <div class="metric-label">Publicados</div>
      </div>
    </div>
    <div class="metric-card">
      <div class="metric-icon">⏳</div>
      <div>
        <div class="metric-value">${agend}</div>
        <div class="metric-label">Em produção</div>
      </div>
    </div>
    <div class="metric-card">
      <div class="metric-icon">❤️</div>
      <div>
        <div class="metric-value">${avgLikes > 0 ? avgLikes.toLocaleString("pt-BR") : "—"}</div>
        <div class="metric-label">Média de likes</div>
      </div>
    </div>
  `;
}

/* -----------------------------------------------
   BARRA DE FERRAMENTAS
----------------------------------------------- */
function renderToolbar() {
  const el = document.getElementById("toolbar");
  if (!el) return;
  const c = getClienteAtivo();
  const meses = c ? ["Todos", ...(c.meses_ativos || MESES_ANO), "Banco"] : ["Todos"];

  el.innerHTML = `
    <div class="toolbar-filtros">
      <input type="checkbox" id="cbAll" onchange="toggleSelectAll(this.checked)" title="Selecionar todos">
      <select id="filtroMes" onchange="aplicarFiltros()">
        ${meses.map(m => `<option value="${m}" ${m === STATE.mesFiltro ? "selected":""}>${m}</option>`).join("")}
      </select>
      <select id="filtroStatus" onchange="aplicarFiltros()">
        ${["Todos",...STATUS].map(s => `<option value="${s}" ${s === STATE.statusFiltro ? "selected":""}>${s}</option>`).join("")}
      </select>
      <select id="filtroLinha" onchange="aplicarFiltros()">
        ${["Todas",...LINHAS].map(l => `<option value="${l}" ${l === STATE.linhaFiltro ? "selected":""}>${l}</option>`).join("")}
      </select>
    </div>
    <button class="btn btn-primary" onclick="abrirModalNovoPost()">+ Novo Post</button>
  `;
}

function aplicarFiltros() {
  STATE.mesFiltro    = document.getElementById("filtroMes")?.value    || "Todos";
  STATE.statusFiltro = document.getElementById("filtroStatus")?.value || "Todos";
  STATE.linhaFiltro  = document.getElementById("filtroLinha")?.value  || "Todas";
  renderTabela();
}

function _postsFiltrados() {
  return POSTS.filter(p => {
    if (STATE.mesFiltro    !== "Todos"  && p.mes    !== STATE.mesFiltro)    return false;
    if (STATE.statusFiltro !== "Todos"  && p.status !== STATE.statusFiltro) return false;
    if (STATE.linhaFiltro  !== "Todas"  && p.linha  !== STATE.linhaFiltro)  return false;
    return true;
  });
}

/* -----------------------------------------------
   TABELA DE POSTS
----------------------------------------------- */
function renderTabela() {
  const el = document.getElementById("table-wrap");
  if (!el) return;
  const posts = _postsFiltrados();

  if (posts.length === 0) {
    el.innerHTML = `
      <div class="empty-state">
        <div class="empty-state-icon">📭</div>
        <p>${POSTS.length === 0 ? "Nenhum post cadastrado ainda.<br>Clique em <strong>+ Novo Post</strong> para começar." : "Nenhum post com esses filtros."}</p>
      </div>
    `;
    return;
  }

  el.innerHTML = `
    <table>
      <thead>
        <tr>
          <th></th><th>#</th><th>Título</th><th>Linha</th><th>Formato</th>
          <th>Funil</th><th>Mês</th><th>Status</th><th>Likes</th><th>Coment.</th><th>Ações</th>
        </tr>
      </thead>
      <tbody>
        ${posts.map((p, i) => _linhaPost(p, i + 1)).join("")}
      </tbody>
    </table>
  `;
}

function _linhaPost(p, num) {
  const publicado = p.status === "Publicado";
  const isSel = selectedIds.has(p.id);
  return `
    <tr data-id="${p.id}" class="${isSel ? "selecionada" : ""}">
      <td><input type="checkbox" ${isSel ? "checked" : ""} onchange="toggleSelect('${p.id}', this.checked)"></td>
      <td class="col-num">${num}</td>
      <td class="col-titulo"><span class="col-titulo-text" title="${_esc(p.titulo)}">${p.titulo}</span></td>
      <td>${badgeHTML("linha", linhaAbrev(p.linha))}</td>
      <td>${badgeHTML("formato", p.formato)}</td>
      <td>${badgeHTML("funil", p.funil)}</td>
      <td>${badgeHTML("mes", p.mes)}</td>
      <td>${badgeHTML("status", p.status)}</td>
      <td class="col-metricas">${publicado ? formatarNumero(p.likes) : "—"}</td>
      <td class="col-metricas">${publicado ? formatarNumero(p.comentarios) : "—"}</td>
      <td>
        <div class="acoes">
          <button class="btn-icon" onclick="abrirModalEditarPost('${p.id}')" title="Editar">✏️</button>
          <button class="btn-icon" onclick="excluirPost('${p.id}')" title="Excluir">🗑️</button>
        </div>
      </td>
    </tr>
  `;
}

/* -----------------------------------------------
   MODAL DE NOVO/EDITAR POST
----------------------------------------------- */
function inicializarModais() {
  document.querySelectorAll(".modal-overlay").forEach(overlay => {
    overlay.addEventListener("click", (e) => {
      if (e.target === overlay) closeModal(overlay.id);
    });
  });
}

function abrirModalNovoPost() {
  STATE.editandoId = null;
  const c = getClienteAtivo();
  _preencherModalPost(null, c);
  openModal("modal-post");
}

function abrirModalEditarPost(id) {
  const post = POSTS.find(p => p.id === id);
  if (!post) return;
  STATE.editandoId = id;
  const c = getClienteAtivo();
  _preencherModalPost(post, c);
  openModal("modal-post");
}

function _preencherModalPost(post, cliente) {
  const meses = [...(cliente?.meses_ativos || MESES_ANO), "Banco"];
  const isNovo = !post;
  const tituloEl = document.getElementById("modal-post-titulo-h");
  if (tituloEl) tituloEl.textContent = isNovo ? "Novo Post" : "Editar Post";

  const body = document.getElementById("modal-post-body");
  if (!body) return;

  body.innerHTML = `
    <div class="form-grupo">
      <label for="fp-titulo">Título *</label>
      <input id="fp-titulo" type="text" placeholder="Título do post" value="${post ? _esc(post.titulo) : ""}">
    </div>
    <div class="form-row">
      <div class="form-grupo">
        <label for="fp-linha">Linha editorial</label>
        <select id="fp-linha">
          ${LINHAS.map(l => `<option value="${l}" ${post?.linha===l?"selected":""}>${l}</option>`).join("")}
        </select>
      </div>
      <div class="form-grupo">
        <label for="fp-subtema">Subtema</label>
        <input id="fp-subtema" type="text" placeholder="Ex: Exercício Físico" value="${post ? _esc(post.subtema) : ""}">
      </div>
    </div>
    <div class="form-row">
      <div class="form-grupo">
        <label for="fp-formato">Formato</label>
        <select id="fp-formato">
          ${FORMATOS.map(f => `<option value="${f}" ${post?.formato===f?"selected":""}>${f}</option>`).join("")}
        </select>
      </div>
      <div class="form-grupo">
        <label for="fp-funil">Funil</label>
        <select id="fp-funil">
          ${FUNIS.map(f => `<option value="${f}" ${post?.funil===f?"selected":""}>${f}</option>`).join("")}
        </select>
      </div>
    </div>
    <div class="form-row">
      <div class="form-grupo">
        <label for="fp-mes">Mês</label>
        <select id="fp-mes">
          ${meses.map(m => `<option value="${m}" ${post?.mes===m?"selected":""}>${m}</option>`).join("")}
        </select>
      </div>
      <div class="form-grupo">
        <label for="fp-status">Status</label>
        <select id="fp-status">
          ${STATUS.map(s => `<option value="${s}" ${post?.status===s?"selected":""}>${s}</option>`).join("")}
        </select>
      </div>
    </div>
    <div class="form-row">
      <div class="form-grupo">
        <label for="fp-serie">Série</label>
        <select id="fp-serie">
          ${SERIES.map(s => `<option value="${s}" ${post?.serie===s?"selected":""}>${s}</option>`).join("")}
        </select>
      </div>
      <div class="form-grupo" id="fp-metricas-wrap" style="${post?.status==='Publicado' ? '' : 'display:none'}">
        <label>Likes / Comentários</label>
        <div style="display:flex;gap:8px">
          <input id="fp-likes"       type="number" min="0" placeholder="Likes"   value="${post ? (post.likes||0) : 0}" style="flex:1">
          <input id="fp-comentarios" type="number" min="0" placeholder="Coment." value="${post ? (post.comentarios||0) : 0}" style="flex:1">
        </div>
      </div>
    </div>
    <div class="form-grupo">
      <label for="fp-gancho">Gancho (hook)</label>
      <textarea id="fp-gancho" rows="2" placeholder="Primeira frase que prende a atenção">${post ? _esc(post.gancho) : ""}</textarea>
    </div>
    <div class="form-grupo">
      <label for="fp-orient">Orientações de produção</label>
      <textarea id="fp-orient" rows="3" placeholder="Instruções para criação do conteúdo">${post ? _esc(post.orientacoes) : ""}</textarea>
    </div>
  `;

  const fpStatus = document.getElementById("fp-status");
  if (fpStatus) {
    fpStatus.addEventListener("change", () => {
      const wrap = document.getElementById("fp-metricas-wrap");
      if (wrap) wrap.style.display = fpStatus.value === "Publicado" ? "" : "none";
    });
  }

  // Auto-save: só ativa ao editar post existente (não ao criar)
  if (STATE.editandoId) {
    document.querySelectorAll("#modal-post-body input, #modal-post-body select, #modal-post-body textarea")
      .forEach(el => {
        el.addEventListener("input",  _autoSavePost);
        el.addEventListener("change", _autoSavePost);
      });
    setSaveStatus(null);
  }
}

async function salvarPost() {
  const titulo = document.getElementById("fp-titulo")?.value.trim();
  if (!titulo) { alert("O título é obrigatório."); return; }

  const c = getClienteAtivo();
  const statusVal = document.getElementById("fp-status")?.value || STATUS[0];

  const dados = {
    clienteId:       c.id,
    titulo,
    linha:           document.getElementById("fp-linha")?.value    || LINHAS[0],
    subtema:         document.getElementById("fp-subtema")?.value.trim() || "",
    formato:         document.getElementById("fp-formato")?.value  || FORMATOS[0],
    funil:           document.getElementById("fp-funil")?.value    || FUNIS[0],
    mes:             document.getElementById("fp-mes")?.value      || "Banco",
    status:          statusVal,
    serie:           document.getElementById("fp-serie")?.value    || "—",
    likes:           parseInt(document.getElementById("fp-likes")?.value) || 0,
    comentarios:     parseInt(document.getElementById("fp-comentarios")?.value) || 0,
    data_publicacao: statusVal === "Publicado" ? new Date().toISOString().slice(0,10) : null,
    gancho:          document.getElementById("fp-gancho")?.value.trim()  || "",
    orientacoes:     document.getElementById("fp-orient")?.value.trim()  || ""
  };

  // Feedback visual enquanto salva
  const btnSalvar = document.querySelector("#modal-post .btn-primary");
  if (btnSalvar) { btnSalvar.disabled = true; btnSalvar.textContent = "Salvando..."; }

  if (STATE.editandoId) {
    const postAtualizado = await db.atualizarPost(STATE.editandoId, dados);
    if (!postAtualizado) {
      if (btnSalvar) { btnSalvar.disabled = false; btnSalvar.textContent = "Salvar"; }
      return; // erro já exibido por db.js
    }
    const idx = POSTS.findIndex(p => p.id === STATE.editandoId);
    if (idx !== -1) POSTS[idx] = postAtualizado;
  } else {
    const novoPost = await db.criarPost(dados);
    if (!novoPost) {
      if (btnSalvar) { btnSalvar.disabled = false; btnSalvar.textContent = "Salvar"; }
      return; // erro já exibido por db.js
    }
    POSTS.unshift(novoPost);
  }

  if (btnSalvar) { btnSalvar.disabled = false; btnSalvar.textContent = "Salvar"; }

  if (STATE.editandoId) setSaveStatus("salvo");
  closeModal("modal-post");
  renderMetrics();
  renderTabela();
  showToast(STATE.editandoId ? "✓ Post atualizado" : "✓ Post criado");
  STATE.editandoId = null;
}

/* -----------------------------------------------
   EXCLUIR POST
----------------------------------------------- */
async function excluirPost(id) {
  const post = POSTS.find(p => p.id === id);
  if (!post) return;
  if (!confirm(`Excluir o post "${post.titulo}"?`)) return;

  const ok = await db.excluirPost(id);
  if (!ok) return;

  const idx = POSTS.findIndex(p => p.id === id);
  if (idx !== -1) POSTS.splice(idx, 1);
  selectedIds.delete(id);

  renderMetrics();
  renderTabela();
  _updateCartFab();
  showToast("✓ Post excluído");
}

/* -----------------------------------------------
   MODAL DE NOVO CLIENTE
----------------------------------------------- */
function abrirModalNovoCliente() {
  openModal("modal-cliente");
}

async function salvarCliente() {
  const nome   = document.getElementById("nc-nome")?.value.trim();
  const handle = document.getElementById("nc-handle")?.value.trim();
  if (!nome || !handle) { alert("Nome e handle são obrigatórios."); return; }

  const dados = {
    nome,
    handle:         handle.startsWith("@") ? handle : "@" + handle,
    especialidade:  document.getElementById("nc-espec")?.value.trim() || "",
    avatar:         document.getElementById("nc-avatar")?.value.trim() || "👤",
    meta_posts_mes: parseInt(document.getElementById("nc-meta")?.value) || 4,
    seguidores:     0,
    ano:            2026,
    meses_ativos:   MESES_ANO.slice()
  };

  const btnSalvar = document.querySelector("#modal-cliente .btn-primary");
  if (btnSalvar) { btnSalvar.disabled = true; btnSalvar.textContent = "Salvando..."; }

  const novoCliente = await db.criarCliente(dados);

  if (btnSalvar) { btnSalvar.disabled = false; btnSalvar.textContent = "Cadastrar"; }

  if (!novoCliente) return; // erro já exibido por db.js

  CLIENTES.push(novoCliente);
  closeModal("modal-cliente");
  setClienteAtivo(novoCliente.id);
  POSTS.length = 0; // novo cliente não tem posts ainda

  renderSidebar();
  renderClienteHeader();
  renderMetrics();
  renderToolbar();
  renderTabela();
  _preencherCartMes();
  showToast("✓ Cliente cadastrado");
}

/* -----------------------------------------------
   CARRINHO — inicializar + preencher select de mês
----------------------------------------------- */
function inicializarCarrinho() {
  const overlay = document.getElementById("cartOverlay");
  if (overlay) overlay.addEventListener("click", closeCart);
}

function _preencherCartMes() {
  const sel = document.getElementById("cartMesSelect");
  if (!sel) return;
  const c = getClienteAtivo();
  const meses = c ? [...(c.meses_ativos || MESES_ANO), "Banco"] : [...MESES_ANO, "Banco"];
  sel.innerHTML = meses.map(m => `<option value="${m}">${m}</option>`).join("");
}

/* -----------------------------------------------
   LOGOUT
----------------------------------------------- */
function _renderBotaoLogout() {
  // Insere botão de logout na sidebar footer se existir
  const footer = document.querySelector(".sidebar-footer");
  if (!footer) return;
  const btnLogout = document.createElement("button");
  btnLogout.className = "btn-novo-cliente";
  btnLogout.style.marginTop = "8px";
  btnLogout.style.color = "#888";
  btnLogout.textContent = "Sair";
  btnLogout.onclick = () => db.logout();
  footer.appendChild(btnLogout);
}

/* -----------------------------------------------
   ESTADO VAZIO GLOBAL (sem clientes)
----------------------------------------------- */
function _mostrarEstadoVazioGlobal() {
  const main = document.getElementById("main-content") || document.querySelector(".main");
  if (!main) return;
  main.innerHTML = `
    <div class="empty-state" style="padding:80px 24px">
      <div class="empty-state-icon">👤</div>
      <p>Nenhum cliente cadastrado ainda.<br>Clique em <strong>+ Novo Cliente</strong> na barra lateral.</p>
    </div>
  `;
}

/* -----------------------------------------------
   AUTO-SAVE DO POST (debounced, só ao editar)
----------------------------------------------- */
const _autoSavePost = _debounce(async function() {
  if (!STATE.editandoId) return;
  const titulo = document.getElementById("fp-titulo")?.value.trim();
  if (!titulo) return; // não salva sem título

  const statusVal = document.getElementById("fp-status")?.value || STATUS[0];
  const dados = {
    titulo,
    linha:       document.getElementById("fp-linha")?.value       || LINHAS[0],
    subtema:     document.getElementById("fp-subtema")?.value.trim() || "",
    formato:     document.getElementById("fp-formato")?.value     || FORMATOS[0],
    funil:       document.getElementById("fp-funil")?.value       || FUNIS[0],
    mes:         document.getElementById("fp-mes")?.value         || "Banco",
    status:      statusVal,
    serie:       document.getElementById("fp-serie")?.value       || "—",
    likes:       parseInt(document.getElementById("fp-likes")?.value)       || 0,
    comentarios: parseInt(document.getElementById("fp-comentarios")?.value) || 0,
    gancho:      document.getElementById("fp-gancho")?.value.trim()  || "",
    orientacoes: document.getElementById("fp-orient")?.value.trim()  || ""
  };

  setSaveStatus("salvando");
  const resultado = await db.atualizarPost(STATE.editandoId, dados);
  if (resultado) {
    const idx = POSTS.findIndex(p => p.id === STATE.editandoId);
    if (idx !== -1) POSTS[idx] = resultado;
    setSaveStatus("salvo");
  } else {
    setSaveStatus("erro");
  }
}, 1000);

/* -----------------------------------------------
   UTILITÁRIO: escape HTML
----------------------------------------------- */
function _esc(str) {
  if (!str) return "";
  return str
    .replace(/&/g, "&amp;")
    .replace(/"/g, "&quot;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;");
}
