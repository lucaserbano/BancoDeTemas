-- =============================================
-- MIGRAÇÃO: Portal da Cliente
-- Execute este arquivo no Supabase SQL Editor
-- (Dashboard → SQL Editor → New query → cole e rode)
--
-- IMPORTANTE: Execute as seções na ordem indicada.
-- A migração é ADITIVA — não altera dados existentes.
-- =============================================


-- ============================================================
-- SEÇÃO 1 — Tabela de perfis (papel de cada usuário)
-- ============================================================

CREATE TABLE IF NOT EXISTS profiles (
  id         UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  role       TEXT NOT NULL DEFAULT 'client' CHECK (role IN ('admin', 'client')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- Cada usuário lê o próprio perfil (necessário para o portal saber o próprio papel)
CREATE POLICY "profiles: leitura propria"
  ON profiles FOR SELECT
  USING (auth.uid() = id);

-- Admin lê todos os perfis
CREATE POLICY "profiles: admin le tudo"
  ON profiles FOR SELECT
  USING (
    EXISTS (SELECT 1 FROM profiles p WHERE p.id = auth.uid() AND p.role = 'admin')
  );


-- ============================================================
-- SEÇÃO 2 — Trigger: cria perfil automaticamente para novos usuários
-- ============================================================

CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  INSERT INTO public.profiles (id, role)
  VALUES (new.id, 'client')
  ON CONFLICT (id) DO NOTHING;
  RETURN new;
END;
$$;

-- Remove o trigger se já existir, para evitar duplicata
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();


-- ============================================================
-- SEÇÃO 3 — Tabela de vínculo usuário ↔ cliente
-- ============================================================

CREATE TABLE IF NOT EXISTS client_users (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  cliente_id UUID NOT NULL REFERENCES clientes(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (user_id, cliente_id)
);

ALTER TABLE client_users ENABLE ROW LEVEL SECURITY;

-- Usuário cliente lê o próprio vínculo (para descobrir qual cliente é o dele)
CREATE POLICY "client_users: leitura propria"
  ON client_users FOR SELECT
  USING (auth.uid() = user_id);

-- Admin lê todos os vínculos
CREATE POLICY "client_users: admin le tudo"
  ON client_users FOR SELECT
  USING (
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
  );


-- ============================================================
-- SEÇÃO 4 — Tabela de comentários por publicação
-- ============================================================

CREATE TABLE IF NOT EXISTS post_comments (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  post_id    UUID NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  user_id    UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  corpo      TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE post_comments ENABLE ROW LEVEL SECURITY;

-- Cliente: inserir comentário somente em posts da própria cliente
CREATE POLICY "post_comments: cliente insere"
  ON post_comments FOR INSERT
  WITH CHECK (
    auth.uid() = user_id
    AND EXISTS (
      SELECT 1
      FROM posts p
      JOIN client_users cu ON cu.cliente_id = p.cliente_id
      WHERE p.id = post_id AND cu.user_id = auth.uid()
    )
  );

-- Cliente: ler comentários de posts da própria cliente
CREATE POLICY "post_comments: cliente le"
  ON post_comments FOR SELECT
  USING (
    EXISTS (
      SELECT 1
      FROM posts p
      JOIN client_users cu ON cu.cliente_id = p.cliente_id
      WHERE p.id = post_id AND cu.user_id = auth.uid()
    )
  );

-- Admin: ler todos os comentários
CREATE POLICY "post_comments: admin le tudo"
  ON post_comments FOR SELECT
  USING (
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- Admin: inserir comentários (para usar no modo preview)
CREATE POLICY "post_comments: admin insere"
  ON post_comments FOR INSERT
  WITH CHECK (
    auth.uid() = user_id
    AND EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
  );


-- ============================================================
-- SEÇÃO 5 — Novas políticas RLS nas tabelas existentes
-- (NÃO remove as políticas antigas — apenas adiciona novas)
-- ============================================================

-- clientes: cliente lê a própria cliente
CREATE POLICY "clientes: cliente le a propria"
  ON clientes FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM client_users
      WHERE cliente_id = clientes.id AND user_id = auth.uid()
    )
  );

-- posts: cliente lê posts da própria cliente
CREATE POLICY "posts: cliente le"
  ON posts FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM client_users
      WHERE cliente_id = posts.cliente_id AND user_id = auth.uid()
    )
  );

-- objetivos_mes: cliente lê objetivos da própria cliente
CREATE POLICY "objetivos_mes: cliente le"
  ON objetivos_mes FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM client_users
      WHERE cliente_id = objetivos_mes.cliente_id AND user_id = auth.uid()
    )
  );


-- ============================================================
-- SEÇÃO 6 — Promover o admin (execute DEPOIS das seções 1-5)
--
-- 1. Vá em Authentication → Users no Supabase Dashboard
-- 2. Encontre sua conta e copie o UUID (coluna "User UID")
-- 3. Substitua <SEU-UUID-AQUI> pelo UUID copiado
-- 4. Execute somente esta linha abaixo:
-- ============================================================

-- INSERT INTO profiles (id, role)
-- VALUES ('<SEU-UUID-AQUI>', 'admin')
-- ON CONFLICT (id) DO UPDATE SET role = 'admin';


-- ============================================================
-- SEÇÃO 7 — Vincular a cliente Paôla ao usuário dela
--           (execute depois de criar a conta da cliente)
--
-- 1. Crie a conta da Paôla em Authentication → Users → Invite user
-- 2. Copie o UUID da conta dela
-- 3. Vá em Table Editor → clientes, copie o UUID da linha da Paôla
-- 4. Substitua os valores abaixo e execute:
-- ============================================================

-- INSERT INTO client_users (user_id, cliente_id)
-- VALUES ('<UUID-CONTA-PAOLA>', '<UUID-CLIENTES-PAOLA>');


-- ============================================================
-- SEÇÃO 8 — Migração de status (OPCIONAL — execute só quando quiser)
--
-- Esta seção converte os status antigos para os novos.
-- Os status antigos eram: "Ideia", "Roteiro", "Gravado", "Editado", "Publicado"
-- Os novos são: "em produção", "aprovado", "reprovado", "publicado"
--
-- NÃO execute agora — primeiro verifique se o portal está funcionando.
-- ============================================================

-- UPDATE posts SET status = 'em produção' WHERE status IN ('Ideia', 'Roteiro', 'Gravado', 'Editado');
-- UPDATE posts SET status = 'publicado'   WHERE status = 'Publicado';
