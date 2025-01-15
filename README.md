# Real-Time

O Real-Time é um Filterscript para SA-MP (San Andreas Multiplayer) que sincroniza o tempo do jogo com o horário real, proporcionando uma experiência mais imersiva através da mudança automática do horário no servidor baseado no tempo real.

## Idiomas

- Deutsch: [README](translations/Deutsch/README.md)
- English: [README](translations/English/README.md)
- Español: [README](translations/Espanol/README.md)
- Français: [README](translations/Francais/README.md)
- Italiano: [README](translations/Italiano/README.md)
- Polski: [README](translations/Polski/README.md)
- Русский: [README](translations/Русский/README.md)
- Svenska: [README](translations/Svenska/README.md)
- Turk: [README](translations/Turkce/README.md)

## Índice
- [Real-Time](#real-time)
  - [Idiomas](#idiomas)
  - [Índice](#índice)
  - [Instalação](#instalação)
  - [Funcionamento Técnico](#funcionamento-técnico)
    - [Sistema de Horários](#sistema-de-horários)
  - [Casos de Uso](#casos-de-uso)
    - [Ideal para:](#ideal-para)
  - [Detalhes Técnicos](#detalhes-técnicos)
    - [Otimizações Implementadas](#otimizações-implementadas)
    - [Características principais:](#características-principais)
  - [Licença](#licença)
    - [Condições:](#condições)

## Instalação

1. Baixe o arquivo [Real-Time.amx](https://github.com/ocalasans/Real-Time/raw/refs/heads/main/src/Real-Time.amx)
2. Copie o arquivo para a pasta `filterscripts` do seu servidor
3. Edite o arquivo `server.cfg`
4. Adicione `Real-Time` na linha `filterscripts`

**Exemplo de configuração no server.cfg:**
```
filterscripts Real-Time
```

> [!WARNING]
> Se já existirem outros filterscripts carregados, adicione o Real-Time após eles.

## Funcionamento Técnico

O sistema opera através de um timer otimizado que verifica o horário atual a cada 5 segundos. Abaixo está um trecho do código que demonstra como a verificação é feita:

```pawn
#define TRF_UPDATE_INTERVAL  (5*1000) // Atualiza a cada 5 segundos
#define TRF_DAWN_TIME        (5) // 00:00 - 05:59 -> 05:00
#define TRF_MORNING_TIME     (7) // 06:00 - 10:59 -> 07:00
#define TRF_NOON_TIME        (12) // 11:00 - 15:59 -> 12:00
#define TRF_EVENING_TIME     (20) // 16:00 - 17:59 -> 20:00
#define TRF_NIGHT_TIME       (0) // 18:00 - 23:59 -> 00:00
```

### Sistema de Horários
O Filterscript utiliza as seguintes conversões de tempo:
- **Madrugada**: 00:00 - 05:59 → 05:00 no jogo
- **Manhã**: 06:00 - 10:59 → 07:00 no jogo
- **Tarde**: 11:00 - 15:59 → 12:00 no jogo
- **Fim de Tarde**: 16:00 - 17:59 → 20:00 no jogo
- **Noite**: 18:00 - 23:59 → 00:00 no jogo

> [!NOTE]
> O sistema utiliza `gettime()` para obter o horário atual do servidor. É crucial que seu servidor esteja configurado com o fuso horário correto.

## Casos de Uso

### Ideal para:
1. **Servidores RolePlay**
   - Aumenta o realismo
   - Sincroniza eventos do servidor com horários reais
   - Melhora a imersão dos jogadores

2. **Servidores DayZ**
   - Sistema dia/noite realista
   - Ciclo de tempo natural
   - Planejamento de eventos baseados no tempo real

3. **Servidores Competitivos**
   - Organização de eventos em horários específicos
   - Mudanças de ambiente programadas
   - Integração com sistemas de clima

## Detalhes Técnicos

### Otimizações Implementadas
```pawn
// Variável global para evitar atualizações desnecessárias
static TRF_Last_WorldTime = -1;

// Função de atualização otimizada
public TRF_UpdateWorldTime() {
    new TRF_Current_Hour,
        TRF_Current_Minute,
        TRF_Current_Second;
    
    gettime(TRF_Current_Hour, TRF_Current_Minute, TRF_Current_Second);
    
    // Só atualiza se o horário mudou
    if(TRF_New_WorldTime != TRF_Last_WorldTime)
    {
        SetWorldTime(TRF_New_WorldTime);
        TRF_Last_WorldTime = TRF_New_WorldTime;
    }
}
```

### Características principais:
- Cache do último horário para evitar atualizações redundantes
- Timer otimizado para reduzir o uso de recursos
- Compatibilidade total com outros filterscripts

> [!IMPORTANT]
> O sistema foi desenvolvido pensando na performance, realizando verificações apenas quando necessário e mantendo um cache do último horário definido.

## Licença

Este Filterscript está protegido sob a Licença Apache 2.0, que permite:

- ✔️ Uso comercial e privado
- ✔️ Modificação do código fonte
- ✔️ Distribuição do código
- ✔️ Concessão de patentes

### Condições:
- Manter o aviso de direitos autorais
- Documentar alterações significativas
- Incluir cópia da licença Apache 2.0

Para mais detalhes sobre a licença: http://www.apache.org/licenses/LICENSE-2.0

**Copyright (c) Calasans - Todos os direitos reservados**