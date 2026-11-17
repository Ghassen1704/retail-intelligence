# 02 — Fiche de découverte Hadoop et HDFS

## Objectif

Hadoop fournit un ensemble d’outils pour le stockage et le traitement distribué de données. Dans ce TP, l’élément utilisé est HDFS (*Hadoop Distributed File System*), le système de fichiers distribué destiné à stocker les fichiers du Data Lake.

## Notions essentielles

| Notion | Rôle |
|---|---|
| HDFS | Système de fichiers distribué de Hadoop. Il organise les données en répertoires et fichiers accessibles avec les commandes `hdfs dfs`. |
| NameNode | Gère les métadonnées du système de fichiers : arborescence, noms, permissions et localisation des blocs. |
| DataNode | Stocke les blocs de données et participe aux opérations de lecture/écriture. |
| Bloc HDFS | Un fichier est découpé en blocs pour être stocké et distribué. |
| Réplication | Mécanisme de conservation de copies des blocs afin d’améliorer la tolérance aux pannes. Le facteur réellement configuré n’est pas indiqué dans les éléments fournis. |
| `hdfs dfs` | Interface en ligne de commande pour manipuler les fichiers et répertoires HDFS. |

## Commandes courantes

```bash
# Afficher la racine HDFS
hdfs dfs -ls /

# Créer un répertoire
hdfs dfs -mkdir -p /retail-lake/raw/tpcxbb

# Lister un répertoire
hdfs dfs -ls -h /retail-lake/raw/tpcxbb

# Copier un fichier local vers HDFS
hdfs dfs -put ./store_sales.dat /retail-lake/raw/tpcxbb/initial/

# Copier un fichier HDFS vers un autre emplacement HDFS
hdfs dfs -cp /retail-lake/raw/tpcxbb/initial/store_sales.dat /retail-lake/bronze/tpcxbb/

# Vérifier la taille et les éléments stockés
hdfs dfs -du -h /retail-lake/raw/tpcxbb

# Vérifier l’existence et les informations d’un fichier
hdfs dfs -stat '%n %b bytes' /retail-lake/raw/tpcxbb/initial/store_sales.dat
```

## Organisation logique du Data Lake

L’arborescence observée dans la capture UC-03 comprend les répertoires suivants :

- `raw` : données déposées à l’état brut, sans transformation métier.
- `bronze` : première zone de structuration/conservation après dépôt.
- `silver` : zone destinée aux données nettoyées et harmonisées.
- `gold` : zone destinée aux données préparées pour les usages analytiques.
- `quality` : éléments associés aux contrôles de qualité.
- `logs` : journaux et éléments de suivi.

La capture d’arborescence fournie constitue la preuve visuelle de la structure créée. Les versions Hadoop et les paramètres effectifs de réplication ne figurent pas dans le dossier transmis.
