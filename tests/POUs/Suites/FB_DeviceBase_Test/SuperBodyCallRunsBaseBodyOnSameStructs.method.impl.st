coUnit.TEST('Device_SuperBodyCall_RunsBaseBodyOnSameStructs');

stCfg.rGain := 3.0;
stCmd.stCommon.xSetAuto := TRUE;
fbExt(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_UINT(Expected := 1, Actual := fbExt.uiExtBodyCalls, Message := 'derived body ran once');
AssertEquals_UINT(Expected := 1, Actual := fbExt.uiBodyCalls, Message := 'base body ran once via SUPER^');
AssertFalse(Condition := stCmd.stCommon.xSetAuto, Message := 'pulse cleared in the caller structure');
AssertTrue(Condition := stRetain.eRemoteMode = E_DeviceMode.Auto, Message := 'base body wrote the caller retain');
AssertEquals_REAL(Expected := 30.0, Actual := fbExt.rOut_eu, Delta := 0.0, Message := 'base body read the caller cfg');
AssertEquals_UINT(Expected := 1, Actual := stCmd.uiTrace,
                  Message := 'derived write after SUPER^ visible to the caller');
fbExt(xExtFault := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbExt.Fault, Message := 'extension point written before SUPER^ is used by the base body');
stCmd2.stCommon.xSetManual := TRUE;
fbExt(xExtFault := FALSE, itfTime := fbTime, stCmd := stCmd2, stRetain := stRetain2, stCfg := stCfg);
AssertFalse(Condition := stCmd2.stCommon.xSetManual, Message := 'second structure set: pulse cleared there');
AssertTrue(Condition := stRetain2.eRemoteMode = E_DeviceMode.Manual, Message := 'second retain written');
AssertTrue(Condition := stRetain.eRemoteMode = E_DeviceMode.Auto, Message := 'first retain untouched');
AssertEquals_UINT(Expected := 2, Actual := stCmd2.uiTrace,
                  Message := 'trace written into the second command structure');
AssertEquals_UINT(Expected := 3, Actual := fbExt.uiBodyCalls, Message := 'base body once per call');

coUnit.TEST_FINISHED();
