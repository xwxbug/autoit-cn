#include <GUIConstantsEx.au3>
#include <GuiListView.au3>

$Debug_LV = False ; 检查传递给 ListView 函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

_Main()

Func _Main()
	Local $iI, $iTimer, $hListView

	; 创建 GUI
	GUICreate("ListView Add Array", 400, 300)
	$hListView = GUICtrlCreateListView("", 2, 2, 394, 268)
	GUISetState()

	; 添加列
	_GUICtrlListView_AddColumn($hListView, "Items", 100)
	_GUICtrlListView_AddColumn($hListView, "SubItems 1", 100)
	_GUICtrlListView_AddColumn($hListView, "SubItems 2", 100)
	_GUICtrlListView_AddColumn($hListView, "SubItems 3", 100)

	_GUICtrlListView_SetItemCount($hListView, 5000)

	; 加载一列
	Local $aItems[5000][1]
	For $iI = 0 To UBound($aItems) - 1
		$aItems[$iI][0] = "Item " & $iI
	Next
	$iTimer = TimerInit()
	_GUICtrlListView_AddArray($hListView, $aItems)
	MsgBox(4160, "信息", "Load time: " & TimerDiff($iTimer) / 1000 & " seconds")

	_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($hListView)) ; 通过 UDF 函数添加的项目也能用 UDF 函数删除

	; 加载四列
	Dim $aItems[5000][4]
	For $iI = 0 To UBound($aItems) - 1
		$aItems[$iI][0] = "Item " & $iI
		$aItems[$iI][1] = "Item " & $iI & "-1"
		$aItems[$iI][2] = "Item " & $iI & "-2"
		$aItems[$iI][3] = "Item " & $iI & "-3"
	Next
	$iTimer = TimerInit()
	_GUICtrlListView_AddArray($hListView, $aItems)
	MsgBox(4160, "信息", "Load time: " & TimerDiff($iTimer) / 1000 & " seconds")

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main
