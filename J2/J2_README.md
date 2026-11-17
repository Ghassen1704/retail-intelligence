# TP Jour 2 — UC-03 et UC-04 : HDFS et NiFi

Ce dossier regroupe les livrables documentaires et les preuves visuelles de la partie obligatoire du TP J2.

## Livrables

| N° | Livrable | Fichier |
|---:|---|---|
| 1 | Fiche d’environnement technique | `01_Fiche_Environnement_Technique.md` |
| 2 | Fiche de découverte Hadoop et HDFS | `02_Fiche_Decouverte_Hadoop_HDFS.md` |
| 3 | Inventaire TPCx-BB | `03_Inventaire_TPCx_BB_J2.md` (complément et renvoi vers l’inventaire J1) |
| 4 | Arborescence du Data Lake | `J2_UC03_Arborescence_Data_Lake_Complete.PNG` |
| 5 | Commandes et résultats HDFS | `05_Commandes_Resultats_HDFS.md` |
| 6 | Preuves du dépôt et contrôles | `06_Preuves_Depot_Controles_Stockage.md` + captures |
| 7 | Schéma du flux NiFi | `J2_UC04_Flux_NiFi_GetFile_PutHDFS.PNG` |
| 8 | Export/configuration NiFi | `UC04_Ingestion_NiFi.json` |
| 9 | Preuves d’exécution et de dépôt | `J2_UC04_Preuve_Ingestion_HDFS_NiFi.PNG` |
| 10 | Tableau des erreurs et corrections | `10_Tableau_Erreurs_Corrections.md` |
| 11 | Documentation de provenance | `11_Documentation_Provenance_Ingestion.md` |
| 12 | Script de repli | `12_script_repli_ingestion_hdfs.sh` (dépôt manuel si NiFi est indisponible) |
| 13 | README de reproduction | `13_README_Reproduction.md` |

## Résumé technique UC-03

L’arborescence documentée comprend les zones `raw`, `bronze`, `silver`, `gold`, `quality` et `logs`. Le compte rendu J2 indique un dépôt manuel dans `raw/tpcxbb/initial/`, puis une copie vers `bronze/tpcxbb/`.

## Résumé technique UC-04

Flux : `GetFile` → `PutHDFS`.

- Entrée locale : `/home/ghassen/nifi_input`
- Destination HDFS : `/retail-lake/raw/tpcxbb/nifi_ingest`
- Fichiers visibles dans la preuve : `store_sales.dat` et `item.dat`
- Export : `UC04_Ingestion_NiFi.json`

## Réutilisation des livrables J1

L’inventaire complet et la provenance générale du kit restent documentés dans `../deliverables/inventory.md` et `../deliverables/kit_provenance.md`. Les anomalies de données J1 sont reprises dans le tableau J2 des erreurs/corrections.

## Note de transparence

Les versions exactes d’Ubuntu, Hadoop et Java et les sorties terminal brutes des commandes HDFS ne sont pas présentes dans les éléments transmis. Les documents les signalent explicitement au lieu d’inventer des valeurs. Les captures fournies sont conservées comme preuves visuelles.
