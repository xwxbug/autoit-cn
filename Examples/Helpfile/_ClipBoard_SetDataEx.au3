#include <GUIConstantsEx.au3>
#include <Clipboard.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global $iMemo

_Main()

Func _Main()
	Local $btn_SetData, $btn_GetData, $hMemory, $hLock, $tData, $sData, $iSize

	; 创建 GUI
	GUICreate("Clipboard", 600, 450)
	$iMemo = GUICtrlCreateEdit("", 2, 2, 596, 396, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	$btn_SetData = GUICtrlCreateButton("Set ClipBoard Data", 150, 410, 120, 30)
	$btn_GetData = GUICtrlCreateButton("Get ClipBoard Data", 300, 410, 120, 30)
	GUISetState()

	; 循环直到用户退出
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $btn_SetData
				; 打开剪贴板
				If Not _ClipBoard_Open(0) Then _WinAPI_ShowError("_ClipBoard_Open failed")

				; 清空剪贴板
				If Not _ClipBoard_Empty() Then _WinAPI_ShowError("_ClipBoard_Empty failed")

				; 创建全局的内存缓冲区 (显示为什么使用 _ClipBoard_SetData 会更容易!)
				$sData = "Hello from AutoIt"
				$iSize = StringLen($sData) + 1
				$hMemory = _MemGlobalAlloc($iSize, $GHND)
				If $hMemory = 0 Then _WinAPI_ShowError("_Mem_GlobalAlloc failed")
				$hLock = _MemGlobalLock($hMemory)
				If $hLock = 0 Then _WinAPI_ShowError("_Mem_GlobalLock failed")
				$tData = DllStructCreate("char Text[" & $iSize & "]", $hLock)
				DllStructSetData($tData, "Text", $sData)
				_MemGlobalUnlock($hMemory)

				; 写入文本到剪贴板
				If Not _ClipBoard_SetDataEx($hMemory, $CF_TEXT) Then _WinAPI_ShowError("_ClipBoard_SetDataEx failed")

				; 关闭剪贴板
				_ClipBoard_Close()
			Case $btn_GetData
				MemoWrite(_ClipBoard_GetData())
		EndSwitch
	WEnd

EndFunc   ;==>_Main

; 写入消息到 memo
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
