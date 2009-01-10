#AutoIt3Wrapper_au3check_parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GuiConstantsEx.au3>
#include <GuiTreeView.au3>
#include <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

$Debug_TV = False ; Check ClassName being passed to functions, set to True and use a handle to another control to see it work

_Main()

Func _Main()

	Local $hItem[10], $hItemChild[30], $iYIndex = 0, $iRand, $hTreeView
	Local $iStyle = BitOR($TVS_EDITLABELS, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS, $TVS_CHECKBOXES)
	
	GUICreate("TreeView Get Item Handle", 400, 300)
	
	$hTreeView = GUICtrlCreateTreeView(2, 2, 396, 268, $iStyle, $WS_EX_CLIENTEDGE)
	GUISetState()

	_GUICtrlTreeView_BeginUpdate($hTreeView)
	For $x = 0 To 9
		$hItem[$x] = GUICtrlCreateTreeViewItem(StringFormat("[%02d] New Item", $x), $hTreeView)
		For $y = $iYIndex To $iYIndex + 2
			$hItemChild[$y] = GUICtrlCreateTreeViewItem(StringFormat("[%02d] New Child Item", $y), $hItem[$x])
		Next
		$iYIndex += 3
	Next
	_GUICtrlTreeView_EndUpdate($hTreeView)

	$iRand = Random(0, 9, 1)
	MsgBox(4160, "Information", StringFormat("Item handle for index %d: %s", $iRand, _GUICtrlTreeView_GetItemHandle($hTreeView, $hItem[$iRand])))
	$iRand = Random(0, 29, 1)
	MsgBox(4160, "Information", StringFormat("Item handle for child index %d: %s", $iRand, _GUICtrlTreeView_GetItemHandle($hTreeView, $hItemChild[$iRand])))

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main