# 03 — Inventaire des fichiers TPCx-BB utilisés

L’inventaire détaillé des données est déjà réalisé dans le livrable J1 `../deliverables/inventory.md`. Il est réutilisé ici afin d’éviter une duplication et de conserver une seule source de référence.

## Périmètre de l’inventaire J1

- 24 fichiers de données dans `data/`.
- 11 fichiers dans `data_refresh/`.
- Total documenté : 35 fichiers `.dat`.
- Format : valeurs séparées par le caractère `|` (*pipe-delimited*), sans ligne d’en-tête.
- Le jeu TPCx-BB est synthétique et ne représente pas les données d’une entreprise réelle.

## Fichiers explicitement utilisés dans la démonstration NiFi

| Fichier | Rôle dans la démonstration | Destination HDFS |
|---|---|---|
| `store_sales.dat` | Fichier de faits de ventes magasin utilisé pour vérifier le dépôt | `/retail-lake/raw/tpcxbb/nifi_ingest` |
| `item.dat` | Fichier de dimension article utilisé pour vérifier le dépôt | `/retail-lake/raw/tpcxbb/nifi_ingest` |

La présence de ces deux fichiers dans HDFS est indiquée dans le README J2 et illustrée par la capture de preuve d’ingestion.

## Référence

Voir `../deliverables/inventory.md` pour le détail des 35 fichiers, tailles, nombres de lignes, nombres de colonnes et statuts. Les tailles et comptages de cet inventaire sont ceux consignés lors du travail J1.
