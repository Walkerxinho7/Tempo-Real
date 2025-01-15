# Real-Time

Real-Time to Filterscript dla SA-MP (San Andreas Multiplayer), który synchronizuje czas w grze z czasem rzeczywistym, zapewniając bardziej immersyjne doświadczenie poprzez automatyczne zmiany czasu na serwerze w oparciu o czas rzeczywisty.

## Języki

- Português: [README](../../)
- Deutsch: [README](../Deutsch/README.md)
- English: [README](../English/README.md)
- Español: [README](../Espanol/README.md)
- Français: [README](../Francais/README.md)
- Italiano: [README](../Italiano/README.md)
- Русский: [README](../Русский/README.md)
- Svenska: [README](../Svenska/README.md)
- Türkçe: [README](../Turkce/README.md)

## Spis treści
- [Real-Time](#real-time)
  - [Języki](#języki)
  - [Spis treści](#spis-treści)
  - [Instalacja](#instalacja)
  - [Działanie techniczne](#działanie-techniczne)
    - [System czasu](#system-czasu)
  - [Przypadki użycia](#przypadki-użycia)
    - [Idealny dla:](#idealny-dla)
  - [Szczegóły techniczne](#szczegóły-techniczne)
    - [Zaimplementowane optymalizacje](#zaimplementowane-optymalizacje)
    - [Główne funkcje:](#główne-funkcje)
  - [Licencja](#licencja)
    - [Warunki:](#warunki)

## Instalacja

1. Pobierz plik [Real-Time.amx](https://github.com/ocalasans/Real-Time/raw/refs/heads/main/src/Real-Time.amx)
2. Skopiuj plik do folderu `filterscripts` na swoim serwerze
3. Edytuj plik `server.cfg`
4. Dodaj `Real-Time` do linii `filterscripts`

**Przykładowa konfiguracja w server.cfg:**
```
filterscripts Real-Time
```

> [!WARNING]
> Jeśli inne filterscripts są już załadowane, dodaj Real-Time po nich.

## Działanie techniczne

System działa poprzez zoptymalizowany timer, który sprawdza aktualny czas co 5 sekund. Poniżej znajduje się fragment kodu, który pokazuje, jak przeprowadzane jest sprawdzanie:

```pawn
#define TRF_UPDATE_INTERVAL  5*1000 // Aktualizacja co 5 sekund
#define TRF_DAWN_TIME        5 // 00:00 - 05:59 -> 05:00
#define TRF_MORNING_TIME     7 // 06:00 - 10:59 -> 07:00
#define TRF_NOON_TIME        12 // 11:00 - 15:59 -> 12:00
#define TRF_EVENING_TIME     20 // 16:00 - 17:59 -> 20:00
#define TRF_NIGHT_TIME       0 // 18:00 - 23:59 -> 00:00
```

### System czasu
Filterscript używa następujących konwersji czasu:
- **Świt**: 00:00 - 05:59 → 05:00 w grze
- **Poranek**: 06:00 - 10:59 → 07:00 w grze
- **Popołudnie**: 11:00 - 15:59 → 12:00 w grze
- **Wieczór**: 16:00 - 17:59 → 20:00 w grze
- **Noc**: 18:00 - 23:59 → 00:00 w grze

> [!NOTE]
> System używa `gettime()` do pobierania aktualnego czasu serwera. Ważne jest, aby serwer był skonfigurowany z odpowiednią strefą czasową.

## Przypadki użycia

### Idealny dla:
1. **Serwerów RolePlay**
   - Zwiększa realizm
   - Synchronizuje wydarzenia na serwerze z rzeczywistym czasem
   - Poprawia immersję graczy

2. **Serwerów DayZ**
   - Realistyczny system dnia i nocy
   - Naturalny cykl czasu
   - Planowanie wydarzeń w oparciu o rzeczywisty czas

3. **Serwerów konkurencyjnych**
   - Organizacja wydarzeń w określonych godzinach
   - Zaplanowane zmiany środowiska
   - Integracja z systemami pogodowymi

## Szczegóły techniczne

### Zaimplementowane optymalizacje
```pawn
// Zmienna globalna dla uniknięcia niepotrzebnych aktualizacji
static TRF_Last_WorldTime = -1;

// Zoptymalizowana funkcja aktualizacji
public TRF_UpdateWorldTime() {
    new TRF_Current_Hour,
        TRF_Current_Minute,
        TRF_Current_Second;
    
    gettime(TRF_Current_Hour, TRF_Current_Minute, TRF_Current_Second);
    
    // Aktualizuje tylko gdy czas się zmienił
    if(TRF_New_WorldTime != TRF_Last_WorldTime)
    {
        SetWorldTime(TRF_New_WorldTime);
        TRF_Last_WorldTime = TRF_New_WorldTime;
    }
}
```

### Główne funkcje:
- Cache ostatniego czasu dla uniknięcia zbędnych aktualizacji
- Zoptymalizowany timer dla zmniejszenia zużycia zasobów
- Pełna kompatybilność z innymi filterscripts

> [!IMPORTANT]
> System został opracowany z myślą o wydajności, wykonując sprawdzenia tylko wtedy, gdy jest to konieczne i utrzymując cache ostatnio ustawionego czasu.

## Licencja

Ten Filterscript jest chroniony licencją Apache License 2.0, która pozwala na:

- ✔️ Użytek komercyjny i prywatny
- ✔️ Modyfikację kodu źródłowego
- ✔️ Dystrybucję kodu
- ✔️ Przyznanie patentu

### Warunki:
- Zachowanie informacji o prawach autorskich
- Dokumentowanie znaczących zmian
- Dołączenie kopii licencji Apache License 2.0

Więcej szczegółów o licencji: http://www.apache.org/licenses/LICENSE-2.0

**Copyright (c) Calasans - Wszelkie prawa zastrzeżone**