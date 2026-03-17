# Extração de Temas - VCC 2026

- Arquivo origem: `Projeto - Marketing VCC 2026.xlsx`
- Aba origem: `TEMAS`
- Cliente destino: `eb9aa951-b915-4b09-9c34-072b56afe4e0`
- Total de temas extraídos: **174**
- Duplicados por título: **0**
- Incompletos (campos opcionais): **79**
- Não aprovados na planilha: **1**
- Agendados na planilha (sem mês explícito): **8**

## Mapeamento para `posts`

- `titulo` <- `TEMA DA PUBLICAÇÃO`
- `linha` <- `CATEGORIA MKT` (normalizada)
- `subtema` <- `TÓPICO(S) - EDUCAÇÃO` (`-` vira vazio)
- `formato` <- `SUGESTÃO DE FORMATO` (`STORIES`->`Story`, `REELS`->`Reels`, `CARROSSEL`->`Carrossel`)
- `funil` <- derivado da `CATEGORIA MKT` (VENDAS=>FUNDO, EDUCAÇÃO=>MEIO, INSPIRAÇÃO/ENTRETENIMENTO=>TOPO)
- `serie` = `—` | `mes` = `Banco` | `status` = `Ideia` | `likes` = `0` | `comentarios` = `0`
- `gancho` vazio e `orientacoes` preenchido com metadados de origem + marcadores

## Arquivos gerados

- `vcc_temas_supabase_payload.json` (payload completo com metadados e qualidade)
- `vcc_temas_insert_posts.sql` (script idempotente para SQL Editor)
- `vcc_temas_resumo_extracao.md` (este resumo)
