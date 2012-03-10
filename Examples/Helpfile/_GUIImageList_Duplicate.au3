#include <GUIConstantsEx.au3>
#include <WinAPI.au3>
#include <GuiListView.au3>
#include <GuiImageList.au3>
#include <WindowsConstants.au3>

_Main()

Func _Main()
	Local $listview, $hImage
	Local $Wow64 = ""
	If @AutoItX64 Then $Wow64 = "\Wow6432Node"
	Local $AutoItDir = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE" & $Wow64 & "\AutoIt v3\AutoIt", "InstallDir")
	Local $hImage2

	GUICreate("ImageList Duplicate", 410, 300)
	$listview = GUICtrlCreateListView("", 2, 2, 404, 268, BitOR($LVS_SHOWSELALWAYS, $LVS_NOSORTHEADER, $LVS_REPORT))
	GUISetState()

	; 创建含图像的图像列表
	$hImage = _GUIImageList_Create(11, 11)
	_GUIImageList_AddIcon($hImage, $AutoItDir & "\Icons\filetype1.ico")
	_GUIImageList_AddIcon($hImage, $AutoItDir & "\Icons\filetype2.ico")
	_GUIImageList_AddIcon($hImage, $AutoItDir & "\Icons\filetype3.ico")
	$hImage2 = _GUIImageList_Duplicate($hImage)
	_GUICtrlListView_SetImageList($listview, $hImage2, 1)

	; 添加列
	_GUICtrlListView_AddColumn($listview, "Column 1", 100, "Left", 0)
	_GUICtrlListView_AddColumn($listview, "Column 2", 100, "Left", 1)
	_GUICtrlListView_AddColumn($listview, "Column 3", 100, "Left", 2)
	_GUICtrlListView_AddColumn($listview, "Column 4", 100)

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main
