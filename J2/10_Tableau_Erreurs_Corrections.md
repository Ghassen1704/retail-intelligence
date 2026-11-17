# 10 — Tableau des erreurs, anomalies et corrections

Ce tableau rassemble les anomalies de données déjà observées en J1 et les points de vigilance de configuration visibles dans l’export NiFi J2. Il distingue une anomalie effectivement observée d’un risque de configuration : un point de vigilance n’est pas présenté comme une erreur survenue.

| Contexte | Anomalie / point de vigilance | Impact potentiel | Action / correction ou précaution | Statut |
|---|---|---|---|---|
| `store_sales` (J1) | 3 lignes avec `ss_ticket_number` égal à 0 ou vide sur 667 579 lignes | Peut fausser le comptage des transactions | Filtrer `ss_ticket_number = 0` selon la règle documentée en J1 | Observé / action documentée |
| `web_clickstreams` (J1) | Champ vide en fin de ligne (trailing pipe) | Valeur manquante à l’analyse | Traiter comme un null structurel et le documenter | Observé / action documentée |
| `web_clickstreams` (J1) | Ordre des colonnes non documenté | Risque d’interprétation incorrecte | Ne pas exploiter sans clarification du schéma | À valider |
| `item` (J1) | `i_rec_end_date` vide | Peut être interprété à tort comme une donnée manquante | Interpréter comme enregistrement ouvert selon l’observation J1 | Observé / normal selon J1 |
| `inventory` (J1) | `inv_warehouse_sk` représente un entrepôt et non un magasin | KPI de stock magasin non calculable à partir de cette source | Marquer le KPI stock magasin comme non disponible | Observé / décision documentée |
| `GetFile` (J2) | `Keep Source File = false` | Le fichier local est supprimé après récupération par GetFile | Conserver une copie source si une ré-exécution locale est nécessaire | Point de vigilance de configuration |
| `PutHDFS` (J2) | Relations `success` et `failure` configurées en auto-termination dans l’export | Les FlowFiles ne sont pas acheminés vers une branche de suivi dédiée après le processeur | Pour une exploitation renforcée, connecter `failure` à une file/branche de traitement et journaliser les erreurs | Point de vigilance de configuration |
| `PutHDFS` (J2) | Stratégie de conflit `fail` | Un fichier déjà présent peut provoquer un échec de dépôt | Vérifier le contenu de la destination ou choisir une stratégie adaptée avant relance | Comportement configuré |

## Conclusion

Les anomalies métier de J1 sont conservées comme contexte qualité des données. Pour le flux J2, les paramètres de suppression de la source, de conflit et d’auto-termination des relations doivent être connus lors d’une relance ou d’un diagnostic. L’export ne permet pas d’affirmer qu’une erreur d’exécution s’est effectivement produite.
