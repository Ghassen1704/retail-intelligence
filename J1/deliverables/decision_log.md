# Journal des décisions et hypothèses

| Date | Élément | Observation / Décision | Statut | Justification | À vérifier avec |
|---|---|---|---|---|---|
| J1 | Source de données | TPCx-BB, format TPC-DS, pipe-delimited, sans en-tête | Vérifié | Observation directe des fichiers | — |
| J1 | Jointures dimensions | item, store, date_dim, customer : clés uniques | Vérifié | rows = distinct SK | — |
| J1 | Périmètre J1 | Magasin + web + retours + inventaire entrepôt | Vérifié | Fichiers présents | — |
| J1 | Stock magasin | Hors périmètre | Non disponible | inventory est par entrepôt | Formateur |
| J1 | web_clickstreams | Non exploité en J1 | À valider | Colonnes non documentées | Formateur |
| J1 | Batch incrémental | data_refresh traité comme incrémental | Déduit | Volume ~1 à 2 % du principal | Formateur |
| J1 | Version du kit TPCx-BB | Non communiquée | À valider | Non indiquée dans le kit | Formateur |
