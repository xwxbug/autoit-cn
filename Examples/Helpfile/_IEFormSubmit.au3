同样 , 某些表单依赖其他表单元素传递的提交按钮值(经常出现在不止一个提交按钮并且用于提交不同的结果).
这个函数无法解决,解决方法和上面一样用_IEAction()中的"click"动作. 
如果你在使用自动的_IELoadWait遇到问题的时候 , 请设置"等待"参数为0 , 并且从脚本里面调用_IELoadWait , 传递到IE对象. 

 
   
相关 _IEFormReset , _IEFormGetObjByName , _IEFormGetCollection , _IEFormElementGetObjByName , _IEFormElementGetCollection , _IELoadWait  
   
示例  
 ; ******************************************************* 
 ; 示例 1 - 打开带表单示例的浏览器, 填写表单字段并提交 
 ; ******************************************************* 
 ; 
 #include  <IE.au3> 
 $oIE = _IE_Example ( " form " ) 
 $oForm = _IEFormGetObjByName ( $oIE , " Example Form " ) 
 $oText = _IEFormElementGetObjByName ( $oForm , " text Example " ) 
 _IEFormElementSetValue ( $oText , " Hey! It works! " ) 
 _IEFormSubmit ( $oForm ) 
 
 ; ******************************************************* 
 ; 示例 2 - 获取指定表单的引用并设置值. 该例中, 向Google搜索引擎提交请求 
 ; ******************************************************* 
 ; 
 #include  <IE.au3> 
 $oIE = _IECreate ( " http://www.google.com " ) 
 $oForm = _IEFormGetObjByName ( $oIE , " f " ) 
 $oQuery = _IEFormElementGetObjByName ( $oForm , " q " ) 
 _IEFormElementSetValue ( $oQuery , " AutoIt IE.au3 " ) 
 _IEFormSubmit ( $oForm ) 
 
 ; ******************************************************* 
 ; 示例 3 - 获取指定表单的引用并设置值. 遇到困难时手工调用_IELoadWait. 
 ; ******************************************************* 
 ; 
 #include  <IE.au3> 
 $oIE  = _IECreate ( " http://www.google.com " ) 
 $oForm = _IEFormGetObjByName ( $oIE , " f " ) 
 $oQuery = _IEFormElementGetObjByName ( $oForm , " q " ) 
 _IEFormElementSetValue ( $oQuery , " AutoIt IE.au3 " ) 
 _IEFormSubmit ( $oForm , 0 ) 
 _IELoadWait ( $oIE ) 
 
