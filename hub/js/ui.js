/* =============================================
   UI.JS — Funções compartilhadas
   Depende de: data.js
   ============================================= */

/* -----------------------------------------------
   CLIENTE ATIVO
----------------------------------------------- */
function getClienteAtivo() {
  const id = localStorage.getItem("hub_clienteAtivo") || CLIENTES[0].id;
  return CLIENTES.find(c => c.id === id) || CLIENTES[0];
}

function setClienteAtivo(id) {
  localStorage.setItem("hub_clienteAtivo", id);
}

/* -----------------------------------------------
   BADGES
----------------------------------------------- */
// Converte valor para chave de CSS (ex: "Post único" → "post")
function _chaveCSS(valor) {
  return valor
    .toLowerCase()
    .normalize("NFD").replace(/[\u0300-\u036f]/g, "")  // remove acentos
    .replace(/[^a-z0-9]/g, "");                         // remove não-alfanuméricos
}

/**
 * Retorna o HTML de um badge.
 * @param {string} tipo  - "formato" | "status" | qualquer outro (→ neutro)
 * @param {string} valor - valor a exibir
 */
function badgeHTML(tipo, valor) {
  if (!valor || valor === "—") return `<span class="badge badge-neutro">—</span>`;

  let cls = "badge-neutro";

  if (tipo === "formato") {
    const chave = valor.toLowerCase().startsWith("story") ? "story" : _chaveCSS(valor);
    cls = `badge-formato-${chave}`;
  } else if (tipo === "status") {
    const chave = _chaveCSS(valor);
    cls = `badge-status-${chave}`;
  }

  return `<span class="badge ${cls}">${valor}</span>`;
}

/* -----------------------------------------------
   MODAIS
----------------------------------------------- */
function openModal(id) {
  const el = document.getElementById(id);
  if (el) el.classList.add("aberto");
  document.body.style.overflow = "hidden";
}

function closeModal(id) {
  const el = document.getElementById(id);
  if (el) el.classList.remove("aberto");
  document.body.style.overflow = "";
}

/* -----------------------------------------------
   TOAST
----------------------------------------------- */
let _toastTimer = null;

function showToast(mensagem) {
  let toast = document.getElementById("toast-global");
  if (!toast) {
    toast = document.createElement("div");
    toast.id = "toast-global";
    toast.className = "toast";
    document.body.appendChild(toast);
  }
  toast.textContent = mensagem;
  toast.classList.add("visivel");

  clearTimeout(_toastTimer);
  _toastTimer = setTimeout(() => toast.classList.remove("visivel"), 2500);
}

/* -----------------------------------------------
   CARRINHO (seleção de posts para atribuir ao mês)
----------------------------------------------- */
const selectedIds = new Set();

function toggleSelect(postId, checked) {
  if (checked) selectedIds.add(postId);
  else selectedIds.delete(postId);
  _updateCartFab();
  // Atualiza classe visual da linha
  const tr = document.querySelector(`tr[data-id="${postId}"]`);
  if (tr) tr.classList.toggle("selecionada", checked);
}

function toggleSelectAll(checked) {
  // Seleciona/deseleciona todos os posts visíveis na tabela
  document.querySelectorAll("tbody tr[data-id]").forEach(tr => {
    const id = tr.dataset.id;
    const cb = tr.querySelector("input[type='checkbox']");
    if (cb) cb.checked = checked;
    if (checked) selectedIds.add(id);
    else selectedIds.delete(id);
    tr.classList.toggle("selecionada", checked);
  });
  _updateCartFab();
}

function _updateCartFab() {
  const fab = document.getElementById("cartFab");
  const cnt = document.getElementById("cartFabCount");
  if (!fab) return;
  if (selectedIds.size > 0) {
    fab.classList.add("visivel");
    if (cnt) cnt.textContent = selectedIds.size;
  } else {
    fab.classList.remove("visivel");
  }
}

function openCart() {
  _renderCart();
  const overlay = document.getElementById("cartOverlay");
  const drawer  = document.getElementById("cartDrawer");
  if (overlay) overlay.classList.add("aberto");
  if (drawer)  drawer.classList.add("aberto");
}

function closeCart() {
  const overlay = document.getElementById("cartOverlay");
  const drawer  = document.getElementById("cartDrawer");
  if (overlay) overlay.classList.remove("aberto");
  if (drawer)  drawer.classList.remove("aberto");
}

function _renderCart() {
  const itemsEl = document.getElementById("cartItems");
  if (!itemsEl) return;

  if (selectedIds.size === 0) {
    itemsEl.innerHTML = `<div class="cart-vazio">Nenhum post selecionado.</div>`;
    return;
  }

  const posts = POSTS.filter(p => selectedIds.has(p.id));
  itemsEl.innerHTML = posts.map(p => `
    <div class="cart-item">
      <div>
        <div class="cart-item-titulo">${p.titulo}</div>
        <div class="cart-item-meta">${p.linha} · ${p.formato} · Mês atual: <strong>${p.mes}</strong></div>
      </div>
      <button class="cart-item-remover" onclick="removeFromCart('${p.id}')" title="Remover">×</button>
    </div>
  `).join("");
}

