
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w
6
#include  <GuiConstantsEx.au3>
#include  <GuiListView.au3>
#include  <GuiImageList.au3>

Opt('MustDeclareVars', 1)

Global $iMemo

_Main()

Func _Main()
	Local $hImage, $hGUI, $hDC, $aSize, $listview

	$hGUI = GUICreate( "ImageList Get
	Icon Size" ,  400 ,  300 )
	$listview = GUICtrlCreateListView("", 2, 2, 394, 199, BitOR($LVS_SHOWSELALWAYS, $LVS_NOSORTHEADER, $LVS_REPORT))
	$iMemo = GUICtrlCreateEdit("", 2, 200, 396, 266, 0)

	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")

	GUISetState()

	$hImage = _GUIImageList_Create(32, 32, 5, 3)

	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 110)

	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 131)

	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 165)

	_GUICtrlListView_SetImageList($listview, $hImage, 1)

	; 添加列
	_GUICtrlListView_AddColumn($listview, "Column 1", 120)
	_GUICtrlListView_AddColumn($listview, "Column 2", 100)
	_GUICtrlListView_AddColumn($listview, "Column 3", 100)

	; 添加项目
	_GUICtrlListView_AddItem($listview, "Row 1: Col 1", 0)

	_GUICtrlListView_AddSubItem($listview, 0, "Row 1: Col 2", 1, 1)

	_GUICtrlListView_AddSubItem($listview, 0, "Row 1: Col 3", 2, 2)

	_GUICtrlListView_AddItem($listview, "Row 2: Col 1", 1)
	_GUICtrlListView_AddSubItem($listview, 1, "Row 2: Col 2", 1, 2)

	;
	显示图像列表中图像大小(宽度和高度)
	$aSize = _GUIImageList_GetIconSize($hImage)
	MemoWrite("Image width :" & $aSize[0])
	MemoWrite("Image height:" & $aSize[1])

	MsgBox(4096, "Information", "Changing Icon
	Size" )

	_GUIImageList_SetIconSize($hImage, 16, 16)
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 110)

	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 131)

	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 165)

	_GUICtrlListView_SetImageList($listview, $hImage, 1)

	$aSize = _GUIImageList_GetIconSize($hImage)
	MemoWrite("Image width :" & $aSize[0])
	MemoWrite("Image height:" & $aSize[1])

	; 循环至用户退出
	Do

	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

; 向memo控件写入一行
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

