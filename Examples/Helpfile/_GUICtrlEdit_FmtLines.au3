#include <GuiEdit.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

$Debug_Ed = False ; 检查传递给 Edit 函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

_Main()

Func _Main()
	Local $hEdit
	Local $sWow64 = ""
	If @AutoItX64 Then $sWow64 = "\Wow6432Node"
	Local $sFile = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE" & $sWow64 & "\AutoIt v3\AutoIt", "InstallDir") & "\include\_ReadMe_.txt"
	Local $sBefore, $sAfter

	; 创建 GUI
	GUICreate("Edit FmtLines", 400, 300)
	$hEdit = GUICtrlCreateEdit("", 2, 2, 394, 268, BitOR($ES_WANTRETURN, $WS_VSCROLL))
	GUISetState()

	; 设置文本
	_GUICtrlEdit_SetText($hEdit, FileRead($sFile, 500))

	; 获取默认格式的文本
	$sBefore = _GUICtrlEdit_GetText($hEdit)

	; 插入软断行符
	_GUICtrlEdit_FmtLines($hEdit, True)

	; 带有软断行符的文本
	$sAfter = _GUICtrlEdit_GetText($hEdit)

	MsgBox(4096, "Information", "Before:" & @LF & @LF & $sBefore & @LF & _
			'--------------------------------------------------------------' & @LF & _
			"After:" & @LF & @LF & $sAfter)

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main
