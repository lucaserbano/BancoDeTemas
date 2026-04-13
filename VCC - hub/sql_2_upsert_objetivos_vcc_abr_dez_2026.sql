-- SQL 2: Upsert dos objetivos mensais (abril a dezembro/2026)
-- Cliente alvo: eb9aa951-b915-4b09-9c34-072b56afe4e0
-- Fonte: levantamento_vcc_temas_objetivos_2026.xlsx (aba Objetivos_Abr-Dez_2026)
BEGIN;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM clientes WHERE id = 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid) THEN
    RAISE EXCEPTION 'cliente_id % nao encontrado na tabela clientes', 'eb9aa951-b915-4b09-9c34-072b56afe4e0';
  END IF;
END $$;

INSERT INTO objetivos_mes (
  cliente_id, mes, ano, objetivo, orcamento_anuncios, tipo_anuncio, datas_importantes, funil_topo, funil_meio, funil_fundo
) VALUES
  ('eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Abril', 2026, 'Lançar o perfil do Valve Care Center, apresentar o posicionamento do time e iniciar reconhecimento de marca local para gerar os primeiros seguidores qualificados.', 'R$ 1.200/mês', 'Reconhecimento de marca + Alcance local (Curitiba e região)', ARRAY['1/abr Início oficial do perfil', '7/abr Dia Mundial da Saúde', '26/abr Dia Nacional de Prevenção e Combate à Hipertensão Arterial']::text[], 60, 30, 10),
  ('eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Maio', 2026, 'Consolidar autoridade em valvopatias e aumentar a familiaridade do público com Heart Team, segunda opinião e jornada do paciente.', 'R$ 1.300/mês', 'Visualização de vídeo + Engajamento', ARRAY['17/mai Dia Mundial da Hipertensão', '31/mai Dia Mundial sem Tabaco']::text[], 60, 30, 10),
  ('eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Junho', 2026, 'Educar sobre sinais de alerta e decisões terapêuticas, transformando alcance em audiência mais qualificada para acompanhamento contínuo.', 'R$ 1.400/mês', 'Engajamento + Tráfego para WhatsApp/Direct', ARRAY['14/jun Dia Mundial do Doador de Sangue', '26/jun Dia Nacional do Diabetes (Brasil)']::text[], 55, 30, 15),
  ('eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Julho', 2026, 'Aprofundar conteúdo técnico em linguagem acessível para fortalecer confiança e preparar audiência para campanhas de intenção no segundo semestre.', 'R$ 1.500/mês', 'Visualização de vídeo + Engajamento qualificado', ARRAY['1/jul Início da campanha de meio de ano', '28/jul Dia Mundial de Luta contra as Hepatites Virais (tema de prevenção em saúde)']::text[], 50, 30, 20),
  ('eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Agosto', 2026, 'Reforçar especialidade em procedimentos e acompanhamento pós-cirúrgico, conectando autoridade médica com geração de demanda para avaliação especializada.', 'R$ 1.700/mês', 'Engajamento + Mensagens (WhatsApp/Direct)', ARRAY['5/ago Dia Nacional da Saúde', '14/ago Dia do Cardiologista']::text[], 45, 35, 20),
  ('eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Setembro', 2026, 'Executar campanha principal do Mês do Coração para pico de alcance e consideração, combinando educação de massa com chamadas para avaliação valvar.', 'R$ 2.500/mês', 'Campanha mista: Alcance + Visualização de vídeo + Mensagens', ARRAY['27/set Dia Nacional da Doação de Órgãos', '29/set Dia Mundial do Coração']::text[], 50, 30, 20),
  ('eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Outubro', 2026, 'Aumentar intenção de consulta com conteúdos de pós-procedimento, segurança clínica e diferenciais do Valve Care Center.', 'R$ 1.900/mês', 'Mensagens + Tráfego para agendamento', ARRAY['16/out Dia Mundial da Alimentação (gancho de prevenção)', '29/out Dia Mundial do AVC']::text[], 40, 35, 25),
  ('eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Novembro', 2026, 'Priorizar conversão: segunda opinião, avaliação especializada e prova social com depoimentos para reduzir objeções de agendamento.', 'R$ 2.100/mês', 'Conversão para mensagens + Remarketing de engajados (90 dias)', ARRAY['14/nov Dia Mundial do Diabetes', '17/nov Dia Mundial de Combate ao Câncer de Próstata']::text[], 35, 30, 35),
  ('eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Dezembro', 2026, 'Fechar o ano com foco em consultas e check-up preventivo para início de 2027, aproveitando audiências quentes acumuladas ao longo do ano.', 'R$ 2.200/mês', 'Mensagens + Remarketing com CTA de agendamento', ARRAY['1/dez Dia Mundial de Luta contra a AIDS (saúde integral)', '31/dez Virada de ano e campanha de check-up 2027']::text[], 30, 30, 40)
ON CONFLICT (cliente_id, mes, ano) DO UPDATE SET
  objetivo          = EXCLUDED.objetivo,
  orcamento_anuncios= EXCLUDED.orcamento_anuncios,
  tipo_anuncio      = EXCLUDED.tipo_anuncio,
  datas_importantes = EXCLUDED.datas_importantes,
  funil_topo        = EXCLUDED.funil_topo,
  funil_meio        = EXCLUDED.funil_meio,
  funil_fundo       = EXCLUDED.funil_fundo;

COMMIT;
