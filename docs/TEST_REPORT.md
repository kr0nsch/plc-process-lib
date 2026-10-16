# Отчёт о тестировании

Результаты юнит-тестов CfUnit (coUnit 1.2.0.0) в CODESYS Control Win V3 и проверок без CODESYS.
Запись «проверено в CODESYS» появляется только после реального прогона. Раздел «Последний прогон
в CODESYS» обновляет `python tools/codesys/cds.py report` по итогам `cds.py test`
(`build/test-results.json`); правки внутри него вручную перезаписываются.

<!-- cds:test-report:begin (раздел обновляет `python tools/codesys/cds.py report`) -->
## Последний прогон в CODESYS

Проверено в CODESYS 3.5.17.30 / CODESYS Control Win V3 (пользовательский процесс) — 2026-10-16 09:39:47. Итог: **все тесты пройдены**.

| Параметр | Значение |
|---|---|
| Дата прогона | 2026-10-16 09:39:47 |
| Коммит | 6f21234-dirty |
| CODESYS | 3.5.17.30 (профиль `CODESYS V3.5 SP17 Patch 3`) |
| Устройство в проекте | CODESYS Control Win V3 (4096 / 0000 0001 / 3.5.17.30) |
| Рантайм | CODESYS Control Win V3 (пользовательский процесс) |
| Фреймворк тестов | coUnit (CfUnit) 1.2.0.0 |
| Сборка | ошибок 0, предупреждений 0 |
| Способ запуска | `python tools/codesys/cds.py test` |

| Набор | Тестов | Пройдено | Упало | Пропущено | Итог |
|---|---|---|---|---|---|
| `GVL_TestsFoundation.fbTimeTest` | 24 | 24 | 0 | 0 | пройдено |
| `GVL_TestsFoundation.fbUtilTest` | 26 | 26 | 0 | 0 | пройдено |
| `GVL_TestsFoundation.fbCommonTest` | 11 | 11 | 0 | 0 | пройдено |
| `GVL_TestsAlarm.fbAlarmTest` | 38 | 38 | 0 | 0 | пройдено |
| `GVL_TestsAlarm.fbDeviceBaseTest` | 44 | 44 | 0 | 0 | пройдено |
| `GVL_TestsAlarm.fbRuntimeTest` | 8 | 8 | 0 | 0 | пройдено |
| **Всего** | 151 | 151 | 0 | 0 | **пройдено** |

### Результаты тестов

| Набор | Тест | Итог |
|---|---|---|
| `GVL_TestsFoundation.fbTimeTest` | `Time_LTimeToSec_OneSecond_ReturnsOne` | пройден |
| `GVL_TestsFoundation.fbTimeTest` | `Time_LTimeToSec_NanosecondAndDays_Exact` | пройден |
| `GVL_TestsFoundation.fbTimeTest` | `Time_TimeToSec_1500ms_Returns1p5` | пройден |
| `GVL_TestsFoundation.fbTimeTest` | `Time_TimeToSec_MaxTime_NoOverflow` | пройден |
| `GVL_TestsFoundation.fbTimeTest` | `Time_FakeTime_StartsAtOneHour` | пройден |
| `GVL_TestsFoundation.fbTimeTest` | `Time_FakeTime_Advance_AddsStep` | пройден |
| `GVL_TestsFoundation.fbTimeTest` | `Time_FakeTime_SetNow_SetsValue` | пройден |
| `GVL_TestsFoundation.fbTimeTest` | `Time_FakeTime_AdvanceL_SubMsAndLongSteps` | пройден |
| `GVL_TestsFoundation.fbTimeTest` | `Time_FakeTime_ViaInterface_ReturnsSameTime` | пройден |
| `GVL_TestsFoundation.fbTimeTest` | `Time_SystemTime_IsMonotonic` | пройден |
| `GVL_TestsFoundation.fbTimeTest` | `Delay_ZeroDelays_PassThroughSameCall` | пройден |
| `GVL_TestsFoundation.fbTimeTest` | `Delay_OnDelay_OutputExactlyAtDelay` | пройден |
| `GVL_TestsFoundation.fbTimeTest` | `Delay_OnDelay_ShortPulse_Ignored` | пройден |
| `GVL_TestsFoundation.fbTimeTest` | `Delay_OffDelay_HoldsOutputForDelay` | пройден |
| `GVL_TestsFoundation.fbTimeTest` | `Delay_DelayChangedWhileTiming_UsesNewValue` | пройден |
| `GVL_TestsFoundation.fbTimeTest` | `Delay_Preset_ForcesOutputWithoutDelay` | пройден |
| `GVL_TestsFoundation.fbTimeTest` | `Delay_Preset_RestartsTimingOnNextCall` | пройден |
| `GVL_TestsFoundation.fbTimeTest` | `Delay_TimeGoesBackwards_RestartsTiming` | пройден |
| `GVL_TestsFoundation.fbTimeTest` | `Delay_NoTimeSource_FallsBackToSystemTime` | пройден |
| `GVL_TestsFoundation.fbTimeTest` | `Delay_Remaining_ReportsTimeLeft` | пройден |
| `GVL_TestsFoundation.fbTimeTest` | `Delay_BothDelays_OnThenOffTimed` | пройден |
| `GVL_TestsFoundation.fbTimeTest` | `Delay_OffDelay_ShortGap_Ignored` | пройден |
| `GVL_TestsFoundation.fbTimeTest` | `Delay_TimingFlags_ReflectCountdown` | пройден |
| `GVL_TestsFoundation.fbTimeTest` | `Delay_FirstCallWithInputTrue_StartsOnDelay` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_IsFinite_NaN_ReturnsFalse` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_IsFinite_Inf_ReturnsFalse` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_IsFinite_Normal_ReturnsTrue` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_IsFinite_AboveSaneMax_ReturnsFalse` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_Ne107Worst_ReturnsMostSevere` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_RateLimit_UpAndDownRatesSeparate` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_RateLimit_ZeroRate_Jumps` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_RateLimit_ZeroDt_NoChange` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_RateLimit_NonFiniteTarget_HoldsCurrent` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_RateLimit_NonFiniteCurrent_JumpsToTarget` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_RateLimit_SmallStep_ReachesTargetExactly` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_StartsWindow_CountsOnlyLastHour` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_StartsWindow_TimeToFree_ReportsRemaining` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_StartsWindow_ExactlyOneHourOld_NotCounted` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_StartsWindow_RingFull_OverwritesOldest` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_StartsWindow_RingCapacity_MatchesConst` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_StartsWindow_TimeBackwards_DropsFutureStamps` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_StartsWindow_Clear_Empties` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_LimitMonitor_HighHysteresis_ClearsBelowSpMinusHyst` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_LimitMonitor_LowHysteresis_ClearsAboveSpPlusHyst` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_LimitMonitor_ForceOff_ClearsImmediately` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_LimitMonitor_Disabled_NeverSets` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_LimitMonitor_OnDelay_ShortExcursionIgnored` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_LimitMonitor_OffDelay_HoldsFlag` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_LimitMonitor_NonFiniteValue_KeepsState` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_LimitMonitor_Reenabled_RestartsOnDelay` | пройден |
| `GVL_TestsFoundation.fbCommonTest` | `Common_SizeOfSts_MatchesRegisterMap` | пройден |
| `GVL_TestsFoundation.fbCommonTest` | `Common_SizeOfDeviceRetain_Is36` | пройден |
| `GVL_TestsFoundation.fbCommonTest` | `Common_SizeOfAlarmCfg_Is16` | пройден |
| `GVL_TestsFoundation.fbCommonTest` | `Common_SizeOfCfg_MatchesReference` | пройден |
| `GVL_TestsFoundation.fbCommonTest` | `Common_SizeOfCmd_MatchesReference` | пройден |
| `GVL_TestsFoundation.fbCommonTest` | `Common_CfgDefaults_MatchContract` | пройден |
| `GVL_TestsFoundation.fbCommonTest` | `Common_StsRetainDefaults_MatchContract` | пройден |
| `GVL_TestsFoundation.fbCommonTest` | `Common_EnumValues_MatchRegisterCodes` | пройден |
| `GVL_TestsFoundation.fbCommonTest` | `Common_AlarmSlots_FitDeviceCounts` | пройден |
| `GVL_TestsFoundation.fbCommonTest` | `Common_TestSink_RecordsEventsInOrder` | пройден |
| `GVL_TestsFoundation.fbCommonTest` | `Common_InterfaceRefs_DefaultToNull` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_Activate_GoesActiveUnack` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_AckWhileActive_GoesActiveAck` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_ReturnWithoutAck_GoesRtnUnack` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_AckAfterReturn_GoesNormal` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_ActiveAckReturn_GoesNormal` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_ReactivateFromRtnUnack_GoesActiveUnack` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_OnDelay_ShortCondition_NoAlarm` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_OffDelay_HoldsActive` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_Shelve_TimeoutUnshelvesAndReannunciates` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_ShelveDurationAboveMax_ClippedToMax` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_ShelveMaxZero_ShelveRejected` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_Unshelve_ConditionCleared_GoesNormal` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_SuppressByDesign_NoAnnunciation` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_OutOfService_OverridesShelve` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_PriorityNone_NeverActivates` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_AckInNormal_ReturnsFalse` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_SeqIncrementsOnEachTransition` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_Transition_SendsEventToSink` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_AckAndClearSameCall_TwoEventsInOrder` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_PriorityNoneToMedium_ActiveCondition_Activates` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_PriorityChangeWhileActive_NoEvent` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_PriorityOutOfEnum_TreatedAsMedium` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_SuppressClearsUnack_ReleaseWithoutCondition_GoesNormal` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_ShelveWhileSuppressed_ShelvedAfterRelease` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_ShelveExpiresDuringSuppress_ReleaseGoesToBase` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_OosOffWithSuppressActive_GoesSuppressed` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_OosEntry_ClearsUnack_ReannunciatesOnExit` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_ShelveRemain_CountsDown` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_TimeBackwards_ShelveRemainNotExtended` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_Reshelve_RestartsTimer` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_ActiveWhileShelved_FollowsCondition` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_InterfaceProperties_MatchOutputs` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_NoTimeSource_FallsBackToSystemTime` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_Unshelve_ReturnsTrueOnlyWhenShelved` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_ShelveRequestThenOos_Rejected` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_PriorityNone_CancelsShelve` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_PriorityReenabled_OnDelayCountsFromEnabling` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_AckWithoutEffect_NotKeptForLater` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_RetainModeInvalid_SanitizedToManual` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_ConflictingModeRequests_OosWins` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_LocalOverridesRemote_ReturnsToRememberedMode` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_ModeRequestInLocal_ChangesRememberedMode` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_RequestMode_SameEffectAsCmd` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_RequestModeLocal_ReturnsFalse` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_AckAll_AcksEveryAlarm` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_AckMask_AcksOnlySelectedSlot` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_ShelveMask_ShelvesSlotForMax` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_ShelveMaskNotAccepted_RejectedState` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_GetAlarmOutOfRange_ReturnsNull` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_CmdResult_SeqIncrementsPerCommand` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_CmdBits_ClearedAfterProcessing` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_OosEntry_ClearsLatchedFaults` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_OnModeChangedHook_CalledInDerived` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_OutOfServiceRetained_StartsInOos` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_HookViaThis_DispatchesToMostDerivedOverride` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_SuperBodyCall_RunsBaseBodyOnSameStructs` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_DerivedBodyWithoutSuper_BaseBodyNotRun` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_InvalidCfgAtStart_CheckFunctionSafeOutput` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_InvalidCfgDuringOperation_KeepsLastValidCfg` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_AlarmPriorityInvalid_CfgErrBit` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_DefaultAlarmCfgOfAllTypes_PassesCheckAlarmCfg` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_SummaryStatus_MaxOfDeviceModeAndCfg` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_StsHeader_AllFieldsFilled` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_Failure_SafeStateResetRules` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_StopInAuto_SwitchesToManual` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_SwitchRemoteModeInLocal_OnlyRemembers` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_AutoToManual_BumplessKeepsOutput` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_OosExitWithLocalSelected_GoesLocal` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_BeginCycle_DtZeroOnFirstCallThenFromTimeSource` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_NoTimeSource_UsesSystemTime` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_ResolveTimeBeforeBeginCycle_NestedDelayDeterministic` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_AlarmIds_BaseFromCfgPlusSlot` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_AlarmsInOos_AllSlotsOutOfService` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_AlarmSummary_WordsAndPrioUnack` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_ZeroAlarmCount_NoSlotsRun` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_ResetCmd_AcksAlarmsAndClearsLatch` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_DevTypeSetByHeir_ReportedInStsCommon` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_InputLike_ModeMemStartsAutoManualIsCheck` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_ImplementsIDevice_InterfaceAccess` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_AlarmSlotArrays_MatchDevAlarmsMax` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_MethodRequests_ProcessedOnce` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_ShelveMaskOnOosEntry_RejectedState` | пройден |
| `GVL_TestsAlarm.fbRuntimeTest` | `Runtime_LTime_MonotonicAcrossTaskCycles` | пройден |
| `GVL_TestsAlarm.fbRuntimeTest` | `Runtime_LTime_ResolutionAtMost1us` | пройден |
| `GVL_TestsAlarm.fbRuntimeTest` | `Runtime_MethodCallWithoutThis_DispatchesVirtually` | пройден |
| `GVL_TestsAlarm.fbRuntimeTest` | `Runtime_PartialArrayInitializer_RestGetsElementDefaults` | пройден |
| `GVL_TestsAlarm.fbRuntimeTest` | `Runtime_LTimeSubtraction_WrapsWhenNegative` | пройден |
| `GVL_TestsAlarm.fbRuntimeTest` | `Runtime_UnsignedCounters_WrapToZero` | пройден |
| `GVL_TestsAlarm.fbRuntimeTest` | `Runtime_LocalDeviceInstances_RunInTestMethod` | пройден |
| `GVL_TestsAlarm.fbRuntimeTest` | `Runtime_LkgCopy300MotorCfg_Below1ms` | пройден |

