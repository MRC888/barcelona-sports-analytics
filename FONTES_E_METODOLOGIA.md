# Fontes, proveniência e nota metodológica

## 1. Escopo

O projeto analisa o período de 2004/05 a 2019/20 e utiliza o Barcelona como eixo para comparações com campeões nacionais, médias das ligas, médias das equipes rebaixadas, campeões da Champions League e média dos quatro semifinalistas da competição.

## 2. Proveniência por grupo de variáveis

| Grupo | Construção e apoio documental |
|---|---|
| Campeões, temporadas e resultados | Registros públicos de competições, com conferência em fontes como FBref, UEFA, WorldFootball.net e Transfermarkt. |
| Jogos, vitórias, empates, derrotas e gols | Organização e padronização pelo autor a partir de registros históricos públicos. |
| Posse de bola e passes | Aproximações estatísticas coerentes para comparação histórica, especialmente nas temporadas mais antigas. |
| Interpretação tática | Literatura sobre futebol total, Cruyff, Guardiola, jogo posicional, controle e adaptação competitiva. |

## 3. Transparência sobre posse e passes

Não existe uma única base pública, gratuita e padronizada que cubra todas as equipes e todas as métricas do recorte desde 2004/05.

Por isso, posse e passes médios foram tratados como aproximações exploratórias. Esses campos:

- não são apresentados como extrações oficiais de um fornecedor único;
- não devem ser utilizados como substitutos de bases proprietárias de eventos;
- servem para observar tendências e apoiar comparações dentro do dataset construído.

StatsBomb, Stats Perform/Opta, Understat e Wyscout foram consultados como referências metodológicas e conceituais. Nenhum dado proprietário dessas plataformas é redistribuído neste repositório.

## 4. Reprodutibilidade

As consultas SQL e as visualizações em Python são reproduzíveis a partir dos CSVs publicados.

A etapa de coleta histórica original não é integralmente reproduzível apenas pelo repositório, pois os recortes brutos, snapshots de páginas e trilha linha a linha de cada estimativa não foram preservados. Essa limitação deve ser considerada ao reutilizar a base.

## 5. Fontes históricas e estatísticas

- FBREF. *Football Statistics and History*. Acesso em 22 maio 2026.
- FBREF. *La Liga Seasons*. Acesso em 22 maio 2026.
- FBREF. *Premier League Seasons*. Acesso em 22 maio 2026.
- FBREF. *Ligue 1 Seasons*. Acesso em 22 maio 2026.
- FBREF. *Fußball-Bundesliga Seasons*. Acesso em 22 maio 2026.
- FBREF. *UEFA Champions League Seasons*. Acesso em 22 maio 2026.
- UEFA. *UEFA Champions League History*. Acesso em 22 maio 2026.
- UEFA. *UEFA Champions League Finals*. Acesso em 22 maio 2026.
- WORLDFOOTBALL.NET. *Results and Standings*. Acesso em 22 maio 2026.
- TRANSFERMARKT. *Tables and Results*. Acesso em 22 maio 2026.

Os endereços completos utilizados no manuscrito estão disponíveis na seção de referências do PDF.

## 6. Referências metodológicas e conceituais

- CRUYFF, Johan. *My Turn: The Autobiography*. Londres: Macmillan, 2016.
- PERARNAU, Martí. *Herr Pep: Inside the Mind of Pep Guardiola*. Londres: Arena Sport, 2014.
- PERARNAU, Martí. *Pep Guardiola: The Evolution*. Londres: Arena Sport, 2016.
- WILSON, Jonathan. *Inverting the Pyramid: The History of Football Tactics*. Londres: Orion, 2008.
- STATSBOMB. Materiais públicos sobre métricas e análise de desempenho no futebol.
- STATS PERFORM. Materiais públicos sobre posse, fases do jogo e definições de eventos.
- HUDL WYSCOUT. Glossário público de dados.
- BARCELONA INNOVATION HUB. Conteúdo público sobre análise tática e desempenho.

## 7. Uso adequado

O dataset é adequado para:

- demonstração de pipeline analítico;
- prática de SQL, Python e visualização;
- comparação exploratória de tendências;
- apoio ao debate histórico e tático.

Não é adequado para:

- afirmações causais isoladas;
- decisões profissionais que exijam dados oficiais;
- comparação com bases proprietárias sem validação adicional;
- apresentação das estimativas como estatísticas oficiais.
