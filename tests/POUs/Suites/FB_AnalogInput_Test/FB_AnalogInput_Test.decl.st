// Назначение: набор тестов coUnit для FB_AnalogInput: масштабирование по типам входа, NAMUR NE 43
//             (границы, подтверждение отказа и возврата, удержание значения), корень и отсечка,
//             ограничение шкалой, фильтр по реальному шагу времени, уставки HH/H/L/LL, подмена и её
//             срок, OutOfService, конфигурация (LKG, биты wCfgErr), тревоги слотов. Время — только
//             FB_FakeTime; эталоны — tools/reference/ai_reference.py.
// Автор:      kr0nsch
// Версия:     0.1.0
// Документ:   docs/fb/FB_AnalogInput.md
FUNCTION_BLOCK FB_AnalogInput_Test EXTENDS coUnit.FB_TestSuite
