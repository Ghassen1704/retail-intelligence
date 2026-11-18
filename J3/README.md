# TP Jour 3 – UC-06 – Retail Intelligence Platform

**Auteur :** Ghassen FOUDA  
**Date :** 18/11/2026  
**Formation :** IPSSI – Data Lakehouse / Data Warehouse  
**Livrable principal :** `Retail_Intelligence_Ghassen_FOUDA.ipynb`

---

## 1. Objectif

Construire une chaîne de transformation **Raw → Silver → Gold** avec PySpark à partir de 4 tables TPCx-BB, pour répondre à deux questions métier du Jour 1 :

| Question J1 | Profil | Jeu Gold produit |
|---|---|---|
| **Q06** – Mon magasin est-il plus ou moins performant que les autres ? | Responsable de magasin | `gold/ventes_magasin_mois` |
| **Q03** – Quels produits et catégories génèrent le plus de CA et de volume ? | Direction commerciale | `gold/ventes_categorie_annee` |

---

## 2. Environnement d'exécution

| Élément | Valeur observée |
|---|---|
| OS | Ubuntu WSL2 (`Linux-6.18.58.1-microsoft-standard-WSL2`) |
| Python | 3.10.12 (dans `.venv` local) |
| Spark / PySpark | **4.2.1** |
| Java | OpenJDK **21.0.13** |
| Mode d'exécution | `local[*]` — une seule machine, **pas un cluster** |
| CPU disponibles | 8 |
| RAM | 7.7 Go |
| Système de fichiers Spark | `file:///` (local, pas de HDFS) |
| Timezone session | `Europe/Paris` |
| Date du traitement | `2026-11-18 15:02:17` |
| Version des règles de nettoyage | `v1` |

> Le notebook est la version locale du travail initialement préparé pour Colab. Il tourne ici sous JupyterLab dans WSL, avec les mêmes fichiers sources.

---

## 3. Prérequis et lancement

### 3.1 Prérequis

- Java 21 installé et `JAVA_HOME` pointant sur `/usr/lib/jvm/java-21-openjdk-amd64` (**pas** `/bin`, **pas** `/bin/java`)
- Python 3.10 avec `pyspark`, `jupyterlab`, `pandas`
- Fichiers `.dat` TPCx-BB présents dans `retail_project/data/<table>/`

### 3.2 Lancement

```bash
cd /mnt/c/Users/found/desktop/ipssi/bd/retail_project/J3
source .venv/bin/activate
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export PATH="$JAVA_HOME/bin:$PATH"
jupyter lab
```

Puis ouvrir `Retail_Intelligence_Ghassen_FOUDA.ipynb` et exécuter **toutes les cellules de haut en bas** (Kernel → Restart & Run All).

---

## 4. Arborescence du projet

```
retail_project/
├── data/                          # Sources TPCx-BB (jamais modifiées)
│   ├── store_sales/store_sales.dat
│   ├── item/item.dat
│   ├── store/store.dat
│   └── date_dim/date_dim.dat
└── J3/
    ├── .venv/                     # Environnement Python isolé
    ├── Retail_Intelligence_Ghassen_FOUDA.ipynb
    ├── README.md                  # Ce fichier
    └── tp3/                       # Toutes les sorties du TP
        ├── raw/                   # Copie des .dat sources
        ├── silver/                # Tables nettoyées (Parquet)
        ├── gold/                  # Tables métier (Parquet)
        ├── quality/               # Rejets + rapport qualité
        └── outputs/               # Fiches, inventaire, benchmarks, journal
```

---

## 5. Sources TPCx-BB

Format : texte `.dat`, séparateur `|`, **sans en-tête**, fins de ligne Windows (CRLF). Les noms de colonnes proviennent du schéma de référence TPCx-BB.

| Source | Fichier | Taille | Lignes | Colonnes | Grain | Clé candidate |
|---|---|---:|---:|---:|---|---|
| `store_sales` | `store_sales.dat` | 88.5 Mo | 667 579 | 23 | 1 ligne = 1 article sur un ticket | `ss_ticket_number + ss_item_sk` |
| `item` | `item.dat` | 6.5 Mo | 17 820 | 22 | 1 ligne = 1 version d'article | `i_item_sk` |
| `store` | `store.dat` | 3.4 Ko | 12 | 29 | 1 ligne = 1 version de magasin | `s_store_sk` |
| `date_dim` | `date_dim.dat` | 14.7 Mo | 109 573 | 28 | 1 ligne = 1 jour du calendrier | `d_date_sk` |

Contrôles effectués à l'étape 2 : chaque fichier ne contient que des lignes au nombre exact de colonnes attendu (aucune ligne malformée).

---

## 6. Structure du notebook

