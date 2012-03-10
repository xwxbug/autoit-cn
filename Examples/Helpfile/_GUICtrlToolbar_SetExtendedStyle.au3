#include <GuiToolbar.au3>
#include <GuiMenu.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Constants.au3>

$Debug_TB = False ; 检查传递给函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作
Global $hGUI, $iMemo

_Main()

Func _Main()
	Local $hToolbar
	Local Enum $idNew = 1000, $idOpen, $idSave, $idHelp

	; 创建 GUI
	$hGUI = GUICreate("Toolbar", 400, 300)
	$hToolbar = _GUICtrlToolbar_Create($hGUI)
	_GUICtrlToolbar_SetExtendedStyle($hToolbar, $TBSTYLE_EX_DRAWDDARROWS)
	$iMemo = GUICtrlCreateEdit("", 2, 36, 396, 262, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 10, 400, 0, "Courier New")
	GUISetState()

	; 添加标准系统位图
	Switch _GUICtrlToolbar_GetBitmapFlags($hToolbar)
		Case 0
			_GUICtrlToolbar_AddBitmap($hToolbar, 1, -1, $IDB_STD_SMALL_COLOR)
		Case 2
			_GUICtrlToolbar_AddBitmap($hToolbar, 1, -1, $IDB_STD_LARGE_COLOR)
	EndSwitch

	; 添加按钮
	_GUICtrlToolbar_AddButton($hToolbar, $idNew, $STD_FILENEW, 0, $BTNS_DROPDOWN)
	_GUICtrlToolbar_AddButton($hToolbar, $idOpen, $STD_FILEOPEN)
	_GUICtrlToolbar_AddButton($hToolbar, $idSave, $STD_FILESAVE)
	_GUICtrlToolbar_AddButtonSep($hToolbar)
	_GUICtrlToolbar_AddButton($hToolbar, $idHelp, $STD_HELP)

	; Show extended styles in use
	MemoWrite("Extended sytles: " & _GUICtrlToolbar_GetExtendedStyle($hToolbar))

	; 循环直到用户退出
	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

EndFunc   ;==>_Main

; 写入消息到 memo
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite

; Handle TBN_DROPDOWN message
Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
	#forceref $hWnd, $iMsg, $iwParam
	Local $tNMHDR, $iCode, $hMenu

	$tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	$iCode = DllStructGetData($tNMHDR, "Code")

	If $iCode = $TBN_DROPDOWN Then
		$hMenu = _GUICtrlMenu_CreatePopup()
		_GUICtrlMenu_AddMenuItem($hMenu, "Template 1", 2000)
		_GUICtrlMenu_AddMenuItem($hMenu, "Template 2", 2001)
		_GUICtrlMenu_AddMenuItem($hMenu, "Template 3", 2002)
		_GUICtrlMenu_TrackPopupMenu($hMenu, $hGUI)
		_GUICtrlMenu_DestroyMenu($hMenu)
	EndIf
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY
