# HUB.md — Referência Técnica

Documentação técnica do hub de gestão de calendário editorial.
Arquivo para uso com Claude Code — leia antes de tarefas técnicas.

---

## Visão Geral

Aplicação web estática (HTML + JS puro) que consome o **Supabase** como backend.
Sem build, sem bundler — abrir os `.html` diretamente no browser ou servir via qualquer servidor estático.

**Supabase:**
- Project URL: `https://iwaoinijfjxvqawbzciv.supabase.co`
- Anon key: em `hub/js/supabase.js`

---

## Estrutura de Arquivos

```
hub/
  index.html          # Banco de posts (área admin)
  mes.html            # Objetivos mês a mês + calendário de posts
  calendario.html     # Calendário visual (grid mensal)
  portal.html         # Portal da cliente (view da Paôla)
  login.html          # Autenticação (Supabase Auth)
  importar.html       # Importação de posts históricos do Instagram
  importar_temas.html # Importação em massa de temas do banco

  js/
    supabase.js       # Inicializa window.sb (cliente Supabase)
    db.js             # CRUD: todas as operações de banco (async, retornam {data, error})
    data.js           # Constantes globais + arrays CLIENTES[] e POSTS[] em memória
    ui.js             # Helpers compartilhados: badges, toasts, modais, _esc(), _debounce()
    app.js            # Lógica do index.html
    mes.js            # Lógica do mes.html
    calendario.js     # Lógica do calendario.html
    portal.js         # Lógica do portal.html (view cliente)
    portal-db.js      # Operações de banco específicas do portal da cliente

  css/
    style.css         # Estilos da área admin
    portal.css        # Estilos do portal da cliente

  sql/
    migration_portal_cliente.sql   # v1: profiles, client_users, post_comments, RLS
    migration_linhas_por_cliente.sql # ADD COLUMN linhas_editoriais em clientes
    migration_portal_v2.sql        # RLS adicional (admin lê objetivos, cliente aprova posts)
    migration_portal_v3.sql        # ADD COLUMN comentario_objetivos/orcamento em objetivos_mes
```

---

## Schema do Banco (Supabase / PostgreSQL)

### `clientes`
| Coluna | Tipo | Notas |
|---|---|---|
| `id` | UUID PK | auto |
| `user_id` | UUID FK → auth.users | dono admin |
| `nome` | TEXT | nome completo |
| `handle` | TEXT | ex: `@paolapreto` |
| `especialidade` | TEXT | |
| `avatar` | TEXT | emoji |
| `seguidores` | INT | |
| `meta_posts_mes` | INT | padrão: 4 |
| `ano` | INT | padrão: 2026 |
| `meses_ativos` | TEXT[] | ex: `["Abril","Maio",...]` |
| `linhas_editoriais` | TEXT[] | ex: `["Medicina do Estilo de Vida",...]` |
| `created_at` | TIMESTAMPTZ | |

### `posts`
| Coluna | Tipo | Notas |
|---|---|---|
| `id` | UUID PK | auto |
| `cliente_id` | UUID FK → clientes | |
| `titulo` | TEXT | obrigatório |
| `linha` | TEXT | linha editorial |
| `subtema` | TEXT | |
| `formato` | TEXT | ver constantes |
| `funil` | TEXT | TOPO / MEIO / FUNDO |
| `serie` | TEXT | ver constantes |
| `mes` | TEXT | nome do mês ou "Banco" |
| `status` | TEXT | ver constantes |
| `likes` | INT | |
| `comentarios` | INT | |
| `data_publicacao` | DATE | null se não publicado |
| `gancho` | TEXT | hook do post |
| `orientacoes` | TEXT | instruções de produção |
| `roteiro` | TEXT | texto completo |
| `created_at` | TIMESTAMPTZ | |

### `objetivos_mes`
| Coluna | Tipo | Notas |
|---|---|---|
| `id` | UUID PK | auto |
| `cliente_id` | UUID FK → clientes | |
| `mes` | TEXT | nome do mês |
| `ano` | INT | |
| `objetivo` | TEXT | texto do objetivo |
| `orcamento_anuncios` | TEXT | ex: "R$ 250–350" |
| `tipo_anuncio` | TEXT | ex: "Reconhecimento de Marca" |
| `datas_importantes` | TEXT[] | ex: `["7/abr — Dia Mundial da Saúde"]` |
| `funil_topo` | INT | % (padrão 50) |
| `funil_meio` | INT | % (padrão 30) |
| `funil_fundo` | INT | % (padrão 20) |
| `comentario_objetivos` | TEXT | comentário da cliente (v3) |
| `comentario_orcamento` | TEXT | comentário da cliente (v3) |
| UNIQUE | `(cliente_id, mes, ano)` | upsert por esse conflito |