| Section | Contenu |
|---|---|
| **0** | Installation, configuration des chemins, copie des sources vers `tp3/raw/` |
| **1** | Session Spark, fiche d'environnement, test de lecture/écriture |
| **2** | Inventaire des sources (format, volume, grain, clé candidata) |
| **3** | Exploration : schémas, nulls, doublons, périodes, catégories |
| **4** | Règles de nettoyage **R1 à R13** (documentées et justifiées) |
| **5** | Typage explicite + nettoyage → **zone Silver** |
| **6** | Jointures vérifiées (N:1, cardinalité contrôlée) |
| **7** | Agrégations → **zone Gold** (Q06 et Q03) |
| **8** | Écriture et relecture Parquet + comparaison avec CSV |
| **9** | Rapport qualité consolidé |
| **10** | Bilan par zone, journal d'exécution, arrêt Spark |

---

## 7. Résultats clés du traitement

### 7.1 Zone Raw

Copie des 4 fichiers `.dat` dans `tp3/raw/` (`shutil.copy2`, sources préservées).

### 7.2 Zone Silver

| Table | Lignes | Colonnes | Provenance |
|---|---:|---:|---|
| `silver/store_sales` | 667 579 | 26 | +3 colonnes de traçabilité |
| `silver/item` | 17 820 | 25 | +3 colonnes de traçabilité |
| `silver/store` | 12 | 32 | +3 colonnes de traçabilité |
| `silver/date_dim` | 109 573 | 31 | +3 colonnes de traçabilité |

Colonnes de traçabilité ajoutées à chaque jeu Silver :
`_source_fichier`, `_date_traitement`, `_version_regles`.

Chaque table est relue après écriture (contrôle ligne à ligne, schéma identique).

### 7.3 Zone Gold

| Table | Grain | Usage |
|---|---|---|
| `gold/ventes_magasin_mois` | 1 ligne = magasin × mois (partitionné par année) | Répond à Q06 |
| `gold/ventes_categorie_annee` | 1 ligne = catégorie × année | Répond à Q03 |

### 7.4 Zone Quality

| Fichier | Contenu |
|---|---|
| `quality/rejets_store_sales/` | **0 ligne** — aucune vente rejetée |
| `quality/rapport_qualite.csv` | R1 → R13 : lignes concernées, statut, action |

### 7.5 Résultats des contrôles

| Contrôle | Résultat |
|---|---|
| Échecs de conversion de type (R1) | **0** sur les 4 tables |
| Doublons exacts (R4) | **0** |
| Lignes en quarantaine (R2, R6, R7, R10) | **0** |
| Doublons ticket+article (R5) | **4 038 paires** — conservées, grain documenté |
| Marges négatives (R8) | **495 971 lignes (74.3 %)** — conservées, signalées |
| Incohérences de calcul (R9) | **0** |
| Catégories absentes (R12) | **0** |
| Dates incohérentes (R13) | **0** |
| Période couverte | **2001-01-01 → 2005-12-13** |
| Tickets distincts | **89 100** |
| Lignes de vente par ticket (moyenne) | **7.49** |

---

## 8. Règles de nettoyage appliquées (R1 → R13)

Résumé. Le détail complet (anomalie, règle, action, justification) figure dans la cellule markdown de la section 4 du notebook.

| # | Anomalie | Action |
|---|---|---|
| R1 | Type incorrect | Conversion explicite + comptage des échecs |
| R2 | Clé obligatoire absente | Quarantaine |
| R3 | Valeur facultative absente | Conservée `null` |
| R4 | Doublon exact | 1 seule copie conservée |
| R5 | Ticket + article non unique | **Conservé**, analysé, documenté |
| R6 | Quantité ≤ 0 | Quarantaine |
| R7 | Montant négatif | Quarantaine |
| R8 | Marge négative | **Conservée**, signalée |
| R9 | Incohérence `ext_sales_price ≠ qty × price` | Contrôle, signalement |
| R10 | Clé étrangère inconnue | Quarantaine |
| R11 | Espaces superflus (référentiels) | `trim()` |
| R12 | Catégorie absente | Remplacée par `Non renseignée` |
| R13 | Date incohérente | Contrôle |

---

## 9. Fichiers produits

