; Example of using ASin with degrees
#include <MsgBoxConstants.au3>
#include <Math.au3>

Local $x = _Degree(ASin(0.5))

MsgBox($MB_SYSTEMMODAL, Default, "ASin(0.5) = " & $x & " degrees")
