// Без источника (itfTime = 0) FB_Delay берёт встроенный FB_SystemTime: задержка 1 ч идёт и не
// истекает за время теста; нулевая задержка проходит сразу. Реального ожидания нет.
METHOD PRIVATE NoTimeSourceFallsBackToSystemTime
VAR
    fbDelay : FB_Delay;      // задержка 1 ч
    fbZero  : FB_Delay;      // нулевые задержки
END_VAR