| Fichier / dossier | Chemin | Contenu |
|---|---|---|
| Fiche environnement | `tp3/outputs/fiche_environnement.csv` | OS, Python, Spark, Java, CPU, RAM, chemins, date |
| Inventaire des sources | `tp3/outputs/inventaire_sources.csv` | Format, taille, lignes, colonnes, grain, clé |
| Test lecture/écriture | `tp3/outputs/test_ecriture/` | 2 lignes Parquet (smoke test Spark) |
| Comparaison formats | `tp3/outputs/comparaison_formats.csv` | Parquet vs CSV : taille, temps de lecture |
| Bilan par zone | `tp3/outputs/bilan_zones.csv` | Contenu et volumétrie de chaque zone |
| Journal d'exécution | `tp3/outputs/journal_execution.txt` | Trace horodatée de chaque étape |
| Silver | `tp3/silver/<table>/` | 4 tables Parquet |
| Gold | `tp3/gold/<table>/` | 2 tables Parquet |
| Rejets | `tp3/quality/rejets_store_sales/` | 0 ligne (preuve) |
| Rapport qualité | `tp3/quality/rapport_qualite.csv` | R1 → R13 : lignes, statut, action |

---

## 10. Correspondance avec les livrables attendus

| # | Livrable | Emplacement |
|---|---|---|
| 1 | Inventaire technique | `outputs/inventaire_sources.csv` + section 2 du notebook |
| 2 | Notebook d'exploration | Sections 1 à 3 du notebook |
| 3 | Règles de nettoyage | Section 4 du notebook (R1 → R13) |
| 4 | Scripts de transformation | Cellules `c20`, `c22`, `c24`, `c31` du notebook |
| 5 | Jeux Silver | `tp3/silver/` (4 tables Parquet) |
| 6 | Jeux Gold | `tp3/gold/` (2 tables Parquet) |
| 7 | Résultat Parquet | `outputs/comparaison_formats.csv` + section 8 |
| 8 | Rapport qualité | `tp3/quality/rapport_qualite.csv` |
| 9 | Documentation | Ce `README.md` + section 10 du notebook |
| 10 | Preuves | `outputs/journal_execution.txt` + `outputs/fiche_environnement.csv` + export HTML du notebook |

---

## 11. Limites connues

- **Données synthétiques TPCx-BB** : les valeurs (marges, CA) ne représentent pas une réalité économique. Elles ne doivent pas être interprétées comme telles.
- **R5 – ticket + article non unique** : 4 038 paires apparaissent plusieurs fois avec des prix ou quantités différents. Le grain réel de `store_sales` est donc « une ligne de ticket » et non « un article par ticket ». Le nombre de transactions (KPI-03) est calculé avec `countDistinct(ss_ticket_number)`, donc non faussé.
- **R8 – marge négative sur 74.3 % des lignes** : cas métier possible (ventes à perte, promotions) sur données synthétiques. Conservée et signalée, non corrigée.
- **Année 2005 incomplète** : les ventes s'arrêtent au 13/12/2005 dans le lot initial. Les agrégats mensuels 2005 ne sont donc pas comparables aux années complètes.
- **HDFS non utilisé** : J2 avait installé Hadoop, mais l'exécution J3 se fait sur fichiers locaux (`file:///`). La solution de repli est documentée dans le notebook.
- **Pas de jointure ventes ↔ web** : aucun identifiant fiable ne relie `store_sales` et la navigation web. Non tenté.

---

## 12. Dépannage

### `UnsupportedClassVersionError` au démarrage Spark

`JAVA_HOME` pointe sur Java 11 alors que Spark 4.2.1 exige Java 17 ou 21.

```bash
echo $JAVA_HOME
# doit afficher /usr/lib/jvm/java-21-openjdk-amd64
```

Corriger si besoin, puis **redémarrer JupyterLab** (pas seulement le kernel) :

```bash
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export PATH="$JAVA_HOME/bin:$PATH"
jupyter lab
```

### `Master must either be yarn or start with spark, k8s, or local`

Le paramètre `.master(" local [*] ")` contient des espaces parasites. Écrire exactement `.master("local[*]")`.

### Erreurs d'écriture Parquet sous `/mnt/c`

Les écritures Spark dans `/mnt/c` (9P filesystem de WSL) peuvent échouer ou laisser des dossiers `_temporary/`. Ce notebook contourne le problème en écrivant sous `tp3/` **à l'intérieur du projet**, ce qui fonctionne dans la configuration actuelle. Si des erreurs apparaissent, déplacer `tp3/` vers `~/retail-intelligence/tp3` (ext4 natif) et adapter `DOSSIER_TRAVAIL` dans la cellule de paramètres.

---

## 13. Reproductibilité

```bash
# 1. Environnement
cd /mnt/c/Users/found/desktop/ipssi/bd/retail_project/J3
source .venv/bin/activate
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export PATH="$JAVA_HOME/bin:$PATH"

# 2. Lancer JupyterLab
jupyter lab

# 3. Dans JupyterLab : Kernel → Restart Kernel and Run All Cells

# 4. Vérifier les sorties
ls tp3/outputs/
ls tp3/silver/
ls tp3/gold/
ls tp3/quality/
```

À l'issue de l'exécution complète, tous les fichiers listés en section 9 doivent être présents.