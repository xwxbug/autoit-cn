#include <IE.au3>

; *******************************************************
; 示例 1 - 创建浏览器窗口并导航到某个站点
; *******************************************************

Local $oIE = _IECreate("www.autoitscript.com")

; *******************************************************
; 示例 2 - 创建指向 3 个不同 URL 的新浏览器窗口
;				如果某个还不存在 ($f_tryAttach = 1)
;				不等待网页加载完成 ($f_wait = 0)
; *******************************************************

_IECreate("www.autoitscript.com", 1, 1, 0)
_IECreate("my.yahoo.com", 1, 1, 0)
_IECreate("www.google.com", 1, 1, 0)

; *******************************************************
; 示例 3 - 尝试附加到显示特殊网站 URL 的现有的浏览器
;				如果不存在, 则创建新浏览器并导航到那站点
; *******************************************************

$oIE = _IECreate("www.autoitscript.com", 1)
; 检查 @extended 返回值以判断附加是否成功
If @extended Then
	MsgBox(4096, "", "Attached to Existing Browser")
Else
	MsgBox(4096, "", "Created New Browser")
EndIf

; *******************************************************
; 示例 4 - 创建空的浏览器窗口并加载自定义的 HTML
; *******************************************************

$oIE = _IECreate()
Local $sHTML = "<h1>Hello World!</h1>"
_IEBodyWriteHTML($oIE, $sHTML)

; *******************************************************
; 示例 5 - 创建附加到 iexplore.exe 新实例的浏览器窗口
;				要获取新会话 cookie 内容时常常需要这样做
;				(会话 cookies 在共享相同的 iexplore.exe 的所有浏览器实例中共享)
; *******************************************************

ShellExecute("iexplore.exe", "about:blank")
WinWait("Blank Page")
$oIE = _IEAttach("about:blank", "url")
_IELoadWait($oIE)
_IENavigate($oIE, "www.autoitscript.com")
