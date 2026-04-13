-- =============================================
-- MIGRAÇÃO v3: Comentários da cliente em objetivos e orçamento
-- Execute no Supabase SQL Editor
-- (Dashboard → SQL Editor → New query → cole e rode)
-- =============================================


-- ============================================================
-- SEÇÃO 1 — Adicionar colunas de comentário em objetivos_mes
-- ============================================================

ALTER TABLE objetivos_mes
  ADD COLUMN IF NOT EXISTS comentario_objetivos TEXT,
  ADD COLUMN IF NOT EXISTS comentario_orcamento TEXT;


-- ============================================================
-- SEÇÃO 2 — Cliente pode inserir objetivos_mes para a própria cliente
-- (necessário para criar o registro quando ainda não existe)
-- ============================================================

DROP POLICY IF EXISTS "objetivos_mes: cliente insere" ON objetivos_mes;

CREATE POLICY "objetivos_mes: cliente insere"
  ON objetivos_mes FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM client_users
      WHERE cliente_id = objetivos_mes.cliente_id AND user_id = auth.uid()
    )
  );


-- ============================================================
-- SEÇÃO 3 — Cliente pode atualizar objetivos_mes da própria cliente
-- (necessário para salvar os comentários)
-- ============================================================

DROP POLICY IF EXISTS "objetivos_mes: cliente atualiza" ON objetivos_mes;

CREATE POLICY "objetivos_mes: cliente atualiza"
  ON objetivos_mes FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM client_users
      WHERE cliente_id = objetivos_mes.cliente_id AND user_id = auth.uid()
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM client_users
      WHERE cliente_id = objetivos_mes.cliente_id AND user_id = auth.uid()
    )
  );
