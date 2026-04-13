-- =============================================
-- VCC + OneHeart — Acréscimo do DIC-SBC em datas_importantes
-- Execute no Supabase SQL Editor
-- (Dashboard → SQL Editor → New query → cole e rode)
--
-- 15º Congresso do DIC-SBC — 15–17/out/2026 · Curitiba, PR
-- Maior congresso latino-americano de imagem cardiovascular.
-- Particularmente relevante para o VCC (mesmo município)
-- e para a OneHeart (imagem como pilar do planejamento estrutural).
-- =============================================

BEGIN;

-- ────────────────────────────────────────────────────────────
-- VCC — eb9aa951-b915-4b09-9c34-072b56afe4e0
-- Outubro: já possui SBC+TCT; acrescenta o DIC-SBC
-- ────────────────────────────────────────────────────────────

UPDATE objetivos_mes
SET datas_importantes = datas_importantes || ARRAY[
  'DIC-SBC 2026 — 15–17/out · Curitiba, PR (15º Congresso do Depto. de Imagem Cardiovascular da SBC — maior congresso de imagem cardiovascular da América Latina; realizado na cidade-sede do VCC)'
]::text[]
WHERE cliente_id = 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid
  AND mes = 'Outubro' AND ano = 2026;


-- ────────────────────────────────────────────────────────────
-- OneHeart — 7463fed9-0bc8-4eea-a7b8-0c5660fee65f
-- Outubro: acrescenta o DIC-SBC ao lado do SBC+TCT
-- ────────────────────────────────────────────────────────────

UPDATE objetivos_mes
SET datas_importantes = datas_importantes || ARRAY[
  'DIC-SBC 2026 — 15–17/out · Curitiba, PR (15º Congresso do Depto. de Imagem Cardiovascular da SBC — imagem, eco, TC e planejamento estrutural)'
]::text[]
WHERE cliente_id = '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid
  AND mes = 'Outubro' AND ano = 2026;


COMMIT;
