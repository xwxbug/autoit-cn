#include <GuiConstantsEx.au3>
#include <WinApiEx.au3>
#include <WindowsConstants.au3>

Opt('MustDeclareVars ', 1)


If Not _WinAPI_DwmIsCompositionEnabled() Then
	MsgBox(16, 'Error ', 'Require Windows Vista or above with enabled Aero theme.')
	Exit
EndIf

Global $hWnd, $iMemo

_Main()

Func _Main()
	Local $hGUI, $Pos

	; 创建界面
	$hGUI = GUICreate(" DWM Attribute ", 400, 300)

	; 创建memo控件
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New ")
	GUISetState()

	Run(@SystemDir & ' \calc.exe')
	$hWnd = WinWaitActive('计算器 ', '', 3)
	If Not $hWnd Then
		Exit
	EndIf

	$Pos = _WinAPI_GetPosFromRect( _WinAPI_DwmGetWindowAttribute($hWnd, $$DWMWA_EXTENDED_FRAME_BOUNDS)

	MemoWrite('left:' & $Pos[0] & @CR)
	MemoWrite('Right:' & $Pos[1] & @CR)
	MemoWrite('Width:' & $Pos[2] & @CR)
	MemoWrite('Height:' & $Pos[3] & @CR)

	Do
	Until GUIGetMsg() = -3
endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

