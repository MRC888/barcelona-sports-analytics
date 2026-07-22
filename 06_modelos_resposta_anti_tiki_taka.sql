-- ============================================================
-- TCC - ANÁLISE DO MODELO DO BARCELONA
-- DOCUMENTAÇÃO SQL - ETAPA 06
-- MODELOS DE RESPOSTA AO TIKI-TAKA
-- Ambiente: PostgreSQL / DBeaver
-- Tabelas utilizadas: campeões nacionais e champions_campeao
-- ============================================================


-- 1. Campeões nacionais com menor posse
-- Identifica equipes campeãs que venceram sem posse dominante.

WITH campeoes AS (
    SELECT temporada, 'Espanha' AS liga, campeao, jogos, vitorias, gols_feitos, gols_sofridos, passes_medios, posse FROM espanha_campeao
    UNION ALL
    SELECT temporada, 'França', campeao, jogos, vitorias, gols_feitos, gols_sofridos, passes_medios, posse FROM franca_campeao
    UNION ALL
    SELECT temporada, 'Itália', campeao, jogos, vitorias, gols_feitos, gols_sofridos, passes_medios, posse FROM italia_campeao
    UNION ALL
    SELECT temporada, 'Alemanha', campeao, jogos, vitorias, gols_feitos, gols_sofridos, passes_medios, posse FROM alemanha_campeao
    UNION ALL
    SELECT temporada, 'Inglaterra', campeao, jogos, vitorias, gols_feitos, gols_sofridos, passes_medios, posse FROM inglaterra_campeao
)

SELECT
    temporada,
    liga,
    campeao,
    posse,
    passes_medios,
    gols_feitos,
    gols_sofridos,
    ROUND((vitorias::numeric / jogos::numeric) * 100, 2) AS percentual_vitorias
FROM campeoes
ORDER BY posse ASC
LIMIT 15;


-- 2. Campeões nacionais com menor volume de passes
-- Ajuda a localizar campeões mais diretos ou menos dependentes da circulação longa.

WITH campeoes AS (
    SELECT temporada, 'Espanha' AS liga, campeao, jogos, vitorias, gols_feitos, gols_sofridos, passes_medios, posse FROM espanha_campeao
    UNION ALL
    SELECT temporada, 'França', campeao, jogos, vitorias, gols_feitos, gols_sofridos, passes_medios, posse FROM franca_campeao
    UNION ALL
    SELECT temporada, 'Itália', campeao, jogos, vitorias, gols_feitos, gols_sofridos, passes_medios, posse FROM italia_campeao
    UNION ALL
    SELECT temporada, 'Alemanha', campeao, jogos, vitorias, gols_feitos, gols_sofridos, passes_medios, posse FROM alemanha_campeao
    UNION ALL
    SELECT temporada, 'Inglaterra', campeao, jogos, vitorias, gols_feitos, gols_sofridos, passes_medios, posse FROM inglaterra_campeao
)

SELECT
    temporada,
    liga,
    campeao,
    passes_medios,
    posse,
    gols_feitos,
    gols_sofridos,
    ROUND((vitorias::numeric / jogos::numeric) * 100, 2) AS percentual_vitorias
FROM campeoes
ORDER BY passes_medios ASC
LIMIT 15;


-- 3. Campeões de alta eficiência com posse baixa
-- Seleciona campeões com posse abaixo de 55% e percentual de vitórias elevado.

WITH campeoes AS (
    SELECT temporada, 'Espanha' AS liga, campeao, jogos, vitorias, gols_feitos, gols_sofridos, passes_medios, posse FROM espanha_campeao
    UNION ALL
    SELECT temporada, 'França', campeao, jogos, vitorias, gols_feitos, gols_sofridos, passes_medios, posse FROM franca_campeao
    UNION ALL
    SELECT temporada, 'Itália', campeao, jogos, vitorias, gols_feitos, gols_sofridos, passes_medios, posse FROM italia_campeao
    UNION ALL
    SELECT temporada, 'Alemanha', campeao, jogos, vitorias, gols_feitos, gols_sofridos, passes_medios, posse FROM alemanha_campeao
    UNION ALL
    SELECT temporada, 'Inglaterra', campeao, jogos, vitorias, gols_feitos, gols_sofridos, passes_medios, posse FROM inglaterra_campeao
),

