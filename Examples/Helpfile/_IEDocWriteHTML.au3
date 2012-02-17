; *******************************************************
; 示例 - 创建空白浏览器并写入自定义 - 此例中为一个框架集 - 然后更新每个框架的内容
; *******************************************************

#include <IE.au3>

Local $oIE = _IECreate()
Local $sHTML = ""
$sHTML &= "<HTML>" & @CR
$sHTML &= "<HEAD>" & @CR
$sHTML &= "<TITLE>_IE_Example('frameset')</TITLE>" & @CR
$sHTML &= "</HEAD>" & @CR
$sHTML &= "<FRAMESET rows='25,200'>" & @CR
$sHTML &= " <FRAME NAME=Top SRC=about:blank>" & @CR
$sHTML &= " <FRAMESET cols='100,500'>" & @CR
$sHTML &= "   <FRAME NAME=Menu SRC=about:blank>" & @CR
$sHTML &= "   <FRAME NAME=Main SRC=about:blank>" & @CR
$sHTML &= " </FRAMESET>" & @CR
$sHTML &= "</FRAMESET>" & @CR
$sHTML &= "</HTML>"
_IEDocWriteHTML($oIE, $sHTML)
_IEAction($oIE, "refresh")
Local $oFrameTop = _IEFrameGetObjByName($oIE, "Top")
Local $oFrameMenu = _IEFrameGetObjByName($oIE, "Menu")
Local $oFrameMain = _IEFrameGetObjByName($oIE, "Main")
_IEBodyWriteHTML($oFrameTop, '$oFrameTop = _IEFrameGetObjByName($oIE, "Top")')
_IEBodyWriteHTML($oFrameMenu, '$oFrameMenu = _IEFrameGetObjByName($oIE, "Menu")')
_IEBodyWriteHTML($oFrameMain, '$oFrameMain = _IEFrameGetObjByName($oIE, "Main")')
