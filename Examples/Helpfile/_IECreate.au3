; *******************************************************
; 示例1 - 创建浏览器窗体并浏览网址
; *******************************************************
#include  <IE.au3>
$oIE = _IECreate(" www.autoitscript.com ")

; *******************************************************
; 示例2 - 创建分别指向3个不同地址的浏览器窗体
;    如果一个已不存在($f_tryAttach = 1)不等待页面加载($f_wait = 0)
; *******************************************************
#include  <IE.au3>
_IECreate(" www.autoitscript.com ", 1, 1, 0)
_IECreate(" my.yahoo.com ", 1, 1, 0)
_IECreate(" www.google.com ", 1, 1, 0)

; *******************************************************
; 示例3 - 尝试获取已存在的显示指定网址的浏览器
;    如果不存在则新建浏览器并浏览该地址
; *******************************************************
#include  <IE.au3>
$oIE = _IECreate(" www.autoitscript.com ", 1)
; 检查@extended返回值查看获取是否成功
If @extended Then
	msgbox(0, "", "Attached to Existing Browser ")
Else
	msgbox(0, "", "Created New Browser ")
EndIf

; *******************************************************
; 示例4 - 创建空白的浏览器窗口并以自定义HTML填充
;*******************************************************
#include  <IE.au3>
$oIE = _IECreate()
$sHTML = " <h1>Hello World!</h1> "
_IEBodyWriteHTML($oIE, $sHTML)

; *******************************************************
; 示例5 - 创建隐藏的浏览器窗口, 浏览网址, 获取信息并退出
; *******************************************************
#include  <IE.au3>
$oIE = _IECreate(" http://sourceforge.net ", 0, 0)
; 显示页面中名称为"sfmarquee"元素的innerText
$oMarquee = _IEGetObjByName($oIE, "sfmarquee ")
msgbox(0, "SourceForge Information ", $oMarquee .innerText)
_IEQuit($oIE)

; *******************************************************
; 示例6 - 新建获取iexplore.exe实例的浏览器窗口. 常用于获取新会话缓存的上下文.
;    (会话上下文被所有相同的iexplore.exe共享的浏览器实例共享)
; *******************************************************
#include  <IE.au3>
ShellExecute(" iexplore.exe ", "about:blank ")
WinWait(" Blank Page ")
$oIE = _IEAttach(" about:blank ", "url ")
_IELoadWait($oIE)
_IENavigate($oIE, "www.autoitscript.com ")

