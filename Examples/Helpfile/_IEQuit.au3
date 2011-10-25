_IEQuit不可以应用在_IECreateEmbedded创建的嵌入浏览器. 该浏览器进程将随他们上一层的GUI窗口关闭而关闭.


相关 _IEAttach, _IECreate

示例
; *******************************************************
; 示例 - 创建一个不可见的浏览器窗口, 浏览一个网址, 获取一些信息并退出
; *******************************************************
#include <IE.au3>
$oIE = _IECreate(" http://sourceforge.net ", 0, 0)
; 显示"sfmarquee"页面中一个元素上的innerTextage
$oMarquee = _IEGetObjByName($oIE, "sfmarquee ")
msgbox(0, "SourceForge Information ", $oMarquee .innerText)
_IEQuit($oIE)

