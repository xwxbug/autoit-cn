 ; ******************************************************* 
 ; 示例1 - 打开一个带有表示例的浏览器, 获取对页面(索引1)上第二张表的引用并将其内容读入2-D数组 
 ; ******************************************************* 
 #include  <IE.au3> 
 $oIE = _IE_Example ( " table " ) 
 $otable = _IEtableGetCollection ( $oIE , 1 ) 
 $atableData = _IEtableWriteToArray ( $otable ) 
 
 ; ******************************************************* 
 ; 示例2 - 与示例1相同, 除了在显示结果时用_ArrayDisplay()函数交换数组坐标 
 ; ******************************************************* 
 #include  <IE.au3> 
 #include  <Array.au3> 
 $oIE = _IE_Example ( " table " ) 
 $otable = _IEtableGetCollection ( $oIE , 1 ) 
 $atableData = _IEtableWriteToArray ( $otable , True ) 
 _ArrayDisplay ( $atableData ) 
 
