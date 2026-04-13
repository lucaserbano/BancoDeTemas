-- =============================================
-- Migration: Linhas editoriais por cliente
-- Adiciona coluna linhas_editoriais na tabela clientes
-- para que cada cliente possa ter suas próprias linhas.
-- =============================================

ALTER TABLE clientes
  ADD COLUMN IF NOT EXISTS linhas_editoriais TEXT[] DEFAULT '{}';
