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

	; 创建虚拟缓存组
	Global $iCacheGroupID = _WinINet_CreateUrlCacheGroup()

	; 设置缓存组名称
	Global $avCacheGroupInfo[6] = [0, "Dummy Group "]
	Global $tCacheGroupInfo = _WinINet_Struct_InternetCacheGroupInfo_FromArray($avCacheGroupInfo)
	_WinINet_SetUrlCacheGroupAttribute($iCacheGroupID, $CACHEGROUP_ATTRIBUTE_GROUPNAME, DllStructGetPtr($tCacheGroupInfo))

	; 获取缓存组名称
	$avCacheGroupInfo = _WinINet_GetUrlCacheGroupAttribute($iCacheGroupID, $CACHEGROUP_ATTRIBUTE_GET_ALL)

	; 输出缓存组信息
	For $i = 0 To UBound($avCacheGroupInfo) - 1
		MemoWrite( StringFormat(" --> [%d]: %s ", $i, $avCacheGroupInfo[$i]))
	Next

	; 删除缓存组
	_WinINet_DeleteUrlCacheGroup($iCacheGroupID, $CACHEGROUP_FLAG_FLUSHURL_ONDELETE)

	; 关闭句柄
	_WinINet_Shutdown()

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

