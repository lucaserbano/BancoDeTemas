# Hub de Conteúdo — Instagram Editorial

Painel de gestão de conteúdo para Instagram de profissionais de saúde. Desenvolvido para planejar, organizar e acompanhar o calendário editorial da **Dra. Paôla Cardoso Preto** (`@paolapreto`), cardiologista especialista em Insuficiência Cardíaca Avançada e Transplante Cardíaco.

## Funcionalidades

- **Multi-cliente** — gerencie vários perfis do Instagram em um único hub
- **Banco de posts** — cadastre posts com linha editorial, formato, funil, série e status de produção
- **Calendário mensal** — atribua posts a meses e gerencie objetivos mensais com orçamento de anúncios
- **Métricas** — acompanhe likes, comentários e distribuição de funil
- **Salvamento automático** — campos são salvos automaticamente ao editar (debounce de 1s)
- **Importação do Instagram** — importe posts históricos do Instagram para o banco
- **Carrinho de mês** — selecione múltiplos posts e atribua a um mês de uma vez
- **Autenticação** — login por e-mail e senha via Supabase (cada usuário vê apenas seus próprios dados)

## Estrutura do projeto

```
hub/
├── index.html        # Dashboard principal (lista de posts)
├── login.html        # Login e cadastro
├── mes.html          # Visão mensal (objetivos + posts do mês + banco)
├── importar.html     # Importação de posts históricos do Instagram
├── css/
│   └── style.css     # Estilos globais
└── js/
    ├── supabase.js   # Inicialização do cliente Supabase
    ├── db.js         # Funções de banco de dados (CRUD)
    ├── data.js       # Constantes e dados de referência
    ├── ui.js         # Utilitários de UI (badges, toast, carrinho, auto-save)
    ├── app.js        # Lógica do dashboard (index.html)
    └── mes.js        # Lógica da visão mensal (mes.html)
```

## Setup do Supabase

### 1. Crie um projeto no Supabase

Acesse [supabase.com](https://supabase.com) e crie um novo projeto.

### 2. Crie as tabelas

No **SQL Editor** do Supabase, execute o seguinte script:

```sql
-- Tabela de clientes (perfis do Instagram)
create table clientes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users not null,
  nome text not null,
  handle text not null,
  especialidade text,
  avatar text default '👤',
  seguidores integer default 0,
  meta_posts_mes integer default 4,
  ano integer default 2026,
  meses_ativos text[] default array['Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
  created_at timestamptz default now()
);

-- Tabela de posts
create table posts (
  id uuid primary key default gen_random_uuid(),
  cliente_id uuid references clientes(id) on delete cascade not null,
  titulo text not null,
  linha text default '',
  subtema text default '',
  formato text default 'Reels',
  funil text default 'TOPO',
  serie text default '—',
  mes text default 'Banco',
  status text default 'Ideia',
  likes integer default 0,
  comentarios integer default 0,
  data_publicacao date,
  gancho text default '',
  orientacoes text default '',
  created_at timestamptz default now()
);

-- Tabela de objetivos mensais
create table objetivos_mes (
  id uuid primary key default gen_random_uuid(),
  cliente_id uuid references clientes(id) on delete cascade not null,
  mes text not null,
  ano integer not null,
  objetivo text,
  orcamento_anuncios text,
  tipo_anuncio text,
  datas_importantes text[] default '{}',
  funil_topo integer default 50,
  funil_meio integer default 30,
  funil_fundo integer default 20,
  unique(cliente_id, mes, ano)
);

-- Row Level Security (cada usuário vê apenas seus próprios dados)
alter table clientes enable row level security;
alter table posts enable row level security;
alter table objetivos_mes enable row level security;

create policy "Usuários veem próprios clientes"
  on clientes for all using (auth.uid() = user_id);

create policy "Usuários veem posts dos próprios clientes"
  on posts for all using (
    cliente_id in (select id from clientes where user_id = auth.uid())
  );

create policy "Usuários veem objetivos dos próprios clientes"
  on objetivos_mes for all using (
    cliente_id in (select id from clientes where user_id = auth.uid())
  );
```

### 3. Configure as credenciais

Edite `hub/js/supabase.js` com as credenciais do seu projeto:

```js
const sb = supabase.createClient(
  'https://SEU-PROJECT-ID.supabase.co',   // Settings → API → Project URL
  'SUA-ANON-PUBLIC-KEY'                    // Settings → API → anon public
);
```

### 4. Habilite autenticação por e-mail

Em **Authentication → Providers → Email**, confirme que está ativado.

## Como rodar localmente

Basta abrir `hub/index.html` no browser. Por ser um site estático, não precisa de servidor local — funciona direto com `file://`.

> **Dica:** Use a extensão [Live Server](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer) no VS Code para hot reload.

## Deploy no GitHub Pages

### 1. Crie um repositório público no GitHub

```bash
git init
git add .
git commit -m "Hub de Conteúdo — deploy inicial"
git remote add origin https://github.com/SEU-USUARIO/hub-editorial.git
git push -u origin main
```

### 2. Ative o GitHub Pages

No repositório, vá em **Settings → Pages**:
- **Source:** `Deploy from a branch`
- **Branch:** `main`
- **Folder:** `/ (root)`
- Clique em **Save**

O site ficará disponível em:
```
https://SEU-USUARIO.github.io/hub-editorial/hub/index.html
```

### 3. Autorize a URL no Supabase

Em **Authentication → URL Configuration** no Supabase:
- **Site URL:** `https://SEU-USUARIO.github.io/hub-editorial/hub/login.html`
- **Redirect URLs:** adicione `https://SEU-USUARIO.github.io`

### Checklist de verificação após deploy

- [ ] Site abre pelo link publicado
- [ ] Login funciona (redireciona corretamente)
- [ ] Posts e clientes carregam do Supabase
- [ ] Auto-save funciona (indicador "Salvando..." / "✓ Salvo" aparece ao editar)
- [ ] Importação de posts funciona (`/hub/importar.html`)

## Importar posts históricos do Instagram

Acesse `hub/importar.html` após o login. A página contém os 24 posts históricos de `@paolapreto` e permite importá-los para o banco com um clique. Duplicatas são detectadas automaticamente.

## Tecnologias

- HTML/CSS/JS puro — sem frameworks, sem build step
- [Supabase](https://supabase.com) — banco PostgreSQL + autenticação
- [Supabase JS v2](https://supabase.com/docs/reference/javascript) via CDN
- [Inter](https://fonts.google.com/specimen/Inter) via Google Fonts
