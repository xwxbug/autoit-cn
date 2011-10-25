#include <GuiConstantsEx.au3>
#include <WinApiEx.au3>
#include <WindowsConstants.au3>

Global $iMemo, $List[10]
Global $tSTORAGEDEVICENUMBER

_Main()

Func _Main()
	Local $hGUI, $Drive

	; 创建界面
	$hGUI = GUICreate(" Drive Num ", 400, 300)

	; 创建memo控件
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New ")
	GUISetState()

	; 获取硬盘信息
	$Drive = DriveGetDrive(" FIXED ")

	; 获取硬盘总线信息
	For $i = 0 To UBound($Drive) - 1
		$List[$i] = ''
	Next
	If IsArray($Drive) Then
		For $i = 1 To $Drive[0]
			$tSTORAGEDEVICENUMBER = _WinAPI_GetDriveNumber($Drive[$i])
			If Not @error Then
				$List[DllStructGetData($tSTORAGEDEVICENUMBER, 'DeviceNumber')] &= StringUpper($Drive[$i]) & ''
			EndIf
		Next
	EndIf
	For $i = 0 To UBound($Drive) - 1
		If $List[$i] > '' Then
			MemoWrite('Drive' & $i & '  ==>' & $List[$i])
		EndIf
	Next
	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

