-- =============================================
-- MIGRAÇÃO v2: Portal da Cliente — melhorias
-- Execute no Supabase SQL Editor
-- (Dashboard → SQL Editor → New query → cole e rode)
-- =============================================


-- ============================================================
-- SEÇÃO 1 — Admin pode ler objetivos_mes no portal (preview)
-- (Necessário se a tabela já tiver RLS habilitado)
-- ============================================================

DROP POLICY IF EXISTS "objetivos_mes: admin le tudo" ON objetivos_mes;

CREATE POLICY "objetivos_mes: admin le tudo"
  ON objetivos_mes FOR SELECT
  USING (
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
  );


-- ============================================================
-- SEÇÃO 2 — Cliente pode excluir os próprios comentários
-- ============================================================

DROP POLICY IF EXISTS "post_comments: cliente exclui proprio" ON post_comments;

CREATE POLICY "post_comments: cliente exclui proprio"
  ON post_comments FOR DELETE
  USING (
    auth.uid() = user_id
    AND EXISTS (
      SELECT 1 FROM posts p
      JOIN client_users cu ON cu.cliente_id = p.cliente_id
      WHERE p.id = post_id AND cu.user_id = auth.uid()
    )
  );


-- ============================================================
-- SEÇÃO 3 — Admin pode excluir qualquer comentário
-- ============================================================

DROP POLICY IF EXISTS "post_comments: admin exclui" ON post_comments;

CREATE POLICY "post_comments: admin exclui"
  ON post_comments FOR DELETE
  USING (
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
  );


-- ============================================================
-- SEÇÃO 4 — Cliente pode aprovar/reprovar posts da própria cliente
-- (Permite atualizar status via botões Aprovar / Reprovar no portal)
-- ============================================================

DROP POLICY IF EXISTS "posts: cliente atualiza status" ON posts;

CREATE POLICY "posts: cliente atualiza status"
  ON posts FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM client_users
      WHERE cliente_id = posts.cliente_id AND user_id = auth.uid()
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM client_users
      WHERE cliente_id = posts.cliente_id AND user_id = auth.uid()
    )
  );
