
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w
6
#include  <GuiEdit.au3>
#include  <GuiStatusBar.au3>
#include  <GuiConstantsEx.au3>
#include  <WindowsConstants.au3>
#include  <ScrollBarConstants.au3>

Opt('MustDeclareVars', 1)

$Debug_Ed = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作

_Main()

Func _Main()
	Local $StatusBar, $hEdit, $hGUI
	Local $sFile = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt", "InstallDir") & "\include\changelog.txt"
	Local $aPartRightSide[3] = [200, 378, -1], $iLen

	; 创建界面
	$hGUI = GUICreate("Edit Scroll", 400, 300)
	$hEdit = GUICtrlCreateEdit("", 2, 2, 394, 268, BitOR($ES_WANTRETURN, $WS_VSCROLL))
	$StatusBar = _GUICtrlStatusBar_Create($hGUI, $aPartRightSide)

	_GUICtrlStatusBar_SetIcon($StatusBar, 2, 97, "shell32.dll")
	GUISetState()

	;
	设置边界
	_GUICtrlEdit_SetMargins($hEdit, BitOR($EC_LEFTMARGIN, $EC_RIGHTMARGIN), 10, 10)

	; Set Text
	_GUICtrlEdit_SetText($hEdit, FileRead($sFile))

	MsgBox(4160, "Information", "Scroll Line Down")
	_GUICtrlEdit_Scroll($hEdit, $SB_LINEDOWN)


	MsgBox(4160, "Information", "Scroll Line Up")

	_GUICtrlEdit_Scroll($hEdit, $SB_LINEUP)

	MsgBox(4160, "Information", "Scroll Page
	Down" )
	_GUICtrlEdit_Scroll($hEdit, $SB_PAGEDOWN)


	MsgBox(4160, "Information", "Scroll Page Up")

	_GUICtrlEdit_Scroll($hEdit, $SB_PAGEUP)

	$iLen = _GUICtrlEdit_GetTextLen($hEdit)
	_GUICtrlEdit_SetSel($hEdit, $iLen, $iLen)

	MsgBox(4160, "Information", "Scroll
	Caret" )
	_GUICtrlEdit_Scroll($hEdit, $SB_SCROLLCARET)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

