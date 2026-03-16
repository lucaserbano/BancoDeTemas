/* =============================================
   MES.JS — Lógica do mes.html
   Depende de: supabase.js, db.js, data.js, ui.js
   ============================================= */

/* -----------------------------------------------
   ESTADO DA PÁGINA
----------------------------------------------- */
const MES_STATE = {
  mesIndex:      0,
  bancoAberto:   false,
  bancoPendentes: new Set()
};

// Objetivos carregados do banco (complementa/substitui OBJETIVOS_MES hardcoded)
const OBJETIVOS_BANCO = [];

/* -----------------------------------------------
   INICIALIZAÇÃO
----------------------------------------------- */
document.addEventListener("DOMContentLoaded", async () => {

  // 1. Verifica login
  const usuario = await db.exigirLogin();
  if (!usuario) return;

  // 2. Carrega clientes
  const clientes = await db.fetchClientes();
  CLIENTES.length = 0;
  clientes.forEach(c => CLIENTES.push(c));

  if (CLIENTES.length === 0) return;

  // 3. Garante que o cliente ativo seja válido
  const idSalvo = localStorage.getItem("hub_clienteAtivo");
  if (!CLIENTES.find(c => c.id === idSalvo)) {
    setClienteAtivo(CLIENTES[0].id);
  }

  // 4. Restaura índice do mês
  const c = getClienteAtivo();
  const savedIdx = parseInt(localStorage.getItem("hub_mesIndex_" + c.id) || "0");
  MES_STATE.mesIndex = Math.min(savedIdx, (c.meses_ativos || []).length - 1);

  // 5. Carrega posts e objetivos do cliente ativo
  const [posts, objetivos] = await Promise.all([
    db.fetchPosts(c.id),
    db.fetchObjetivos(c.id)
  ]);

  POSTS.length = 0;
  posts.forEach(p => POSTS.push(p));

  OBJETIVOS_BANCO.length = 0;
  objetivos.forEach(o => OBJETIVOS_BANCO.push(o));

  // 6. Renderiza
  renderHeader();
  renderConteudo();
  inicializarModaisObjetivo();
});

/* -----------------------------------------------
   HEADER
----------------------------------------------- */
function renderHeader() {
  const c   = getClienteAtivo();
  const mes = _mesAtual(c);

  const nomeEl   = document.getElementById("mes-header-nome");
  const handleEl = document.getElementById("mes-header-handle");
  const labelEl  = document.getElementById("mes-nav-label");

  if (nomeEl)   nomeEl.textContent   = c?.nome   || "—";
  if (handleEl) handleEl.textContent = c?.handle || "—";
  if (labelEl)  labelEl.textContent  = `${mes} ${c?.ano || 2026}`;
}

/* -----------------------------------------------
   NAVEGAÇÃO DE MÊS
----------------------------------------------- */
function _mesAtual(c) {
  return (c?.meses_ativos || [])[MES_STATE.mesIndex] || "Abril";
}

function navegarMes(direcao) {
  const c   = getClienteAtivo();
  const max = (c?.meses_ativos || []).length - 1;
  MES_STATE.mesIndex = Math.max(0, Math.min(max, MES_STATE.mesIndex + direcao));
  localStorage.setItem("hub_mesIndex_" + c.id, MES_STATE.mesIndex);
  MES_STATE.bancoPendentes.clear();
  renderHeader();
  renderConteudo();
}

/* -----------------------------------------------
   CONTEÚDO PRINCIPAL
----------------------------------------------- */
function renderConteudo() {
  renderObjetivos();
  renderPostsDoMes();
  renderBanco();
}

