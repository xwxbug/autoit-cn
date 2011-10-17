 
#include <IE.au3> 
_IE_Example ( [$s_module = 
"basic"] ) 
 
   
参数    
 $s_module  可选: 指定运行哪种模块 
basic = (默认)带有文字, 链接和图片的简单HTML页 
form = 带有多个表单元素(form)的简单HTML页 
frameset = 带有多框架(frames)的简单HTML页 
iframe = 带有内嵌浮动框架(iframes)的简单HTML页 
table = 带有表单(tables)的简单HTML页  
   
返回值    
 成功:  返回指向InternetExplorer.Application对象的对象变量  
 失败:  返回0 并且设置 @ERROR  
 @Error:  0 ($_IEStatus_Success) = 无错误  
  5 ($_IEStatus_InvalidValue) = 无效值  
 @Extended:  包含无效参数数量  
   
备注 这个函数显示带有HTML和HTML元素的网页,用在整个帮助文件和IE.au3的示例中.鼓励大家在测试IE.au3的时候也使用这个函数. 

 
   
相关 _IE_Introduction  
   
示例  
 ; ******************************************************* 
 ; 示例 - 创建带有要显示的示例页的浏览器窗口. 
 ;       返回的对象变量仅被用作由_IECreate或_IEAttach创建的对象变量 
 ; ******************************************************* 
 #include <IE.au3> 
 $oIE_basic = _IE_Example ( "basic" ) 
 $oIE_form = _IE_Example ( "form" ) 
 $oIE_table = _IE_Example ( "table" ) 
 $oIE_frameset = _IE_Example ( "frameset" ) 
 $oIE_iframe = _IE_Example ( "iframe" ) 
 
