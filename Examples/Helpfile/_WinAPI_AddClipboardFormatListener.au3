#include <WinAPISys.au3>
#include <WindowsConstants.au3>
#include <Clipboard.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

If _WinAPI_GetVersion() < '6.0' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later.')
	Exit
EndIf

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 400, 10, 10, BitOR($GUI_SS_DEFAULT_GUI, $WS_MAXIMIZEBOX, $WS_SIZEBOX), $WS_EX_TOPMOST)
Global $Edit = GUICtrlCreateEdit('', 0, 0, 400, 400, BitOR($GUI_SS_DEFAULT_EDIT, $ES_READONLY))
GUIRegisterMsg($WM_CLIPBOARDUPDATE, 'WM_CLIPBOARDUPDATE')
GUISetState()

_WinAPI_AddClipboardFormatListener($hForm) ; JPM:	Not really demonstrating as the result is the same without
_SendMessage($hForm, $WM_CLIPBOARDUPDATE)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func WM_CLIPBOARDUPDATE($hWnd, $Msg, $wParam, $lParam)
	#forceref $hWnd, $Msg, $wParam, $lParam

	_ClipBoard_Open(0)
	GUICtrlSetData($Edit, _ClipBoard_GetData($CF_TEXT))
	_ClipBoard_Close()
	Return 0
EndFunc   ;==>WM_CLIPBOARDUPDATE
