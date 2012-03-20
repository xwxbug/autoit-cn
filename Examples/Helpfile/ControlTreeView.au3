#include <GUIConstantsEx.au3>
#include <TreeViewConstants.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
Local $hGUI = GUICreate("ControlTreeView 测试", 212, 212)
	Local $iTreeView_1 = GUICtrlCreateTreeView(6, 6, 200, 160, BitOR($TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_CHECKBOXES), $WS_EX_CLIENTEDGE)
	Local $hTreeView_1 = ControlGetHandle($hGUI, "", $iTreeView_1)

	Local $iRoot = GUICtrlCreateTreeViewItem("根", $iTreeView_1)
	GUICtrlCreateTreeViewItem("项目 1", $iRoot)
	GUICtrlCreateTreeViewItem("项目 2", $iRoot)
	GUICtrlCreateTreeViewItem("项目 3", $iRoot)
	Local $iItem_4 = GUICtrlCreateTreeViewItem("项目 4", $iRoot)
	GUICtrlCreateTreeViewItem("项目 4.1", $iItem_4)
	GUICtrlCreateTreeViewItem("项目 4.2", $iItem_4)
	GUICtrlCreateTreeViewItem("项目 5", $iRoot)

	GUISetState(@SW_SHOW, $hGUI)

	ControlTreeView ($hGUI, "", $hTreeView_1, "Expand", "根")

	ControlTreeView ($hGUI, "", $hTreeView_1, "Exists", "根|项目 4")
	ControlTreeView ($hGUI, "", $hTreeView_1, "Check", "根|项目 4")
	ControlTreeView ($hGUI, "", $hTreeView_1, "Select", "根|项目 4")
	ControlTreeView ($hGUI, "", $hTreeView_1, "Expand", "根|项目 4")

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>Example
