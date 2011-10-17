 ; ******************************************************* 
 ; 示例 - 打开带有表单示例的浏览器, 填充表单并重新设置为默认值 
 ; ******************************************************* 
 #include  <IE.au3> 
 $oIE = _IE_Example ( " form " ) 
 $oForm = _IEFormGetObjByName ( $oIE , " Example Form " ) 
 $oText = _IEFormElementGetObjByName ( $oForm , " textExample " ) 
 _IEFormElementSetValue $oText , " Hey! It works! " ) 
 _IEFormReset $oForm ) 
 