/* -----------------------------------------------
   BLOCO DE OBJETIVOS
----------------------------------------------- */
function renderObjetivos() {
  const el = document.getElementById("obj-card");
  if (!el) return;
  const c   = getClienteAtivo();
  const mes = _mesAtual(c);
  const ano = c?.ano || 2026;

  // 1. Tenta buscar no banco primeiro
  const objBanco = OBJETIVOS_BANCO.find(o => o.mes === mes && o.ano === ano);

  // 2. Se não tiver no banco, tenta o hardcoded (fallback)
  const objHard  = (OBJETIVOS_MES[c?.id] || {})[mes];

  // Unifica: banco tem prioridade
  const obj = objBanco ? _normalizeObjetivoBanco(objBanco) : objHard;

  if (!obj) {
    el.innerHTML = `
      <h2>Objetivos de ${mes}</h2>
      <div class="obj-texto" style="color:#AAAAAA;font-weight:400">
        Nenhum objetivo definido para ${mes}.
      </div>
      <div style="margin-top:16px">
        <button class="btn btn-secondary" style="font-size:12px" onclick="abrirModalObjetivo()">
          + Definir objetivo
        </button>
      </div>
    `;
    return;
  }

  const dataPills = (obj.datas_importantes || []).map(d => {
    const destaque = d.toLowerCase().includes("coração") || d.toLowerCase().includes("doação");
    return `<span class="obj-data-pill ${destaque ? "destaque" : ""}">${d}</span>`;
  }).join("");

  const { topo = 50, meio = 30, fundo = 20 } = obj.funil_meta || {};
  const total = topo + meio + fundo;
  const pTopo  = Math.round((topo  / total) * 100);
  const pMeio  = Math.round((meio  / total) * 100);
  const pFundo = 100 - pTopo - pMeio;

  el.innerHTML = `
    <div style="display:flex;justify-content:space-between;align-items:flex-start;gap:12px">
      <h2>Objetivos de ${mes}</h2>
      <button class="btn btn-secondary" style="font-size:11px;padding:4px 10px;flex-shrink:0"
              onclick="abrirModalObjetivo()">✏️ Editar</button>
    </div>
    <div class="obj-texto">${obj.objetivo}</div>
    <div class="obj-meta-row">
      ${obj.orcamento_anuncios ? `<span class="obj-chip">💰 ${obj.orcamento_anuncios}</span>` : ""}
      ${obj.tipo_anuncio       ? `<span class="obj-chip">📣 ${obj.tipo_anuncio}</span>`       : ""}
      ${dataPills}
    </div>
    <div class="funil-label">Distribuição de Funil</div>
    <div class="funil-bar">
      <div class="funil-seg funil-topo"  style="width:${pTopo}%"></div>
      <div class="funil-seg funil-meio"  style="width:${pMeio}%"></div>
      <div class="funil-seg funil-fundo" style="width:${pFundo}%"></div>
    </div>
    <div class="funil-legenda">
      <span><span class="funil-dot" style="background:#AAAAAA"></span>TOPO ${pTopo}%</span>
      <span><span class="funil-dot" style="background:#666666"></span>MEIO ${pMeio}%</span>
      <span><span class="funil-dot" style="background:#111111"></span>FUNDO ${pFundo}%</span>
    </div>
  `;
}

/**
 * Converte um registro do banco de objetivos para o mesmo shape
 * que o objeto hardcoded OBJETIVOS_MES usa internamente.
 */
function _normalizeObjetivoBanco(row) {
  return {
    objetivo:           row.objetivo,
    orcamento_anuncios: row.orcamento_anuncios || "",
    tipo_anuncio:       row.tipo_anuncio || "",
    datas_importantes:  row.datas_importantes || [],
    funil_meta: {
      topo:  row.funil_topo  ?? 50,
      meio:  row.funil_meio  ?? 30,
      fundo: row.funil_fundo ?? 20
    }
  };
}

/* -----------------------------------------------
   MODAL DE OBJETIVO MENSAL
----------------------------------------------- */
function inicializarModaisObjetivo() {
  const overlay = document.getElementById("modal-objetivo");
  if (overlay) {
    overlay.addEventListener("click", (e) => {
      if (e.target === overlay) closeModal("modal-objetivo");
    });
  }
}

function abrirModalObjetivo() {
  const c   = getClienteAtivo();
  const mes = _mesAtual(c);
  const ano = c?.ano || 2026;

  // Preenche o modal com dados existentes (banco ou vazio)
  const obj = OBJETIVOS_BANCO.find(o => o.mes === mes && o.ano === ano);

  document.getElementById("obj-mes-titulo").textContent = `Objetivo de ${mes}`;
  document.getElementById("obj-objetivo").value         = obj?.objetivo           || "";
  document.getElementById("obj-orcamento").value        = obj?.orcamento_anuncios || "";
  document.getElementById("obj-tipo").value             = obj?.tipo_anuncio       || "";
  document.getElementById("obj-datas").value            = (obj?.datas_importantes || []).join(", ");
  document.getElementById("obj-topo").value             = obj?.funil_topo  ?? 50;
  document.getElementById("obj-meio").value             = obj?.funil_meio  ?? 30;
  document.getElementById("obj-fundo").value            = obj?.funil_fundo ?? 20;

  openModal("modal-objetivo");

  // Auto-save em todos os campos do formulário de objetivo
  document.querySelectorAll("#modal-objetivo input, #modal-objetivo textarea")
    .forEach(el => {
      el.oninput  = _autoSaveObjetivo;
      el.onchange = _autoSaveObjetivo;
    });
  setSaveStatus(null);
}

