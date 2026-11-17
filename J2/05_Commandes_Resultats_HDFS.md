# 05 — Commandes et résultats des manipulations HDFS

## Opérations réalisées (d’après le compte rendu J2)

Le compte rendu J2 indique les opérations suivantes :

1. Création de l’arborescence du Data Lake avec les zones `raw`, `bronze`, `silver`, `gold`, `quality` et `logs`.
2. Dépôt manuel des fichiers dans `raw/tpcxbb/initial/`.
3. Copie des fichiers depuis la zone `raw` vers `bronze/tpcxbb/`.
4. Dépôt par NiFi dans `/retail-lake/raw/tpcxbb/nifi_ingest`.

## Commandes de référence

Les commandes ci-dessous documentent les opérations et permettent de les reproduire. Les sorties terminal exactes ne sont pas incluses dans l’archive fournie ; les preuves visuelles disponibles sont référencées dans la section suivante.

```bash
# Création des zones du Data Lake
hdfs dfs -mkdir -p /retail-lake/{raw,bronze,silver,gold,quality,logs}

# Création des sous-répertoires TPCx-BB
hdfs dfs -mkdir -p /retail-lake/raw/tpcxbb/initial
hdfs dfs -mkdir -p /retail-lake/raw/tpcxbb/nifi_ingest
hdfs dfs -mkdir -p /retail-lake/bronze/tpcxbb

# Dépôt manuel de fichiers depuis le répertoire local courant
hdfs dfs -put store_sales.dat item.dat /retail-lake/raw/tpcxbb/initial/

# Copie HDFS vers la zone bronze
hdfs dfs -cp /retail-lake/raw/tpcxbb/initial/store_sales.dat /retail-lake/bronze/tpcxbb/
hdfs dfs -cp /retail-lake/raw/tpcxbb/initial/item.dat /retail-lake/bronze/tpcxbb/

# Contrôle des dépôts
hdfs dfs -ls -h /retail-lake/raw/tpcxbb/initial
hdfs dfs -ls -h /retail-lake/bronze/tpcxbb
hdfs dfs -ls -h /retail-lake/raw/tpcxbb/nifi_ingest

# Contrôle des tailles
hdfs dfs -du -h /retail-lake/raw/tpcxbb
```

> Remarque : la syntaxe d’expansion `{...}` est interprétée par le shell Bash avant l’appel à `hdfs dfs`. Si le shell utilisé ne prend pas en charge cette expansion, créer chaque répertoire avec une commande `hdfs dfs -mkdir -p` séparée.

## Résultats documentés

- L’arborescence complète du Data Lake est présente dans la capture `J2_UC03_Arborescence_Data_Lake_Complete.PNG`.
- Le compte rendu J2 indique que les fichiers ont été déposés dans `raw/tpcxbb/initial/`, puis copiés vers `bronze/tpcxbb/`.
- La capture `J2_UC04_Preuve_Ingestion_HDFS_NiFi.PNG` montre la preuve de dépôt NiFi des fichiers `store_sales.dat` et `item.dat`.

Les sorties de commandes détaillées (valeurs exactes de tailles, dates et permissions) ne sont pas reproduites ici car elles ne sont pas présentes dans les fichiers transmis.
