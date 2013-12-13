#include <WinAPIDlg.au3>
#include <APIDlgConstants.au3>
#include <WinAPISys.au3>
#include <MsgBoxConstants.au3>

Global Const $InitDir = @ProgramFilesDir

Local $hBrowseProc = DllCallbackRegister('_BrowseProc', 'int', 'hwnd;uint;lparam;ptr')
Local $pBrowseProc = DllCallbackGetPtr($hBrowseProc)

Local $pText = _WinAPI_CreateString($InitDir)
Local $Path = _WinAPI_BrowseForFolderDlg(_WinAPI_PathStripToRoot($InitDir), 'Select a folder from the list below.', BitOR($BIF_RETURNONLYFSDIRS, $BIF_EDITBOX, $BIF_VALIDATE), $pBrowseProc, $pText)
_WinAPI_FreeMemory($pText)

If $Path Then
	ConsoleWrite('--------------------------------------------------' & @CRLF)
	ConsoleWrite($Path & @CRLF)
EndIf

DllCallbackFree($hBrowseProc)

Func _BrowseProc($hWnd, $iMsg, $wParam, $lParam)
	Local $Path

	Switch $iMsg
		Case $BFFM_INITIALIZED
			_WinAPI_SetWindowText($hWnd, 'MyTitle')
			_SendMessage($hWnd, $BFFM_SETSELECTIONW, 1, $lParam)
		Case $BFFM_SELCHANGED
			$Path = _WinAPI_ShellGetPathFromIDList($wParam)
			If Not @error Then
				ConsoleWrite($Path & @CRLF)
			EndIf
		Case $BFFM_VALIDATEFAILED
			MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', _WinAPI_GetString($wParam) & ' is invalid.', 0, $hWnd)
			Return 1
	EndSwitch
	Return 0
EndFunc   ;==>_BrowseProc
