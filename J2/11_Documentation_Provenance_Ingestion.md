# 11 — Documentation de la provenance et de la chaîne d’ingestion

## Provenance des données

Le jeu utilisé est TPCx-BB, un jeu de données synthétique au format TPC-DS. Les fichiers sont au format `.dat`, séparés par `|` et sans en-tête. La provenance détaillée du kit est documentée dans `../deliverables/kit_provenance.md`.

| Élément | Information documentée |
|---|---|
| Kit | `data/` et `data_refresh/` |
| Nombre de fichiers inventoriés | 35 fichiers `.dat` (24 dans `data/`, 11 dans `data_refresh/`) selon l’inventaire J1 |
| Source exacte / URL de téléchargement | Non communiquée dans les éléments disponibles |
| Version du kit | Non communiquée |
| Nature | Jeu synthétique à usage pédagogique |
| Format | Pipe-delimited, sans en-tête |

## Chaîne de provenance UC-04

```text
Jeu TPCx-BB fourni pour le TP
        |
        v
Fichiers sélectionnés : store_sales.dat et item.dat
        |
        v
Répertoire local surveillé par NiFi
/home/ghassen/nifi_input
        |
        v
GetFile (NiFi)
        |
        v
PutHDFS (NiFi)
        |
        v
HDFS : /retail-lake/raw/tpcxbb/nifi_ingest
```

## Paramètres qui assurent la traçabilité

- Le processeur `GetFile` lit le répertoire `/home/ghassen/nifi_input`.
- Le polling est configuré à 30 secondes et la taille de lot à 10.
- `Keep Source File` est configuré à `false` : le fichier local est supprimé après sa récupération par GetFile.
- Le processeur `PutHDFS` écrit dans `/retail-lake/raw/tpcxbb/nifi_ingest`.
- Les fichiers Hadoop utilisés sont `core-site.xml` et `hdfs-site.xml` sous `/usr/local/hadoop/etc/hadoop/`.
- La stratégie de conflit est `fail` et la stratégie d’écriture est `writeAndRename`.

## Limites

La source de téléchargement et la version exacte du kit ne sont pas indiquées dans les documents J1. L’export NiFi décrit la configuration, mais ne constitue pas à lui seul un journal d’exécution horodaté. Les preuves visuelles de l’exécution et du dépôt sont fournies séparément dans `J2_UC04_Preuve_Ingestion_HDFS_NiFi.PNG`.
