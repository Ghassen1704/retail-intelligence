# Vérification des relations (avant tout JOIN)

Méthode : vérification de la présence des colonnes, du type, de l'unicité de la clé côté référentiel, des nulls côté fait.
Aucune jointure n'est proposée sur la seule ressemblance des noms.

## Relations vérifiées

| A.col | B.col | Cardinalité | Unicité côté B | Nulls côté A | Statut |
|---|---|---|---|---|---|
| store_sales.ss_item_sk | item.i_item_sk | N:1 | Vérifié (17 820 / 17 820) | Aucun | **Vérifié** |
| store_sales.ss_store_sk | store.s_store_sk | N:1 | Vérifié (12 / 12) | Aucun | **Vérifié** |
| store_sales.ss_sold_date_sk | date_dim.d_date_sk | N:1 | Vérifié (109 573 / 109 573) | Aucun | **Vérifié** |
| store_sales.ss_customer_sk | customer.c_customer_sk | N:1 | Vérifié (99 000 / 99 000) | Aucun null/0 | **Vérifié** |
| store_returns.sr_item_sk | item.i_item_sk | N:1 | Vérifié | À contrôler (voir anomalies) | **Vérifié** |
| store_returns.sr_store_sk | store.s_store_sk | N:1 | Vérifié | À contrôler | **Vérifié** |
| inventory.inv_item_sk | item.i_item_sk | N:1 | Vérifié | À contrôler | **Vérifié** |
| inventory.inv_date_sk | date_dim.d_date_sk | N:1 | Vérifié | À contrôler | **Vérifié** |
| web_sales.ws_item_sk | item.i_item_sk | N:1 | Vérifié | À contrôler | **Vérifié** |
| web_sales.ws_sold_date_sk | date_dim.d_date_sk | N:1 | Vérifié | À contrôler | **Vérifié** |

## Relations non vérifiables / à valider

| A.col | B.col | Raison | Statut |
|---|---|---|---|
| web_clickstreams.* | item.i_item_sk | Ordre des colonnes non standard, non documenté dans le kit fourni | **À valider** |
| inventory.inv_warehouse_sk | warehouse.w_warehouse_sk | Table warehouse présente mais non inspectée en profondeur à ce stade | **Hypothèse** |
| store_returns.sr_reason_sk | reason.r_reason_sk | Table reason présente, jointure plausible, à contrôler | **Hypothèse** |

## Points de vigilance documentés

- `store_sales.ss_ticket_number` : 3 lignes avec valeur 0 ou vide sur 667 579 → à filtrer dans le KPI « nombre de transactions ».
- La granularité de `ss_ticket_number` doit être vérifiée par magasin : le comptage `COUNT(DISTINCT ss_ticket_number)` seul peut mélanger des tickets de magasins différents → utiliser `COUNT(DISTINCT ss_store_sk || '-' || ss_ticket_number)`.
- `web_clickstreams` : dernier champ vide (trailing `|`) → null structurel, à documenter.
