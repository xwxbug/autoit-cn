; *******************************************************
; 示例 - 打开AutoIt论坛页, "View new posts"标签, 连接并以Enter键激活. 然后在移动前等待页面加载完毕.
; *******************************************************
;
#include  <IE.au3>
$oI = _IECreate(" http://www.autoitscript.com/forum/index.php ")
Send(" {TAB 12} ")
Send(" {ENTER} ")
_IELoadWait($oIE)

