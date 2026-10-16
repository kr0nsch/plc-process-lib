// Хук смены режима: сначала база (SUPER^), затем запись вызова для тестов, безударность
// Auto → Manual (ручная защёлка := текущий выход) и снятие зафиксированного отказа при входе в
// OutOfService. VAR_IN_OUT устройства не трогает (R2)
METHOD PROTECTED OnModeChanged
VAR_INPUT
    eOld : E_DeviceMode;   // режим до смены
    eNew : E_DeviceMode;   // новый режим
END_VAR
