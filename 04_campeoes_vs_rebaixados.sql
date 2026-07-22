-- ============================================================
-- TCC - ANÁLISE DO MODELO DO BARCELONA
-- DOCUMENTAÇÃO SQL - ETAPA 04
-- CAMPEÕES VS REBAIXADOS
-- Ambiente: PostgreSQL / DBeaver
-- Tabelas utilizadas: campeões e rebaixados das cinco grandes ligas
-- ============================================================


-- 1. Comparação geral: campeões vs rebaixados da Espanha

SELECT
    c.temporada,
    'Espanha' AS liga,
    c.campeao,
    c.posse AS posse_campeao,
    r.posse AS posse_rebaixados,
    ROUND((c.posse - r.posse)::numeric, 2) AS diferenca_posse,
    c.passes_medios AS passes_campeao,
    r.passes_medios AS passes_rebaixados,
    ROUND((c.passes_medios - r.passes_medios)::numeric, 2) AS diferenca_passes,
    c.gols_feitos AS gols_feitos_campeao,
    r.gols_feitos AS gols_feitos_rebaixados,
    ROUND((c.gols_feitos - r.gols_feitos)::numeric, 2) AS diferenca_gols_feitos,
    c.gols_sofridos AS gols_sofridos_campeao,
    r.gols_sofridos AS gols_sofridos_rebaixados,
    ROUND((c.gols_sofridos - r.gols_sofridos)::numeric, 2) AS diferenca_gols_sofridos
FROM espanha_campeao c
JOIN espanha_rebaixados r
    ON c.temporada = r.temporada
ORDER BY c.temporada;


-- 2. Comparação geral: campeões vs rebaixados da França

SELECT
    c.temporada,
    'França' AS liga,
    c.campeao,
    c.posse AS posse_campeao,
    r.posse AS posse_rebaixados,
    ROUND((c.posse - r.posse)::numeric, 2) AS diferenca_posse,
    c.passes_medios AS passes_campeao,
    r.passes_medios AS passes_rebaixados,
    ROUND((c.passes_medios - r.passes_medios)::numeric, 2) AS diferenca_passes,
    c.gols_feitos AS gols_feitos_campeao,
    r.gols_feitos AS gols_feitos_rebaixados,
    ROUND((c.gols_feitos - r.gols_feitos)::numeric, 2) AS diferenca_gols_feitos,
    c.gols_sofridos AS gols_sofridos_campeao,
    r.gols_sofridos AS gols_sofridos_rebaixados,
    ROUND((c.gols_sofridos - r.gols_sofridos)::numeric, 2) AS diferenca_gols_sofridos
FROM franca_campeao c
JOIN franca_rebaixados r
    ON c.temporada = r.temporada
ORDER BY c.temporada;


-- 3. Comparação geral: campeões vs rebaixados da Itália

SELECT
    c.temporada,
    'Itália' AS liga,
    c.campeao,
    c.posse AS posse_campeao,
    r.posse AS posse_rebaixados,
    ROUND((c.posse - r.posse)::numeric, 2) AS diferenca_posse,
    c.passes_medios AS passes_campeao,
    r.passes_medios AS passes_rebaixados,
    ROUND((c.passes_medios - r.passes_medios)::numeric, 2) AS diferenca_passes,
    c.gols_feitos AS gols_feitos_campeao,
    r.gols_feitos AS gols_feitos_rebaixados,
    ROUND((c.gols_feitos - r.gols_feitos)::numeric, 2) AS diferenca_gols_feitos,
    c.gols_sofridos AS gols_sofridos_campeao,
    r.gols_sofridos AS gols_sofridos_rebaixados,
    ROUND((c.gols_sofridos - r.gols_sofridos)::numeric, 2) AS diferenca_gols_sofridos
FROM italia_campeao c
JOIN italia_rebaixados r
    ON c.temporada = r.temporada
ORDER BY c.temporada;


-- 4. Comparação geral: campeões vs rebaixados da Alemanha

SELECT
    c.temporada,
    'Alemanha' AS liga,
    c.campeao,
    c.posse AS posse_campeao,
    r.posse AS posse_rebaixados,
    ROUND((c.posse - r.posse)::numeric, 2) AS diferenca_posse,
    c.passes_medios AS passes_campeao,
    r.passes_medios AS passes_rebaixados,
    ROUND((c.passes_medios - r.passes_medios)::numeric, 2) AS diferenca_passes,
    c.gols_feitos AS gols_feitos_campeao,
    r.gols_feitos AS gols_feitos_rebaixados,
    ROUND((c.gols_feitos - r.gols_feitos)::numeric, 2) AS diferenca_gols_feitos,
    c.gols_sofridos AS gols_sofridos_campeao,
    r.gols_sofridos AS gols_sofridos_rebaixados,
    ROUND((c.gols_sofridos - r.gols_sofridos)::numeric, 2) AS diferenca_gols_sofridos
