
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w
6
#include  <GuiConstantsEx.au3>
#include  <GuiTreeView.au3>
#include  <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

$Debug_TV = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作

Global $hImage, $hStateImage

_Main()

Func _Main()

	Local $hItem[10], $hChildItem[30], $iRand, $iYItem, $hTreeView
	Local $iStyle = BitOR($TVS_EDITLABELS, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS)

	GUICreate( "TreeView Select
	Item" ,  400 ,  300 )

	$hTreeView = GUICtrlCreateTreeView(2, 2, 396, 268, $iStyle, $WS_EX_CLIENTEDGE)
	_GUICtrlTreeView_SetUnicodeFormat($hTreeView, False)
	GUISetState()

	_GUICtrlTreeView_BeginUpdate($hTreeView)

	For $x = 0 To 9
		$hItem[$x] = GUICtrlCreateTreeViewItem( StringFormat( "[%02d] New
		Item" ,  $x ),  $hTreeView )

		For $y = 1 To 3
			$hChildItem[$iYItem] = GUICtrlCreateTreeViewItem( StringFormat( "[%02d] New
			Child" ,  $y ),  $hItem [ $x ])
			$iYItem += 1
		Next
	Next
	_GUICtrlTreeView_EndUpdate($hTreeView)


	$iRand = Random(0, 9, 1)

	_GUICtrlTreeView_SelectItem($hTreeView, $hItem[$iRand])


	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