async function salvarObjetivo() {
  const c   = getClienteAtivo();
  const mes = _mesAtual(c);
  const ano = c?.ano || 2026;

  const objetivo = document.getElementById("obj-objetivo").value.trim();
  if (!objetivo) { alert("O campo Objetivo é obrigatório."); return; }

  const datasRaw = document.getElementById("obj-datas").value;
  const datas = datasRaw
    .split(",")
    .map(d => d.trim())
    .filter(d => d.length > 0);

  const dados = {
    clienteId:          c.id,
    mes,
    ano,
    objetivo,
    orcamento_anuncios: document.getElementById("obj-orcamento").value.trim() || null,
    tipo_anuncio:       document.getElementById("obj-tipo").value.trim()      || null,
    datas_importantes:  datas,
    funil_topo:         parseInt(document.getElementById("obj-topo").value)  || 50,
    funil_meio:         parseInt(document.getElementById("obj-meio").value)  || 30,
    funil_fundo:        parseInt(document.getElementById("obj-fundo").value) || 20
  };

  const btnSalvar = document.querySelector("#modal-objetivo .btn-primary");
  if (btnSalvar) { btnSalvar.disabled = true; btnSalvar.textContent = "Salvando..."; }

  const resultado = await db.salvarObjetivo(dados);

  if (btnSalvar) { btnSalvar.disabled = false; btnSalvar.textContent = "Salvar"; }

  if (!resultado) return; // erro já exibido por db.js

  // Atualiza array local
  const idx = OBJETIVOS_BANCO.findIndex(o => o.mes === mes && o.ano === ano);
  if (idx !== -1) OBJETIVOS_BANCO[idx] = resultado;
  else OBJETIVOS_BANCO.push(resultado);

  setSaveStatus("salvo");
  closeModal("modal-objetivo");
  renderObjetivos();
  showToast("✓ Objetivo salvo");
}

/* -----------------------------------------------
   AUTO-SAVE DO OBJETIVO (debounced)
----------------------------------------------- */
const _autoSaveObjetivo = _debounce(async function() {
  const objetivo = document.getElementById("obj-objetivo")?.value.trim();
  if (!objetivo) return; // campo obrigatório vazio — não salva

  const c   = getClienteAtivo();
  const mes = _mesAtual(c);
  const ano = c?.ano || 2026;
  const datasRaw = document.getElementById("obj-datas")?.value || "";
  const datas = datasRaw.split(",").map(d => d.trim()).filter(d => d.length > 0);

  const dados = {
    clienteId:          c.id,
    mes,
    ano,
    objetivo,
    orcamento_anuncios: document.getElementById("obj-orcamento")?.value.trim() || null,
    tipo_anuncio:       document.getElementById("obj-tipo")?.value.trim()      || null,
    datas_importantes:  datas,
    funil_topo:  parseInt(document.getElementById("obj-topo")?.value)  || 50,
    funil_meio:  parseInt(document.getElementById("obj-meio")?.value)  || 30,
    funil_fundo: parseInt(document.getElementById("obj-fundo")?.value) || 20
  };

  setSaveStatus("salvando");
  const resultado = await db.salvarObjetivo(dados);
  if (resultado) {
    const idx = OBJETIVOS_BANCO.findIndex(o => o.mes === mes && o.ano === ano);
    if (idx !== -1) OBJETIVOS_BANCO[idx] = resultado;
    else OBJETIVOS_BANCO.push(resultado);
    renderObjetivos();
    setSaveStatus("salvo");
  } else {
    setSaveStatus("erro");
  }
}, 1000);

/* -----------------------------------------------
   GRID DE POSTS DO MÊS
----------------------------------------------- */
const STATUS_ORDEM = ["Ideia","Roteiro","Gravado","Editado","Publicado"];

function renderPostsDoMes() {
  const el    = document.getElementById("mes-posts-grid");
  const cntEl = document.getElementById("mes-posts-count");
  if (!el) return;

  const c   = getClienteAtivo();
  const mes = _mesAtual(c);
  const posts = POSTS
    .filter(p => p.mes === mes)
    .sort((a, b) => STATUS_ORDEM.indexOf(a.status) - STATUS_ORDEM.indexOf(b.status));

  if (cntEl) cntEl.textContent = posts.length;

  if (posts.length === 0) {
    el.innerHTML = `
      <div class="empty-state" style="grid-column:1/-1">
        <div class="empty-state-icon">📭</div>
        <p>Nenhum post atribuído a ${mes} ainda.<br>Use o banco abaixo para adicionar.</p>
      </div>`;
    return;
  }

  el.innerHTML = posts.map(p => _cardPost(p)).join("");
}

