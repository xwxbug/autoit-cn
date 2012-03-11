#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <GuiImageList.au3>

$Debug_LV = False ; 检查传递给 ListView 函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

Global $iMemo

_Main()

Func _Main()

	Local $GUI, $hImage, $aDrag, $hListView

	$GUI = GUICreate("(UDF Created) ListView Create Drag Image", 400, 300)

	$hListView = _GUICtrlListView_Create($GUI, "", 2, 2, 394, 118)
	$iMemo = GUICtrlCreateEdit("", 2, 124, 396, 174, 0)
	GUISetState()

	; 加载图像
	$hImage = _GUIImageList_Create()
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($hListView, 0xFF0000, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($hListView, 0x00FF00, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($hListView, 0x0000FF, 16, 16))
	_GUICtrlListView_SetImageList($hListView, $hImage, 1)

	; 添加列
	_GUICtrlListView_InsertColumn($hListView, 0, "Column 1", 100)
	_GUICtrlListView_InsertColumn($hListView, 1, "Column 2", 100)
	_GUICtrlListView_InsertColumn($hListView, 2, "Column 3", 100)

	; 添加项目
	_GUICtrlListView_AddItem($hListView, "Red", 0)
	_GUICtrlListView_AddItem($hListView, "Green", 1)
	_GUICtrlListView_AddItem($hListView, "Blue", 2)

	; 创建拖动时的图像
	$aDrag = _GUICtrlListView_CreateDragImage($hListView, 0)
	_GUICtrlListView_DrawDragImage($hListView, $aDrag)

	MemoWrite("Drag Image Handle = 0x" & Hex($aDrag[0]) & " IsPtr = " & IsPtr($aDrag[0]) & " IsHWnd = " & IsHWnd($aDrag[0]))

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_MOUSEMOVE
				_GUICtrlListView_DrawDragImage($hListView, $aDrag)
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	; Destory image list
	_GUIImageList_Destroy($aDrag[0])

	GUIDelete()
EndFunc   ;==>_Main

; 写入一行到 memo 控件
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
