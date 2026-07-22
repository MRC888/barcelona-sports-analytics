"""Gera as 20 visualizações do projeto Barcelona Sports Analytics.

Uso a partir da raiz do repositório:
    python python/visualizacoes.py

Caminhos personalizados:
    python python/visualizacoes.py --data-dir data/csv --output-dir images/gerados
"""
from __future__ import annotations

import argparse
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_DATA_DIR = ROOT / "data" / "csv"
DEFAULT_OUTPUT_DIR = ROOT / "images" / "gerados"

LEAGUES = ["espanha", "inglaterra", "italia", "alemanha", "franca"]
LABELS = {
    "espanha": "Espanha",
    "inglaterra": "Inglaterra",
    "italia": "Itália",
    "alemanha": "Alemanha",
    "franca": "França",
}
REQUIRED_TABLES = [
    "barcelona",
    "champions_campeao",
    "champions_media_alta",
    *[f"{league}_{suffix}" for league in LEAGUES for suffix in ("campeao", "media", "rebaixados")],
]


def load(data_dir: Path, name: str) -> pd.DataFrame:
    path = data_dir / f"{name}.csv"
    if not path.exists():
        raise FileNotFoundError(f"Arquivo obrigatório não encontrado: {path}")
    frame = pd.read_csv(path, encoding="utf-8-sig")
    if len(frame) != 16:
        raise ValueError(f"{name}.csv deveria ter 16 registros, mas possui {len(frame)}.")
    if "temporada" not in frame.columns:
        raise ValueError(f"{name}.csv não possui a coluna 'temporada'.")
    if frame["temporada"].duplicated().any():
        raise ValueError(f"{name}.csv possui temporadas duplicadas.")
    return frame


def add_year(frame: pd.DataFrame) -> pd.DataFrame:
    result = frame.copy()
    result["ano_inicio"] = result["temporada"].astype(str).str[:4].astype(int)
    return result.sort_values("ano_inicio").reset_index(drop=True)


def save(output_dir: Path, filename: str) -> None:
    output_dir.mkdir(parents=True, exist_ok=True)
    plt.tight_layout()
    plt.savefig(output_dir / filename, dpi=300, bbox_inches="tight")
    plt.close()


def line_chart(x, series, labels, title, ylabel, output_dir, filename) -> None:
    plt.figure(figsize=(12, 6))
    for values, label in zip(series, labels):
        plt.plot(x, values, marker="o", label=label)
    plt.title(title)
    plt.xlabel("Temporada")
    plt.ylabel(ylabel)
    plt.xticks(rotation=45)
    plt.grid(alpha=0.25)
    if len(labels) > 1:
        plt.legend()
    save(output_dir, filename)


def aligned_comparison(left: pd.DataFrame, right: pd.DataFrame, left_col: str, right_col: str) -> pd.DataFrame:
    return left[["temporada", left_col]].merge(
        right[["temporada", right_col]],
        on="temporada",
        how="inner",
        validate="one_to_one",
        suffixes=("_left", "_right"),
    )