campeoes_calculados AS (
    SELECT
        *,
        ROUND((vitorias::numeric / jogos::numeric) * 100, 2) AS percentual_vitorias
    FROM campeoes
)

SELECT
    temporada,
    liga,
    campeao,
    posse,
    passes_medios,
    percentual_vitorias,
    gols_feitos,
    gols_sofridos
FROM campeoes_calculados
WHERE posse < 55
  AND percentual_vitorias >= 65
ORDER BY percentual_vitorias DESC, posse ASC;


-- 4. Casos simbólicos de resposta ao modelo de posse
-- Seleciona equipes relevantes para interpretação qualitativa do trabalho.

WITH casos AS (
    SELECT
        temporada,
        'Champions League' AS competicao,
        campeao,
        posse,
        passes_medios,
        gols_feitos,
        gols_sofridos,
        vitorias,
        jogos
    FROM champions_campeao
    WHERE temporada IN ('2009/10', '2011/12', '2018/19', '2019/20')

    UNION ALL

    SELECT
        temporada,
        'Premier League',
        campeao,
        posse,
        passes_medios,
        gols_feitos,
        gols_sofridos,
        vitorias,
        jogos
    FROM inglaterra_campeao
    WHERE temporada IN ('2015/16', '2017/18', '2018/19', '2019/20')

    UNION ALL

    SELECT
        temporada,
        'La Liga',
        campeao,
        posse,
        passes_medios,
        gols_feitos,
        gols_sofridos,
        vitorias,
        jogos
    FROM espanha_campeao
    WHERE temporada IN ('2013/14', '2016/17', '2019/20')
)

SELECT
    temporada,
    competicao,
    campeao,
    posse,
    passes_medios,
    gols_feitos,
    gols_sofridos,
    ROUND((vitorias::numeric / jogos::numeric) * 100, 2) AS percentual_vitorias
FROM casos
ORDER BY temporada, competicao;


-- 5. Classificação dos campeões por perfil de posse
-- Agrupa campeões em faixas: baixa, intermediária, alta e muito alta.

WITH campeoes AS (
    SELECT temporada, 'Espanha' AS liga, campeao, posse, passes_medios, gols_feitos, gols_sofridos FROM espanha_campeao
    UNION ALL
    SELECT temporada, 'França', campeao, posse, passes_medios, gols_feitos, gols_sofridos FROM franca_campeao
    UNION ALL
    SELECT temporada, 'Itália', campeao, posse, passes_medios, gols_feitos, gols_sofridos FROM italia_campeao
    UNION ALL
    SELECT temporada, 'Alemanha', campeao, posse, passes_medios, gols_feitos, gols_sofridos FROM alemanha_campeao
    UNION ALL
    SELECT temporada, 'Inglaterra', campeao, posse, passes_medios, gols_feitos, gols_sofridos FROM inglaterra_campeao
)

SELECT
    CASE
        WHEN posse < 50 THEN 'Baixa posse'
        WHEN posse >= 50 AND posse < 56 THEN 'Posse intermediária'
        WHEN posse >= 56 AND posse < 62 THEN 'Alta posse'
        WHEN posse >= 62 THEN 'Posse muito alta'
        ELSE 'Outro'
    END AS perfil_posse,
    COUNT(*) AS total_campeoes,
    ROUND(AVG(posse)::numeric, 2) AS media_posse,
    ROUND(AVG(passes_medios)::numeric, 2) AS media_passes,
    ROUND(AVG(gols_feitos)::numeric, 2) AS media_gols_feitos,
    ROUND(AVG(gols_sofridos)::numeric, 2) AS media_gols_sofridos
FROM campeoes
GROUP BY perfil_posse
ORDER BY media_posse;


-- 6. Comparação entre campeões de baixa posse e alta posse
-- Resume diferenças entre modelos mais reativos e modelos mais dominantes.

