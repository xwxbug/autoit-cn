#AutoIt3Wrapper_au3check_parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GuiConstantsEx.au3>
#include <GuiListView.au3>
#include <GuiImageList.au3>

Opt('MustDeclareVars', 1)

$Debug_LV = False ; Check ClassName being passed to ListView functions, set to True and use a handle to another control to see it work

_Main()

Func _Main()

	Local $GUI, $hImage, $aDrag, $hListView
	
	$GUI = GUICreate("(UDF Created) ListView Create Drag Image", 400, 300)

	$hListView = _GUICtrlListView_Create($GUI, "", 2, 2, 394, 268)
	GUISetState()
	
	; Load images
	$hImage = _GUIImageList_Create()
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($hListView, 0xFF0000, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($hListView, 0x00FF00, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($hListView, 0x0000FF, 16, 16))
	_GUICtrlListView_SetImageList($hListView, $hImage, 1)

	; Add columns
	_GUICtrlListView_InsertColumn($hListView, 0, "Column 1", 100)
	_GUICtrlListView_InsertColumn($hListView, 1, "Column 2", 100)
	_GUICtrlListView_InsertColumn($hListView, 2, "Column 3", 100)

	; Add items
	_GUICtrlListView_AddItem($hListView, "Red", 0)
	_GUICtrlListView_AddItem($hListView, "Green", 1)
	_GUICtrlListView_AddItem($hListView, "Blue", 2)
	
	; Create drag image
	$aDrag = _GUICtrlListView_CreateDragImage($hListView, 0)
	_GUICtrlListView_DrawDragImage($hListView, $aDrag)
	
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