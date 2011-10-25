
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w
6
#include  <GuiConstantsEx.au3>
#include  <GuiTreeView.au3>
#include  <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

$Debug_TV = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作

示例_Internal()
示例_External()

Func 示例_Internal()

	Local $hItem, $hChild, $hFirst, $hTreeView
	Local $iStyle = BitOR($TVS_EDITLABELS, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS, $TVS_CHECKBOXES)

	GUICreate("TreeView Get Parent Param", 400, 300)

	$hTreeView = GUICtrlCreateTreeView(2, 2, 396, 268, $iStyle, $WS_EX_CLIENTEDGE)
	GUISetState()

	_GUICtrlTreeView_BeginUpdate($hTreeView)

	For $x = 0 To 20
		$hItem = GUICtrlCreateTreeViewItem( StringFormat( "[%02d] New
		Item" ,  $x ),  $hTreeView )

		For $y = 0 To 2
			$hChild = GUICtrlCreateTreeViewItem( StringFormat( "[%02d] New
			Item" ,  $y ),  $hItem )

		Next
	Next
	_GUICtrlTreeView_EndUpdate($hTreeView)


	_GUICtrlTreeView_SelectItem($hTreeView, $hChild)
	MsgBox(4160, "Information", "Parent Param/ID:" & _GUICtrlTreeView_GetParentParam($hTreeView, $hChild)) ; same as controlId

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>示例_Internal

Func 示例_External()

	Local $GUI, $hItem, $hChild, $hFirst, $iParam = 1, $hTreeView
	Local $iStyle = BitOR($TVS_EDITLABELS, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS, $TVS_CHECKBOXES)

	$GUI = GUICreate( "(UDF Created)
	TreeView Get Parent Param" ,  400 ,  300 )

	$hTreeView = _GUICtrlTreeView_Create($GUI, 2, 2, 396, 268, $iStyle, $WS_EX_CLIENTEDGE)
	GUISetState()

	_GUICtrlTreeView_BeginUpdate($hTreeView)

	For $x = 0 To 20
		$hItem = _GUICtrlTreeView_Add($hTreeView, 0, StringFormat( "[%02d] New
		Item" ,  $x ))

		_GUICtrlTreeView_SetItemParam($hTreeView, $hItem, $iParam)
		$iParam += 1
		For $y = 0 To 2

			$hChild = _GUICtrlTreeView_AddChild($hTreeView, $hItem, StringFormat( "[%02d] New
			Item" ,  $y ))

			_GUICtrlTreeView_SetItemParam($hTreeView, $hChild, $iParam)

			$iParam += 1
		Next
	Next
	_GUICtrlTreeView_EndUpdate($hTreeView)


	_GUICtrlTreeView_SelectItem($hTreeView, $hChild)
	MsgBox(4160, "Information", "Parent Param:" & _GUICtrlTreeView_GetParentParam($hTreeView, $hChild))


	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>示例_External

