#include <GUIConstantsEx.au3>
#include <GuiListView.au3>

$Debug_LV = False ; 检查传递给 ListView 函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

_Main()

Func _Main()
	Local $aItem, $sText, $hListView

	GUICreate("ListView Get Item Text Array", 400, 300)

	$hListView = GUICtrlCreateListView("col1|col2|col3", 2, 2, 394, 268)
	GUICtrlCreateListViewItem("line1|data1|more1", $hListView)
	GUICtrlCreateListViewItem("line2|data2|more2", $hListView)
	GUICtrlCreateListViewItem("line3|data3|more3", $hListView)
	GUICtrlCreateListViewItem("line4|data4|more4", $hListView)
	GUICtrlCreateListViewItem("line5|data5|more5", $hListView)

	GUISetState()

	; 获取第二项的文本
	$aItem = _GUICtrlListView_GetItemTextArray($hListView, 1)
	For $i = 1 To $aItem[0]
		$sText &= StringFormat("Column[%2d] %s", $i, $aItem[$i]) & @LF
	Next

	MsgBox(4160, "Information", "Item 2 (All Columns) Text: " & @LF & @LF & $sText)

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main
