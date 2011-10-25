; *******************************************************
; 示例1 - 打开标题为"AutoIt"的浏览器并显示网址
; *******************************************************
#include  <IE.au3>
$oIE = _IEAttach(" AutoIt ")
msgbox(0, "The URL ", _IEPropertyGet($oIE, "locationurl "))

; *******************************************************
; 示例2 - 打开顶层文档中包含"The quick brown fox"文本的浏览器
; *******************************************************
#include  <IE.au3>
$oIE = _IEAttach(" The quick brown fox ", "text ")

; *******************************************************
; 示例3 - 打开内嵌在另一窗口中的浏览器控件
; *******************************************************
;
#include  <IE.au3>
$oIE = _IEAttach(" A Window Title ", "embedded ")

; *******************************************************
; 示例4 - 打开第三个内嵌在另一窗口中的浏览器控件
;        使用高级窗口标题语法来使用第二个标题中带有'ICQ'字符串的窗口
; *******************************************************
#include  <IE.au3>
$oIE = _IEAttach(" [REGEXPTITLE:ICQ; INSTANCE:2] ", "embedded ", 3)

; *******************************************************
; 示例5 - 创建当前浏览器所有引用的实例对象的数组. 数组首个元素为实例数量
; *******************************************************
;
#include  <IE.au3>

Dim $aIE[1]
$aIE[0] = 0

$i = 1
While 1
	$oIE = _IEAttach(" ", "instance ", $i)
	If @error = $_IEStatus_NoMatch Then ExitLoop
	ReDim $aIE[$i + 1]
	$aIE[$i] = $oIE
	$aIE[0] = $i
	$i += 1
WEnd

msgbox(0, "Browsers Found ", "Number of browser instances in the array:" & $aIE[0])

