-- ============================================================
-- TCC - ANÁLISE DO MODELO DO BARCELONA
-- DOCUMENTAÇÃO SQL - ETAPA 03
-- BARCELONA VS MÉDIA DA ESPANHA
-- Ambiente: PostgreSQL / DBeaver
-- Tabelas utilizadas: barcelona, espanha_media
-- ============================================================


-- 1. Visão comparativa geral
-- Compara Barcelona e média da liga espanhola por temporada.

SELECT
    b.temporada,
    b.tecnico,
    b.posse AS posse_barcelona,
    e.posse AS posse_media_espanha,
    b.passes_medios AS passes_barcelona,
    e.passes AS passes_media_espanha,
    b.gols_feitos AS gols_feitos_barcelona,
    e.gols_feitos AS gols_feitos_media_espanha,
    b.gols_sofridos AS gols_sofridos_barcelona,
    e.gols_sofridos AS gols_sofridos_media_espanha
FROM barcelona b
JOIN espanha_media e
    ON b.temporada = e.temporada
ORDER BY b.temporada;


-- 2. Diferença entre Barcelona e média da Espanha
-- Calcula quanto o Barcelona ficou acima ou abaixo da média da liga.

SELECT
    b.temporada,
    b.tecnico,
    ROUND((b.posse - e.posse)::numeric, 2) AS diferenca_posse,
    ROUND((b.passes_medios - e.passes)::numeric, 2) AS diferenca_passes,
    ROUND((b.gols_feitos - e.gols_feitos)::numeric, 2) AS diferenca_gols_feitos,
    ROUND((b.gols_sofridos - e.gols_sofridos)::numeric, 2) AS diferenca_gols_sofridos
FROM barcelona b
JOIN espanha_media e
    ON b.temporada = e.temporada
ORDER BY b.temporada;


-- 3. Temporadas em que o Barcelona mais superou a liga em posse

SELECT
    b.temporada,
    b.tecnico,
    b.posse AS posse_barcelona,
    e.posse AS posse_media_espanha,
    ROUND((b.posse - e.posse)::numeric, 2) AS diferenca_posse
FROM barcelona b
JOIN espanha_media e
    ON b.temporada = e.temporada
ORDER BY diferenca_posse DESC
LIMIT 5;


-- 4. Temporadas em que o Barcelona mais superou a liga em passes

SELECT
    b.temporada,
    b.tecnico,
    b.passes_medios AS passes_barcelona,
    e.passes AS passes_media_espanha,
    ROUND((b.passes_medios - e.passes)::numeric, 2) AS diferenca_passes
FROM barcelona b
JOIN espanha_media e
    ON b.temporada = e.temporada
ORDER BY diferenca_passes DESC
LIMIT 5;


-- 5. Comparação por era
-- Agrupa a diferença entre Barcelona e média espanhola por fase histórica.

WITH barca_vs_espanha AS (
    SELECT
        b.temporada,
        b.tecnico,
        CASE
            WHEN b.tecnico = 'rijkaard' THEN 'Rijkaard'
            WHEN b.tecnico = 'guardiola' THEN 'Guardiola'
            WHEN b.tecnico IN ('tito vilanova', 'gerardo martino') THEN 'Pós-Guardiola'
            WHEN b.tecnico = 'luis enrique' THEN 'Luis Enrique'
            WHEN b.tecnico IN ('ernesto valverde', 'quique setien') THEN 'Transição Moderna'
            ELSE 'Outro'
        END AS era,
        CASE
            WHEN b.tecnico = 'rijkaard' THEN 1
            WHEN b.tecnico = 'guardiola' THEN 2
            WHEN b.tecnico IN ('tito vilanova', 'gerardo martino') THEN 3
            WHEN b.tecnico = 'luis enrique' THEN 4
            WHEN b.tecnico IN ('ernesto valverde', 'quique setien') THEN 5
            ELSE 6
        END AS ordem_era,
        b.posse AS posse_barcelona,
        e.posse AS posse_media_espanha,
        b.passes_medios AS passes_barcelona,
        e.passes AS passes_media_espanha,
        b.gols_feitos AS gols_feitos_barcelona,
        e.gols_feitos AS gols_feitos_media_espanha,
        b.gols_sofridos AS gols_sofridos_barcelona,
        e.gols_sofridos AS gols_sofridos_media_espanha
    FROM barcelona b
    JOIN espanha_media e
        ON b.temporada = e.temporada
)

