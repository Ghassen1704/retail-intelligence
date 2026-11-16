# TP J1 — Retail Intelligence Platform
## UC-01 et UC-02 — Livrables

**Source** : TPCx-BB (jeu synthétique), format TPC-DS, pipe-delimited, sans en-tête.
**Emplacement des données** : `data/` (24 tables) et `data_refresh/` (11 tables, ~1–2 % du volume).
**Environnement** : WSL / Ubuntu sur Windows. Aucune installation Hadoop, Spark ou cloud (conforme au TP J1).

## Contenu

| Fichier | Rôle |
|---|---|
| `kit_provenance.md` | Provenance du kit et limites (jeu synthétique) |
| `inventory.md` | Inventaire des 35 fichiers : taille, lignes, colonnes, statut |
| `UC01_users_questions.md` | 6 profils utilisateurs, questions, décisions, priorités |
| `KPIs.md` | 11 KPIs avec formule, unité, sources, limites, statut |
| `relationships.md` | Vérification des jointures avant tout JOIN |
| `functional_schema.md` | Schéma fonctionnel utilisateurs → questions → KPI → sources |
| `UC02_architecture.md` | Architecture locale 4 couches + déclinaison Azure cible |
| `anomaly_log.md` | Anomalies observées dans les données |
| `decision_log.md` | Décisions et hypothèses avec statut et justification |

## Statuts utilisés
**Vérifié** / **Déduit** / **Hypothèse** / **Non disponible** / **À valider** — conformes au support.

## Chiffres clés vérifiés
- 24 tables dans `data/`, 11 dans `data_refresh/`
- `store_sales` : 667 579 lignes, 23 colonnes
- `inventory` : 23 255 100 lignes, 4 colonnes
- Référentiels (clés uniques) : item 17 820 · customer 99 000 · store 12 · date_dim 109 573
- `data_refresh/` ≈ 1–2 % du volume principal → batch incrémental
