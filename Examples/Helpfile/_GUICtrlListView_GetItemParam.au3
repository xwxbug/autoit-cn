
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w
6
#include  <GuiConstantsEx.au3>
#include  <GuiListView.au3>

Opt('MustDeclareVars', 1)

$Debug_LV = False ; 检查传递给函数的类名,设置为真并使用另一控件的句柄观察其工作

;不要在由GuiCtrlCreateListViewItem建立的控件上使用SetItemParam
;参数是用建立函数创建的项目的controlId

Example_UDF_Created()


Func Example_UDF_Created()

	Local $GUI, $hListView

	$GUI = GUICreate( "(UDF Created)
	ListView Get Item Param" ,  400 ,  300 )

	$hListView = _GUICtrlListView_Create($GUI, "", 2, 2, 394, 268)
	GUISetState()

	; 添加列
	_GUICtrlListView_AddColumn($hListView, "Items", 100)

	; 添加项目
	_GUICtrlListView_AddItem($hListView, "Item 1")
	_GUICtrlListView_AddItem($hListView, "Item 2")
	_GUICtrlListView_AddItem($hListView, "Item 3")


	; 设置项目2的参数
	_GUICtrlListView_SetItemParam($hListView, 1, 1234)
	MsgBox(4160, "Information", "Item 2 Parameter:" & _GUICtrlListView_GetItemParam($hListView, 1))

	;循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example_UDF_Created

