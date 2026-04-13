-- =============================================
-- VCC — Acréscimo de congressos/eventos em datas_importantes
-- Execute no Supabase SQL Editor
-- (Dashboard → SQL Editor → New query → cole e rode)
--
-- Cliente: eb9aa951-b915-4b09-9c34-072b56afe4e0
-- Objetivo: APENAS acrescentar datas de congressos e eventos
--           relevantes para valvopatias/cardiologia intervencionista
--           ao array já existente em cada mês.
--           As datas de saúde que já estão cadastradas são MANTIDAS.
-- =============================================

BEGIN;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM clientes WHERE id = 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid) THEN
    RAISE EXCEPTION 'cliente_id % nao encontrado', 'eb9aa951-b915-4b09-9c34-072b56afe4e0';
  END IF;
END $$;


-- ────────────────────────────────────────────────────────────
-- NOTA TÉCNICA
-- O operador || concatena arrays no PostgreSQL.
-- Cada UPDATE preserva tudo que já está em datas_importantes
-- e acrescenta apenas as novas entradas de congressos.
-- ────────────────────────────────────────────────────────────


-- ABRIL
-- SCAI 2026 — principal congresso norte-americano de
-- cardiologia intervencionista estrutural (TAVI, TEER, FOP, CIA)
UPDATE objetivos_mes
SET datas_importantes = datas_importantes || ARRAY[
  'SCAI 2026 — 23–25/abr · Montreal, Canadá (cardiologia intervencionista estrutural: TAVI, TEER, valvopatias)'
]::text[]
WHERE cliente_id = 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid
  AND mes = 'Abril' AND ano = 2026;


-- MAIO
-- EuroPCR — principal congresso europeu de intervenção percutânea;
-- dedicado a valvopatias, TAVI, TEER e inovações em dispositivos
UPDATE objetivos_mes
SET datas_importantes = datas_importantes || ARRAY[
  'EuroPCR 2026 — 19–22/mai · Paris, França (maior congresso europeu de intervenção percutânea: TAVI, TEER, valve-in-valve)'
]::text[]
WHERE cliente_id = 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid
  AND mes = 'Maio' AND ano = 2026;


-- JUNHO
-- SOCESP — congresso mais relevante do estado de SP;
-- inclui sessões de valvopatias e cardiologia intervencionista
UPDATE objetivos_mes
SET datas_importantes = datas_importantes || ARRAY[
  'SOCESP 2026 — 4–6/jun · São Paulo, SP (46º Congresso de Cardiologia do Estado de SP)'
]::text[]
WHERE cliente_id = 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid
  AND mes = 'Junho' AND ano = 2026;


-- JULHO
-- SOLACI-SBHCI — principal congresso de hemodinâmica e cardiologia
-- intervencionista da América Latina; sessões de destaque em
-- cardiopatias estruturais, TAVI e TEER
UPDATE objetivos_mes
SET datas_importantes = datas_importantes || ARRAY[
  'SOLACI-SBHCI 2026 — 29–31/jul · São Paulo, SP (principal congresso de hemodinâmica e intervenção estrutural da América Latina)'
]::text[]
WHERE cliente_id = 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid
  AND mes = 'Julho' AND ano = 2026;


-- AGOSTO
-- ESC Congress — maior congresso de cardiologia do mundo;
-- inclui apresentação/atualização das diretrizes europeias de
-- valvopatias (Valvular Heart Disease Guidelines)
UPDATE objetivos_mes
SET datas_importantes = datas_importantes || ARRAY[
  'ESC Congress 2026 — 28–31/ago · Munique, Alemanha (maior congresso mundial de cardiologia; inclui atualização das diretrizes europeias de valvopatias)'
]::text[]
WHERE cliente_id = 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid
  AND mes = 'Agosto' AND ano = 2026;


-- SETEMBRO
-- Mês do Coração — datas já existentes no cadastro (27/set e 29/set).
-- Nenhum congresso de valvopatias relevante neste mês.
-- (sem acréscimo)


-- OUTUBRO
-- SBC + World Congress of Cardiology — edição especial conjunta com
-- o World Congress of Cardiology em 2026; inclui simposios de
-- valvopatias e cardiologia intervencionista
-- TCT — referência global em procedimentos transcateter; TAVI,
-- TEER e valve-in-valve são eixos centrais do congresso
UPDATE objetivos_mes
SET datas_importantes = datas_importantes || ARRAY[
  'SBC 2026 — 8–10/out · Rio de Janeiro, RJ (81º Congresso Brasileiro + World Congress of Cardiology — edição histórica)',
  'TCT 2026 — 31/out–3/nov · San Diego, EUA (Transcatheter Cardiovascular Therapeutics — referência em TAVI, TEER e valve-in-valve)'
]::text[]
WHERE cliente_id = 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid
  AND mes = 'Outubro' AND ano = 2026;


-- NOVEMBRO
-- PCR London Valves — congresso dedicado EXCLUSIVAMENTE a
-- intervenções valvares percutâneas; o mais relevante do mundo
-- especificamente para valvopatias (TAVI, TEER, valve-in-valve,
-- fechamento de paravalvar). Essencial para o posicionamento do VCC.
UPDATE objetivos_mes
SET datas_importantes = datas_importantes || ARRAY[
  'PCR London Valves 2026 — 22–24/nov · Londres, Reino Unido (congresso dedicado exclusivamente a intervenções valvares: TAVI, TEER, valve-in-valve, paravalvar — o mais relevante do mundo para valvopatias)'
]::text[]
WHERE cliente_id = 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid
  AND mes = 'Novembro' AND ano = 2026;


-- DEZEMBRO
-- Sem congressos de valvopatias relevantes. (sem acréscimo)


COMMIT;


-- ============================================================
-- MAPA DE CONGRESSOS — VCC 2026
-- (por ordem de relevância para valvopatias/estrutural)
-- ============================================================
--
-- Congresso              | Mês  | Relevância para VCC
-- -----------------------|------|---------------------------------------------
-- PCR London Valves      | Nov  | ⭐⭐⭐ Foco exclusivo em valvas percutâneas
-- EuroPCR                | Mai  | ⭐⭐⭐ TAVI, TEER, dispositivos estruturais
-- TCT                    | Out  | ⭐⭐⭐ TAVI, TEER, valve-in-valve
-- SCAI                   | Abr  | ⭐⭐  Estrutural + intervencionismo geral
-- ESC Congress           | Ago  | ⭐⭐  Diretrizes de valvopatias
-- SOLACI-SBHCI           | Jul  | ⭐⭐  Principal da AL: estrutural e coronária
-- SBC + World Congress   | Out  | ⭐⭐  Maior congresso brasileiro + WCC 2026
-- SOCESP                 | Jun  | ⭐    Regional SP; presença institucional
-- ============================================================
