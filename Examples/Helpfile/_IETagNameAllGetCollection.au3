 ; ******************************************************* 
 ; 打开带有基本示例的浏览器, 获取所有元素的集合并显示每个标签名及innerText 
 ; ******************************************************* 
 #include  <IE.au3> 
 $oIE = _IE_Example ( " basic " ) 
 $oElements = IETagNameAllGetCollection $oIE ) 
 For $oElement In $oElements 
   MsgBox ( 0 , " Element info ", " Tagname: " & $oElement .form.tagname  & " innerText: " & $oElement .innerText) 
 Next 
 
