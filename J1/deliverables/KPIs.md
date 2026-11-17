# UC-01 — Catalogue des KPIs

Statuts utilisés : Vérifié / Déduit / Hypothèse / Non disponible / À valider.

## KPI 1 — Chiffre d'affaires magasin
- Définition : total des ventes nettes magasin sur une période.
- Formule : SUM(ss_net_paid)
- Unité : unité monétaire du jeu TPCx-BB (synthétique)
- Périmètre : par magasin, produit, jour, mois
- Fréquence : quotidienne / mensuelle
- Sources : store_sales (colonne ss_net_paid, position 21)
- Données manquantes : aucune sur cette colonne à ce stade
- Limites : exclut le canal web ; jeu synthétique → pas d'interprétation en valeur absolue
- Statut : **Vérifié**

## KPI 2 — Nombre de transactions
- Définition : nombre de tickets de caisse distincts.
- Formule : COUNT(DISTINCT ss_store_sk || '-' || ss_ticket_number)
- Unité : nombre
- Périmètre : par magasin, par jour
- Sources : store_sales (ss_store_sk, ss_ticket_number)
- Limites : 3 lignes avec ss_ticket_number = 0 à exclure ; la clé ticket doit être combinée au magasin
- Statut : **Vérifié** (après filtre documenté)

## KPI 3 — Panier moyen
- Définition : CA / nombre de transactions.
- Formule : SUM(ss_net_paid) / COUNT(DISTINCT ss_store_sk || '-' || ss_ticket_number)
- Unité : unité monétaire
- Sources : store_sales
- Limites : dépend de la définition des transactions (KPI 2)
- Statut : **Déduit**

## KPI 4 — Quantités vendues
- Définition : volume d'articles vendus.
- Formule : SUM(ss_quantity)
- Unité : unités
- Sources : store_sales (ss_quantity, position 11)
- Statut : **Vérifié**

## KPI 5 — Évolution des ventes (MoM / YoY)
- Définition : variation du CA d'une période sur la précédente.
- Formule : (CA_période − CA_période_précédente) / CA_période_précédente
- Unité : %
- Sources : store_sales + date_dim (jointure sur ss_sold_date_sk = d_date_sk)
- Limites : granularité à choisir (mois, trimestre, année)
- Statut : **Vérifié** (la jointure date est vérifiée)

## KPI 6 — Taux de remise
- Définition : remise accordée sur les ventes brutes.
- Formule : SUM(ss_ext_discount_amt) / SUM(ss_ext_list_price)
- Unité : %
- Sources : store_sales (positions 15 et 18)
- Statut : **Vérifié**

## KPI 7 — Taux de retour magasin
- Définition : proportion d'articles retournés.
- Formule : SUM(sr_return_quantity) / SUM(ss_quantity)
- Sources : store_returns + store_sales
- Limites : granularité temporelle des retours différente de celle des ventes → interpréter par produit ou par magasin, pas par jour
- Statut : **Déduit**

## KPI 8 — CA web
- Définition : chiffre d'affaires canal web.
- Formule : SUM(ws_net_paid)
- Sources : web_sales
- Limites : canal distinct ; ne pas cumuler avec le CA magasin sans règle de consolidation explicite
- Statut : **Vérifié**

## KPI 9 — Marge brute magasin
- Définition : profit net magasin.
- Formule : SUM(ss_net_profit)
- Sources : store_sales (position 23)
- Statut : **Vérifié**

## KPI 10 — Stock disponible par entrepôt
- Définition : quantité en stock par produit / entrepôt / jour.
- Formule : SUM(inv_quantity_on_hand)
- Sources : inventory (inv_date_sk, inv_item_sk, inv_warehouse_sk, inv_quantity_on_hand)
- Limites : **Non disponible au niveau magasin** — l'inventaire TPCx-BB est par entrepôt ; le stock magasin nécessiterait une source complémentaire
- Statut : **Non disponible** (au niveau magasin) / **Vérifié** (au niveau entrepôt)

## KPI 11 — Ventes par canal
- Définition : comparaison magasin vs web.
- Formule : SUM(ss_net_paid) et SUM(ws_net_paid) calculés séparément
- Sources : store_sales + web_sales
- Limites : les deux canaux n'ont pas la même granularité client → comparaison par période et par produit uniquement
- Statut : **Déduit**
