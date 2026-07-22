-- ============================================================
-- TCC - ANÁLISE DO MODELO DO BARCELONA
-- DOCUMENTAÇÃO SQL - ETAPA 05
-- CAMPEÕES DAS CINCO GRANDES LIGAS
-- Ambiente: PostgreSQL / DBeaver
-- Tabelas utilizadas: campeões das cinco grandes ligas
-- ============================================================


-- 1. Base unificada dos campeões nacionais
-- Reúne os campeões de Espanha, França, Itália, Alemanha e Inglaterra.

WITH campeoes AS (
    SELECT
        temporada,
        'Espanha' AS liga,
        campeao,
        jogos,
        vitorias,
        empates,
        derrotas,
        gols_feitos,
        gols_sofridos,
        passes_medios,
        posse
    FROM espanha_campeao

    UNION ALL

    SELECT
        temporada,
        'França',
        campeao,
        jogos,
        vitorias,
        empates,
        derrotas,
        gols_feitos,
        gols_sofridos,
        passes_medios,
        posse
    FROM franca_campeao

    UNION ALL

    SELECT
        temporada,
        'Itália',
        campeao,
        jogos,
        vitorias,
        empates,
        derrotas,
        gols_feitos,
        gols_sofridos,
        passes_medios,
        posse
    FROM italia_campeao

    UNION ALL

    SELECT
        temporada,
        'Alemanha',
        campeao,
        jogos,
        vitorias,
        empates,
        derrotas,
        gols_feitos,
        gols_sofridos,
        passes_medios,
        posse
    FROM alemanha_campeao

    UNION ALL

    SELECT
        temporada,
        'Inglaterra',
        campeao,
        jogos,
        vitorias,
        empates,
        derrotas,
        gols_feitos,
        gols_sofridos,
        passes_medios,
        posse
    FROM inglaterra_campeao
)

SELECT
    temporada,
    liga,
    campeao,
    jogos,
    vitorias,
    empates,
    derrotas,
    gols_feitos,
    gols_sofridos,
    passes_medios,
    posse,
    ROUND((vitorias::numeric / jogos::numeric) * 100, 2) AS percentual_vitorias
FROM campeoes
ORDER BY liga, temporada;


-- 2. Evolução da posse dos campeões por liga
-- Permite observar se os campeões passaram a controlar mais a bola ao longo do tempo.

WITH campeoes AS (
    SELECT temporada, 'Espanha' AS liga, campeao, posse FROM espanha_campeao
    UNION ALL
    SELECT temporada, 'França', campeao, posse FROM franca_campeao
    UNION ALL
    SELECT temporada, 'Itália', campeao, posse FROM italia_campeao
    UNION ALL
    SELECT temporada, 'Alemanha', campeao, posse FROM alemanha_campeao
    UNION ALL
    SELECT temporada, 'Inglaterra', campeao, posse FROM inglaterra_campeao
)

SELECT
    temporada,
    liga,
    campeao,
    posse
FROM campeoes
ORDER BY liga, temporada;


-- 3. Evolução dos passes médios dos campeões por liga
-- Permite observar a evolução do volume de circulação dos campeões.

WITH campeoes AS (
    SELECT temporada, 'Espanha' AS liga, campeao, passes_medios FROM espanha_campeao
    UNION ALL
    SELECT temporada, 'França', campeao, passes_medios FROM franca_campeao
    UNION ALL
    SELECT temporada, 'Itália', campeao, passes_medios FROM italia_campeao
    UNION ALL
    SELECT temporada, 'Alemanha', campeao, passes_medios FROM alemanha_campeao
    UNION ALL
    SELECT temporada, 'Inglaterra', campeao, passes_medios FROM inglaterra_campeao
)

SELECT
    temporada,
    liga,
    campeao,
    passes_medios
FROM campeoes
ORDER BY liga, temporada;


