/* =============================================
   CALENDARIO.JS — Lógica do calendario.html
   Depende de: supabase.js, db.js, data.js, ui.js
   ============================================= */

const CAL_STATE = {
  mesIndex: 0,
  diaSelecionado: null  // { ano, mes (1-12), dia }
};

/* -----------------------------------------------
   INICIALIZAÇÃO
----------------------------------------------- */
document.addEventListener("DOMContentLoaded", async () => {

  const usuario = await db.exigirLogin();
  if (!usuario) return;

  const clientes = await db.fetchClientes();
  CLIENTES.length = 0;
  clientes.forEach(c => CLIENTES.push(c));
  if (CLIENTES.length === 0) return;

  const idSalvo = localStorage.getItem("hub_clienteAtivo");
  if (!CLIENTES.find(c => c.id === idSalvo)) setClienteAtivo(CLIENTES[0].id);

  const c = getClienteAtivo();
  const savedIdx = parseInt(localStorage.getItem("hub_mesIndex_" + c.id) || "0");
  CAL_STATE.mesIndex = Math.min(savedIdx, (c.meses_ativos || []).length - 1);

  const posts = await db.fetchPosts(c.id);
  POSTS.length = 0;
  posts.forEach(p => POSTS.push(p));

  _renderCalHeader();
  _renderCalendar();
  _inicializarModal();
});

/* -----------------------------------------------
   HEADER
----------------------------------------------- */
function _renderCalHeader() {
  const c   = getClienteAtivo();
  const mes = _mesAtualCal(c);
  const nomeEl   = document.getElementById("cal-header-nome");
  const handleEl = document.getElementById("cal-header-handle");
  const labelEl  = document.getElementById("cal-nav-label");
  if (nomeEl)   nomeEl.textContent   = c?.nome   || "—";
  if (handleEl) handleEl.textContent = c?.handle || "—";
  if (labelEl)  labelEl.textContent  = `${mes} ${c?.ano || 2026}`;
}

function _mesAtualCal(c) {
  return (c?.meses_ativos || [])[CAL_STATE.mesIndex] || "Abril";
}

function navegarMesCal(dir) {
  const c   = getClienteAtivo();
  const max = (c?.meses_ativos || []).length - 1;
  CAL_STATE.mesIndex = Math.max(0, Math.min(max, CAL_STATE.mesIndex + dir));
  localStorage.setItem("hub_mesIndex_" + c.id, CAL_STATE.mesIndex);
  _renderCalHeader();
  _renderCalendar();
}

/* -----------------------------------------------
   GRADE MENSAL
----------------------------------------------- */
function _renderCalendar() {
  const grid = document.getElementById("cal-grid");
  if (!grid) return;

  const c        = getClienteAtivo();
  const mesNome  = _mesAtualCal(c);
  const ano      = c?.ano || 2026;
  const mesIdx   = MESES_ANO.indexOf(mesNome); // 0-based
  if (mesIdx === -1) { grid.innerHTML = ""; return; }

  const mesNum   = mesIdx + 1; // 1-based
  const diasNoMes  = new Date(ano, mesNum, 0).getDate();
  const primeiroDia = new Date(ano, mesIdx, 1).getDay(); // 0=Dom

  // Converter para Seg=0 … Dom=6
  const offset = (primeiroDia + 6) % 7;

  // Posts deste mês com data de publicação
  const postsMes = POSTS.filter(p => p.mes === mesNome);

  // Indexar por dia: { "5": [post,...], "12": [...] }
  const porDia = {};
  postsMes.forEach(p => {
    if (p.data_publicacao) {
      const d = new Date(p.data_publicacao + "T12:00:00");
      if (d.getMonth() + 1 === mesNum && d.getFullYear() === ano) {
        const dia = d.getDate();
        if (!porDia[dia]) porDia[dia] = [];
        porDia[dia].push(p);
      }
    }
  });

  const hoje = new Date();
  const ehHojeAno = hoje.getFullYear() === ano;
  const ehHojeMes = hoje.getMonth() + 1 === mesNum;

  // Nomes dos dias da semana
  const diasNome = ["Seg","Ter","Qua","Qui","Sex","Sáb","Dom"];

  let html = diasNome.map(d => `<div class="cal-dia-nome">${d}</div>`).join("");

  // Células vazias iniciais
  for (let i = 0; i < offset; i++) {
    html += `<div class="cal-dia vazio"></div>`;
  }

  for (let dia = 1; dia <= diasNoMes; dia++) {
    const ehHoje = ehHojeAno && ehHojeMes && hoje.getDate() === dia;
    const posts  = porDia[dia] || [];

    const chipsHtml = posts.map(p => {
      const cls = _linhaClassCal(p.linha);
      const titulo = p.titulo.length > 20 ? p.titulo.slice(0, 19) + "…" : p.titulo;
      return `<span class="cal-post-chip ${cls}"
                    title="${_escCal(p.titulo)}"
                    onclick="event.stopPropagation();abrirModalRemover('${p.id}',${dia},'${_escCal(p.titulo)}')">${titulo}</span>`;
    }).join("");

    const dataStr = `${ano}-${String(mesNum).padStart(2,"0")}-${String(dia).padStart(2,"0")}`;

    html += `
      <div class="cal-dia${ehHoje ? " hoje" : ""}" onclick="abrirModalAtribuir('${dataStr}',${dia})">
        <div class="cal-dia-num">${dia}</div>
        ${chipsHtml}
        <button class="cal-dia-add" title="Adicionar post" onclick="event.stopPropagation();abrirModalAtribuir('${dataStr}',${dia})">+</button>
      </div>`;
  }

  grid.innerHTML = html;

  // Título do mês
  const tituloEl = document.getElementById("cal-titulo");
  if (tituloEl) tituloEl.textContent = `${mesNome} ${ano}`;
}

