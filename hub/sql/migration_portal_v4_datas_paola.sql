-- =============================================
-- MIGRAÇÃO v4: Objetivos mensais completos — Paôla Cardoso Preto
-- Execute no Supabase SQL Editor
-- (Dashboard → SQL Editor → New query → cole e rode)
--
-- Cliente: d466bf18-1f39-47b8-91ee-5aa8696b16db
-- Fonte: CLAUDE.md — Estratégia Editorial 2026
-- Publicações começam em ABRIL 2026
-- =============================================

BEGIN;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM clientes WHERE id = 'd466bf18-1f39-47b8-91ee-5aa8696b16db'::uuid) THEN
    RAISE EXCEPTION 'cliente_id % nao encontrado', 'd466bf18-1f39-47b8-91ee-5aa8696b16db';
  END IF;
END $$;


INSERT INTO objetivos_mes (
  cliente_id, mes, ano,
  objetivo, orcamento_anuncios, tipo_anuncio,
  datas_importantes,
  funil_topo, funil_meio, funil_fundo
) VALUES

  -- ── ABRIL ──────────────────────────────────────────────────
  -- Lançamento + Dia Mundial da Saúde 7/abr
  -- Posts: Apresentação SP (Conv) · Checkup (MEV) · MAPA (MEV) · Diferenciais IC/Tx (Conv)
  (
    'd466bf18-1f39-47b8-91ee-5aa8696b16db'::uuid, 'Abril', 2026,
    'Lançar a nova fase do perfil em SP: apresentar a Dra. Paôla, seus diferenciais em IC avançada e transplante, e iniciar geração de audiência qualificada com conteúdo de checkup e hipertensão.',
    'R$ 250–350',
    'Reconhecimento de marca (alcance) — mês de lançamento',
    ARRAY[
      '7/abr — Dia Mundial da Saúde (OMS) — gancho para checkup e prevenção cardiovascular',
      'ISHLT 2026 — 21–25/abr · Toronto, Canadá (46º encontro anual — principal congresso mundial de transplante cardíaco)'
    ]::text[],
    50, 30, 20
  ),

  -- ── MAIO ───────────────────────────────────────────────────
  -- Saúde da mulher + Dia das Mães 10/mai
  -- Posts: Saúde cardiovascular da mulher (MEV) · Arritmias e IC (MEV) · Cuidar = presente (Conv) · Congresso/corrida (Hum)
  (
    'd466bf18-1f39-47b8-91ee-5aa8696b16db'::uuid, 'Maio', 2026,
    'Explorar o eixo saúde cardiovascular feminina e Dia das Mães como ganchos emocionais. Educação sobre arritmias e IC. Um post de conversão com apelo emocional ("cuidar da saúde = o melhor presente").',
    'R$ 100–150',
    'Engajamento',
    ARRAY[
      '10/mai — Dia das Mães — gancho emocional para post de conversão',
      'ESC Heart Failure Congress 2026 — 9–12/mai · Barcelona, Espanha (maior congresso mundial dedicado à IC — tema: "Evolution in Heart Failure")',
      'HFA Heart Failure Awareness Days — 27/abr–3/mai (semana europeia de conscientização sobre IC — ESC/HFA)'
    ]::text[],
    60, 30, 10
  ),

  -- ── JUNHO ──────────────────────────────────────────────────
  -- Exercício físico e cardiologia
  -- Posts: Por que cardiologista prescreve exercício? (MEV) · VO2max (MEV) · Qualidade pós-Tx (Causa) · Onde atendo (Conv)
  (
    'd466bf18-1f39-47b8-91ee-5aa8696b16db'::uuid, 'Junho', 2026,
    'Posicionar exercício físico como prescrição médica e pilar da saúde cardiovascular. Mostrar qualidade de vida pós-transplante como resultado positivo. Post de conversão com localização dos consultórios em SP.',
    'R$ 150–200',
    'Mensagens (WhatsApp)',
    ARRAY[
      'SOCESP 2026 — 4–6/jun · São Paulo, SP (46º Congresso de Cardiologia do Estado de SP)'
    ]::text[],
    50, 30, 20
  ),

  -- ── JULHO ──────────────────────────────────────────────────
  -- Posicionamento profissional + IC avançada
  -- Posts: IC avançada — Quarteto Fantástico (MEV) · Colesterol e aterosclerose (MEV) · 1ª consulta (Conv) · Congresso (Hum)
  (
    'd466bf18-1f39-47b8-91ee-5aa8696b16db'::uuid, 'Julho', 2026,
    'Aprofundar posicionamento em IC avançada com o tema Quarteto Fantástico (medicamentos de base). Educação sobre colesterol e aterosclerose. Post de conversão sobre o que esperar da primeira consulta.',
    'R$ 100–150',
    'Engajamento',
    ARRAY[
      'DEIC 2026 — 2–4/jul · Porto Alegre, RS (Congresso Brasileiro de Insuficiência Cardíaca — Depto. de IC da SBC)',
      '9/jul — Dia Nacional de Alerta Contra a Insuficiência Cardíaca (SBC/DEIC)'
    ]::text[],
    55, 30, 15
  ),

  -- ── AGOSTO ─────────────────────────────────────────────────
  -- Fatores de risco cardiovascular + aquecimento para setembro
  -- Posts: Dieta DASH (MEV) · Sono e coração (MEV) · Fila espera transplante (Causa) · Por que especialista em IC (Conv)
  (
    'd466bf18-1f39-47b8-91ee-5aa8696b16db'::uuid, 'Agosto', 2026,
    'Trabalhar fatores de risco modificáveis (alimentação e sono) como aquecimento para o Mês do Coração. Humanizar a fila de espera por transplante. Post de conversão reforçando o porquê de consultar especialista em IC avançada.',
    'R$ 100–150',
    'Reconhecimento de marca (alcance)',
    ARRAY[
      '8/ago — Dia Nacional de Prevenção e Controle do Colesterol (gancho para MEV: dieta DASH, aterosclerose)',
      '14/ago — Dia do Cardiologista (oportunidade de humanização ou conversão)'
    ]::text[],
    55, 30, 15
  ),

  -- ── SETEMBRO ⭐ ─────────────────────────────────────────────
  -- Campanha Mês do Coração — maior investimento do ano
  -- Posts: Abertura Mês do Coração (Causa) · Como preservar o coração (MEV) · 27/set Doação (Causa) · 29/set Coração (Conv) + Bônus
  (
    'd466bf18-1f39-47b8-91ee-5aa8696b16db'::uuid, 'Setembro', 2026,
    'Campanha completa do Mês do Coração: maior investimento em anúncios do ano. Combinar educação cardiovascular, conscientização sobre doação de órgãos e conversão no Dia Mundial do Coração (29/set). Post bônus de engajamento ("Você é doador?").',
    'R$ 400–600',
    'Campanha mista: Reconhecimento de marca (alcance) + Mensagens (WhatsApp)',
    ARRAY[
      '27/set — Dia Nacional da Doação de Órgãos (Lei 11.584/2007) — post central sobre transplante cardíaco',
      '29/set — Dia Mundial do Coração (World Heart Day · WHF) — post de conversão âncora do mês'
    ]::text[],
    50, 30, 20
  ),

  -- ── OUTUBRO ────────────────────────────────────────────────
  -- Reconversão pós-campanha
  -- Posts: Miocardiopatias (MEV) · Medicamentos cardiológicos (MEV) · Resultados do Tx (Causa) · Q&A seguidores (Conv)
  (
    'd466bf18-1f39-47b8-91ee-5aa8696b16db'::uuid, 'Outubro', 2026,
    'Aproveitar a audiência aquecida pelo Mês do Coração para reconverter seguidores em consultas. Q&A como formato de conversão com baixo custo de produção. Educação sobre miocardiopatias e medicamentos.',
    'R$ 150–200',
    'Mensagens (WhatsApp)',
    ARRAY[
      'SBC 2026 — 8–10/out · Rio de Janeiro, RJ (81º Congresso Brasileiro de Cardiologia + World Congress of Cardiology — edição histórica)',
      'HFSA 2026 — 9–12/out · Phoenix, EUA (Annual Scientific Meeting da Heart Failure Society of America)',
      'CBMEV 2026 — 22–24/out · São Paulo, SP (IX Congresso Brasileiro de Medicina do Estilo de Vida — nicho central da Paôla)'
    ]::text[],
    50, 30, 20
  ),

  -- ── NOVEMBRO ───────────────────────────────────────────────
  -- Prevenção — saúde preventiva
  -- Posts: Tabagismo e coração (MEV) · Teste ergométrico (MEV) · Aniversário/congresso (Hum) · Por que me escolher (Conv)
  (
    'd466bf18-1f39-47b8-91ee-5aa8696b16db'::uuid, 'Novembro', 2026,
    'Reforçar prevenção cardiovascular com tabagismo e teste ergométrico. Post de humanização (aniversário da Paôla ou congresso). Post de conversão direto: "Por que me escolher como sua cardiologista".',
    'R$ 150–200',
    'Mensagens (WhatsApp)',
    ARRAY[
      'ACLM 2026 — 8–11/nov · Orlando, EUA (Conferência Anual do American College of Lifestyle Medicine — disponível também online)',
      '12/nov — Dia Nacional de Prevenção das Arritmias Cardíacas e da Morte Súbita'
    ]::text[],
    50, 30, 20
  ),

  -- ── DEZEMBRO ───────────────────────────────────────────────
  -- Fechamento + cuidados nas festas
  -- Posts: Coração nas festas: álcool/sal/estresse (MEV) · Coração artificial como ponte ao Tx (Causa) · Retrospectiva (Hum) · Checkup 2027 (Conv)
  (
    'd466bf18-1f39-47b8-91ee-5aa8696b16db'::uuid, 'Dezembro', 2026,
    'Fechar o ano com conteúdo de cuidados nas festas (álcool, sal, estresse) e retrospectiva 2026. Post de Causa sobre coração artificial como ponte ao transplante. CTA de fim de ano: "Agende seu checkup para 2027".',
    'R$ 150–200',
    'Mensagens (WhatsApp)',
    ARRAY[]::text[],
    50, 30, 20
  )

