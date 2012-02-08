; WMI example to enumerate services

Local $ObjWMI = ObjGet("winmgmts://" & @ComputerName)

Local $string = ""
For $item In $ObjWMI.ExecQuery("select * from win32_service")
	$string = $string & $item.name & @TAB
Next

MsgBox(0, "", "Services on this computer: " & @CRLF & $string)