WITH campeoes AS (
    SELECT temporada, 'Espanha' AS liga, campeao, jogos, vitorias, posse, passes_medios, gols_feitos, gols_sofridos FROM espanha_campeao
    UNION ALL
    SELECT temporada, 'França', campeao, jogos, vitorias, posse, passes_medios, gols_feitos, gols_sofridos FROM franca_campeao
    UNION ALL
    SELECT temporada, 'Itália', campeao, jogos, vitorias, posse, passes_medios, gols_feitos, gols_sofridos FROM italia_campeao
    UNION ALL
    SELECT temporada, 'Alemanha', campeao, jogos, vitorias, posse, passes_medios, gols_feitos, gols_sofridos FROM alemanha_campeao
    UNION ALL
    SELECT temporada, 'Inglaterra', campeao, jogos, vitorias, posse, passes_medios, gols_feitos, gols_sofridos FROM inglaterra_campeao
),

perfis AS (
    SELECT
        *,
        CASE
            WHEN posse < 55 THEN 'Menor posse'
            WHEN posse >= 55 THEN 'Maior posse'
            ELSE 'Outro'
        END AS perfil
    FROM campeoes
)

SELECT
    perfil,
    COUNT(*) AS total_campeoes,
    ROUND(AVG(posse)::numeric, 2) AS media_posse,
    ROUND(AVG(passes_medios)::numeric, 2) AS media_passes,
    ROUND(AVG(gols_feitos)::numeric, 2) AS media_gols_feitos,
    ROUND(AVG(gols_sofridos)::numeric, 2) AS media_gols_sofridos,
    ROUND(AVG((vitorias::numeric / jogos::numeric) * 100), 2) AS media_percentual_vitorias
FROM perfis
GROUP BY perfil
ORDER BY media_posse;


-- 7. Champions: campeões com posse abaixo da média dos semifinalistas
-- Identifica títulos europeus vencidos sem dominar a posse em relação à elite da edição.

SELECT
    c.temporada,
    c.campeao,
    c.posse AS posse_campeao,
    m.posse AS posse_media_semifinalistas,
    ROUND((c.posse - m.posse)::numeric, 2) AS diferenca_posse,
    c.passes_medios AS passes_campeao,
    m.passes AS passes_media_semifinalistas,
    ROUND((c.passes_medios - m.passes)::numeric, 2) AS diferenca_passes,
    c.gols_feitos,
    c.gols_sofridos
FROM champions_campeao c
JOIN champions_media_alta m
    ON c.temporada = m.temporada
WHERE c.posse < m.posse
ORDER BY c.temporada;


-- 8. Visão final para exportação ao Python
-- Base com campeões nacionais classificados por perfil de posse.

WITH campeoes AS (
    SELECT temporada, 'Espanha' AS liga, campeao, jogos, vitorias, posse, passes_medios, gols_feitos, gols_sofridos FROM espanha_campeao
    UNION ALL
    SELECT temporada, 'França', campeao, jogos, vitorias, posse, passes_medios, gols_feitos, gols_sofridos FROM franca_campeao
    UNION ALL
    SELECT temporada, 'Itália', campeao, jogos, vitorias, posse, passes_medios, gols_feitos, gols_sofridos FROM italia_campeao
    UNION ALL
    SELECT temporada, 'Alemanha', campeao, jogos, vitorias, posse, passes_medios, gols_feitos, gols_sofridos FROM alemanha_campeao
    UNION ALL
    SELECT temporada, 'Inglaterra', campeao, jogos, vitorias, posse, passes_medios, gols_feitos, gols_sofridos FROM inglaterra_campeao
)

SELECT
    temporada,
    liga,
    campeao,
    CASE
        WHEN posse < 50 THEN 'Baixa posse'
        WHEN posse >= 50 AND posse < 56 THEN 'Posse intermediária'
        WHEN posse >= 56 AND posse < 62 THEN 'Alta posse'
        WHEN posse >= 62 THEN 'Posse muito alta'
        ELSE 'Outro'
    END AS perfil_posse,
    posse,
    passes_medios,
    gols_feitos,
    gols_sofridos,
    ROUND((vitorias::numeric / jogos::numeric) * 100, 2) AS percentual_vitorias
FROM campeoes
ORDER BY temporada, liga;
