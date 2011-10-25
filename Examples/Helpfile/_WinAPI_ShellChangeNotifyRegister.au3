
出于性能原因, 多个通知可被结合为一个通知. 如, 如果同一文件夹中的文件创建大量$SHCNE_UPDATEITEM通知, 可被结合为单一的$SHCNE_UPDATEDIR通知.

参考 搜索MSDN知识库中SHChangeNotifyRegister的相关信息

示例
#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)
Opt('TrayAutoPause ', 0)

Global $hWnd, $iMsg, $ID
Global Const $sPath = @ScriptDir & ' \~TEST~ '

DirCreate($sPath)
If Not FileExists($sPath) Then
	MsgBox(16, 'Error ', 'Unable to create folder.')
	Exit
EndIf

OnAutoItExitRegister('OnAutoItExit')

$hWnd = GUICreate('')
$iMsg = _WinAPI_RegisterWindowMessage('SHELLCHANGENOTIFY')
GUIRegisterMsg($iMsg, '_ShellChangeNotifyProc')
$ID = _WinAPI_ShellChangeNotifyRegister($hWnd, $iMsg, $SHCNE_ALLEVENTS, BitOR($SHCNRF_INTERRUPTLEVEL, $SHCNRF_SHELLLEVEL, $SHCNRF_RECURSIVEINTERRUPT), $sPath, 1)
If @error Then
	MsgBox(16, 'Error ', 'Window does not registered.')
	Exit
EndIf

While 1
	Sleep(1000)
WEnd

Func _ShellChangeNotifyProc($hWnd, $iMsg, $wParam, $lParam)

	Local $tData = DllStructCreate('dword Item1; dword Item2 ', $wParam)

	MsgBox(32, 'Info ', 'Event: 0x' & Hex($lParam) & '  Path:' & _WinAPI_ShellGetPathFromIDList( DllStructGetData($tData, 'Item1')) & @CR)
endfunc   ;==>_ShellChangeNotifyProc

Func OnAutoItExit()
	_WinAPI_ShellChangeNotifyDeregister($ID)
	;	DirRemove($sPath)
endfunc   ;==>OnAutoItExit

