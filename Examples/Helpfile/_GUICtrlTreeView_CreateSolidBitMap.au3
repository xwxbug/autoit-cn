#include <GUIConstantsEx.au3>
#include <GuiTreeView.au3>
#include <GuiImageList.au3>
#include <WindowsConstants.au3>

$Debug_TV = False ; 检查传递给函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

_Main()

Func _Main()

	Local $hImage, $hTreeView
	Local $iStyle = BitOR($TVS_EDITLABELS, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS, $TVS_CHECKBOXES)

	GUICreate("TreeView Create Solid BitMap", 400, 300)

	$hTreeView = GUICtrlCreateTreeView(2, 2, 396, 268, $iStyle, $WS_EX_CLIENTEDGE)
	GUISetState()

	$hImage = _GUIImageList_Create()
	_GUIImageList_Add($hImage, _GUICtrlTreeView_CreateSolidBitMap($hTreeView, 0xFF0000, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlTreeView_CreateSolidBitMap($hTreeView, 0x00FF00, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlTreeView_CreateSolidBitMap($hTreeView, 0x0000FF, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlTreeView_CreateSolidBitMap($hTreeView, 0xFF00FF, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlTreeView_CreateSolidBitMap($hTreeView, 0x000000, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlTreeView_CreateSolidBitMap($hTreeView, 0x00FFFF, 16, 16))
	_GUICtrlTreeView_SetNormalImageList($hTreeView, $hImage)

	For $x = 0 To _GUIImageList_GetImageCount($hImage) - 1
		_GUICtrlTreeView_Add($hTreeView, 0, StringFormat("[%02d] New Item", $x + 1), $x, $x + 3)
	Next

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main