-- 4. Médias dos campeões por liga
-- Resume posse, passes, gols e percentual de vitórias por campeonato.

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
    liga,
    ROUND(AVG(posse)::numeric, 2) AS media_posse,
    ROUND(AVG(passes_medios)::numeric, 2) AS media_passes,
    ROUND(AVG(gols_feitos)::numeric, 2) AS media_gols_feitos,
    ROUND(AVG(gols_sofridos)::numeric, 2) AS media_gols_sofridos,
    ROUND(AVG((vitorias::numeric / jogos::numeric) * 100), 2) AS media_percentual_vitorias
FROM campeoes
GROUP BY liga
ORDER BY liga;


-- 5. Separação por fases históricas
-- Compara o comportamento dos campeões antes, durante e depois da era Guardiola.

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

campeoes_fases AS (
    SELECT
        *,
        CASE
            WHEN temporada IN ('2004/05', '2005/06', '2006/07', '2007/08') THEN 'Pré-Guardiola'
            WHEN temporada IN ('2008/09', '2009/10', '2010/11', '2011/12') THEN 'Era Guardiola'
            WHEN temporada IN ('2012/13', '2013/14', '2014/15', '2015/16') THEN 'Pós-Guardiola inicial'
            WHEN temporada IN ('2016/17', '2017/18', '2018/19', '2019/20') THEN 'Futebol moderno'
            ELSE 'Outro'
        END AS fase,
        CASE
            WHEN temporada IN ('2004/05', '2005/06', '2006/07', '2007/08') THEN 1
            WHEN temporada IN ('2008/09', '2009/10', '2010/11', '2011/12') THEN 2
            WHEN temporada IN ('2012/13', '2013/14', '2014/15', '2015/16') THEN 3
            WHEN temporada IN ('2016/17', '2017/18', '2018/19', '2019/20') THEN 4
            ELSE 5
        END AS ordem_fase
    FROM campeoes
)

SELECT
    fase,
    COUNT(*) AS registros,
    ROUND(AVG(posse)::numeric, 2) AS media_posse,
    ROUND(AVG(passes_medios)::numeric, 2) AS media_passes,
    ROUND(AVG(gols_feitos)::numeric, 2) AS media_gols_feitos,
    ROUND(AVG(gols_sofridos)::numeric, 2) AS media_gols_sofridos,
    ROUND(AVG((vitorias::numeric / jogos::numeric) * 100), 2) AS media_percentual_vitorias
FROM campeoes_fases
GROUP BY fase, ordem_fase
ORDER BY ordem_fase;


-- 6. Fases históricas por liga
-- Mostra como cada liga se comportou em cada fase do recorte.

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

campeoes_fases AS (
    SELECT
        *,
        CASE
            WHEN temporada IN ('2004/05', '2005/06', '2006/07', '2007/08') THEN 'Pré-Guardiola'
            WHEN temporada IN ('2008/09', '2009/10', '2010/11', '2011/12') THEN 'Era Guardiola'
            WHEN temporada IN ('2012/13', '2013/14', '2014/15', '2015/16') THEN 'Pós-Guardiola inicial'
            WHEN temporada IN ('2016/17', '2017/18', '2018/19', '2019/20') THEN 'Futebol moderno'
            ELSE 'Outro'
        END AS fase,
        CASE
            WHEN temporada IN ('2004/05', '2005/06', '2006/07', '2007/08') THEN 1
            WHEN temporada IN ('2008/09', '2009/10', '2010/11', '2011/12') THEN 2
            WHEN temporada IN ('2012/13', '2013/14', '2014/15', '2015/16') THEN 3
            WHEN temporada IN ('2016/17', '2017/18', '2018/19', '2019/20') THEN 4
            ELSE 5
        END AS ordem_fase
    FROM campeoes
)

