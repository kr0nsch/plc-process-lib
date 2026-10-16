// 1. До тела FB_TestDevice: точка расширения
uiExtBodyCalls := uiExtBodyCalls + 1;
xFaultAdd := xExtFault;
// 2. Тело FB_TestDevice над теми же структурами: все VAR_IN_OUT явно (SUPER^(); — ошибка C0039)
SUPER^(stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
// 3. После тела: наследник пишет унаследованный VAR_IN_OUT — номер команды, который видит вызывающий
stCmd.uiTrace := stSts.stCommon.uiCmdSeq;
