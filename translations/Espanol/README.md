# Real-Time

Real-Time es un Filterscript para SA-MP (San Andreas Multiplayer) que sincroniza el tiempo del juego con el tiempo real, proporcionando una experiencia más inmersiva a través de cambios automáticos de tiempo en el servidor basados en el tiempo real.

## Idiomas

- Português: [README](../../)
- Deutsch: [README](../Deutsch/README.md)
- English: [README](../English/README.md)
- Français: [README](../Francais/README.md)
- Italiano: [README](../Italiano/README.md)
- Polski: [README](../Polski/README.md)
- Русский: [README](../Русский/README.md)
- Svenska: [README](../Svenska/README.md)
- Türkçe: [README](../Turkce/README.md)

## Contenidos
- [Real-Time](#real-time)
  - [Idiomas](#idiomas)
  - [Contenidos](#contenidos)
  - [Instalación](#instalación)
  - [Operación Técnica](#operación-técnica)
    - [Sistema de Tiempo](#sistema-de-tiempo)
  - [Casos de Uso](#casos-de-uso)
    - [Ideal para:](#ideal-para)
  - [Detalles Técnicos](#detalles-técnicos)
    - [Optimizaciones Implementadas](#optimizaciones-implementadas)
    - [Características Principales:](#características-principales)
  - [Licencia](#licencia)
    - [Condiciones:](#condiciones)

## Instalación

1. Descarga el archivo [Real-Time.amx](https://github.com/ocalasans/Real-Time/raw/refs/heads/main/src/Real-Time.amx)
2. Copia el archivo en la carpeta `filterscripts` de tu servidor
3. Edita el archivo `server.cfg`
4. Añade `Real-Time` en la línea `filterscripts`

**Ejemplo de configuración en server.cfg:**
```
filterscripts Real-Time
```

> [!ADVERTENCIA]
> Si otros filterscripts ya están cargados, añade Real-Time después de ellos.

## Operación Técnica

El sistema opera a través de un temporizador optimizado que verifica el tiempo actual cada 5 segundos. A continuación se muestra un fragmento de código que demuestra cómo se realiza la verificación:

```pawn
#define TRF_UPDATE_INTERVAL  (5*1000) // Actualiza cada 5 segundos
#define TRF_DAWN_TIME        (5) // 00:00 - 05:59 -> 05:00
#define TRF_MORNING_TIME     (7) // 06:00 - 10:59 -> 07:00
#define TRF_NOON_TIME        (12) // 11:00 - 15:59 -> 12:00
#define TRF_EVENING_TIME     (20) // 16:00 - 17:59 -> 20:00
#define TRF_NIGHT_TIME       (0) // 18:00 - 23:59 -> 00:00
```

### Sistema de Tiempo
El Filterscript utiliza las siguientes conversiones de tiempo:
- **Amanecer**: 00:00 - 05:59 → 05:00 en el juego
- **Mañana**: 06:00 - 10:59 → 07:00 en el juego
- **Tarde**: 11:00 - 15:59 → 12:00 en el juego
- **Atardecer**: 16:00 - 17:59 → 20:00 en el juego
- **Noche**: 18:00 - 23:59 → 00:00 en el juego

> [!NOTA]
> El sistema utiliza `gettime()` para obtener el tiempo actual del servidor. Es crucial que tu servidor esté configurado con la zona horaria correcta.

## Casos de Uso

### Ideal para:
1. **Servidores RolePlay**
   - Aumenta el realismo
   - Sincroniza eventos del servidor con tiempos reales
   - Mejora la inmersión del jugador

2. **Servidores DayZ**
   - Sistema realista de día/noche
   - Ciclo natural de tiempo
   - Planificación de eventos basada en tiempo real

3. **Servidores Competitivos**
   - Organización de eventos en horarios específicos
   - Cambios programados del entorno
   - Integración con sistemas climáticos

## Detalles Técnicos

### Optimizaciones Implementadas
```pawn
// Variable global para evitar actualizaciones innecesarias
static TRF_Last_WorldTime = -1;

// Función de actualización optimizada
public TRF_UpdateWorldTime() {
    new TRF_Current_Hour,
        TRF_Current_Minute,
        TRF_Current_Second;
    
    gettime(TRF_Current_Hour, TRF_Current_Minute, TRF_Current_Second);
    
    // Solo actualiza si el tiempo ha cambiado
    if(TRF_New_WorldTime != TRF_Last_WorldTime)
    {
        SetWorldTime(TRF_New_WorldTime);
        TRF_Last_WorldTime = TRF_New_WorldTime;
    }
}
```

### Características Principales:
- Caché del último tiempo para evitar actualizaciones redundantes
- Temporizador optimizado para reducir el uso de recursos
- Compatibilidad total con otros filterscripts

> [!IMPORTANTE]
> El sistema fue desarrollado pensando en el rendimiento, realizando verificaciones solo cuando es necesario y manteniendo un caché del último tiempo establecido.

## Licencia

Este Filterscript está protegido bajo la Licencia Apache 2.0, que permite:

- ✔️ Uso comercial y privado
- ✔️ Modificación del código fuente
- ✔️ Distribución del código
- ✔️ Concesión de patente

### Condiciones:
- Mantener el aviso de copyright
- Documentar cambios significativos
- Incluir copia de la Licencia Apache 2.0

Para más detalles sobre la licencia: http://www.apache.org/licenses/LICENSE-2.0

**Copyright (c) Calasans - Todos los derechos reservados**