// Замкнутый контур с моделью FOPDT (K = 2, T = 20 с, L = 4 с, шаг 0,1 с; параметры вымышленные):
// ПИД Kp = 1, Ti = 20 с, Td = 1 с, старт в Auto при y = 0, ступень задания 0 -> 40. Выход ПИД и PV
// в моменты 10, 30, 60, 120 с совпадают с эталоном до 1·10^-3; перерегулирование и время
// установления (полоса ±2 %) — тоже.
METHOD PRIVATE FopdtClosedLoopMatchesPythonReference
VAR
    fbTime    : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid     : FB_PID;            // ФБ под тестом
    fbPlant   : FB_FopdtModel;     // модель объекта
    stCmd     : ST_PidCmd;         // команды
    stRetain  : ST_DeviceRetain;   // режим: Auto из Retain
    stCfg     : ST_PidCfg;         // конфигурация теста
    iStep     : INT;               // шаг модели (0,1 с)
    rPeak     : REAL;              // максимум PV
    rSettle_s : REAL;              // время установления, с
    rOut10    : REAL;              // выход и PV в 10, 30, 60 и 120 с
    rPv10     : REAL;
    rOut30    : REAL;
    rPv30     : REAL;
    rOut60    : REAL;
    rPv60     : REAL;
    rOut120   : REAL;
    rPv120    : REAL;
END_VAR
