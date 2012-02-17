; *******************************************************
; 示例1 - 打开带有基本示例页的浏览器, 将事件脚本插入到文档头部, 
; 使得在点击文档时发出JavaScript提醒
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("basic")
_IEHeadInsertEventScript($oIE, "document", "onclick", "alert('Someone clicked the document!');")

; *******************************************************
; 示例2 - 打开带有基本示例页的浏览器, 将事件脚本插入到文档头部, 
; 使得在右击文档时发出JavaScript提醒,
; 然后事件脚本返回"false"以阻止右击出现的上下文菜单
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("basic")
_IEHeadInsertEventScript($oIE, "document", "oncontextmenu", "alert('No Context Menu');return false")

; *******************************************************
; 示例3 - 打开带有基本示例页的浏览器, 
; 当离开浏览页时将事件脚本插入到文档头部并提供取消操作的选项.
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("basic")
_IEHeadInsertEventScript($oIE, "window", "onbeforeunload", _
		"alert('Example warning follows...');return 'Pending changes may be lost';")
_IENavigate($oIE, "www.autoitscript.com")

; *******************************************************
; 示例4 - 打开带有基本示例页的浏览器, 
; 将事件脚本插入到文档头部以阻止在文档中选取文本
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example()
_IEHeadInsertEventScript($oIE, "document", "ondrag", "return false;")
_IEHeadInsertEventScript($oIE, "document", "onselectstart", "return false;")

; *******************************************************
; 示例5 - 以AutoIt主页打开浏览器, 
; 将事件脚本插入到文档头部以阻止浏览任一链接的点击并将点击的链接地址记录到控制台
; *******************************************************

#include <IE.au3>

$oIE = _IECreate("http://www.autoitscript.com")
Local $oLinks = _IELinkGetCollection($oIE)
For $oLink In $oLinks
	Local $sLinkId = _IEPropertyGet($oLink, "uniqueid")
	_IEHeadInsertEventScript($oIE, $sLinkId, "onclick", "return false;")
	ObjEvent($oLink, "_Evt_")
Next

While 1
	Sleep(100)
WEnd

Func _Evt_onClick()
	Local $o_link = @COM_EventObj
	ConsoleWrite($o_link.href & @CRLF)
EndFunc   ;==>_Evt_onClick
