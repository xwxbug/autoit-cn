; *******************************************************
; 示例1 - 创建打开了AutoIt主页的浏览器, 获取页面上第6幅图像的引用(注: 首个图像的索引为0), 并显示其信息
; *******************************************************
#include  <IE.au3>
$oIE = _IECreate(" http://www.autoitscript.com/ ")
$oImg = _IEImgGetCollection($oIE, 5)
$sInfo = " Src:" & $oImg .src & @CR
$sInfo & = " FileName:" & $oImg .nameProp & @CR
$sInfo & = " Height:" & $oImg .height & @CR
$sInfo & = " Width:" & $oImg .width & @CR
$sInfo & = " Border:" & $oImg .border
msgbox(0, "4th Image Info ", $sInfo)

; *******************************************************
; 示例2 - 创建打开了AutoIt主页的浏览器, 获取Img集并显示源地址
; *******************************************************
#include  <IE.au3>
$oIE = _IECreate(" http://www.autoitscript.com/ ")
$oImgs = _IEImgGetCollection($oIE)
$iNumImg = @extended
msgbox(0, "Img Info ", "There are" & $iNumImg & " images on the page ")
For $oImg In $oImgs
	msgbox(0, "Img Info  ", "src=" & $oImg .src)
Next

