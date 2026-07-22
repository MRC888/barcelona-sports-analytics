<p align="center">
  <img src="images/capa_projeto.png" alt="Capa do projeto Barcelona Sports Analytics" width="100%">
</p>

# Barcelona Sports Analytics

**Análise quantitativa da influência do modelo de jogo do Barcelona na evolução do futebol europeu entre 2004/05 e 2019/20.**

![Python](https://img.shields.io/badge/Python-3.10%2B-3776AB?logo=python&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-SQL-4169E1?logo=postgresql&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-analise-150458?logo=pandas&logoColor=white)
![Matplotlib](https://img.shields.io/badge/Matplotlib-visualizacao-11557C)
![Status](https://img.shields.io/badge/status-concluido-2ea44f)

## Visão geral

Este repositório apresenta um **case acadêmico de Sports Analytics**, desenvolvido como Trabalho de Conclusão do curso de Sistemas de Informação da Universidade de Taubaté (UNITAU).

A pergunta central da pesquisa é:

> Em que medida o modelo de jogo consolidado pelo Barcelona influenciou a evolução do futebol europeu moderno e até que ponto essa influência pode ser identificada por meio de dados?

O projeto combina fundamentação histórica e tática, construção de dataset próprio, validação em PostgreSQL, consultas SQL e visualizações em Python.

## Nota metodológica importante

Este dataset possui caráter **exploratório e comparativo**.

- Resultados, campeões, jogos e gols foram organizados a partir de registros públicos.
- Posse de bola e passes médios, principalmente nas temporadas mais antigas, são **aproximações estatísticas construídas para comparação histórica**.
- O repositório não redistribui dados proprietários de Opta, StatsBomb, Wyscout ou outras plataformas comerciais.
- As análises descrevem associações e tendências. Elas não demonstram causalidade isolada.

A documentação completa sobre proveniência e limitações está em [`docs/FONTES_E_METODOLOGIA.md`](docs/FONTES_E_METODOLOGIA.md).

## Escopo do dataset

| Item | Quantidade |
|---|---:|
| Temporadas | 16 |
| Período | 2004/05 a 2019/20 |
| Tabelas | 18 |
| Registros | 288 |
| Ligas nacionais | 5 |
| Visualizações | 20 |

O Barcelona funciona como eixo central. As comparações incluem:

- campeões das cinco grandes ligas europeias;
- médias gerais das ligas;
- médias sazonais das equipes rebaixadas;
- campeão da UEFA Champions League;
- média dos quatro semifinalistas de cada edição da Champions League.

## Tecnologias utilizadas

`PostgreSQL` · `SQL` · `Python` · `Pandas` · `Matplotlib` · `Excel` · `Google Colab` · `DBeaver`

## Pipeline analítico

1. Delimitação histórica e tática do fenômeno.
2. Definição das variáveis observáveis.
3. Construção e padronização do dataset.
4. Exportação das tabelas para CSV.
5. Validação de integridade e consistência em PostgreSQL.
6. Consultas SQL para comparação dos recortes.
7. Geração das visualizações em Python.
8. Interpretação quantitativamente assistida pelo contexto histórico e tático.

## Principais resultados

### 1. A era Guardiola representou o pico estatístico do modelo no Barcelona

Na base construída, o Barcelona da era Guardiola apresentou média de **67,4% de posse** e aproximadamente **651 passes por jogo**. O período concentra os maiores valores de controle e circulação do recorte.

<p align="center">
  <img src="images/05_barcelona_posse_media_era.png" alt="Posse média do Barcelona por era" width="48%">
  <img src="images/06_barcelona_passes_media_era.png" alt="Passes médios do Barcelona por era" width="48%">
</p>

### 2. O Barcelona permaneceu acima da média espanhola

A diferença se torna especialmente evidente durante a era Guardiola, reforçando que o clube não apenas acompanhou uma tendência da liga: ele se comportou como um ponto fora da curva dentro do próprio campeonato.

<p align="center"><img src="images/08_barcelona_vs_espanha_posse.png" alt="Barcelona e média da Espanha em posse" width="88%"></p>

### 3. Campeões e rebaixados apresentaram perfis distintos

Considerando os agregados das cinco ligas, os campeões registraram em média **58,3% de posse** e **513 passes**, enquanto as médias sazonais das equipes rebaixadas ficaram em aproximadamente **45,3%** e **344 passes**.

Esse resultado não transforma posse em garantia de título. Ele indica associação entre maior capacidade de controle, construção e consistência em campeonatos de pontos corridos.

<p align="center"><img src="images/11_campeoes_vs_rebaixados_posse_liga.png" alt="Campeões e rebaixados em posse" width="88%"></p>

### 4. A influência não ocorreu por cópia direta

Dos 80 campeões nacionais observados, 72 foram classificados nas faixas de alta ou muito alta posse definidas na pesquisa. Entretanto, também existiram campeões com menor domínio da bola, apoiados em transição, organização defensiva, verticalidade e eficiência.

A interpretação central é que o futebol europeu absorveu princípios associados ao controle, mas também desenvolveu respostas competitivas ao modelo.

<p align="center"><img src="images/20_distribuicao_campeoes_perfil_posse.png" alt="Distribuição dos campeões por perfil de posse" width="88%"></p>

### 5. A Champions League exige uma leitura diferente

Em competições eliminatórias, controle estatístico e resultado não caminham sempre juntos. A comparação é feita entre o campeão de cada edição e a **média dos quatro semifinalistas**, e não com semifinalistas individuais.

<p align="center"><img src="images/17_champions_posse_campeao_vs_semifinalistas.png" alt="Campeão da Champions e média dos semifinalistas" width="88%"></p>

## O que a análise não afirma

- Posse de bola, isoladamente, não garante títulos.
- O estudo não demonstra que todas as equipes copiaram o Barcelona.
- As tendências observadas não provam causalidade direta.
- As aproximações históricas de posse e passes não substituem bases oficiais de eventos.

## Estrutura do repositório

```text
barcelona-sports-analytics/
├── README.md
├── CITATION.cff
├── LICENSE
├── LICENSE-CODE
├── requirements.txt
├── docs/
│   ├── TCC_Barcelona_Manuscrito_Final.pdf
│   └── FONTES_E_METODOLOGIA.md
├── data/
│   ├── Dataset_TCC.xlsx
│   ├── data_dictionary.md
│   └── csv/
├── sql/
│   ├── 00_criacao_tabelas.sql
│   └── 01...07_analises.sql
├── python/
│   └── visualizacoes.py
├── images/
│   └── 20 gráficos + capa
└── presentation/
    └── Barcelona_Sports_Analytics_Case_LinkedIn.pptx
```

## Como reproduzir as visualizações

```bash
git clone https://github.com/MRC888/barcelona-sports-analytics.git
cd barcelona-sports-analytics
python -m venv .venv
pip install -r requirements.txt
python python/visualizacoes.py
```

Por padrão, o script lê os CSVs de `data/csv/` e grava uma nova versão dos gráficos em `images/gerados/`.

Também é possível definir caminhos manualmente:

```bash
python python/visualizacoes.py --data-dir data/csv --output-dir images/gerados
```

## Como reproduzir as consultas SQL

1. Crie um banco PostgreSQL.
2. Execute `sql/00_criacao_tabelas.sql`.
3. Importe os arquivos de `data/csv/` para as tabelas de mesmo nome.
4. Execute `sql/01_validacao_e_testes.sql`.
5. Execute os blocos analíticos de `sql/02` a `sql/07`.

## Arquivos principais

- [Manuscrito completo em PDF](docs/TCC_Barcelona_Manuscrito_Final.pdf)
- [Dataset em Excel](data/Dataset_TCC.xlsx)
- [Dicionário de dados](data/data_dictionary.md)
- [Fontes e nota metodológica](docs/FONTES_E_METODOLOGIA.md)
- [Apresentação do case](presentation/Barcelona_Sports_Analytics_Case_LinkedIn.pptx)

## Citação

O repositório possui um arquivo [`CITATION.cff`](CITATION.cff). No GitHub, a opção **Cite this repository** gera uma referência a partir desse arquivo.

## Autor

**Marcelo Augusto Pereira Santos**  
Bacharelado em Sistemas de Informação - Universidade de Taubaté (UNITAU)

- [GitHub](https://github.com/MRC888)
- [LinkedIn](https://www.linkedin.com/in/marcelo-augusto-santos88/)

## Licenciamento

- Os códigos SQL e Python estão disponíveis sob a licença MIT, conforme [`LICENSE-CODE`](LICENSE-CODE).
- O dataset, os gráficos, o manuscrito, a apresentação e os textos permanecem sob os direitos autorais do autor, conforme [`LICENSE`](LICENSE).

---

> O Barcelona não apenas ganhou jogos. O Barcelona mudou o jogo.