FROM alemanha_campeao c
JOIN alemanha_rebaixados r
    ON c.temporada = r.temporada
ORDER BY c.temporada;


-- 5. Comparação geral: campeões vs rebaixados da Inglaterra

SELECT
    c.temporada,
    'Inglaterra' AS liga,
    c.campeao,
    c.posse AS posse_campeao,
    r.posse AS posse_rebaixados,
    ROUND((c.posse - r.posse)::numeric, 2) AS diferenca_posse,
    c.passes_medios AS passes_campeao,
    r.passes_medios AS passes_rebaixados,
    ROUND((c.passes_medios - r.passes_medios)::numeric, 2) AS diferenca_passes,
    c.gols_feitos AS gols_feitos_campeao,
    r.gols_feitos AS gols_feitos_rebaixados,
    ROUND((c.gols_feitos - r.gols_feitos)::numeric, 2) AS diferenca_gols_feitos,
    c.gols_sofridos AS gols_sofridos_campeao,
    r.gols_sofridos AS gols_sofridos_rebaixados,
    ROUND((c.gols_sofridos - r.gols_sofridos)::numeric, 2) AS diferenca_gols_sofridos
FROM inglaterra_campeao c
JOIN inglaterra_rebaixados r
    ON c.temporada = r.temporada
ORDER BY c.temporada;


-- 6. Base unificada: campeões vs rebaixados das cinco grandes ligas
-- Reúne todas as ligas em uma única visão comparativa.

WITH comparativo AS (
    SELECT
        c.temporada,
        'Espanha' AS liga,
        c.campeao,
        c.jogos,
        c.vitorias,
        c.empates,
        c.derrotas,
        c.gols_feitos AS gols_feitos_campeao,
        r.gols_feitos AS gols_feitos_rebaixados,
        c.gols_sofridos AS gols_sofridos_campeao,
        r.gols_sofridos AS gols_sofridos_rebaixados,
        c.passes_medios AS passes_campeao,
        r.passes_medios AS passes_rebaixados,
        c.posse AS posse_campeao,
        r.posse AS posse_rebaixados
    FROM espanha_campeao c
    JOIN espanha_rebaixados r ON c.temporada = r.temporada

    UNION ALL

    SELECT
        c.temporada,
        'França',
        c.campeao,
        c.jogos,
        c.vitorias,
        c.empates,
        c.derrotas,
        c.gols_feitos,
        r.gols_feitos,
        c.gols_sofridos,
        r.gols_sofridos,
        c.passes_medios,
        r.passes_medios,
        c.posse,
        r.posse
    FROM franca_campeao c
    JOIN franca_rebaixados r ON c.temporada = r.temporada

    UNION ALL

    SELECT
        c.temporada,
        'Itália',
        c.campeao,
        c.jogos,
        c.vitorias,
        c.empates,
        c.derrotas,
        c.gols_feitos,
        r.gols_feitos,
        c.gols_sofridos,
        r.gols_sofridos,
        c.passes_medios,
        r.passes_medios,
        c.posse,
        r.posse
    FROM italia_campeao c
    JOIN italia_rebaixados r ON c.temporada = r.temporada

    UNION ALL

    SELECT
        c.temporada,
        'Alemanha',
        c.campeao,
        c.jogos,
        c.vitorias,
        c.empates,
        c.derrotas,
        c.gols_feitos,
        r.gols_feitos,
        c.gols_sofridos,
        r.gols_sofridos,
        c.passes_medios,
        r.passes_medios,
        c.posse,
        r.posse
    FROM alemanha_campeao c
    JOIN alemanha_rebaixados r ON c.temporada = r.temporada

    UNION ALL

    SELECT
        c.temporada,
        'Inglaterra',
        c.campeao,
        c.jogos,
        c.vitorias,
        c.empates,
        c.derrotas,
        c.gols_feitos,
        r.gols_feitos,
        c.gols_sofridos,
        r.gols_sofridos,
        c.passes_medios,
        r.passes_medios,
        c.posse,
        r.posse
    FROM inglaterra_campeao c
    JOIN inglaterra_rebaixados r ON c.temporada = r.temporada
)

