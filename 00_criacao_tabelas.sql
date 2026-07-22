-- Estrutura das 18 tabelas do projeto para PostgreSQL.
-- Execute antes de importar os CSVs da pasta data/csv.

BEGIN;

DROP TABLE IF EXISTS
    barcelona,
    espanha_campeao,
    franca_campeao,
    italia_campeao,
    alemanha_campeao,
    inglaterra_campeao,
    espanha_media,
    franca_media,
    italia_media,
    alemanha_media,
    inglaterra_media,
    espanha_rebaixados,
    franca_rebaixados,
    italia_rebaixados,
    alemanha_rebaixados,
    inglaterra_rebaixados,
    champions_campeao,
    champions_media_alta CASCADE;

CREATE TABLE barcelona (
    temporada VARCHAR(7) PRIMARY KEY,
    tecnico VARCHAR(100) NOT NULL,
    jogos INTEGER NOT NULL CHECK (jogos > 0),
    vitorias INTEGER NOT NULL CHECK (vitorias >= 0),
    empates INTEGER NOT NULL CHECK (empates >= 0),
    derrotas INTEGER NOT NULL CHECK (derrotas >= 0),
    gols_feitos INTEGER NOT NULL CHECK (gols_feitos >= 0),
    gols_sofridos INTEGER NOT NULL CHECK (gols_sofridos >= 0),
    passes_medios INTEGER NOT NULL CHECK (passes_medios >= 0),
    posse NUMERIC(5,2) NOT NULL CHECK (posse BETWEEN 0 AND 100),
    CHECK (vitorias + empates + derrotas = jogos)
);

CREATE TABLE espanha_campeao (
    temporada VARCHAR(7) PRIMARY KEY,
    campeao VARCHAR(100) NOT NULL,
    jogos INTEGER NOT NULL CHECK (jogos > 0),
    vitorias INTEGER NOT NULL CHECK (vitorias >= 0),
    empates INTEGER NOT NULL CHECK (empates >= 0),
    derrotas INTEGER NOT NULL CHECK (derrotas >= 0),
    gols_feitos INTEGER NOT NULL CHECK (gols_feitos >= 0),
    gols_sofridos INTEGER NOT NULL CHECK (gols_sofridos >= 0),
    passes_medios INTEGER NOT NULL CHECK (passes_medios >= 0),
    posse NUMERIC(5,2) NOT NULL CHECK (posse BETWEEN 0 AND 100),
    CHECK (vitorias + empates + derrotas = jogos)
);

CREATE TABLE franca_campeao (
    temporada VARCHAR(7) PRIMARY KEY,
    campeao VARCHAR(100) NOT NULL,
    jogos INTEGER NOT NULL CHECK (jogos > 0),
    vitorias INTEGER NOT NULL CHECK (vitorias >= 0),
    empates INTEGER NOT NULL CHECK (empates >= 0),
    derrotas INTEGER NOT NULL CHECK (derrotas >= 0),
    gols_feitos INTEGER NOT NULL CHECK (gols_feitos >= 0),
    gols_sofridos INTEGER NOT NULL CHECK (gols_sofridos >= 0),
    passes_medios INTEGER NOT NULL CHECK (passes_medios >= 0),
    posse NUMERIC(5,2) NOT NULL CHECK (posse BETWEEN 0 AND 100),
    CHECK (vitorias + empates + derrotas = jogos)
);

CREATE TABLE italia_campeao (
    temporada VARCHAR(7) PRIMARY KEY,
    campeao VARCHAR(100) NOT NULL,
    jogos INTEGER NOT NULL CHECK (jogos > 0),
    vitorias INTEGER NOT NULL CHECK (vitorias >= 0),
    empates INTEGER NOT NULL CHECK (empates >= 0),
    derrotas INTEGER NOT NULL CHECK (derrotas >= 0),
    gols_feitos INTEGER NOT NULL CHECK (gols_feitos >= 0),
    gols_sofridos INTEGER NOT NULL CHECK (gols_sofridos >= 0),
    passes_medios INTEGER NOT NULL CHECK (passes_medios >= 0),
    posse NUMERIC(5,2) NOT NULL CHECK (posse BETWEEN 0 AND 100),
    CHECK (vitorias + empates + derrotas = jogos)
);

CREATE TABLE alemanha_campeao (
    temporada VARCHAR(7) PRIMARY KEY,
    campeao VARCHAR(100) NOT NULL,
    jogos INTEGER NOT NULL CHECK (jogos > 0),
    vitorias INTEGER NOT NULL CHECK (vitorias >= 0),
    empates INTEGER NOT NULL CHECK (empates >= 0),
    derrotas INTEGER NOT NULL CHECK (derrotas >= 0),
    gols_feitos INTEGER NOT NULL CHECK (gols_feitos >= 0),
    gols_sofridos INTEGER NOT NULL CHECK (gols_sofridos >= 0),
    passes_medios INTEGER NOT NULL CHECK (passes_medios >= 0),
    posse NUMERIC(5,2) NOT NULL CHECK (posse BETWEEN 0 AND 100),
    CHECK (vitorias + empates + derrotas = jogos)
);

