#include <GuiConstantsEx.au3>
#include <WinApiEx.au3>
#include <WindowsConstants.au3>

Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $info = _WinAPI_GetSystemInfo()

	; 创建界面
	$hGUI = GUICreate(" Processor Info ", 400, 300)

	; 创建memo控件
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New ")
	GUISetState()

	; 获取系统处理器和内存信息
	MemoWrite('ProcessorArchitecture =>' & $info[0])
	MemoWrite('PageSize =>' & $info[1])
	MemoWrite('MinimumApplicationAddress =>' & $info[2])
	MemoWrite('MaximumApplicationAddress =>' & $info[3])
	MemoWrite('ActiveProcessorMask =>' & $info[4])
	MemoWrite('NumberOfProcessors =>' & $info[5])
	MemoWrite('ProcessorType =>' & $info[6])
	MemoWrite('AllocationGranularity =>' & $info[7])
	MemoWrite('ProcessorLevel =>' & $info[8])
	MemoWrite('ProcessorRevision =>' & $info[9])

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

