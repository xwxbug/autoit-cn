; 作者:         Zedna

#include <GUIConstantsEx.au3>
#include <TreeviewConstants.au3>
#include <WindowsConstants.au3>

Local $gui = GUICreate("ControlTreeview 测试", 212, 212)
Local $treeview = GUICtrlCreateTreeView(6, 6, 200, 160, BitOR($TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_CHECKBOXES), $WS_EX_CLIENTEDGE)
Local $h_tree = ControlGetHandle($gui, "", $treeview)

Local $root = GUICtrlCreateTreeViewItem("根", $treeview)
GUICtrlCreateTreeViewItem("项目 1", $root)
GUICtrlCreateTreeViewItem("项目 2", $root)
GUICtrlCreateTreeViewItem("项目 3", $root)
Local $item4 = GUICtrlCreateTreeViewItem("项目 4", $root)
GUICtrlCreateTreeViewItem("项目 41", $item4)
GUICtrlCreateTreeViewItem("项目 42", $item4)
GUICtrlCreateTreeViewItem("项目 5", $root)

GUISetState(@SW_SHOW)

; 一些例子
ControlTreeView ($gui, "", $h_tree, "Expand", "根")

ControlTreeView ($gui, "", $h_tree, "Exists", "根|项目 4")
ControlTreeView ($gui, "", $h_tree, "Check", "根|项目 4")
ControlTreeView ($gui, "", $h_tree, "Select", "根|项目 4")
ControlTreeView ($gui, "", $h_tree, "Expand", "根|项目 4")

While 1
	Local $msg = GUIGetMsg()
	Select
		Case $msg = $GUI_EVENT_CLOSE
			ExitLoop
	EndSelect
WEnd
