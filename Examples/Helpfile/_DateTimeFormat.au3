#include <Date.au3>

; 使用 pc 格式显示当前日期/时间
MsgBox(4096, "Pc Long format", _DateTimeFormat(_NowCalc(), 1))
MsgBox(4096, "Pc Short format", _DateTimeFormat(_NowCalc(), 2))
