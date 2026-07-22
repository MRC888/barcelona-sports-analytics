-- ============================================================
-- TCC - ANÁLISE DO MODELO DO BARCELONA
-- DOCUMENTAÇÃO SQL - ETAPA 02
-- ANÁLISE DA EVOLUÇÃO ESTATÍSTICA DO BARCELONA
-- Ambiente: PostgreSQL / DBeaver
-- Tabela utilizada: barcelona
-- ============================================================


-- 1. Visão analítica geral do Barcelona
-- Inclui o percentual de vitórias calculado em SQL.

SELECT
    *,
    ROUND((vitorias::numeric / jogos::numeric) * 100, 2) AS percentual_vitorias
FROM barcelona
ORDER BY temporada;


-- 2. Evolução da posse de bola por temporada

SELECT
    temporada,
    tecnico,
    posse
FROM barcelona
ORDER BY temporada;


-- 3. Evolução dos passes médios por temporada

SELECT
    temporada,
    tecnico,
    passes_medios
FROM barcelona
ORDER BY temporada;


-- 4. Evolução ofensiva e defensiva

SELECT
    temporada,
    tecnico,
    gols_feitos,
    gols_sofridos
FROM barcelona
ORDER BY temporada;


-- 5. Percentual de vitórias por temporada

SELECT
    temporada,
    tecnico,
    jogos,
    vitorias,
    ROUND((vitorias::numeric / jogos::numeric) * 100, 2) AS percentual_vitorias
FROM barcelona
ORDER BY temporada;


-- 6. Médias por técnico

SELECT
    tecnico,
    COUNT(*) AS temporadas,
    ROUND(AVG(posse)::numeric, 2) AS media_posse,
    ROUND(AVG(passes_medios)::numeric, 2) AS media_passes,
    ROUND(AVG(gols_feitos)::numeric, 2) AS media_gols_feitos,
    ROUND(AVG(gols_sofridos)::numeric, 2) AS media_gols_sofridos,
    ROUND(AVG((vitorias::numeric / jogos::numeric) * 100), 2) AS media_percentual_vitorias
FROM barcelona
GROUP BY tecnico
ORDER BY MIN(temporada);


-- 7. Top 5 temporadas com maior posse

SELECT
    temporada,
    tecnico,
    posse
FROM barcelona
ORDER BY posse DESC
LIMIT 5;


-- 8. Top 5 temporadas com maior volume de passes

SELECT
    temporada,
    tecnico,
    passes_medios
FROM barcelona
ORDER BY passes_medios DESC
LIMIT 5;


-- 9. Top 5 temporadas com mais gols feitos

SELECT
    temporada,
    tecnico,
    gols_feitos
FROM barcelona
ORDER BY gols_feitos DESC
LIMIT 5;


-- 10. Top 5 temporadas com menos gols sofridos

SELECT
    temporada,
    tecnico,
    gols_sofridos
FROM barcelona
ORDER BY gols_sofridos ASC
LIMIT 5;


-- 11. Classificação das temporadas por era
-- A classificação é criada apenas na consulta, sem alterar o dataset original.

SELECT
    temporada,
    tecnico,
    CASE
        WHEN tecnico = 'rijkaard' THEN 'Rijkaard'
        WHEN tecnico = 'guardiola' THEN 'Guardiola'
        WHEN tecnico IN ('tito vilanova', 'gerardo martino') THEN 'Pós-Guardiola'
        WHEN tecnico = 'luis enrique' THEN 'Luis Enrique'
        WHEN tecnico IN ('ernesto valverde', 'quique setien') THEN 'Transição Moderna'
        ELSE 'Outro'
    END AS era,
    jogos,
    vitorias,
    empates,
    derrotas,
    gols_feitos,
    gols_sofridos,
    passes_medios,
    posse,
    ROUND((vitorias::numeric / jogos::numeric) * 100, 2) AS percentual_vitorias
FROM barcelona
ORDER BY temporada;


-- 12. Médias por era
-- A CTE barca_eras organiza as temporadas por fase histórica.

WITH barca_eras AS (
    SELECT
        temporada,
        tecnico,
        CASE
            WHEN tecnico = 'rijkaard' THEN 'Rijkaard'
            WHEN tecnico = 'guardiola' THEN 'Guardiola'
            WHEN tecnico IN ('tito vilanova', 'gerardo martino') THEN 'Pós-Guardiola'
            WHEN tecnico = 'luis enrique' THEN 'Luis Enrique'
            WHEN tecnico IN ('ernesto valverde', 'quique setien') THEN 'Transição Moderna'
            ELSE 'Outro'
        END AS era,
        CASE
            WHEN tecnico = 'rijkaard' THEN 1
            WHEN tecnico = 'guardiola' THEN 2
            WHEN tecnico IN ('tito vilanova', 'gerardo martino') THEN 3
            WHEN tecnico = 'luis enrique' THEN 4
            WHEN tecnico IN ('ernesto valverde', 'quique setien') THEN 5
            ELSE 6
        END AS ordem_era,
        jogos,
        vitorias,
        gols_feitos,
        gols_sofridos,
        passes_medios,
        posse
    FROM barcelona
)

SELECT
    era,
    COUNT(*) AS temporadas,
    ROUND(AVG(posse)::numeric, 2) AS media_posse,
    ROUND(AVG(passes_medios)::numeric, 2) AS media_passes,
    ROUND(AVG(gols_feitos)::numeric, 2) AS media_gols_feitos,
    ROUND(AVG(gols_sofridos)::numeric, 2) AS media_gols_sofridos,
    ROUND(AVG((vitorias::numeric / jogos::numeric) * 100), 2) AS media_percentual_vitorias
FROM barca_eras
GROUP BY era, ordem_era
ORDER BY ordem_era;

-- 13. Visão final para exportação ao Python
-- Essa consulta reúne temporada, técnico, era e principais métricas.

WITH barca_eras AS (
    SELECT
        temporada,
        tecnico,
        CASE
            WHEN tecnico = 'rijkaard' THEN 'Rijkaard'
            WHEN tecnico = 'guardiola' THEN 'Guardiola'
            WHEN tecnico IN ('tito vilanova', 'gerardo martino') THEN 'Pós-Guardiola'
            WHEN tecnico = 'luis enrique' THEN 'Luis Enrique'
            WHEN tecnico IN ('ernesto valverde', 'quique setien') THEN 'Transição Moderna'
            ELSE 'Outro'
        END AS era,
        jogos,
        vitorias,
        empates,
        derrotas,
        gols_feitos,
        gols_sofridos,
        passes_medios,
        posse
    FROM barcelona
)

SELECT
    temporada,
    tecnico,
    era,
    jogos,
    vitorias,
    empates,
    derrotas,
    gols_feitos,
    gols_sofridos,
    passes_medios,
    posse,
    ROUND((vitorias::numeric / jogos::numeric) * 100, 2) AS percentual_vitorias
FROM barca_eras
ORDER BY temporada;