SELECT
    liga,
    fase,
    ROUND(AVG(posse)::numeric, 2) AS media_posse,
    ROUND(AVG(passes_medios)::numeric, 2) AS media_passes,
    ROUND(AVG(gols_feitos)::numeric, 2) AS media_gols_feitos,
    ROUND(AVG(gols_sofridos)::numeric, 2) AS media_gols_sofridos
FROM campeoes_fases
GROUP BY liga, fase, ordem_fase
ORDER BY liga, ordem_fase;


-- 7. Campeões com maior posse no recorte
-- Identifica os campeões mais próximos do modelo de controle por posse.

WITH campeoes AS (
    SELECT temporada, 'Espanha' AS liga, campeao, posse, passes_medios FROM espanha_campeao
    UNION ALL
    SELECT temporada, 'França', campeao, posse, passes_medios FROM franca_campeao
    UNION ALL
    SELECT temporada, 'Itália', campeao, posse, passes_medios FROM italia_campeao
    UNION ALL
    SELECT temporada, 'Alemanha', campeao, posse, passes_medios FROM alemanha_campeao
    UNION ALL
    SELECT temporada, 'Inglaterra', campeao, posse, passes_medios FROM inglaterra_campeao
)

SELECT
    temporada,
    liga,
    campeao,
    posse,
    passes_medios
FROM campeoes
ORDER BY posse DESC
LIMIT 10;


-- 8. Campeões com maior volume de passes no recorte
-- Identifica os campeões com maior circulação de bola.

WITH campeoes AS (
    SELECT temporada, 'Espanha' AS liga, campeao, posse, passes_medios FROM espanha_campeao
    UNION ALL
    SELECT temporada, 'França', campeao, posse, passes_medios FROM franca_campeao
    UNION ALL
    SELECT temporada, 'Itália', campeao, posse, passes_medios FROM italia_campeao
    UNION ALL
    SELECT temporada, 'Alemanha', campeao, posse, passes_medios FROM alemanha_campeao
    UNION ALL
    SELECT temporada, 'Inglaterra', campeao, posse, passes_medios FROM inglaterra_campeao
)

SELECT
    temporada,
    liga,
    campeao,
    passes_medios,
    posse
FROM campeoes
ORDER BY passes_medios DESC
LIMIT 10;


-- 9. Campeões de menor posse no recorte
-- Ajuda a localizar modelos vencedores alternativos ao controle por posse.

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
    temporada,
    liga,
    campeao,
    posse,
    passes_medios,
    gols_feitos,
    gols_sofridos
FROM campeoes
ORDER BY posse ASC
LIMIT 10;


-- 10. Visão final para exportação ao Python
-- Base consolidada para gráficos comparativos entre ligas.

WITH campeoes AS (
    SELECT temporada, 'Espanha' AS liga, campeao, jogos, vitorias, empates, derrotas, gols_feitos, gols_sofridos, passes_medios, posse FROM espanha_campeao
    UNION ALL
    SELECT temporada, 'França', campeao, jogos, vitorias, empates, derrotas, gols_feitos, gols_sofridos, passes_medios, posse FROM franca_campeao
    UNION ALL
    SELECT temporada, 'Itália', campeao, jogos, vitorias, empates, derrotas, gols_feitos, gols_sofridos, passes_medios, posse FROM italia_campeao
    UNION ALL
    SELECT temporada, 'Alemanha', campeao, jogos, vitorias, empates, derrotas, gols_feitos, gols_sofridos, passes_medios, posse FROM alemanha_campeao
    UNION ALL
    SELECT temporada, 'Inglaterra', campeao, jogos, vitorias, empates, derrotas, gols_feitos, gols_sofridos, passes_medios, posse FROM inglaterra_campeao
)

SELECT
    temporada,
    liga,
    campeao,
    jogos,
    vitorias,
    empates,
    derrotas,
    gols_feitos,
    gols_sofridos,
    passes_medios,
    posse,
    ROUND((vitorias::numeric / jogos::numeric) * 100, 2) AS percentual_vitorias
FROM campeoes
ORDER BY liga, temporada;