SELECT
    temporada,
    liga,
    campeao,
    ROUND((vitorias::numeric / jogos::numeric) * 100, 2) AS percentual_vitorias_campeao,
    posse_campeao,
    posse_rebaixados,
    ROUND((posse_campeao - posse_rebaixados)::numeric, 2) AS diferenca_posse,
    passes_campeao,
    passes_rebaixados,
    ROUND((passes_campeao - passes_rebaixados)::numeric, 2) AS diferenca_passes,
    gols_feitos_campeao,
    gols_feitos_rebaixados,
    ROUND((gols_feitos_campeao - gols_feitos_rebaixados)::numeric, 2) AS diferenca_gols_feitos,
    gols_sofridos_campeao,
    gols_sofridos_rebaixados,
    ROUND((gols_sofridos_campeao - gols_sofridos_rebaixados)::numeric, 2) AS diferenca_gols_sofridos
FROM comparativo
ORDER BY liga, temporada;


-- 7. Médias gerais: campeões vs rebaixados por liga

WITH comparativo AS (
    SELECT 'Espanha' AS liga, c.posse AS posse_campeao, r.posse AS posse_rebaixados, c.passes_medios AS passes_campeao, r.passes_medios AS passes_rebaixados, c.gols_feitos AS gols_feitos_campeao, r.gols_feitos AS gols_feitos_rebaixados, c.gols_sofridos AS gols_sofridos_campeao, r.gols_sofridos AS gols_sofridos_rebaixados FROM espanha_campeao c JOIN espanha_rebaixados r ON c.temporada = r.temporada
    UNION ALL
    SELECT 'França', c.posse, r.posse, c.passes_medios, r.passes_medios, c.gols_feitos, r.gols_feitos, c.gols_sofridos, r.gols_sofridos FROM franca_campeao c JOIN franca_rebaixados r ON c.temporada = r.temporada
    UNION ALL
    SELECT 'Itália', c.posse, r.posse, c.passes_medios, r.passes_medios, c.gols_feitos, r.gols_feitos, c.gols_sofridos, r.gols_sofridos FROM italia_campeao c JOIN italia_rebaixados r ON c.temporada = r.temporada
    UNION ALL
    SELECT 'Alemanha', c.posse, r.posse, c.passes_medios, r.passes_medios, c.gols_feitos, r.gols_feitos, c.gols_sofridos, r.gols_sofridos FROM alemanha_campeao c JOIN alemanha_rebaixados r ON c.temporada = r.temporada
    UNION ALL
    SELECT 'Inglaterra', c.posse, r.posse, c.passes_medios, r.passes_medios, c.gols_feitos, r.gols_feitos, c.gols_sofridos, r.gols_sofridos FROM inglaterra_campeao c JOIN inglaterra_rebaixados r ON c.temporada = r.temporada
)

SELECT
    liga,
    ROUND(AVG(posse_campeao)::numeric, 2) AS media_posse_campeao,
    ROUND(AVG(posse_rebaixados)::numeric, 2) AS media_posse_rebaixados,
    ROUND(AVG(posse_campeao - posse_rebaixados)::numeric, 2) AS diferenca_media_posse,
    ROUND(AVG(passes_campeao)::numeric, 2) AS media_passes_campeao,
    ROUND(AVG(passes_rebaixados)::numeric, 2) AS media_passes_rebaixados,
    ROUND(AVG(passes_campeao - passes_rebaixados)::numeric, 2) AS diferenca_media_passes,
    ROUND(AVG(gols_feitos_campeao)::numeric, 2) AS media_gols_feitos_campeao,
    ROUND(AVG(gols_feitos_rebaixados)::numeric, 2) AS media_gols_feitos_rebaixados,
    ROUND(AVG(gols_sofridos_campeao)::numeric, 2) AS media_gols_sofridos_campeao,
    ROUND(AVG(gols_sofridos_rebaixados)::numeric, 2) AS media_gols_sofridos_rebaixados
FROM comparativo
GROUP BY liga
ORDER BY liga;


-- 8. Média geral das cinco ligas
-- Consolida o comportamento médio entre topo e parte inferior.

WITH comparativo AS (
    SELECT c.posse AS posse_campeao, r.posse AS posse_rebaixados, c.passes_medios AS passes_campeao, r.passes_medios AS passes_rebaixados, c.gols_feitos AS gols_feitos_campeao, r.gols_feitos AS gols_feitos_rebaixados, c.gols_sofridos AS gols_sofridos_campeao, r.gols_sofridos AS gols_sofridos_rebaixados FROM espanha_campeao c JOIN espanha_rebaixados r ON c.temporada = r.temporada
    UNION ALL
    SELECT c.posse, r.posse, c.passes_medios, r.passes_medios, c.gols_feitos, r.gols_feitos, c.gols_sofridos, r.gols_sofridos FROM franca_campeao c JOIN franca_rebaixados r ON c.temporada = r.temporada
    UNION ALL
    SELECT c.posse, r.posse, c.passes_medios, r.passes_medios, c.gols_feitos, r.gols_feitos, c.gols_sofridos, r.gols_sofridos FROM italia_campeao c JOIN italia_rebaixados r ON c.temporada = r.temporada
    UNION ALL
    SELECT c.posse, r.posse, c.passes_medios, r.passes_medios, c.gols_feitos, r.gols_feitos, c.gols_sofridos, r.gols_sofridos FROM alemanha_campeao c JOIN alemanha_rebaixados r ON c.temporada = r.temporada
    UNION ALL
    SELECT c.posse, r.posse, c.passes_medios, r.passes_medios, c.gols_feitos, r.gols_feitos, c.gols_sofridos, r.gols_sofridos FROM inglaterra_campeao c JOIN inglaterra_rebaixados r ON c.temporada = r.temporada
)

