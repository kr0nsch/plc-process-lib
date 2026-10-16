// Назначение: модель объекта «первый порядок + запаздывание» (FOPDT) для тестов ПИД в замкнутом
//             контуре: y[k+1] = y[k] + dt/T·(K·u[k - L/dt] - y[k]), шаг dt = 0,1 с, запаздывание
//             L = 4 с — кольцо на 40 отсчётов (контракт API.md, 22.5 и 23.1). Состояние — LREAL,
//             выход rY — REAL. Шаг модели — метод Step; тело пустое. Эталон —
//             tools/reference/pid.py, класс Fopdt. Параметры объекта вымышленные. Только для тестов.
// Автор:      <ИМЯ ФАМИЛИЯ>
// Версия:     0.1.0
// Документ:   docs/fb/FB_PID.md, раздел «Тесты»
FUNCTION_BLOCK FB_FopdtModel
VAR CONSTANT
    DT_S        : LREAL := 0.1;   // шаг модели, с
    RING_SIZE   : UINT := 40;     // длина кольца = запаздывание в шагах: L / dt = 4 с / 0,1 с
END_VAR
VAR_INPUT
    rU_pct : REAL;                // вход объекта (выход регулятора), %
    rGain  : REAL := 2.0;         // K, инж. ед. на %
    rT_s   : REAL := 20.0;        // T, с
END_VAR
VAR_OUTPUT
    rY : REAL;                    // выход объекта, инж. ед.
END_VAR
VAR
    arDelay : ARRAY[0..RING_SIZE - 1] OF REAL;   // кольцо запаздывания
    uiHead  : UINT;                   // самая старая запись кольца: u[k - 40]
    lrY     : LREAL;                  // состояние y
END_VAR
