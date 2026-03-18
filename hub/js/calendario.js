/* =============================================
   CALENDARIO.JS — Lógica do calendario.html
   Depende de: supabase.js, db.js, data.js, ui.js
   ============================================= */

const CAL_STATE = {
  mesIndex: 0,
  diaSelecionado: null,  // { ano, mes (1-12), dia }
  editandoPostId: null
};

/* -----------------------------------------------
   INICIALIZAÇÃO
----------------------------------------------- */
document.addEventListener("DOMContentLoaded", async () => {

  const usuario = await db.exigirLogin();
  if (!usuario) return;

  // Verifica se é admin — redireciona cliente para portal.html
  const isAdmin = await db.exigirAdmin();
  if (!isAdmin) return;

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
      const fmt   = _formatoAbrev(p.formato);
      const titulo = p.titulo.length > 15 ? p.titulo.slice(0, 14) + "…" : p.titulo;
      return `<span class="cal-post-chip ${cls}"
                    title="${_escCal(p.titulo)} · ${_escCal(p.formato)}"
                    onclick="event.stopPropagation();abrirModalRemover('${p.id}',${dia},'${_escCal(p.titulo)}')"
              >${fmt}-${titulo}</span>`;
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

  _renderListaMes();
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

function _formatoAbrev(formato) {
  if (!formato) return "?";
  if (formato.startsWith("Story")) return "S";
  if (formato === "Reels")        return "R";
  if (formato === "Carrossel")    return "C";
  if (formato === "Post único")   return "P";
  return formato[0];
}

/* -----------------------------------------------
   LISTA DE POSTS DO MÊS (abaixo do calendário)
----------------------------------------------- */
function _renderListaMes() {
  const el = document.getElementById("cal-lista-mes");
  if (!el) return;

  const c       = getClienteAtivo();
  const mesNome = _mesAtualCal(c);
  const ano     = c?.ano || 2026;
  const mesIdx  = MESES_ANO.indexOf(mesNome);
  const mesNum  = mesIdx + 1;

  const postsMes = POSTS.filter(p => p.mes === mesNome);

  if (postsMes.length === 0) {
    el.innerHTML = `<div class="cal-lista-vazio">Nenhum post atribuído a ${mesNome}.</div>`;
    return;
  }

  // Posts com data ordenados cronologicamente, depois os sem data
  const comData  = postsMes.filter(p => p.data_publicacao)
                            .sort((a, b) => a.data_publicacao.localeCompare(b.data_publicacao));
  const semData  = postsMes.filter(p => !p.data_publicacao);
  const ordenados = [...comData, ...semData];

  const diasSemana = ["Dom","Seg","Ter","Qua","Qui","Sex","Sáb"];

  const itensHtml = ordenados.map(p => {
    const cls = _linhaClassCal(p.linha);
    const fmt = _formatoAbrev(p.formato);

    let dataHtml;
    if (p.data_publicacao) {
      const d = new Date(p.data_publicacao + "T12:00:00");
      dataHtml = `<div class="cal-lista-data">${diasSemana[d.getDay()]} ${d.getDate()}</div>`;
    } else {
      dataHtml = `<div class="cal-lista-data sem-data">A agendar</div>`;
    }

    return `
      <div class="cal-lista-item ${cls}" onclick="abrirModalEditarPostCal('${p.id}')">
        ${dataHtml}
        <span class="cal-lista-fmt">${fmt}</span>
        <div class="cal-lista-titulo">${_escCal(p.titulo)}</div>
        <div class="cal-lista-linha">${linhaAbrev(p.linha)}</div>
        ${badgeHTML("status", p.status)}
      </div>`;
  }).join("");

  el.innerHTML = `
    <div class="cal-lista-header">
      <span>Posts de ${mesNome}</span>
      <span class="cal-lista-count">${postsMes.length}</span>
    </div>
    <div class="cal-lista-items">${itensHtml}</div>`;
}

/* -----------------------------------------------
   MODAL — ATRIBUIR POST AO DIA
----------------------------------------------- */
let _modalDataStr = null;

function abrirModalAtribuir(dataStr, dia) {
  _modalDataStr = dataStr;

  const c       = getClienteAtivo();
  const mesNome = _mesAtualCal(c);

  // Todos os posts do mês (com ou sem data)
  const disponiveis = POSTS.filter(p => p.mes === mesNome);

  const listEl = document.getElementById("cal-modal-lista");
  if (!listEl) return;

  const tituloEl = document.getElementById("cal-modal-titulo");
  if (tituloEl) {
    const [ano, mes, d] = dataStr.split("-");
    tituloEl.textContent = `Atribuir post — ${parseInt(d)}/${parseInt(mes)}/${ano}`;
  }

  if (disponiveis.length === 0) {
    listEl.innerHTML = `<div style="padding:16px;color:#888;font-size:13px">
      Nenhum post atribuído a ${mesNome} ainda.
    </div>`;
  } else {
    listEl.innerHTML = disponiveis.map(p => {
      const jaTemData = !!p.data_publicacao;
      const dataLabel = jaTemData
        ? `<span style="color:#F59E0B;font-weight:600">· já agendado em ${p.data_publicacao.split("-").reverse().join("/")} — será reagendado</span>`
        : "";
      return `
        <div class="cal-modal-item" onclick="atribuirDia('${p.id}')">
          <div class="cal-modal-item-titulo">${_escCal(p.titulo)}</div>
          <div class="cal-modal-item-meta">
            <span>${p.linha}</span>
            <span>·</span>
            <span>${p.formato}</span>
            <span>·</span>
            <span>${p.status}</span>
            ${dataLabel}
          </div>
        </div>
      `;
    }).join("");
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
   MODAL — EDITAR POST (a partir da lista do mês)
----------------------------------------------- */
function abrirModalEditarPostCal(id) {
  const post = POSTS.find(p => p.id === id);
  if (!post) return;
  CAL_STATE.editandoPostId = id;
  const c = getClienteAtivo();
  _preencherModalPostCal(post, c);
  openModal("modal-cal-post");
}

function _preencherModalPostCal(post, cliente) {
  const meses  = [...(cliente?.meses_ativos || MESES_ANO), "Banco"];
  const linhas = _linhasDoCliente();

  const body = document.getElementById("modal-cal-post-body");
  if (!body) return;

  body.innerHTML = `
    <div class="form-grupo">
      <label for="cp-titulo">Título *</label>
      <input id="cp-titulo" type="text" placeholder="Título do post" value="${_esc(post.titulo)}">
    </div>
    <div class="form-row">
      <div class="form-grupo">
        <label for="cp-linha">Linha editorial</label>
        <input id="cp-linha" list="cp-linha-list" type="text"
               placeholder="Selecione ou escreva uma nova linha"
               value="${_esc(post.linha)}">
        <datalist id="cp-linha-list">
          ${linhas.map(l => `<option value="${_esc(l)}">`).join("")}
        </datalist>
      </div>
      <div class="form-grupo">
        <label for="cp-subtema">Subtema</label>
        <input id="cp-subtema" type="text" placeholder="Ex: Exercício Físico" value="${_esc(post.subtema || '')}">
      </div>
    </div>
    <div class="form-row">
      <div class="form-grupo">
        <label for="cp-formato">Formato</label>
        <select id="cp-formato">
          ${FORMATOS.map(f => `<option value="${f}" ${post.formato===f?"selected":""}>${f}</option>`).join("")}
        </select>
      </div>
      <div class="form-grupo">
        <label for="cp-funil">Funil</label>
        <select id="cp-funil">
          ${FUNIS.map(f => `<option value="${f}" ${post.funil===f?"selected":""}>${f}</option>`).join("")}
        </select>
      </div>
    </div>
    <div class="form-row">
      <div class="form-grupo">
        <label for="cp-mes">Mês</label>
        <select id="cp-mes">
          ${meses.map(m => `<option value="${m}" ${post.mes===m?"selected":""}>${m}</option>`).join("")}
        </select>
      </div>
      <div class="form-grupo">
        <label for="cp-status">Status</label>
        <select id="cp-status">
          ${STATUS.map(s => `<option value="${s}" ${post.status===s?"selected":""}>${s}</option>`).join("")}
        </select>
      </div>
    </div>
    <div class="form-grupo">
      <label for="cp-serie">Série</label>
      <select id="cp-serie">
        ${SERIES.map(s => `<option value="${s}" ${post.serie===s?"selected":""}>${s}</option>`).join("")}
      </select>
    </div>
    <div class="form-grupo">
      <label for="cp-gancho">Gancho (hook)</label>
      <textarea id="cp-gancho" rows="2" placeholder="Primeira frase que prende a atenção">${_esc(post.gancho || '')}</textarea>
    </div>
    <div class="form-grupo">
      <label for="cp-orient">Orientações de produção</label>
      <textarea id="cp-orient" rows="3" placeholder="Instruções para criação do conteúdo">${_esc(post.orientacoes || '')}</textarea>
    </div>
    <div class="form-grupo">
      <label for="cp-roteiro">Roteiro</label>
      <textarea id="cp-roteiro" rows="6" placeholder="Escreva o roteiro do post aqui...">${_esc(post.roteiro || '')}</textarea>
    </div>
  `;

  document.querySelectorAll("#modal-cal-post-body input, #modal-cal-post-body select, #modal-cal-post-body textarea")
    .forEach(el => {
      el.addEventListener("input",  _autoSavePostCal);
      el.addEventListener("change", _autoSavePostCal);
    });
  setSaveStatus(null);
}

async function salvarPostCal() {
  const titulo = document.getElementById("cp-titulo")?.value.trim();
  if (!titulo) { alert("O título é obrigatório."); return; }

  const linhaVal = (document.getElementById("cp-linha")?.value || "").trim() || _linhasDoCliente()[0];

  const dados = {
    titulo,
    linha:       linhaVal,
    subtema:     document.getElementById("cp-subtema")?.value.trim()  || "",
    formato:     document.getElementById("cp-formato")?.value         || FORMATOS[0],
    funil:       document.getElementById("cp-funil")?.value           || FUNIS[0],
    mes:         document.getElementById("cp-mes")?.value             || "Banco",
    status:      document.getElementById("cp-status")?.value          || STATUS[0],
    serie:       document.getElementById("cp-serie")?.value           || "—",
    gancho:      document.getElementById("cp-gancho")?.value.trim()   || "",
    orientacoes: document.getElementById("cp-orient")?.value.trim()   || "",
    roteiro:     document.getElementById("cp-roteiro")?.value.trim()  || ""
  };

  const btnSalvar = document.querySelector("#modal-cal-post .btn-primary");
  if (btnSalvar) { btnSalvar.disabled = true; btnSalvar.textContent = "Salvando..."; }

  const postAtualizado = await db.atualizarPost(CAL_STATE.editandoPostId, dados);

  if (btnSalvar) { btnSalvar.disabled = false; btnSalvar.textContent = "Salvar"; }

  if (!postAtualizado) return;

  const idx = POSTS.findIndex(p => p.id === CAL_STATE.editandoPostId);
  if (idx !== -1) POSTS[idx] = { ...POSTS[idx], ...postAtualizado };

  setSaveStatus("salvo");
  closeModal("modal-cal-post");
  _renderCalendar();
  showToast("✓ Post atualizado");
  CAL_STATE.editandoPostId = null;
}

const _autoSavePostCal = _debounce(async function() {
  if (!CAL_STATE.editandoPostId) return;
  const titulo = document.getElementById("cp-titulo")?.value.trim();
  if (!titulo) return;

  const linhaVal = (document.getElementById("cp-linha")?.value || "").trim() || _linhasDoCliente()[0];
  const dados = {
    titulo,
    linha:       linhaVal,
    subtema:     document.getElementById("cp-subtema")?.value.trim()  || "",
    formato:     document.getElementById("cp-formato")?.value         || FORMATOS[0],
    funil:       document.getElementById("cp-funil")?.value           || FUNIS[0],
    mes:         document.getElementById("cp-mes")?.value             || "Banco",
    status:      document.getElementById("cp-status")?.value          || STATUS[0],
    serie:       document.getElementById("cp-serie")?.value           || "—",
    gancho:      document.getElementById("cp-gancho")?.value.trim()   || "",
    orientacoes: document.getElementById("cp-orient")?.value.trim()   || "",
    roteiro:     document.getElementById("cp-roteiro")?.value.trim()  || ""
  };

  setSaveStatus("salvando");
  const resultado = await db.atualizarPost(CAL_STATE.editandoPostId, dados);
  if (resultado) {
    const idx = POSTS.findIndex(p => p.id === CAL_STATE.editandoPostId);
    if (idx !== -1) POSTS[idx] = { ...POSTS[idx], ...resultado };
    setSaveStatus("salvo");
  } else {
    setSaveStatus("erro");
  }
}, 1000);

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