### Упавшие тесты

_Нет._

Машиночитаемые результаты: `build/test-results.json`, `build/junit.xml` (не в git).
<!-- cds:test-report:end -->

## Что проверяют тесты

Наборы основы регистрируются в `tests/GVLs/GVL_TestsFoundation.gvl.st` (этап 1: время, утилиты,
общие типы) и `tests/GVLs/GVL_TestsAlarm.gvl.st` (этап 2: `FB_Alarm`, `FB_DeviceBase`, зонды времени
выполнения); соглашения — [TESTING.md](TESTING.md). Тесты из списка 23.2 контракта и тесты сверх него
(граничные значения и отказы) — в одной таблице, порядок — как в теле набора. Описание строки —
комментарий объявления метода-теста.

| Набор | Тест | Что проверяет |
|---|---|---|
| `FB_Time_Test` | `Time_LTimeToSec_OneSecond_ReturnsOne` | F_LTimeToSec: LTIME#1S (1e9 нс) — ровно 1 с, LTIME#1MS — 0,001 с. Эталон — `tools/reference/common.py`. |
| `FB_Time_Test` | `Time_LTimeToSec_NanosecondAndDays_Exact` | F_LTimeToSec: 1 нс — 1e-9 с (разрешение LTIME); 100 сут — 8 640 000 с: 8,64e15 нс меньше 2^53, LREAL представляет их точно. Эталон — `tools/reference/common.py`. |
| `FB_Time_Test` | `Time_TimeToSec_1500ms_Returns1p5` | F_TimeToSec: T#1500MS — 1,5 с. |
| `FB_Time_Test` | `Time_TimeToSec_MaxTime_NoOverflow` | F_TimeToSec: наибольшее TIME (2^32 - 1 мс) переводится без переполнения — 4 294 967,295 с. Эталон — `tools/reference/common.py`. |
| `FB_Time_Test` | `Time_FakeTime_StartsAtOneHour` | FB_FakeTime стартует с LTIME#1H, а не с 0: ловит код, который считает «0 = не инициализировано». |
| `FB_Time_Test` | `Time_FakeTime_Advance_AddsStep` | Advance прибавляет шаг TIME: два шага по 250 мс, затем длинный шаг 49 сут. |
| `FB_Time_Test` | `Time_FakeTime_SetNow_SetsValue` | SetNow ставит время вперёд и назад (назад — допустимо, ФБ библиотеки это переживают). |
| `FB_Time_Test` | `Time_FakeTime_AdvanceL_SubMsAndLongSteps` | AdvanceL: шаги меньше 1 мс (4 по 250 мкс) и больше 49 сут (60 сут). |
| `FB_Time_Test` | `Time_FakeTime_ViaInterface_ReturnsSameTime` | Через I_TimeSource FB_FakeTime отдаёт то же время, что и напрямую (так его получают ФБ библиотеки). |
| `FB_Time_Test` | `Time_SystemTime_IsMonotonic` | Дымовая проверка FB_SystemTime (оператор LTIME()): 20 000 вызовов подряд — время не убывает, растёт (значит, берётся заново в каждом вызове) и больше нуля. Реального ожидания нет. Проверка R1 контракта; ручная проверка со сменой времени ОС — docs/MANUAL_STEPS.md. |
| `FB_Time_Test` | `Delay_ZeroDelays_PassThroughSameCall` | Задержки T#0S: фронт и спад проходят в том же вызове, отсчёта нет. Время не продвигается. |
| `FB_Time_Test` | `Delay_OnDelay_OutputExactlyAtDelay` | Задержка включения 2 с, шаг 100 мс: выход включается ровно на 20-м шаге (t0 + 2,0 с), не на 19-м. |
| `FB_Time_Test` | `Delay_OnDelay_ShortPulse_Ignored` | Импульс 1,5 с при задержке включения 2 с, затем 5 с покоя: выход не включается ни разу, ожидание отменяется. |
| `FB_Time_Test` | `Delay_OffDelay_HoldsOutputForDelay` | Задержка отключения 3 с: выход держится до t0 + 2,9 с (идёт отсчёт) и снимается ровно в t0 + 3,0 с. |
| `FB_Time_Test` | `Delay_DelayChangedWhileTiming_UsesNewValue` | Изменение задержки во время отсчёта действует сразу: прошедшее время сравнивается с новым значением. Уменьшение 10 с → 1 с через 1,5 с — выход в том же вызове; увеличение 2 с → 5 с через 1,5 с — выхода нет в 2,0 с и 4,9 с, есть в 5,0 с. |
| `FB_Time_Test` | `Delay_Preset_ForcesOutputWithoutDelay` | Preset ставит выход сразу, без задержек включения и отключения (5 с каждая). |
| `FB_Time_Test` | `Delay_Preset_RestartsTimingOnNextCall` | После Preset отсчёт начинается заново с ближайшего вызова тела: задержка 2 с, через 1,5 с Preset(FALSE), следующий вызов в t0 + 1,6 с — выход только в t0 + 3,6 с, а не в t0 + 2,0 с. |
| `FB_Time_Test` | `Delay_TimeGoesBackwards_RestartsTiming` | «Время назад» (SetNow на 11,5 с раньше) во время отсчёта: выход не меняется, остаток — полная задержка (разность LTIME без переполнения), выход ровно через 2 с от нового времени. |
| `FB_Time_Test` | `Delay_NoTimeSource_FallsBackToSystemTime` | Без источника (itfTime = 0) FB_Delay берёт встроенный FB_SystemTime: задержка 1 ч идёт и не истекает за время теста; нулевая задержка проходит сразу. Реального ожидания нет. |
| `FB_Time_Test` | `Delay_Remaining_ReportsTimeLeft` | tRemaining: полная задержка сразу после фронта, остаток по ходу отсчёта, T#0S без отсчёта; то же для задержки отключения. |
| `FB_Time_Test` | `Delay_BothDelays_OnThenOffTimed` | Обе задержки: включение 1 с, отключение 2 с, шаг 500 мс. |
| `FB_Time_Test` | `Delay_OffDelay_ShortGap_Ignored` | Провал входа 1,9 с при задержке отключения 3 с, затем 5 с с TRUE: выход не снимается ни разу. |
| `FB_Time_Test` | `Delay_TimingFlags_ReflectCountdown` | xTimingOn и xTimingOff взведены только во время своих отсчётов (задержки по 1 с). |
| `FB_Time_Test` | `Delay_FirstCallWithInputTrue_StartsOnDelay` | Первый вызов сразу с xIn = TRUE ставит отметку и начинает отсчёт. Подменное время стартует с 1 ч: без отметки первого вызова разность с нулевой отметкой была бы 1 ч, и выход включился бы сразу. |
| `FB_Util_Test` | `Util_IsFinite_NaN_ReturnsFalse` | F_IsFinite: тихий NaN с обоими знаками и с полной мантиссой — FALSE (проверка R4 контракта). |
| `FB_Util_Test` | `Util_IsFinite_Inf_ReturnsFalse` | F_IsFinite: +Inf и -Inf — FALSE. |
| `FB_Util_Test` | `Util_IsFinite_Normal_ReturnsTrue` | F_IsFinite: обычные числа, 0, -0, наименьшее денормализованное и граница ±REAL_SANE_MAX (включительно) — TRUE. |
| `FB_Util_Test` | `Util_IsFinite_AboveSaneMax_ReturnsFalse` | F_IsFinite: \|x\| > REAL_SANE_MAX — мусор (перепутан порядок слов Modbus): 1e31, -1e31 и наибольшее REAL — FALSE. |
| `FB_Util_Test` | `Util_Ne107Worst_ReturnsMostSevere` | F_Ne107Worst: результат — более тяжёлый статус (F > C > S > M > Good), порядок аргументов не важен. |
| `FB_Util_Test` | `Util_RateLimit_UpAndDownRatesSeparate` | F_RateLimit: рост ограничен 10 ед./с, спад — 2 ед./с, каждый своей скоростью. Эталон — `tools/reference/common.py`. |
| `FB_Util_Test` | `Util_RateLimit_ZeroRate_Jumps` | F_RateLimit: скорость 0 — без ограничения (сразу к цели); ограничение другого направления действует. Эталон — `tools/reference/common.py`. |
| `FB_Util_Test` | `Util_RateLimit_ZeroDt_NoChange` | F_RateLimit: шаг времени 0 или отрицательный — значение не меняется. |
| `FB_Util_Test` | `Util_RateLimit_NonFiniteTarget_HoldsCurrent` | F_RateLimit: цель NaN, +Inf или больше REAL_SANE_MAX (мусор из Modbus/ПИД) — значение удерживается. |
| `FB_Util_Test` | `Util_RateLimit_NonFiniteCurrent_JumpsToTarget` | F_RateLimit: текущее значение NaN (мусор прошлого шага) заменяется конечной целью — ограничитель не застревает на NaN. |
| `FB_Util_Test` | `Util_RateLimit_SmallStep_ReachesTargetExactly` | F_RateLimit: если до цели меньше шага, результат — ровно цель, без перелёта. Эталон — `tools/reference/common.py`. |
| `FB_Util_Test` | `Util_StartsWindow_CountsOnlyLastHour` | FB_StartsWindow: пуски в 1:00, 1:20, 1:40 — в окне последнего часа их 3, 2, 1, 0 по мере старения. Эталон — `tools/reference/common.py`. |
| `FB_Util_Test` | `Util_StartsWindow_TimeToFree_ReportsRemaining` | TimeToFree: пуски 1:00, 1:10, 1:20; в 1:30 при лимите 3 — 30 мин, при лимите 2 — 40 мин, при лимите 4 и без лимита (0) — 0; в 2:00 при лимите 3 — 0. Эталон — `tools/reference/common.py`. |
| `FB_Util_Test` | `Util_StartsWindow_ExactlyOneHourOld_NotCounted` | Граница окна: отметка ровно часовой давности уже не считается (ltNow - t < STARTS_WINDOW). |
| `FB_Util_Test` | `Util_StartsWindow_RingFull_OverwritesOldest` | Кольцо на STARTS_WINDOW_MAX = 30: 31 пуск с шагом 1 мин (1:00…1:30) — остаются 30 последних; в 1:30 при лимите 30 окно освободится через 31 мин (самый старый оставшийся — 1:01). Эталон — `tools/reference/common.py`. |
| `FB_Util_Test` | `Util_StartsWindow_RingCapacity_MatchesConst` | Ёмкость кольца altStart равна GVL_Const.STARTS_WINDOW_MAX. Граница массива записана числом (iec_checker 0.4 не разбирает константы в границах), тест ловит расхождение с константой. Тест обращается к внутренней переменной ФБ намеренно: это проверка раскладки, а не API. |
| `FB_Util_Test` | `Util_StartsWindow_TimeBackwards_DropsFutureStamps` | Время назад: отметки «из будущего» удаляются и в Count, и в Register; окно остаётся упорядоченным. |
| `FB_Util_Test` | `Util_StartsWindow_Clear_Empties` | Clear очищает окно: пусков 0, освобождать нечего. |
| `FB_Util_Test` | `Util_LimitMonitor_HighHysteresis_ClearsBelowSpMinusHyst` | Верхняя уставка 80, гистерезис 5: флаг при значении >= 80 (включительно), держится до 75 включительно, снимается ниже 75; в зоне гистерезиса снятый флаг не возвращается. |
| `FB_Util_Test` | `Util_LimitMonitor_LowHysteresis_ClearsAboveSpPlusHyst` | Нижняя уставка 20, гистерезис 2 — зеркально: флаг при значении <= 20, держится до 22 включительно, снимается выше 22. |
| `FB_Util_Test` | `Util_LimitMonitor_ForceOff_ClearsImmediately` | xForceOff снимает флаг и сырой флаг в том же вызове, несмотря на задержку снятия 10 с; после снятия xForceOff флаг возвращается (значение по-прежнему выше уставки, задержки включения нет). |
| `FB_Util_Test` | `Util_LimitMonitor_Disabled_NeverSets` | Выключенная уставка (xEnable = FALSE) не взводит флаг: 10 с значение далеко за уставкой. |
| `FB_Util_Test` | `Util_LimitMonitor_OnDelay_ShortExcursionIgnored` | Задержка срабатывания 3 с: выброс 2,9 с за уставку флаг не взводит (сырой флаг — да); устойчивое превышение — флаг ровно через 3 с. |
| `FB_Util_Test` | `Util_LimitMonitor_OffDelay_HoldsFlag` | Задержка снятия 2 с: сырой флаг снимается сразу, выходной держится до t0 + 1,9 с и снимается ровно в t0 + 2,0 с. |
| `FB_Util_Test` | `Util_LimitMonitor_NonFiniteValue_KeepsState` | Неконечное значение (NaN, ±Inf, больше REAL_SANE_MAX) флаг не меняет: -Inf не снимает взведённый флаг верхней уставки, +Inf не взводит снятый. |
| `FB_Util_Test` | `Util_LimitMonitor_Reenabled_RestartsOnDelay` | Выключение уставки во время задержки срабатывания (2 с) сбрасывает отсчёт: после повторного включения в t0 + 1,6 с флаг — ровно через 2 с от включения, а не в t0 + 2,0 с. |
| `FB_Common_Test` | `Common_SizeOfSts_MatchesRegisterMap` | SIZEOF семи структур состояния — таблица 4.6 контракта (карта регистров Modbus = порядок полей, скрытого выравнивания нет). Источник: таблица 4.6 и tools/reference/common.py, сценарий sts_sizes. |
| `FB_Common_Test` | `Common_SizeOfDeviceRetain_Is36` | SIZEOF(ST_DeviceRetain) = 36 на Control Win V3 32 бит (зонд P17 контракта). |
| `FB_Common_Test` | `Common_SizeOfAlarmCfg_Is16` | SIZEOF(ST_AlarmCfg) = 16 (зонд Q14 контракта) и SIZEOF(ST_AiLimitCfg) = 20: элементы массивов astAlarm и astLimit в persistent-данных. Эталон — `tools/reference/common.py`. |
| `FB_Common_Test` | `Common_SizeOfCfg_MatchesReference` | SIZEOF структур Cfg — по расчёту раскладки (Control Win V3 32 бит). Cfg лежат в Persistent Variables приложения: изменение типа переинициализирует уставки (A-13), тест ловит его. Эталон — `tools/reference/common.py`. |
| `FB_Common_Test` | `Common_SizeOfCmd_MatchesReference` | SIZEOF структур команд HMI/SCADA (GVL_Hmi приложения). Эталон — `tools/reference/common.py`. |
| `FB_Common_Test` | `Common_CfgDefaults_MatchContract` | Значения Cfg по умолчанию — по контракту (на них опирается генератор: экземпляр без строки конфигурации корректен). Инициализатор элемента массива (ePriority := ...) оставляет прочим полям умолчания ST_AlarmCfg (проверка R9 контракта для DUT). |
| `FB_Common_Test` | `Common_StsRetainDefaults_MatchContract` | Умолчания общего заголовка и энергонезависимых данных: до первого вызова eMode = Manual, eNe107 = CheckFunction («не проверено»), тип None; дистанционный режим в Retain — Manual. Вложенный заголовок stCommon сохраняет свои умолчания. |
| `FB_Common_Test` | `Common_EnumValues_MatchRegisterCodes` | Коды перечислений в регистрах Modbus и SCADA — по контракту (крайние значения каждого типа). |
| `FB_Common_Test` | `Common_AlarmSlots_FitDeviceCounts` | Слоты тревог: последний индекс E_<Dev>Alarm + 1 = число используемых слотов типа (GVL_Const.<DEV>_ALARM_COUNT) и не больше DEV_ALARMS_MAX = 8 слотов базы. |
| `FB_Common_Test` | `Common_TestSink_RecordsEventsInOrder` | FB_TestSink через PL.GVL_Lib.itfAlarmSink (как его вызывает FB_Alarm): события по порядку, Last и GetEvent, кольцо на 32 события (33 события — остаются 32 последних), Clear. Приёмник возвращается в 0 до конца теста. |
| `FB_Common_Test` | `Common_InterfaceRefs_DefaultToNull` | Интерфейсные ссылки до присваивания — 0 (так их проверяют ФБ: itfTime <> 0); цепочка EXTENDS I_MotorVfd → I_Motor → I_Device → I_AlarmSource допускает приведение вверх. |
| `FB_Alarm_Test` | `Alarm_Activate_GoesActiveUnack` | Условие появилось (без задержек): Normal → ActiveUnack; xActive, xUnacked, xInList взведены, udiSeq = 1, ltLastChange — время перехода. |
| `FB_Alarm_Test` | `Alarm_AckWhileActive_GoesActiveAck` | Квитирование активной тревоги: Ack() возвращает TRUE и только ставит запрос; ближайший вызов тела переводит ActiveUnack → ActiveAck (тревога остаётся в списке, неквитированности нет). |
| `FB_Alarm_Test` | `Alarm_ReturnWithoutAck_GoesRtnUnack` | Условие ушло до квитирования: ActiveUnack → RtnUnack; тревога остаётся неквитированной и в списке. |
| `FB_Alarm_Test` | `Alarm_AckAfterReturn_GoesNormal` | Квитирование вернувшейся тревоги: RtnUnack → Normal, тревога уходит из списка. |
| `FB_Alarm_Test` | `Alarm_ActiveAckReturn_GoesNormal` | Квитированная активная тревога, условие ушло: ActiveAck → Normal (причина Cleared). |
| `FB_Alarm_Test` | `Alarm_ReactivateFromRtnUnack_GoesActiveUnack` | Условие вернулось до квитирования: RtnUnack → ActiveUnack (причина Activated). |
| `FB_Alarm_Test` | `Alarm_OnDelay_ShortCondition_NoAlarm` | Задержка появления 3 с: условие 2,9 с тревоги не даёт; устойчивое условие — ActiveUnack ровно через 3,0 с (на шаге 2,9 с ещё Normal). |
| `FB_Alarm_Test` | `Alarm_OffDelay_HoldsActive` | Задержка снятия 2 с: после ухода условия тревога остаётся ActiveUnack до 1,9 с и переходит в RtnUnack ровно в 2,0 с. |
| `FB_Alarm_Test` | `Alarm_Shelve_TimeoutUnshelvesAndReannunciates` | Shelve квитированной активной тревоги на tShelveMax = 8 ч (T#0S в запросе): Shelved, остаток 8 ч, тревога не в списке. По истечении срока при активном условии — снова ActiveUnack (повторное оповещение, причина ShelveExpired); в 7 ч 50 мин ещё Shelved. Шаг времени 10 мин. |
| `FB_Alarm_Test` | `Alarm_ShelveDurationAboveMax_ClippedToMax` | Срок shelve больше tShelveMax (2 ч при максимуме 1 ч) обрезается до максимума; меньший срок (30 мин) берётся как есть. |
| `FB_Alarm_Test` | `Alarm_ShelveMaxZero_ShelveRejected` | tShelveMax = T#0S запрещает shelve: Shelve() возвращает FALSE, тревога остаётся ActiveUnack. Выключенная тревога (приоритет None) shelve тоже не принимает. |
| `FB_Alarm_Test` | `Alarm_Unshelve_ConditionCleared_GoesNormal` | Условие ушло, пока тревога отложена: состояние Shelved, xActive = FALSE. Unshelve переводит в Normal (причина Unshelved), без повторного оповещения. |
| `FB_Alarm_Test` | `Alarm_SuppressByDesign_NoAnnunciation` | Подавление по условию: при xSuppress активная тревога — SuppressedByDesign, не в списке, не требует квитирования (Ack — FALSE), xActive показывает условие. Снятие подавления при активном условии — ActiveUnack (причина Unsuppressed): оператор видит тревогу заново. |
| `FB_Alarm_Test` | `Alarm_OutOfService_OverridesShelve` | OutOfService старше shelve: отложенная тревога уходит в OutOfService, срок shelve продолжает идти (xShelved = TRUE); Shelve в OutOfService не принимается. Выход из OutOfService до конца срока — снова Shelved с остатком 40 мин; срок, истёкший в OutOfService, — при выходе базовое состояние (условие активно — ActiveUnack). |
| `FB_Alarm_Test` | `Alarm_PriorityNone_NeverActivates` | Приоритет None выключает тревогу: при активном условии 10 вызовов — Normal, все выходы FALSE, udiSeq = 0, событий нет; Shelve и Ack — FALSE. |
| `FB_Alarm_Test` | `Alarm_AckInNormal_ReturnsFalse` | Ack без эффекта: в Normal и ActiveAck метод возвращает FALSE и переходов не даёт. |
| `FB_Alarm_Test` | `Alarm_SeqIncrementsOnEachTransition` | udiSeq (и свойство Seq) растёт на 1 на каждом переходе: Activated, Acked, Shelved, Unshelved, Cleared, Acked — 6; вызовы без перехода счётчик не меняют. |
| `FB_Alarm_Test` | `Alarm_Transition_SendsEventToSink` | Каждый переход отправляет событие в GVL_Lib.itfAlarmSink: номер, приоритет, старое и новое состояние, причина, отметка времени и значение процесса. |
| `FB_Alarm_Test` | `Alarm_AckAndClearSameCall_TwoEventsInOrder` | Квитирование и уход условия в одном вызове: два перехода по порядку шагов тела — Acked (ActiveUnack → ActiveAck), затем Cleared (ActiveAck → Normal); udiSeq + 2. |
| `FB_Alarm_Test` | `Alarm_PriorityNoneToMedium_ActiveCondition_Activates` | Включение выключенной тревоги при активном условии: приоритет None → Medium даёт Activated в том же вызове (без задержки); с tOnDelay 1 с — через 1 с после включения. |
| `FB_Alarm_Test` | `Alarm_PriorityChangeWhileActive_NoEvent` | Смена приоритета активной тревоги (Medium → High) действует сразу и события не порождает. |
| `FB_Alarm_Test` | `Alarm_PriorityOutOfEnum_TreatedAsMedium` | Приоритет вне перечисления (9 — мусор persistent-памяти) не выключает тревогу: она работает как Medium, свойство и событие показывают Medium. |
| `FB_Alarm_Test` | `Alarm_SuppressClearsUnack_ReleaseWithoutCondition_GoesNormal` | Вход в подавление сбрасывает неквитированность (ActiveUnack → SuppressedByDesign); условие ушло во время подавления — снятие подавления даёт Normal, а не RtnUnack. |
| `FB_Alarm_Test` | `Alarm_ShelveWhileSuppressed_ShelvedAfterRelease` | Shelve во время подавления принимается (не OutOfService): состояние остаётся SuppressedByDesign, xShelved = TRUE, событий нет; снятие подавления — Shelved (причина Unsuppressed). |
| `FB_Alarm_Test` | `Alarm_ShelveExpiresDuringSuppress_ReleaseGoesToBase` | Срок shelve истёк во время подавления: состояние остаётся SuppressedByDesign, xShelved снят; снятие подавления при активном условии — ActiveUnack. |
| `FB_Alarm_Test` | `Alarm_OosOffWithSuppressActive_GoesSuppressed` | Выход из OutOfService при действующем подавлении — SuppressedByDesign (причина OosOff), а не базовое состояние. |
| `FB_Alarm_Test` | `Alarm_OosEntry_ClearsUnack_ReannunciatesOnExit` | Вход в OutOfService из ActiveUnack снимает неквитированность; при выходе с активным условием тревога снова ActiveUnack, без условия — Normal. |
| `FB_Alarm_Test` | `Alarm_ShelveRemain_CountsDown` | Остаток shelve убывает со временем: shelve 1 ч, через 15 мин — 45 мин, через 59 мин 59 с — 1 с. |
| `FB_Alarm_Test` | `Alarm_TimeBackwards_ShelveRemainNotExtended` | «Время назад» во время shelve (SetNow на 2 ч раньше): остаток не растёт сверх срока (1 ч), shelve заканчивается через 1 ч от нового времени. |
| `FB_Alarm_Test` | `Alarm_Reshelve_RestartsTimer` | Повторный Shelve во время shelve отсчитывает срок заново: через 40 мин после первого — снова 1 ч. |
| `FB_Alarm_Test` | `Alarm_ActiveWhileShelved_FollowsCondition` | xActive показывает условие после задержек независимо от наложенного состояния: при shelve условие уходит и возвращается — xActive следует за ним, состояние Shelved не меняется. |
| `FB_Alarm_Test` | `Alarm_InterfaceProperties_MatchOutputs` | Свойства I_Alarm совпадают с выходами ФБ: Id, State, AlarmPriority, Active, Unacked, Seq. |
| `FB_Alarm_Test` | `Alarm_NoTimeSource_FallsBackToSystemTime` | Без источника (itfTime = 0) FB_Alarm берёт встроенный FB_SystemTime: тревога без задержки появляется сразу, отметка перехода больше 0; задержка 1 ч за время теста не истекает. |
| `FB_Alarm_Test` | `Alarm_Unshelve_ReturnsTrueOnlyWhenShelved` | Unshelve возвращает TRUE, только пока shelve действует; без shelve запрос ни на что не влияет. |
| `FB_Alarm_Test` | `Alarm_ShelveRequestThenOos_Rejected` | Запрос Shelve принят методом (тревога ещё не в OutOfService), но в ближайшем вызове тела поднялся xOutOfService: тело запрос отклоняет — shelve не начинается, после выхода из OutOfService тревога не Shelved, а ActiveUnack (условие активно). F-21 (в). |
| `FB_Alarm_Test` | `Alarm_PriorityNone_CancelsShelve` | Выключение тревоги (приоритет None) снимает действующий shelve: Normal без события, xShelved = FALSE, остаток 0; после включения при активном условии — Activated (ActiveUnack), а не Shelved. |
| `FB_Alarm_Test` | `Alarm_PriorityReenabled_OnDelayCountsFromEnabling` | Тревога с tOnDelay 2 с была активна и квитирована, на 5 с выключена при активном условии; после включения — Normal 1,9 с и ActiveUnack ровно через 2 с, а не сразу по старому состоянию задержки. F-21 (б). |
| `FB_Alarm_Test` | `Alarm_AckWithoutEffect_NotKeptForLater` | Квитирование без эффекта (в Normal и в Shelved) не запоминается: следующее появление и повторное оповещение после снятия shelve остаются ActiveUnack — «заранее квитировать» тревогу нельзя. |
| `FB_DeviceBase_Test` | `Device_RetainModeInvalid_SanitizedToManual` | Значение вне {Auto, Manual} в stRetain.eRemoteMode (7 — мусор, 0 — очищенная память) заменяется на Manual и записывается обратно; устройство работает в Manual; это не команда (uiCmdSeq = 0). |
| `FB_DeviceBase_Test` | `Device_ConflictingModeRequests_OosWins` | Одновременные запросы режима (xSetAuto, xSetManual, xSetOos и RequestMode(Auto)) — одна команда: побеждает OutOfService; затем xSetAuto вместе с RequestMode(Manual) — побеждает Manual и выводит из OutOfService. Импульсы сброшены. |
| `FB_DeviceBase_Test` | `Device_LocalOverridesRemote_ReturnsToRememberedMode` | Local старше дистанционного режима: в Local выходы сняты, запомненный режим (Auto) сохранён; после возврата переключателя устройство продолжает в Auto. Хук — на каждой смене режима. |
| `FB_DeviceBase_Test` | `Device_ModeRequestInLocal_ChangesRememberedMode` | В Local команда xSetAuto принимается и меняет только запомненный режим; после возврата переключателя устройство работает в Auto. |
| `FB_DeviceBase_Test` | `Device_RequestMode_SameEffectAsCmd` | RequestMode() — запрос, как бит stCmd: режим меняет ближайший вызов тела, результат и uiCmdSeq — как у команды; OutOfService при движущемся механизме — RejectedState и через метод, и через бит. |
| `FB_DeviceBase_Test` | `Device_RequestModeLocal_ReturnsFalse` | RequestMode(Local) и значение вне перечисления возвращают FALSE: запроса нет, команда не считается. |
| `FB_DeviceBase_Test` | `Device_AckAll_AcksEveryAlarm` | AckAll() квитирует все тревоги устройства: три активных слота → ActiveAck, wAlmUnack = 0, бит DEV_STS_ALARM_UNACK снят, результат Accepted; когда квитировать нечего, AckAll() — FALSE. Бит stCmd.xAck делает то же и сбрасывается. |
| `FB_DeviceBase_Test` | `Device_AckMask_AcksOnlySelectedSlot` | Маска wAckReq квитирует только выбранный слот (бит 1), маска обнуляется, результат Accepted. |
| `FB_DeviceBase_Test` | `Device_ShelveMask_ShelvesSlotForMax` | Маска wShelveReq откладывает слот на его tShelveMax (1 ч): Shelved, бит в wAlmShelved, в 50 мин ещё отложен, в 60 мин снова ActiveUnack. Маска обнуляется, результат Accepted. |
| `FB_DeviceBase_Test` | `Device_ShelveMaskNotAccepted_RejectedState` | Маска shelve, которую не принял ни один слот (у слота tShelveMax = 0; бит неиспользуемого слота), даёт результат RejectedState; слот остаётся ActiveUnack. |
| `FB_DeviceBase_Test` | `Device_GetAlarmOutOfRange_ReturnsNull` | GetAlarm отдаёт слот только в 0..AlarmCount - 1: при трёх слотах — слоты 0…2, номер 3 и 65535 — 0; до первого вызова слотов нет. |
| `FB_DeviceBase_Test` | `Device_CmdResult_SeqIncrementsPerCommand` | Каждая обработанная команда пишет eCmdResult и увеличивает uiCmdSeq: в одном вызове режим и пуск (в Auto отклонён) — +2, результат последней RejectedMode; Reset и маска shelve без принявших слотов — +2, результат RejectedState. |
| `FB_DeviceBase_Test` | `Device_CmdBits_ClearedAfterProcessing` | Все импульсные биты и маски stCmd (xSetAuto, xSetManual, xSetOos, xReset, xAck, wAckReq, wShelveReq, wUnshelveReq, xStart, xStop) сброшены в том же вызове. |
| `FB_DeviceBase_Test` | `Device_OosEntry_ClearsLatchedFaults` | Вход в OutOfService снимает зафиксированные отказы (хук наследника): отказ без Reset держится, после xSetOos — Fault = FALSE, статус CheckFunction, wFault = 0; после выхода в Manual — Good. |
| `FB_DeviceBase_Test` | `Device_OnModeChangedHook_CalledInDerived` | Вопрос R2 контракта: хук OnModeChanged, вызванный как THIS^.OnModeChanged из метода базы (ProcessMode, SwitchRemoteMode), выполняет переопределение наследника с параметрами смены. |
| `FB_DeviceBase_Test` | `Device_OutOfServiceRetained_StartsInOos` | stRetain.xOutOfService = TRUE после перезапуска: устройство стартует в OutOfService (хук — в первом вызове), все слоты тревог OutOfService; xSetAuto выводит из OutOfService. |
| `FB_DeviceBase_Test` | `Device_HookViaThis_DispatchesToMostDerivedOverride` | Вопрос R2 для двух уровней: у FB_TestDeviceExt хук переопределён ещё раз. THIS^.OnModeChanged из метода FB_DeviceBase вызывает реализацию самого производного ФБ; её SUPER^.OnModeChanged выполняет часть FB_TestDevice, затем своя часть: след 12 на одну смену режима, 1212 — на две. |
| `FB_DeviceBase_Test` | `Device_SuperBodyCall_RunsBaseBodyOnSameStructs` | Вопрос R3 контракта: SUPER^(stCmd := stCmd, stRetain := stRetain, stCfg := stCfg) в теле наследника выполняет тело базы один раз за вызов над теми же структурами, что переданы в вызов наследника: импульс сброшен и режим записан в структурах вызывающего, Cfg вызывающего прочитана, запись наследника в stCmd после SUPER^ видна; точка расширения до SUPER^ действует; вызов с другими структурами работает с ними. |
| `FB_DeviceBase_Test` | `Device_DerivedBodyWithoutSuper_BaseBodyNotRun` | L1 контракта во время выполнения: у наследника со своим телом без SUPER^ тело базы не выполняется само — импульс режима не обработан, FinishCycle не вызван (eDevType = None). |
| `FB_DeviceBase_Test` | `Device_InvalidCfgAtStart_CheckFunctionSafeOutput` | Корректной Cfg ещё не было (rGain = 0): бит wCfgErr, NE 107 CheckFunction, DEV_STS_CFG_ERROR, безопасный выход (FALSE и в Auto с запросом), Available = FALSE, пуск — RejectedCfg; режимы работают. |
| `FB_DeviceBase_Test` | `Device_InvalidCfgDuringOperation_KeepsLastValidCfg` | Cfg испорчена в работе (rGain = -1): бит wCfgErr и CheckFunction, но логика работает по LKG (значение 20 от rGain = 2), механизм не останавливается, Available не меняется; исправленная Cfg (rGain = 3) принимается сразу. |
| `FB_DeviceBase_Test` | `Device_AlarmPriorityInvalid_CfgErrBit` | Приоритет тревоги вне перечисления (9) не проходит CheckAlarmCfg: бит wCfgErr устройства и CheckFunction; исправленный приоритет снимает бит. |
| `FB_DeviceBase_Test` | `Device_DefaultAlarmCfgOfAllTypes_PassesCheckAlarmCfg` | Умолчания astAlarm Cfg всех семи устройств и тестового проходят CheckAlarmCfg (инвариант генератора для конфигурации тревог); массивы с границей GVL_Const.DEV_ALARMS_MAX - 1 из DUT передаются в параметр ARRAY[0..7]. Приоритет 5 и -1 — отказ, 4 (Critical) — норма. |
| `FB_DeviceBase_Test` | `Device_SummaryStatus_MaxOfDeviceModeAndCfg` | Сводный NE 107 = MAX(устройство, режим, Cfg): S и M от устройства (бит предупреждения), M при испорченной Cfg — C, F в OutOfService — F (Fault, бит отказа), Good в OutOfService — C; AI/DI-подобное устройство: Manual (подмена) — C. |
| `FB_DeviceBase_Test` | `Device_StsHeader_AllFieldsFilled` | FinishCycle заполняет все 14 полей stCommon: слово состояния (биты устройства и общие), wFault, wWarning, wCfgErr, режим, NE 107, результат и номер команды, маски тревог, наивысший приоритет неквитированных, тип устройства, резерв. |
| `FB_DeviceBase_Test` | `Device_Failure_SafeStateResetRules` | Безопасное состояние при отказе: выход снят, Fault, NE 107 Failure, бит wFault, Available = FALSE. Reset при действующей причине — RejectedFault; причина ушла — отказ держится до Reset(); после Reset() выход не включается сам (ручная защёлка снята). |
| `FB_DeviceBase_Test` | `Device_StopInAuto_SwitchesToManual` | «Стоп» оператора в Auto: SwitchRemoteMode переводит в Manual сразу (хук Auto → Manual), режим записан в retain, механизм остановлен, результат Accepted. |
| `FB_DeviceBase_Test` | `Device_SwitchRemoteModeInLocal_OnlyRemembers` | SwitchRemoteMode в Local меняет только запомненный режим, без смены режима и хука; после возврата переключателя — Manual. |
| `FB_DeviceBase_Test` | `Device_AutoToManual_BumplessKeepsOutput` | Безударный переход Auto → Manual (хук наследника): работающий механизм продолжает работать. |
| `FB_DeviceBase_Test` | `Device_OosExitWithLocalSelected_GoesLocal` | OutOfService старше Local: при переключателе «Местное» устройство остаётся OutOfService; выход из OutOfService командой xSetManual при включённом «Местном» — в Local. |
| `FB_DeviceBase_Test` | `Device_BeginCycle_DtZeroOnFirstCallThenFromTimeSource` | BeginCycle: в первом вызове ltDt = 0; затем — шаг подменного времени (250 мс); при «времени назад» — 0 (без переполнения LTIME); дальше снова шаг (100 мс). |
| `FB_DeviceBase_Test` | `Device_NoTimeSource_UsesSystemTime` | Без источника (itfTime = 0) база берёт встроенный FB_SystemTime: действующий источник задан, время вызова больше 0, шаг между двумя соседними вызовами меньше 1 с. |
| `FB_DeviceBase_Test` | `Device_ResolveTimeBeforeBeginCycle_NestedDelayDeterministic` | ResolveTime до BeginCycle: вложенный FB_Delay, вызванный раньше BeginCycle, с первого вызова получает подменное время — задержка включения 2 с отрабатывает ровно (на 1,9 с выхода нет). |
| `FB_DeviceBase_Test` | `Device_AlarmIds_BaseFromCfgPlusSlot` | Номер тревоги слота = stCfg.udiAlarmIdBase + слот: база 120, слот 5 — 125; номер и значение процесса приходят в событии. |
| `FB_DeviceBase_Test` | `Device_AlarmsInOos_AllSlotsOutOfService` | OutOfService устройства — OutOfService у всех используемых слотов (3): wAlmShelved = 2#111, неквитированных нет; после выхода активная тревога снова ActiveUnack. |
| `FB_DeviceBase_Test` | `Device_AlarmSummary_WordsAndPrioUnack` | Сводка тревог: слоты Low, High, Medium активны — ePrioUnack = High; квитирован High — Medium; слот Medium вернулся без квитирования — wAlmActive = 2#011, wAlmUnack = 2#101; подавление слота 0 — бит в wAlmShelved и снят из wAlmUnack. |
| `FB_DeviceBase_Test` | `Device_ZeroAlarmCount_NoSlotsRun` | Устройство без тревог (uiAlarmCount = 0): все условия и маски взведены — ни один слот не вызывается, сводка пустая, GetAlarm(0) = 0; маска квитирования — Accepted, маска shelve — RejectedState. Проверка цикла FOR 1 TO MIN(...) без беззнакового «0 - 1». |
| `FB_DeviceBase_Test` | `Device_ResetCmd_AcksAlarmsAndClearsLatch` | stCmd.xReset: сброс зафиксированного отказа (причина ушла) и квитирование всех тревог — одна команда (результат Accepted, uiCmdSeq + 1), бит сброшен. Метод Reset() квитирует так же. |
| `FB_DeviceBase_Test` | `Device_DevTypeSetByHeir_ReportedInStsCommon` | Тип устройства задаёт наследник в первом вызове, FinishCycle пишет его в stCommon.eDevType; до первого вызова — None. |
| `FB_DeviceBase_Test` | `Device_InputLike_ModeMemStartsAutoManualIsCheck` | AI/DI-подобное устройство (без stRetain, режима Local нет): после старта Auto из stModeMem, переключатель «Местное» не действует, xSetManual — Manual (подмена) с CheckFunction; stRetain не трогается. |
| `FB_DeviceBase_Test` | `Device_ImplementsIDevice_InterfaceAccess` | Устройства через I_Device (массив интерфейсов, как у станционной логики): RequestMode, Reset, Mode, Status, Fault, Available, AlarmCount, GetAlarm, AckAll работают одинаково для FB_TestDevice и его наследника. |
| `FB_DeviceBase_Test` | `Device_AlarmSlotArrays_MatchDevAlarmsMax` | Массивы слотов базы (afbAlarm, axAlmCond, axAlmSuppress, arAlmValue) записаны с границей 7 числом (iec_checker 0.4 не разбирает константы в границах): их длина равна GVL_Const.DEV_ALARMS_MAX. Тест читает внутренние переменные базы намеренно — это проверка раскладки. |
| `FB_DeviceBase_Test` | `Device_MethodRequests_ProcessedOnce` | Запросы Reset(), AckAll() и RequestMode() выполняет один ближайший вызов тела: uiCmdSeq растёт на 1 за запрос, тревога после выполненного запроса остаётся неквитированной, сменённый командой режим старый запрос не возвращает. |
| `FB_DeviceBase_Test` | `Device_ShelveMaskOnOosEntry_RejectedState` | Маска shelve в вызове входа в OutOfService (xSetOos и wShelveReq вместе) и в OutOfService: результат RejectedState, а не ложный Accepted (слот ещё не в OutOfService и ответил бы TRUE); после выхода из OutOfService тревога не Shelved. |
| `FB_Runtime_Test` | `Runtime_LTime_MonotonicAcrossTaskCycles` | R1 контракта по циклам задачи: LTIME() (FB_SystemTime) в 50 циклах TestTask (10 мс) строго растёт от цикла к циклу, а промежуток 49 циклов — от 49·5 мс до 49·50 мс (время идёт с реальной скоростью). Единственный тест библиотеки на несколько циклов: реального ожидания в нём нет, цикл задачи — данность. Смену системного времени ОС тест не делает (нужны права администратора). |
| `FB_Runtime_Test` | `Runtime_LTime_ResolutionAtMost1us` | R1 контракта внутри цикла: 20 000 чтений LTIME() подряд — время не убывает, меняется хотя бы раз, наименьший ненулевой шаг (разрешение источника) не больше 1 мкс. |
| `FB_Runtime_Test` | `Runtime_MethodCallWithoutThis_DispatchesVirtually` | Связывание вызовов (L6 контракта): метод базы вызывает переопределённый метод через THIS^ и без него; у экземпляра наследника оба вызова выполняют реализацию наследника, у экземпляра базы — базы. |
| `FB_Runtime_Test` | `Runtime_PartialArrayInitializer_RestGetsElementDefaults` | R9 контракта: частичный инициализатор astAlarm в объявлении переменной Cfg (как в GVL_Persist) задаёт слот 0, остальные слоты получают умолчания ST_AlarmCfg (Medium), а не умолчания DUT устройства (у ST_AnalogInputCfg: слот 1 — Low, слот 3 — High); поля Cfg вне инициализатора сохраняют умолчания DUT. |
| `FB_Runtime_Test` | `Runtime_LTimeSubtraction_WrapsWhenNegative` | L7 контракта: LTIME без знака — разность a - b при a < b не отрицательна, а переполняется по модулю 2^64 (огромное значение больше a), поэтому библиотека сравнивает отметки до вычитания. |
| `FB_Runtime_Test` | `Runtime_UnsignedCounters_WrapToZero` | Счётчики «по кругу» (uiCmdSeq, udiSeq): UINT 65535 + 1 и UDINT 4294967295 + 1 дают 0 без исключения на Control Win V3. |
| `FB_Runtime_Test` | `Runtime_LocalDeviceInstances_RunInTestMethod` | R5 контракта: шесть экземпляров устройства (FB_TestDeviceExt: 8 слотов FB_Alarm, LKG) и их структуры — локальные переменные метода теста; стека задачи хватает, все работают. |
| `FB_Runtime_Test` | `Runtime_LkgCopy300MotorCfg_Below1ms` | R13 контракта (данные для Control Win V3, не для ПЛК210): 300 копирований ST_MotorCfg (216 байт — копия LKG одного двигателя за цикл) занимают меньше 1 мс. |

## Вопросы раздела 24.2 контракта: ответы прогона

CODESYS Control Win V3 3.5.17.30, 32 бит, пользовательский процесс, 16.10.2026. Постоянные тесты —
наборы `FB_DeviceBase_Test` и `FB_Runtime_Test` (зелёные в прогоне выше). Числа (разрешение, период
цикла, размеры, цена копирования) сняты отдельным зондом в копии репозитория: тест-измеритель
передаёт значение в сообщении намеренно упавшего ассерта; в репозиторий зонд не входит. Решения и
статусы — [ASSUMPTIONS.md](ASSUMPTIONS.md), раздел «Проверено во время выполнения».

| № | Вопрос | Ответ | Тест |
|---|---|---|---|
| R1 | Монотонность и разрешение `LTIME()` | Не убывает (100 000 чтений подряд); строго растёт от цикла к циклу (200 циклов TestTask 10 мс: период 9,76…11,01 мс, среднее 10,09 мс); наименьший ненулевой шаг — 100 нс; чтение ≈ 40–60 нс (из 100 000 чтений значение менялось 34 785…54 690 раз). Смена времени ОС не проверялась — ручной шаг | `Time_SystemTime_IsMonotonic`, `Runtime_LTime_MonotonicAcrossTaskCycles`, `Runtime_LTime_ResolutionAtMost1us` |
| R2 | Виртуальный вызов хука `THIS^.OnModeChanged` из метода базы | Вызывается переопределение наследника; при двух уровнях — самое производное, его `SUPER^` — по цепочке (след 12, затем 1212) | `Device_OnModeChangedHook_CalledInDerived`, `Device_HookViaThis_DispatchesToMostDerivedOverride` |
| R3 | `SUPER^(...)` со всеми `VAR_IN_OUT` | Тело базы выполняется один раз за вызов над структурами вызывающего; запись наследника после `SUPER^` видна вызывающему; точка расширения до `SUPER^` действует | `Device_SuperBodyCall_RunsBaseBodyOnSameStructs` |
| L1 | Выполняется ли тело базы само | Нет: у наследника со своим телом без `SUPER^` тело базы не выполнено ни разу | `Device_DerivedBodyWithoutSuper_BaseBodyNotRun` |
| L6 | Вызов метода без `THIS^` | Тоже динамический: метод базы вызвал реализацию наследника | `Runtime_MethodCallWithoutThis_DispatchesVirtually` |
| L7 | `LTIME`: `a - b` при `a < b` | Переполнение по модулю 2^64, `(a - b) + b = a` | `Runtime_LTimeSubtraction_WrapsWhenNegative` |
| R5 | Стек для локальных экземпляров в методах тестов | Шесть `FB_TestDeviceExt` (по 1904 байта) со структурами в одном методе работают. `SIZEOF(FB_Alarm)` = 176, `FB_Delay` = 56, восемь слотов `afbAlarm` = 1408, `FB_TestDevice` = 1896 байт | `Runtime_LocalDeviceInstances_RunInTestMethod` |
| R9 | Частичный инициализатор `astAlarm` | Остальные слоты — умолчания `ST_AlarmCfg` (Medium), не DUT устройства; прочие поля Cfg — умолчания DUT | `Runtime_PartialArrayInitializer_RestGetsElementDefaults` |
| R10 | Сторожевой таймер тестовой задачи | Не включён; все одноцикловые тесты проходят в первом цикле | прогон `cds.py test` |
| R13 | Цена копирования LKG (Control Win, x86) | 3000 копий `ST_MotorCfg` (216 байт) — 23,2…29,9 мкс, `ST_AnalogInputCfg` (264 байта) — 32,0…62,7 мкс: 300 копий ≈ 3 мкс. 1000 вызовов тестового устройства (8 слотов) — 0,9…4,4 мс, 3000 вызовов `FB_Alarm` — 0,22…12,3 мс (разброс — нагрузка машины другими сборками); для ПЛК210 — замерить | `Runtime_LkgCopy300MotorCfg_Below1ms` |
| — | Счётчики «по кругу» | `UINT` 65535 + 1 = 0, `UDINT` 4294967295 + 1 = 0 | `Runtime_UnsignedCounters_WrapToZero` |

Проверка, что тесты этапа 2 ловят ошибки (прогон 16.10.2026 в копии репозитория): шесть мутаций —
`>=` → `>` в истечении shelve, выход из наложенного состояния в Normal вместо ActiveUnack, Auto
старше Manual в `ProcessMode`, `Available` без учёта Cfg, `Reset()` без квитирования тревог, слоты
без `xOutOfService` устройства — уронили 4, 11, 1, 1, 1 и 2 теста; после отката — все зелёные.
Мутацию `Reset()` сначала не поймал ни один тест — тест `Device_ResetCmd_AcksAlarmsAndClearsLatch`
дополнен проверкой метода `Reset()`.

## Мутационная проверка (ревью основы перед устройствами)

16.10.2026, копия репозитория, `cds.py test` на CODESYS Control Win V3 после каждой однострочной
мутации; после отката — все зелёные. Цель — убедиться, что тесты ловят правдоподобные ошибки
`FB_Alarm` и `FB_DeviceBase`, на которые будут опираться команды устройств.

| № | Мутация | До ревью (145 тестов) | После ревью (151 тест) |
|---|---|---|---|
| M1 | `FB_Alarm`: тело принимает shelve в вызове, где поднялся `xOutOfService` | **не поймана** | `Alarm_ShelveRequestThenOos_Rejected` |
| M2 | `FB_Alarm`: приоритет None не снимает shelve | **не поймана** | `Alarm_PriorityNone_CancelsShelve` |
| M3 | `FB_Alarm`: приоритет None без сброса задержки появления (`Preset`) | **не поймана** | `Alarm_PriorityReenabled_OnDelayCountsFromEnabling` |
| M4 | `FB_Alarm`: сброс запроса Ack внутрь `IF xAckReq` | эквивалентна (поведение не меняется) | — |
| M4b | `FB_Alarm`: запрос Ack без эффекта не снимается | не проверялась | `Alarm_AckWithoutEffect_NotKeptForLater`, `Device_MethodRequests_ProcessedOnce` |
| M5 | `ProcessMode`: OutOfService принимается при движущемся механизме | 1 тест | 1 тест |
| M6 | `BeginCycle`: `ltDt` без проверки «время назад» | 1 тест | 1 тест |
| M7 | `FinishCycle` не снимает запрос `Reset()` | **не поймана** | `Device_MethodRequests_ProcessedOnce` |
| M8 | `CheckAlarmCfg` не проверяет последний слот | 1 тест | 1 тест |
| M9 | бит `DEV_STS_WARNING` без учёта NE 107 S/M | 1 тест | 1 тест |
| M10 | `wAlmShelved` без слотов в OutOfService | 2 теста | 2 теста |
| M11 | Local без учёта `xLocalSupported` | 1 тест | 1 тест |
| M12 | `stCmd.xReset` не квитирует тревоги | 1 тест | 1 тест |
| M13 | `SwitchRemoteMode` без вызова хука | не проверялась | 2 теста |
| M14 | Manual даёт CheckFunction без `xManualIsCheck` | не проверялась | 3 теста |
| M15 | `GetAlarm`: `<=` вместо `<` | не проверялась | 2 теста |
| M16 | `FinishCycle` не снимает запрос `AckAll()` | не проверялась | `Device_MethodRequests_ProcessedOnce` |
| M17 | `RunAlarms` запрашивает shelve у слотов в вызове входа в OutOfService (код до исправления) | не проверялась | `Device_ShelveMaskOnOosEntry_RejectedState` |

Итог: из 17 мутаций одна эквивалентна, остальные 16 ловит хотя бы один тест. Мутация M17 — это код
до исправления `RunAlarms` (результат маски shelve при входе в OutOfService был ложным `Accepted`,
CHANGELOG, «Fixed»): новый тест на нём падает.

## Проверки без CODESYS

Итоги последнего локального прогона (Windows, 16.10.2026); в CI — те же команды.

| Проверка | Итог | Примечание |
|---|---|---|
| `ruff check`, `ruff format --check`, `mypy` | пройдено | mypy strict — 19 модулей |
| `pytest` | пройдено: 357 тестов | инструменты шаблона (в том числе интеграционные с настоящими `plc` и iec_checker) и `tools/project_checks/` (соглашения тестов, константы, маски, перечисления, DUT против контракта) |
| `tools/assemble.py --tests` (варианты `iec`, `rusty`, `iec-checker`) | пройдено | 72 объекта `src/` + 19 объектов `tests/` |
| `tools/check/st_lint.py --strict` | пройдено | 582 файла, 0 замечаний; 30 подавлений `lint:allow STL007` с причиной ([STATIC_ANALYSIS.md](STATIC_ANALYSIS.md)) |
| iec_checker 0.4 (`run_iec_checker.py`, `--tests`) | пройдено | `src/`: 72 объекта, необоснованных 0, обоснованных 280; с `tests/`: 91 объект, необоснованных 0, обоснованных 1427 — разбор в [STATIC_ANALYSIS.md](STATIC_ANALYSIS.md) |
| RuSTy 1.0.6 (`run_rusty.py`, необязательно) | 4 известные ошибки | 82 файла, 10 исключены; E033 в `FB_SystemTime` — следствие обхода для iec_checker (F-08); E036 и две E034 — сигнатуры `VAR_IN_OUT CONSTANT` контракта в `FB_Alarm` и `FB_DeviceBase` (F-24); разбор в [STATIC_ANALYSIS.md](STATIC_ANALYSIS.md) |
| `tools/reference/common.py` | пройдено | размеры Sts совпадают с таблицей 4.6 контракта |
