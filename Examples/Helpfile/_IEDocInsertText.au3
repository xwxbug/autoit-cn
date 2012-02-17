; *******************************************************
; 示例 1 - 打开含基本示例页面的浏览器, 插入文本到
;		首个 Paragraph 标签内部和周围并显示 HTML 主体
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("basic")
Local $oP = _IETagNameGetCollection($oIE, "p", 0)

_IEDocInsertText($oP, "(Text beforebegin)", "beforebegin")
_IEDocInsertText($oP, "(Text afterbegin)", "afterbegin")
_IEDocInsertText($oP, "(Text beforeend)", "beforeend")
_IEDocInsertText($oP, "(Text afterend)", "afterend")

ConsoleWrite(_IEBodyReadHTML($oIE) & @CRLF)

; *******************************************************
; 示例 2 - 插入 HTML 到 document 的顶部和底部
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("basic")
Local $oBody = _IETagNameGetCollection($oIE, "body", 0)
_IEDocInsertText($oBody, "This Text is inserted After Begin", "afterbegin")
_IEDocInsertText($oBody, "Notice that <b>Tags</b> are <encoded> before display", "beforeend")


; *******************************************************
; 示例 3 - 高级示例
;		当浏览新地址时在每页顶部插入一个时钟及一个引用字符串,
;		使用_IEDocInsertText, _IEDocInsertHTML及
;		_IEPropertySet设置"innerhtml"及"referrer"
; *******************************************************

#include <IE.au3>

$oIE = _IECreate("http://www.autoitscript.com")

AdlibRegister("UpdateClock", 1000) ; 每秒更新时钟一次

; 只有浏览器窗口还存在则空闲
While WinExists(_IEPropertyGet($oIE, "hwnd"))
	Sleep(10000)
WEnd

Exit

Func UpdateClock()
	Local $curTime = "<b>Current Time is: </b>" & @HOUR & ":" & @MIN & ":" & @SEC
	; 预期中在导航后 _IEGetObjByName 会返回 NoMatch 错误
	;   (插入 DIV 之前), 所以临时关闭通告
	_IEErrorNotify(False)
	Local $oAutoItClock = _IEGetObjByName($oIE, "AutoItClock")
	If Not IsObj($oAutoItClock) Then ; 如果没有找到则插入 DIV 元素
		;
		; 获取到 BODY 的引用, 插入 DIV, 获取到 DIV 的引用, 更新时间
		Local $oBody = _IETagNameGetCollection($oIE, "body", 0)
		_IEDocInsertHTML($oBody, "<div id='AutoItClock'></div>", "afterbegin")
		$oAutoItClock = _IEGetObjByName($oIE, "AutoItClock")
		_IEPropertySet($oAutoItClock, "innerhtml", $curTime)
		;
		; 检查引用字符串, 如果非空插入到时间后
		_IELoadWait($oIE)
		Local $sReferrer = _IEPropertyGet($oIE, "referrer")
		If $sReferrer Then _IEDocInsertText($oAutoItClock, _
				"  Referred by: " & $sReferrer, "afterend")
	Else
		_IEPropertySet($oAutoItClock, "innerhtml ", $curTime) ; 更新时间
	EndIf
	_IEErrorNotify(True)
EndFunc   ;==>UpdateClock
