#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GuiConstantsEx.au3>
#include <GuiTab.au3>
#include <WinAPI.au3>
#include <GuiImageList.au3>

Opt('MustDeclareVars ', 1)

$Debug_TAB = False ; 检查传递给函数的类名, 设置为真并使用另一控件句柄观察其工作

_Main()

Func _Main()
	Local $hGUI, $hImage, $hTab

	; 创建界面
	$hGUI = GUICreate(" Tab Control Remove Image ", 400, 300)
	$hTab = GUICtrlCreateTab(2, 2, 396, 296)
	GUISetState()

	; 创建图像
	$hImage = _GUIImageList_Create()
	_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($hGUI, 0xFF0000, 16, 16))
	_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($hGUI, 0x00FF00, 16, 16))
	_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($hGUI, 0x0000FF, 16, 16))
	_GUICtrlTab_SetImageList($hTab, $hImage)

	; 添加标签页
	_GUICtrlTab_InsertItem($hTab, 0, "Tab 1 ")
	_GUICtrlTab_InsertItem($hTab, 1, "Tab 2 ")
	_GUICtrlTab_InsertItem($hTab, 2, "Tab 3 ")

	; 移除第二个图像
	MsgBox(4160, "Information ", "Removing second image in list ")
	_GUICtrlTab_RemoveImage($hTab, 1)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

