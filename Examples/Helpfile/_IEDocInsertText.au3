; *******************************************************
; Example 1 - Open a browser with the basic example page, insert text
;		in and around the first Paragraph tag and display Body HTML
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
; 示例2 - 在文档顶部和底部插入HTML
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("basic")
Local $oBody = _IETagNameGetCollection($oIE, "body", 0)
_IEDocInsertText($oBody, "This Text is inserted After Begin", "afterbegin")
_IEDocInsertText($oBody, "Notice that <b>Tags</b> are <encoded> before display", "beforeend")


; *******************************************************
; 示例3 - 高级示例
;		当浏览新地址时在每页顶部插入一个时钟及一个引用字符串,
;		使用_IEDocInsertText, _IEDocInsertHTML及
;		_IEPropertySet设置"innerhtml"及"referrer"
; *******************************************************

#include <IE.au3>

$oIE = _IECreate("http://www.autoitscript.com")

AdlibRegister(" UpdateClock ", 1000) ; 每秒更新时钟

; 浏览器窗口存在时空置
While WinExists(_IEPropertyGet($oIE, "hwnd"))
	Sleep(10000)
WEnd

Exit

Func UpdateClock()
	Local $curTime = "<b>Current Time is: </b>" & @HOUR & ":" & @MIN & ":" & @SEC
	; 在浏览后_IEGetObjByName预期返回NoMatch错误(插入DIV前), 因而暂时关闭通知
	_IEErrorNotify(False)
	Local $oAutoItClock = _IEGetObjByName($oIE, "AutoItClock")
	If Not IsObj($oAutoItClock) Then ; 如果未找到DIV元素则插入
		;
		; 获得BODY的引用, 插入DIV, 获得DIV引用, 更新时间
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
