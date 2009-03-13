#AutoIt3Wrapper_au3check_parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GuiConstantsEx.au3>
#include <GuiTab.au3>
#include <GuiToolTip.au3>

Opt('MustDeclareVars', 1)

$Debug_TAB = False ; Check ClassName being passed to functions, set to True and use a handle to another control to see it work

_Main()

Func _Main()
	Local $hTool, $hTab

	; Create GUI
	GUICreate("Tab Control Get Tool Tips", 400, 300)
	$hTab = GUICtrlCreateTab(2, 2, 396, 296)
	GUISetState()

	; Add tabs
	_GUICtrlTab_InsertItem($hTab, 0, "Tab 1")
	_GUICtrlTab_InsertItem($hTab, 1, "Tab 2")
	_GUICtrlTab_InsertItem($hTab, 2, "Tab 3")
	
	; Get/Set tooltip
	$hTool = _GUIToolTip_Create(GUICtrlGetHandle($hTab))
	_GUICtrlTab_SetToolTips($hTab, $hTool)
	MsgBox(4160, "Information", "ToolTip handle: 0x" & _GUICtrlTab_GetToolTips($hTab))

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main