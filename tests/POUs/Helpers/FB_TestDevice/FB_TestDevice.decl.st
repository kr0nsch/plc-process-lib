// Назначение: тестовое устройство — наследник FB_DeviceBase, на котором проверяется база.
//             Тело — нормативный порядок цикла устройства (docs/fb/FB_DeviceBase.md): ResolveTime
//             до вложенного FB_Delay, BeginCycle, AcceptCfg(CheckConfig) с LKG, Reset с
//             фиксируемым отказом, ProcessMode, команды пуск/стоп (SwitchRemoteMode при «Стоп» в
//             Auto), безопасный выход, RunAlarms, FinishCycle. Переопределяет хук OnModeChanged
//             (безударность, снятие отказа при входе в OutOfService) и записывает его вызовы.
//             xInputLike = TRUE ведёт себя как AI/DI: режим в stModeMem, Manual = CheckFunction.
//             Только для тестов.
// Автор:      <ИМЯ ФАМИЛИЯ>
// Версия:     0.1.0
// Документ:   docs/TESTING.md, раздел «Тестовое устройство»
FUNCTION_BLOCK FB_TestDevice EXTENDS FB_DeviceBase
VAR CONSTANT
    CFG_GAIN   : WORD := 16#0001;  // wCfgErr бит 0: rGain не конечен или <= 0
    CFG_ALARM  : WORD := 16#0002;  // wCfgErr бит 1: приоритет тревоги вне перечисления (CheckAlarmCfg)
    STS_OUTPUT : WORD := 16#0001;  // wStatus бит 0: выход включён
    STS_FAULT  : WORD := 16#0002;  // wStatus бит 1: зафиксирован отказ
    FLT_LATCH  : WORD := 16#0001;  // wFault бит 0: зафиксированный механический отказ
    GAIN_SCALE : REAL := 10.0;     // rOut_eu = rGain * GAIN_SCALE
END_VAR
VAR_INPUT
    xAutoRun        : BOOL;                                   // запрос автоматики «работать»
    xLocal          : BOOL;                                   // переключатель «Местное»
    xMoving         : BOOL;                                   // механизм в движении: вывод из работы запрещён
    xFaultCause     : BOOL;                                   // причина механического отказа (фиксируется)
    xShedToManual   : BOOL;                                   // логика устройства переводит в Manual
    xLocalSupported : BOOL := TRUE;                           // FALSE — как у AI/DI: режима Local нет
    xInputLike      : BOOL;                                   // TRUE — как AI/DI (задаётся до первого вызова)
    uiAlarmSlots    : UINT := 8;                              // используемых слотов (в первом вызове)
    eTypeSel        : E_DeviceType := E_DeviceType.Valve;     // тип для eDevType (в первом вызове)
    eDevStatusIn    : E_Ne107Status := E_Ne107Status.Good;    // вклад логики устройства в NE 107
    wWarnIn         : WORD;                                   // предупреждения устройства
    axCondIn        : ARRAY[0..GVL_Const.DEV_ALARMS_MAX - 1] OF BOOL;   // условия тревог слотов
    axSuppressIn    : ARRAY[0..GVL_Const.DEV_ALARMS_MAX - 1] OF BOOL;   // подавление по условию
    rValueIn        : REAL;                                   // значение процесса для событий
END_VAR
VAR_IN_OUT
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные (при xInputLike не используются)
END_VAR
VAR_IN_OUT CONSTANT
    stCfg : ST_TestDeviceCfg;      // конфигурация
END_VAR
VAR_OUTPUT
    xOutput : BOOL;                // выход механизма; безопасное состояние — FALSE
    rOut_eu : REAL;                // значение по LKG: rGain * 10; 0 — корректной Cfg не было
    stSts   : ST_TestDeviceSts;    // состояние для HMI
END_VAR
VAR
    stCfgLkg       : ST_TestDeviceCfg;   // последняя корректная конфигурация (LKG)
    fbRunDelay     : FB_Delay;           // задержка включения в Auto — вызывается до BeginCycle
    xManualRun     : BOOL;               // ручная защёлка «работать»
    xFaultLatched  : BOOL;               // зафиксированный механический отказ
    xFaultAdd      : BOOL;               // точка расширения: доп. причина отказа (пишет наследник до SUPER^)
    uiBodyCalls    : UINT;               // сколько раз выполнено это тело
    ltDtSeen       : LTIME;              // ltDt последнего вызова (после BeginCycle)
    // --- журнал хука OnModeChanged ---
    uiHookCalls    : UINT;               // вызовов хука
    eHookOld       : E_DeviceMode := E_DeviceMode.Manual;   // eOld последнего вызова
    eHookNew       : E_DeviceMode := E_DeviceMode.Manual;   // eNew последнего вызова
    xHookInFirst   : BOOL;               // хук вызывался в первом вызове (xFirstCall = TRUE)
    udiHookTrace   : UDINT;              // порядок частей хука: цифра на уровень иерархии (1 — этот ФБ)
END_VAR
VAR_TEMP
    xResetNow : BOOL;                    // Reset в этом вызове
    eRes      : E_CmdResult;             // результат ProcessMode
    eDevSt    : E_Ne107Status;           // статус логики устройства
    uiLoop    : UINT;                    // номер слота + 1
    uiSlot    : UINT;                    // номер слота
END_VAR
