#include  <GuiConstantsEx.au3>
#include  <WinApiEx.au3>
#include  <WindowsConstants.au3>

Global $iMemo, $hGUI

_Main()

Func _Main()

	; 创建界面
	$hGUI = GUICreate("Special Path", 400, 300)

	; 创建memo控件
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 获取信息
	MemWrite('Windows =>' & _WinAPI_ShellGetSpecialFolderPath($CSIDL_WINDOWS) & @CR)
	MemWrite('System =>' & _WinAPI_ShellGetSpecialFolderPath($CSIDL_SYSTEM) & @CR)
	MemWrite('Fonts =>' & _WinAPI_ShellGetSpecialFolderPath($CSIDL_FONTS) & @CR)
	MemWrite('Program Files =>' & _WinAPI_ShellGetSpecialFolderPath($CSIDL_PROGRAM_FILES) & @CR)
	MemWrite('Profile =>' & _WinAPI_ShellGetSpecialFolderPath($CSIDL_PROFILE) & @CR)
	MemWrite('My Documents =>' & _WinAPI_ShellGetSpecialFolderPath($CSIDL_PERSONAL) & @CR)
	MemWrite('Start Menu =>' & _WinAPI_ShellGetSpecialFolderPath($CSIDL_STARTMENU) & @CR)
	MemWrite('Favorites =>' & _WinAPI_ShellGetSpecialFolderPath($CSIDL_FAVORITES) & @CR)
	MemWrite('Desktop =>' & _WinAPI_ShellGetSpecialFolderPath($CSIDL_DESKTOP) & @CR)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

