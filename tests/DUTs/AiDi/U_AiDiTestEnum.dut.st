// Назначение: значения вне строгих перечислений аналогового и дискретного входа для тестов
//             CheckConfig: строгое перечисление не даёт присвоить число в исходном тексте (C0358),
//             а в памяти persistent оно может быть любым — тест пишет iValue и читает поле
//             перечисления. Только для тестов.
// Автор:      kr0nsch
// Версия:     0.1.0
// Документ:   docs/fb/FB_AnalogInput.md
{attribute 'qualified_only'}
TYPE U_AiDiTestEnum :
UNION
    iValue       : INT;             // число, которое пишет тест
    eInput       : E_AiInputType;   // то же как тип входа AI
    eAiFailValue : E_AiFailValue;   // то же как значение AI при отказе
    eDiFailValue : E_DiFailValue;   // то же как значение DI при отказе канала
END_UNION
END_TYPE
