#Include <APIConstants.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

Global Const $InitDir = @ProgramFilesDir

Global $hBrowseProc, $pBrowseProc, $tData, $Path

$hBrowseProc = DllCallbackRegister('_BrowseProc','int', 'hwnd;uint;long;ptr')
$pBrowseProc = DllCallbackGetPtr($hBrowseProc)

$Path = _WinAPI_BrowseForFolderDlg(StringLeft($InitDir, 3), 'Select a folder from the list below.', BitOR($BIF_RETURNONLYFSDIRS, $BIF_EDITBOX, $BIF_VALIDATE), $pBrowseProc, _WinAPI_CreateString($InitDir, $tData))
If $Path Then
	ConsoleWrite('--------------------------------------------------' & @CR)
	ConsoleWrite($Path & @CR)
EndIf

DllCallbackFree($hBrowseProc)

Func _BrowseProc($hWnd, $iMsg, $wParam, $lParam)
	Switch $iMsg
		Case $BFFM_INITIALIZED
			_WinAPI_SetWindowText($hWnd, 'Select Folder')
			_SendMessage($hWnd, $BFFM_SETSELECTIONW, 1, $lParam)
		Case $BFFM_SELCHANGED
			ConsoleWrite(_WinAPI_ShellGetPathFromIDList($wParam) & @CR)
		Case $BFFM_VALIDATEFAILED
			MsgBox(16, 'Error', _WinAPI_GetString($wParam) & ' is invalid.', 0, $hWnd)
			Return 1
	EndSwitch
    Return 0
EndFunc ;==> _BrowseProc
