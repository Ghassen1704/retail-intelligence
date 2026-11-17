#!/usr/bin/env bash
# Script de repli : dépôt manuel dans HDFS si le flux NiFi est indisponible.
# Usage : ./12_script_repli_ingestion_hdfs.sh /chemin/vers/store_sales.dat /chemin/vers/item.dat
set -euo pipefail

DEST="/retail-lake/raw/tpcxbb/nifi_ingest"

if [[ "$#" -lt 1 ]]; then
  echo "Usage: $0 fichier1.dat [fichier2.dat ...]" >&2
  exit 2
fi

command -v hdfs >/dev/null 2>&1 || {
  echo "Erreur : commande hdfs introuvable. Vérifier l'installation et le PATH Hadoop." >&2
  exit 127
}

hdfs dfs -mkdir -p "$DEST"
for file in "$@"; do
  if [[ ! -f "$file" ]]; then
    echo "Fichier local introuvable : $file" >&2
    exit 1
  fi
  hdfs dfs -put -f "$file" "$DEST/"
done

echo "Contrôle du répertoire cible : $DEST"
hdfs dfs -ls -h "$DEST"