function _cardPost(p) {
  const pub = p.status === "Publicado";
  return `
    <div class="post-card ${pub ? "publicado" : ""}" data-id="${p.id}">
      <div class="post-card-status">${badgeHTML("status", p.status)}</div>
      <div class="post-card-titulo">${p.titulo}</div>
      <div class="post-card-badges">
        ${badgeHTML("linha", linhaAbrev(p.linha))}
        ${badgeHTML("formato", p.formato)}
        ${p.funil ? badgeHTML("funil", p.funil) : ""}
      </div>
      ${p.gancho ? `<div class="post-card-gancho">${p.gancho}</div>` : ""}
      <div class="post-card-footer">
        <div>
          ${pub ? `<span style="font-size:11px;color:#888">❤️ ${formatarNumero(p.likes)}  💬 ${formatarNumero(p.comentarios)}</span>` : ""}
        </div>
        <button class="btn-remover-mes" onclick="removerDoMes('${p.id}')">× Remover</button>
      </div>
    </div>
  `;
}

async function removerDoMes(id) {
  const post = POSTS.find(p => p.id === id);
  if (!post) return;
  if (!confirm(`Remover "${post.titulo}" do mês? O post volta ao banco.`)) return;

  const ok = await db.atualizarPost(id, { mes: "Banco" });
  if (!ok) return;

  post.mes = "Banco";
  renderPostsDoMes();
  renderBanco();
  showToast("✓ Post devolvido ao banco");
}

/* -----------------------------------------------
   BANCO DE TEMAS DISPONÍVEIS
----------------------------------------------- */
function renderBanco() {
  const lista = document.getElementById("banco-lista");
  if (!lista) return;

  const c   = getClienteAtivo();
  const mes = _mesAtual(c);
  const disponiveis = POSTS.filter(p => p.mes !== mes);

  if (disponiveis.length === 0) {
    lista.innerHTML = `<div class="cart-vazio">Todos os posts estão atribuídos a meses.</div>`;
    return;
  }

  lista.innerHTML = disponiveis.map(p => `
    <div class="banco-item">
      <input type="checkbox" data-id="${p.id}"
             ${MES_STATE.bancoPendentes.has(p.id) ? "checked" : ""}
             onchange="toggleBancoItem('${p.id}', this.checked)">
      <span class="banco-item-titulo" title="${p.titulo}">${p.titulo}</span>
      <div class="banco-item-badges">
        ${badgeHTML("formato", p.formato)}
        ${badgeHTML("status", p.status)}
      </div>
      <span style="font-size:11px;color:#AAAAAA;flex-shrink:0">${p.mes}</span>
    </div>
  `).join("") + `
    <div class="banco-atribuir-row ${MES_STATE.bancoPendentes.size > 0 ? "visivel" : ""}" id="banco-atribuir">
      <span style="font-size:12px;color:#666;flex-shrink:0">
        ${MES_STATE.bancoPendentes.size} selecionado(s)
      </span>
      <button class="btn btn-primary" style="padding:6px 14px;font-size:12px"
              onclick="adicionarBancoAoMes()">
        + Adicionar a ${mes}
      </button>
      <button class="btn btn-secondary" style="padding:6px 10px;font-size:12px"
              onclick="limparBancoPendentes()">Cancelar</button>
    </div>
  `;
}

function toggleBancoItem(id, checked) {
  if (checked) MES_STATE.bancoPendentes.add(id);
  else MES_STATE.bancoPendentes.delete(id);

  const barraEl = document.getElementById("banco-atribuir");
  if (barraEl) {
    barraEl.className = "banco-atribuir-row " + (MES_STATE.bancoPendentes.size > 0 ? "visivel" : "");
    const span = barraEl.querySelector("span");
    if (span) span.textContent = `${MES_STATE.bancoPendentes.size} selecionado(s)`;
  }
}

async function adicionarBancoAoMes() {
  if (MES_STATE.bancoPendentes.size === 0) return;
  const c   = getClienteAtivo();
  const mes = _mesAtual(c);
  const ids = Array.from(MES_STATE.bancoPendentes);

  const ok = await db.atualizarMesPosts(ids, mes);
  if (!ok) return;

  // Atualiza array local
  ids.forEach(id => {
    const post = POSTS.find(p => p.id === id);
    if (post) post.mes = mes;
  });

  const qtd = ids.length;
  MES_STATE.bancoPendentes.clear();
  renderPostsDoMes();
  renderBanco();
  showToast(`✓ ${qtd} post(s) adicionados a ${mes}`);
}

function limparBancoPendentes() {
  MES_STATE.bancoPendentes.clear();
  renderBanco();
}

function toggleBanco() {
  MES_STATE.bancoAberto = !MES_STATE.bancoAberto;
  const lista  = document.getElementById("banco-lista");
  const toggle = document.getElementById("banco-toggle");
  if (lista)  lista.classList.toggle("aberta", MES_STATE.bancoAberto);
  if (toggle) toggle.classList.toggle("aberto", MES_STATE.bancoAberto);
}
