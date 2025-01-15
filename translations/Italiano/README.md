# Real-Time

Real-Time è un Filterscript per SA-MP (San Andreas Multiplayer) che sincronizza il tempo di gioco con il tempo reale, offrendo un'esperienza più immersiva attraverso cambiamenti automatici del tempo sul server basati sul tempo reale.

## Lingue

- Português: [README](../../)
- Deutsch: [README](../Deutsch/README.md)
- English: [README](../English/README.md)
- Español: [README](../Espanol/README.md)
- Français: [README](../Francais/README.md)
- Polski: [README](../Polski/README.md)
- Русский: [README](../Русский/README.md)
- Svenska: [README](../Svenska/README.md)
- Türkçe: [README](../Turkce/README.md)

## Contenuti
- [Real-Time](#real-time)
  - [Lingue](#lingue)
  - [Contenuti](#contenuti)
  - [Installazione](#installazione)
  - [Funzionamento Tecnico](#funzionamento-tecnico)
    - [Sistema Orario](#sistema-orario)
  - [Casi d'Uso](#casi-duso)
    - [Ideale per:](#ideale-per)
  - [Dettagli Tecnici](#dettagli-tecnici)
    - [Ottimizzazioni Implementate](#ottimizzazioni-implementate)
    - [Caratteristiche Principali:](#caratteristiche-principali)
  - [Licenza](#licenza)
    - [Condizioni:](#condizioni)

## Installazione

1. Scarica il file [Real-Time.amx](https://github.com/ocalasans/Real-Time/raw/refs/heads/main/src/Real-Time.amx)
2. Copia il file nella cartella `filterscripts` del tuo server
3. Modifica il file `server.cfg`
4. Aggiungi `Real-Time` alla riga `filterscripts`

**Esempio di configurazione in server.cfg:**
```
filterscripts Real-Time
```

> [!WARNING]
> Se altri filterscripts sono già caricati, aggiungi Real-Time dopo di essi.

## Funzionamento Tecnico

Il sistema opera attraverso un timer ottimizzato che controlla l'ora corrente ogni 5 secondi. Di seguito uno snippet di codice che dimostra come viene eseguito il controllo:

```pawn
#define TRF_UPDATE_INTERVAL  5*1000 // Aggiornamento ogni 5 secondi
#define TRF_DAWN_TIME        5 // 00:00 - 05:59 -> 05:00
#define TRF_MORNING_TIME     7 // 06:00 - 10:59 -> 07:00
#define TRF_NOON_TIME        12 // 11:00 - 15:59 -> 12:00
#define TRF_EVENING_TIME     20 // 16:00 - 17:59 -> 20:00
#define TRF_NIGHT_TIME       0 // 18:00 - 23:59 -> 00:00
```

### Sistema Orario
Il Filterscript utilizza le seguenti conversioni di tempo:
- **Alba**: 00:00 - 05:59 → 05:00 nel gioco
- **Mattina**: 06:00 - 10:59 → 07:00 nel gioco
- **Pomeriggio**: 11:00 - 15:59 → 12:00 nel gioco
- **Sera**: 16:00 - 17:59 → 20:00 nel gioco
- **Notte**: 18:00 - 23:59 → 00:00 nel gioco

> [!NOTE]
> Il sistema utilizza `gettime()` per ottenere l'ora corrente del server. È fondamentale che il tuo server sia configurato con il fuso orario corretto.

## Casi d'Uso

### Ideale per:
1. **Server RolePlay**
   - Aumenta il realismo
   - Sincronizza gli eventi del server con orari reali
   - Migliora l'immersione dei giocatori

2. **Server DayZ**
   - Sistema giorno/notte realistico
   - Ciclo temporale naturale
   - Pianificazione degli eventi basata sul tempo reale

3. **Server Competitivi**
   - Organizzazione di eventi in orari specifici
   - Cambiamenti ambientali programmati
   - Integrazione con sistemi meteorologici

## Dettagli Tecnici

### Ottimizzazioni Implementate
```pawn
// Variabile globale per evitare aggiornamenti non necessari
static TRF_Last_WorldTime = -1;

// Funzione di aggiornamento ottimizzata
public TRF_UpdateWorldTime() {
    new TRF_Current_Hour,
        TRF_Current_Minute,
        TRF_Current_Second;
    
    gettime(TRF_Current_Hour, TRF_Current_Minute, TRF_Current_Second);
    
    // Aggiorna solo se l'ora è cambiata
    if(TRF_New_WorldTime != TRF_Last_WorldTime)
    {
        SetWorldTime(TRF_New_WorldTime);
        TRF_Last_WorldTime = TRF_New_WorldTime;
    }
}
```

### Caratteristiche Principali:
- Cache dell'ultimo orario per evitare aggiornamenti ridondanti
- Timer ottimizzato per ridurre l'utilizzo delle risorse
- Piena compatibilità con altri filterscripts

> [!IMPORTANT]
> Il sistema è stato sviluppato pensando alle prestazioni, eseguendo controlli solo quando necessario e mantenendo una cache dell'ultimo orario impostato.

## Licenza

Questo Filterscript è protetto sotto la Licenza Apache 2.0, che permette:

- ✔️ Uso commerciale e privato
- ✔️ Modifica del codice sorgente
- ✔️ Distribuzione del codice
- ✔️ Concessione di brevetto

### Condizioni:
- Mantenere l'avviso di copyright
- Documentare le modifiche significative
- Includere una copia della Licenza Apache 2.0

Per maggiori dettagli sulla licenza: http://www.apache.org/licenses/LICENSE-2.0

**Copyright (c) Calasans - Tutti i diritti riservati**