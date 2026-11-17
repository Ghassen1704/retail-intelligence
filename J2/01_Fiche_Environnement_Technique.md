# 01 — Fiche d’environnement technique

## Périmètre

Cette fiche décrit l’environnement utilisé pour les manipulations UC-03 (Data Lake HDFS) et UC-04 (ingestion NiFi) du TP Jour 2 de la plateforme Retail Intelligence.

| Élément | Information disponible dans les livrables | Statut |
|---|---|---|
| Poste de travail | Windows avec environnement Linux WSL / Ubuntu mentionné dans les livrables du projet | Documenté |
| Distribution Linux | Ubuntu sous WSL (version exacte non consignée) | À préciser si exigé |
| Hadoop / HDFS | Utilisé pour le Data Lake ; fichiers de configuration référencés dans `/usr/local/hadoop/etc/hadoop/` | Version non consignée |
| Configuration Hadoop | `core-site.xml` et `hdfs-site.xml` | Chemins présents dans l’export NiFi |
| Apache NiFi | 2.12.0 (version du bundle des processeurs dans l’export fourni) | Vérifié dans l’export |
| Répertoire d’entrée NiFi | `/home/ghassen/nifi_input` | Vérifié dans l’export |
| Répertoire HDFS cible NiFi | `/retail-lake/raw/tpcxbb/nifi_ingest` | Vérifié dans l’export |
| Jeu de données | TPCx-BB synthétique, fichiers `.dat` au format pipe-delimited sans en-tête | Documenté en J1 |

## Composants du flux

- `GetFile` : surveille le répertoire local `/home/ghassen/nifi_input`.
- `PutHDFS` : dépose le contenu des FlowFiles dans `/retail-lake/raw/tpcxbb/nifi_ingest`.
- Les fichiers de configuration Hadoop déclarés pour `PutHDFS` sont `core-site.xml` et `hdfs-site.xml` situés sous `/usr/local/hadoop/etc/hadoop/`.

## Paramètres NiFi relevés dans l’export

| Paramètre | Valeur |
|---|---|
| Polling Interval | 30 sec |
| Batch Size | 10 |
| Keep Source File | false |
| Ignore Hidden Files | true |
| Recurse Subdirectories | true |
| Writing Strategy | writeAndRename |
| Compression Codec | NONE |
| Conflict Resolution Strategy | fail |
| Retry Count (PutHDFS) | 10 |

## Limites de traçabilité

Les livrables fournis ne précisent pas la version exacte d’Ubuntu, de Hadoop, de Java, ni les ressources CPU/RAM de la machine. Ces informations ne sont donc pas inventées dans cette fiche. La version 2.12.0 identifiée correspond aux bundles NiFi de l’export JSON ; elle ne constitue pas une preuve indépendante de la version du serveur NiFi installé.
