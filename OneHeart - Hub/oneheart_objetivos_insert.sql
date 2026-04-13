-- =============================================
-- OneHeart — Objetivos mensais (abril–dezembro 2026)
-- Execute no Supabase SQL Editor
-- (Dashboard → SQL Editor → New query → cole e rode)
--
-- Cliente destino: 7463fed9-0bc8-4eea-a7b8-0c5660fee65f
-- Estratégia: Cardiologia intervencionista / Curitiba e RMC
-- Objetivo macro: Prestígio de marca → Atração de pacientes → Encaminhamento médico
-- =============================================

BEGIN;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM clientes WHERE id = '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid) THEN
    RAISE EXCEPTION 'cliente_id % nao encontrado na tabela clientes', '7463fed9-0bc8-4eea-a7b8-0c5660fee65f';
  END IF;
END $$;


-- ============================================================
-- Distribuição editorial de referência (por linha / por mês)
--
-- 30% Prestígio Institucional              → TOPO
-- 20% OneHeart Talks! & Ecossistema        → TOPO
-- 20% Autoridade Técnica em Estruturais    → TOPO / MEIO
-- 15% Encaminhamento Médico & Parceria     → MEIO / FUNDO
-- 15% Segurança & Confiança para Pacientes → MEIO
--
-- Meta geral: 50% TOPO · 30% MEIO · 20% FUNDO
-- Frequência: 1 post/semana → 4 posts/mês
-- ============================================================


INSERT INTO objetivos_mes (
  cliente_id,
  mes,
  ano,
  objetivo,
  orcamento_anuncios,
  tipo_anuncio,
  datas_importantes,
  funil_topo,
  funil_meio,
  funil_fundo
)
VALUES

  -- ────────────────────────────────────────────
  -- ABRIL — Abertura editorial + SCAI 2026
  -- ────────────────────────────────────────────
  (
    '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
    'Abril', 2026,
    'Inaugurar presença editorial com foco em posicionamento da marca OneHeart. Apresentar a equipe, o INC e os diferenciais em cardiologia intervencionista estrutural. Prioridade: construir prestígio institucional desde o primeiro post.',
    'R$ 200–300',
    'Reconhecimento de marca (alcance)',
    ARRAY[
      'SCAI 2026 — 23–25/abr · Montreal, Canadá (cardiologia intervencionista estrutural)'
    ],
    70, 20, 10
  ),

  -- ────────────────────────────────────────────
  -- MAIO — Autoridade técnica + EuroPCR
  -- ────────────────────────────────────────────
  (
    '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
    'Maio', 2026,
    'Consolidar autoridade técnica em valvopatias e cardiopatias estruturais. Aproveitar o EuroPCR para reforçar presença no cenário científico internacional. Conteúdo voltado a cardiologistas clínicos e ecocardiografistas.',
    'R$ 150–200',
    'Reconhecimento de marca (alcance)',
    ARRAY[
      'EuroPCR 2026 — 19–22/mai · Paris, França (principal congresso europeu de intervenção percutânea)'
    ],
    60, 30, 10
  ),

  -- ────────────────────────────────────────────
  -- JUNHO — Encaminhamento médico + SOCESP
  -- ────────────────────────────────────────────
  (
    '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
    'Junho', 2026,
    'Estimular o encaminhamento de casos por cardiologistas clínicos e ecocardiografistas. Destaque para o SOCESP 2026 como oportunidade de presença e networking local. Reforçar disponibilidade e parceria assistencial da OneHeart.',
    'R$ 250–350',
    'Mensagens (WhatsApp) · Reconhecimento de marca',
    ARRAY[
      'SOCESP 2026 — 4–6/jun · São Paulo, SP (46º Congresso de Cardiologia do Estado de SP)'
    ],
    50, 30, 20
  ),

  -- ────────────────────────────────────────────
  -- JULHO — Bastidores técnicos + SOLACI-SBHCI
  -- ────────────────────────────────────────────
  (
    '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
    'Julho', 2026,
    'Mostrar os bastidores do processo decisório: planejamento por imagem, sizing e heart team. Aproveitar o SOLACI-SBHCI para posts de presença institucional e atualização científica. Principal congresso de hemodinâmica da América Latina — usar como ativo de marca.',
    'R$ 200–300',
    'Reconhecimento de marca (engajamento)',
    ARRAY[
      'SOLACI-SBHCI 2026 — 29–31/jul · São Paulo, SP (principal congresso de hemodinâmica da América Latina)'
    ],
    55, 30, 15
  ),

  -- ────────────────────────────────────────────
  -- AGOSTO — Segurança para pacientes + ESC
  -- ────────────────────────────────────────────
  (
    '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
    'Agosto', 2026,
    'Fortalecer confiança e reduzir barreiras emocionais para pacientes que consideram avaliação especializada. Abordar medos comuns (cirurgia aberta, procedimento transcateter, decisão em família). Aproveitar o ESC 2026 para reforçar atualização científica.',
    'R$ 150–200',
    'Mensagens (WhatsApp)',
    ARRAY[
      'ESC Congress 2026 — 28–31/ago · Munique, Alemanha (principal congresso europeu de cardiologia)'
    ],
    45, 40, 15
  ),

  -- ────────────────────────────────────────────
  -- SETEMBRO — Mês do Coração · Campanha
  -- ────────────────────────────────────────────
  (
    '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
    'Setembro', 2026,
    'Campanha Mês do Coração: maior investimento em anúncios do ano. Reforçar posicionamento da OneHeart para pacientes e mercado médico local. Explorar o Dia Mundial do Coração (29/set) com post de alta relevância institucional.',
    'R$ 400–500',
    'Reconhecimento de marca (alcance) · Mensagens (WhatsApp)',
    ARRAY[
      '29/set — Dia Mundial do Coração (World Heart Day) · OMS',
      'Mês do Coração — campanha de conscientização cardiovascular'
    ],
    50, 30, 20
  ),

  -- ────────────────────────────────────────────
  -- OUTUBRO — SBC + TCT · Presença científica
  -- ────────────────────────────────────────────
  (
    '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
    'Outubro', 2026,
    'Reforçar autoridade científica com presença no SBC 2026 (World Congress of Cardiology) e no TCT. Explorar casos comentados e raciocínio intervencionista para engajar médicos encaminhadores. Mês de alta relevância científica — conteúdo voltado ao mercado médico.',
    'R$ 200–300',
    'Mensagens (WhatsApp) · Engajamento',
    ARRAY[
      'SBC 2026 — 8–10/out · Rio de Janeiro, RJ (81º Congresso Brasileiro + World Congress of Cardiology)',
      'TCT 2026 — 31/out–3/nov · San Diego, EUA (Transcatheter Cardiovascular Therapeutics)'
    ],
    50, 30, 20
  ),

  -- ────────────────────────────────────────────
  -- NOVEMBRO — Encaminhamento + OneHeart Talks!
  -- ────────────────────────────────────────────
  (
    '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
    'Novembro', 2026,
    'Consolidar parcerias de encaminhamento com cardiologistas clínicos e ecocardiografistas. Usar o OneHeart Talks! como ativo de marca e liderança local. PCR London Valves como referência em valvopatias estruturais para conteúdo técnico.',
    'R$ 150–200',
    'Mensagens (WhatsApp)',
    ARRAY[
      'PCR London Valves 2026 — 22–24/nov · Londres, Reino Unido (foco em TAVI, TEER, valvopatias)'
    ],
    40, 35, 25
  ),

  -- ────────────────────────────────────────────
  -- DEZEMBRO — Fechamento + Retrospectiva
  -- ────────────────────────────────────────────
  (
    '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
    'Dezembro', 2026,
    'Encerrar o ano com retrospectiva institucional e reforço do posicionamento da OneHeart. Comunicar conquistas do ano, presença em congressos e volume assistencial (sem dados protegidos). Preparar o terreno para 2027 com mensagem de continuidade.',
    'R$ 100–150',
    'Reconhecimento de marca (alcance)',
    ARRAY[
      'Retrospectiva 2026 — marco editorial de encerramento'
    ],
    55, 30, 15
  )

