; *******************************************************
; 示例1 - 在文档顶部和底部插入HTML
; *******************************************************

#include <IE.au3>

Local $oIE = _IECreate("http://www.autoitscript.com")
Local $oBody = _IETagNameGetCollection($oIE, "body", 0)
_IEDocInsertHTML($oBody, "<h2>This HTML is inserted After Begin</h2>", "afterbegin")
_IEDocInsertHTML($oBody, "<h2>This HTML is inserted Before End</h2>", "beforeend")

; *******************************************************
; 示例2 - 打开带有基本示例页的浏览器, 
; 插入在名为"IEAu3Data"的DIV标记周围插入HTML并显示
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("basic")
Local $oDiv = _IEGetObjByName($oIE, "IEAu3Data")

_IEDocInsertHTML($oDiv, "<b>(HTML beforebegin)</b>", "beforebegin")
_IEDocInsertHTML($oDiv, "<i>(HTML afterbegin)</i>", "afterbegin")
_IEDocInsertHTML($oDiv, "<b>(HTML beforeend)</b>", "beforeend")
_IEDocInsertHTML($oDiv, "<i>(HTML afterend)</i>", "afterend")

ConsoleWrite(_IEBodyReadHTML($oIE) & @CRLF)

; *******************************************************
; 示例3 - 高级示例:当浏览新地址时在每页顶部插入一个时钟及一个引用字符串,
; 使用_IEDocInsertText, _IEDocInsertHTML及_IEPropertySet设置"innerhtml"及"referrer "
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
