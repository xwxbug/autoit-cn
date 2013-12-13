#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Initialize the variale $sString with data
	Local $sString = "This is a string"
	#forceref $sString

	; Find the value of the variable string sString and assign to the variable $sEvalString.
	Local $sEvalString = Eval("sString")

	; Display the value of $sEvalString. This should be the same value as $sString.
	MsgBox($MB_SYSTEMMODAL, "", $sEvalString)
EndFunc   ;==>Example
