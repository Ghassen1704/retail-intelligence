#Retail Intelligence Platform
### UC-01 & UC-02 — IPSSI Mastère Dev, Data & IA (5e année)

**Auteur** : Ghassen
**Source de données** : TPCx-BB (jeu synthétique, format TPC-DS)

## Contenu du dépôt

| Chemin | Contenu |
|---|---|
| `TP_J1_Retail_Intelligence_GHASSEN.pdf` | Rapport principal (UC-01 + UC-02) |
| `latex/main.tex` | Source LaTeX du rapport (Overleaf) |
| `deliverables/` | Les 10 livrables en Markdown |
| `evidence/` | Preuves d'exécution (hashes, profils, comptages) |

## Démarche

1. Inventaire exhaustif des 34 fichiers `.dat` fournis
2. Vérification de chaque jointure avant modélisation (unicité, nulls, cardinalité)
3. Définition de 11 KPIs sur colonnes réelles
4. Conception architecture locale 4 couches + déclinaison Azure cible
5. Documentation des anomalies, décisions et hypothèses (5 statuts)

## Chiffres clés

- 34 fichiers `.dat` (23 dans `data/`, 11 dans `data_refresh/`)
- 6 profils utilisateurs · 13 questions décisionnelles · 11 KPIs
- 10 jointures vérifiées · 3 à valider
- `data_refresh/` ≈ 1–2 % du volume principal → batch incrémental

## Non inclus dans ce dépôt

Les dossiers `data/` (1,1 Go) et `data_refresh/` (8 Mo) contiennent le jeu TPCx-BB fourni
par le formateur. Ils sont exclus du dépôt pour des raisons de taille et de licence.
La démarche d'exploration est entièrement documentée dans `deliverables/inventory.md`
et `evidence/`.
