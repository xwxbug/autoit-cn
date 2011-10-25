#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $PID = ProcessExists('Explorer.exe')

If $PID > 0 Then
	msgbox(0, 'Proc Name ', _WinAPI_GetProcessFileName($ID))
EndIf

