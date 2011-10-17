 ; ******************************************************* 
 ; 示例 - 打开带有基本示例的浏览器, 读取HTML文档(所有包含<HEAD>的HTML及脚本)并在消息框中显示 
 ; ******************************************************* 
 #include  <IE.au3> 
 $oIE = _IE_Example ( " basic " ) 
 $sHTML = _IEDocReadHTML ( $oIE ) 
 MsgBox ( 0 , " Document Source ", $sHTML ) 
 
