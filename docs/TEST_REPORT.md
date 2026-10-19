# Отчёт о тестировании

Результаты юнит-тестов CfUnit (coUnit 1.2.0.0) в CODESYS Control Win V3 и проверок без CODESYS.
Запись «проверено в CODESYS» появляется только после реального прогона. Раздел «Последний прогон
в CODESYS» обновляет `python tools/codesys/cds.py report` по итогам `cds.py test`
(`build/test-results.json`); правки внутри него вручную перезаписываются.

<!-- cds:test-report:begin (раздел обновляет `python tools/codesys/cds.py report`) -->
## Последний прогон в CODESYS

Проверено в CODESYS 3.5.17.30 / CODESYS Control Win V3 (пользовательский процесс) — 2026-10-19 11:42:52. Итог: **все тесты пройдены**.

| Параметр | Значение |
|---|---|
| Дата прогона | 2026-10-19 11:42:52 |
| Коммит | cf4400a-dirty |
| CODESYS | 3.5.17.30 (профиль `CODESYS V3.5 SP17 Patch 3`) |
| Устройство в проекте | CODESYS Control Win V3 (4096 / 0000 0001 / 3.5.17.30) |
| Рантайм | CODESYS Control Win V3 (пользовательский процесс) |
| Фреймворк тестов | coUnit (CfUnit) 1.2.0.0 |
| Сборка | ошибок 0, предупреждений 0 |
| Способ запуска | `python tools/codesys/cds.py test` |

| Набор | Тестов | Пройдено | Упало | Пропущено | Итог |
|---|---|---|---|---|---|
| `GVL_TestsAiDi.fbAnalogInputTest` | 54 | 54 | 0 | 0 | пройдено |
| `GVL_TestsAiDi.fbDigitalInputTest` | 19 | 19 | 0 | 0 | пройдено |
| `GVL_TestsAlarm.fbAlarmTest` | 40 | 40 | 0 | 0 | пройдено |
| `GVL_TestsAlarm.fbDeviceBaseTest` | 47 | 47 | 0 | 0 | пройдено |
| `GVL_TestsAlarm.fbRuntimeTest` | 8 | 8 | 0 | 0 | пройдено |
| `GVL_TestsFoundation.fbTimeTest` | 24 | 24 | 0 | 0 | пройдено |
| `GVL_TestsFoundation.fbUtilTest` | 28 | 28 | 0 | 0 | пройдено |
| `GVL_TestsFoundation.fbCommonTest` | 11 | 11 | 0 | 0 | пройдено |
| `GVL_TestsMotor.fbMotorTest` | 55 | 55 | 0 | 0 | пройдено |
| `GVL_TestsMotor.fbMotorVfdTest` | 33 | 33 | 0 | 0 | пройдено |
| `GVL_TestsPid.fbPidTest` | 54 | 54 | 0 | 0 | пройдено |
| `GVL_TestsValve.fbValveTest` | 47 | 47 | 0 | 0 | пройдено |
| `GVL_TestsValve.fbControlValveTest` | 28 | 28 | 0 | 0 | пройдено |
| `GVL_TestsIntegration.fbIntegrationTest` | 5 | 5 | 0 | 0 | пройдено |
| **Всего** | 453 | 453 | 0 | 0 | **пройдено** |

### Результаты тестов

| Набор | Тест | Итог |
|---|---|---|
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_Scale_4mA_ReturnsRangeLo` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_Scale_20mA_ReturnsRangeHi` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_Scale_12mA_ReturnsMidRange` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_Norm420_ScalesLikeMilliamps` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_Norm01_NoNe43Check` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_EngInput_PassesThrough` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_RawInput_ScalesCounts` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_RawRangeUnset_CfgErrBit8` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_WireBreak_SetsFailureAfterDelay` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_WireBreak_HoldsLastGoodValue` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_WireBreakShorterThanDelay_NoFailure` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_At3p6mA_IsFailure` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_At3p7mA_IsOutOfSpecification` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_At3p8mA_IsGood` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_At20p5mA_IsGood` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_At20p7mA_IsOutOfSpecification` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_At21mA_IsFailure` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_SignalRecovered_ClearsFailureAfterDelayAndResetsFilter` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_NaNInput_TreatedAsFailure` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_ChannelFault_SetsFailure` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_FailValueSubstitute_UsesCfgValue` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_LimitsOnFail_EvaluatesFailValue` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_Sqrt_25PctDp_Returns50PctFlow` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_LowCut_BelowCut_ReturnsZero` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_Clamp_LimitsToRange` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_Filter_OneTimeConstant_Reaches63Pct` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_Filter_IndependentOfCycleTime` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_LimitH_Hysteresis_ClearsBelowSpMinusHyst` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_LimitL_Hysteresis_ClearsAboveSpPlusHyst` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_LimitHH_OnDelay_ShortExcursionIgnored` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_LimitOffDelay_HoldsFlag` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_LimitDisabled_NeverSets` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_Failure_ForcesLimitsFalseAndSuppressesLimitAlarms` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_SuppressLimitAlarmsInput_FlagsStillSet` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_Substitution_ValueAndCheckFunction` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_Substitution_StartsFromCurrentValue` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_SubstitutionTimeout_ReturnsToAuto` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_OutOfService_HoldsValueInvalid` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_InvalidRangeAtStartup_CheckFunctionSafeValue` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_LimitOrderInvalidAtRuntime_KeepsLastValidCfg` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_DefaultCfg_FirstCallAutoTypeAndSlots` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_ResetCmd_AcceptedAndAcksAlarms` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_StartupWireBreak_InvalidUntilFirstGoodValue` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_AlarmEvents_FailureValueIsRawInput` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_CfgErrBits_MatchContractMap` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_TimeBackwards_FilterHoldsWithoutJump` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_SubstitutionNonFinite_ValueHeld` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_OosExitWithBrokenSignal_InvalidAtOnce` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_SubstitutionRenewedAfterTimeout_CountsFullPeriod` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_ShortGlitch_FilterKeptNoFalseLimit` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_SubstitutionDuringFailure_LimitsOnSubstValue` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_GuardBandLow_InvalidAfterDelay` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_GuardBandHigh_InvalidLimitsKept` | пройден |
| `GVL_TestsAiDi.fbAnalogInputTest` | `AnalogInput_SubstitutionUnlimited_NoTimeout` | пройден |
| `GVL_TestsAiDi.fbDigitalInputTest` | `DigitalInput_OnDelay_FiltersBounce` | пройден |
| `GVL_TestsAiDi.fbDigitalInputTest` | `DigitalInput_OffDelay_HoldsValue` | пройден |
| `GVL_TestsAiDi.fbDigitalInputTest` | `DigitalInput_Invert_InvertsBeforeDelay` | пройден |
| `GVL_TestsAiDi.fbDigitalInputTest` | `DigitalInput_Substitution_OverridesValueBypassesDelay` | пройден |
| `GVL_TestsAiDi.fbDigitalInputTest` | `DigitalInput_ChannelFault_ForceTrue` | пройден |
| `GVL_TestsAiDi.fbDigitalInputTest` | `DigitalInput_ChannelFault_HoldLast` | пройден |
| `GVL_TestsAiDi.fbDigitalInputTest` | `DigitalInput_AlarmOnFalse_ActivatesWhenValueFalse` | пройден |
| `GVL_TestsAiDi.fbDigitalInputTest` | `DigitalInput_OutOfService_AlarmsOutOfService` | пройден |
| `GVL_TestsAiDi.fbDigitalInputTest` | `DigitalInput_SubstitutionTimeout_ReturnsToAuto` | пройден |
| `GVL_TestsAiDi.fbDigitalInputTest` | `DigitalInput_DefaultCfg_FirstCallValueWithoutDelay` | пройден |
| `GVL_TestsAiDi.fbDigitalInputTest` | `DigitalInput_InvalidCfgAtStartup_ValueFalseCheckFunction` | пройден |
| `GVL_TestsAiDi.fbDigitalInputTest` | `DigitalInput_ResetCmd_AcceptedAndAcksAlarms` | пройден |
| `GVL_TestsAiDi.fbDigitalInputTest` | `DigitalInput_ChannelFault_ForceFalse` | пройден |
| `GVL_TestsAiDi.fbDigitalInputTest` | `DigitalInput_InvertFromFirstValidCfg_NoFalseValue` | пройден |
| `GVL_TestsAiDi.fbDigitalInputTest` | `DigitalInput_ChannelFaultDuringOnDelay_RestartsDelay` | пройден |
| `GVL_TestsAiDi.fbDigitalInputTest` | `DigitalInput_SubstitutionRenewedAfterTimeout_CountsFullPeriod` | пройден |
| `GVL_TestsAiDi.fbDigitalInputTest` | `DigitalInput_AlarmEvents_ValueIsZeroOrOne` | пройден |
| `GVL_TestsAiDi.fbDigitalInputTest` | `DigitalInput_ChannelFaultRecovered_ForcedValueReleasedThroughDelay` | пройден |
| `GVL_TestsAiDi.fbDigitalInputTest` | `DigitalInput_SubstitutionUnlimited_NoTimeout` | пройден |
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
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_PriorityNoneWhileActive_EmitsClosingEvent` | пройден |
| `GVL_TestsAlarm.fbAlarmTest` | `Alarm_NonFiniteValue_EventValueFinite` | пройден |
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
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_OosRepeatWhileMovingInOos_Accepted` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_LocalMode_Ne107CheckFunction` | пройден |
| `GVL_TestsAlarm.fbDeviceBaseTest` | `Device_ShelvedAndSuppressed_SeparateMasks` | пройден |
| `GVL_TestsAlarm.fbRuntimeTest` | `Runtime_LTime_MonotonicAcrossTaskCycles` | пройден |
| `GVL_TestsAlarm.fbRuntimeTest` | `Runtime_LTime_ResolutionAtMost1us` | пройден |
| `GVL_TestsAlarm.fbRuntimeTest` | `Runtime_MethodCallWithoutThis_DispatchesVirtually` | пройден |
| `GVL_TestsAlarm.fbRuntimeTest` | `Runtime_PartialArrayInitializer_RestGetsElementDefaults` | пройден |
| `GVL_TestsAlarm.fbRuntimeTest` | `Runtime_LTimeSubtraction_WrapsWhenNegative` | пройден |
| `GVL_TestsAlarm.fbRuntimeTest` | `Runtime_UnsignedCounters_WrapToZero` | пройден |
| `GVL_TestsAlarm.fbRuntimeTest` | `Runtime_LocalDeviceInstances_RunInTestMethod` | пройден |
| `GVL_TestsAlarm.fbRuntimeTest` | `Runtime_LkgCopy300MotorCfg_Below1ms` | пройден |
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
| `GVL_TestsFoundation.fbUtilTest` | `Util_RateLimitLr_SmallStep_NotLost` | пройден |
| `GVL_TestsFoundation.fbUtilTest` | `Util_RateLimitLr_NonFiniteTargetOrZeroDt_HoldsCurrent` | пройден |
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
| `GVL_TestsMotor.fbMotorTest` | `Motor_FirstCall_SetsTypeSlotsAndPassesDefaultCfg` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_AutoRun_StartsAndConfirms` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_ManualStart_FeedbackOk_GoesRunning` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_ManualStartInAuto_Rejected` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_StopInAuto_SwitchesToManualAndStops` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_ModeAutoToManual_Bumpless` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_NoFeedback_SetsFailToStartAfterTimeout` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_FeedbackLostWhileRunning_TripsAndLatches` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_FailToStop_RaisesHighPriorityAlarm` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_UncommandedRun_Detected` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_ExtFault_TripsAndResetRejectedWhileActive` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_Reset_CauseClearsWithinWindow_FaultCleared` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_Reset_PulsesResetOutput` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_Interlock_StopsInAutoAndManual_RecordsFirstOut` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_InterlockCleared_AutoRestarts_ManualDoesNot` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_InterlockMaskBitCleared_Ignored` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_PermitMissing_BlocksStart_DoesNotStopRunning` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_MinRunTime_DelaysAutoStop` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_MinRunTime_ManualStopImmediate` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_MinStopTime_InhibitsRestart_ReportsRemaining` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_StartsPerHour_LimitReached_InhibitsUntilWindowFrees` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_LocalMode_OutputsOffTracksFeedback` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_LocalToRemote_RestoresRememberedMode` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_OosRequestWhileRunning_Rejected` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_PowerLoss_StopsWithoutFault_StartsMinStop` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_PlcRestart_RunningFeedback_Adopted` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_RunHours_AccumulateInRetain` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_RunHours_LargeTimeStep_Bounded` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_Starts_CountedOnFeedbackEdge` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_PresetCounters_AppliedInBody` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_MaintIntervalReached_MaintenanceRequired` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_NoFeedbackConfigured_RunsOnCommand` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_InvalidCfgAtStartup_StaysStoppedCheckFunction` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_InvalidCfgAtRuntime_KeepsRunningWithLastValid` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_CurrentRunSeconds_CountsAndResetsOnStop` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_OosEntry_ClearsLatchedFaultsAndFirstOut` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_CfgChecks_SetEachCfgErrBit` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_ManualStart_RejectionReasonByPrecedence` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_StopAndStartSameCall_StopWins` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_PlcRestart_AutoWithoutDemand_Stops` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_ExtFaultInLocal_Latches` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_PowerLossInManual_LatchClearedNoRestart` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_InterlockTrip_SlotAlarmWhileInterlockActive` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_TimeBackwards_NoFaultNoCountJump` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_PowerDipWhileStopped_PauseFromPowerLoss` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_StartWhileStopping_PermitLostCancelsLatch` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_PowerDipFeedbackStays_StoppingWithoutUncommandedRun` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_FeedbackStaysAfterTrip_RaisesFailToStop` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_FeedbackDropoutWithinFilter_NotCountedAsStart` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_ReadyToStart_FalseWhileStarting` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_OosRequestWhileRunningByFeedback_Rejected` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_ResetFailToStop_ClearedOnlyAfterMotorStops` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_TimeBackwardsDuringMinStop_PauseRestarts` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_TimeBackwardsDuringMinRun_KeepsRunning` | пройден |
| `GVL_TestsMotor.fbMotorTest` | `Motor_TimeBackwardsDuringResetPulse_PulseRestarts` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_FirstCallFakeTime_CommLossDeterministic` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_ImplementsIMotorVfd_LeadPumpProperties` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_SpeedRamp_LimitsRate` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_SpeedClampedToMinMax` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_StartPresetsRampToMin` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_StopSetsRefZero` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_CommLoss_FaultAfterDelayNotLatched` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_CommLoss_SuppressesFeedbackSupervisionImmediately` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_CommRestored_RunningWithoutDemand_Stops` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_CommLossNotFault_Warning` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_VfdFault_TripsAndResetPulses` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_VfdNotReady_BlocksStart` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_SpeedDeviation_WarningAfterDelay` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_ManualSpeed_TracksAutoForBumpless` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_SpeedSpNaN_HoldsRef` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_InvalidSpeedLimits_CfgErrBit8` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_ImplementsIMotor_PolymorphicArray` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_FirstCall_SetsTypeMotorVfdAndPassesDefaultCfg` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_CfgChecks_RampCommSpeedDevBits` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_LocalMode_RefTracksActualSpeed` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_PlcRestartFbFromDi_AdoptedWithoutFault` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_PlcRestartCommLater_AdoptedWithoutFault` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_SpeedDeviationDuringRamp_Ignored` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_CommLost_StatusWordIgnored` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_CommLossInOos_NoFaultNoWarning` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_StartWithNaNTarget_RefStartsAtMin` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_CommLossWhileStopping_HoldsStopping` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_PlcRestart_RefBumpless` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_StartInCommGap_RefPresetToMin` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_CommLoss_CountersFrozen` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_PowerLossCommLoss_NoFaultNotRunning` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_SlowRamp1msCycle_NotStalled` | пройден |
| `GVL_TestsMotor.fbMotorVfdTest` | `MotorVfd_SpeedActNaN_StsFinite` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_POnly_ErrorStep_OutputEqualsKpTimesError` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_Integral_ConstantError_RampRateKpOverTi` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_DOnMeasurement_SetpointStep_NoDerivativeKick` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_DFilter_PvStep_DecaysWithTdOverN` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_DirectAction_InvertsSign` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_OutputLimits_ClampAndFlags` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_AntiWindup_LongSaturation_RecoversWithinTt` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_AntiWindup_OutActFeedback_TracksExternalLimit` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_OutputRateLimit_IntegratorBacksOff` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_ManualToAuto_Bumpless` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_Track_PresetsIntegrator_BumplessRelease` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_SpExternal_TracksIntoCmd` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_SetpointRamp_RateLimited` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_RealDt_SameResultFor10msAnd100msSteps` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_Sample_ComputesOnlyEveryTSample` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_DtGap_SkipsIntegration` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_Deadband_NoActionInsideBand` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_PvFail_HoldOutput_BumplessResume` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_PvFail_ShedToManual` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_SetAutoWithInvalidPv_Rejected` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_Fopdt_ClosedLoop_MatchesPythonReference` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_InvalidCfg_StartupManualOutput` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_RetainAuto_RestoredOnRestart` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_OutOfService_HoldsOutput` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_Fopdt_SaturatedStep_BackCalcLimitsOvershoot` | пройден |
| `GVL_TestsPid.fbPidTest` | `FopdtModel_OpenLoopStep_MatchesPythonReference` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_TimeBackwards_InitStep_NoJump` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_PvFail_SafeOut_DrivesSafeOutput` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_SpTrackPv_ManualSetpoint_FollowsPv` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_SetpointNaN_HoldsTarget_Warns` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_DefaultCfg_PassesCheck` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_FirstCall_ReportsDevTypeAndAlarmCount` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_CfgChecks_SetDocumentedBits` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_InvalidCfgAtRuntime_KeepsLastValidCfg` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_PvInvalidAlarm_ActiveOnlyInAuto` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_Reset_AcceptedWithoutLatchedFaults` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_TrackWithInvalidPv_NoFailure` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_AntiWindup_TtBelowDt_GainClampedToOne` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_Startup_OutActInitialisesOutput` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_DtGap_BoundaryAtTDtMax` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_SetpointRamp_ResumesAfterPvFailure` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_PvFail_ShedToManual_AlarmStaysActive` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_SetpointNaN_HeldTargetWithinSpLimits` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_Track_PvMoving_NoDerivativeKickAtRelease` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_AntiWindup_OutActNaN_UsesOwnOutput` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_SpTrackPv_InvalidPv_KeepsLastSetpoint` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_PvFail_ShedToManual_DeferredWhileTracking` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_Track_NaNValue_HoldsOutput` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_CfgSpLimitsEqual_FixedSetpoint` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_PvNaN_TreatedAsInvalid` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_SetAutoWithOosRequest_OneCommand` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_Manual_OutputClampedToLimits` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_SameTimestamp_NoCalc_HoldsOutput` | пройден |
| `GVL_TestsPid.fbPidTest` | `Pid_PvNaN_EventAndStsFinite` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_Open_LimitReached_GoesOpen` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_Close_LimitReached_GoesClosed` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_Open_Timeout_SetsFailToOpen` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_BothLimits_SetsFailureOutputsOff` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_PositionLost_LatchesFault` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_Reverse_PausesBeforeOppositeDirection` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_NeverBothOutputs` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_StopMotorized_GoesIntermediate` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_StopSolenoid_Rejected` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_SolenoidEtc_FaultDeenergizesCoil` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_SolenoidEto_OpenEnergizesCoil` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_Interlock_DrivesToSafePosition` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_PermitOpenMissing_OpenRejected` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_TorqueMidTravel_LatchesTorqueTrip` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_CloseOnTorque_CompletesClosing` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_NoLimitSwitches_PositionByTravelTime` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_ManualCmdInAuto_SwitchesToManual` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_PowerLoss_StopsWithoutFault` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_Local_OutputsOffTracksLimits` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_Cycles_CountedOnOpen` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_InvalidCfg_StartupOutputsOff` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_ExtFault_TripsAndResetRejectedWhileActive` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_Reset_CauseClearsWithinWindow_FaultCleared` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_OosRequestWhileMoving_Rejected` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_OosEntry_ClearsLatchedFaults` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_AutoToManual_Bumpless` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_PlcRestart_StateFromLimits` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_ActTime_AccumulatesInRetain` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_MaintCyclesReached_MaintenanceRequired` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_DefaultCfg_PassesCheck` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_CfgChecks_SetBits` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_PermitLostWhileMoving_ContinuesMotion` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_InvalidCfgAtRuntime_KeepsLastValid` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_InterlockStay_StopsMotorized` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_CloseOnTorque_ZscAloneKeepsDrivingUntilTimeout` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_ReverseAfterEndStop_WaitsReversePause` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_CloseOnTorque_TorqueBeforeZsc_LatchesTorqueTrip` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_PositionByTime_LostInLocal_AutoDrivesAgain` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_SolenoidByTime_CoilOff_NotReportedOpen` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_CloseOnTorqueNoZsc_TorqueMissing_SetsFailToClose` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_PermitCloseMissing_AutoWaitsReportsCloseBits` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_InterlockWithBothLimits_DrivesSafe` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_InterlockAfterPositionLost_DrivesSafe` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_InterlockWithExtFault_OutputsStayOff` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_OpenTorqueWhileUnseating_Ignored` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_OpenTorqueUnseatingNoZsc_TripsAfterBypass` | пройден |
| `GVL_TestsValve.fbValveTest` | `Valve_SolenoidWithZso_PowerLoss_NoPositionLostFault` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_ManualSetpoint_RateLimited` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_OutputLimits_Clamp` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_Invert_20mAAtZero` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_TightShut_BelowThresholdGivesZero` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_Deviation_WarningAfterDelay` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_DeviationDuringRamp_Ignored` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_DeviationAsFault_GoesSafePosition` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_Interlock_SafePosBypassesRamp` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_Local_TracksFeedback` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_AutoToManual_Bumpless` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_FbInvalid_MaintenanceRequiredKeepsControl` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_PositionerFault_SafePosAction` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_InvalidCfg_StartupSafePosition` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_OutOfService_HoldsOutput` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_AutoSpNaN_HoldsWithWarning` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_PositionerFault_HoldAction` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_OosEntry_ClearsLatchedDeviation` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_DefaultCfg_PassesCheck` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_CfgChecks_SetBits` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_InvalidCfgAtRuntime_KeepsLastValid` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_Ramp_IndependentOfCycleTime` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_LocalFeedbackOutOfRange_OutputClamped` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_DeviationFaultReset_StuckValveRetripsAfterTDev` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_InterlockInManual_StaysAtSafePosition` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_TightShutHysteresis_NoChatter` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_SlowRamp1msCycle_NotStalled` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_FbNaN_EventAndStsFinite` | пройден |
| `GVL_TestsValve.fbControlValveTest` | `ControlValve_InterlockFirstOut_KeptUntilResetOrOos` | пройден |
| `GVL_TestsIntegration.fbIntegrationTest` | `Device_DefaultCfg_PassesCheck` | пройден |
| `GVL_TestsIntegration.fbIntegrationTest` | `Device_DevType_ReportedInStsCommon` | пройден |
| `GVL_TestsIntegration.fbIntegrationTest` | `Device_AllTypes_AlarmCountThroughIDevice` | пройден |
| `GVL_TestsIntegration.fbIntegrationTest` | `LevelLoop_AiPidVfd_TracksBumplessNoWindup` | пройден |
| `GVL_TestsIntegration.fbIntegrationTest` | `LevelLoop_GuardBandCurrent_PidHoldsOutput` | пройден |

