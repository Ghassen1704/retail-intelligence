# Schéma fonctionnel — UC-01

Légende des statuts : Vérifié / Déduit / Hypothèse / Non disponible / À valider

```mermaid
flowchart LR
  DC[Direction commerciale] --> Q1[Top produits par CA]
  DC --> Q2[Évolution des ventes]
  DC --> Q3[Magasin vs web]

  RM[Responsable de magasin] --> Q4[Ventes quotidiennes magasin]
  RM --> Q5[Tension de stock]

  CG[Contrôleur de gestion] --> Q6[Panier moyen]
  CG --> Q7[Taux de retour]
  CG --> Q8[CA net après retours]

  DG[Direction générale] --> Q9[Tendance globale]
  DG --> Q10[Performance des magasins]

  RS[Responsable des stocks] --> Q11[Stock par entrepôt]

  ED[Équipe Data] --> Q12[Qualité et périmètre]
  ED --> Q13[Stratégie incrémentale]

  Q1 --> K1[KPI CA par produit]
  Q2 --> K5[KPI Évolution]
  Q3 --> K11[KPI Ventes par canal]
  Q4 --> K1
  Q5 --> K10[KPI Stock]
  Q6 --> K3[KPI Panier moyen]
  Q7 --> K7[KPI Taux de retour]
  Q8 --> K9[KPI Marge]
  Q9 --> K5
  Q10 --> K1
  Q11 --> K10
  Q12 --> K0[Inventaire]
  Q13 --> K0

  K1 --> D1[(store_sales)]
  K1 --> D2[(item)]
  K5 --> D3[(date_dim)]
  K3 --> D1
  K7 --> D4[(store_returns)]
  K9 --> D1
  K10 --> D5[(inventory)]
  K11 --> D6[(web_sales)]

  D1 -. Vérifié .-> K1
  D2 -. Vérifié .-> K1
  D3 -. Vérifié .-> K5
  D4 -. Vérifié .-> K7
  D5 -. Vérifié .-> K10
  D6 -. Vérifié .-> K11
