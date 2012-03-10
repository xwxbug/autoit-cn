#include <GUIConstantsEx.au3>
#include <GuiTreeView.au3>
#include <WindowsConstants.au3>

$Debug_TV = False ; 检查传递给函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

Global $hImage, $hStateImage

_Main()

Func _Main()

	Local $hItem[10], $iX = 9, $iY = 29, $hTreeView
	Local $iStyle = BitOR($TVS_EDITLABELS, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS)

	GUICreate("TreeView Sort", 400, 300)

	$hTreeView = GUICtrlCreateTreeView(2, 2, 396, 268, $iStyle, $WS_EX_CLIENTEDGE)
	GUISetState()

	_GUICtrlTreeView_BeginUpdate($hTreeView)
	For $x = 0 To 9
		$hItem[$x] = GUICtrlCreateTreeViewItem(StringFormat("[%02d] New Item", $iX), $hTreeView)
		$iX -= 1
		For $y = 1 To 3
			GUICtrlCreateTreeViewItem(StringFormat("[%02d] New Child", $iY), $hItem[$x])
			$iY -= 1
		Next
	Next
	_GUICtrlTreeView_Expand($hTreeView)
	_GUICtrlTreeView_EndUpdate($hTreeView)

	MsgBox(4160, "Information", "Sort")
	_GUICtrlTreeView_Sort($hTreeView)
	_GUICtrlTreeView_SelectItem($hTreeView, $hItem[9])

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main
