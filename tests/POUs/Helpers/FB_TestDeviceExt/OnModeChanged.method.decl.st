// Хук второго уровня: сначала FB_TestDevice (SUPER^), затем своя часть (цифра 2 в udiHookTrace)
METHOD PROTECTED OnModeChanged
VAR_INPUT
    eOld : E_DeviceMode;   // режим до смены
    eNew : E_DeviceMode;   // новый режим
END_VAR
