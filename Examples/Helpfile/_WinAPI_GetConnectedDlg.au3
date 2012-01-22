#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

If _WinAPI_GetVersion() < '6.0' Then
	MsgBox(16, 'Error', 'Require Windows Vista or later.')
	Exit
EndIf

If _WinAPI_IsInternetConnected() Then
	ConsoleWrite('Internet is already connected.' & @CR)
	Exit
EndIf

; 在调用的应用程序中运行获取连接向导来启用因特网连接
_WinAPI_GetConnectedDlg(1, 1 + 4)
