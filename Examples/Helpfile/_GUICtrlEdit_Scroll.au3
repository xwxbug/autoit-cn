#include <GuiEdit.au3>
#include <GuiStatusBar.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ScrollBarConstants.au3>

$Debug_Ed = False ; 检查传递给 Edit 函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

_Main()

Func _Main()
	Local $hStatusBar, $hEdit, $hGUI
	Local $sWow64 = ""
	If @AutoItX64 Then $sWow64 = "\Wow6432Node"
	Local $sFile = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE" & $sWow64 & "\AutoIt v3\AutoIt", "InstallDir") & "\include\_ReadMe_.txt"
	Local $aPartRightSide[3] = [200, 378, -1], $iLen

	; 创建 GUI
	$hGUI = GUICreate("Edit Scroll", 400, 300)
	$hEdit = GUICtrlCreateEdit("", 2, 2, 394, 268, BitOR($ES_WANTRETURN, $WS_VSCROLL))
	$hStatusBar = _GUICtrlStatusBar_Create($hGUI, $aPartRightSide)
	_GUICtrlStatusBar_SetIcon($hStatusBar, 2, 97, "shell32.dll")
	GUISetState()

	; 设置边距
	_GUICtrlEdit_SetMargins($hEdit, BitOR($EC_LEFTMARGIN, $EC_RIGHTMARGIN), 10, 10)

	; 设置文本
	_GUICtrlEdit_SetText($hEdit, FileRead($sFile))

	MsgBox(4160, "Information", "Scroll Line Down")
	_GUICtrlEdit_Scroll($hEdit, $SB_LINEDOWN)

	MsgBox(4160, "Information", "Scroll Line Up")
	_GUICtrlEdit_Scroll($hEdit, $SB_LINEUP)

	MsgBox(4160, "Information", "Scroll Page Down")
	_GUICtrlEdit_Scroll($hEdit, $SB_PAGEDOWN)

	MsgBox(4160, "Information", "Scroll Page Up")
	_GUICtrlEdit_Scroll($hEdit, $SB_PAGEUP)

	$iLen = _GUICtrlEdit_GetTextLen($hEdit)
	_GUICtrlEdit_SetSel($hEdit, $iLen, $iLen)

	MsgBox(4160, "Information", "Scroll Caret")
	_GUICtrlEdit_Scroll($hEdit, $SB_SCROLLCARET)

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main
