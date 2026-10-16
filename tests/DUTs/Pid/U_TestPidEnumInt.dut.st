// Назначение: значение вне строгих перечислений ПИД для тестов CheckConfig. Строгое перечисление
//             не даёт присвоить число в исходном тексте (C0358), а в памяти persistent оно может
//             быть любым: тест пишет iValue и читает поле перечисления. Только для тестов.
// Автор:      <ИМЯ ФАМИЛИЯ>
// Версия:     0.1.0
// Документ:   docs/fb/FB_PID.md, раздел «Тесты»
{attribute 'qualified_only'}
TYPE U_TestPidEnumInt :
UNION
    iValue    : INT;                 // число, которое пишет тест
    eAction   : E_PidAction;         // то же как действие
    ePvFail   : E_PidPvFailAction;   // то же как реакция на отказ PV
    ePriority : E_AlarmPriority;     // то же как приоритет тревоги
END_UNION
END_TYPE
