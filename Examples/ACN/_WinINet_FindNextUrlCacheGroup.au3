#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#Include <WinINet.au3>

Global $iMemo

_Main()

Func _Main()
	Local $hGUI

	; 创建界面
	$hGUI = GUICreate(" _WinINet_UrlCache ", 600, 400)

	; 创建memo控件
	$iMemo = GUICtrlCreateEdit("", 2, 2, 596, 396, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New ")
	GUISetState()

	; 初始化WinINet
	_WinINet_Startup()

	; 创建多个虚拟缓存组
	Global $iGroupIDCount = 10
	Global $aiCacheGroupIDs[$iGroupIDCount]
	For $i = 0 To $iGroupIDCount - 1
		$aiCacheGroupIDs[$i] = _WinINet_CreateUrlCacheGroup()
	Next

	; 枚举缓存组
	Global $avCacheGroup = _WinINet_FindFirstUrlCacheGroup()
	While Not @error
		MemoWrite($avCacheGroup[1])
		$avCacheGroup[1] = _WinINet_FindNextUrlCacheGroup($avCacheGroup[0])
	Wend

	; 删除缓存组
	For $i = 0 To $iGroupIDCount - 1
		_WinINet_DeleteUrlCacheGroup($aiCacheGroupIDs[$i], $CACHEGROUP_FLAG_FLUSHURL_ONDELETE)
	Next

	; 清除
	_WinINet_Shutdown()

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