ON CONFLICT (cliente_id, mes, ano) DO UPDATE SET
  objetivo           = EXCLUDED.objetivo,
  orcamento_anuncios = EXCLUDED.orcamento_anuncios,
  tipo_anuncio       = EXCLUDED.tipo_anuncio,
  datas_importantes  = EXCLUDED.datas_importantes,
  funil_topo         = EXCLUDED.funil_topo,
  funil_meio         = EXCLUDED.funil_meio,
  funil_fundo        = EXCLUDED.funil_fundo;


COMMIT;


-- ============================================================
-- RESUMO — Paôla 2026
-- ============================================================
--
-- Mês  | Foco                              | Orçamento    | Funil T/M/F
-- -----|-----------------------------------|--------------|------------
-- Abr  | Lançamento + Dia Mundial da Saúde | R$ 250–350   | 50/30/20
-- Mai  | Saúde da mulher + Dia das Mães    | R$ 100–150   | 60/30/10
-- Jun  | Exercício físico e cardiologia    | R$ 150–200   | 50/30/20
-- Jul  | IC avançada + posicionamento      | R$ 100–150   | 55/30/15
-- Ago  | Fatores de risco + aquecimento    | R$ 100–150   | 55/30/15
-- Set⭐ | Campanha Mês do Coração           | R$ 400–600   | 50/30/20
-- Out  | Reconversão pós-campanha          | R$ 150–200   | 50/30/20
-- Nov  | Prevenção + saúde preventiva      | R$ 150–200   | 50/30/20
-- Dez  | Fechamento + checkup 2027         | R$ 150–200   | 50/30/20
-- -----|-----------------------------------|--------------|------------
-- TOT  |                                   | R$1.550–2.150|
-- ============================================================
