; Example of using ACos with degrees.
#include <MsgBoxConstants.au3>
#include <Math.au3>

Local $y = _Degree(ACos(-1))

MsgBox($MB_SYSTEMMODAL, Default, "ACos(-1) = " & $y & " degrees")