CREATE TABLE inglaterra_campeao (
    temporada VARCHAR(7) PRIMARY KEY,
    campeao VARCHAR(100) NOT NULL,
    jogos INTEGER NOT NULL CHECK (jogos > 0),
    vitorias INTEGER NOT NULL CHECK (vitorias >= 0),
    empates INTEGER NOT NULL CHECK (empates >= 0),
    derrotas INTEGER NOT NULL CHECK (derrotas >= 0),
    gols_feitos INTEGER NOT NULL CHECK (gols_feitos >= 0),
    gols_sofridos INTEGER NOT NULL CHECK (gols_sofridos >= 0),
    passes_medios INTEGER NOT NULL CHECK (passes_medios >= 0),
    posse NUMERIC(5,2) NOT NULL CHECK (posse BETWEEN 0 AND 100),
    CHECK (vitorias + empates + derrotas = jogos)
);

CREATE TABLE espanha_media (
    temporada VARCHAR(7) PRIMARY KEY,
    jogos INTEGER NOT NULL CHECK (jogos > 0),
    gols_feitos INTEGER NOT NULL CHECK (gols_feitos >= 0),
    gols_sofridos INTEGER NOT NULL CHECK (gols_sofridos >= 0),
    posse NUMERIC(5,2) NOT NULL CHECK (posse BETWEEN 0 AND 100),
    passes INTEGER NOT NULL CHECK (passes >= 0)
);

CREATE TABLE franca_media (
    temporada VARCHAR(7) PRIMARY KEY,
    jogos INTEGER NOT NULL CHECK (jogos > 0),
    gols_feitos INTEGER NOT NULL CHECK (gols_feitos >= 0),
    gols_sofridos INTEGER NOT NULL CHECK (gols_sofridos >= 0),
    posse NUMERIC(5,2) NOT NULL CHECK (posse BETWEEN 0 AND 100),
    passes INTEGER NOT NULL CHECK (passes >= 0)
);

CREATE TABLE italia_media (
    temporada VARCHAR(7) PRIMARY KEY,
    jogos INTEGER NOT NULL CHECK (jogos > 0),
    gols_feitos INTEGER NOT NULL CHECK (gols_feitos >= 0),
    gols_sofridos INTEGER NOT NULL CHECK (gols_sofridos >= 0),
    posse NUMERIC(5,2) NOT NULL CHECK (posse BETWEEN 0 AND 100),
    passes INTEGER NOT NULL CHECK (passes >= 0)
);

CREATE TABLE alemanha_media (
    temporada VARCHAR(7) PRIMARY KEY,
    jogos INTEGER NOT NULL CHECK (jogos > 0),
    gols_feitos INTEGER NOT NULL CHECK (gols_feitos >= 0),
    gols_sofridos INTEGER NOT NULL CHECK (gols_sofridos >= 0),
    posse NUMERIC(5,2) NOT NULL CHECK (posse BETWEEN 0 AND 100),
    passes INTEGER NOT NULL CHECK (passes >= 0)
);

CREATE TABLE inglaterra_media (
    temporada VARCHAR(7) PRIMARY KEY,
    jogos INTEGER NOT NULL CHECK (jogos > 0),
    gols_feitos INTEGER NOT NULL CHECK (gols_feitos >= 0),
    gols_sofridos INTEGER NOT NULL CHECK (gols_sofridos >= 0),
    posse NUMERIC(5,2) NOT NULL CHECK (posse BETWEEN 0 AND 100),
    passes INTEGER NOT NULL CHECK (passes >= 0)
);

CREATE TABLE espanha_rebaixados (
    temporada VARCHAR(7) PRIMARY KEY,
    jogos INTEGER NOT NULL CHECK (jogos > 0),
    vitorias INTEGER NOT NULL CHECK (vitorias >= 0),
    empates INTEGER NOT NULL CHECK (empates >= 0),
    derrotas INTEGER NOT NULL CHECK (derrotas >= 0),
    gols_feitos INTEGER NOT NULL CHECK (gols_feitos >= 0),
    gols_sofridos INTEGER NOT NULL CHECK (gols_sofridos >= 0),
    passes_medios INTEGER NOT NULL CHECK (passes_medios >= 0),
    posse NUMERIC(5,2) NOT NULL CHECK (posse BETWEEN 0 AND 100),
    CHECK (vitorias + empates + derrotas = jogos)
);

