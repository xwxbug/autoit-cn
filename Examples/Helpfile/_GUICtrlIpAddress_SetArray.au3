
#include  <GuiConstantsEx.au3>
#include  <GuiIPAddress.au3>

Opt("MustDeclareVars", 1)

$Debug_IP = False ; 检查传递给函数的类名,
设置为真且使用另一控件的句柄观察其工作
Global $iMemo

_Main()

Func _Main()
	Local $hgui, $aIP[4] = [24, 168, 2, 128], $hIPAddress

	$hgui = GUICreate( "IP Address
	Control Set(Array) 示例" ,  400 ,  300 )

	$hIPAddress = _GUICtrlIpAddress_Create($hgui, 2, 4, 125, 20)

	$iMemo = GUICtrlCreateEdit("", 2, 28, 396, 270, 0)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")

	GUISetState(@SW_SHOW)


	_GUICtrlIpAddress_SetArray($hIPAddress, $aIP)

	$aIP = _GUICtrlIpAddress_GetArray($hIPAddress)

	MemoWrite("Field 1 .....:" & $aIP[0])
	MemoWrite("Field 2 .....:" & $aIP[1])
	MemoWrite("Field 3 .....:" & $aIP[2])
	MemoWrite("Field 4 .....:" & $aIP[3])

	;
	等待用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; Write a line to the memo
control
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite


