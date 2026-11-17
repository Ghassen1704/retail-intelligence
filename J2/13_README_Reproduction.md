# 13 — README de reproduction du TP Jour 2

## Objectif

Ce document décrit comment reproduire les manipulations UC-03 (création du Data Lake HDFS) et UC-04 (ingestion de fichiers TPCx-BB avec Apache NiFi).

## Environnement documenté

- Poste : Windows avec WSL / Ubuntu mentionné dans le projet.
- Hadoop : utilisé via HDFS ; version exacte non consignée dans les livrables transmis.
- Configuration Hadoop référencée par NiFi : `/usr/local/hadoop/etc/hadoop/core-site.xml` et `/usr/local/hadoop/etc/hadoop/hdfs-site.xml`.
- NiFi : export des processeurs basé sur les bundles version 2.12.0.
- Données : fichiers TPCx-BB `.dat`, pipe-delimited, sans en-tête.

## 1. Préparer les répertoires HDFS

Vérifier que les services Hadoop/HDFS sont démarrés, puis exécuter :

```bash
hdfs dfs -mkdir -p /retail-lake/raw/tpcxbb/initial
hdfs dfs -mkdir -p /retail-lake/raw/tpcxbb/nifi_ingest
hdfs dfs -mkdir -p /retail-lake/bronze/tpcxbb
hdfs dfs -mkdir -p /retail-lake/silver
hdfs dfs -mkdir -p /retail-lake/gold
hdfs dfs -mkdir -p /retail-lake/quality
hdfs dfs -mkdir -p /retail-lake/logs
hdfs dfs -ls -R /retail-lake
```

## 2. Dépôt manuel (si nécessaire)

Depuis le répertoire local contenant les fichiers :

```bash
hdfs dfs -put store_sales.dat item.dat /retail-lake/raw/tpcxbb/initial/
hdfs dfs -ls -h /retail-lake/raw/tpcxbb/initial
```

Copie vers la zone bronze :

```bash
hdfs dfs -cp /retail-lake/raw/tpcxbb/initial/store_sales.dat /retail-lake/bronze/tpcxbb/
hdfs dfs -cp /retail-lake/raw/tpcxbb/initial/item.dat /retail-lake/bronze/tpcxbb/
hdfs dfs -ls -h /retail-lake/bronze/tpcxbb
```

## 3. Configurer NiFi

Importer le fichier `UC04_Ingestion_NiFi.json` dans NiFi (ou reconstruire le flux à partir de la capture). Le flux comporte :

1. `GetFile` — répertoire d’entrée : `/home/ghassen/nifi_input` ; polling : 30 sec ; batch size : 10 ; ignore hidden files : true ; recurse subdirectories : true ; keep source file : false.
2. `PutHDFS` — répertoire HDFS : `/retail-lake/raw/tpcxbb/nifi_ingest` ; configuration Hadoop : `/usr/local/hadoop/etc/hadoop/core-site.xml,/usr/local/hadoop/etc/hadoop/hdfs-site.xml` ; stratégie d’écriture : `writeAndRename` ; codec : `NONE` ; résolution de conflit : `fail`.

Placer les fichiers à ingérer dans `/home/ghassen/nifi_input`, puis démarrer/activer les processeurs selon l’interface NiFi. Le processeur GetFile interroge le répertoire toutes les 30 secondes.

## 4. Vérifier le dépôt

```bash
hdfs dfs -ls -h /retail-lake/raw/tpcxbb/nifi_ingest
hdfs dfs -du -h /retail-lake/raw/tpcxbb/nifi_ingest
```

Les deux fichiers utilisés dans la preuve fournie sont `store_sales.dat` et `item.dat`.

## 5. Paramètres et sécurité

Les chemins locaux et HDFS ci-dessus sont ceux présents dans les livrables. Aucun mot de passe, jeton ou secret n’est requis dans ce README. Ne pas publier de secrets ou de paramètres sensibles dans l’export NiFi.

## 6. Arrêt

- Arrêter/désactiver les processeurs du flux NiFi depuis l’interface NiFi.
- Arrêter les services Hadoop/HDFS avec les scripts de l’installation locale, selon le mode de démarrage utilisé. Les commandes exactes de démarrage/arrêt ne sont pas indiquées dans les livrables fournis et dépendent de l’installation.

## 7. Fichiers de preuve

- `J2_UC03_Arborescence_Data_Lake_Complete.PNG` — structure HDFS.
- `J2_UC04_Flux_NiFi_GetFile_PutHDFS.PNG` — schéma du flux.
- `J2_UC04_Preuve_Ingestion_HDFS_NiFi.PNG` — preuve de dépôt.
- `UC04_Ingestion_NiFi.json` — export de configuration NiFi.

## Limites de reproduction

Les versions précises d’Ubuntu, Hadoop et Java ainsi que les commandes de démarrage des services ne figurent pas dans le dossier source. Elles doivent être adaptées à l’installation locale ; aucune version ou sortie de commande n’est inventée dans ce document.
