# UC-01 — Utilisateurs, questions décisionnelles et priorités

## 1. Direction commerciale
Responsabilité : piloter la performance commerciale magasin et web par produit, magasin et période.

| Question métier | Décision associée | Priorité | Données nécessaires | Statut |
|---|---|---|---|---|
| Quels produits génèrent le plus de CA ? | Prioriser réassort et promotions sur les top produits | Indispensable | store_sales + item | Vérifié |
| Comment évoluent les ventes dans le temps ? | Ajuster les plans promotionnels mensuels / trimestriels | Indispensable | store_sales + date_dim | Vérifié |
| Quels canaux (magasin / web) performent le mieux ? | Arbitrer les investissements marketing | Utile | store_sales + web_sales | Vérifié |

## 2. Responsable de magasin
Responsabilité : suivre les ventes et le stock de son établissement.

| Question métier | Décision associée | Priorité | Données nécessaires | Statut |
|---|---|---|---|---|
| Quelles sont les ventes de mon magasin par jour ? | Réajuster planning et promotions locales | Indispensable | store_sales filtré sur ss_store_sk + store | Vérifié |
| Quels produits sont en tension de stock ? | Déclencher un réassort | Utile | inventory + item | Vérifié (niveau entrepôt, pas magasin) |

## 3. Contrôleur de gestion
Responsabilité : indicateurs financiers, marges, comparaisons inter-magasins, retours.

| Question métier | Décision associée | Priorité | Données nécessaires | Statut |
|---|---|---|---|---|
| Quel est le panier moyen et son évolution ? | Arbitrer les actions commerciales | Indispensable | store_sales | Vérifié |
| Quel est le taux de retour par magasin / produit ? | Cibler les produits à problème | Utile | store_returns + store_sales + item | Vérifié |
| Quel est le CA net après retours ? | Ajuster les objectifs financiers | Utile | store_sales + store_returns | Déduit |

## 4. Direction générale
Responsabilité : vision consolidée de l'activité.

| Question métier | Décision associée | Priorité | Données nécessaires | Statut |
|---|---|---|---|---|
| Quelle est la tendance globale d'activité ? | Arbitrer les orientations stratégiques | Utile | store_sales + web_sales + date_dim | Vérifié |
| Quels sont les magasins les plus performants ? | Allocation des investissements | Utile | store_sales + store | Vérifié |

## 5. Responsable des stocks
Responsabilité : disponibilité produit et mouvements de stock.

| Question métier | Décision associée | Priorité | Données nécessaires | Statut |
|---|---|---|---|---|
| Quels produits ont un stock sous le seuil ? | Déclencher un réapprovisionnement | Utile | inventory + item | Vérifié (entrepôt) |
| Comment évolue le stock dans le temps ? | Anticiper les ruptures | Complémentaire | inventory + date_dim | Vérifié |

## 6. Équipe Data
Responsabilité : intégration, qualité et mise à disposition des données.

| Question métier | Décision associée | Priorité | Données nécessaires | Statut |
|---|---|---|---|---|
| Quelles sources sont complètes et fiables ? | Valider le périmètre d'analyse J1 | Indispensable | Inventaire des fichiers | Vérifié |
| Comment intégrer le batch incrémental (data_refresh) ? | Définir la stratégie d'ingestion J2 / J3 | Indispensable | data/ vs data_refresh/ | Vérifié |

## Questions du TP non couvertes par les données

| Question du TP | Constat | Statut |
|---|---|---|
| Quelles informations permettent de caractériser les clients ? | customer (18 colonnes : démographie, adresse, email) + customer_demographics + household_demographics + income_band → couvert | Vérifié |
| Les données de navigation web permettent-elles d'étudier les comportements ? | web_clickstreams présent mais colonnes non standard, non documentées dans le kit | À valider |
| Peut-on analyser les niveaux de stock au niveau magasin ? | Non : inventory est par entrepôt | Non disponible |