function _linhaClassCal(linha) {
  if (!linha) return "mev";
  const l = linha.toLowerCase();
  if (l.includes("estilo") || l.includes("mev"))   return "mev";
  if (l.includes("convers"))                        return "conv";
  if (l.includes("causa") || l.includes("consci")) return "causa";
  if (l.includes("human"))                          return "hum";
  return "mev";
}

function _escCal(s) {
  if (!s) return "";
  return s.replace(/&/g,"&amp;").replace(/"/g,"&quot;").replace(/</g,"&lt;").replace(/>/g,"&gt;");
}

/* -----------------------------------------------
   MODAL — ATRIBUIR POST AO DIA
----------------------------------------------- */
let _modalDataStr = null;

function abrirModalAtribuir(dataStr, dia) {
  _modalDataStr = dataStr;

  const c       = getClienteAtivo();
  const mesNome = _mesAtualCal(c);

  // Posts do mês ainda sem data de publicação
  const disponiveis = POSTS.filter(p =>
    p.mes === mesNome && !p.data_publicacao
  );

  const listEl = document.getElementById("cal-modal-lista");
  if (!listEl) return;

  const tituloEl = document.getElementById("cal-modal-titulo");
  if (tituloEl) {
    const [ano, mes, d] = dataStr.split("-");
    tituloEl.textContent = `Atribuir post — ${parseInt(d)}/${parseInt(mes)}/${ano}`;
  }

  if (disponiveis.length === 0) {
    listEl.innerHTML = `<div style="padding:16px;color:#888;font-size:13px">
      Todos os posts de ${mesNome} já têm data de publicação.<br>
      Para reposicionar, clique no post no calendário para removê-lo primeiro.
    </div>`;
  } else {
    listEl.innerHTML = disponiveis.map(p => `
      <div class="cal-modal-item" onclick="atribuirDia('${p.id}')">
        <div class="cal-modal-item-titulo">${_escCal(p.titulo)}</div>
        <div class="cal-modal-item-meta">
          <span>${p.linha}</span>
          <span>·</span>
          <span>${p.formato}</span>
          <span>·</span>
          <span>${p.status}</span>
        </div>
      </div>
    `).join("");
  }

  openModal("modal-cal-atribuir");
}

async function atribuirDia(postId) {
  if (!_modalDataStr) return;
  const ok = await db.atualizarPost(postId, { data_publicacao: _modalDataStr });
  if (!ok) return;

  const post = POSTS.find(p => p.id === postId);
  if (post) post.data_publicacao = _modalDataStr;

  closeModal("modal-cal-atribuir");
  _renderCalendar();
  showToast("✓ Post agendado para " + _modalDataStr.split("-").reverse().join("/"));
}

/* -----------------------------------------------
   MODAL — REMOVER DATA DO POST
----------------------------------------------- */
let _modalRemoverId = null;

function abrirModalRemover(postId, dia, titulo) {
  _modalRemoverId = postId;
  const confirmaEl = document.getElementById("cal-remover-texto");
  if (confirmaEl) confirmaEl.textContent = `Remover a data de publicação de "${titulo}"?`;
  openModal("modal-cal-remover");
}

async function confirmarRemoverDia() {
  if (!_modalRemoverId) return;
  const ok = await db.atualizarPost(_modalRemoverId, { data_publicacao: null });
  if (!ok) return;

  const post = POSTS.find(p => p.id === _modalRemoverId);
  if (post) post.data_publicacao = null;

  closeModal("modal-cal-remover");
  _renderCalendar();
  showToast("✓ Data removida do post");
}

/* -----------------------------------------------
   INICIALIZAR MODAIS
----------------------------------------------- */
function _inicializarModal() {
  document.querySelectorAll(".modal-overlay").forEach(overlay => {
    overlay.addEventListener("click", e => {
      if (e.target === overlay) closeModal(overlay.id);
    });
  });
}
