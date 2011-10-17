17
 _INetGetSource     _INetGetSource   
不写入临时文件获取网址源代码. 
 
#include <INet.au3> 
_INetGetSource ( $s_URL 
) 
 
   
参数    
 $s_URL  (网站的URL地址)如'www.autoitscript.com'  
   
返回值    
 成功:  返回源代码.  
 失败:  返回 0 并设置 @ERROR = 1  
   
相关 INetGet  
  