ON CONFLICT (cliente_id, mes, ano)
DO UPDATE SET
  objetivo           = EXCLUDED.objetivo,
  orcamento_anuncios = EXCLUDED.orcamento_anuncios,
  tipo_anuncio       = EXCLUDED.tipo_anuncio,
  datas_importantes  = EXCLUDED.datas_importantes,
  funil_topo         = EXCLUDED.funil_topo,
  funil_meio         = EXCLUDED.funil_meio,
  funil_fundo        = EXCLUDED.funil_fundo;


COMMIT;


-- ============================================================
-- RESUMO — Estratégia de anúncios por mês
-- ============================================================
--
-- Mês       | Orçamento        | Tipo de anúncio                       | Funil T/M/F
-- ----------|------------------|---------------------------------------|------------
-- Abril     | R$ 200–300       | Alcance (reconhecimento de marca)     | 70/20/10
-- Maio      | R$ 150–200       | Alcance                               | 60/30/10
-- Junho     | R$ 250–350       | Mensagens + Alcance                   | 50/30/20
-- Julho     | R$ 200–300       | Engajamento                           | 55/30/15
-- Agosto    | R$ 150–200       | Mensagens                             | 45/40/15
-- Setembro⭐ | R$ 400–500       | Alcance + Mensagens (campanha)        | 50/30/20
-- Outubro   | R$ 200–300       | Mensagens + Engajamento               | 50/30/20
-- Novembro  | R$ 150–200       | Mensagens                             | 40/35/25
-- Dezembro  | R$ 100–150       | Alcance                               | 55/30/15
-- ----------|------------------|---------------------------------------|------------
-- TOTAL     | R$ 1.600–2.300   |                                       |
--
-- Obs: Restrição CFM Res. 2.336/2023 — proibido mencionar preços,
-- antes/depois, depoimentos e comparações com outros médicos em anúncios.
-- ============================================================
