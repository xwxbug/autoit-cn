
#include  <GuiToolbar.au3>
#include  <GuiConstantsEx.au3>
#include  <WindowsConstants.au3>
#include  <Constants.au3>

Opt('MustDeclareVars', 1)

$Debug_TB = False ; 检查传递给函数的类名,
设置为真并使用另一控件的句柄观察其工作

_Main()

Func _Main()
	Local $hGUI, $hToolbar
	Local Enum $idNew = 1000, $idOpen, $idSave, $idHelp

	; 创建界面
	$hGUI = GUICreate("Toolbar", 400, 300)
	$hToolbar = _GUICtrlToolbar_Create($hGUI)
	GUISetState()

	; 添加标准系统位图
	_GUICtrlToolbar_AddBitmap($hToolbar, 1, -1, $IDB_STD_LARGE_COLOR)

	;
	添加按钮
	_GUICtrlToolbar_InsertButton($hToolbar, 0, $idNew, $STD_FILENEW)

	_GUICtrlToolbar_InsertButton($hToolbar, 1, $idOpen, $STD_FILEOPEN)
	_GUICtrlToolbar_InsertButton($hToolbar, 2, $idSave, $STD_FILESAVE)

	_GUICtrlToolbar_AddButtonSep($hToolbar)
	_GUICtrlToolbar_InsertButton($hToolbar, 4, $idHelp, $STD_HELP)


	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

endfunc   ;==>_Main

