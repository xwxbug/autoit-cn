#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

If _WinAPI_GetVersion() Then
	msgbox(16, 'Error ', 'Require Windows Vista or later.')
	Exit
EndIf

If _WinAPI_IsInternetConnected() Then
	msgbox(0, 'info ', 'Internet is already connected.')
	Exit
EndIf

; 通过调用获取连接向导启用网络连接
_WinAPI_GetConnectedDlg(1, 1 + 4)

