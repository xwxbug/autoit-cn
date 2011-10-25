#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#Include <WinINet.au3>

Global $iMemo

_Main()

Func _Main()
	Local $hGUI

	; 创建界面
	$hGUI = GUICreate(" _WinINet_CommitUrlCacheEntry ", 600, 400)

	; 创建memo控件
	$iMemo = GUICtrlCreateEdit("", 2, 2, 596, 396, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New ")
	GUISetState()

	; 初始化WinINet
	_WinINet_Startup()

	; 创建虚拟缓存项
	Global $sSourceUrlName = " http://www.autoitscript.com/ "
	Global $sLocalFileName = _WinINet_CreateUrlCacheEntry($sSourceUrlName)

	; 将虚拟缓存项提交到磁盘
	_WinINet_CommitUrlCacheEntry($sSourceUrlName, $sLocalFileName)

	; 获取缓存项信息
	Global $avCacheEntryInfo = _WinINet_GetUrlCacheEntryInfo($sSourceUrlName)

	; 打印缓存项信息
	For $i = 0 To UBound($avCacheEntryInfo) - 1
		MemoWrite('-->[' & $i & ' ]:' & $avCacheEntryInfo[$i])
	Next

	; 删除缓存项
	_WinINet_DeleteUrlCacheEntry($sSourceUrlName)

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

