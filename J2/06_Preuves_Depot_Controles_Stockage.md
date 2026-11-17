# 06 — Preuves du dépôt et des contrôles de stockage

## Preuves incluses dans le dossier

| Preuve | Fichier | Ce qu’elle permet de vérifier |
|---|---|---|
| Arborescence du Data Lake | `J2_UC03_Arborescence_Data_Lake_Complete.PNG` | Présence de la structure logique du Data Lake et de ses zones. |
| Flux NiFi | `J2_UC04_Flux_NiFi_GetFile_PutHDFS.PNG` | Enchaînement des processeurs GetFile et PutHDFS. |
| Dépôt après ingestion | `J2_UC04_Preuve_Ingestion_HDFS_NiFi.PNG` | Présence des fichiers `store_sales.dat` et `item.dat` dans le répertoire HDFS d’ingestion. |

## Contrôles HDFS associés

Les commandes suivantes servent à contrôler les dépôts et le stockage :

```bash
hdfs dfs -ls -h /retail-lake/raw/tpcxbb/initial
hdfs dfs -ls -h /retail-lake/bronze/tpcxbb
hdfs dfs -ls -h /retail-lake/raw/tpcxbb/nifi_ingest
hdfs dfs -du -h /retail-lake
hdfs dfs -stat '%n %b bytes' /retail-lake/raw/tpcxbb/nifi_ingest/store_sales.dat
```

## Portée et limite des preuves

Les captures jointes sont les preuves visuelles retenues pour le rendu. Les sorties textuelles complètes des commandes HDFS et les valeurs de capacité/réplication ne sont pas archivées dans le ZIP initial. Aucune valeur de taille ou de facteur de réplication n’est donc affirmée dans ce document.
