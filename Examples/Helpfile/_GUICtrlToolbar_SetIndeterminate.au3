#include <GuiToolbar.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Constants.au3>

$Debug_TB = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

_Main()

Func _Main()
	Local $hGUI, $hToolbar, $aStrings[4]
	Local Enum $idNew = 1000, $idOpen, $idSave, $idHelp

	; 创建 GUI
	$hGUI = GUICreate("Toolbar", 400, 300)
	$hToolbar = _GUICtrlToolbar_Create($hGUI)
	GUISetState()

	_GUICtrlToolbar_AddBitmap($hToolbar, 1, -1, $IDB_STD_LARGE_COLOR)

	; 添加字符串
	$aStrings[0] = _GUICtrlToolbar_AddString($hToolbar, "&New Button")
	$aStrings[1] = _GUICtrlToolbar_AddString($hToolbar, "&Open Button")
	$aStrings[2] = _GUICtrlToolbar_AddString($hToolbar, "&Save Button")
	$aStrings[3] = _GUICtrlToolbar_AddString($hToolbar, "&Help Button")

	; 添加按钮
	_GUICtrlToolbar_AddButton($hToolbar, $idNew, $STD_FILENEW, $aStrings[0])
	_GUICtrlToolbar_AddButton($hToolbar, $idOpen, $STD_FILEOPEN, $aStrings[1])
	_GUICtrlToolbar_AddButton($hToolbar, $idSave, $STD_FILESAVE, $aStrings[2])
	_GUICtrlToolbar_AddButtonSep($hToolbar)
	_GUICtrlToolbar_AddButton($hToolbar, $idHelp, $STD_HELP, $aStrings[3])

	; 设置保存按钮状态
	MsgBox(4096, "信息", "Save button indeterminate: " & _GUICtrlToolbar_IsButtonIndeterminate($hToolbar, $idSave))
	_GUICtrlToolbar_SetIndeterminate($hToolbar, $idSave)
	MsgBox(4096, "信息", "Save button indeterminate: " & _GUICtrlToolbar_IsButtonIndeterminate($hToolbar, $idSave))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

EndFunc   ;==>_Main
