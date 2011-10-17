 ; ******************************************************* 
 ; 示例 - 打开显示AutoIt主页的浏览器窗口, 获取文档对象的引用并显示文档属性 
 ; ******************************************************* 
 #include <IE.au3> 
 $oIE = _IECreate ( " www.autoitscript.com " ) 
 $oDoc = _IEDocGetObj ( $oIE ) 
 MsgBox ( 0 , " Document Created Date ", $oDoc .fileCreateDate) 
 
