Example()

Func Example()
	Local $iValue = 0
	Local $sBlank = "Test"

	Select
		Case $iValue = 1
			MsgBox(4096, "", "The first expression was True.")
		Case $sBlank = "Test"
			MsgBox(4096, "", "The second expression was True")
		Case Else ; If nothing matches then execute the following.
			MsgBox(4096, "", "No preceding case was True.")
	EndSelect
EndFunc   ;==>Example
