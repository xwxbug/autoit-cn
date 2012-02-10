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

	; 查找所有缓存项中的第一个
	Global $avCacheEntry = _WinINet_FindFirstUrlCacheEntry()

	If Not @error Then
		; 将数据存入返回的数组
		Global $hCacheEntry = $avCacheEntry[0]
		Global $avCacheEntryInfo = $avCacheEntry[1]
		$avCacheEntry = 0

		While Not @error
			; 输出当前找到的缓存值
			MemoWrite(" ---------- ")
			For $i = 0 To UBound($avCacheGroupInfo) - 1
				MemoWrite( StringFormat(" --> [%d]: %s ", $i, $avCacheGroupInfo[$i]))
			Next
			MemoWrite(" ----------" & @CRLF)

			; 查找下一缓存项
			$avCacheEntryInfo = _WinINet_FindNextUrlCacheEntry($hCacheEntry)
		Wend
	EndIf

	; 关闭句柄
	_WinINet_FindCloseUrlCache($hCacheEntry)

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

