; *******************************************************
; 示例 1 - 创建浏览器并打开 AutoIt 主页, 获取到
;				页面中第 6 幅图像的引用 (注意: 首幅图像索引为 0)
;				并显示其信息
; *******************************************************

#include <IE.au3>

Local $oIE = _IECreate("http://www.autoitscript.com/")
Local $oImg = _IEImgGetCollection($oIE, 5)
Local $sInfo = "Src: " & $oImg.src & @CR
$sInfo &= "FileName: " & $oImg.nameProp & @CR
$sInfo &= "Height: " & $oImg.height & @CR
$sInfo &= "Width: " & $oImg.width & @CR
$sInfo &= "Border: " & $oImg.border
MsgBox(4096, "4th Image Info", $sInfo)

; *******************************************************
; 示例 2 - 创建浏览器并打开 AutoIt 主页, 获取 Img 集合
;				并显示其中每个的源 URL
; *******************************************************

#include <IE.au3>

$oIE = _IECreate("http://www.autoitscript.com/")
Local $oImgs = _IEImgGetCollection($oIE)
Local $iNumImg = @extended
MsgBox(4096, "Img Info", "There are " & $iNumImg & " images on the page")
For $oImg In $oImgs
	MsgBox(4096, "Img Info", "src=" & $oImg.src)
Next
