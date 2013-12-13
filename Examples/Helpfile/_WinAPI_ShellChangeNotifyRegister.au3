#include <WinAPIShellEx.au3>
#include <APIShellExConstants.au3>
#include <WinAPI.au3>
#include <MsgBoxConstants.au3>

Opt('TrayAutoPause', 0)

Global Const $sPath = @TempDir & '\~TEST~'

DirCreate($sPath)
If Not FileExists($sPath) Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Unable to create folder.')
	Exit
EndIf

OnAutoItExitRegister('OnAutoItExit')

Local $hWnd = GUICreate('')
Local $iMsg = _WinAPI_RegisterWindowMessage('SHELLCHANGENOTIFY')
GUIRegisterMsg($iMsg, 'WM_SHELLCHANGENOTIFY')
Global $ID = _WinAPI_ShellChangeNotifyRegister($hWnd, $iMsg, $SHCNE_ALLEVENTS, BitOR($SHCNRF_INTERRUPTLEVEL, $SHCNRF_SHELLLEVEL, $SHCNRF_RECURSIVEINTERRUPT), $sPath, 1)
If @error Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Window does not registered.')
	Exit
EndIf

While 1
	Sleep(1000)
WEnd

Func WM_SHELLCHANGENOTIFY($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg

	Local $Path = _WinAPI_ShellGetPathFromIDList(DllStructGetData(DllStructCreate('dword Item1; dword Item2', $wParam), 'Item1'))
	If $Path Then
		ConsoleWrite('Event: 0x' & Hex($lParam) & ' | Path: ' & $Path & @CRLF)
	Else
		ConsoleWrite('Event: 0x' & Hex($lParam) & @CRLF)
	EndIf
EndFunc   ;==>WM_SHELLCHANGENOTIFY

Func OnAutoItExit()
	If $ID Then
		_WinAPI_ShellChangeNotifyDeregister($ID)
	EndIf
	DirRemove($sPath)
EndFunc   ;==>OnAutoItExit