### Упавшие тесты

_Нет._

Машиночитаемые результаты: `build/test-results.json`, `build/junit.xml` (не в git).
<!-- cds:test-report:end -->

## Что проверяют тесты

Наборы регистрируются экземплярами в GVL с `linkalways` ([TESTING.md](TESTING.md)): основа —
`GVL_TestsFoundation` (время, утилиты, общие типы) и `GVL_TestsAlarm` (`FB_Alarm`, `FB_DeviceBase`,
зонды времени выполнения), семейства — `GVL_TestsAiDi`, `GVL_TestsMotor`, `GVL_TestsValve`,
`GVL_TestsPid`, межсемейные тесты — `GVL_TestsIntegration`. Тесты из списка 23.2 контракта и тесты сверх
него (граничные значения, отказы, найденные мутационной проверкой) — в одной таблице, порядок — как в
теле набора. Описание строки — комментарий объявления метода-теста (таблица собрана из исходников при
выпуске 1.0.0, 453 теста).

| Набор | Тест | Что проверяет |
|---|---|---|
| `FB_Time_Test` | `Time_LTimeToSec_OneSecond_ReturnsOne` | F_LTimeToSec: LTIME#1S (1e9 нс) — ровно 1 с, LTIME#1MS — 0,001 с. Источник: tools/reference/common.py, сценарий ltime_to_sec. |
| `FB_Time_Test` | `Time_LTimeToSec_NanosecondAndDays_Exact` | F_LTimeToSec: 1 нс — 1e-9 с (разрешение LTIME); 100 сут — 8 640 000 с: 8,64e15 нс меньше 2^53, LREAL представляет их точно. Источник: tools/reference/common.py, сценарий ltime_to_sec. |
| `FB_Time_Test` | `Time_TimeToSec_1500ms_Returns1p5` | F_TimeToSec: T#1500MS — 1,5 с. |
| `FB_Time_Test` | `Time_TimeToSec_MaxTime_NoOverflow` | F_TimeToSec: наибольшее TIME (2^32 - 1 мс) переводится без переполнения — 4 294 967,295 с. Источник: tools/reference/common.py, сценарий ltime_to_sec. |
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
| `FB_Util_Test` | `Util_RateLimit_UpAndDownRatesSeparate` | F_RateLimit: рост ограничен 10 ед./с, спад — 2 ед./с, каждый своей скоростью. Источник: tools/reference/common.py, сценарий rate_limit. |
| `FB_Util_Test` | `Util_RateLimit_ZeroRate_Jumps` | F_RateLimit: скорость 0 — без ограничения (сразу к цели); ограничение другого направления действует. Источник: tools/reference/common.py, сценарий rate_limit. |
| `FB_Util_Test` | `Util_RateLimit_ZeroDt_NoChange` | F_RateLimit: шаг времени 0 или отрицательный — значение не меняется. |
| `FB_Util_Test` | `Util_RateLimit_NonFiniteTarget_HoldsCurrent` | F_RateLimit: цель NaN, +Inf или больше REAL_SANE_MAX (мусор из Modbus/ПИД) — значение удерживается. |
| `FB_Util_Test` | `Util_RateLimit_NonFiniteCurrent_JumpsToTarget` | F_RateLimit: текущее значение NaN (мусор прошлого шага) заменяется конечной целью — ограничитель не застревает на NaN. |
| `FB_Util_Test` | `Util_RateLimit_SmallStep_ReachesTargetExactly` | F_RateLimit: если до цели меньше шага, результат — ровно цель, без перелёта. Источник: tools/reference/common.py, сценарий rate_limit. |
| `FB_Util_Test` | `Util_StartsWindow_CountsOnlyLastHour` | FB_StartsWindow: пуски в 1:00, 1:20, 1:40 — в окне последнего часа их 3, 2, 1, 0 по мере старения. Источник: tools/reference/common.py, сценарий starts_window. |
| `FB_Util_Test` | `Util_StartsWindow_TimeToFree_ReportsRemaining` | TimeToFree: пуски 1:00, 1:10, 1:20; в 1:30 при лимите 3 — 30 мин, при лимите 2 — 40 мин, при лимите 4 и без лимита (0) — 0; в 2:00 при лимите 3 — 0. Источник: tools/reference/common.py, сценарий starts_window. |
| `FB_Util_Test` | `Util_StartsWindow_ExactlyOneHourOld_NotCounted` | Граница окна: отметка ровно часовой давности уже не считается (ltNow - t < STARTS_WINDOW). |
| `FB_Util_Test` | `Util_StartsWindow_RingFull_OverwritesOldest` | Кольцо на STARTS_WINDOW_MAX = 30: 31 пуск с шагом 1 мин (1:00…1:30) — остаются 30 последних; в 1:30 при лимите 30 окно освободится через 31 мин (самый старый оставшийся — 1:01). Источник: tools/reference/common.py, сценарий starts_window. |
| `FB_Util_Test` | `Util_StartsWindow_RingCapacity_MatchesConst` | Ёмкость кольца altStart равна GVL_Const.STARTS_WINDOW_MAX: индексы кольца считаются по константе, тест ловит расхождение, если границу массива запишут числом. Тест обращается к внутренней переменной ФБ намеренно: это проверка раскладки, а не API. |
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
| `FB_Util_Test` | `Util_RateLimitLr_SmallStep_NotLost` | F_RateLimitLr: состояние в LREAL — 1000 шагов по 1 мс со скоростью 0,003 ед./с от 70,0 дают 70,003 (в REAL приращение 3·10⁻⁶ меньше половины шага REAL рядом с 70 и терялось бы); спад — так же; цель достигается точно. |
| `FB_Util_Test` | `Util_RateLimitLr_NonFiniteTargetOrZeroDt_HoldsCurrent` | F_RateLimitLr: цель NaN (мусор Modbus) или шаг времени 0 — значение не меняется; скорость 0 — сразу к цели; текущее значение NaN — сразу к цели (как F_RateLimit, F-11). |
| `FB_Common_Test` | `Common_SizeOfSts_MatchesRegisterMap` | SIZEOF семи структур состояния — таблица 4.6 контракта (карта регистров Modbus = порядок полей, скрытого выравнивания нет). Источник: таблица 4.6 и tools/reference/common.py, сценарий sts_sizes. |
| `FB_Common_Test` | `Common_SizeOfDeviceRetain_Is36` | SIZEOF(ST_DeviceRetain) = 36 на Control Win V3 32 бит (зонд P17 контракта). |
| `FB_Common_Test` | `Common_SizeOfAlarmCfg_Is16` | SIZEOF(ST_AlarmCfg) = 16 (зонд Q14 контракта) и SIZEOF(ST_AiLimitCfg) = 20: элементы массивов astAlarm и astLimit в persistent-данных. Источник: tools/reference/common.py, сценарий cfg_sizes. |
| `FB_Common_Test` | `Common_SizeOfCfg_MatchesReference` | SIZEOF структур Cfg — по расчёту раскладки (Control Win V3 32 бит). Cfg лежат в Persistent Variables приложения: изменение типа переинициализирует уставки (A-13), тест ловит его. Источник: tools/reference/common.py, сценарий cfg_sizes. |
| `FB_Common_Test` | `Common_SizeOfCmd_MatchesReference` | SIZEOF структур команд HMI/SCADA (GVL_Hmi приложения). Источник: tools/reference/common.py, сценарий cmd_sizes. |
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
| `FB_Alarm_Test` | `Alarm_ShelveRequestThenOos_Rejected` | Запрос Shelve принят методом (тревога ещё не в OutOfService), но в ближайшем вызове тела поднялся xOutOfService: тело запрос отклоняет — shelve не начинается, после выхода из OutOfService тревога не Shelved, а базовое состояние (условие активно — ActiveUnack). F-21 (в), контракт 10.1 |
| `FB_Alarm_Test` | `Alarm_PriorityNone_CancelsShelve` | Выключение тревоги (приоритет None) снимает действующий shelve: Normal с событием Disabled (ALM-1), xShelved = FALSE, остаток 0. После включения при активном условии — Activated (ActiveUnack), а не Shelved: shelve выключенной тревоги не «доживает» до её включения. Контракт 10.2, F-21 (б) |
| `FB_Alarm_Test` | `Alarm_PriorityReenabled_OnDelayCountsFromEnabling` | Задержка появления после выключения и включения тревоги отсчитывается заново, от включения: тревога с tOnDelay 2 с была активна и квитирована, на 5 с выключена (приоритет None) при активном условии; после включения — Normal 1,9 с и ActiveUnack ровно через 2 с, а не сразу по старому состоянию задержки. F-21 (б) |
| `FB_Alarm_Test` | `Alarm_AckWithoutEffect_NotKeptForLater` | Квитирование без эффекта не запоминается: Ack в Normal и в Shelved выполняется ближайшим вызовом тела и снимается. Следующее появление тревоги (в том числе повторное оповещение после снятия shelve) остаётся ActiveUnack и в следующих вызовах — «заранее квитировать» тревогу нельзя (ISA-18.2: оператор должен увидеть каждое новое появление) |
| `FB_Alarm_Test` | `Alarm_PriorityNoneWhileActive_EmitsClosingEvent` | Тревога ActiveUnack, приоритет переключили на None (ALM-1): переход в Normal с событием Disabled (старое состояние ActiveUnack, новое Normal, udiSeq + 1) — журнал и сводка по событиям закрывают тревогу. Дальше выключенная тревога событий не даёт. |
| `FB_Alarm_Test` | `Alarm_NonFiniteValue_EventValueFinite` | Значение процесса NaN в момент перехода (PV из Modbus): rValue события конечно — 0.0 (R6: приёмник журнала и SQL не получают NaN); конечное значение передаётся как есть. |
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
| `FB_DeviceBase_Test` | `Device_DefaultAlarmCfgOfAllTypes_PassesCheckAlarmCfg` | Умолчания astAlarm Cfg всех семи устройств и тестового проходят CheckAlarmCfg (инвариант генератора для конфигурации тревог); массивы astAlarm из DUT передаются в параметр ARRAY[0..GVL_Const.DEV_ALARMS_MAX - 1]. Приоритет 5 и -1 — отказ, 4 (Critical) — норма. |
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
| `FB_DeviceBase_Test` | `Device_AlarmsInOos_AllSlotsOutOfService` | OutOfService устройства — OutOfService у всех используемых слотов (3); в wAlmShelved и wAlmSuppressed их нет (ALM-2: вывод из работы виден по eMode), неквитированных нет; после выхода активная тревога снова ActiveUnack. |
| `FB_DeviceBase_Test` | `Device_AlarmSummary_WordsAndPrioUnack` | Сводка тревог: слоты Low, High, Medium активны — ePrioUnack = High; квитирован High — Medium; слот Medium вернулся без квитирования — wAlmActive = 2#011, wAlmUnack = 2#101; подавление слота 0 — бит в wAlmSuppressed (не в wAlmShelved, ALM-2) и снят из wAlmUnack. |
| `FB_DeviceBase_Test` | `Device_ZeroAlarmCount_NoSlotsRun` | Устройство без тревог (uiAlarmCount = 0): все условия и маски взведены — ни один слот не вызывается, сводка пустая, GetAlarm(0) = 0; маска квитирования — Accepted, маска shelve — RejectedState. Проверка цикла FOR 1 TO MIN(...) без беззнакового «0 - 1». |
| `FB_DeviceBase_Test` | `Device_ResetCmd_AcksAlarmsAndClearsLatch` | stCmd.xReset: сброс зафиксированного отказа (причина ушла) и квитирование всех тревог — одна команда (результат Accepted, uiCmdSeq + 1), бит сброшен. Метод Reset() квитирует так же. |
| `FB_DeviceBase_Test` | `Device_DevTypeSetByHeir_ReportedInStsCommon` | Тип устройства задаёт наследник в первом вызове, FinishCycle пишет его в stCommon.eDevType; до первого вызова — None. |
| `FB_DeviceBase_Test` | `Device_InputLike_ModeMemStartsAutoManualIsCheck` | AI/DI-подобное устройство (без stRetain, режима Local нет): после старта Auto из stModeMem, переключатель «Местное» не действует, xSetManual — Manual (подмена) с CheckFunction; stRetain не трогается. |
| `FB_DeviceBase_Test` | `Device_ImplementsIDevice_InterfaceAccess` | Устройства через I_Device (массив интерфейсов, как у станционной логики): RequestMode, Reset, Mode, Status, Fault, Available, AlarmCount, GetAlarm, AckAll работают одинаково для FB_TestDevice и его наследника. |
| `FB_DeviceBase_Test` | `Device_AlarmSlotArrays_MatchDevAlarmsMax` | Длина массивов слотов базы (afbAlarm, axAlmCond, axAlmSuppress, arAlmValue) равна GVL_Const.DEV_ALARMS_MAX: циклы базы идут по константе, тест ловит расхождение, если границу запишут числом. Тест читает внутренние переменные базы намеренно — это проверка раскладки. |
| `FB_DeviceBase_Test` | `Device_MethodRequests_ProcessedOnce` | Запросы методов Reset(), AckAll() и RequestMode() выполняет один ближайший вызов тела, затем они снимаются (FinishCycle): uiCmdSeq растёт на 1 за запрос, а не в каждом цикле; тревога, появившаяся после выполненного запроса, остаётся неквитированной; режим, сменённый командой после RequestMode(), повторный запрос не возвращает. Иначе Reset() станции квитировал бы все будущие тревоги и бесконечно повторял бы сброс |
| `FB_DeviceBase_Test` | `Device_ShelveMaskOnOosEntry_RejectedState` | Маска shelve в вызове, в котором устройство уходит в OutOfService (xSetOos и wShelveReq вместе), и в OutOfService: shelve не принимается (10.1) — результат маски RejectedState, а не ложный Accepted (слот в этот момент ещё не в OutOfService и на запрос ответил бы TRUE); после выхода из OutOfService тревога не Shelved |
| `FB_DeviceBase_Test` | `Device_OosRepeatWhileMovingInOos_Accepted` | Повтор запроса OutOfService, когда устройство уже выведено из работы, а механизм движется (двигают по месту, xMoving): принимается (F-22 (в)) — битом команды и RequestMode: Accepted, uiCmdSeq + 1, режим OutOfService. |
| `FB_DeviceBase_Test` | `Device_LocalMode_Ne107CheckFunction` | Local (переключатель на месте, тип с Local): ПЛК механизмом не управляет — сводный NE 107 CheckFunction («местное управление», категория C NE 107, статус PA 0x3C), Available = FALSE; отказ в Local старше — Failure. Возврат в дистанционный режим — Good. |
| `FB_DeviceBase_Test` | `Device_ShelvedAndSuppressed_SeparateMasks` | Отложенная оператором тревога и подавленная логикой — разные биты (ISA-18.2, ALM-2): слот 0 отложен (wShelveReq) — бит только в wAlmShelved; слот 1 подавлен (axSuppressIn) — бит только в wAlmSuppressed. Вывод устройства из работы — ни shelve, ни подавление: оба слова 0 (OutOfService виден по eMode). |
| `FB_Runtime_Test` | `Runtime_LTime_MonotonicAcrossTaskCycles` | R1 контракта по циклам задачи: LTIME() (FB_SystemTime) в 50 циклах TestTask (10 мс) строго растёт от цикла к циклу, а промежуток 49 циклов — от 49·5 мс до 49·50 мс (время идёт с реальной скоростью). Единственный тест библиотеки на несколько циклов: реального ожидания в нём нет, цикл задачи — данность. Смену системного времени ОС тест не делает (нужны права администратора). |
| `FB_Runtime_Test` | `Runtime_LTime_ResolutionAtMost1us` | R1 контракта внутри цикла: 20 000 чтений LTIME() подряд — время не убывает, меняется хотя бы раз, наименьший ненулевой шаг (разрешение источника) не больше 1 мкс. |
| `FB_Runtime_Test` | `Runtime_MethodCallWithoutThis_DispatchesVirtually` | Связывание вызовов (L6 контракта): метод базы вызывает переопределённый метод через THIS^ и без него; у экземпляра наследника оба вызова выполняют реализацию наследника, у экземпляра базы — базы. |
| `FB_Runtime_Test` | `Runtime_PartialArrayInitializer_RestGetsElementDefaults` | R9 контракта: частичный инициализатор astAlarm в объявлении переменной Cfg (как в GVL_Persist) задаёт слот 0, остальные слоты получают умолчания ST_AlarmCfg (Medium), а не умолчания DUT устройства (у ST_AnalogInputCfg: слот 1 — Low, слот 3 — High); поля Cfg вне инициализатора сохраняют умолчания DUT. |
| `FB_Runtime_Test` | `Runtime_LTimeSubtraction_WrapsWhenNegative` | L7 контракта: LTIME без знака — разность a - b при a < b не отрицательна, а переполняется по модулю 2^64 (огромное значение больше a), поэтому библиотека сравнивает отметки до вычитания. |
| `FB_Runtime_Test` | `Runtime_UnsignedCounters_WrapToZero` | Счётчики «по кругу» (uiCmdSeq, udiSeq): UINT 65535 + 1 и UDINT 4294967295 + 1 дают 0 без исключения на Control Win V3. |
| `FB_Runtime_Test` | `Runtime_LocalDeviceInstances_RunInTestMethod` | R5 контракта: шесть экземпляров устройства (FB_TestDeviceExt: 8 слотов FB_Alarm, LKG) и их структуры — локальные переменные метода теста; стека задачи хватает, все работают. |
| `FB_Runtime_Test` | `Runtime_LkgCopy300MotorCfg_Below1ms` | R13 контракта (данные для Control Win V3, не для ПЛК210): 300 копирований ST_MotorCfg (216 байт — копия LKG одного двигателя за цикл) занимают меньше 1 мс. |
| `FB_AnalogInput_Test` | `AnalogInput_Scale_4mA_ReturnsRangeLo` | Шкала 2..12: 4 мА — начало шкалы 2,0 (0 %), сигнал в норме, значение пригодно, NE 107 Good. источник: tools/reference/ai_reference.py, сценарий scale «4 мА, шкала 2..12». |
| `FB_AnalogInput_Test` | `AnalogInput_Scale_20mA_ReturnsRangeHi` | Шкала 2..12: 20 мА — конец шкалы 12,0 (100 %). источник: tools/reference/ai_reference.py, сценарий scale «20 мА, шкала 2..12». |
| `FB_AnalogInput_Test` | `AnalogInput_Scale_12mA_ReturnsMidRange` | Шкала 2..12: 12 мА — середина шкалы 7,0 (50 %); сырое значение в stSts.rIn. источник: tools/reference/ai_reference.py, сценарий scale «12 мА, шкала 2..12». |
| `FB_AnalogInput_Test` | `AnalogInput_Norm420_ScalesLikeMilliamps` | Norm420: rIn 0..1 = 4..20 мА. 0,5 даёт то же, что 12 мА на соседнем экземпляре (7,0 на шкале 2..12); NE 43 — по пересчёту I = 4 + 16·rIn: -0,05 (3,2 мА) — FailLow, 1,0625 (21 мА) — FailHigh. источник: tools/reference/ai_reference.py, сценарий scale «Norm420 0,5, шкала 2..12». |
| `FB_AnalogInput_Test` | `AnalogInput_Norm01_NoNe43Check` | Norm01 (0–10 В и т. п.): NE 43 не применяется — rIn = -0,03 даёт экстраполяцию -3 % без отказа и выхода за диапазон даже при tFailDelay = 0; 1,5 — 150. источник: tools/reference/ai_reference.py, сценарии scale «Norm01 -0,03» и «Norm01 0,7». |
| `FB_AnalogInput_Test` | `AnalogInput_EngInput_PassesThrough` | Eng (значение уже в инж. ед., Modbus REAL): шкала -50..150, 123,4 — 123,4 (86,7 %); NE 43 не применяется (0 — норма). источник: tools/reference/ai_reference.py, сценарий scale «Eng 123,4, шкала -50..150». |
| `FB_AnalogInput_Test` | `AnalogInput_RawInput_ScalesCounts` | Raw (целое из Modbus): отсчёты 2000..10000 — шкала 0..16 бар; 6000 — 8,0; 1000 — экстраполяция -2,0; NE 43 не применяется, Cfg корректна. источник: tools/reference/ai_reference.py, сценарии scale «Raw 6000» и «Raw 1000». |
| `FB_AnalogInput_Test` | `AnalogInput_RawRangeUnset_CfgErrBit8` | Raw с не заданной шкалой отсчётов (умолчания 0/0): бит 8 wCfgErr (AI_CFG_RAW_RANGE) и только он, CheckFunction, безопасное значение 0.0, xValid = FALSE, Available = FALSE. После задания шкалы отсчётов Cfg принимается: 5000 из 0..10000 — 50 % шкалы 0..100. |
| `FB_AnalogInput_Test` | `AnalogInput_WireBreak_SetsFailureAfterDelay` | Обрыв (0 мА) при tFailDelay = 2 с: до 1,9 с отказа нет, значение удерживается (2,5 м), ложного LL нет, бит AI_STS_FAIL_PENDING; ровно через 2,0 с — Failure, xValid = FALSE, бит AI_FLT_FAIL_LOW (AI_STS_FAIL_PENDING снят), тревога Failure, LL снят принудительно. Образец — раздел 23.3 контракта. |
| `FB_AnalogInput_Test` | `AnalogInput_WireBreak_HoldsLastGoodValue` | HoldLast (по умолчанию): при обрыве значение 3,75 (16 мА на шкале 0..5) держится и до подтверждения, и после него (xValid = FALSE); проценты и слежение в stCmd — то же значение. |
| `FB_AnalogInput_Test` | `AnalogInput_WireBreakShorterThanDelay_NoFailure` | Обрыв на 1,5 с при tFailDelay = 2 с: отказа и тревоги нет ни в одном вызове, значение держится, после возврата сигнала — сразу новое измеренное значение; ещё 3 с — без отказа. |
| `FB_AnalogInput_Test` | `AnalogInput_At3p6mA_IsFailure` | Граница NE 43 3,6 мА включена в отказ (A-02, сверить с NAMUR NE 43): FailLow, Failure (tFailDelay = 0), бит AI_FLT_FAIL_LOW; чуть выше, 3,61 мА — уже UnderRange. |
| `FB_AnalogInput_Test` | `AnalogInput_At3p7mA_IsOutOfSpecification` | 3,7 мА (между 3,6 и 3,8): UnderRange, OutOfSpecification, значение — насыщение NE 43 3,8 мА (-1,25 %), без экстраполяции; выход за диапазон подтверждён (tFailDelay = 0) — xValid = FALSE (AI-13), бит AI_WRN_UNDER_RANGE, тревога OutOfRange. источник: tools/reference/ai_reference.py, сценарий scale «3,7 мА, шкала 0..100 (насыщение NE 43)». |
| `FB_AnalogInput_Test` | `AnalogInput_At3p8mA_IsGood` | Граница 3,8 мА — уже норма (NE43_MEAS_LOW_MA: «I < — вне диапазона»): Good, значение -1,25 %. |
| `FB_AnalogInput_Test` | `AnalogInput_At20p5mA_IsGood` | Граница 20,5 мА — ещё норма (NE43_MEAS_HIGH_MA: «I > — вне диапазона»): Good, значение 103,125 %. |
| `FB_AnalogInput_Test` | `AnalogInput_At20p7mA_IsOutOfSpecification` | 20,7 мА (между 20,5 и 21,0): OverRange, OutOfSpecification, значение — насыщение NE 43 20,5 мА (103,125 %), без экстраполяции; выход за диапазон подтверждён — xValid = FALSE (AI-13), бит AI_WRN_OVER_RANGE. источник: tools/reference/ai_reference.py, сценарий scale «20,7 мА, шкала 0..100 (насыщение NE 43)». |
| `FB_AnalogInput_Test` | `AnalogInput_At21mA_IsFailure` | Граница NE 43 21,0 мА включена в отказ (A-02): FailHigh, Failure, бит AI_FLT_FAIL_HIGH; 20,99 мА — ещё OverRange. |
| `FB_AnalogInput_Test` | `AnalogInput_SignalRecovered_ClearsFailureAfterDelayAndResetsFilter` | Фильтр 10 с, tFailDelay 2 с: отказ подтверждён; сигнал вернулся (75 %) — отказ держится 1,9 с (значение удерживается 50), снимается ровно через 2,0 с, и значение сразу 75: фильтр начался с текущего значения. Без сброса фильтра было бы 54,53 (источник: tools/reference/ai_reference.py, сценарий filter «возврат сигнала 50 -> 75 без сброса фильтра»). |
| `FB_AnalogInput_Test` | `AnalogInput_NaNInput_TreatedAsFailure` | NaN на входе (например, ошибка обмена REAL): NotFinite, значение удерживается до подтверждения (tFailDelay 1 с), затем Failure и бит AI_FLT_NOT_FINITE; +Inf и 1E31 (больше REAL_SANE_MAX) — тоже NotFinite. После возврата значение конечно и равно новому: NaN не попал в фильтр. |
| `FB_AnalogInput_Test` | `AnalogInput_ChannelFault_SetsFailure` | xChannelFault (диагностика модуля, ошибка обмена) при нормальном токе: ChannelFault, значение удерживается, через tFailDelay 2 с — Failure и бит AI_FLT_CHANNEL; после снятия — возврат через те же 2 с. |
| `FB_AnalogInput_Test` | `AnalogInput_FailValueSubstitute_UsesCfgValue` | eFailValue = Substitute: до подтверждения отказа держится последнее хорошее значение (25), после — rFailValue_eu = 99, xValid = FALSE. |
| `FB_AnalogInput_Test` | `AnalogInput_LimitsOnFail_EvaluatesFailValue` | xLimitsOnFail = TRUE и Substitute 95: после подтверждения отказа уставки считаются по значению отказа — HH (90) взводится, тревога HH не подавлена (ActiveUnack). Так проектировщик задаёт безопасную реакцию на отказ датчика. |
| `FB_AnalogInput_Test` | `AnalogInput_Sqrt_25PctDp_Returns50PctFlow` | Корень (расход по перепаду): 8 мА = 25 % перепада — 50 % расхода; 4 мА — 0, 20 мА — 100. источник: tools/reference/ai_reference.py, сценарий scale «корень: 8 мА (25 % перепада)». |
| `FB_AnalogInput_Test` | `AnalogInput_LowCut_BelowCut_ReturnsZero` | Отсечка 5 % после корня: 0,2 % перепада (корень 4,47 %) — 0 и бит AI_STS_LOW_CUT; 1 % перепада (корень 10 %) — 9,999995 без бита. Без корня отсечка тоже действует: 2,5 % при отсечке 3 % — 0. Граница: отсечка — при x·100 < rLowCut_pct, ровно 12,5 % при отсечке 12,5 % не срезается. источник: tools/reference/ai_reference.py, сценарии scale «корень: 4,032 мА», «корень: 4,16 мА», «без корня: 4,4 мА», «без корня: 6 мА (12,5 %), отсечка 12,5 %». |
| `FB_AnalogInput_Test` | `AnalogInput_Clamp_LimitsToRange` | По умолчанию значение экстраполируется (20,4 мА — 102,5 %); с xClamp — ограничено шкалой (100 и 0) с предупреждением AI_WRN_CLAMPED. источник: tools/reference/ai_reference.py, сценарии scale «20,4 мА без ограничения», «… с ограничением», «3,9 мА с ограничением». |
| `FB_AnalogInput_Test` | `AnalogInput_Filter_OneTimeConstant_Reaches63Pct` | Фильтр T = 10 с, ступень 0 -> 100 % с шагом 100 мс: в 9,9 с — 62,842, ровно через T — 63,212 (1 - e^-1). источник: tools/reference/ai_reference.py, сценарии filter «… 99 шагов по 0,1 с» и «… 100 шагов по 0,1 с». |
| `FB_AnalogInput_Test` | `AnalogInput_Filter_IndependentOfCycleTime` | Один и тот же интервал 5 с при T = 10 с: шаг 10 мс (500 вызовов), 250 мс (20 вызовов) и неравномерный 50/150/300 мс дают одно значение 39,347 (1 - e^-0,5): фильтр считает по реальному шагу времени. Неявный Эйлер dt/(T + dt) при 250 мс дал бы 38,97. источник: tools/reference/ai_reference.py, сценарии filter «5 с шагом 10 мс», «… 250 мс», «… неравномерно». |
| `FB_AnalogInput_Test` | `AnalogInput_LimitH_Hysteresis_ClearsBelowSpMinusHyst` | Уставка H 80, гистерезис 2 (вход Eng 0..100): 79,9 — нет; 80,0 — да (граница включена); 78,0 — ещё да; 77,9 — снят. Тревога H — ActiveUnack, бит AI_STS_H. |
| `FB_AnalogInput_Test` | `AnalogInput_LimitL_Hysteresis_ClearsAboveSpPlusHyst` | Уставка L 20, гистерезис 2: 20,1 — нет; 20,0 — да; 22,0 — ещё да; 22,1 — снят. |
| `FB_AnalogInput_Test` | `AnalogInput_LimitHH_OnDelay_ShortExcursionIgnored` | HH 90 с задержкой срабатывания 3 с: выброс 2,9 с флаг не взводит; устойчивое превышение — флаг ровно через 3,0 с. |
| `FB_AnalogInput_Test` | `AnalogInput_LimitOffDelay_HoldsFlag` | H 80 с задержкой снятия 2 с: значение ушло ниже уставки — флаг держится 1,9 с, снимается в 2,0 с. |
| `FB_AnalogInput_Test` | `AnalogInput_LimitDisabled_NeverSets` | Выключенные уставки (HH 10 и LL 90 при значении 50) флаги не взводят ни в одном вызове и не проверяются CheckConfig (порядок и шкала — только у включённых). |
| `FB_AnalogInput_Test` | `AnalogInput_Failure_ForcesLimitsFalseAndSuppressesLimitAlarms` | H 4,0 активна (4,25 м); обрыв: пока отказ не подтверждён, H держится по удержанному значению, ложного LL (0,5) нет; после подтверждения флаги сняты, тревога H — SuppressedByDesign, тревога Failure — ActiveUnack. |
| `FB_AnalogInput_Test` | `AnalogInput_SuppressLimitAlarmsInput_FlagsStillSet` | xSuppressLimitAlarms: флаг H считается (логика станции его видит), а тревога H — SuppressedByDesign, не неквитирована; вход снят — тревога ActiveUnack. |
| `FB_AnalogInput_Test` | `AnalogInput_Substitution_ValueAndCheckFunction` | Подмена (Manual): значение — stCmd.rSubstValue_eu без фильтра, пригодно, NE 107 CheckFunction, бит DEV_STS_MODE_MANUAL; уставки считаются по подменённому значению (H 80 при 85). «Измерение» — снова 50. |
| `FB_AnalogInput_Test` | `AnalogInput_Substitution_StartsFromCurrentValue` | Слежение: в Auto ФБ пишет rValue_eu в stCmd.rSubstValue_eu, поэтому подмена начинается с текущего значения 7,0 — даже если в том же вызове вход изменился (20 мА). |
| `FB_AnalogInput_Test` | `AnalogInput_SubstitutionTimeout_ReturnsToAuto` | tSubstMax 1 мин: подмена 42; остаток uiSubstRemain_s 60 при входе, 1 в 59 с; ровно через 60 с ФБ сам возвращается в Auto: результат SubstExpired (+1 к uiCmdSeq), значение измеренное, остаток 0. |
| `FB_AnalogInput_Test` | `AnalogInput_OutOfService_HoldsValueInvalid` | OutOfService: значение удерживается (50 при 16 мА на входе), xValid = FALSE, CheckFunction, флаги уставок сняты, все слоты OutOfService; обрыв в OOS не даёт Failure (сигнал не контролируется); слежение пишет удерживаемое значение в rSubstValue_eu и в OOS (правило 2.1, AI-10). Выход («Измерение») — измеренное значение 75. |
| `FB_AnalogInput_Test` | `AnalogInput_InvalidRangeAtStartup_CheckFunctionSafeValue` | Шкала 10..10 с первого вызова: бит AI_CFG_RANGE, CheckFunction, безопасное значение 0.0, xValid = FALSE, флаги уставок FALSE, Available = FALSE; режим — Auto, тип — AnalogInput. |
| `FB_AnalogInput_Test` | `AnalogInput_LimitOrderInvalidAtRuntime_KeepsLastValidCfg` | В работе HH испорчена (70 < H 80): бит AI_CFG_LIMIT_ORDER, CheckFunction, но логика работает по последней корректной Cfg (HH 90): 85 — только H, 95 — HH; значение пригодно. Исправление Cfg снимает CheckFunction. |
| `FB_AnalogInput_Test` | `AnalogInput_DefaultCfg_FirstCallAutoTypeAndSlots` | Cfg по умолчанию проходит CheckConfig (wCfgErr = 0); после первого вызова — Auto («Измерение»), тип AnalogInput, 6 слотов тревог, Good, бит DEV_STS_MODE_AUTO; седьмого слота нет; Local не запрашивается. |
| `FB_AnalogInput_Test` | `AnalogInput_ResetCmd_AcceptedAndAcksAlarms` | Фиксируемых отказов у AI нет, но xReset — команда: результат Accepted, uiCmdSeq + 1, бит сброшен; неквитированная тревога Failure (RtnUnack после возврата сигнала) квитируется — Normal. |
| `FB_AnalogInput_Test` | `AnalogInput_StartupWireBreak_InvalidUntilFirstGoodValue` | Обрыв уже в первом вызове: удерживать нечего — значение 0.0 и xValid = FALSE сразу (не «годный ноль»), ложного LL нет, NE 107 Good до подтверждения; бита AI_STS_FAIL_PENDING нет — значение не удерживается как годное; через 2 с — Failure; после возврата и подтверждения — измеренное значение. |
| `FB_AnalogInput_Test` | `AnalogInput_AlarmEvents_FailureValueIsRawInput` | Номера и значения событий: udiAlarmIdBase 120 — тревога HH = 120, Failure = 124; значение события HH — rValue_eu (95), Failure — сырое rIn (22,5 мА). |
| `FB_AnalogInput_Test` | `AnalogInput_CfgErrBits_MatchContractMap` | Каждая проверка CheckConfig ставит свой бит wCfgErr (карта 11.5): тип входа вне перечисления, шкала, порядок уставок, уставка вне шкалы, гистерезис (< 0 и >= диапазона), отсечка (вне 0…20 %), значение отказа (вне перечисления и NaN), приоритет тревоги вне перечисления, шкала отсчётов Raw. Один экземпляр: wCfgErr — результат проверки этого вызова. |
| `FB_AnalogInput_Test` | `AnalogInput_TimeBackwards_FilterHoldsWithoutJump` | «Время назад» (SetNow на 1 с раньше): шаг времени 0 — фильтр стоит, значение не прыгает и конечно; следующий шаг вперёд продолжает фильтр от того же значения. |
| `FB_AnalogInput_Test` | `AnalogInput_SubstitutionNonFinite_ValueHeld` | Неконечное значение подмены (NaN с HMI) не принимается: значение остаётся прежним (42), а не NaN. |
| `FB_AnalogInput_Test` | `AnalogInput_OosExitWithBrokenSignal_InvalidAtOnce` | Выход из OutOfService с уже оборванной линией (датчик меняли «в ремонте», линию ещё не подключили): последнее хорошее значение — до вывода из работы, его возраст неизвестен. Удерживать его как годное на время подтверждения нельзя: значение сразу негодно, уставки по нему не считаются (как AI-2 при старте ПЛК), отказ — через tFailDelay. Шкала 0..5 м: 17,6 мА = 4,25 м (H 4,0), 16 мА = 3,75 м. |
| `FB_AnalogInput_Test` | `AnalogInput_SubstitutionRenewedAfterTimeout_CountsFullPeriod` | Подмена, снятая по tSubstMax, и новый запрос подмены в следующем же вызове: срок отсчитывается заново, подмена не снимается сразу же. Остаток uiSubstRemain_s — целые секунды с округлением вверх (59,4 с -> 60, 1,3 с -> 2, 0,1 с -> 1): пока подмена идёт, остаток не 0. |
| `FB_AnalogInput_Test` | `AnalogInput_ShortGlitch_FilterKeptNoFalseLimit` | Короткий провал сигнала (один вызов с отказом канала, ошибка обмена Modbus): отказ не подтверждён, значение удерживается, фильтр заморожен и после провала продолжает с прежнего состояния (AI-12). Фильтр 10 с, ступень 50 -> 75, HH 70 без задержки: до провала (1 с) 52,379, через вызов после провала 52,604, HH нет. Сброс фильтра выдал бы мгновенное 75 и ложный HH. источник: tools/reference/ai_reference.py, сценарии filter «ступень 50 -> 75, T = 10 с, 1 с до провала» и «… провал 0,1 с, фильтр заморожен». |
| `FB_AnalogInput_Test` | `AnalogInput_SubstitutionDuringFailure_LimitsOnSubstValue` | Подмена при подтверждённом отказе датчика (наладка блокировок при оборванной линии): в Manual уставки считаются по подменённому значению (11.3, п. 7: принудительный сброс — только в Auto), тревоги уставок подавлены отказом (xLimitsOnFail = FALSE), значение годно, NE 107 — Failure. Возврат в Auto при оборванной линии — уставки сняты сразу, значение — удерживаемое до отказа, xValid = FALSE. |
| `FB_AnalogInput_Test` | `AnalogInput_GuardBandLow_InvalidAfterDelay` | 3,61 мА — защитная полоса NE 43 между отказом (<= 3,6) и измерением (>= 3,8 мА): исправный датчик NE 43 так не выдаёт, это ток отказа с погрешностью канала или насыщение (AI-13). Значение не экстраполируется ниже насыщения 3,8 мА: -0,125 м на шкале 0..10 м (-0,0125 · 10). Пока выход за диапазон не подтверждён (1,9 с) — xValid; через tFailDelay = 2 с — xValid = FALSE (ПИД и автоматика по неопределённому значению не управляют), NE 107 OutOfSpecification, wFault = 0, UNDER_RANGE; уставка LL остаётся (значение не выше насыщения). Норма 12 мА — xValid снова через tFailDelay. источник: tools/reference/ai_reference.py, сценарий scale «3,61 мА, шкала 0..10 (насыщение NE 43)». |
| `FB_AnalogInput_Test` | `AnalogInput_GuardBandHigh_InvalidLimitsKept` | 20,9 мА — верхняя защитная полоса NE 43 (между 20,5 и 21 мА, AI-13): значение — насыщение 20,5 мА, 10,3125 м на шкале 0..10 м (1,03125 · 10), без экстраполяции; через tFailDelay — xValid = FALSE, OVER_RANGE, уставка HH (9,5 м) остаётся: процесс выше верхнего предела измерения. источник: tools/reference/ai_reference.py, сценарий scale «20,9 мА, шкала 0..10 (насыщение NE 43)». |
| `FB_AnalogInput_Test` | `AnalogInput_SubstitutionUnlimited_NoTimeout` | tSubstMax = T#0S — подмена без ограничения срока (Cfg, контракт 11.1): 24 ч в Manual крупными шагами — режим остаётся Manual, результата SubstExpired нет, значение подмены, остаток uiSubstRemain_s = 0. |
| `FB_DigitalInput_Test` | `DigitalInput_OnDelay_FiltersBounce` | Задержка включения 500 мс: дребезг (импульсы 200 и 300 мс) значение не включает, пока идёт отсчёт — бит DI_STS_TIMING_ON; устойчивый сигнал — TRUE ровно через 500 мс. |
| `FB_DigitalInput_Test` | `DigitalInput_OffDelay_HoldsValue` | Задержка отключения 1 с: сигнал пропал — значение держится 0,9 с (бит DI_STS_TIMING_OFF), снимается ровно через 1,0 с. |
| `FB_DigitalInput_Test` | `DigitalInput_Invert_InvertsBeforeDelay` | Инверсия (НЗ-контакт) до задержек: xIn TRUE — значение FALSE; пропадание xIn — фронт инвертированного сигнала, его и задерживает tOnDelay 300 мс (бит DI_STS_RAW = 1 сразу); возврат xIn — спад без задержки. |
| `FB_DigitalInput_Test` | `DigitalInput_Substitution_OverridesValueBypassesDelay` | Подмена (Manual): значение — stCmd.xSubstValue в том же вызове, без задержек 5 с; пригодно, NE 107 CheckFunction. До подмены ФБ следит: stCmd.xSubstValue = xValue. |
| `FB_DigitalInput_Test` | `DigitalInput_ChannelFault_ForceTrue` | ForceTrue (защитный сигнал: отказ канала = сработал): отказ — значение TRUE сразу, xValid = FALSE, Failure, биты DI_FLT_CHANNEL и DI_STS_CHANNEL_FAULT, тревога Failure ActiveUnack, тревога State подавлена (SuppressedByDesign, без дублирования). Отказ снят — снова измерение. |
| `FB_DigitalInput_Test` | `DigitalInput_ChannelFault_HoldLast` | HoldLast: при отказе канала держится значение до отказа (TRUE), xValid = FALSE; после отказа задержка отключения 1 с отсчитывается от возврата канала. |
| `FB_DigitalInput_Test` | `DigitalInput_AlarmOnFalse_ActivatesWhenValueFalse` | xAlarmOnTrue = FALSE (тревога при пропадании сигнала, например «давление в норме»): TRUE — тревоги нет; FALSE — тревога State ActiveUnack, бит DI_STS_ALARM_COND, приоритет в ePrioUnack. |
| `FB_DigitalInput_Test` | `DigitalInput_OutOfService_AlarmsOutOfService` | OutOfService: оба слота OutOfService (в wAlmShelved их нет — ALM-2), значение удерживается (TRUE), xValid = FALSE, CheckFunction; отказ канала в OOS не даёт Failure; слежение xSubstValue действует и в OOS (2.1). После выхода активная тревога State снова ActiveUnack. |
| `FB_DigitalInput_Test` | `DigitalInput_SubstitutionTimeout_ReturnsToAuto` | tSubstMax 30 с: подмена TRUE; остаток 30 при входе, 1 в 29 с; ровно через 30 с — Auto, результат SubstExpired, значение измеренное (FALSE). |
| `FB_DigitalInput_Test` | `DigitalInput_DefaultCfg_FirstCallValueWithoutDelay` | Cfg по умолчанию проходит CheckConfig; после первого вызова — Auto, тип DigitalInput, 2 слота, Good. Значение в первом вызове — без задержки включения (2 с): после старта ПЛК вход сразу равен сигналу. Тревога State по умолчанию выключена (None) и не формируется. |
| `FB_DigitalInput_Test` | `DigitalInput_InvalidCfgAtStartup_ValueFalseCheckFunction` | Без корректной Cfg с первого вызова (eFailValue и приоритет тревоги вне перечисления): биты DI_CFG_FAIL_VALUE и DI_CFG_ALARM, значение FALSE при xIn = TRUE, xValid = FALSE, Available = FALSE, CheckFunction. Исправленная Cfg — измерение. |
| `FB_DigitalInput_Test` | `DigitalInput_ResetCmd_AcceptedAndAcksAlarms` | xReset у DI — команда без фиксируемых отказов: результат Accepted, uiCmdSeq + 1, бит сброшен; тревога Failure после отказа канала (RtnUnack) квитирована. |
| `FB_DigitalInput_Test` | `DigitalInput_ChannelFault_ForceFalse` | ForceFalse: отказ канала при включённом сигнале — значение FALSE сразу, xValid = FALSE. |
| `FB_DigitalInput_Test` | `DigitalInput_InvertFromFirstValidCfg_NoFalseValue` | Корректная Cfg появилась не в первом вызове (на старте Cfg была испорчена, наладчик исправил её с HMI): задержки предустанавливаются по сигналу с инверсией из этой Cfg, а не по сигналу без инверсии, который считался по умолчаниям Cfg. Поплавок «сухой ход», НЗ-контакт (xInvert), задержки 2 с: A — контакт замкнут (норма) — значение FALSE сразу, без ложного «сухого хода» на tOffDelay; B — контакт разомкнут (сработал) — TRUE сразу, без пропуска срабатывания на tOnDelay. |
| `FB_DigitalInput_Test` | `DigitalInput_ChannelFaultDuringOnDelay_RestartsDelay` | Отказ канала во время задержки включения: сигнал при отказе недостоверен, поэтому задержка после возврата канала отсчитывается заново (DI-2), а не продолжается с момента фронта; биты отсчёта во время отказа не выставляются. tOnDelay = 1 с: фронт в t0, отказ t0 + 0,6 … t0 + 0,8 с, возврат tr = t0 + 0,8 с — значение в tr + 1,0 с. |
| `FB_DigitalInput_Test` | `DigitalInput_SubstitutionRenewedAfterTimeout_CountsFullPeriod` | Подмена, снятая по tSubstMax, и новый запрос подмены в следующем же вызове: срок отсчитывается заново, подмена не снимается сразу же. Остаток uiSubstRemain_s — целые секунды с округлением вверх (29,4 с -> 30, 0,3 с -> 1). |
| `FB_DigitalInput_Test` | `DigitalInput_AlarmEvents_ValueIsZeroOrOne` | Значение события тревог дискретного входа — xValue как 1.0 / 0.0 (DI-7): State при xValue = TRUE — Activated со значением 1.0, снятие — Cleared со значением 0.0; номер тревоги State = udiAlarmIdBase + 0. |
| `FB_DigitalInput_Test` | `DigitalInput_ChannelFaultRecovered_ForcedValueReleasedThroughDelay` | Защитный сигнал (ForceTrue, «сухой ход»): после возврата канала задержки отсчитываются от значения отказа, а не от значения до отказа (DI-2). tOnDelay 2 с, tOffDelay 3 с. 1) До отказа FALSE, после возврата датчик сработал (TRUE) — значение остаётся TRUE без провала (иначе 2 с FALSE при xValid = TRUE: насос пустили бы на сухую). 2) До отказа FALSE, после возврата датчик в норме — TRUE снимается только через tOffDelay, ровно в tr + 3,0 с. |
| `FB_DigitalInput_Test` | `DigitalInput_SubstitutionUnlimited_NoTimeout` | tSubstMax = T#0S — подмена без ограничения срока: 24 ч в Manual — режим Manual, SubstExpired нет, значение подмены TRUE, остаток 0. |
| `FB_Motor_Test` | `Motor_FirstCall_SetsTypeSlotsAndPassesDefaultCfg` | Чек-лист устройства, пункты 1 и 4: первый вызов — тип Motor, 8 слотов тревог, умолчания Cfg проходят CheckConfig; двигатель стоит, первопричины нет, NE 107 — Good (Manual у двигателя — не CheckFunction). |
| `FB_Motor_Test` | `Motor_AutoRun_StartsAndConfirms` | Auto: запрос xAutoRun запускает двигатель (Starting, xQRun), ОС через 1 с подтверждает пуск (Running); пуск считается по фронту ОС, отметка в окне пусков — при входе в Starting; двигатель доступен автоматике. |
| `FB_Motor_Test` | `Motor_ManualStart_FeedbackOk_GoesRunning` | Manual: xStart принимается (Accepted, импульс сброшен), двигатель в Starting ждёт ОС; ОС через 2 с (меньше tFbStart = 5 с) — Running без отказа. |
| `FB_Motor_Test` | `Motor_ManualStartInAuto_Rejected` | Auto: команда оператора «Пуск» отклоняется (RejectedMode), импульс сброшен, двигатель стоит, режим Auto. |
| `FB_Motor_Test` | `Motor_StopInAuto_SwitchesToManualAndStops` | «Стоп» оператора в Auto: устройство переходит в Manual (запомнено в retain), команда работы снимается сразу, Stopping до пропадания ОС, затем Stopped; результат Accepted. |
| `FB_Motor_Test` | `Motor_ModeAutoToManual_Bumpless` | Auto → Manual при работе: ручная защёлка := команда работы, двигатель продолжает работать; снятие xAutoRun в Manual его не останавливает. |
| `FB_Motor_Test` | `Motor_NoFeedback_SetsFailToStartAfterTimeout` | Нет ОС после пуска: отказ FailToStart ровно через tFbStart = 5 с (на 4,9 с — ещё нет), выходы сняты, Fault, NE 107 Failure, тревога слота 0 активна и не квитирована. |
| `FB_Motor_Test` | `Motor_FeedbackLostWhileRunning_TripsAndLatches` | ОС пропала в работе: отказ FeedbackLost через tFbLossFilter = 500 мс (на 400 мс — ещё нет); отказ фиксируется — возврат ОС его не снимает, выходы остаются снятыми до Reset. |
| `FB_Motor_Test` | `Motor_FailToStop_RaisesHighPriorityAlarm` | ОС не пропала после «Стоп»: отказ FailToStop через tFbStop = 5 с; тревога слота 2 — приоритет High (механизм не остановить из ПЛК), в сводке ePrioUnack = High, активен только слот 2. |
| `FB_Motor_Test` | `Motor_UncommandedRun_Detected` | ОС без команды ПЛК дольше tFbStart = 5 с: отказ UncommandedRun (High); до этого двигатель считается работающим по ОС; фронт ОС без команды — пуск (счётчик и окно пусков). |
| `FB_Motor_Test` | `Motor_ExtFault_TripsAndResetRejectedWhileActive` | Внешняя авария через фильтр tExtFaultFilter = 200 мс: отказ ExtFault, выходы сняты. Reset при действующей причине: Accepted и импульс xQReset сразу, к концу окна tResetWindow = 3 с — второй результат RejectedFault, отказ остаётся. |
| `FB_Motor_Test` | `Motor_Reset_CauseClearsWithinWindow_FaultCleared` | Reset при действующей причине, причина уходит через 1 с (в окне tResetWindow = 3 с): отказ снимается без второго нажатия, двигатель Stopped; RejectedFault в конце окна не появляется. |
| `FB_Motor_Test` | `Motor_Reset_PulsesResetOutput` | Reset без отказов (чек-лист, пункт 2): результат Accepted, uiCmdSeq + 1; импульс xQReset длится tResetPulse = 1 с (на 0,9 с ещё есть, на 1,0 с — нет); RejectedFault в конце окна нет. |
| `FB_Motor_Test` | `Motor_Interlock_StopsInAutoAndManual_RecordsFirstOut` | Блокировка останавливает двигатель в Auto и в Manual; первопричина — младший из битов, взведённых при переходе слова из 0 (биты 3 и 5 разом → 3), последующие биты её не меняют; вход в Starting её снимает; в Manual блокировка снимает ручную защёлку. |
| `FB_Motor_Test` | `Motor_InterlockCleared_AutoRestarts_ManualDoesNot` | Блокировка не фиксируется: в Auto после её снятия двигатель сам запускается по xAutoRun (tMinStop = 0), в Manual — нет (ручная защёлка снята блокировкой). |
| `FB_Motor_Test` | `Motor_InterlockMaskBitCleared_Ignored` | Бит блокировки, снятый в wInterlockMask, не действует: двигатель работает, в wInterlock состояния его нет, первопричины нет; немаскированный бит останавливает (первопричина — он). |
| `FB_Motor_Test` | `Motor_PermitMissing_BlocksStart_DoesNotStopRunning` | Нет разрешения: в Auto запрос ждёт (бит PERMIT_MISSING, wPermitMissing, ReadyToStart = FALSE) и пуск происходит сам, когда разрешение появилось; пропажа разрешения работающий двигатель не останавливает; в Manual xStart — RejectedPermit. |
| `FB_Motor_Test` | `Motor_MinRunTime_DelaysAutoStop` | tMinRun = 10 с: снятие xAutoRun через 2 с после входа в Running останавливает двигатель только через 10 с от входа в Running (на 9,9 с ещё работает). |
| `FB_Motor_Test` | `Motor_MinRunTime_ManualStopImmediate` | tMinRun действует только на остановы от автоматики: «Стоп» оператора через 1 с после пуска снимает команду сразу; в Auto блокировка тоже останавливает без ожидания tMinRun. |
| `FB_Motor_Test` | `Motor_MinStopTime_InhibitsRestart_ReportsRemaining` | tMinStop = 30 с: пауза отсчитывается от старта ПЛК и от останова; остаток — в uiInhibitRemain_s с округлением вверх (30, через 12,3 с — 18, через 29,9 с — 1), бит START_INHIBIT, xStart — RejectedInhibit; через 30 с пуск принимается. Источник: tools/reference/motor.py, сценарии inhibit_min_stop_*. |
| `FB_Motor_Test` | `Motor_StartsPerHour_LimitReached_InhibitsUntilWindowFrees` | Лимит 3 пуска в час, пуски в t0, t0 + 10 мин, t0 + 20 мин: в t0 + 30 мин пуск отклонён (RejectedInhibit), uiStartsLastHour = 3, остаток 1800 с, предупреждение STARTS_LIMIT; в t0 + 59 мин остаток 60 с; в t0 + 60 мин первая отметка вышла из окна — пуск принят. Источник: tools/reference/motor.py, сценарии starts_limit_3_*. |
| `FB_Motor_Test` | `Motor_LocalMode_OutputsOffTracksFeedback` | Local: выходы сняты, состояние следует ОС (Running/Stopped), контроля ОС нет (ни FailToStop, ни UncommandedRun), команды оператора — RejectedMode, блокировка — только предупреждение INTERLOCK_IN_LOCAL. |
| `FB_Motor_Test` | `Motor_LocalToRemote_RestoresRememberedMode` | Возврат из Local — в запомненный дистанционный режим: Auto → Local → Auto; в Local команда xSetManual меняет запомненный режим, и двигатель, запущенный по месту, после возврата продолжает работать в Manual. |
| `FB_Motor_Test` | `Motor_OosRequestWhileRunning_Rejected` | Вывод из работы при работающем двигателе — RejectedState (чек-лист, пункт 3); у стоящего — принят: режим OutOfService, NE 107 CheckFunction, пуск — RejectedMode. |
| `FB_Motor_Test` | `Motor_PowerLoss_StopsWithoutFault_StartsMinStop` | Пропадание напряжения в Auto: Stopped без отказа, предупреждение POWER_LOST и запрет пуска; tMinStop = 20 с отсчитывается от момента пропадания: питание вернулось через 5 с — остаток 15 с, пуск по запросу Auto — ровно через 20 с. Источник: tools/reference/motor.py, сценарий inhibit_power_loss_after_5s. |
| `FB_Motor_Test` | `Motor_PlcRestart_RunningFeedback_Adopted` | Старт ПЛК при работающем по ОС двигателе: Auto с запросом и Manual — подхват (Running, xQRun) без отказа UncommandedRun и без счёта пуска. |
| `FB_Motor_Test` | `Motor_RunHours_AccumulateInRetain` | Наработка копится в stRetain: 90 мин работы шагами по 10 с — 5400 с, rRunTime_h = 1,5 ч (и «с ТО» так же, RunSeconds); 2,5 с шагами по 100 мс — 2 целых секунды (0,5 с — в накопителе), ещё 0,5 с — 3 с. Источник: tools/reference/motor.py, сценарии run_hours_90min_*, run_fraction_*. |
| `FB_Motor_Test` | `Motor_RunHours_LargeTimeStep_Bounded` | Шаг времени больше DT_ACCUM_MAX (зависание, остановка задачи) засчитывается как 10 с: после шага 1 ч — 10 с, после шага 3 с — 13 с. Источник: tools/reference/motor.py, сценарии run_large_step_*. |
| `FB_Motor_Test` | `Motor_Starts_CountedOnFeedbackEdge` | Пуск считается по фронту ОС: попытка пуска без ОС — отметка в окне, но не пуск; ОС — пуск (всего и «с ТО»); пуск по месту (фронт ОС в Local без команды ПЛК) — тоже пуск и отметка в окне. |
| `FB_Motor_Test` | `Motor_PresetCounters_AppliedInBody` | PresetCounters() только ставит запрос (TRUE), значения пишет ближайший вызов тела: наработка и пуски в stRetain, RunSeconds, Starts, rRunTime_h = 100 ч, Accepted; счётчики «с ТО» не меняются. |
| `FB_Motor_Test` | `Motor_MaintIntervalReached_MaintenanceRequired` | ТО по наработке 1 ч (порог 3600 с) и по 2 пускам: 3590 с + 10 с работы — предупреждение MAINT_RUNTIME, NE 107 MaintenanceRequired; второй пуск — MAINT_STARTS; xResetMaint обнуляет счётчики «с ТО» (Accepted). Источник: tools/reference/motor.py, сценарии maint_runtime_*. |
| `FB_Motor_Test` | `Motor_NoFeedbackConfigured_RunsOnCommand` | Без ОС (xFbUsed = FALSE; tFbStart = T#0S тогда допустим): работа — по команде, сразу Running; отказов контроля ОС нет; наработка и пуски — по команде. |
| `FB_Motor_Test` | `Motor_InvalidCfgAtStartup_StaysStoppedCheckFunction` | Неверная Cfg с первого вызова (uiMaxStartsPerHour > STARTS_WINDOW_MAX): бит MOT_CFG_STARTS_LIMIT, CheckFunction, безопасный выход — запрос Auto не запускает, Available = FALSE, xStart — RejectedCfg. |
| `FB_Motor_Test` | `Motor_InvalidCfgAtRuntime_KeepsRunningWithLastValid` | Cfg испорчена в работе (tResetWindow = T#0S): двигатель продолжает работать, CheckFunction и бит MOT_CFG_RESET; логика — по последней корректной копии: фильтр пропадания ОС 500 мс, а не 5 с из новой Cfg. |
| `FB_Motor_Test` | `Motor_CurrentRunSeconds_CountsAndResetsOnStop` | Текущая непрерывная работа: 65 с работы — CurrentRunSeconds = 65 (и stSts.udiRunCurrent_s); останов — 0; новый пуск считает с нуля (3 с), наработка всего продолжается (68 с). Источник: tools/reference/motor.py, сценарии current_run_*. |
| `FB_Motor_Test` | `Motor_OosEntry_ClearsLatchedFaultsAndFirstOut` | Чек-лист, пункт 5: вход в OutOfService (хук OnModeChanged) снимает зафиксированный отказ и первопричину; тревоги — OutOfService, NE 107 — CheckFunction. |
| `FB_Motor_Test` | `Motor_CfgChecks_SetEachCfgErrBit` | CheckConfig двигателя: каждая проверка 13.9 даёт свой бит wCfgErr; границы допустимы (30 пусков в час, tResetPulse = tResetWindow); без ОС времена ОС не проверяются. |
| `FB_Motor_Test` | `Motor_ManualStart_RejectionReasonByPrecedence` | Причина отказа xStart в Manual — по старшинству 13.5: при отказе, блокировке, нет разрешения и паузе — RejectedFault; без отказа — RejectedInterlock; без блокировки — RejectedPermit; затем RejectedInhibit. |
| `FB_Motor_Test` | `Motor_StopAndStartSameCall_StopWins` | «Стоп» и «Пуск» в одном вызове: «Стоп» старше — двигатель останавливается, оба импульса сброшены. |
| `FB_Motor_Test` | `Motor_PlcRestart_AutoWithoutDemand_Stops` | Старт ПЛК в Auto без запроса при работающем по ОС двигателе: штатный останов с контролем (Stopping, команда не подаётся), после пропадания ОС — Stopped без отказа. |
| `FB_Motor_Test` | `Motor_ExtFaultInLocal_Latches` | Внешняя авария действует и в Local: отказ фиксируется (Fault); после возврата в Manual отказ остаётся, пуск — RejectedFault. |
| `FB_Motor_Test` | `Motor_PowerLossInManual_LatchClearedNoRestart` | Пропадание напряжения в Manual снимает ручную защёлку: после восстановления питания двигатель не запускается сам; отказа нет. |
| `FB_Motor_Test` | `Motor_InterlockTrip_SlotAlarmWhileInterlockActive` | Останов блокировкой в работе — тревога слота 5 InterlockTrip (приоритет по умолчанию None, здесь Low), номер тревоги udiAlarmIdBase + 5; пока блокировка действует — тревога активна, после снятия — нет. |
| `FB_Motor_Test` | `Motor_TimeBackwards_NoFaultNoCountJump` | «Время назад» (SetNow на 30 с раньше) у работающего двигателя: отказов нет, наработка не скачет (шаг времени 0), дальше считается обычно. |
| `FB_Motor_Test` | `Motor_PowerDipWhileStopped_PauseFromPowerLoss` | Провал питания у стоящего двигателя тоже даёт паузу tMinStop = 20 с от момента пропадания: через 5 с после провала (питание вернулось через 1 с) пуск — RejectedInhibit, остаток 15 с; через 20 с — принят. Источник: tools/reference/motor.py, сценарий inhibit_power_loss_after_5s. |
| `FB_Motor_Test` | `Motor_StartWhileStopping_PermitLostCancelsLatch` | Manual: «Пуск» во время выбега (Stopping) принят — двигатель запустится после останова (M-09). За время выбега пропало разрешение: после останова отложенный пуск отменяется (защёлка снята, второй результат RejectedPermit), и когда разрешение вернётся через 10 мин, двигатель в Manual сам не запускается. |
| `FB_Motor_Test` | `Motor_PowerDipFeedbackStays_StoppingWithoutUncommandedRun` | Провал напряжения 0,3 с, который пережил ПЧ (кинетическая поддержка): ОС «в работе» не пропала. Команда снята; после восстановления питания двигатель тормозит под контролем останова (Stopping, tFbStop = 10 с), а не стоит в Stopped с ложным UncommandedRun через tFbStart = 5 с; ОС пропала через 6 с — Stopped без отказа. |
| `FB_Motor_Test` | `Motor_FeedbackStaysAfterTrip_RaisesFailToStop` | Сварившийся контактор: внешняя авария (тепловое реле) отключила двигатель — xQRun снят, Fault, — а ОС «в работе» осталась. Через tFbStop = 5 с после отказа к ExtFault добавляется FailToStop (тревога слота 2, High: механизм не остановить из ПЛК); через 4,9 с после отказа — только ExtFault. |
| `FB_Motor_Test` | `Motor_FeedbackDropoutWithinFilter_NotCountedAsStart` | Дребезг блок-контакта в работе: ОС пропала на 0,2 с (меньше tFbLossFilter = 0,5 с) и вернулась — это не останов и не новый пуск: пусков 1, текущая непрерывная работа не обнулилась (по ней станция ограничивает непрерывную работу и чередует насосы), отказа нет. Источник: tools/reference/motor.py, сценарии dropout_bridged_at_return_s, dropout_bridged_total_s. |
| `FB_Motor_Test` | `Motor_ReadyToStart_FalseWhileStarting` | ReadyToStart — «стоит и готов к пуску» (I_Motor): в Auto до пуска TRUE; в Starting (команда подана, ОС ещё нет, tMinStop = 0) — FALSE: станция не должна считать запускаемый насос резервом; в Running — FALSE. |
| `FB_Motor_Test` | `Motor_OosRequestWhileRunningByFeedback_Rejected` | Вывод из работы — только когда механизм стоит (2.2): после внешней аварии команда снята (Fault), но ОС «в работе» держится (сварился контактор) — xSetOos отклоняется (RejectedState), зафиксированные отказы не снимаются; ОС пропала — вывод из работы принят. |
| `FB_Motor_Test` | `Motor_ResetFailToStop_ClearedOnlyAfterMotorStops` | FailToStop снимается Reset только когда двигатель не работает по ОС (M-02): Reset при ещё работающем двигателе — импульс xQReset, отказ остаётся, к концу окна tResetWindow = 3 с второй результат RejectedFault; ОС пропала — следующий Reset снимает отказ, двигатель в Stopped. |
| `FB_Motor_Test` | `Motor_TimeBackwardsDuringMinStop_PauseRestarts` | Пауза tMinStop = 10 с (защита погружного насоса от обратного вращения): двигатель остановлен, прошло 2 с, время назад на 30 с (SetNow — смена источника времени). Пауза отсчитывается заново (M-03, M-17), а не снимается переполнением LTIME без знака: пуск — RejectedInhibit, остаток 10 с; 1 с в 9,9 с; через 10 с пуск принят. |
| `FB_Motor_Test` | `Motor_TimeBackwardsDuringMinRun_KeepsRunning` | Auto, tMinRun = 10 с: через 2 с работы запрос снят — двигатель работает до tMinRun. Время назад на 30 с: отсчёт tMinRun начинается заново (M-17), двигатель не останавливается раньше срока; останов ровно через 10 с после скачка. |
| `FB_Motor_Test` | `Motor_TimeBackwardsDuringResetPulse_PulseRestarts` | Внешняя авария зафиксирована, Reset с tResetPulse = 1 с (сброс УПП): через 0,5 с время назад на 30 с. Импульс xQReset и окно tResetWindow отсчитываются заново (M-17), а не обрываются переполнением: импульс держится ещё 1 с после скачка; авария, снятая в окне, сброшена без RejectedFault. |
| `FB_MotorVfd_Test` | `MotorVfd_FirstCallFakeTime_CommLossDeterministic` | Связи с ПЧ нет с первого вызова: ResolveTime() до вложенного фильтра даёт подменное время и в первом вызове, отказ связи — ровно через tCommLoss = 2 с (на 1,9 с ещё нет). |
| `FB_MotorVfd_Test` | `MotorVfd_ImplementsIMotorVfd_LeadPumpProperties` | I_MotorVfd для ведущего насоса: SpeedRef, SpeedAct, SpeedAutoActive, Running и Mode через интерфейс. SpeedAutoActive (VFD-06) — только Auto, Running и без отказа: FALSE у стоящего в Auto насоса, в Starting (ОС ещё нет), в Stopping (ОС ещё есть), при отказе связи и в Manual; TRUE — Auto и Running. |
| `FB_MotorVfd_Test` | `MotorVfd_SpeedRamp_LimitsRate` | Рампа задания: min 20 %, рост 10 %/с, спад 5 %/с, шаг 100 мс; пуск — с 20 %, через 1,5 с — 35 %, через 3 с — цель 50 %; цель 30 %: через 2 с — 40 %, через 4 с — 30 %. Источник: tools/reference/motor.py, сценарии ramp_*. |
| `FB_MotorVfd_Test` | `MotorVfd_SpeedClampedToMinMax` | Пределы задания 20…90 %: цель Auto 95 % → 90 % (слежение stCmd.rSpeedSp_pct тоже 90), 5 % → 20 %; в Manual 150 % → 90 % и записывается обратно в stCmd. |
| `FB_MotorVfd_Test` | `MotorVfd_StartPresetsRampToMin` | Вход в Starting начинает рампу с rSpeedMin_pct = 30 % (а не с 0): в вызове пуска 30 %, через шаг 100 мс — 31 %, через 1 с — 40 % (рост 10 %/с, цель 80 %). Источник: tools/reference/motor.py, сценарии start_preset_*. |
| `FB_MotorVfd_Test` | `MotorVfd_StopSetsRefZero` | «Стоп» снимает команду работы и задание — 0 % в том же вызове (торможение — рампой ПЧ). |
| `FB_MotorVfd_Test` | `MotorVfd_CommLoss_FaultAfterDelayNotLatched` | Потеря связи (xCommLossIsFault = TRUE): сразу — контроль ОС приостановлен (FB_SUSPENDED), через tCommLoss = 3 с — нефиксируемый отказ (бит COMM_LOSS, Fault, выходы сняты, Available = FALSE, тревога слота 6), задание удерживается; связь вернулась, ПЧ работает, запрос Auto есть — Running без Reset. |
| `FB_MotorVfd_Test` | `MotorVfd_CommLoss_SuppressesFeedbackSupervisionImmediately` | Связь пропала во время пуска (tFbStart = 2 с) на 2,4 с — меньше tCommLoss: FailToStart не формируется, состояние Starting удерживается; связь вернулась с ОС — Running без отказа. |
| `FB_MotorVfd_Test` | `MotorVfd_CommRestored_RunningWithoutDemand_Stops` | Manual: отказ связи снимает ручную защёлку; связь вернулась, ПЧ ещё работает, запроса нет — штатный останов с контролем (Stopping, команда не подаётся), затем Stopped. |
| `FB_MotorVfd_Test` | `MotorVfd_CommLossNotFault_Warning` | xCommLossIsFault = FALSE (пуск/стоп и ОС проводами, xFbFromComm = FALSE): потеря связи — только предупреждение COMM_LOSS, NE 107 OutOfSpecification и тревога слота 6; двигатель работает, ОС по DI контролируется. |
| `FB_MotorVfd_Test` | `MotorVfd_VfdFault_TripsAndResetPulses` | Авария ПЧ из слова состояния — внешняя авария (фильтр 200 мс, фиксируется); Reset даёт импульс xQReset, ПЧ сбрасывает аварию через 0,5 с — отказ снят в окне без второго нажатия. |
| `FB_MotorVfd_Test` | `MotorVfd_VfdNotReady_BlocksStart` | ПЧ не готов (xVfdReady = FALSE при связи): пуск оператора — RejectedPermit, бит PERMIT_MISSING; в Auto запрос ждёт (ReadyToStart = FALSE) и пуск происходит, когда ПЧ готов. |
| `FB_MotorVfd_Test` | `MotorVfd_SpeedDeviation_WarningAfterDelay` | Рассогласование задания 50 % и факта 35 % (больше rSpeedDev_pct = 10 %) дольше tSpeedDev = 10 с: предупреждение SPEED_DEV, NE 107 OutOfSpecification, тревога слота 7; не отказ — двигатель работает. |
| `FB_MotorVfd_Test` | `MotorVfd_ManualSpeed_TracksAutoForBumpless` | В Auto задание оператора следит за целью (60 %); переход в Manual — задание не прыгает, команда работы сохраняется. |
| `FB_MotorVfd_Test` | `MotorVfd_SpeedSpNaN_HoldsRef` | Цель не конечна (NaN от ПИД/Modbus): задание удерживается, предупреждение SPEED_SP_INVALID, NaN в задание оператора не пишется; конечная цель снова принимается. |
| `FB_MotorVfd_Test` | `MotorVfd_InvalidSpeedLimits_CfgErrBit8` | Пределы скорости неверны (min >= max, max > 100, min < 0): бит 8 MOT_CFG_VFD_SPEED_LIMITS (переопределение CheckConfig вызывается и из тела FB_Motor), CheckFunction. |
| `FB_MotorVfd_Test` | `MotorVfd_ImplementsIMotor_PolymorphicArray` | FB_Motor и FB_MotorVfd в одном массиве I_Motor: станция читает Running, Starts, RunSeconds без знания типа; тип в stCommon.eDevType — Motor и MotorVfd; Reset() через I_Device. |
| `FB_MotorVfd_Test` | `MotorVfd_FirstCall_SetsTypeMotorVfdAndPassesDefaultCfg` | Чек-лист, пункты 1 и 8: тип MotorVfd (FB_Motor его не затирает), 8 слотов, умолчания Cfg с полем stVfd проходят CheckConfig, задание 0 %. |
| `FB_MotorVfd_Test` | `MotorVfd_CfgChecks_RampCommSpeedDevBits` | Переопределение CheckConfig: бит 9 (рампа < 0), бит 10 (tCommLoss = T#0S), бит 11 (rSpeedDev_pct > 0 при tSpeedDev = T#0S) и биты FB_Motor вместе (tResetWindow = T#0S — бит 2). |
| `FB_MotorVfd_Test` | `MotorVfd_LocalMode_RefTracksActualSpeed` | Local: выходы сняты, задание и задание оператора следят за фактической скоростью (42 %); возврат в Manual при работающем ПЧ — без рывка задания. |
| `FB_MotorVfd_Test` | `MotorVfd_PlcRestartFbFromDi_AdoptedWithoutFault` | Старт ПЛК, ОС по DI (xFbFromComm = FALSE), слово состояния ПЧ ещё не прочитано: в первом вызове точки расширения берут корректную stCfg, а не умолчания — двигатель подхвачен, UncommandedRun нет. |
| `FB_MotorVfd_Test` | `MotorVfd_PlcRestartCommLater_AdoptedWithoutFault` | Старт ПЛК, ПЧ работает, ОС — из слова состояния, но связи первые 0,5 с нет (мастер Modbus ещё не опросил слейв): подхват ждёт первой достоверной ОС — при появлении связи двигатель подхвачен (Running, команда), без UncommandedRun и без счёта пуска. |
| `FB_MotorVfd_Test` | `MotorVfd_SpeedDeviationDuringRamp_Ignored` | Рассогласование во время рампы не контролируется: рост 1 %/с к цели 50 %, факт отстаёт (0 %) — за 20 с (больше tSpeedDev = 2 с при допуске 10 %) предупреждения нет (задание 20 %); рампа завершена — предупреждение ровно через tSpeedDev. Источник: tools/reference/motor.py, сценарий ramp_slow_20s. |
| `FB_MotorVfd_Test` | `MotorVfd_CommLost_StatusWordIgnored` | Слово состояния ПЧ достоверно только при связи (14.2): связи нет 1 с (меньше tCommLoss), в последнем прочитанном слове «авария» и «не готов» — ни ExtFault (дольше tExtFaultFilter), ни PERMIT_MISSING. Связь появилась, авария держится — ExtFault через tExtFaultFilter, «не готов» — PERMIT_MISSING. |
| `FB_MotorVfd_Test` | `MotorVfd_CommLossInOos_NoFaultNoWarning` | Отказ связи с ПЧ действует во всех режимах, кроме OutOfService (13.6, 14.4): в OOS связи нет 4 с — ни MOT_FLT_COMM_LOSS (xCommLossIsFault = TRUE), ни MOT_WRN_COMM_LOSS (FALSE), тревога слота 6 — в OutOfService. Выход в Manual при той же потере связи — предупреждение появляется. |
| `FB_MotorVfd_Test` | `MotorVfd_StartWithNaNTarget_RefStartsAtMin` | Пуск при не конечной цели (ПИД выдал NaN, пока насос стоял), без ограничения роста (rRampUp_pctps = 0): задание начинается с rSpeedMin_pct = 25 %, а не с последней конечной цели 60 %; предупреждение SPEED_SP_INVALID. Конечная цель — задание сразу к ней (VFD-03). |
| `FB_MotorVfd_Test` | `MotorVfd_CommLossWhileStopping_HoldsStopping` | Связь с ПЧ пропала во время торможения (Stopping, ОС из слова состояния): ОС недостоверна — состояние удерживается в Stopping (не «остановлен»), контроль приостановлен; связь вернулась через 1 с (меньше tCommLoss), ПЧ ещё тормозит — Stopping под контролем tFbStop; ПЧ остановился — Stopped без отказа. |
| `FB_MotorVfd_Test` | `MotorVfd_PlcRestart_RefBumpless` | Перезапуск ПЛК при работающем ПЧ: подхват (VFD-09). Auto, запрос есть, ПЧ на 70 %: задание на ПЧ сразу 70 % — фактическая скорость в пределах rSpeedMin…rSpeedMax, — без провала к 0 и рампы с нуля (rRampUp 10 %/с). Manual, ПЧ на 55 %: подхват пишет фактическую скорость и в задание оператора stCmd.rSpeedSp_pct (оно не энергонезависимо и после старта 0) — двигатель не тормозится до rSpeedMin. |
| `FB_MotorVfd_Test` | `MotorVfd_StartInCommGap_RefPresetToMin` | Пуск в Manual во время короткого пропуска связи (короче tCommLoss): пуск не блокируется, а задание передать нельзя — предустановка rSpeedMin ждёт связи (VFD-10). Связь вернулась — задание 30 % (rSpeedMin), а не рампа от 0; дальше рампа 1 %/с: 30,1 % через 0,1 с. |
| `FB_MotorVfd_Test` | `MotorVfd_CommLoss_CountersFrozen` | ПЧ с ОС из слова состояния работает в Auto 10 с; связь пропала на 1 ч (кабель), питание есть. Через tCommLoss — отказ CommLoss, и двигатель больше не считается работающим по устаревшей ОС (VFD-11): xRunning, Running и бит RUNNING сняты, наработка выросла только на время до отказа, CurrentRunSeconds = 0. Связь вернулась, ПЧ работает, запрос есть — Running без нового пуска. |
| `FB_MotorVfd_Test` | `MotorVfd_PowerLossCommLoss_NoFaultNotRunning` | Пропало питание станции: xPowerOk = FALSE, ПЧ обесточен, связи нет (VFD-11, VFD-12). Отказа CommLoss и тревоги слота 6 нет — пропадание питания — останов без отказа (13.7); двигатель не работает: xRunning снят сразу, Stopped, наработка за час не растёт. Питание вернулось — ПЧ загружается VFD_POWER_UP_DELAY = 10 с, затем фильтр tCommLoss = 3 с: отказ связи — только через 13 с, если связь так и не появилась; связь есть — отказ снят. |
| `FB_MotorVfd_Test` | `MotorVfd_SlowRamp1msCycle_NotStalled` | Рампа задания 0,003 %/с при цикле 1 мс (VFD-13): состояние рампы в LREAL — за 1 с задание растёт на 0,003 % (в REAL приращение 3·10⁻⁶ % рядом с 70 % терялось бы и рампа стояла). Ожидаемое: 70 + 0,003 · 1 с. |
| `FB_MotorVfd_Test` | `MotorVfd_SpeedActNaN_StsFinite` | Фактическая скорость NaN при xCommOk (мусор Modbus): связь недостоверна, задание удерживается; в Sts и свойстве SpeedAct — конечное 0.0 (R6: карта регистров NaN не получает). |
| `FB_Valve_Test` | `Valve_Open_LimitReached_GoesOpen` | Manual, задвижка закрыта (ZSC). xOpen: Opening, включён только xQOpen, остаток хода 10 с; через 2 с остаток 8 с; ZSO на t0 + 5,0 с — Open, выход снят, xOpened, один цикл в stRetain. |
| `FB_Valve_Test` | `Valve_Close_LimitReached_GoesClosed` | Manual, задвижка открыта (ZSO). xClose: Closing, включён только xQClose; ZSC на t0 + 3,0 с — Closed, выход снят, xClosed. Закрытие циклом «открыто» не считается. |
| `FB_Valve_Test` | `Valve_Open_Timeout_SetsFailToOpen` | tTravel = 10 с, ZSO не приходит: на t0 + 9,9 с ещё Opening без отказа, ровно на t0 + 10,0 с — FailToOpen (wFault бит 0, Failure, тревога слота 0), выход снят. Отказ фиксируется: пришедший позже ZSO его не снимает (положение видно в xOpened), снимает Reset — далее состояние по концевикам. |
| `FB_Valve_Test` | `Valve_BothLimits_SetsFailureOutputsOff` | Auto, закрыта. Залип ZSO — оба концевика: до tLimitFilter (0,5 с) состояние держится, на 0,5 с — BothLimits (wFault бит 2, Failure, тревога слота 2). Запрос автоматики «открыть» выходы не включает, Available = FALSE. Отказ не фиксируется: концевик исправен — отказ снят без Reset, Auto ведёт к цели. |
| `FB_Valve_Test` | `Valve_PositionLost_LatchesFault` | Manual, открыта. Провал ZSO на 0,4 с фильтруется (tLimitFilter = 0,5 с). Пропал на 0,5 с без команды — PositionLost (wFault бит 3), фиксируется: вернувшийся ZSO отказ не снимает, снимает Reset. |
| `FB_Valve_Test` | `Valve_Reverse_PausesBeforeOppositeDirection` | Motorized открывается; команда «закрыть» в ходе: Reversing, оба выхода сняты на tReverse = 1 с (на t1 + 0,9 с ещё сняты), ровно на t1 + 1,0 с включается xQClose. |
| `FB_Valve_Test` | `Valve_NeverBothOutputs` | Инвариант: xQOpen AND xQClose никогда не TRUE. 600 циклов по 0,1 с с моделью хода (30 шагов от ZSC до ZSO): команды открыть, закрыть, стоп с разными периодами, переходы в Auto с переменным запросом, блокировки и пропадающее разрешение на открытие. Проверяется и то, что сценарий открывал, закрывал и реверсировал (тест не пустой). |
| `FB_Valve_Test` | `Valve_StopMotorized_GoesIntermediate` | Motorized открывается; xStop в ходе — Intermediate, выходы сняты, Accepted, бит сброшен. Цель Manual «никуда»: арматура стоит и дальше. |
| `FB_Valve_Test` | `Valve_StopSolenoid_Rejected` | Соленоид НЗ (SolenoidEto) открывается; xStop — RejectedNotSupported: катушка и движение не меняются, бит сброшен. |
| `FB_Valve_Test` | `Valve_SolenoidEtc_FaultDeenergizesCoil` | Соленоид НО (SolenoidEtc, без тока открыт): закрытие — катушка под током и держит Closed. Внешняя авария — Fault, катушка обесточена (положение пружины, независимо от eSafePos), выходов привода нет; причина ушла — катушка без тока до Reset, пружина открыла клапан (xOpened). |
| `FB_Valve_Test` | `Valve_SolenoidEto_OpenEnergizesCoil` | Соленоид НЗ (SolenoidEto, без тока закрыт): xOpen — катушка под током, Opening, выходов привода нет; ZSO — Open, катушка держит; xClose — катушка обесточена, Closing. |
| `FB_Valve_Test` | `Valve_Interlock_DrivesToSafePosition` | Manual, открыта, разрешения на закрытие нет (xClose — RejectedPermit). Блокировка (биты 3 и 4) ведёт в положение безопасности Closed без разрешения: Closing, бит INTERLOCKED, wInterlock, первопричина — младший бит 3. Команды — RejectedInterlock; новый бит первопричину не меняет. После снятия блокировки Manual остаётся закрытым; первопричина держится до Reset. |
| `FB_Valve_Test` | `Valve_PermitOpenMissing_OpenRejected` | Нет разрешения на открытие (бит 0): xOpen — RejectedPermit, движения нет; бит снят из маски — команда принята. В Auto запрос «открыть» ждёт разрешения (бит PERMIT_MISSING, wPermitMissing) и выполняется, когда оно появится. |
| `FB_Valve_Test` | `Valve_TorqueMidTravel_LatchesTorqueTrip` | Муфта подключена. Через 3 с хода, до концевика, сработала муфта открытия — TorqueTrip (wFault бит 4), выход снят, бит TORQUE. Муфта отпустила — отказ держится (бит TORQUE снят); Reset снимает отказ, арматура в промежутке стоит (Manual). |
| `FB_Valve_Test` | `Valve_CloseOnTorque_CompletesClosing` | Клиновая задвижка: муфта подключена, закрытие «по моменту». Через 3 с хода сработал ZSC (стоит чуть раньше посадки клина) — выход держится; через 0,2 с клин сел, сработала муфта закрытия — Closed без отказа, выход снят, xClosed; предупреждения «положение по времени» нет. Муфта отпустила, ZSC держится — задвижка остаётся Closed без отказа. Муфта раньше ZSC — тест Valve_CloseOnTorque_TorqueBeforeZsc_LatchesTorqueTrip. |
| `FB_Valve_Test` | `Valve_NoLimitSwitches_PositionByTravelTime` | Концевиков нет: старт — Unknown (VLV_WRN_POSITION_UNKNOWN). xOpen: выход держится tTravel = 10 с (на 9,9 с ещё Opening), ровно на 10,0 с — Open по времени без отказа, VLV_WRN_POSITION_BY_TIME; входы неподключённых концевиков не учитываются. |
| `FB_Valve_Test` | `Valve_ManualCmdInAuto_SwitchesToManual` | Auto, запрос «закрыть», закрыта. xOpen оператора: Manual (запоминается в stRetain), Opening, Accepted; запрос автоматики больше не действует. xStop в Auto: Manual и стоп. |
| `FB_Valve_Test` | `Valve_PowerLoss_StopsWithoutFault` | Нет напряжения при открытии: Intermediate, выходы сняты, VLV_WRN_POWER_LOST, отказа нет; команда — RejectedInhibit; 12 с без напряжения (больше tTravel) отказа хода не дают. Напряжение вернулось: Manual стоит (цель снята); Auto снова ведёт к цели. Готовность для автоматики (Available, VLV_STS_AVAILABLE) в Auto есть только при напряжении. |
| `FB_Valve_Test` | `Valve_Local_OutputsOffTracksLimits` | Local: выходы сняты, команды — RejectedMode; состояние по концевикам при движении руками (цикл считается); блокировка — только предупреждение VLV_WRN_INTERLOCK_IN_LOCAL; «оба концевика» не контролируется (Unknown, без отказа). Возврат в запомненный Manual без движения. |
| `FB_Valve_Test` | `Valve_Cycles_CountedOnOpen` | Цикл — вход в Open, если прошлое крайнее положение не Open: открыть (1), закрыть (1), открыть (2) — stRetain и stSts. Неполный ход Open -> стоп -> снова Open циклом не считается. xResetMaint обнуляет счётчик «с ТО», полный не трогает. Перед каждой сменой направления арматура стоит 1 с: встречный ход начинается не раньше tReverse после снятия выхода (тест Valve_ReverseAfterEndStop_WaitsReversePause). |
| `FB_Valve_Test` | `Valve_InvalidCfg_StartupOutputsOff` | Корректной Cfg ещё не было (tTravel = T#0S): бит VLV_CFG_TRAVEL, CheckFunction, DEV_STS_CFG_ERROR; Auto с запросом «открыть» — выходы сняты 1 с, Available = FALSE; состояние по концевикам; xOpen — RejectedCfg без смены режима. Cfg исправлена — арматура идёт к цели. |
| `FB_Valve_Test` | `Valve_ExtFault_TripsAndResetRejectedWhileActive` | Внешняя авария в ходе: Fault, выход снят, тревога слота 5 с номером udiAlarmIdBase + 5. Reset при действующей причине: Accepted сразу, окно tResetWindow = 3 с; до конца окна второго результата нет, ровно на 3 с — RejectedFault, отказ остаётся. Причина ушла — отказ держится до Reset; Reset снимает. |
| `FB_Valve_Test` | `Valve_Reset_CauseClearsWithinWindow_FaultCleared` | TorqueTrip, Reset при сработавшей муфте: отказ держится; муфта отпустила через 1 с — отказ снят в окне tResetWindow без второго результата (и после конца окна RejectedFault нет). |
| `FB_Valve_Test` | `Valve_OosRequestWhileMoving_Rejected` | Вывод из работы в ходе — RejectedState, ход продолжается. Остановленную арматуру вывести можно: OutOfService, выходы сняты, CheckFunction, команды — RejectedMode. |
| `FB_Valve_Test` | `Valve_OosEntry_ClearsLatchedFaults` | Зафиксированные TorqueTrip (муфта в ходе после страгивания, отпустила) и внешняя авария (причина ушла) снимаются входом в OutOfService; в OOS внешняя авария не контролируется, тревоги — OutOfService; после выхода в Manual отказа нет. |
| `FB_Valve_Test` | `Valve_AutoToManual_Bumpless` | Auto открывает; переход в Manual: цель := текущее направление — ход продолжается до ZSO (арматура не дёргается). |
| `FB_Valve_Test` | `Valve_PlcRestart_StateFromLimits` | Старт ПЛК (первый вызов, Manual): ZSO — Open, оба концевика — сразу Fault (BothLimits), ни одного — Intermediate, без концевиков — Unknown; выходы сняты. |
| `FB_Valve_Test` | `Valve_ActTime_AccumulatesInRetain` | Время работы привода: 12,5 с с включённым выходом — 12 с в stRetain (доля 0,5 с в накопителе), часы в Sts; пока стоит — не копится; шаг времени 60 с идёт в счёт не больше DT_ACCUM_MAX = 10 с. xResetMaint обнуляет время «с ТО», полное время не трогает. |
| `FB_Valve_Test` | `Valve_MaintCyclesReached_MaintenanceRequired` | ТО по циклам: udiMaintCycles = 2, до ТО остался один цикл. Открытие — счётчик «с ТО» 2: предупреждение VLV_WRN_MAINT_CYCLES, NE 107 MaintenanceRequired, бит DEV_STS_WARNING; xResetMaint — снова Good. |
| `FB_Valve_Test` | `Valve_DefaultCfg_PassesCheck` | Умолчания ST_ValveCfg проходят CheckConfig; тип в stCommon — Valve, слотов тревог 7; приоритеты по умолчанию (FailToOpen — Medium, InterlockAct — None); слот 7 не используется; NE 107 Good. |
| `FB_Valve_Test` | `Valve_CfgChecks_SetBits` | Каждая проверка CheckConfig даёт свой бит wCfgErr: тип вне перечисления; tTravel = 0; Stay у соленоида и eSafePos вне перечисления; закрытие по моменту без муфты и муфта у соленоида; tReverse = 0 у Motorized (у соленоида допустим); tResetWindow = 0; приоритет тревоги вне перечисления. |
| `FB_Valve_Test` | `Valve_PermitLostWhileMoving_ContinuesMotion` | Разрешение на открытие пропало в ходе: работающий ход не останавливается (бит PERMIT_MISSING и wPermitMissing показывают недостачу), арматура доходит до ZSO. |
| `FB_Valve_Test` | `Valve_InvalidCfgAtRuntime_KeepsLastValid` | Cfg испорчена в ходе (tTravel = 0): бит wCfgErr и CheckFunction, ход продолжается по последней корректной Cfg; время хода контролируется по ней же: FailToOpen ровно на t0 + 10 с. |
| `FB_Valve_Test` | `Valve_InterlockStay_StopsMotorized` | Положение безопасности Stay: блокировка в ходе останавливает электропривод (Intermediate), выходы сняты, бит INTERLOCKED. |
| `FB_Valve_Test` | `Valve_CloseOnTorque_ZscAloneKeepsDrivingUntilTimeout` | Клиновая задвижка, закрытие «по моменту», tTravel = 10 с. ZSC сработал на t0 + 3 с (концевик стоит чуть раньше посадки клина): выход «закрывать» не снимается — клин дожимается до муфты, xClosed нет. Муфта так и не сработала: ровно на t0 + 10,0 с — FailToClose, выход снят; положение по ZSC видно в xClosed. Reset снимает отказ — далее состояние по концевикам (Closed). |
| `FB_Valve_Test` | `Valve_ReverseAfterEndStop_WaitsReversePause` | Motorized: ход на открытие дошёл до ZSO на t1 (выход «открывать» снят), сразу команда «закрыть»: выход «закрывать» не включается, пока от снятия «открывать» не прошла пауза tReverse = 1 с (на t1 + 0,9 с — ещё нет), ровно на t1 + 1,0 с — Closing. То же после стопа в ходе на закрытие (t2) и команды «открыть» через 0,2 с: «открывать» включается только на t2 + 1,0 с. Двигатель на выбеге встречным включением не реверсируется, даже если ход перед этим остановил концевик или стоп. |
| `FB_Valve_Test` | `Valve_CloseOnTorque_TorqueBeforeZsc_LatchesTorqueTrip` | Клиновая задвижка, закрытие «по моменту», ZSC подключён. Муфта закрытия сработала на t0 + 3 с, а ZSC — нет: ZSC настроен чуть раньше посадки клина (VLV-19), значит, это не посадка, а заклинивание или посторонний предмет — TorqueTrip, выход снят, xClosed нет. Тот же ход без ZSC (xZscUsed = FALSE): муфта — штатное окончание закрытия, Closed без отказа, и после того как муфта отпустила, задвижка остаётся Closed. |
| `FB_Valve_Test` | `Valve_PositionByTime_LostInLocal_AutoDrivesAgain` | Концевиков нет, Auto: открыта по времени хода (tTravel = 10 с, на t0 + 10,0 с — Open). Local: с места арматуру могут закрыть, положение «по времени» больше не известно — Unknown, xOpened нет, VLV_WRN_POSITION_UNKNOWN. Возврат в дистанционный режим (Auto, xAutoOpen): привод снова ведёт к цели — Opening, выход «открывать» на tTravel, ровно через 10,0 с — снова Open по времени. С устаревшим «Open» автоматика считала бы открытой задвижку, которую закрыли с места. |
| `FB_Valve_Test` | `Valve_SolenoidByTime_CoilOff_NotReportedOpen` | Соленоид НЗ (SolenoidEto, без тока закрыт) без концевиков, Manual: открыт по времени хода (tTravel = 2 с, катушка под током). Пропало напряжение: катушка без тока, клапан уходит на пружину — «открыто» снято (Unknown). Напряжение вернулось: Manual стоит (цель снята), катушка без тока, «открыто» не показывается. Снова открыт по времени; Local и возврат в Manual: клапан, закрывшийся на пружине в Local, сам не открывается — катушка без команды не включается. |
| `FB_Valve_Test` | `Valve_CloseOnTorqueNoZsc_TorqueMissing_SetsFailToClose` | Клиновая задвижка без ZSC (xZscUsed = FALSE), закрытие «по моменту», tTravel = 10 с. Муфта закрытия так и не сработала: на t0 + 9,9 с ещё Closing и выход «закрывать» держится, ровно на t0 + 10,0 с — FailToClose, выход снят, xClosed нет. Положения «закрыто по времени» у закрытия по моменту нет: его подтверждает только муфта. |
| `FB_Valve_Test` | `Valve_PermitCloseMissing_AutoWaitsReportsCloseBits` | Auto, задвижка открыта. Нет разрешения на закрытие (бит 1), а на открытие не хватает другого бита (бит 0). Автоматика просит «закрыть»: выход «закрывать» не включается, бит PERMIT_MISSING, в wPermitMissing — недостающие биты направления к цели (16#0002), а не открытия. Разрешение появилось — задвижка закрывается, wPermitMissing = 0. |
| `FB_Valve_Test` | `Valve_InterlockWithBothLimits_DrivesSafe` | Задвижка в Auto открыта по ZSO; замыкание в цепи ZSC — оба концевика дольше tLimitFilter, отказ BothLimits. Блокировка (положение безопасности Closed): привод исправен, отказал только контроль концевиков — задвижка закрывается (VLV-20), состояние Fault, биты INTERLOCKED и CLOSING. Концевикам верить нельзя, поэтому ход заканчивается по tTravel (60 с), а не по ZSC; дальше, пока блокировка держится, ход не повторяется; оба выхода никогда. |
| `FB_Valve_Test` | `Valve_InterlockAfterPositionLost_DrivesSafe` | Задвижка в Auto открыта по ZSO; ZSO пропал (обрыв) — через tLimitFilter зафиксирован PositionLost, выходов нет. Блокировка (Closed): задвижка закрывается (VLV-20); ход заканчивается по ZSC — он согласован (ZSO нет). Отказ держится до Reset; после Reset — Closed по концевикам, движения нет (уже в положении безопасности). |
| `FB_Valve_Test` | `Valve_InterlockWithExtFault_OutputsStayOff` | Авария привода (ExtFault: тепловое реле, обрыв фазы) — привод неисправен: блокировка выходы не включает (VLV-20), состояние Fault, бит INTERLOCKED показывает только действующую блокировку. |
| `FB_Valve_Test` | `Valve_OpenTorqueWhileUnseating_Ignored` | Клиновая задвижка, закрытие по моменту (xTorqueUsed, xCloseOnTorque), закрыта при ZSC. «Открыть»: при страгивании клина муфта открытия срабатывает, пока ZSC ещё замкнут, — это не заклинивание (VLV-21): ход продолжается, отказа нет. ZSC разомкнулся; ещё tLimitFilter (0,5 с) муфта не контролируется, затем муфта в ходе — TorqueTrip. |
| `FB_Valve_Test` | `Valve_OpenTorqueUnseatingNoZsc_TripsAfterBypass` | Закрытие по моменту без ZSC (xZscUsed = FALSE): задвижка закрыта по муфте. «Открыть»: муфта открытия держится — при страгивании с закрытого положения она не контролируется VLV_UNSEAT_BYPASS = 2 с от начала хода (VLV-21); держится дольше — клин не вышел из седла: TorqueTrip ровно через 2 с, выход снят. |
| `FB_Valve_Test` | `Valve_SolenoidWithZso_PowerLoss_NoPositionLostFault` | Соленоидный клапан НЗ (SolenoidEto) с ZSO и ZSC, открыт командой до ZSO. Пропало питание привода: катушка обесточена, клапан уходит на пружину — ZSO пропал, через 1 с ZSC. Отказа PositionLost нет: без напряжения уход с концевика не контролируется (VLV-08), состояние Closed. Питание вернулось — отказа нет, в Manual катушка не включается. |
| `FB_ControlValve_Test` | `ControlValve_ManualSetpoint_RateLimited` | Manual, рост 10 %/с, спад 20 %/с, шаг 0,1 с. Задание 0 -> 50 %: 10 % через 1 с, 49 % на 4,9 с, 50 % на 5,0 с (бит RAMPING снят); задание 50 -> 10 %: 30 % через 1 с, 10 % через 2 с. Задание оператора в Manual ФБ не переписывает. |
| `FB_ControlValve_Test` | `ControlValve_OutputLimits_Clamp` | Пределы 10…90 %: задание Manual 95 % — выход 90 % (бит LIMITED_MAX), 5 % — 10 % (LIMITED_MIN); в Auto 120 % — 90 %, 55 % — без ограничения. rPosSp_pct — задание после пределов. |
| `FB_ControlValve_Test` | `ControlValve_Invert_20mAAtZero` | Инверсия выхода: 0 % — 20 мА, 25 % — 16 мА, 100 % — 4 мА; без инверсии 25 % — 8 мА. Ток — и в выходе, и в Sts. |
| `FB_ControlValve_Test` | `ControlValve_TightShut_BelowThresholdGivesZero` | Плотное закрытие 5 %: задание 4 % — выход 0 % (бит TIGHT_SHUT, 4 мА), 6 % — 6 %. Рампа не залипает под порогом: рост 1 %/с, задание 20 %: на 4,5 с выход 0 % (рампа 4,5 %), на 5,0 с ещё 0 % (гистерезис 1 %, CV-13), на 6,0 с — 6 %, на 10 с — 10 %. |
| `FB_ControlValve_Test` | `ControlValve_Deviation_WarningAfterDelay` | ОС подключена, допуск 5 %, tDev = 30 с. Выход 50 %, ОС 40 %: до 29 с предупреждения нет, ровно на 30 с — CV_WRN_DEVIATION, NE 107 OutOfSpecification, тревога слота Deviation; отказа нет, выход не меняется, rDeviation_pct = 10 %. ОС 48 % — предупреждение снято, бит AT_SETPOINT. |
| `FB_ControlValve_Test` | `ControlValve_DeviationDuringRamp_Ignored` | Клапан не двигается (ОС 0 %), задание 0 -> 50 % с рампой 1 %/с (50 с): во время рампы рассогласование не контролируется. После конца рампы предупреждение — ровно через tDev = 10 с (на 9 с ещё нет). |
| `FB_ControlValve_Test` | `ControlValve_DeviationAsFault_GoesSafePosition` | Рассогласование — отказ (xDevIsFault), реакция SafePos (20 %), рампа 10 %/с, tDev = 5 с. Auto, выход 50 %, ОС 30 %: на 4 с отказа нет, на 5 с — CV_FLT_DEVIATION, Failure и сразу 20 % без рампы (бит SAFE_POS), xAutoActive = FALSE. Отказ фиксирован; Reset снимает, рампа к 50 % — от текущих 20 %. |
| `FB_ControlValve_Test` | `ControlValve_Interlock_SafePosBypassesRamp` | Блокировка (бит 2) при рампе 1 %/с: выход 60 % -> 10 % в том же вызове, мимо рампы и ниже rOutMin (20 %); биты SAFE_POS и INTERLOCKED, wInterlock, первопричина 2; xAutoActive = FALSE; задание Manual следит за принудительным выходом. После снятия — рампа от 10 %: 11 % через 1 с. |
| `FB_ControlValve_Test` | `ControlValve_Local_TracksFeedback` | Local (позиционер на месте): выход сразу следует ОС 37 % без рампы, задание Manual тоже; ОС недостоверна — удержание и CV_WRN_FB_INVALID; ОС 42 % — 42 %. Возврат в Manual — без рывка. |
| `FB_ControlValve_Test` | `ControlValve_AutoToManual_Bumpless` | Auto 70 %: задание Manual следит (70 %). Переход в Manual при задании автоматики 20 %: выход остаётся 70 %, xAutoActive = FALSE; задание оператора 60 % — рампа 5 %/с от 70 %: 65 % через 1 с. |
| `FB_ControlValve_Test` | `ControlValve_FbInvalid_MaintenanceRequiredKeepsControl` | ОС подключена, но недостоверна: CV_WRN_FB_INVALID, NE 107 MaintenanceRequired, тревога FbFailure; клапан управляется (30 % -> 60 %), xAutoActive и Available; рассогласование без ОС не контролируется дольше tDev. NaN при признаке «достоверна» — тоже отказ ОС. |
| `FB_ControlValve_Test` | `ControlValve_PositionerFault_SafePosAction` | Отказ позиционера, реакция SafePos (100 %, «открыть при отказе»), рампа 2 %/с: выход 40 % -> 100 % в том же вызове, CV_FLT_POSITIONER, Failure, SAFE_POS. Отказ не фиксируется: ушёл — wFault = 0, рампа к 40 % от 100 %: 98 % через 1 с. |
| `FB_ControlValve_Test` | `ControlValve_InvalidCfg_StartupSafePosition` | Корректной Cfg ещё не было (rOutMin >= rOutMax): CV_CFG_LIMITS, CheckFunction; выход — положение безопасности из поданной Cfg (30 %, 8,8 мА) и в Auto, xAutoActive = FALSE, задание Manual следит. Положение безопасности NaN — 0 % (4 мА), 150 % — ограничено 100 %. |
| `FB_ControlValve_Test` | `ControlValve_OutOfService_HoldsOutput` | OutOfService: выход удерживается (40 %), задание, блокировка и отказ позиционера не действуют, задание Manual следит за удерживаемым выходом, NE 107 CheckFunction. |
| `FB_ControlValve_Test` | `ControlValve_AutoSpNaN_HoldsWithWarning` | Задание автоматики не число (NaN из Modbus/ПИД): выход удерживается, CV_WRN_SP_INVALID; конечное задание — снова к нему, предупреждение снято. |
| `FB_ControlValve_Test` | `ControlValve_PositionerFault_HoldAction` | Отказ позиционера с реакцией Hold (по умолчанию): выход удерживается (40 %) при смене задания, бита SAFE_POS нет; отказ ушёл — выход к заданию 70 %. |
| `FB_ControlValve_Test` | `ControlValve_OosEntry_ClearsLatchedDeviation` | Зафиксированный отказ рассогласования снимается входом в OutOfService; после выхода в Manual отказа нет. |
| `FB_ControlValve_Test` | `ControlValve_DefaultCfg_PassesCheck` | Умолчания ST_ControlValveCfg проходят CheckConfig; тип ControlValve, слотов тревог 4, приоритеты по умолчанию (PositionerFault — Medium, InterlockAct — None); ток 4 мА при 0 %; Manual — xAutoActive нет. |
| `FB_ControlValve_Test` | `ControlValve_CfgChecks_SetBits` | Каждая проверка CheckConfig даёт свой бит wCfgErr: пределы (min < 0, max > 100, min >= max), скорость (< 0, NaN), положение безопасности вне 0…100, рассогласование при подключённой ОС (допуск 0, tDev = 0; без ОС не проверяется), плотное закрытие (< 0, >= rOutMax), реакция на отказ вне перечисления, приоритет тревоги. |
| `FB_ControlValve_Test` | `ControlValve_InvalidCfgAtRuntime_KeepsLastValid` | Cfg испорчена в работе (скорость < 0): бит CV_CFG_RATE и CheckFunction, рампа продолжается по последней корректной Cfg (10 %/с): 10 % через 1 с. |
| `FB_ControlValve_Test` | `ControlValve_Ramp_IndependentOfCycleTime` | Рампа 10 %/с за 2 с даёт одно и то же положение при шаге 10 мс (200 вызовов) и 100 мс (20 вызовов): скорость задана в %/с, шаг — фактический ltDt. |
| `FB_ControlValve_Test` | `ControlValve_LocalFeedbackOutOfRange_OutputClamped` | Local: выход следует ОС, но только в пределах хода 0…100 %. Датчик положения на закрытом клапане показывает чуть ниже нуля (-1,5 %, сигнал ещё достоверен): выход 0 % и 4,0 мА, а не 3,76 мА — ток ниже 4 мА позиционер с питанием от токовой петли может не держать (минимальный ток — по паспорту позиционера). ОС 102,5 % — выход 100 % и 20,0 мА, а не 20,4 мА. С инверсией: 100 % — 4,0 мА, -1,5 % — 20,0 мА. Возврат в Manual — без рывка от ограниченного выхода. |
| `FB_ControlValve_Test` | `ControlValve_DeviationFaultReset_StuckValveRetripsAfterTDev` | Рассогласование — отказ (xDevIsFault), реакция Hold, tDev = 5 с. Manual, задание 50 %, клапан заклинило на 30 %: на t0 + 5 с — CV_FLT_DEVIATION, выход удерживается (50 %), предупреждения рассогласования нет — это отказ. Reset при неснятой причине снимает отказ и начинает отсчёт tDev заново: на t1 + 4 с отказа нет, ровно на t1 + 5 с он возвращается. |
| `FB_ControlValve_Test` | `ControlValve_InterlockInManual_StaysAtSafePosition` | Manual, задание оператора 70 %. Блокировка: выход сразу в положение безопасности 15 %, задание Manual следит за ним (оператор не управляет выходом). Блокировка снята: Manual остаётся в 15 % — клапан сам к прежнему заданию оператора не уходит (CV-6, как у FB_Valve и двигателя). |
| `FB_ControlValve_Test` | `ControlValve_TightShutHysteresis_NoChatter` | Плотное закрытие 2 % с гистерезисом CV_TIGHT_HYST_PCT = 1 % (CV-13): задание 2,02 %, затем по кругу 1,98 / 2,02 % десять вызовов — выход один раз уходит в 0 % и дальше не дёргается; 2,99 % — ещё 0 %; 3,0 % — выход 3,0 %, бит TIGHT_SHUT снят. |
| `FB_ControlValve_Test` | `ControlValve_SlowRamp1msCycle_NotStalled` | Рампа 0,003 %/с при цикле 1 мс (CV-14): приращение за шаг 3·10⁻⁶ % меньше половины шага REAL рядом с 70 % (7,6·10⁻⁶ %) — в REAL рампа стояла бы на месте. Состояние рампы в LREAL: за 1 с (1000 шагов по 1 мс) выход 70,003 % — столько же, сколько при цикле 100 мс (10 шагов). источник: tools/reference/valve_reference.py, сценарий cv_slow_ramp. |
| `FB_ControlValve_Test` | `ControlValve_FbNaN_EventAndStsFinite` | ОС положения NaN при xPosFbValid = TRUE (мусор Modbus): тревога FbFailure; значение её события и stSts.rPosFb_pct конечны — 0.0 (R6: журнал и карта регистров NaN не получают), рассогласование 0, выход удерживается. |
| `FB_ControlValve_Test` | `ControlValve_InterlockFirstOut_KeptUntilResetOrOos` | Первопричина держится (CV-9): блокировка бит 2, затем добавился бит 0 (16#0005) — uiFirstOut = 2 не меняется. Reset снимает её; пока слово блокировок не 0, новой первопричины нет. Слово вернулось в 0, затем бит 1 — первопричина 1; вход в OutOfService её снимает. |
| `FB_Pid_Test` | `Pid_POnly_ErrorStep_OutputEqualsKpTimesError` | П-регулятор (Kp = 2, без I и D): после безударного перехода в Auto со смещением 40 % выход отличается от смещения ровно на Kp·e при ошибке +5 % и -3 %. |
| `FB_Pid_Test` | `Pid_Integral_ConstantError_RampRateKpOverTi` | ПИ-регулятор (Kp = 2, Ti = 10 с) при постоянной ошибке 4 %: выход растёт со скоростью Kp·e/Ti = 0,8 %/с, интегратор — на Kp·dt/Ti·e за шаг. |
| `FB_Pid_Test` | `Pid_DOnMeasurement_SetpointStep_NoDerivativeKick` | D по измерению (Kp = 1, Td = 5 с, N = 10, без I): ступень задания меняет выход только на P (D = 0, «удара» нет), ступень PV на 2 % даёт D = -Kp·Td/(Tf + dt)·2 %. |
| `FB_Pid_Test` | `Pid_DFilter_PvStep_DecaysWithTdOverN` | Фильтр Д (Td = 5 с, N = 10, Tf = 0,5 с, шаг 100 мс): после ступени PV составляющая D затухает множителем Tf/(Tf + dt) за шаг; через Tf от неё остаётся (5/6)^5, около 0,40. |
| `FB_Pid_Test` | `Pid_DirectAction_InvertsSign` | Прямое и обратное действие (Kp = 2, без I): при PV на 10 % выше задания обратное действие уменьшает выход на 20 %, прямое — увеличивает; знак ошибки в Sts — со знаком действия. |
| `FB_Pid_Test` | `Pid_OutputLimits_ClampAndFlags` | Пределы выхода 10…90 % (Kp = 2, без I): большая положительная ошибка — выход 90 % и xSatHigh (бит SAT_HIGH), большая отрицательная — 10 % и xSatLow (бит SAT_LOW). |
| `FB_Pid_Test` | `Pid_AntiWindup_LongSaturation_RecoversWithinTt` | Anti-windup обратным расчётом (Kp = 1, Ti = 10 с, Tt = авто = Ti): 60 с на верхнем пределе при ошибке +20 %, затем ошибка -20 %. С обратным расчётом интегратор ограничен (v ≈ 100 + Tt·Kp·e/Ti) и выход уходит с предела сразу; для сравнения тот же ФБ с Tt = 1·10^6 с (обратного расчёта практически нет) остаётся на пределе и через Tt после смены знака. |
| `FB_Pid_Test` | `Pid_AntiWindup_OutActFeedback_TracksExternalLimit` | Обратный расчёт по фактическому выходу (xUseOutAct): механизм не опускается ниже 30 % (минимум частоты ПЧ), rOutAct_pct = MAX(30, выход прошлого вызова). При ошибке -10 % 60 с выход ПИД держится у внешнего предела (около 30 - Tt·Kp·\|e\|/Ti = 20 %), а не уходит в 0; после смены знака ошибки механизм отвечает сразу. Без xUseOutAct ПИД уходит в 0 и после смены знака остаётся ниже 30 %. |
| `FB_Pid_Test` | `Pid_OutputRateLimit_IntegratorBacksOff` | Ограничение скорости выхода 5 %/с (Kp = 2, Ti = 10 с): после ступени задания на 10 % выход растёт ровно на 0,5 % за шаг 100 мс (бит OUT_RATE_LIMITED), а обратный расчёт по разности u - v сдерживает интегратор (без него было бы 40 + 2·10·2/10 = 44 % за 2 с). |
| `FB_Pid_Test` | `Pid_ManualToAuto_Bumpless` | Безударный переход Manual -> Auto (Kp = 2, Ti = 10 с, Td = 1 с): ошибка 3 % есть уже в Manual, интегратор предустановлен I = u - P - D = 35 - 6 - 0; в момент перехода выход равен ручному 35 %, дальше меняется только интегратором; Cmd следит за выходом в Auto. |
| `FB_Pid_Test` | `Pid_Track_PresetsIntegrator_BumplessRelease` | Слежение в Auto (Kp = 2, Ti = 10 с, нижний предел 10 %): выход = rTrack_pct без пределов (0 %), интегратор I = u - P - D, бит TRACKING, Cmd следит за выходом; после снятия xTrack выход продолжается с 25 % без рывка. Available = FALSE при слежении (PV годна, Auto), TRUE после снятия. |
| `FB_Pid_Test` | `Pid_SpExternal_TracksIntoCmd` | Внешнее задание: цель — rSpExt_eu (в пределах rSpMin_eu…rSpMax_eu), ФБ пишет её в stCmd.rSp_eu; после снятия xSpExt операторское задание продолжается с того же значения. |
| `FB_Pid_Test` | `Pid_SetpointRamp_RateLimited` | Рампа задания 2 инж. ед./с: ступень операторского задания 40 -> 60 проходится за 10 с; через 5 с действующее задание 50 и бит SP_RAMPING, через 10 с — 60 и бит снят; цель — сразу 60. |
| `FB_Pid_Test` | `Pid_RealDt_SameResultFor10msAnd100msSteps` | Расчёт по реальному dt (Kp = 2, Ti = 10 с, e = 4 %): за 5 с при вызовах раз в 10 мс и раз в 100 мс интегратор одинаков (30 + 2·4·5/10 = 34 %). Выход берёт интегратор прошлого шага, поэтому выходы различаются ровно на приращение одного шага: 0,008 и 0,08 %. |
| `FB_Pid_Test` | `Pid_Sample_ComputesOnlyEveryTSample` | Период расчёта tSample = 100 мс при вызовах раз в 10 мс: за 300 мс выход меняется ровно три раза (на расчётах), между ними держится; шаг расчёта в Sts — 100 мс. |
| `FB_Pid_Test` | `Pid_DtGap_SkipsIntegration` | Разрыв времени 5 с > tDtMax = 2 с (стоп ПЛК, отладка): шаг инициализации — выход прежний, интегратор не получает 5 с (без защиты было бы +4 %), бит DT_GAP и предупреждение PID_WRN_DT_GAP на один вызов; дальше интегрирование по обычному шагу. |
| `FB_Pid_Test` | `Pid_Deadband_NoActionInsideBand` | Зона нечувствительности 1 % (Kp = 2, Ti = 10 с): ошибка 0,8 % — e' = 0, выход и интегратор стоят 2 с, бит IN_DEADBAND; ошибка 1,5 % — e' = 0,5 %, выход +1 % без скачка на границе зоны. |
| `FB_Pid_Test` | `Pid_PvFail_HoldOutput_BumplessResume` | Отказ PV в Auto, реакция Hold (Kp = 2, Ti = 10 с): выход удерживается, интегратор заморожен, Failure, бит PID_FLT_PV_INVALID, бит PV_FAIL, тревога PvInvalid активна. PV вернулась с другой ошибкой (6 % вместо 4 %): шаг инициализации, выход продолжается с удержанного без рывка. |
| `FB_Pid_Test` | `Pid_PvFail_ShedToManual` | Отказ PV в Auto, реакция ShedToManual: ФБ переходит в Manual (и в stRetain) с текущим выходом, stCmd.rManualOut_pct уже равен выходу; в Manual отказ PV — не Failure. |
| `FB_Pid_Test` | `Pid_SetAutoWithInvalidPv_Rejected` | Запрос Auto при негодной PV (бит xSetAuto и RequestMode) отклоняется до ProcessMode: RejectedFault, бит снят, режим остаётся Manual, каждая команда даёт +1 к uiCmdSeq. |
| `FB_Pid_Test` | `Pid_Fopdt_ClosedLoop_MatchesPythonReference` | Замкнутый контур с моделью FOPDT (K = 2, T = 20 с, L = 4 с, шаг 0,1 с; параметры вымышленные): ПИД Kp = 1, Ti = 20 с, Td = 1 с, старт в Auto при y = 0, ступень задания 0 -> 40. Выход ПИД и PV в моменты 10, 30, 60, 120 с совпадают с эталоном до 1·10^-3; перерегулирование и время установления (полоса ±2 %) — тоже. |
| `FB_Pid_Test` | `Pid_InvalidCfg_StartupManualOutput` | Корректной Cfg ещё не было (rKp = 0): расчёта нет, выход = LIMIT(0, rManualOut_pct, 100), CheckFunction, бит PID_CFG_KP, Available = FALSE; запрос Auto — RejectedCfg; слежения в Cmd нет (значение оператора не переписывается). |
| `FB_Pid_Test` | `Pid_RetainAuto_RestoredOnRestart` | Старт ПЛК с режимом Auto в stRetain: ФБ стартует в Auto (хук в первом вызове), выход — из stCmd.rManualOut_pct (42 %), интегратор инициализирован шагом инициализации (бит DT_GAP первого вызова), дальше регулирование без рывка. |
| `FB_Pid_Test` | `Pid_OutOfService_HoldsOutput` | OutOfService: выход удерживается при любой PV, расчёта нет, Cmd следит за выходом, CheckFunction; выход в Auto — шаг инициализации без бита DT_GAP, регулирование продолжается с удержанного выхода без рывка. |
| `FB_Pid_Test` | `Pid_Fopdt_SaturatedStep_BackCalcLimitsOvershoot` | Насыщение в замкнутом контуре: тот же объект и ПИД, предел выхода 30 %, ступень задания 0 -> 40, 60 с. С обратным расчётом (Tt = авто) выход раньше уходит с предела и перерегулирования нет; без него (Tt = 1·10^6 с) интегратор накапливается, перерегулирование около 9 %. |
| `FB_Pid_Test` | `FopdtModel_OpenLoopStep_MatchesPythonReference` | Модель FOPDT без регулятора: ступень входа 10 % с t = 0; первые 40 шагов (L = 4 с) выход 0, на 41-м шаге 0,1 = dt/T·K·u, через 24 с — по эталону (около 20·(1 - e^-1)). |
| `FB_Pid_Test` | `Pid_TimeBackwards_InitStep_NoJump` | «Время назад» на 30 с (источник времени переставлен): LTIME без знака, разность не считается; шаг инициализации — выход прежний, бит DT_GAP; дальше интегрирование по обычному шагу. |
| `FB_Pid_Test` | `Pid_PvFail_SafeOut_DrivesSafeOutput` | Отказ PV в Auto, реакция SafeOut (rSafeOut_pct = 15 %): выход 15 % без рампы; после возврата PV регулирование продолжается с 15 % без рывка (шаг инициализации). |
| `FB_Pid_Test` | `Pid_SpTrackPv_ManualSetpoint_FollowsPv` | xSpTrackPv: в Manual задание следует за PV (ФБ пишет PV в stCmd.rSp_eu), поэтому переход в Auto идёт с нулевой ошибкой и выход не меняется. |
| `FB_Pid_Test` | `Pid_SetpointNaN_HoldsTarget_Warns` | Неконечное задание (NaN из Modbus или расчёта): цель остаётся прежней, предупреждение PID_WRN_SP_INVALID и общий бит DEV_STS_WARNING; конечное задание снимает предупреждение. |
| `FB_Pid_Test` | `Pid_DefaultCfg_PassesCheck` | Значения ST_PidCfg по умолчанию проходят CheckConfig (инвариант генератора iolistgen, контракт 2.3): wCfgErr = 0, бита CFG_ERROR нет, статус Good в Manual. |
| `FB_Pid_Test` | `Pid_FirstCall_ReportsDevTypeAndAlarmCount` | Первый вызов: тип устройства Pid в stSts.stCommon.eDevType, один слот тревог (PID_ALARM_COUNT), режим из stRetain (Manual по умолчанию), Local не поддерживается (RequestMode(Local) = FALSE). |
| `FB_Pid_Test` | `Pid_CfgChecks_SetDocumentedBits` | CheckConfig: каждая неверная группа параметров даёт свой бит wCfgErr (карта битов docs/fb/FB_PID.md); значения вне строгих перечислений — через объединение U_TestPidEnumInt, NaN — через U_RealBits. |
| `FB_Pid_Test` | `Pid_InvalidCfgAtRuntime_KeepsLastValidCfg` | Cfg испорчена в работе (rKp := -1): CheckFunction, бит PID_CFG_KP, режим Auto сохраняется, регулирование идёт по последней корректной копии (Kp = 2). |
| `FB_Pid_Test` | `Pid_PvInvalidAlarm_ActiveOnlyInAuto` | Тревога слота 0 PvInvalid: в Manual негодная PV тревоги не даёт; в Auto — ActiveUnack с номером udiAlarmIdBase + 0, квитирование — ActiveAck, возврат PV — Normal. |
| `FB_Pid_Test` | `Pid_Reset_AcceptedWithoutLatchedFaults` | Reset у ПИД (фиксируемых отказов нет): xReset и Reset() принимаются, каждая команда даёт +1 к uiCmdSeq, бит xReset сбрасывается (чек-лист устройства, пункт 2). |
| `FB_Pid_Test` | `Pid_TrackWithInvalidPv_NoFailure` | Слежение в Auto при негодной PV: ПИД не регулирует, поэтому не Failure и wFault = 0; выход — rTrack_pct; тревога PvInvalid по контракту (PV негодна в Auto) активна. |
| `FB_Pid_Test` | `Pid_AntiWindup_TtBelowDt_GainClampedToOne` | Постоянная слежения меньше шага (Tt = 0,05 с, dt = 0,1 с): множитель обратного расчёта MIN(dt/Tt, 1) = 1, и за один шаг насыщения интегратор садится ровно на v = u (I = 1 %), выход остаётся на пределе. Без MIN множитель был бы 2: I = -49 %, и на следующем шаге выход упал бы с предела до 51 % при той же ошибке +50 % — колебание обратного расчёта. |
| `FB_Pid_Test` | `Pid_Startup_OutActInitialisesOutput` | Старт ПЛК в Auto (режим из stRetain) с xUseOutAct: stCmd.rManualOut_pct = 0 (GVL_Hmi после потери питания не сохраняется), механизм стоит на 37 % — выход первого вызова берётся из rOutAct_pct, интегратор инициализируется под него (I = 37 - 8 = 29 %), и регулирование идёт от 37 % без провала в ноль. Второй экземпляр: rOutAct_pct не конечен — выход из rManualOut_pct. |
| `FB_Pid_Test` | `Pid_DtGap_BoundaryAtTDtMax` | Граница разрыва времени (tDtMax = 1 с): шаг ровно 1 с — обычный расчёт (dt = 1000 мс, интеграл +0,8 %, без DT_GAP), шаг 1,001 с — разрыв: шаг инициализации, выход прежний, интегратор предустановлен I := u - P (30,8 %), бит DT_GAP. Условие контракта — «dt > tDtMax». |
| `FB_Pid_Test` | `Pid_SetpointRamp_ResumesAfterPvFailure` | Рампа задания (2 инж. ед./с, 40 -> 60) и недостоверная PV: пока PV негодна, расчёта нет и действующее задание стоит (44); возврат PV — шаг инициализации с dt = 0, рампа продолжается с 44 (не прыгает к цели 60) и через 1 с даёт 46. Бит SP_RAMPING остаётся, пока задание не у цели. |
| `FB_Pid_Test` | `Pid_PvFail_ShedToManual_AlarmStaysActive` | Отказ PV в Auto с реакцией ShedToManual: ФБ сам уходит в Manual, и тревога PvInvalid всё равно появляется (ActiveUnack) и держится, пока PV негодна: оператор должен узнать, что контур переведён на ручное управление. Возврат PV снимает условие (RtnUnack), квитирование — Normal. Выход из OutOfService в Manual при негодной PV тревоги не даёт: Manual выбрал оператор. |
| `FB_Pid_Test` | `Pid_SetpointNaN_HeldTargetWithinSpLimits` | Неконечное задание держит прежнюю цель, но и она остаётся в пределах задания: задание NaN уже в первом вызове (связь со SCADA ещё не поднялась) даёт цель rSpMin_eu, а не 0 вне пределов; сужение пределов наладчиком, пока задание неконечно, ограничивает удерживаемую цель. |
| `FB_Pid_Test` | `Pid_Track_PvMoving_NoDerivativeKickAtRelease` | Слежение при движущейся PV и Td > 0: D работает и при слежении (за 2 с выходит на 5 %), а предустановка I := u - P - D держит v = u. Снятие слежения — выход 30 % плюс изменение P и D за один шаг, без «удара» на величину D. |
| `FB_Pid_Test` | `Pid_AntiWindup_OutActNaN_UsesOwnOutput` | xUseOutAct, а фактический выход не конечен (связь с ПЧ потеряна, в образе обмена NaN): обратный расчёт идёт по собственному выходу ФБ, NaN в интегратор не попадает. Без насыщения член u - v равен нулю — выход тот же, что в сценарии integral. |
| `FB_Pid_Test` | `Pid_SpTrackPv_InvalidPv_KeepsLastSetpoint` | Слежение задания за PV в Manual (xSpTrackPv) идёт только за годной PV: при обрыве датчика (AI держит 0 и снимает xValid) задание оператора и цель остаются последними годными, иначе после возврата в Auto регулятор погнал бы процесс к ложному значению. |
| `FB_Pid_Test` | `Pid_PvFail_ShedToManual_DeferredWhileTracking` | ShedToManual при слежении не выполняется: регулятор не управляет, выход задаёт механизм. Когда слежение снято, а PV всё ещё негодна, — переход в Manual с текущим (отслеженным) выходом. |
| `FB_Pid_Test` | `Pid_Track_NaNValue_HoldsOutput` | Слежение за неконечным значением (NaN из образа обмена): выход и слежение в Cmd остаются прежними, NaN на механизм не уходит; конечное значение снова принимается. |
| `FB_Pid_Test` | `Pid_CfgSpLimitsEqual_FixedSetpoint` | Равные пределы задания допустимы (бит 6 — только min > max): задание фиксировано, любое задание оператора ограничивается этим значением. |
| `FB_Pid_Test` | `Pid_PvNaN_TreatedAsInvalid` | PV не конечна при xPvValid = TRUE (P-04): в Auto это отказ PV — Failure, бит PV_FAIL, wFault, тревога; выход удерживается (Hold), NaN в расчёт не попадает. Годная PV — продолжение без рывка. |
| `FB_Pid_Test` | `Pid_SetAutoWithOosRequest_OneCommand` | Запрос Auto при негодной PV вместе со старшим запросом OutOfService в одном вызове (P-13): одна команда — результат старшего (Accepted), uiCmdSeq + 1, оба бита сброшены. |
| `FB_Pid_Test` | `Pid_Manual_OutputClampedToLimits` | Manual: выход оператора ограничивается rOutMin_pct…rOutMax_pct (таблица 17.5), флаги насыщения выставляются и на самих пределах; значение оператора в Cmd ФБ не переписывает. |
| `FB_Pid_Test` | `Pid_SameTimestamp_NoCalc_HoldsOutput` | Второй вызов в тот же момент (dt = 0; P-02): расчёта нет — выход и D прежние, хотя PV изменилась; следующий шаг учитывает изменение PV один раз. Расчёт с нулевым шагом дал бы всплеск D = Kp·Td/Tf·ΔPV = 10 %. |
| `FB_Pid_Test` | `Pid_PvNaN_EventAndStsFinite` | Auto, PV = NaN при xPvValid = TRUE (мусор Modbus): тревога PvInvalid; значение её события и stSts.rPv_eu конечны — 0.0 (R6), выход удерживается (Hold) и конечен. |
| `FB_Integration_Test` | `Device_DefaultCfg_PassesCheck` | Инвариант генератора (контракт 2.3, раздел 20): умолчания Cfg всех семи типов устройств проходят CheckConfig — после первого вызова wCfgErr = 0 и нет бита DEV_STS_CFG_ERROR (корректная Cfg принята как LKG). Каждый тип — настоящий ФБ, а не тестовое устройство (F-26). |
| `FB_Integration_Test` | `Device_DevType_ReportedInStsCommon` | Каждый тип пишет свой E_DeviceType в stSts.stCommon.eDevType с первого вызова (SCADA выбирает фейсплейт, генератор карты Modbus сверяет тип блока); до первого вызова — None. FB_MotorVfd сообщает MotorVfd, а не Motor: FB_Motor тип наследника не затирает и во втором вызове. |
| `FB_Integration_Test` | `Device_AllTypes_AlarmCountThroughIDevice` | Все семь типов доступны через I_Device (интерфейс станции и SCADA-адаптера): число слотов тревог AlarmCount (I_AlarmSource) после первого вызова равно <DEV>_ALARM_COUNT из GVL_Const, слот 0 доступен через GetAlarm, режим — из перечисления. У FB_Motor и FB_MotorVfd слотов одинаково (8). |
| `FB_Integration_Test` | `LevelLoop_AiPidVfd_TracksBumplessNoWindup` | Контур уровня КНС по примеру 17.3 контракта: LT (AI 4–20 мА, 0..10 м) -> LIC (ПИД Direct, Kp 2, Ti 20 с, xUseOutAct) -> ведущий насос (ПЧ, rSpeedMin 30 %); xTrack := NOT SpeedAutoActive, rTrack = rOutAct = SpeedRef с прошлого цикла. (1) Насос стоит в Auto — ПИД следит, выход = заданию ПЧ (0 %), Available = FALSE. (2) Пуск: Starting — ПИД ещё следит (30 % — предустановка ПЧ); Running — слежение снято, выход ПИД без рывка (30 %). (3) Уровень 4,8 м ниже задания 5 м 10 мин: ПИД просит меньше минимума, задание ПЧ держится на 30 %, выход ПИД по обратному расчёту от rOutAct не уходит в 0: 30 + P = 30 - 2·2 = 26 %. (4) Уровень 5,2 м — задание ПЧ сразу 34 % (30 + P), без задержки на «раскрутку» интегратора. |
| `FB_Integration_Test` | `LevelLoop_GuardBandCurrent_PidHoldsOutput` | Датчик уровня выдаёт ток отказа NAMUR, а канал AI читает 3,61 мА (защитная полоса NE 43, AI-13). ПИД (Reverse, Auto, задание 5 м, выход 40 %) работает tFailDelay = 2 с по значению насыщения, затем AI снимает xValid — ПИД фиксирует отказ PV и удерживает выход (Hold), а не уводит его к 100 % за минуту. |

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
| M10 | `wAlmShelved` без слотов в OutOfService | 2 теста | 2 теста (с 1.0.0 это нормативное поведение — F-32: OutOfService виден по `eMode`) |
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

## Мутационная проверка семейств и интеграции

Тесты каждого семейства проверены однострочными мутациями в копии рабочего дерева (по одной мутации на
прогон `cds.py test` в Control Win V3, затем откат; 16.10.2026). Выжившие мутации закрыты новыми тестами,
второй круг — после исправлений. Таблицы мутаций и тесты, которые их ловят, — в разделах «Тесты»
документов семейств: [FB_AnalogInput](fb/FB_AnalogInput.md) (и мутации дискретного входа —
[FB_DigitalInput](fb/FB_DigitalInput.md)), [FB_Motor](fb/FB_Motor.md) (вместе с `FB_MotorVfd`),
[FB_Valve](fb/FB_Valve.md), [FB_ControlValve](fb/FB_ControlValve.md), [FB_PID](fb/FB_PID.md).

Интеграция (I-04, I-05 в [ASSUMPTIONS.md](ASSUMPTIONS.md#решения-интеграции-этап-4)):

| Мутация | Итог | Какие тесты падают |
|---|---|---|
| `FB_MotorVfd`: `eDevType := E_DeviceType.Motor` вместо `MotorVfd` (19.10.2026) | поймана, 417 из 420 | `Device_DevType_ReportedInStsCommon` («MotorVfd, not Motor»), `MotorVfd_FirstCall_SetsTypeMotorVfdAndPassesDefaultCfg`, `MotorVfd_ImplementsIMotor_PolymorphicArray` |
| `F_RateLimit`: неконечная цель без проверки — результат NaN (16.10.2026) | поймана после правила NaN | `Util_RateLimit_NonFiniteTarget_HoldsCurrent` («NaN target: result finite»); прежний `AssertEquals_REAL` её пропускал ([TESTING.md](TESTING.md#ожидаемые-значения-и-эталоны)) |

## Ревью перед выпуском: находки и мутации

19.10.2026, три независимых ревью интегрированной библиотеки: стандарты (NAMUR NE 43, NE 107, ISA-18.2,
практика арматуры и ПИД), ПО (мутации и пробелы тестов), потребители (проекты 02 и 07). 25 находок. Каждая
проверена в этой рабочей копии: настоящая ошибка — тест, который падал до исправления, затем исправление;
пробел тестов — тест, который падает на мутанте ревью и зелёный на исправном коде. Решения —
[ASSUMPTIONS.md](ASSUMPTIONS.md) (I-10 и номера в таблице), изменения контракта —
[API.md, «Изменения по ревью перед выпуском»](API.md#изменения-по-ревью-перед-выпуском).

**Красный прогон** (CODESYS 3.5.17.30, Control Win V3, `cds.py test`): исходный код, все новые и расширенные
тесты и одновременно мутанты пробелов M1, M1b, M1c, M2, M2b, M3, M4, M5, M6, M7 (таблица ниже). 14 наборов,
451 тест: 419 пройдено, **32 упало** — ровно новые и расширенные тесты, каждый на исправляемом месте (тест
`Valve_InterlockWithExtFault_OutputsStayOff` — граничный, зелёный и до, и после). Существующие 419 тестов с
мутантами прошли — это и есть пробелы, найденные ревью. **Зелёный прогон** после исправлений, отката мутантов и
двух тестов `F_RateLimitLr`: 14 наборов, 453 теста, 453 пройдено.

| Находка | Важность | Итог | Изменение | Тесты (падали до исправления или на мутанте) |
|---|---|---|---|---|
| VLV-1 | major | исправлено | VLV-20: блокировка при одних отказах контроля ведёт задвижку в положение безопасности | `Valve_InterlockWithBothLimits_DrivesSafe`, `Valve_InterlockAfterPositionLost_DrivesSafe`; граничный `Valve_InterlockWithExtFault_OutputsStayOff` |
| VLV-2 | major | исправлено | VLV-21: муфта открытия при страгивании с седла не контролируется (ZSC + `tLimitFilter`, не дольше `VLV_UNSEAT_BYPASS`) | `Valve_OpenTorqueWhileUnseating_Ignored`, `Valve_OpenTorqueUnseatingNoZsc_TripsAfterBypass` |
| NE43-1 | major | исправлено | AI-13: значение в защитной полосе — насыщение NE 43, подтверждённый выход за диапазон — `xValid = FALSE` | `AnalogInput_GuardBandLow_InvalidAfterDelay`, `AnalogInput_GuardBandHigh_InvalidLimitsKept`, `LevelLoop_GuardBandCurrent_PidHoldsOutput` |
| NE107-1 | minor | исправлено | F-30: Local — NE 107 CheckFunction | `Device_LocalMode_Ne107CheckFunction` |
| CV-1 | minor | исправлено | CV-13: гистерезис плотного закрытия `CV_TIGHT_HYST_PCT` | `ControlValve_TightShutHysteresis_NoChatter` |
| ALM-1 | minor | исправлено | F-31: приоритет None у активной тревоги — событие `Disabled` | `Alarm_PriorityNoneWhileActive_EmitsClosingEvent` |
| ALM-2 | minor | исправлено | F-32: `wAlmShelved` — только Shelved, `wAlmSuppressed` (бывший `wReserve`) — SuppressedByDesign | `Device_ShelvedAndSuppressed_SeparateMasks` |
| R1 | major | исправлено | VFD-09: подхват — задание от фактической скорости, в Manual — и задание оператора | `MotorVfd_PlcRestart_RefBumpless` |
| R2 | major | пробел закрыт | — (код верен) | `Motor_TimeBackwardsDuringMinStop_PauseRestarts` (M1), `Motor_TimeBackwardsDuringMinRun_KeepsRunning` (M1b), `Motor_TimeBackwardsDuringResetPulse_PulseRestarts` (M1c) |
| R3 | major | пробел закрыт | — (код верен) | `MotorVfd_ImplementsIMotorVfd_LeadPumpProperties` расширен (M3), `LevelLoop_AiPidVfd_TracksBumplessNoWindup` (контур AI → ПИД → ПЧ по 17.3) |
| R4 | minor | исправлено | VFD-10: предустановка пуска ждёт связи | `MotorVfd_StartInCommGap_RefPresetToMin` |
| R5 | minor | исправлено | CV-14, VFD-13: состояние рамп в LREAL, функция `F_RateLimitLr` | `ControlValve_SlowRamp1msCycle_NotStalled`, `MotorVfd_SlowRamp1msCycle_NotStalled`; функция — `Util_RateLimitLr_*` |
| R6 | minor | исправлено | F-33: значения событий и Sts конечны | `Alarm_NonFiniteValue_EventValueFinite`, `Pid_PvNaN_EventAndStsFinite`, `ControlValve_FbNaN_EventAndStsFinite`, `MotorVfd_SpeedActNaN_StsFinite` |
| R7 | minor | пробел закрыт | — (код верен) | `Valve_SolenoidWithZso_PowerLoss_NoPositionLostFault` (M6) |
| R8 | minor | пробел закрыт | — (код верен) | `AnalogInput_SubstitutionUnlimited_NoTimeout` (M2), `DigitalInput_SubstitutionUnlimited_NoTimeout` (M2b) |
| R9 | minor | пробел закрыт | — (код верен) | `Pid_Track_PresetsIntegrator_BumplessRelease` расширен (M4) |
| R10 | minor | пробел закрыт | — (код верен) | `Device_OosRepeatWhileMovingInOos_Accepted` (M5) |
| R11 | minor | пробел закрыт | — (код верен) | `ControlValve_InterlockFirstOut_KeptUntilResetOrOos` (M7) |
| F1 | major | исправлено | VFD-11: устаревшая ОС (нет питания или отказ связи) — не работа: счётчики, `Running` стоят | `MotorVfd_CommLoss_CountersFrozen`, `MotorVfd_PowerLossCommLoss_NoFaultNotRunning` |
| F2 | major | исправлено | VFD-12: без питания и `VFD_POWER_UP_DELAY` после его возврата связь не контролируется | `MotorVfd_PowerLossCommLoss_NoFaultNotRunning` |
| F3 | major | исправлено в контракте | I-13: Pid — тип устройства iolistgen, данные приложения — `persist_extra`; изменения генератора — [CONSUMERS.md](CONSUMERS.md#iolistgen) | — (проект 07) |
| F4 | minor | исправлено | I-11: `docs/alarm_templates.csv` | `tools/project_checks/test_alarm_templates.py` |
| F5 | minor | исправлено | I-12: сверка объявлений ФБ, таблиц `docs/fb` и констант 5.1 с исходниками | `test_fb_declarations_match_api_doc`, `test_fb_io_tables_match_sources`, `test_non_mask_constants_in_api_doc_table` (`tools/project_checks/test_contract_doc.py`); эксперимент ревью (`xCommOk := FALSE`, `xPvValid` → `xPvGood`) теперь падает |

Мутанты пробелов (однострочные, применены вместе в красном прогоне, затем откатаны):

| № | Мутация | До (420 тестов) | После |
|---|---|---|---|
| M1 | `FB_Motor`: убрана проверка «время назад» отметки останова `ltStopMark` | выжила | `Motor_TimeBackwardsDuringMinStop_PauseRestarts` |
| M1b | `FB_Motor`: то же для `ltRunEntry` (`tMinRun` в Auto) | выжила | `Motor_TimeBackwardsDuringMinRun_KeepsRunning` |
| M1c | `FB_Motor`: то же для `ltResetMark` (импульс и окно Reset) | выжила | `Motor_TimeBackwardsDuringResetPulse_PulseRestarts` |
| M2 | `FB_AnalogInput`: подмена ограничена и при `tSubstMax = T#0S` | выжила | `AnalogInput_SubstitutionUnlimited_NoTimeout` |
| M2b | `FB_DigitalInput`: то же | выжила | `DigitalInput_SubstitutionUnlimited_NoTimeout` |
| M3 | `FB_MotorVfd`: `xSpeedAutoActive` без `eState = Running` | выжила | `MotorVfd_ImplementsIMotorVfd_LeadPumpProperties`, `LevelLoop_AiPidVfd_TracksBumplessNoWindup` |
| M4 | `FB_PID`: `xAvailableDev` без `NOT xTrack` | выжила | `Pid_Track_PresetsIntegrator_BumplessRelease` |
| M5 | `ProcessMode`: повтор OutOfService в OutOfService только при `xOosAllowed` | выжила | `Device_OosRepeatWhileMovingInOos_Accepted` |
| M6 | `FB_Valve`: контроль ухода с концевика без проверки напряжения | выжила | `Valve_SolenoidWithZso_PowerLoss_NoPositionLostFault` |
| M7 | `FB_ControlValve`: первопричина перезаписывается каждый цикл | выжила | `ControlValve_InterlockFirstOut_KeptUntilResetOrOos` |

Существующие тесты, поведение которых изменилось осознанно (новые ожидания вместо прежних):
`AnalogInput_At3p7mA_IsOutOfSpecification`, `AnalogInput_At20p7mA_IsOutOfSpecification` (AI-13),
`Alarm_PriorityNone_CancelsShelve` (F-31), `Device_AlarmSummary_WordsAndPrioUnack`,
`Device_AlarmsInOos_AllSlotsOutOfService`, `Device_OutOfServiceRetained_StartsInOos`,
`Device_StsHeader_AllFieldsFilled`, `DigitalInput_OutOfService_AlarmsOutOfService`,
`MotorVfd_CommLossInOos_NoFaultNoWarning` (F-32), `ControlValve_TightShut_BelowThresholdGivesZero` (CV-13),
`ControlValve_PositionerFault_SafePosAction` (эталон рампы в LREAL, CV-14), `Valve_OosEntry_ClearsLatchedFaults`
(муфта заводится после страгивания, VLV-21).

## Проверки без CODESYS

Итоги последнего локального прогона (Windows, 19.10.2026); в CI — те же команды.

| Проверка | Итог | Примечание |
|---|---|---|
| `ruff check`, `ruff format --check`, `mypy` | пройдено | ruff — 61 файл; mypy strict — 30 модулей |
| `pytest` | пройдено: 620 тестов | инструменты шаблона (в том числе интеграционные с настоящими `plc` и iec_checker) и `tools/project_checks/` (соглашения тестов, константы, маски, перечисления, DUT, интерфейсы, объявления ФБ, таблицы «Входы и выходы» `docs/fb` и константы `docs/API.md` против исходников, шаблоны текстов тревог) |
| `tools/check/st_lint.py --strict` | пройдено | 1332 файла, 0 замечаний; подавлений `lint:allow` нет |
| iec_checker 0.4 (`run_iec_checker.py`, `--tests`) | пройдено | `src/`: 80 объектов, ошибок разбора нет, необоснованных 0; с `tests/`: 116 объектов, необоснованных 0 — разбор в [STATIC_ANALYSIS.md](STATIC_ANALYSIS.md) |
| RuSTy 1.0.6 (`run_rusty.py`, необязательно) | пройдено: 0 ошибок | 117 файлов, исключённых нет; предупреждения E049, E067, E091, E040, E127 — [STATIC_ANALYSIS.md](STATIC_ANALYSIS.md#rusty-plc---check) |
| `tools/reference/*.py` (`common`, `ai_reference`, `motor`, `valve_reference`, `pid`) | пройдено | эталоны тестов; размеры Sts совпадают с таблицей 4.6 контракта |