SELECT
    ROUND(AVG(posse_campeao)::numeric, 2) AS media_geral_posse_campeoes,
    ROUND(AVG(posse_rebaixados)::numeric, 2) AS media_geral_posse_rebaixados,
    ROUND(AVG(posse_campeao - posse_rebaixados)::numeric, 2) AS diferenca_geral_posse,
    ROUND(AVG(passes_campeao)::numeric, 2) AS media_geral_passes_campeoes,
    ROUND(AVG(passes_rebaixados)::numeric, 2) AS media_geral_passes_rebaixados,
    ROUND(AVG(passes_campeao - passes_rebaixados)::numeric, 2) AS diferenca_geral_passes,
    ROUND(AVG(gols_feitos_campeao)::numeric, 2) AS media_geral_gols_feitos_campeoes,
    ROUND(AVG(gols_feitos_rebaixados)::numeric, 2) AS media_geral_gols_feitos_rebaixados,
    ROUND(AVG(gols_sofridos_campeao)::numeric, 2) AS media_geral_gols_sofridos_campeoes,
    ROUND(AVG(gols_sofridos_rebaixados)::numeric, 2) AS media_geral_gols_sofridos_rebaixados
FROM comparativo;


-- 9. Visão final para exportação ao Python
-- Base pronta para gráficos de campeões vs rebaixados.

WITH comparativo AS (
    SELECT c.temporada, 'Espanha' AS liga, c.campeao, c.posse AS posse_campeao, r.posse AS posse_rebaixados, c.passes_medios AS passes_campeao, r.passes_medios AS passes_rebaixados, c.gols_feitos AS gols_feitos_campeao, r.gols_feitos AS gols_feitos_rebaixados, c.gols_sofridos AS gols_sofridos_campeao, r.gols_sofridos AS gols_sofridos_rebaixados FROM espanha_campeao c JOIN espanha_rebaixados r ON c.temporada = r.temporada
    UNION ALL
    SELECT c.temporada, 'França', c.campeao, c.posse, r.posse, c.passes_medios, r.passes_medios, c.gols_feitos, r.gols_feitos, c.gols_sofridos, r.gols_sofridos FROM franca_campeao c JOIN franca_rebaixados r ON c.temporada = r.temporada
    UNION ALL
    SELECT c.temporada, 'Itália', c.campeao, c.posse, r.posse, c.passes_medios, r.passes_medios, c.gols_feitos, r.gols_feitos, c.gols_sofridos, r.gols_sofridos FROM italia_campeao c JOIN italia_rebaixados r ON c.temporada = r.temporada
    UNION ALL
    SELECT c.temporada, 'Alemanha', c.campeao, c.posse, r.posse, c.passes_medios, r.passes_medios, c.gols_feitos, r.gols_feitos, c.gols_sofridos, r.gols_sofridos FROM alemanha_campeao c JOIN alemanha_rebaixados r ON c.temporada = r.temporada
    UNION ALL
    SELECT c.temporada, 'Inglaterra', c.campeao, c.posse, r.posse, c.passes_medios, r.passes_medios, c.gols_feitos, r.gols_feitos, c.gols_sofridos, r.gols_sofridos FROM inglaterra_campeao c JOIN inglaterra_rebaixados r ON c.temporada = r.temporada
)

SELECT
    temporada,
    liga,
    campeao,
    posse_campeao,
    posse_rebaixados,
    ROUND((posse_campeao - posse_rebaixados)::numeric, 2) AS diferenca_posse,
    passes_campeao,
    passes_rebaixados,
    ROUND((passes_campeao - passes_rebaixados)::numeric, 2) AS diferenca_passes,
    gols_feitos_campeao,
    gols_feitos_rebaixados,
    ROUND((gols_feitos_campeao - gols_feitos_rebaixados)::numeric, 2) AS diferenca_gols_feitos,
    gols_sofridos_campeao,
    gols_sofridos_rebaixados,
    ROUND((gols_sofridos_campeao - gols_sofridos_rebaixados)::numeric, 2) AS diferenca_gols_sofridos
FROM comparativo
ORDER BY liga, temporada;
