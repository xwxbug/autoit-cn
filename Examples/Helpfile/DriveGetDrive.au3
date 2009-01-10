$var = DriveGetDrive( "all" )
If NOT @error Then
	MsgBox(4096,"", "找到 " & $var[0] & " 个驱动器")
	For $i = 1 to $var[0]
		MsgBox(4096,"驱动器 " & $i, $var[$i])
	Next
EndIf
