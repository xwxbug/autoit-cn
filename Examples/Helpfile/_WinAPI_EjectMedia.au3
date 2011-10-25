#include <GuiConstantsEx.au3>
#include <WinApiEx.au3>
#include <WindowsConstants.au3>

Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $Drive = DriveGetDrive('CDROM')

	; 创建界面
	$hGUI = GUICreate(" Processor Info ", 400, 300)

	; 创建memo控件
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New ")
	GUISetState()

	If IsArray($Drive) Then
		MemoWrite('Open...')
		_WinAPI_EjectMedia($Drive[1])
		MemoWrite('Tray is open:' & _WinAPI_IsDoorOpen($Drive[1]))
		Sleep(1000)
		MemoWrite('Close...')
		_WinAPI_LoadMedia($Drive[1])
		MemoWrite('Tray is open:' & _WinAPI_IsDoorOpen($Drive[1]))
	EndIf

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

