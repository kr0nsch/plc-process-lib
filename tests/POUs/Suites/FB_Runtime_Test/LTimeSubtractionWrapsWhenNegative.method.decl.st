// L7 контракта: LTIME без знака — разность a - b при a < b не отрицательна, а переполняется по
// модулю 2^64 (огромное значение больше a), поэтому библиотека сравнивает отметки до вычитания.
METHOD PRIVATE LTimeSubtractionWrapsWhenNegative
VAR
    ltA : LTIME := LTIME#1S;   // меньшая отметка
    ltB : LTIME := LTIME#2S;   // большая отметка
    ltD : LTIME;               // a - b
END_VAR
