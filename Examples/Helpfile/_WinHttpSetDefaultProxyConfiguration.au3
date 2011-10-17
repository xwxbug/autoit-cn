19
 _WinHttpSetDefaultProxyConfiguration      _WinHttpSetDefaultProxyConfiguration   
设置默认的WinHTTP代理配置 
 
#Include <WinHTTP.au3> 
_WinHttpSetDefaultProxyConfiguration( $iAccessType, $Proxy, $ProxyBypass ) 
 
   
参数    
 $iAccessType  包含权限类型的整数值  
 $Proxy  包含代理服务器列表的字符串  
 $ProxyBypass  包含代理旁路列表的字符串  
   
返回值 成功: 返回1并设置@error为0 
失败: 返回0并设置@error且当其为1时表示DllCall失败 
   
相关  _WinHttpDetectAutoProxyConfigUrl ,  _WinHttpGetDefaultProxyConfiguration ,  _WinHttpGetIEProxyConfigForCurrentUser 
   
参考  搜索MSDN知识库中WinHttpSetDefaultProxyConfiguration的相关信息  
   
