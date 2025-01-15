# Real-Time

Real-Time är en Filterscript för SA-MP (San Andreas Multiplayer) som synkroniserar speltiden med realtid, vilket ger en mer uppslukande upplevelse genom automatiska tidsändringar på servern baserat på realtid.

## Språk

- Português: [README](../../)
- Deutsch: [README](../Deutsch/README.md)
- English: [README](../English/README.md)
- Español: [README](../Espanol/README.md)
- Français: [README](../Francais/README.md)
- Italiano: [README](../Italiano/README.md)
- Polski: [README](../Polski/README.md)
- Русский: [README](../Русский/README.md)
- Türkçe: [README](../Turkce/README.md)

## Innehåll
- [Real-Time](#real-time)
  - [Språk](#språk)
  - [Innehåll](#innehåll)
  - [Installation](#installation)
  - [Teknisk funktion](#teknisk-funktion)
    - [Tidssystem](#tidssystem)
  - [Användningsfall](#användningsfall)
    - [Idealisk för:](#idealisk-för)
  - [Tekniska detaljer](#tekniska-detaljer)
    - [Implementerade optimeringar](#implementerade-optimeringar)
    - [Huvudfunktioner:](#huvudfunktioner)
  - [Licens](#licens)
    - [Villkor:](#villkor)

## Installation

1. Ladda ner filen [Real-Time.amx](https://github.com/ocalasans/Real-Time/raw/refs/heads/main/src/Real-Time.amx)
2. Kopiera filen till din servers `filterscripts` mapp
3. Redigera filen `server.cfg`
4. Lägg till `Real-Time` i raden `filterscripts`

**Exempel på konfiguration i server.cfg:**
```
filterscripts Real-Time
```

> [!VARNING]
> Om andra filterscripts redan är laddade, lägg till Real-Time efter dem.

## Teknisk funktion

Systemet fungerar genom en optimerad timer som kontrollerar aktuell tid var 5:e sekund. Nedan är ett kodexempel som visar hur kontrollen utförs:

```pawn
#define TRF_UPDATE_INTERVAL  (5*1000) // Uppdaterar var 5:e sekund
#define TRF_DAWN_TIME        (5) // 00:00 - 05:59 -> 05:00
#define TRF_MORNING_TIME     (7) // 06:00 - 10:59 -> 07:00
#define TRF_NOON_TIME        (12) // 11:00 - 15:59 -> 12:00
#define TRF_EVENING_TIME     (20) // 16:00 - 17:59 -> 20:00
#define TRF_NIGHT_TIME       (0) // 18:00 - 23:59 -> 00:00
```

### Tidssystem
Filterscript använder följande tidskonverteringar:
- **Gryning**: 00:00 - 05:59 → 05:00 i spelet
- **Morgon**: 06:00 - 10:59 → 07:00 i spelet
- **Eftermiddag**: 11:00 - 15:59 → 12:00 i spelet
- **Kväll**: 16:00 - 17:59 → 20:00 i spelet
- **Natt**: 18:00 - 23:59 → 00:00 i spelet

> [!OBS]
> Systemet använder `gettime()` för att hämta aktuell servertid. Det är viktigt att din server är konfigurerad med rätt tidszon.

## Användningsfall

### Idealisk för:
1. **RolePlay-servrar**
   - Ökar realismen
   - Synkroniserar serverhändelser med realtider
   - Förbättrar spelarens inlevelse

2. **DayZ-servrar**
   - Realistiskt dag/natt-system
   - Naturlig tidscykel
   - Planering av händelser baserat på realtid

3. **Tävlingsservrar**
   - Organisation av evenemang vid specifika tider
   - Schemalagda miljöförändringar
   - Integration med vädersystem

## Tekniska detaljer

### Implementerade optimeringar
```pawn
// Global variabel för att undvika onödiga uppdateringar
static TRF_Last_WorldTime = -1;

// Optimerad uppdateringsfunktion
public TRF_UpdateWorldTime() {
    new TRF_Current_Hour,
        TRF_Current_Minute,
        TRF_Current_Second;
    
    gettime(TRF_Current_Hour, TRF_Current_Minute, TRF_Current_Second);
    
    // Uppdaterar endast om tiden har ändrats
    if(TRF_New_WorldTime != TRF_Last_WorldTime)
    {
        SetWorldTime(TRF_New_WorldTime);
        TRF_Last_WorldTime = TRF_New_WorldTime;
    }
}
```

### Huvudfunktioner:
- Cache av senaste tiden för att undvika redundanta uppdateringar
- Optimerad timer för att minska resursanvändning
- Full kompatibilitet med andra filterscripts

> [!VIKTIGT]
> Systemet utvecklades med prestanda i åtanke, utför kontroller endast när det behövs och upprätthåller en cache av den senast inställda tiden.

## Licens

Detta Filterscript är skyddat under Apache License 2.0, som tillåter:

- ✔️ Kommersiell och privat användning
- ✔️ Källkodsmodifiering
- ✔️ Koddistribution
- ✔️ Patentbeviljande

### Villkor:
- Behåll upphovsrättsmeddelande
- Dokumentera betydande ändringar
- Inkludera kopia av Apache License 2.0

För mer information om licensen: http://www.apache.org/licenses/LICENSE-2.0

**Copyright (c) Calasans - Alla rättigheter förbehållna**