#include <GuiToolbar.au3>
#include <GUIConstantsEx.au3>

$Debug_TB = False ; 检查传递给函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

_Main()

Func _Main()
	Local $hGUI, $hToolbar
	Local Enum $idRed = 1000, $idGreen, $idBlue

	; 创建 GUI
	$hGUI = GUICreate("Toolbar", 400, 300)
	$hToolbar = _GUICtrlToolbar_Create($hGUI)
	GUISetState()

	; Add bitmaps
	_GUICtrlToolbar_LoadBitmap($hToolbar, @ScriptDir & "\images\Red.bmp")
	_GUICtrlToolbar_LoadBitmap($hToolbar, @ScriptDir & "\Images\Green.bmp")
	_GUICtrlToolbar_LoadBitmap($hToolbar, @ScriptDir & "\Images\Blue.bmp")

	; 添加按钮
	_GUICtrlToolbar_AddButton($hToolbar, $idRed, 0)
	_GUICtrlToolbar_AddButton($hToolbar, $idGreen, 1)
	_GUICtrlToolbar_AddButton($hToolbar, $idBlue, 2)

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

EndFunc   ;==>_Main
