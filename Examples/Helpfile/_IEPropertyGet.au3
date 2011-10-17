 
 ; ******************************************************* 
 ; 示例 - 打开一个带示例的浏览器, 查看地址栏是否可见, 如果可见则关闭, 不可见则打开 
 ; ******************************************************* 
 #include  <IE.au3> 
 $oIE  =  _IE_Example  ( "basic" ) 
 If  _IEPropertyGet  ( $oIE ,  "addressbar" )  Then 
     MsgBox ( 0 ,  "AddressBar Status" ,  "AddressBar Visible, turning it off" ) 
     _IEPropertySet  ( $oIE ,  "addressbar" ,  False ) 
 Else 
     MsgBox ( 0 ,  "AddressBar Status" ,  "AddressBar Invisible, turning it on" ) 
     _IEPropertySet  ( $oIE ,  "addressbar" ,  True ) 
 EndIf  