def main(data_dir: Path, output_dir: Path) -> None:
    missing = [name for name in REQUIRED_TABLES if not (data_dir / f"{name}.csv").exists()]
    if missing:
        raise FileNotFoundError("CSVs ausentes: " + ", ".join(missing))

    barca = add_year(load(data_dir, "barcelona"))
    esp_media = add_year(load(data_dir, "espanha_media"))
    champion_ucl = add_year(load(data_dir, "champions_campeao"))
    semifinalists_ucl = add_year(load(data_dir, "champions_media_alta"))
    barca["percentual_vitorias"] = barca["vitorias"] / barca["jogos"] * 100

    def era(tecnico: str) -> str:
        if tecnico == "rijkaard":
            return "Rijkaard"
        if tecnico == "guardiola":
            return "Guardiola"
        if tecnico in {"tito vilanova", "gerardo martino"}:
            return "Pós-Guardiola"
        if tecnico == "luis enrique":
            return "Luis Enrique"
        if tecnico in {"ernesto valverde", "quique setien"}:
            return "Transição Moderna"
        return "Outro"

    era_order = ["Rijkaard", "Guardiola", "Pós-Guardiola", "Luis Enrique", "Transição Moderna"]
    barca["era"] = barca["tecnico"].apply(era)

    line_chart(barca["temporada"], [barca["posse"]], ["Barcelona"], "Evolução da posse de bola do Barcelona", "Posse (%)", output_dir, "01_barcelona_posse_temporada.png")
    line_chart(barca["temporada"], [barca["passes_medios"]], ["Barcelona"], "Evolução dos passes médios do Barcelona", "Passes médios", output_dir, "02_barcelona_passes_temporada.png")
    line_chart(barca["temporada"], [barca["gols_feitos"], barca["gols_sofridos"]], ["Gols feitos", "Gols sofridos"], "Evolução de gols do Barcelona", "Gols", output_dir, "03_barcelona_gols_temporada.png")
    line_chart(barca["temporada"], [barca["percentual_vitorias"]], ["Vitórias"], "Percentual de vitórias do Barcelona", "Vitórias (%)", output_dir, "04_barcelona_percentual_vitorias.png")

    era_avg = (
        barca.groupby("era")
        .agg(posse=("posse", "mean"), passes=("passes_medios", "mean"), vitorias=("percentual_vitorias", "mean"))
        .reindex(era_order)
    )
    for column, title, ylabel, filename in [
        ("posse", "Posse média do Barcelona por era", "Posse média (%)", "05_barcelona_posse_media_era.png"),
        ("passes", "Passes médios do Barcelona por era", "Passes médios", "06_barcelona_passes_media_era.png"),
        ("vitorias", "Percentual médio de vitórias do Barcelona por era", "Vitórias (%)", "07_barcelona_vitorias_media_era.png"),
    ]:
        plt.figure(figsize=(11, 6))
        era_avg[column].plot(kind="bar")
        plt.title(title)
        plt.xlabel("Era")
        plt.ylabel(ylabel)
        plt.xticks(rotation=25)
        save(output_dir, filename)

    barca_spain = barca[["temporada", "posse", "passes_medios"]].merge(
        esp_media[["temporada", "posse", "passes"]],
        on="temporada",
        validate="one_to_one",
        suffixes=("_barcelona", "_espanha"),
    )
    line_chart(barca_spain["temporada"], [barca_spain["posse_barcelona"], barca_spain["posse_espanha"]], ["Barcelona", "Média Espanha"], "Posse: Barcelona vs média da Espanha", "Posse (%)", output_dir, "08_barcelona_vs_espanha_posse.png")
    line_chart(barca_spain["temporada"], [barca_spain["passes_medios"], barca_spain["passes"]], ["Barcelona", "Média Espanha"], "Passes: Barcelona vs média da Espanha", "Passes", output_dir, "09_barcelona_vs_espanha_passes.png")
    plt.figure(figsize=(12, 6))
    plt.bar(barca_spain["temporada"], barca_spain["posse_barcelona"] - barca_spain["posse_espanha"])
    plt.title("Diferença de posse: Barcelona - média da Espanha")
    plt.xlabel("Temporada")
    plt.ylabel("Diferença (p.p.)")
    plt.xticks(rotation=45)
    save(output_dir, "10_barcelona_diferenca_posse_espanha.png")

    champions = [add_year(load(data_dir, f"{league}_campeao")) for league in LEAGUES]
    relegated = [add_year(load(data_dir, f"{league}_rebaixados")) for league in LEAGUES]
    league_labels = [LABELS[league] for league in LEAGUES]

    for metric, ylabel, filename in [
        ("posse", "Posse média (%)", "11_campeoes_vs_rebaixados_posse_liga.png"),
        ("passes_medios", "Passes médios", "12_campeoes_vs_rebaixados_passes_liga.png"),
    ]:
        champion_values = [frame[metric].mean() for frame in champions]
        relegated_values = [frame[metric].mean() for frame in relegated]
        positions = list(range(len(league_labels)))
        width = 0.38
        plt.figure(figsize=(11, 6))
        plt.bar([position - width / 2 for position in positions], champion_values, width=width, label="Campeões")
        plt.bar([position + width / 2 for position in positions], relegated_values, width=width, label="Média dos rebaixados")
        plt.xticks(positions, league_labels, rotation=20)
        plt.ylabel(ylabel)
        plt.title(f"{ylabel}: campeões vs média dos rebaixados por liga")
        plt.legend()
        save(output_dir, filename)

    for metric, ylabel, filename in [
        ("posse", "Posse (%)", "13_posse_campeoes_cinco_ligas.png"),
        ("passes_medios", "Passes médios", "14_passes_campeoes_cinco_ligas.png"),
    ]:
        plt.figure(figsize=(13, 7))
        for league, frame in zip(LEAGUES, champions):
            plt.plot(frame["temporada"], frame[metric], marker="o", label=LABELS[league])
        plt.title(f"Evolução de {ylabel.lower()} dos campeões das cinco grandes ligas")
        plt.xlabel("Temporada")
        plt.ylabel(ylabel)
        plt.xticks(rotation=45)
        plt.grid(alpha=0.25)
        plt.legend()
        save(output_dir, filename)

    all_champions = pd.concat(
        [frame.assign(liga=LABELS[league]) for league, frame in zip(LEAGUES, champions)],
        ignore_index=True,
    )
    all_champions["rotulo"] = all_champions["temporada"] + " - " + all_champions["campeao"]
    for largest, title, filename in [
        (True, "Top 10 campeões com maior posse", "15_top10_campeoes_maior_posse.png"),
        (False, "Top 10 campeões com menor posse", "16_top10_campeoes_menor_posse.png"),
    ]:
        top = all_champions.nlargest(10, "posse") if largest else all_champions.nsmallest(10, "posse")
        plt.figure(figsize=(12, 6))
        plt.bar(top["rotulo"], top["posse"])
        plt.title(title)
        plt.ylabel("Posse (%)")
        plt.xticks(rotation=70, ha="right")
        save(output_dir, filename)

    champions_comparison = champion_ucl[["temporada", "posse", "passes_medios"]].merge(
        semifinalists_ucl[["temporada", "posse", "passes"]],
        on="temporada",
        validate="one_to_one",
        suffixes=("_campeao", "_semifinalistas"),
    )
    line_chart(champions_comparison["temporada"], [champions_comparison["posse_campeao"], champions_comparison["posse_semifinalistas"]], ["Campeão", "Média dos semifinalistas"], "Champions: posse do campeão vs média dos semifinalistas", "Posse (%)", output_dir, "17_champions_posse_campeao_vs_semifinalistas.png")
    line_chart(champions_comparison["temporada"], [champions_comparison["passes_medios"], champions_comparison["passes"]], ["Campeão", "Média dos semifinalistas"], "Champions: passes do campeão vs média dos semifinalistas", "Passes", output_dir, "18_champions_passes_campeao_vs_semifinalistas.png")
    plt.figure(figsize=(12, 6))
    plt.bar(champions_comparison["temporada"], champions_comparison["posse_campeao"] - champions_comparison["posse_semifinalistas"])
    plt.axhline(0, linewidth=1)
    plt.title("Champions: diferença de posse do campeão para a média dos semifinalistas")
    plt.ylabel("Diferença (p.p.)")
    plt.xticks(rotation=45)
    save(output_dir, "19_champions_diferenca_posse.png")

    bins = [0, 50, 55, 65, 101]
    profile_labels = ["Baixa posse", "Posse intermediária", "Alta posse", "Posse muito alta"]
    profiles = pd.cut(all_champions["posse"], bins=bins, labels=profile_labels, right=False).value_counts().reindex(profile_labels, fill_value=0)
    plt.figure(figsize=(10, 6))
    profiles.plot(kind="bar")
    plt.title("Distribuição dos campeões nacionais por perfil de posse")
    plt.ylabel("Total de campeões")
    plt.xlabel("Perfil de posse")
    plt.xticks(rotation=25)
    save(output_dir, "20_distribuicao_campeoes_perfil_posse.png")

    print(f"20 visualizações geradas em: {output_dir.resolve()}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Gera as visualizações do projeto Barcelona Sports Analytics.")
    parser.add_argument("--data-dir", type=Path, default=DEFAULT_DATA_DIR)
    parser.add_argument("--output-dir", type=Path, default=DEFAULT_OUTPUT_DIR)
    arguments = parser.parse_args()
    main(arguments.data_dir.resolve(), arguments.output_dir.resolve())
