; 作者:         Zedna

#include <GUIConstantsEx.au3>
#include <TreeviewConstants.au3>
#include <WindowsConstants.au3>

$gui = GUICreate("ControlTreeview 测试", 212, 212)
$treeview = GUICtrlCreateTreeView(6, 6, 200, 160, BitOR($TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_CHECKBOXES), $WS_EX_CLIENTEDGE)
$h_tree = ControlGetHandle($gui, "", $treeview)

$root = GUICtrlCreateTreeViewItem("根", $treeview)
$item1 = GUICtrlCreateTreeViewItem("项目 1", $root)
$item2 = GUICtrlCreateTreeViewItem("项目 2", $root)
$item3 = GUICtrlCreateTreeViewItem("项目 3", $root)
$item4 = GUICtrlCreateTreeViewItem("项目 4", $root)
$item41 = GUICtrlCreateTreeViewItem("项目 41", $item4)
$item42 = GUICtrlCreateTreeViewItem("项目 42", $item4)
$item5 = GUICtrlCreateTreeViewItem("项目 5", $root)

GUISetState(@SW_SHOW)

; 一些例子
ControlTreeView ($gui, "", $h_tree, "Expand", "根")

ControlTreeView ($gui, "", $h_tree, "Exists", "根|项目 4")
ControlTreeView ($gui, "", $h_tree, "Check", "根|项目 4")
ControlTreeView ($gui, "", $h_tree, "Select", "根|项目 4")
ControlTreeView ($gui, "", $h_tree, "Expand", "根|项目 4")

While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = $GUI_EVENT_CLOSE
			ExitLoop
	EndSelect
WEnd
