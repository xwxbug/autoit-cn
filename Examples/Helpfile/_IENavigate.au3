; *******************************************************
; 示例1 - 创建浏览器窗口并浏览一个网址, 等待5秒后浏览另一个, 再等待5秒浏览另一个
; *******************************************************
;
#include <IE.au3>
$oIE = _IECreate(" www.autoitscript.com ")
Sleep(5000)
_IENavigate($oIE, "http://www.autoitscript.com/forum/index.php? ")
Sleep(5000)
_IENavigate($oIE, "http://www.autoitscript.com/forum/index.php?showforum=9 ")

; *******************************************************
; 示例2 - 创建浏览器窗口并浏览一个网址, 在移动到下一行前不等待页面加载完成
; *******************************************************
;
#include <IE.au3>
$oIE = _IECreate(" www.autoitscript.com ", 0)
msgbox(0, "_IENavigate() ", "This code executes immediately ")

