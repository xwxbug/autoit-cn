 #AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 

 #Include <WinHttp.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 ; !!!示例结构将发送至服务器!!! 
 #cs 
 POST /admin.php HTTP/1.1 
 Connection: Keep-Alive 
 Accept: text/html, application/xhtml+xml, application/xml;q=0.9, */*;q=0.8 
 User-Agent: AutoIt/3.3 
 Content-Length: 0 
 Host: 127.0.0.1 
 Authorization: Basic YWRtaW46YWRtaW4= 
 #ce 

 ; 本地服务器 
 Global $sLocalIP = " 127.0.0.1 " 
 
 ; 初始化并获取会话句柄 
 Global $hOpen = _WinHttpOpen () 
 
 ; 获取连接句柄 
 Global $hConnect = _WinHttpConnect ( $hOpen , $sLocalIP ) 
 
 ; 创建请求 
 Global $hRequest = _WinHttpOpenRequest ( $hConnect , _ 
    " POST ", _ ; 动作 
    " admin.php ", _ ; 对象 
    Default , _ ; 版本 
    Default , _ ; 参考 
    " text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8 " )  ; 接受类型 
 
 ; 发送证书 
 _WinHttpSetCredentials ( $hRequest , $ WINHTTP_AUTH_TARGET_SERVER , $WINHTTP_AUTH_SCHEME_BASIC , " admin ", " admin " ) 
 
 ; 发送请求 
 _WinHttpSendRequest ( $hRequest ) 
 
 ; 等待应答 
 _WinHttpReceiveResponse ( $hRequest ) 
 
 ; 此处可填入代码其余部分 
 
 ; 关闭句柄 
 _WinHttpCloseHandle ( $hRequest ) 
 _WinHttpCloseHandle ( $hConnect ) 
 _WinHttpCloseHandle ( $hOpen ) 
 
