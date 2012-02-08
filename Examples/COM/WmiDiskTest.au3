; AutoItCOM 3.1.0
;
; Test File
;
; Use WMI to collect logical drive information


Local $objcol = ObjGet("winmgmts:")

Local $instance = $objcol.instancesof("Win32_LogicalDisk")

If @error Then
	MsgBox(0, "", "error getting object. Error code: " & @error)
	Exit
EndIf

Local $string = "size:" & @TAB & "driveletter:" & @CRLF

For $Drive In $instance
	$string = $string & $Drive.size & @TAB & $Drive.deviceid & @CRLF
Next

MsgBox(0, "Drive test", "Drive information: " & @CRLF & $string)
