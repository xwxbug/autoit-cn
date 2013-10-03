#include <Constants.au3>

; AutoItCOM 3.1.0
;
; Test File
;
; Returns processor information

Local $MyCompName = @ComputerName

Local $oWMIservice = ObjGet("winmgmts:\\" & $MyCompName & "\root\cimv2")

If @error Then
	MsgBox($MB_SYSTEMMODAL, "", "error getting object. Error code: " & @error)
EndIf

Local $ColProcessors = $oWMIservice.ExecQuery("Select * from Win32_Processor")

Local $Counter = 1

For $Processor In $ColProcessors

	MsgBox($MB_SYSTEMMODAL, "WMI Test", "Processor " & $Counter & @CRLF & "Id: " & $Processor.processorid & @CRLF & _
			"Maximum Clock Speed: " & $Processor.MaxClockSpeed)
	$Counter = $Counter + 1

Next
