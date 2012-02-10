Sleep(1000) ; Allow time for the cursor to change its state.

; Create an array of possible cursor states using StringSplit.
Local $aArray = StringSplit("Unknown|AppStarting|Arrow|Cross|Help|IBeam|Icon|No|" & _
		"Size|SizeAll|SizeNESW|SizeNS|SizeNWSE|SizeWE|UpArrow|Wait|Hand", "|", 2) ; The flag parameter is set to flag = 2 as we don't require the total count of the array.
#cs
	The array returned will contain the following values:
	$aArray[0] = "Unknown"
	$aArray[1] = "AppStarting"
	$aArray[2] = "Arrow"
	...
	$aArray[16] = "Hand"
#ce

Local $iCursor = MouseGetCursor()
MsgBox(4096, "CursorID = " & $iCursor, "Which means " & $aArray[$iCursor] & ".") ; Use the CursorID value as the index value of the array
