 ; ******************************************************* 
 ; 示例1 - 获取0基索引的指定表单的引用, 此例中为页中的首个表单 
 ; ******************************************************* 
 #include  <IE.au3> 
 $oIE = _IECreate ( " http://www.google.com " ) 
 $oForm = _IEFormGetCollection ( $oIE , 0 ) 
 $oQuery = _IEFormElementGetCollection ( $oForm , 1 ) 
 _IEFormElementSetValue ( $oQuery , " AutoIt IE.au3 " ) 
 _IEFormSubmit ( $oForm ) 
 
 ; ******************************************************* 
 ; 示例2 - 获取页中表单集合的引用, 并逐一显示每个表单的信息 
 ; ******************************************************* 
 #include  <IE.au3> 
 $oIE = _IECreate ( " http://www.google.com " ) 
 $oForms = _IEFormGetCollection ( $oIE ) 
 MsgBox ( 0 , " Forms Info ", " There are " & @extended & "  forms on this page " ) 
 For $oForm In $oForms 
   MsgBox ( 0 , " Form Info ", $oForm .name) 
 Next 
 
 ; ******************************************************* 
 ; 示例3 - 获取页中表单集合的引用, 并逐一显示每个表单的信息, 以演示表单索引的用法 
 ; ******************************************************* 
 #include  <IE.au3> 
 $oIE = _IECreate ( " http://www.google.com " ) 
 $oForms = _IEFormGetCollection ( $oIE ) 
 $iNumForms = @extended 
 MsgBox ( 0 , " Forms Info ", " There are  " & $iNumForms & "  forms on this page " ) 
 For $i = 0  to $iNumForms - 1 
   $oForm = _IEFormGetCollection ( $oIE , $i ) 
   MsgBox ( 0 , " Form Info ", $oForm .name) 
 Next 
 
