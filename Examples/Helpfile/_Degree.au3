#include <Math.au3>

Local $radians = 3.14159265358979
Local $degrees = _Degree($radians)

MsgBox(4096, "Radians to Degrees", $radians & " radians = " & $degrees & " degrees")