SELECT
    era,
    COUNT(*) AS temporadas,
    ROUND(AVG(posse_barcelona)::numeric, 2) AS media_posse_barcelona,
    ROUND(AVG(posse_media_espanha)::numeric, 2) AS media_posse_espanha,
    ROUND(AVG(posse_barcelona - posse_media_espanha)::numeric, 2) AS diferenca_media_posse,
    ROUND(AVG(passes_barcelona)::numeric, 2) AS media_passes_barcelona,
    ROUND(AVG(passes_media_espanha)::numeric, 2) AS media_passes_espanha,
    ROUND(AVG(passes_barcelona - passes_media_espanha)::numeric, 2) AS diferenca_media_passes,
    ROUND(AVG(gols_feitos_barcelona - gols_feitos_media_espanha)::numeric, 2) AS diferenca_media_gols_feitos,
    ROUND(AVG(gols_sofridos_barcelona - gols_sofridos_media_espanha)::numeric, 2) AS diferenca_media_gols_sofridos
FROM barca_vs_espanha
GROUP BY era, ordem_era
ORDER BY ordem_era;


-- 6. Índice de superioridade do Barcelona em relação à média espanhola
-- Calcula a diferença percentual em posse e passes.

SELECT
    b.temporada,
    b.tecnico,
    ROUND(((b.posse - e.posse) / e.posse * 100)::numeric, 2) AS superioridade_posse_percentual,
    ROUND(((b.passes_medios - e.passes) / e.passes * 100)::numeric, 2) AS superioridade_passes_percentual
FROM barcelona b
JOIN espanha_media e
    ON b.temporada = e.temporada
ORDER BY b.temporada;


-- 7. Visão final para exportação ao Python
-- Reúne os principais campos para visualização gráfica.

WITH barca_vs_espanha AS (
    SELECT
        b.temporada,
        b.tecnico,
        CASE
            WHEN b.tecnico = 'rijkaard' THEN 'Rijkaard'
            WHEN b.tecnico = 'guardiola' THEN 'Guardiola'
            WHEN b.tecnico IN ('tito vilanova', 'gerardo martino') THEN 'Pós-Guardiola'
            WHEN b.tecnico = 'luis enrique' THEN 'Luis Enrique'
            WHEN b.tecnico IN ('ernesto valverde', 'quique setien') THEN 'Transição Moderna'
            ELSE 'Outro'
        END AS era,
        b.posse AS posse_barcelona,
        e.posse AS posse_media_espanha,
        b.passes_medios AS passes_barcelona,
        e.passes AS passes_media_espanha,
        b.gols_feitos AS gols_feitos_barcelona,
        e.gols_feitos AS gols_feitos_media_espanha,
        b.gols_sofridos AS gols_sofridos_barcelona,
        e.gols_sofridos AS gols_sofridos_media_espanha
    FROM barcelona b
    JOIN espanha_media e
        ON b.temporada = e.temporada
)

SELECT
    temporada,
    tecnico,
    era,
    posse_barcelona,
    posse_media_espanha,
    ROUND((posse_barcelona - posse_media_espanha)::numeric, 2) AS diferenca_posse,
    passes_barcelona,
    passes_media_espanha,
    ROUND((passes_barcelona - passes_media_espanha)::numeric, 2) AS diferenca_passes,
    gols_feitos_barcelona,
    gols_feitos_media_espanha,
    ROUND((gols_feitos_barcelona - gols_feitos_media_espanha)::numeric, 2) AS diferenca_gols_feitos,
    gols_sofridos_barcelona,
    gols_sofridos_media_espanha,
    ROUND((gols_sofridos_barcelona - gols_sofridos_media_espanha)::numeric, 2) AS diferenca_gols_sofridos
FROM barca_vs_espanha
ORDER BY temporada;
