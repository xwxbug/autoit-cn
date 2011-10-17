 ; ******************************************************* 
 ; 示例1 - 打开带有表示例的浏览器, 获取对页面(索引0)上第二张表的引用并将其内容读入2-D数组 
 ; ******************************************************* 
 ; 
 #include  <IE.au3> 
 $oIE = _IE_Example ( " table " ) 
 $otable = _IEtableGetCollection ( $oIE , 0 ) 
 $atableData = _IEtableWriteToArray ( $otable ) 
 
 ; ******************************************************* 
 ; 示例2 - 打开带有表示例的浏览器, 获取对表集合的引用并显示页中表的数量 
 ; ******************************************************* 
 #include  <IE.au3> 
 $oIE = _IE_Example ( " table " ) 
 $otable = _IEtableGetCollection ( $oIE ) 
 $iNumtables = @extended 
 MsgBox ( 0 , " table Info ", " There are " & $iNumtables & " tables on the page " ) 
 
