#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>

_Main()

Func _Main()
	Local $iCancel, $iExit, $iFileItem, $iFileMenu, $iHelpMenu, $iInfoItem
	Local $iRecentFilesMenu, $iStatusLabel, $iViewMenu, $iViewStatusItem, $sFilePath, $sStatus = "Ready"

	GUICreate("我的图形菜单", 300, 200)

	$sStatus = "Ready"

	$iFileMenu = GUICtrlCreateMenu("文件(&F)")
	$iFileItem = GUICtrlCreateMenuItem("打开", $iFileMenu)
	GUICtrlSetState(-1, $GUI_DEFBUTTON);调整指定控件为窗口的默认按钮
	$iHelpMenu = GUICtrlCreateMenu("?"); 创建一个菜单控件
	GUICtrlCreateMenuItem("保存", $iFileMenu)
	GUICtrlSetState(-1, $GUI_DISABLE);调整指定控件为灰色状态
	$iInfoItem = GUICtrlCreateMenuItem("信息", $iHelpMenu)
	$iExit = GUICtrlCreateMenuItem("退出", $iFileMenu)
	$iRecentFilesMenu = GUICtrlCreateMenu("历史文件", $iFileMenu, 1)

	GUICtrlCreateMenuItem("", $iFileMenu, 2) 	; 创建分隔线

	$iViewMenu = GUICtrlCreateMenu("查看", -1, 1); 创建一个菜单控件
	$iViewStatusItem = GUICtrlCreateMenuItem("状态栏", $iViewMenu)
	GUICtrlSetState(-1, $GUI_CHECKED);调整指定控件为选中状态
	GUICtrlCreateButton("确定", 50, 130, 70, 20)
	GUICtrlSetState(-1, $GUI_FOCUS)
	$iCancel = GUICtrlCreateButton("取消", 180, 130, 70, 20)

	$iStatusLabel = GUICtrlCreateLabel($sStatus, 0, 165, 300, 16, BitOR($SS_SIMPLE, $SS_SUNKEN))

	GUISetState(@SW_SHOW)

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE, $iCancel, $iExit
				Exit

			Case $iInfoItem
				MsgBox(64, "Info", "Only a test...")

			Case $iFileItem
				$sFilePath = FileOpenDialog("选择一个文件...", @TempDir, "All (*.*)")
				If @error Then
					ContinueLoop
				EndIf
				GUICtrlCreateMenuItem($sFilePath, $iRecentFilesMenu)

			Case $iViewStatusItem
				If BitAND(GUICtrlRead($iViewStatusItem), $GUI_CHECKED) = $GUI_CHECKED Then
					GUICtrlSetState($iViewStatusItem, $GUI_UNCHECKED)
					GUICtrlSetState($iStatusLabel, $GUI_HIDE)
				Else
					GUICtrlSetState($iViewStatusItem, $GUI_CHECKED)
					GUICtrlSetState($iStatusLabel, $GUI_SHOW)
				EndIf
		EndSwitch
	WEnd
EndFunc   ;==>_Main