function removeFromCart(postId) {
  selectedIds.delete(postId);
  // Desmarca checkbox na tabela
  const cb = document.querySelector(`tr[data-id="${postId}"] input[type='checkbox']`);
  if (cb) cb.checked = false;
  const tr = document.querySelector(`tr[data-id="${postId}"]`);
  if (tr) tr.classList.remove("selecionada");
  _updateCartFab();
  _renderCart();
  if (selectedIds.size === 0) closeCart();
}

function clearSelection() {
  selectedIds.forEach(id => {
    const cb = document.querySelector(`tr[data-id="${id}"] input[type='checkbox']`);
    if (cb) cb.checked = false;
    const tr = document.querySelector(`tr[data-id="${id}"]`);
    if (tr) tr.classList.remove("selecionada");
  });
  // Desmarca "selecionar todos"
  const cbAll = document.getElementById("cbAll");
  if (cbAll) cbAll.checked = false;
  selectedIds.clear();
  _updateCartFab();
  closeCart();
}

async function assignToMonth() {
  const mesSelect = document.getElementById("cartMesSelect");
  if (!mesSelect) return;
  const mes = mesSelect.value;
  if (!mes) return;

  const qtd = selectedIds.size;
  if (!confirm(`Atribuir ${qtd} post(s) ao mês "${mes}"?`)) return;

  const ids = Array.from(selectedIds);

  // Atualiza no banco
  const ok = await db.atualizarMesPosts(ids, mes);
  if (!ok) return; // erro já exibido por db.js

  // Atualiza array local
  ids.forEach(id => {
    const post = POSTS.find(p => p.id === id);
    if (post) post.mes = mes;
  });

  clearSelection();
  showToast(`✓ ${qtd} post(s) atribuídos a ${mes}`);

  if (typeof renderTabela  === "function") renderTabela();
  if (typeof renderMetrics === "function") renderMetrics();
}

/* -----------------------------------------------
   GERADOR DE ID ÚNICO PARA NOVOS POSTS
----------------------------------------------- */
function gerarId() {
  return "post-" + Date.now() + "-" + Math.floor(Math.random() * 1000);
}

/* -----------------------------------------------
   HELPERS DE FORMATAÇÃO
----------------------------------------------- */
function formatarNumero(n) {
  if (n === null || n === undefined || n === 0) return "—";
  if (n >= 1000) return (n / 1000).toFixed(1).replace(".", ",") + "k";
  return n.toString();
}

function linhaAbrev(linha) {
  const map = {
    "Medicina do Estilo de Vida": "MEV",
    "Conversão": "Conv",
    "Causa & Conscientização": "Causa",
    "Humanização": "Hum"
  };
  return map[linha] || linha;
}

/* -----------------------------------------------
   AUTO-SAVE — indicador de status + debounce
----------------------------------------------- */
let _saveStatusTimer = null;

/**
 * Atualiza o indicador visual de auto-save.
 * @param {"salvando"|"salvo"|"erro"|null} estado
 */
function setSaveStatus(estado) {
  const el = document.getElementById("save-status");
  if (!el) return;
  clearTimeout(_saveStatusTimer);
  el.className = "save-status";
  if (!estado) return;

  if (estado === "salvando") {
    el.innerHTML = '<span class="save-spin">⟳</span> Salvando...';
    el.classList.add("visivel", "save-salvando");
  } else if (estado === "salvo") {
    el.textContent = "✓ Salvo";
    el.classList.add("visivel", "save-salvo");
    _saveStatusTimer = setTimeout(() => el.classList.remove("visivel"), 2000);
  } else if (estado === "erro") {
    el.textContent = "✗ Erro ao salvar";
    el.classList.add("visivel", "save-erro");
  }
}

/**
 * Retorna uma versão com debounce da função fn.
 * @param {Function} fn
 * @param {number} delay - milissegundos
 */
function _debounce(fn, delay) {
  let timer = null;
  return function(...args) {
    clearTimeout(timer);
    timer = setTimeout(() => fn.apply(this, args), delay);
  };
}

/* -----------------------------------------------
   ESCAPE HTML
----------------------------------------------- */
function _esc(str) {
  if (!str) return "";
  return str
    .replace(/&/g, "&amp;")
    .replace(/"/g, "&quot;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;");
}

/* -----------------------------------------------
   LINHAS EDITORIAIS DO CLIENTE ATIVO
   Retorna as linhas do cliente ou o fallback global.
----------------------------------------------- */
function _linhasDoCliente() {
  const c = getClienteAtivo();
  const linhas = c?.linhas_editoriais;
  return (linhas && linhas.length > 0) ? linhas : LINHAS;
}

/* -----------------------------------------------
   CONSTRUTOR DE SELECT DE MÊS (reutilizado em modais e carrinho)
----------------------------------------------- */
function selectMesesHTML(id, mesesAtivos, valorSelecionado, incluirBanco) {
  const opcoes = (mesesAtivos || MESES_ANO).map(m =>
    `<option value="${m}" ${m === valorSelecionado ? "selected" : ""}>${m}</option>`
  ).join("");
  const banco = incluirBanco
    ? `<option value="Banco" ${"Banco" === valorSelecionado ? "selected" : ""}>Banco (sem mês)</option>`
    : "";
  return `<select id="${id}">${opcoes}${banco}</select>`;
}