CREATE TABLE franca_rebaixados (
    temporada VARCHAR(7) PRIMARY KEY,
    jogos INTEGER NOT NULL CHECK (jogos > 0),
    vitorias INTEGER NOT NULL CHECK (vitorias >= 0),
    empates INTEGER NOT NULL CHECK (empates >= 0),
    derrotas INTEGER NOT NULL CHECK (derrotas >= 0),
    gols_feitos INTEGER NOT NULL CHECK (gols_feitos >= 0),
    gols_sofridos INTEGER NOT NULL CHECK (gols_sofridos >= 0),
    passes_medios INTEGER NOT NULL CHECK (passes_medios >= 0),
    posse NUMERIC(5,2) NOT NULL CHECK (posse BETWEEN 0 AND 100),
    CHECK (vitorias + empates + derrotas = jogos)
);

CREATE TABLE italia_rebaixados (
    temporada VARCHAR(7) PRIMARY KEY,
    jogos INTEGER NOT NULL CHECK (jogos > 0),
    vitorias INTEGER NOT NULL CHECK (vitorias >= 0),
    empates INTEGER NOT NULL CHECK (empates >= 0),
    derrotas INTEGER NOT NULL CHECK (derrotas >= 0),
    gols_feitos INTEGER NOT NULL CHECK (gols_feitos >= 0),
    gols_sofridos INTEGER NOT NULL CHECK (gols_sofridos >= 0),
    passes_medios INTEGER NOT NULL CHECK (passes_medios >= 0),
    posse NUMERIC(5,2) NOT NULL CHECK (posse BETWEEN 0 AND 100),
    CHECK (vitorias + empates + derrotas = jogos)
);

CREATE TABLE alemanha_rebaixados (
    temporada VARCHAR(7) PRIMARY KEY,
    jogos INTEGER NOT NULL CHECK (jogos > 0),
    vitorias INTEGER NOT NULL CHECK (vitorias >= 0),
    empates INTEGER NOT NULL CHECK (empates >= 0),
    derrotas INTEGER NOT NULL CHECK (derrotas >= 0),
    gols_feitos INTEGER NOT NULL CHECK (gols_feitos >= 0),
    gols_sofridos INTEGER NOT NULL CHECK (gols_sofridos >= 0),
    passes_medios INTEGER NOT NULL CHECK (passes_medios >= 0),
    posse NUMERIC(5,2) NOT NULL CHECK (posse BETWEEN 0 AND 100),
    CHECK (vitorias + empates + derrotas = jogos)
);

CREATE TABLE inglaterra_rebaixados (
    temporada VARCHAR(7) PRIMARY KEY,
    jogos INTEGER NOT NULL CHECK (jogos > 0),
    vitorias INTEGER NOT NULL CHECK (vitorias >= 0),
    empates INTEGER NOT NULL CHECK (empates >= 0),
    derrotas INTEGER NOT NULL CHECK (derrotas >= 0),
    gols_feitos INTEGER NOT NULL CHECK (gols_feitos >= 0),
    gols_sofridos INTEGER NOT NULL CHECK (gols_sofridos >= 0),
    passes_medios INTEGER NOT NULL CHECK (passes_medios >= 0),
    posse NUMERIC(5,2) NOT NULL CHECK (posse BETWEEN 0 AND 100),
    CHECK (vitorias + empates + derrotas = jogos)
);

CREATE TABLE champions_campeao (
    temporada VARCHAR(7) PRIMARY KEY,
    campeao VARCHAR(100) NOT NULL,
    jogos INTEGER NOT NULL CHECK (jogos > 0),
    vitorias INTEGER NOT NULL CHECK (vitorias >= 0),
    empates INTEGER NOT NULL CHECK (empates >= 0),
    derrotas INTEGER NOT NULL CHECK (derrotas >= 0),
    gols_feitos INTEGER NOT NULL CHECK (gols_feitos >= 0),
    gols_sofridos INTEGER NOT NULL CHECK (gols_sofridos >= 0),
    passes_medios INTEGER NOT NULL CHECK (passes_medios >= 0),
    posse NUMERIC(5,2) NOT NULL CHECK (posse BETWEEN 0 AND 100),
    CHECK (vitorias + empates + derrotas = jogos)
);

CREATE TABLE champions_media_alta (
    temporada VARCHAR(7) PRIMARY KEY,
    jogos NUMERIC(5,2) NOT NULL CHECK (jogos > 0),
    gols_feitos INTEGER NOT NULL CHECK (gols_feitos >= 0),
    gols_sofridos INTEGER NOT NULL CHECK (gols_sofridos >= 0),
    posse NUMERIC(5,2) NOT NULL CHECK (posse BETWEEN 0 AND 100),
    passes INTEGER NOT NULL CHECK (passes >= 0)
);

COMMIT;
