-- ============================================================
-- TCC - ANÁLISE DO MODELO DO BARCELONA
-- DOCUMENTAÇÃO SQL - ETAPA 07
-- CHAMPIONS LEAGUE COMO VALIDAÇÃO INTERNACIONAL
-- Ambiente: PostgreSQL / DBeaver
-- Tabelas utilizadas: champions_campeao, champions_media_alta
-- ============================================================


-- 1. Visão geral dos campeões da Champions League
-- Apresenta os campeões europeus no recorte analisado.

SELECT
    temporada,
    jogos,
    campeao,
    vitorias,
    empates,
    derrotas,
    gols_feitos,
    gols_sofridos,
    passes_medios,
    posse,
    ROUND((vitorias::numeric / jogos::numeric) * 100, 2) AS percentual_vitorias
FROM champions_campeao
ORDER BY temporada;


-- 2. Visão geral da média alta da Champions
-- Representa a média dos quatro semifinalistas de cada temporada.

SELECT
    temporada,
    jogos,
    gols_feitos,
    gols_sofridos,
    passes,
    posse
FROM champions_media_alta
ORDER BY temporada;


-- 3. Campeão da Champions vs média dos semifinalistas
-- Compara o campeão com a elite da competição em cada temporada.

SELECT
    c.temporada,
    c.campeao,
    c.posse AS posse_campeao,
    m.posse AS posse_media_semifinalistas,
    ROUND((c.posse - m.posse)::numeric, 2) AS diferenca_posse,
    c.passes_medios AS passes_campeao,
    m.passes AS passes_media_semifinalistas,
    ROUND((c.passes_medios - m.passes)::numeric, 2) AS diferenca_passes,
    c.gols_feitos AS gols_feitos_campeao,
    m.gols_feitos AS gols_feitos_media_semifinalistas,
    ROUND((c.gols_feitos - m.gols_feitos)::numeric, 2) AS diferenca_gols_feitos,
    c.gols_sofridos AS gols_sofridos_campeao,
    m.gols_sofridos AS gols_sofridos_media_semifinalistas,
    ROUND((c.gols_sofridos - m.gols_sofridos)::numeric, 2) AS diferenca_gols_sofridos
FROM champions_campeao c
JOIN champions_media_alta m
    ON c.temporada = m.temporada
ORDER BY c.temporada;


-- 4. Temporadas em que o campeão teve posse acima da média dos semifinalistas
-- Ajuda a localizar títulos vencidos com maior controle de bola.

SELECT
    c.temporada,
    c.campeao,
    c.posse AS posse_campeao,
    m.posse AS posse_media_semifinalistas,
    ROUND((c.posse - m.posse)::numeric, 2) AS diferenca_posse
FROM champions_campeao c
JOIN champions_media_alta m
    ON c.temporada = m.temporada
WHERE c.posse > m.posse
ORDER BY diferenca_posse DESC;


-- 5. Temporadas em que o campeão teve posse abaixo da média dos semifinalistas
-- Ajuda a localizar títulos vencidos com modelos mais eficientes, diretos ou reativos.

SELECT
    c.temporada,
    c.campeao,
    c.posse AS posse_campeao,
    m.posse AS posse_media_semifinalistas,
    ROUND((c.posse - m.posse)::numeric, 2) AS diferenca_posse
FROM champions_campeao c
JOIN champions_media_alta m
    ON c.temporada = m.temporada
WHERE c.posse < m.posse
ORDER BY diferenca_posse ASC;


-- 6. Temporadas em que o campeão teve mais passes que a média dos semifinalistas
-- Verifica quando o campeão teve maior volume de circulação que a elite da edição.

SELECT
    c.temporada,
    c.campeao,
    c.passes_medios AS passes_campeao,
    m.passes AS passes_media_semifinalistas,
    ROUND((c.passes_medios - m.passes)::numeric, 2) AS diferenca_passes
FROM champions_campeao c
JOIN champions_media_alta m
    ON c.temporada = m.temporada
WHERE c.passes_medios > m.passes
ORDER BY diferenca_passes DESC;


-- 7. Classificação dos campeões da Champions por perfil de posse
-- Agrupa os campeões europeus em faixas de controle de bola.

SELECT
    CASE
        WHEN posse < 50 THEN 'Baixa posse'
        WHEN posse >= 50 AND posse < 56 THEN 'Posse intermediária'
        WHEN posse >= 56 AND posse < 62 THEN 'Alta posse'
        WHEN posse >= 62 THEN 'Posse muito alta'
        ELSE 'Outro'
    END AS perfil_posse,
    COUNT(*) AS total_titulos,
    ROUND(AVG(posse)::numeric, 2) AS media_posse,
    ROUND(AVG(passes_medios)::numeric, 2) AS media_passes,
    ROUND(AVG(gols_feitos)::numeric, 2) AS media_gols_feitos,
    ROUND(AVG(gols_sofridos)::numeric, 2) AS media_gols_sofridos
