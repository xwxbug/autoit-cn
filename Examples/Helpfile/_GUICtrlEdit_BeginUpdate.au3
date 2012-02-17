#include <GuiEdit.au3>
#include <GUIConstantsEx.au3>

$Debug_Ed = False ; 检查传递给 Edit 函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

_Main()

Func _Main()
	Local $hEdit, $hStatusBar, $hGUI
	Local $sWow64 = ""
	If @AutoItX64 Then $sWow64 = "\Wow6432Node"
	Local $sFile = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE" & $sWow64 & "\AutoIt v3\AutoIt", "InstallDir") & "\include\_ReadMe_.txt"

	; 创建 GUI
	$hGUI = GUICreate("Edit Begin Update", 400, 300)
	$hEdit = GUICtrlCreateEdit("", 2, 2, 394, 268)
	$hStatusBar = _GUICtrlStatusBar_Create($hGUI, -1)
	GUISetState()

	_GUICtrlEdit_BeginUpdate($hEdit)
	_GUICtrlEdit_SetText($hEdit, FileRead($sFile))
	_GUICtrlEdit_EndUpdate($hEdit)

	_GUICtrlStatusBar_SetIcon($hStatusBar, 0, 97, "shell32.dll")
	_GUICtrlStatusBar_SetText($hStatusBar, @TAB & "Lines: " & _GUICtrlEdit_GetLineCount($hEdit))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main
