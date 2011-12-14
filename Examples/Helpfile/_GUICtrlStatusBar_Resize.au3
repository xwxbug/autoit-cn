#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <WindowsConstants.au3>

$Debug_SB = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

Global $hStatus

_Main()

Func _Main()

	Local $hGUI
	Local $aParts[3] = [75, 150, -1]

	; 创建 GUI
	$hGUI = GUICreate("StatusBar Resize", 400, 300, -1, -1, $WS_SIZEBOX)

	$hStatus = _GUICtrlStatusBar_Create($hGUI)
	_GUICtrlStatusBar_SetParts($hStatus, $aParts)
	GUISetState()

	GUIRegisterMsg($WM_SIZE, "WM_SIZE")

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main

; 当 GUI 大小改变时重设状态栏大小
Func WM_SIZE($hWnd, $iMsg, $iwParam, $ilParam)
	#forceref $hWnd, $iMsg, $iwParam, $ilParam
	_GUICtrlStatusBar_Resize($hStatus)
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_SIZE
