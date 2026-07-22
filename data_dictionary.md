# Dicionário de dados

## Natureza do dataset

O dataset é exploratório e comparativo. As métricas de posse e passes, sobretudo nas temporadas mais antigas, são aproximações estatísticas construídas para permitir comparação histórica no recorte de 2004/05 a 2019/20.

## Campos

| Campo | Descrição | Tipo lógico | Disponibilidade |
|---|---|---|---|
| `temporada` | Identificador da temporada esportiva. | Texto/categoria temporal | Todas as tabelas |
| `tecnico` | Treinador do Barcelona na temporada. | Texto/categoria | `barcelona` |
| `campeao` | Clube campeão da competição. | Texto/categoria | Tabelas de campeões |
| `jogos` | Jogos disputados; em `champions_media_alta`, média dos semifinalistas. | Inteiro/decimal | Todas as tabelas |
| `vitorias` | Vitórias na campanha ou perfil agregado. | Inteiro | Barcelona, campeões e rebaixados |
| `empates` | Empates na campanha ou perfil agregado. | Inteiro | Barcelona, campeões e rebaixados |
| `derrotas` | Derrotas na campanha ou perfil agregado. | Inteiro | Barcelona, campeões e rebaixados |
| `gols_feitos` | Gols marcados na temporada ou média do grupo analisado. | Inteiro | Todas as tabelas |
| `gols_sofridos` | Gols sofridos na temporada ou média do grupo analisado. | Inteiro | Todas as tabelas |
| `passes_medios` | Volume médio de passes da equipe. | Inteiro | Barcelona, campeões e rebaixados |
| `passes` | Volume médio de passes agregado da liga ou dos semifinalistas. | Inteiro | Médias das ligas e `champions_media_alta` |
| `posse` | Percentual médio de posse de bola. | Decimal (%) | Todas as tabelas |

## Grupos de tabelas

| Arquivo/padrão | Representação | Registros por tabela |
|---|---|---:|
| `barcelona.csv` | Barcelona por temporada | 16 |
| `*_campeao.csv` | Campeão nacional por temporada | 16 |
| `*_media.csv` | Média da liga por temporada | 16 |
| `*_rebaixados.csv` | Média sazonal das equipes rebaixadas | 16 |
| `champions_campeao.csv` | Campeão da Champions por temporada | 16 |
| `champions_media_alta.csv` | Média dos quatro semifinalistas | 16 |

## Integridade verificada

- 18 tabelas;
- 16 temporadas por tabela;
- 288 registros no total;
- ausência de valores vazios nos campos utilizados;
- ausência de valores negativos;
- posse dentro do intervalo de 0% a 100%;
- consistência entre jogos e resultados nas tabelas de campanha.

## Limitações

- A base não contém eventos por partida ou por jogador.
- Não há métricas padronizadas de pressão, recuperação alta ou localização das ações para todo o período.
- Posse e passes antigos não devem ser interpretados como valores oficiais de um único fornecedor.
- A análise é descritiva e não estabelece causalidade.
