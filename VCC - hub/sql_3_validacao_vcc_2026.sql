-- SQL 3: Validação pós-importação (somente SELECTs)
-- Cliente alvo: eb9aa951-b915-4b09-9c34-072b56afe4e0

-- 1) Total de posts do cliente
SELECT COUNT(*) AS total_posts
FROM posts
WHERE cliente_id = 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid;

-- 2) Distribuição por mês (esperado: Abr 8, Mai 8, Jun 8, Jul 8, Ago 9, Set 10, Out 9, Nov 9, Dez 9, Banco 96)
SELECT mes, COUNT(*) AS qtd
FROM posts
WHERE cliente_id = 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid
GROUP BY mes
ORDER BY
  CASE mes
    WHEN 'Abril' THEN 1
    WHEN 'Maio' THEN 2
    WHEN 'Junho' THEN 3
    WHEN 'Julho' THEN 4
    WHEN 'Agosto' THEN 5
    WHEN 'Setembro' THEN 6
    WHEN 'Outubro' THEN 7
    WHEN 'Novembro' THEN 8
    WHEN 'Dezembro' THEN 9
    WHEN 'Banco' THEN 10
    ELSE 99
  END;

-- 3) Objetivos mensais salvos para 2026
SELECT mes, objetivo, orcamento_anuncios, tipo_anuncio, funil_topo, funil_meio, funil_fundo
FROM objetivos_mes
WHERE cliente_id = 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid
  AND ano = 2026
ORDER BY
  CASE mes
    WHEN 'Abril' THEN 1
    WHEN 'Maio' THEN 2
    WHEN 'Junho' THEN 3
    WHEN 'Julho' THEN 4
    WHEN 'Agosto' THEN 5
    WHEN 'Setembro' THEN 6
    WHEN 'Outubro' THEN 7
    WHEN 'Novembro' THEN 8
    WHEN 'Dezembro' THEN 9
    ELSE 99
  END;
