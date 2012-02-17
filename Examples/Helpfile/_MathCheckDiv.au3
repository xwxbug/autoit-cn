#include <Math.au3>

Local $I_Var = InputBox('Odd or Even', 'Enter a number:')
Local $I_Result = _MathCheckDiv($I_Var, 2)
If $I_Result = -1 Or @error = 1 Then
	MsgBox(4096, '', 'You did not enter a valid number')
ElseIf $I_Result = 1 Then
	MsgBox(4096, '', 'Number is odd')
ElseIf $I_Result = 2 Then
	MsgBox(4096, '', 'Number is even')
Else
	MsgBox(4096, '', 'Could not parse $I_Result')
EndIf
