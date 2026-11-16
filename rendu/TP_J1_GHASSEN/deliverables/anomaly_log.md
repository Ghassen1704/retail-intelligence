# Journal des anomalies observées

| Fichier | Colonne | Anomalie | Exemple | Impact KPI | Statut | Action |
|---|---|---|---|---|---|---|
| store_sales | ss_ticket_number | 3 lignes avec valeur 0 ou vide sur 667 579 | — | KPI transactions | Vérifié | Filtrer ss_ticket_number = 0 |
| store_sales | ss_customer_sk | Aucun null ni 0 | — | — | Vérifié | Aucune |
| web_clickstreams | dernière colonne | Champ vide en fin de ligne (trailing pipe) | `36890\|71470\|\|4867\|28\|` | Analyse comportementale | Vérifié | Documenter comme null structurel |
| web_clickstreams | toutes | Ordre des colonnes non documenté | — | Non exploitable | À valider | Demander la doc au formateur |
| item | i_rec_end_date | Valeur vide = enregistrement ouvert | `2000-01-14\|\|` | Aucun | Vérifié | Normal TPC-DS |
| inventory | inv_warehouse_sk | Stock par entrepôt, pas par magasin | — | KPI stock magasin | Vérifié | KPI stock magasin marqué Non disponible |
