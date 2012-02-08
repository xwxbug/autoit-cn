; AutoITCOM 3.1.1
;
; Test file
;
; Stops and starts the 'Windows Update' service
;
;
; This requires Boolean support in AutoIt
;
;
; http://msdn.microsoft.com/library/en-us/shellcc/platform/shell/reference/objects/ishelldispatch2/ishelldispatch2.asp

; Open Windows Shell object
Local $oShell = ObjCreate("shell.application")


If $oShell.IsServiceRunning("wuauserv") Then

	$oShell.ServiceStop("wuauserv", False)

	MsgBox(0, "Service Stopped", "Service: automatic update services is now stopped")

	$oShell.ServiceStart("wuauserv", False)

	MsgBox(0, "Service Started", "Service: automatic update services is started again")

EndIf
