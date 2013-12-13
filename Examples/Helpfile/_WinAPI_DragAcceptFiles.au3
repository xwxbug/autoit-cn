#include <WinAPISys.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>

OnAutoItExitRegister('OnAutoItExit')

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 400)
Local $Check = GUICtrlCreateCheckbox('Enable Drag && Drop', 10, 370, 120, 19)
Local $Label = GUICtrlCreateLabel('', 100, 100, 200, 200)
Global $hLabel = GUICtrlGetHandle($Label)
GUICtrlSetBkColor(-1, 0xD3D8EF)
GUICtrlCreateLabel('Drop here', 175, 193, 50, 14)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

; Allow WM_DROPFILES to be received from lower privileged processes (Windows Vista or later)
#cs
If IsAdmin() Then
	_WinAPI_ChangeWindowMessageFilterEx($hLabel, $WM_COPYGLOBALDATA, $MSGFLT_ALLOW)
	_WinAPI_ChangeWindowMessageFilterEx($hLabel, $WM_DROPFILES, $MSGFLT_ALLOW)
EndIf
#ce

; Register label window proc
Global $hDll = DllCallbackRegister('_WinProc', 'ptr', 'hwnd;uint;wparam;lparam')
Global $pDll = DllCallbackGetPtr($hDll)
Global $hProc = _WinAPI_SetWindowLong($hLabel, $GWL_WNDPROC, $pDll)

GUISetState()

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $Check
			_WinAPI_DragAcceptFiles($hLabel, GUICtrlRead($Check) = $GUI_CHECKED)
	EndSwitch
WEnd

Func _WinProc($hWnd, $iMsg, $wParam, $lParam)
	Switch $iMsg
		Case $WM_DROPFILES
			Local $FileList = _WinAPI_DragQueryFileEx($wParam)
			If Not @error Then
				ConsoleWrite('--------------------------------------------------' & @CRLF)
				For $i = 1 To $FileList[0]
					ConsoleWrite($FileList[$i] & @CRLF)
				Next
			EndIf
			_WinAPI_DragFinish($wParam)
			Return 0
	EndSwitch
	Return _WinAPI_CallWindowProc($hProc, $hWnd, $iMsg, $wParam, $lParam)
EndFunc   ;==>_WinProc

Func OnAutoItExit()
	_WinAPI_SetWindowLong($hLabel, $GWL_WNDPROC, $hProc)
	DllCallbackFree($hDll)
EndFunc   ;==>OnAutoItExit
