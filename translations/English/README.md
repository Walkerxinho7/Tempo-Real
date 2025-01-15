# Real-Time

Real-Time is a Filterscript for SA-MP (San Andreas Multiplayer) that synchronizes game time with real time, providing a more immersive experience through automatic time changes on the server based on real time.

## Languages

- Português: [README](../../)
- Deutsch: [README](../Deutsch/README.md)
- Español: [README](../Espanol/README.md)
- Français: [README](../Francais/README.md)
- Italiano: [README](../Italiano/README.md)
- Polski: [README](../Polski/README.md)
- Русский: [README](../Русский/README.md)
- Svenska: [README](../Svenska/README.md)
- Türkçe: [README](../Turkce/README.md)

## Contents
- [Real-Time](#real-time)
  - [Languages](#languages)
  - [Contents](#contents)
  - [Installation](#installation)
  - [Technical Operation](#technical-operation)
    - [Time System](#time-system)
  - [Use Cases](#use-cases)
    - [Ideal for:](#ideal-for)
  - [Technical Details](#technical-details)
    - [Implemented Optimizations](#implemented-optimizations)
    - [Main Features:](#main-features)
  - [License](#license)
    - [Conditions:](#conditions)

## Installation

1. Download the `Real-Time.amx` file
2. Copy the file to your server's `filterscripts` folder
3. Edit the `server.cfg` file
4. Add `Real-Time` to the `filterscripts` line

**Example configuration in server.cfg:**
```
filterscripts Real-Time
```

> [!WARNING]
> If other filterscripts are already loaded, add Real-Time after them.

## Technical Operation

The system operates through an optimized timer that checks the current time every 5 seconds. Below is a code snippet that demonstrates how the check is performed:

```pawn
#define TRF_UPDATE_INTERVAL  5*1000 // Updates every 5 seconds
#define TRF_DAWN_TIME        5 // 00:00 - 05:59 -> 05:00
#define TRF_MORNING_TIME     7 // 06:00 - 10:59 -> 07:00
#define TRF_NOON_TIME        12 // 11:00 - 15:59 -> 12:00
#define TRF_EVENING_TIME     20 // 16:00 - 17:59 -> 20:00
#define TRF_NIGHT_TIME       0 // 18:00 - 23:59 -> 00:00
```

### Time System
The Filterscript uses the following time conversions:
- **Dawn**: 00:00 - 05:59 → 05:00 in game
- **Morning**: 06:00 - 10:59 → 07:00 in game
- **Afternoon**: 11:00 - 15:59 → 12:00 in game
- **Evening**: 16:00 - 17:59 → 20:00 in game
- **Night**: 18:00 - 23:59 → 00:00 in game

> [!NOTE]
> The system uses `gettime()` to get the current server time. It is crucial that your server is configured with the correct timezone.

## Use Cases

### Ideal for:
1. **RolePlay Servers**
   - Increases realism
   - Synchronizes server events with real times
   - Improves player immersion

2. **DayZ Servers**
   - Realistic day/night system
   - Natural time cycle
   - Planning of events based on real time

3. **Competitive Servers**
   - Organization of events at specific times
   - Scheduled environment changes
   - Integration with weather systems

## Technical Details

### Implemented Optimizations
```pawn
// Global variable to avoid unnecessary updates
static TRF_Last_WorldTime = -1;

// Optimized update function
public TRF_UpdateWorldTime() {
    new TRF_Current_Hour,
        TRF_Current_Minute,
        TRF_Current_Second;
    
    gettime(TRF_Current_Hour, TRF_Current_Minute, TRF_Current_Second);
    
    // Only updates if the time has changed
    if(TRF_New_WorldTime != TRF_Last_WorldTime)
    {
        SetWorldTime(TRF_New_WorldTime);
        TRF_Last_WorldTime = TRF_New_WorldTime;
    }
}
```

### Main Features:
- Cache of the last time to avoid redundant updates
- Optimized timer to reduce resource usage
- Full compatibility with other filterscripts

> [!IMPORTANT]
> The system was developed with performance in mind, performing checks only when necessary and maintaining a cache of the last set time.

## License

This Filterscript is protected under the Apache License 2.0, which allows:

- ✔️ Commercial and private use
- ✔️ Source code modification
- ✔️ Code distribution
- ✔️ Patent grant

### Conditions:
- Maintain copyright notice
- Document significant changes
- Include copy of Apache License 2.0

For more details about the license: http://www.apache.org/licenses/LICENSE-2.0

**Copyright (c) Calasans - All rights reserved**
