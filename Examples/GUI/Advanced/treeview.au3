#include <GUIConstantsEx.au3>
#include <TreeViewConstants.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $hGUI = GUICreate("GUI 之多个 treeviews", 340, 200, -1, -1, BitOR($WS_MINIMIZEBOX, $WS_MAXIMIZEBOX, $WS_GROUP, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU))

	Local $iTreeView = GUICtrlCreateTreeView(10, 10, 120, 150)
	Local $iAboutItem = GUICtrlCreateTreeViewItem("关于", $iTreeView)
	Local $iGeneralItem = GUICtrlCreateTreeViewItem("常规", $iTreeView)
	Local $iToolsItem = GUICtrlCreateTreeViewItem("工具", $iTreeView)
	Local $iEffectItem = GUICtrlCreateTreeViewItem("效果", $iGeneralItem)
	Local $iStyleItem = GUICtrlCreateTreeViewItem("样式", $iGeneralItem)
	GUICtrlCreateTreeViewItem("命令行", $iToolsItem)
	GUICtrlCreateTreeViewItem("其它", $iToolsItem)

	Local $iDescriptionGroup = GUICtrlCreateGroup("详细信息", 140, 105, 180, 55)
	GUICtrlSetState(-1, $GUI_HIDE)

	Local $iEffectsGroup = GUICtrlCreateGroup("效果", 140, 5, 180, 95)
	GUICtrlSetState(-1, $GUI_HIDE)
	Local $iEffectsTreeView = GUICtrlCreateTreeView(150, 20, 160, 70, BitOR($TVS_CHECKBOXES, $TVS_DISABLEDRAGDROP), $WS_EX_CLIENTEDGE)
	GUICtrlSetState(-1, $GUI_HIDE)
	Local $iEffect1 = GUICtrlCreateTreeViewItem("效果 1", $iEffectsTreeView)
	GUICtrlCreateTreeViewItem("效果 2", $iEffectsTreeView)
	Local $iEffect3 = GUICtrlCreateTreeViewItem("效果 3", $iEffectsTreeView)
	GUICtrlCreateTreeViewItem("效果 4", $iEffectsTreeView)
	GUICtrlCreateTreeViewItem("效果 5", $iEffectsTreeView)

	Local $iStylesGroup = GUICtrlCreateGroup("样式", 140, 5, 180, 95)
	GUICtrlSetState(-1, $GUI_HIDE)
	Local $iStylesTreeView = GUICtrlCreateTreeView(150, 20, 160, 70, BitOR($TVS_CHECKBOXES, $TVS_DISABLEDRAGDROP), $WS_EX_CLIENTEDGE)
	GUICtrlSetState(-1, $GUI_HIDE)
	GUICtrlCreateTreeViewItem("样式 1", $iStylesTreeView)
	GUICtrlCreateTreeViewItem("样式 2", $iStylesTreeView)
	GUICtrlCreateTreeViewItem("样式 3", $iStylesTreeView)
	Local $iStyle4 = GUICtrlCreateTreeViewItem("样式 4", $iStylesTreeView)
	Local $iStyle5 = GUICtrlCreateTreeViewItem("样式 5", $iStylesTreeView)

	Local $iAboutLabel = GUICtrlCreateLabel("这只是一个treeview演示.", 160, 80, 160, 20)

	Local $iCancelButton = GUICtrlCreateButton("取消", 130, 170, 85, 25)
	GUISetState(@SW_SHOW, $hGUI)

	GUICtrlSetState($iEffect1, $GUI_CHECKED)
	GUICtrlSetState($iEffect3, $GUI_CHECKED)
	GUICtrlSetState($iStyle4, $GUI_CHECKED)
	GUICtrlSetState($iStyle5, $GUI_CHECKED)

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE, $iCancelButton
				ExitLoop

			Case $iAboutItem
				GUICtrlSetState($iDescriptionGroup, $GUI_HIDE)
				GUICtrlSetState($iEffectsTreeView, $GUI_HIDE)
				GUICtrlSetState($iEffectsGroup, $GUI_HIDE)
				GUICtrlSetState($iStylesTreeView, $GUI_HIDE)
				GUICtrlSetState($iStylesGroup, $GUI_HIDE)
				GUICtrlSetState($iAboutLabel, $GUI_SHOW)

			Case $iEffectItem
				GUICtrlSetState($iStylesTreeView, $GUI_HIDE)
				GUICtrlSetState($iStylesGroup, $GUI_HIDE)
				GUICtrlSetState($iAboutLabel, $GUI_HIDE)
				GUICtrlSetState($iEffectsGroup, $GUI_SHOW)
				GUICtrlSetState($iDescriptionGroup, $GUI_SHOW)
				GUICtrlSetState($iEffectsTreeView, $GUI_SHOW)
				GUICtrlSetBkColor($iEffectsTreeView, 0xD0F0F0)

			Case $iStyleItem
				GUICtrlSetState($iEffectsTreeView, $GUI_HIDE)
				GUICtrlSetState($iEffectsGroup, $GUI_HIDE)
				GUICtrlSetState($iAboutLabel, $GUI_HIDE)
				GUICtrlSetState($iStylesGroup, $GUI_SHOW)
				GUICtrlSetState($iDescriptionGroup, $GUI_SHOW)
				GUICtrlSetState($iStylesTreeView, $GUI_SHOW)
				GUICtrlSetColor($iStylesTreeView, 0xD00000)
				GUICtrlSetBkColor($iStylesTreeView, 0xD0FFD0)

		EndSwitch
	WEnd
	GUIDelete($hGUI)
	Exit
EndFunc   ;==>Example
