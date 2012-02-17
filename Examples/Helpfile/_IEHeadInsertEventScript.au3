; *******************************************************
; 示例 1 - 打开含基本示例页面的浏览器, 插入
;				事件脚本到文档头, 其中创建了
;				当某个人点击文档时会弹出的 JavaScript 警告
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("basic")
_IEHeadInsertEventScript($oIE, "document", "onclick", "alert('Someone clicked the document!');")

; *******************************************************
; 示例 2 - 打开含基本示例页面的浏览器, 插入
;				事件脚本到文档头, 其中创建了
;				当某个人右击文档时会弹出的 JavaScript 警告
;				然后事件脚本返回 "false" 以阻止
;				右键上下文菜单出现
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("basic")
_IEHeadInsertEventScript($oIE, "document", "oncontextmenu", "alert('No Context Menu');return false")

; *******************************************************
; 示例 3 - 打开含基本示例页面的浏览器, 插入
;				事件脚本到文档头, 其中创建了
;				当我们即将从页面导航离开时的 JavaScript 警告
;				且出现取消操作的选项.
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("basic")
_IEHeadInsertEventScript($oIE, "window", "onbeforeunload", _
		"alert('Example warning follows...');return 'Pending changes may be lost';")
_IENavigate($oIE, "www.autoitscript.com")

; *******************************************************
; 示例 4 - 打开含基本示例页面的浏览器, 插入
;				事件脚本到文档头, 其中出现了
;				文档中选择的文本
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example()
_IEHeadInsertEventScript($oIE, "document", "ondrag", "return false;")
_IEHeadInsertEventScript($oIE, "document", "onselectstart", "return false;")

; *******************************************************
; 示例 5 - 在浏览器中打开 AutoIt 主页, 插入
;				事件脚本到文档头, 其中出现了
;				点击任何链接时的导航并记录被点击链接的 URL
;               到控制台
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
