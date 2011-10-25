
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w
6
#include  <GuiConstantsEx.au3>
#include  <GuiTreeView.au3>
#include  <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

$Debug_TV = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作

_Main()

Func _Main()

	Local $hItem[100], $hChildItem[100], $iRand, $iChildRand, $iYItem, $hTreeView
	Local $iStyle = BitOR($TVS_EDITLABELS, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS, $TVS_CHECKBOXES)

	GUICreate("TreeView Get Sibling Count", 400, 300)

	$hTreeView = GUICtrlCreateTreeView(2, 2, 396, 268, $iStyle, $WS_EX_CLIENTEDGE)
	GUISetState()

	_GUICtrlTreeView_BeginUpdate($hTreeView)

	$iRand = Random(2, 9, 1)

	For $x = 0 To $iRand
		$hItem[$x] = GUICtrlCreateTreeViewItem( StringFormat( "[%02d] New
		Item" ,  $x ),  $hTreeView )

		$iChildRand = Random(0, 9, 1)
		For $y = 0 To $iChildRand

			$hChildItem[$iYItem] = GUICtrlCreateTreeViewItem( StringFormat( "[%02d] New
			Item" ,  $y ),  $hItem [ $x ])
			$iYItem += 1
		Next
	Next
	_GUICtrlTreeView_EndUpdate($hTreeView)


	$iRand = Random(0, 9)

	MsgBox(4160, "Information", StringFormat( "Sibling Count
	for item index %d: %d" ,  $iRand ,  _GUICtrlTreeView_GetSiblingCount ( $hTreeView ,  $hItem [ $iRand ])))

		$iRand = Random(0, 99)
		MsgBox(4160, "Information", StringFormat( "Sibling Count
		for Child item index %d: %d" ,  $iRand ,  _GUICtrlTreeView_GetSiblingCount ( $hTreeView ,  $hChildItem [ $iRand ])))
			_GUICtrlTreeView_Expand($hTreeView, _GUICtrlTreeView_GetParentHandle($hTreeView, $hChildItem[$iRand]))


			; 循环至用户退出
			Do
			Until GUIGetMsg() = $GUI_EVENT_CLOSE
			GUIDelete()
;### Tidy Error -> "endfunc" is closing previous "for" on line 50
		endfunc   ;==>_Main


;### Tidy Error -> for is never closed in your script.
;### Tidy Error -> for is never closed in your script.
