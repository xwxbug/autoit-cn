; AutoIt 3.1.1.x beta
;
; COM Test File
;
; Testing Error Event handling by creating a WMI exception

Local $MyCompName = @ComputerName

; Initialize my error handler
Global $g_nComError, $oMyError = ObjEvent("AutoIt.Error", "MyErrFunc")

; Open WMI
Local $oWMIservice = ObjGet("winmgmts:\\" & $MyCompName & "\root\cimv2")

; Check is WMI opened successfully
If @error Then
	MsgBox(0, "AutoItCOM Test", "Error getting object $oWMIservice. Error code: " & @error)
	Exit
EndIf

; Try a query
Local $ColProcessors = $oWMIservice.ExecQuery("Select * from Win32_Processor")


; THIS line should deliberately fail!
Local $item1 = $ColProcessors.item(1)

If $g_nComError Then
	MsgBox(0, "AutoItCOM test", "Test passed: We got an error number: 0x" & Hex($g_nComError))
Else
	MsgBox(0, "AutoItCOM test", "Test failed!")
EndIf

Exit



; This is my custom error handler
Func MyErrFunc()

	Local $HexNumber = Hex($oMyError.number, 8)

	MsgBox(0, "AutoItCOM Test", "We intercepted a COM Error !" & @CRLF & @CRLF & _
			"err.description is: " & @TAB & $oMyError.description & @CRLF & _
			"err.windescription:" & @TAB & $oMyError.windescription & @CRLF & _
			"err.number is: " & @TAB & $HexNumber & @CRLF & _
			"err.lastdllerror is: " & @TAB & $oMyError.lastdllerror & @CRLF & _
			"err.scriptline is: " & @TAB & $oMyError.scriptline & @CRLF & _
			"err.source is: " & @TAB & $oMyError.source & @CRLF & _
			"err.helpfile is: " & @TAB & $oMyError.helpfile & @CRLF & _
			"err.helpcontext is: " & @TAB & $oMyError.helpcontext _
			)

	$g_nComError = $oMyError.number
EndFunc   ;==>MyErrFunc