FROM champions_campeao
GROUP BY perfil_posse
ORDER BY media_posse;


-- 8. Comparação por fases históricas
-- Compara a Champions antes, durante e depois da era Guardiola.

WITH champions_fases AS (
    SELECT
        c.temporada,
        c.campeao,
        c.jogos,
        c.vitorias,
        c.gols_feitos,
        c.gols_sofridos,
        c.passes_medios,
        c.posse,
        m.gols_feitos AS gols_feitos_media_semifinalistas,
        m.gols_sofridos AS gols_sofridos_media_semifinalistas,
        m.passes AS passes_media_semifinalistas,
        m.posse AS posse_media_semifinalistas,
        CASE
            WHEN c.temporada IN ('2004/05', '2005/06', '2006/07', '2007/08') THEN 'Pré-Guardiola'
            WHEN c.temporada IN ('2008/09', '2009/10', '2010/11', '2011/12') THEN 'Era Guardiola'
            WHEN c.temporada IN ('2012/13', '2013/14', '2014/15', '2015/16') THEN 'Pós-Guardiola inicial'
            WHEN c.temporada IN ('2016/17', '2017/18', '2018/19', '2019/20') THEN 'Futebol moderno'
            ELSE 'Outro'
        END AS fase,
        CASE
            WHEN c.temporada IN ('2004/05', '2005/06', '2006/07', '2007/08') THEN 1
            WHEN c.temporada IN ('2008/09', '2009/10', '2010/11', '2011/12') THEN 2
            WHEN c.temporada IN ('2012/13', '2013/14', '2014/15', '2015/16') THEN 3
            WHEN c.temporada IN ('2016/17', '2017/18', '2018/19', '2019/20') THEN 4
            ELSE 5
        END AS ordem_fase
    FROM champions_campeao c
    JOIN champions_media_alta m
        ON c.temporada = m.temporada
)

SELECT
    fase,
    COUNT(*) AS temporadas,
    ROUND(AVG(posse)::numeric, 2) AS media_posse_campeao,
    ROUND(AVG(posse_media_semifinalistas)::numeric, 2) AS media_posse_semifinalistas,
    ROUND(AVG(posse - posse_media_semifinalistas)::numeric, 2) AS diferenca_media_posse,
    ROUND(AVG(passes_medios)::numeric, 2) AS media_passes_campeao,
    ROUND(AVG(passes_media_semifinalistas)::numeric, 2) AS media_passes_semifinalistas,
    ROUND(AVG(passes_medios - passes_media_semifinalistas)::numeric, 2) AS diferenca_media_passes,
    ROUND(AVG((vitorias::numeric / jogos::numeric) * 100), 2) AS media_percentual_vitorias
FROM champions_fases
GROUP BY fase, ordem_fase
ORDER BY ordem_fase;


-- 9. Campeões simbólicos para interpretação do modelo europeu
-- Seleciona casos relevantes para o storytelling do trabalho.

SELECT
    temporada,
    campeao,
    posse,
    passes_medios,
    gols_feitos,
    gols_sofridos,
    ROUND((vitorias::numeric / jogos::numeric) * 100, 2) AS percentual_vitorias
FROM champions_campeao
WHERE temporada IN (
    '2005/06',
    '2008/09',
    '2009/10',
    '2010/11',
    '2011/12',
    '2012/13',
    '2014/15',
    '2018/19',
    '2019/20'
)
ORDER BY temporada;


-- 10. Visão final para exportação ao Python
-- Base pronta para gráficos da Champions League.

SELECT
    c.temporada,
    c.campeao,
    c.jogos AS jogos_campeao,
    c.vitorias,
    c.empates,
    c.derrotas,
    c.gols_feitos AS gols_feitos_campeao,
    m.gols_feitos AS gols_feitos_media_semifinalistas,
    ROUND((c.gols_feitos - m.gols_feitos)::numeric, 2) AS diferenca_gols_feitos,
    c.gols_sofridos AS gols_sofridos_campeao,
    m.gols_sofridos AS gols_sofridos_media_semifinalistas,
    ROUND((c.gols_sofridos - m.gols_sofridos)::numeric, 2) AS diferenca_gols_sofridos,
    c.passes_medios AS passes_campeao,
    m.passes AS passes_media_semifinalistas,
    ROUND((c.passes_medios - m.passes)::numeric, 2) AS diferenca_passes,
    c.posse AS posse_campeao,
    m.posse AS posse_media_semifinalistas,
    ROUND((c.posse - m.posse)::numeric, 2) AS diferenca_posse,
    ROUND((c.vitorias::numeric / c.jogos::numeric) * 100, 2) AS percentual_vitorias
FROM champions_campeao c
JOIN champions_media_alta m
    ON c.temporada = m.temporada
ORDER BY c.temporada;
