-- Validação consolidada das 18 tabelas do dataset.
-- Consultas que retornam zero linhas indicam ausência da anomalia testada.

CREATE OR REPLACE TEMP VIEW vw_validacao_dataset AS
SELECT 'barcelona'::text AS tabela, 'campanha'::text AS tipo, temporada, jogos::numeric, vitorias::numeric, empates::numeric, derrotas::numeric, gols_feitos::numeric, gols_sofridos::numeric, passes_medios::numeric AS passes, posse::numeric FROM barcelona
UNION ALL
SELECT 'espanha_campeao', 'campanha', temporada, jogos::numeric, vitorias::numeric, empates::numeric, derrotas::numeric, gols_feitos::numeric, gols_sofridos::numeric, passes_medios::numeric, posse::numeric FROM espanha_campeao
UNION ALL
SELECT 'franca_campeao', 'campanha', temporada, jogos::numeric, vitorias::numeric, empates::numeric, derrotas::numeric, gols_feitos::numeric, gols_sofridos::numeric, passes_medios::numeric, posse::numeric FROM franca_campeao
UNION ALL
SELECT 'italia_campeao', 'campanha', temporada, jogos::numeric, vitorias::numeric, empates::numeric, derrotas::numeric, gols_feitos::numeric, gols_sofridos::numeric, passes_medios::numeric, posse::numeric FROM italia_campeao
UNION ALL
SELECT 'alemanha_campeao', 'campanha', temporada, jogos::numeric, vitorias::numeric, empates::numeric, derrotas::numeric, gols_feitos::numeric, gols_sofridos::numeric, passes_medios::numeric, posse::numeric FROM alemanha_campeao
UNION ALL
SELECT 'inglaterra_campeao', 'campanha', temporada, jogos::numeric, vitorias::numeric, empates::numeric, derrotas::numeric, gols_feitos::numeric, gols_sofridos::numeric, passes_medios::numeric, posse::numeric FROM inglaterra_campeao
UNION ALL
SELECT 'espanha_rebaixados', 'campanha', temporada, jogos::numeric, vitorias::numeric, empates::numeric, derrotas::numeric, gols_feitos::numeric, gols_sofridos::numeric, passes_medios::numeric, posse::numeric FROM espanha_rebaixados
UNION ALL
SELECT 'franca_rebaixados', 'campanha', temporada, jogos::numeric, vitorias::numeric, empates::numeric, derrotas::numeric, gols_feitos::numeric, gols_sofridos::numeric, passes_medios::numeric, posse::numeric FROM franca_rebaixados
UNION ALL
SELECT 'italia_rebaixados', 'campanha', temporada, jogos::numeric, vitorias::numeric, empates::numeric, derrotas::numeric, gols_feitos::numeric, gols_sofridos::numeric, passes_medios::numeric, posse::numeric FROM italia_rebaixados
UNION ALL
SELECT 'alemanha_rebaixados', 'campanha', temporada, jogos::numeric, vitorias::numeric, empates::numeric, derrotas::numeric, gols_feitos::numeric, gols_sofridos::numeric, passes_medios::numeric, posse::numeric FROM alemanha_rebaixados
UNION ALL
SELECT 'inglaterra_rebaixados', 'campanha', temporada, jogos::numeric, vitorias::numeric, empates::numeric, derrotas::numeric, gols_feitos::numeric, gols_sofridos::numeric, passes_medios::numeric, posse::numeric FROM inglaterra_rebaixados
UNION ALL
SELECT 'champions_campeao', 'campanha', temporada, jogos::numeric, vitorias::numeric, empates::numeric, derrotas::numeric, gols_feitos::numeric, gols_sofridos::numeric, passes_medios::numeric, posse::numeric FROM champions_campeao
UNION ALL
SELECT 'espanha_media', 'media', temporada, jogos::numeric, NULL::numeric, NULL::numeric, NULL::numeric, gols_feitos::numeric, gols_sofridos::numeric, passes::numeric, posse::numeric FROM espanha_media
UNION ALL
SELECT 'franca_media', 'media', temporada, jogos::numeric, NULL::numeric, NULL::numeric, NULL::numeric, gols_feitos::numeric, gols_sofridos::numeric, passes::numeric, posse::numeric FROM franca_media
UNION ALL
SELECT 'italia_media', 'media', temporada, jogos::numeric, NULL::numeric, NULL::numeric, NULL::numeric, gols_feitos::numeric, gols_sofridos::numeric, passes::numeric, posse::numeric FROM italia_media
UNION ALL
SELECT 'alemanha_media', 'media', temporada, jogos::numeric, NULL::numeric, NULL::numeric, NULL::numeric, gols_feitos::numeric, gols_sofridos::numeric, passes::numeric, posse::numeric FROM alemanha_media
UNION ALL
SELECT 'inglaterra_media', 'media', temporada, jogos::numeric, NULL::numeric, NULL::numeric, NULL::numeric, gols_feitos::numeric, gols_sofridos::numeric, passes::numeric, posse::numeric FROM inglaterra_media
UNION ALL
SELECT 'champions_media_alta', 'media_semifinalistas', temporada, jogos::numeric, NULL::numeric, NULL::numeric, NULL::numeric, gols_feitos::numeric, gols_sofridos::numeric, passes::numeric, posse::numeric FROM champions_media_alta;

