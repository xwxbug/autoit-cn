#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $hDesktop, $hPrev, $tDesktop, $tProcess, $tStartup

; 获取当前桌面的句柄并新建名为"MyDesktop"的桌面
$hPrev = _WinAPI_GetThreadDesktop( _WinAPI_GetCurrentThreadID())
$hDesktop = _WinAPI_CreateDesktop('MyDesktop ', BitOR($DESKTOP_CREATEWINDOW, $DESKTOP_SWITCHDESKTOP))
If Not $hDesktop Then
	msgbox(16, 'Error ', 'Unable to create desktop.')
	Exit
EndIf

;切换到新建的桌面
_WinAPI_SwitchDesktop($hDesktop)

; 在"MyDesktop"上运行"calc.exe"直到用户关闭进程
$tProcess = DllStructCreate($tagPROCESS_INFORMATION)
$tStartup = DllStructCreate($tagSTARTUPINFO)
DllStructSetData($tStartup, 'Size ', DllStructGetSize($tStartup))
DllStructSetData($tStartup, 'Desktop ', _WinAPI_CreateString('MyDesktop ', $tDesktop))
If _WinAPI_CreateProcess('', @SystemDir & ' \calc.exe ', 0, 0, 0, $CREATE_NEW_PROCESS_GROUP, 0, 0, DllStructGetPtr($tStartup), DllStructGetPtr($tProcess)) Then
	ProcessWaitClose( DllStructGetData($tProcess, 'ProcessID'))
EndIf
;切换到原桌面并关闭"MyDesktop"
_WinAPI_SwitchDesktop($hPrev)
_WinAPI_CloseDesktop($hDesktop)

