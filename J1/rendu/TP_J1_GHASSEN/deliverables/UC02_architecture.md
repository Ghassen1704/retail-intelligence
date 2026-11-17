# UC-02 — Architecture Data proposée

## 1. Faits observés (Vérifié)

- 24 tables dans data/ et 11 tables dans data_refresh/, format TPC-DS, pipe-delimited, sans en-tête.
- Volumétrie principale : inventory 406 Mo (23 255 100 lignes), web_clickstreams 171 Mo, web_sales 128 Mo, store_sales 89 Mo (667 579 lignes).
- Référentiels : item 17 820, customer 99 000, store 12, date_dim 109 573 — clés primaires uniques (vérifié).
- data_refresh/ représente ~1 à 2 % du volume de data/ sur chaque table → batch incrémental.
- Aucune donnée complémentaire fournie à ce stade.

## 2. Limites et manques identifiés

- Pas de stock au niveau magasin (inventory est par entrepôt) → besoin d'une source complémentaire pour le KPI stock magasin.
- web_clickstreams : ordre des colonnes non documenté → non exploitable sans validation.
- 3 lignes avec ss_ticket_number = 0 dans store_sales → règle de nettoyage à appliquer.
- Jeu synthétique TPCx-BB : les résultats ne reflètent pas une entreprise réelle.

## 3. Architecture locale proposée (J1)

Architecture en 4 couches, exécutable en local (WSL / Windows) sans cluster Hadoop ni cloud.

| Couche | Rôle | Contenu | Outil local |
|---|---|---|---|
| Landing (raw) | Conserver l'original immuable | Fichiers .dat de data/ et data_refresh/ | Système de fichiers |
| Staging | Nettoyer et typer | Copies sans CRLF, colonnes nommées, contrôle des nulls | DuckDB ou PostgreSQL |
| Curated | Modéliser | Dimensions (item, store, customer, date_dim) + faits (store_sales, web_sales, store_returns, inventory) | DuckDB / PostgreSQL |
| Serving | Restituer | Requêtes KPI, vues, exports CSV, tableaux de bord | DuckDB views + Excel / Power BI |

Choix structurants :
- Ingestion en batch : data/ = chargement initial, data_refresh/ = incrémental.
- Modèle en étoile : les 4 dimensions ont des clés uniques vérifiées, les faits portent les SK correspondants.
- Séparation raw / staging / curated pour garantir la traçabilité et la reproductibilité.
- Pas d'outil Big Data installé en J1 : la volumétrie (< 1 Go) ne le justifie pas.

## 4. Déclinaison cloud cible (Azure — J4)

| Couche | Service Azure |
|---|---|
| Landing | Azure Blob Storage / ADLS Gen2 |
| Ingestion | Azure Data Factory (chargement initial + incrémental depuis data_refresh) |
| Curated | Databricks (Delta Lake) ou Synapse |
| Serving | Synapse / Power BI |
| Gouvernance | Microsoft Purview (catalogue, lineage) + RBAC |

Organisation en zones bronze / silver / gold, correspondant aux couches landing / staging / curated.

## 5. Justification des choix

- Besoins métier = BI batch (pas de temps réel) → une architecture batch suffit.
- Volumétrie totale inférieure à 1 Go → aucun besoin de Hadoop ou Spark en local.
- La présence de data_refresh/ prouve un besoin d'incrémentalité → à anticiper dès la conception (watermark sur les colonnes *_date_sk / *_sold_date_sk).
- Les jointures sont vérifiées sur les 4 dimensions → un modèle en étoile est défendable.
- Les données manquantes (stock magasin, clickstream non documenté) sont identifiées et exclues du périmètre J1.

## 6. Points restant à vérifier

| Point | Statut |
|---|---|
| Ordre exact des colonnes de web_clickstreams | À valider |
| Sémantique de ss_ticket_number = 0 (sentinel ou ticket réel) | À valider |
| Granularité de ss_ticket_number par magasin | À valider |
| Présence éventuelle de données complémentaires du formateur | À valider |
