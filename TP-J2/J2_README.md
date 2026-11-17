# TP Jour 2 - UC-03 & UC-04 : HDFS et NiFi

## UC-03 : Data Lake HDFS
- **Arborescence créée** : `raw`, `bronze`, `silver`, `gold`, `quality`, `logs`.
- **Preuve** : Voir la capture `J2_UC03_Arborescence_Data_Lake_Complete.png`.
- **Dépôt manuel** : Les fichiers ont été copiés dans `raw/tpcxbb/initial/` puis copiés vers `bronze/tpcxbb/`.

## UC-04 : Ingestion avec Apache NiFi
- **Flux construit** : `GetFile` (lecture depuis `/home/ghassen/nifi_input`) -> `PutHDFS` (écriture vers `/retail-lake/raw/tpcxbb/nifi_ingest`).
- **Preuve visuelle** : Voir `J2_UC04_Flux_NiFi_GetFile_PutHDFS.png`.
- **Preuve d'ingestion** : Voir `J2_UC04_Preuve_Ingestion_HDFS_NiFi.png` (les fichiers `store_sales.dat` et `item.dat` sont bien dans HDFS).
- **Configuration** : Le fichier `J2_UC04_Flux_NiFi.json` contient l'export complet du flux.