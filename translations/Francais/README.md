# Real-Time

Real-Time est un Filterscript pour SA-MP (San Andreas Multiplayer) qui synchronise l'heure du jeu avec l'heure réelle, offrant une expérience plus immersive grâce aux changements automatiques de l'heure sur le serveur basés sur l'heure réelle.

## Langues

- Português: [README](../../)
- Deutsch: [README](../Deutsch/README.md)
- English: [README](../English/README.md)
- Español: [README](../Espanol/README.md)
- Italiano: [README](../Italiano/README.md)
- Polski: [README](../Polski/README.md)
- Русский: [README](../Русский/README.md)
- Svenska: [README](../Svenska/README.md)
- Türkçe: [README](../Turkce/README.md)

## Sommaire
- [Real-Time](#real-time)
  - [Langues](#langues)
  - [Sommaire](#sommaire)
  - [Installation](#installation)
  - [Fonctionnement Technique](#fonctionnement-technique)
    - [Système Horaire](#système-horaire)
  - [Cas d'Utilisation](#cas-dutilisation)
    - [Idéal pour :](#idéal-pour-)
  - [Détails Techniques](#détails-techniques)
    - [Optimisations Implémentées](#optimisations-implémentées)
    - [Caractéristiques Principales :](#caractéristiques-principales-)
  - [Licence](#licence)
    - [Conditions :](#conditions-)

## Installation

1. Téléchargez le fichier [Real-Time.amx](https://github.com/ocalasans/Real-Time/raw/refs/heads/main/src/Real-Time.amx)
2. Copiez le fichier dans le dossier `filterscripts` de votre serveur
3. Modifiez le fichier `server.cfg`
4. Ajoutez `Real-Time` à la ligne `filterscripts`

**Exemple de configuration dans server.cfg :**
```
filterscripts Real-Time
```

> [!WARNING]
> Si d'autres filterscripts sont déjà chargés, ajoutez Real-Time après ceux-ci.

## Fonctionnement Technique

Le système fonctionne grâce à un minuteur optimisé qui vérifie l'heure actuelle toutes les 5 secondes. Voici un extrait de code qui démontre comment la vérification est effectuée :

```pawn
#define TRF_UPDATE_INTERVAL  5*1000 // Mise à jour toutes les 5 secondes
#define TRF_DAWN_TIME        5 // 00:00 - 05:59 -> 05:00
#define TRF_MORNING_TIME     7 // 06:00 - 10:59 -> 07:00
#define TRF_NOON_TIME        12 // 11:00 - 15:59 -> 12:00
#define TRF_EVENING_TIME     20 // 16:00 - 17:59 -> 20:00
#define TRF_NIGHT_TIME       0 // 18:00 - 23:59 -> 00:00
```

### Système Horaire
Le Filterscript utilise les conversions de temps suivantes :
- **Aube** : 00:00 - 05:59 → 05:00 en jeu
- **Matin** : 06:00 - 10:59 → 07:00 en jeu
- **Après-midi** : 11:00 - 15:59 → 12:00 en jeu
- **Soir** : 16:00 - 17:59 → 20:00 en jeu
- **Nuit** : 18:00 - 23:59 → 00:00 en jeu

> [!NOTE]
> Le système utilise `gettime()` pour obtenir l'heure actuelle du serveur. Il est crucial que votre serveur soit configuré avec le bon fuseau horaire.

## Cas d'Utilisation

### Idéal pour :
1. **Serveurs RolePlay**
   - Augmente le réalisme
   - Synchronise les événements du serveur avec les heures réelles
   - Améliore l'immersion des joueurs

2. **Serveurs DayZ**
   - Système jour/nuit réaliste
   - Cycle temporel naturel
   - Planification d'événements basée sur l'heure réelle

3. **Serveurs Compétitifs**
   - Organisation d'événements à des heures spécifiques
   - Changements d'environnement programmés
   - Intégration avec les systèmes météorologiques

## Détails Techniques

### Optimisations Implémentées
```pawn
// Variable globale pour éviter les mises à jour inutiles
static TRF_Last_WorldTime = -1;

// Fonction de mise à jour optimisée
public TRF_UpdateWorldTime() {
    new TRF_Current_Hour,
        TRF_Current_Minute,
        TRF_Current_Second;
    
    gettime(TRF_Current_Hour, TRF_Current_Minute, TRF_Current_Second);
    
    // Met à jour uniquement si l'heure a changé
    if(TRF_New_WorldTime != TRF_Last_WorldTime)
    {
        SetWorldTime(TRF_New_WorldTime);
        TRF_Last_WorldTime = TRF_New_WorldTime;
    }
}
```

### Caractéristiques Principales :
- Cache de la dernière heure pour éviter les mises à jour redondantes
- Minuteur optimisé pour réduire l'utilisation des ressources
- Compatibilité totale avec d'autres filterscripts

> [!IMPORTANT]
> Le système a été développé en pensant à la performance, effectuant des vérifications uniquement lorsque nécessaire et maintenant un cache de la dernière heure définie.

## Licence

Ce Filterscript est protégé sous la licence Apache License 2.0, qui permet :

- ✔️ Utilisation commerciale et privée
- ✔️ Modification du code source
- ✔️ Distribution du code
- ✔️ Octroi de brevet

### Conditions :
- Maintenir l'avis de droit d'auteur
- Documenter les changements significatifs
- Inclure une copie de la licence Apache License 2.0

Pour plus de détails sur la licence : http://www.apache.org/licenses/LICENSE-2.0

**Copyright (c) Calasans - Tous droits réservés**