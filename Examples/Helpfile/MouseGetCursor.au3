sleep(2000)  ;allow time to move mouse before reporting ID

;create an array that tells us the meaning of an ID Number
$IDs = StringSplit("AppStarting|Arrow|Cross|Help|IBeam|Icon|No|" & _
"Size|SizeAll|SizeNESW|SizeNS|SizeNWSE|SizeWE|UpArrow|Wait", "|")
$IDs[0] = "Unknown"

$cursor = MouseGetCursor()
MsgBox(4096, "ID = " & $cursor, "Which means " & $IDs[$cursor])
