If Not IsDeclared("Var") Then
	MsgBox(4096, "", "$Var is NOT declared") ; If $Var has not been declared then display the message box.
EndIf

Local $Var = 1 ; Declare the variable $Var.

If IsDeclared("Var") Then
	MsgBox(4096, "", "$Var IS declared") ; If $Var is declared then display the message box.
EndIf
