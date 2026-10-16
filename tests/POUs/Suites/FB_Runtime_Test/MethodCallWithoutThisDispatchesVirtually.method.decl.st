// Связывание вызовов (L6 контракта): метод базы вызывает переопределённый метод через THIS^ и без
// него; у экземпляра наследника оба вызова выполняют реализацию наследника, у экземпляра базы —
// базы.
METHOD PRIVATE MethodCallWithoutThisDispatchesVirtually
VAR
    fbBase    : FB_ProbeHookBase;      // экземпляр базы
    fbDerived : FB_ProbeHookDerived;   // экземпляр наследника
END_VAR
