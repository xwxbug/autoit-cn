 #AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 

 #Include <WinHTTP.au3> 
 #Include <Array.au3> 
 
 ; 当前WinHTTP代理配置 
 Global $aProxy = _WinHttpGetDefaultProxyConfiguration () 
 _ArrayDisplay ( $aProxy , " Current WinHTTP proxy configuration " ) 
 
