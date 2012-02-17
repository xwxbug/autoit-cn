; *******************************************************
; 示例 1 - 附加到标题中含 "AutoIt" 的浏览器, 显示其 URL
; *******************************************************

#include <IE.au3>

Local $oIE = _IEAttach("AutoIt")
MsgBox(4096, "The URL", _IEPropertyGet($oIE, "locationurl"))

; *******************************************************
; 示例 2 - 附加到顶级文档的文本中含 "The quick brown fox"
;				的浏览器
; *******************************************************

#include <IE.au3>

$oIE = _IEAttach("The quick brown fox", "text")

; *******************************************************
; 示例 3 - 附加到嵌入另一窗口的浏览器控件
; *******************************************************

#include <IE.au3>

$oIE = _IEAttach("A Window Title", "embedded")

; *******************************************************
; 示例 4 - 附加到嵌入另一窗口的第三个浏览器控件
;				使用高级窗口标题语法以便使用标题中
;				含有字符串 'ICQ' 的第二个窗口
; *******************************************************

#include <IE.au3>

$oIE = _IEAttach("[REGEXPTITLE:ICQ; INSTANCE:2]", "embedded", 3)

; *******************************************************
; 示例 5 - 创建到所有当前浏览器实例的对象引用的数组
;				首个数组元素将包含找到的实例数
; *******************************************************

#include <IE.au3>

Local $aIE[1]
$aIE[0] = 0

Local $i = 1
While 1
	$oIE = _IEAttach("", "instance", $i)
	If @error = $_IEStatus_NoMatch Then ExitLoop
	ReDim $aIE[$i + 1]
	$aIE[$i] = $oIE
	$aIE[0] = $i
	$i += 1
WEnd

MsgBox(4096, "Browsers Found", "Number of browser instances in the array: " & $aIE[0])
