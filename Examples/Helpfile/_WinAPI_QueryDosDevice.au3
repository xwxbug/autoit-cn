#include <GuiConstantsEx.au3>
#include <WinApiEx.au3>
#include <WindowsConstants.au3>

Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $Drive = DriveGetDrive('ALL')

	; 创建界面
	$hGUI = GUICreate(" Dos Disk Devices ", 400, 300)

	; 创建memo控件
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New ")
	GUISetState()

	; 获取磁盘设备
	If IsArray($Drive) Then
		For $i = 1 To $Drive[0]
			MemWrite( StringUpper($Drive[$i]) & ' =>' & _WinAPI_QueryDosDevice($Drive[$i]))
		Next
	EndIf

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