-- 1. Resumo estrutural: esperado 16 registros e 16 temporadas por tabela.
SELECT
    tabela,
    COUNT(*) AS registros,
    COUNT(DISTINCT temporada) AS temporadas_distintas,
    MIN(temporada) AS primeira_temporada,
    MAX(temporada) AS ultima_temporada
FROM vw_validacao_dataset
GROUP BY tabela
ORDER BY tabela;

-- 2. Tabelas fora do padrão estrutural esperado.
SELECT tabela, COUNT(*) AS registros, COUNT(DISTINCT temporada) AS temporadas_distintas
FROM vw_validacao_dataset
GROUP BY tabela
HAVING COUNT(*) <> 16 OR COUNT(DISTINCT temporada) <> 16;

-- 3. Temporadas duplicadas.
SELECT tabela, temporada, COUNT(*) AS ocorrencias
FROM vw_validacao_dataset
GROUP BY tabela, temporada
HAVING COUNT(*) > 1;

-- 4. Valores nulos em campos essenciais.
SELECT *
FROM vw_validacao_dataset
WHERE temporada IS NULL
   OR jogos IS NULL
   OR gols_feitos IS NULL
   OR gols_sofridos IS NULL
   OR passes IS NULL
   OR posse IS NULL
   OR (tipo = 'campanha' AND (vitorias IS NULL OR empates IS NULL OR derrotas IS NULL));

-- 5. Valores negativos.
SELECT *
FROM vw_validacao_dataset
WHERE jogos < 0
   OR COALESCE(vitorias, 0) < 0
   OR COALESCE(empates, 0) < 0
   OR COALESCE(derrotas, 0) < 0
   OR gols_feitos < 0
   OR gols_sofridos < 0
   OR passes < 0
   OR posse < 0;

-- 6. Posse fora do intervalo percentual.
SELECT tabela, temporada, posse
FROM vw_validacao_dataset
WHERE posse < 0 OR posse > 100;

-- 7. Inconsistência entre jogos e resultados nas tabelas de campanha.
SELECT tabela, temporada, jogos, vitorias, empates, derrotas,
       (vitorias + empates + derrotas) AS total_resultados
FROM vw_validacao_dataset
WHERE tipo = 'campanha'
  AND (vitorias + empates + derrotas) <> jogos;

-- 8. Fronteiras numéricas observadas.
SELECT
    MIN(jogos) AS min_jogos, MAX(jogos) AS max_jogos,
    MIN(gols_feitos) AS min_gols_feitos, MAX(gols_feitos) AS max_gols_feitos,
    MIN(gols_sofridos) AS min_gols_sofridos, MAX(gols_sofridos) AS max_gols_sofridos,
    MIN(passes) AS min_passes, MAX(passes) AS max_passes,
    MIN(posse) AS min_posse, MAX(posse) AS max_posse
FROM vw_validacao_dataset;

-- 9. Métrica inicial do Barcelona.
SELECT temporada, tecnico, jogos, vitorias,
       ROUND((vitorias::numeric / jogos::numeric) * 100, 2) AS percentual_vitorias
FROM barcelona
ORDER BY temporada;

DROP VIEW vw_validacao_dataset;
