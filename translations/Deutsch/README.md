# Real-Time

Real-Time ist ein Filterscript für SA-MP (San Andreas Multiplayer), das die Spielzeit mit der Echtzeit synchronisiert und durch automatische Zeitanpassung auf dem Server basierend auf der Echtzeit ein immersiveres Erlebnis bietet.

## Sprachen

- Português: [README](../../)
- English: [README](../English/README.md)
- Español: [README](../Espanol/README.md)
- Français: [README](../Francais/README.md)
- Italiano: [README](../Italiano/README.md)
- Polski: [README](../Polski/README.md)
- Русский: [README](../Русский/README.md)
- Svenska: [README](../Svenska/README.md)
- Türkçe: [README](../Turkce/README.md)

## Inhaltsverzeichnis
- [Real-Time](#real-time)
  - [Sprachen](#sprachen)
  - [Inhaltsverzeichnis](#inhaltsverzeichnis)
  - [Installation](#installation)
  - [Technische Funktionsweise](#technische-funktionsweise)
    - [Zeitsystem](#zeitsystem)
  - [Anwendungsfälle](#anwendungsfälle)
    - [Ideal für:](#ideal-für)
  - [Technische Details](#technische-details)
    - [Implementierte Optimierungen](#implementierte-optimierungen)
    - [Hauptmerkmale:](#hauptmerkmale)
  - [Lizenz](#lizenz)
    - [Bedingungen:](#bedingungen)

## Installation

1. Laden Sie die Datei [Real-Time.amx](https://github.com/ocalasans/Real-Time/raw/refs/heads/main/src/Real-Time.amx) herunter
2. Kopieren Sie die Datei in den `filterscripts`-Ordner Ihres Servers
3. Bearbeiten Sie die Datei `server.cfg`
4. Fügen Sie `Real-Time` in der Zeile `filterscripts` hinzu

**Beispielkonfiguration in server.cfg:**
```
filterscripts Real-Time
```

> [!WARNING]
> Wenn bereits andere Filterscripts geladen sind, fügen Sie Real-Time nach diesen hinzu.

## Technische Funktionsweise

Das System arbeitet mit einem optimierten Timer, der alle 5 Sekunden die aktuelle Uhrzeit überprüft. Nachfolgend ein Codeausschnitt, der die Überprüfung demonstriert:

```pawn
#define TRF_UPDATE_INTERVAL  5*1000 // Aktualisierung alle 5 Sekunden
#define TRF_DAWN_TIME        5 // 00:00 - 05:59 -> 05:00
#define TRF_MORNING_TIME     7 // 06:00 - 10:59 -> 07:00
#define TRF_NOON_TIME        12 // 11:00 - 15:59 -> 12:00
#define TRF_EVENING_TIME     20 // 16:00 - 17:59 -> 20:00
#define TRF_NIGHT_TIME       0 // 18:00 - 23:59 -> 00:00
```

### Zeitsystem
Das Filterscript verwendet folgende Zeitumrechnungen:
- **Morgendämmerung**: 00:00 - 05:59 → 05:00 im Spiel
- **Morgen**: 06:00 - 10:59 → 07:00 im Spiel
- **Mittag**: 11:00 - 15:59 → 12:00 im Spiel
- **Abend**: 16:00 - 17:59 → 20:00 im Spiel
- **Nacht**: 18:00 - 23:59 → 00:00 im Spiel

> [!NOTE]
> Das System verwendet `gettime()`, um die aktuelle Serverzeit zu erhalten. Es ist wichtig, dass Ihr Server mit der korrekten Zeitzone konfiguriert ist.

## Anwendungsfälle

### Ideal für:
1. **RolePlay-Server**
   - Erhöht den Realismus
   - Synchronisiert Server-Events mit Echtzeit
   - Verbessert die Immersion der Spieler

2. **DayZ-Server**
   - Realistisches Tag/Nacht-System
   - Natürlicher Zeitzyklus
   - Planung von Ereignissen basierend auf Echtzeit

3. **Wettbewerbsserver**
   - Organisation von Events zu bestimmten Zeiten
   - Geplante Umgebungsänderungen
   - Integration mit Wettersystemen

## Technische Details

### Implementierte Optimierungen
```pawn
// Globale Variable zur Vermeidung unnötiger Aktualisierungen
static TRF_Last_WorldTime = -1;

// Optimierte Aktualisierungsfunktion
public TRF_UpdateWorldTime() {
    new TRF_Current_Hour,
        TRF_Current_Minute,
        TRF_Current_Second;
    
    gettime(TRF_Current_Hour, TRF_Current_Minute, TRF_Current_Second);
    
    // Aktualisierung nur bei Zeitänderung
    if(TRF_New_WorldTime != TRF_Last_WorldTime)
    {
        SetWorldTime(TRF_New_WorldTime);
        TRF_Last_WorldTime = TRF_New_WorldTime;
    }
}
```

### Hauptmerkmale:
- Cache der letzten Zeit zur Vermeidung redundanter Aktualisierungen
- Optimierter Timer zur Reduzierung der Ressourcennutzung
- Volle Kompatibilität mit anderen Filterscripts

> [!IMPORTANT]
> Das System wurde mit Fokus auf Performance entwickelt, führt Überprüfungen nur bei Bedarf durch und hält einen Cache der zuletzt eingestellten Zeit.

## Lizenz

Dieses Filterscript steht unter der Apache 2.0 Lizenz, die Folgendes erlaubt:

- ✔️ Kommerzielle und private Nutzung
- ✔️ Modifikation des Quellcodes
- ✔️ Verteilung des Codes
- ✔️ Patenterteilung

### Bedingungen:
- Urheberrechtshinweis beibehalten
- Wesentliche Änderungen dokumentieren
- Kopie der Apache 2.0 Lizenz beifügen

Weitere Details zur Lizenz: http://www.apache.org/licenses/LICENSE-2.0

**Copyright (c) Calasans - Alle Rechte vorbehalten**