### `profiles`
| Coluna | Tipo | Notas |
|---|---|---|
| `id` | UUID PK FK → auth.users | |
| `role` | TEXT | `'admin'` ou `'client'` |
| `created_at` | TIMESTAMPTZ | |

Trigger: ao criar usuário em `auth.users`, insere automaticamente em `profiles` com `role = 'client'`.

### `client_users`
| Coluna | Tipo | Notas |
|---|---|---|
| `id` | UUID PK | |
| `user_id` | UUID FK → auth.users | |
| `cliente_id` | UUID FK → clientes | |
| UNIQUE | `(user_id, cliente_id)` | |

Vínculo muitos-para-muitos entre usuário autenticado e cliente.

### `post_comments`
| Coluna | Tipo | Notas |
|---|---|---|
| `id` | UUID PK | |
| `post_id` | UUID FK → posts | |
| `user_id` | UUID FK → auth.users | |
| `corpo` | TEXT | |
| `created_at` | TIMESTAMPTZ | |

---

## Constantes (data.js)

```js
MESES_ANO = ["Janeiro","Fevereiro","Março","Abril","Maio","Junho",
             "Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"]

LINHAS    = ["Medicina do Estilo de Vida", "Conversão",
             "Causa & Conscientização", "Humanização"]

FORMATOS  = ["Reels", "Carrossel", "Post único",
             "Story · Enquete", "Story · Quiz", "Story · Caixinha",
             "Story · Slider", "Story · Sequência"]

FUNIS     = ["TOPO", "MEIO", "FUNDO"]

STATUS    = ["Ideia", "Roteiro", "Gravado", "Editado", "Publicado"]

SERIES    = ["—", "Mito ou Verdade? 🫀", "Pergunte à Dra."]
```

---

## Fluxo de Autenticação

- Login via Supabase Auth (email + senha) em `login.html`
- `db.exigirLogin()` — redireciona para `login.html` se sem sessão
- `db.exigirAdmin()` — redireciona para `portal.html` se `role !== 'admin'`
- Páginas admin (`index.html`, `mes.html`, `calendario.html`): chamam ambas
- `portal.html`: chama só `exigirLogin()` — acessível por clientes e admins

**Dois tipos de usuário:**
| Tipo | Acesso | Como identificar |
|---|---|---|
| Admin | Todas as páginas | `profiles.role = 'admin'` |
| Cliente | Apenas `portal.html` | `profiles.role = 'client'` + registro em `client_users` |

Para promover admin: `INSERT INTO profiles (id, role) VALUES ('<UUID>', 'admin') ON CONFLICT (id) DO UPDATE SET role = 'admin'`
Para vincular cliente: `INSERT INTO client_users (user_id, cliente_id) VALUES ('<UUID-USER>', '<UUID-CLIENTE>')`

---

## SQL Migrations — Ordem de Aplicação

Executar no **Supabase → SQL Editor** nesta ordem (cada uma é aditiva, não destrói dados):

1. `migration_portal_cliente.sql` — cria profiles, client_users, post_comments + RLS base
2. `migration_linhas_por_cliente.sql` — ADD COLUMN linhas_editoriais em clientes
3. `migration_portal_v2.sql` — políticas RLS adicionais (admin lê objetivos, cliente aprova posts, cliente exclui comentário)
4. `migration_portal_v3.sql` — ADD COLUMN comentario_objetivos/orcamento + cliente pode inserir/atualizar objetivos_mes

---

## Convenções de Código

- JS usa **camelCase** (clienteId, dataPublicacao)
- Banco usa **snake_case** (cliente_id, data_publicacao)
- `db.js` faz a conversão nos dois sentidos via `_mapPost()`, `_mapCliente()`, `_postParaBanco()`
- Todas as funções de `db.js` são `async` e retornam `{ data, error }`
- Toasts de erro são exibidos automaticamente por `_erroToast()` em `db.js`
- Auto-save no modal de edição de post: debounce de 1000ms via `_debounce()` de `ui.js`

---

## Arquivos Legados (`_legado/`)

Mantidos apenas como backup — não são mais usados:

| Arquivo | O que era |
|---|---|
| `gerar_planilha.py` | Gerava aba "Medicina do Estilo de Vida" no xlsx |
| `gerar_aba_conversao.py` | Gerava abas "Conversão" + "Objetivos Mês a Mês" no xlsx |
| `gerar_aba_objetivos.py` | Versão anterior de objetivos (sem anúncios) |
| `gerar_html.py` | Gerava banco_temas.html |
| `banco_temas.html` | Dashboard standalone com banco de temas (pré-hub) |
| `objetivos.html` | Visualização standalone de objetivos (pré-hub) |
