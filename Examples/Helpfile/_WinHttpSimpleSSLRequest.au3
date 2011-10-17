 #AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 

 #Include <WinHttp.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 ; !!!注意该示例将因为无效用户名和密码失败!!! 
 Global $sDomain = " www.google.com " 
 Global $sPage = " accounts/ClientLogin " 
 Global $sUserName = " SomeUserName " 
 Global $sPassword = " SomePassword " 
 ; 更多信息请访问http://code.google.com/apis/accounts/docs/AuthForInstalledApps.html 
 Global $sAdditionalData = " accountType=HOSTED_OR_GOOGLE&Email= " & $sUserName & " &Passwd= " & $sPassword & " &service=mail&source=Gulp-CalGulp-1.05 " 
 ; 初始化并获取会话句柄 
 Global $hOpen = _WinHttpOpen () 
 ; 获取连接句柄 
 Global $hConnect = _WinHttpConnect ( $hOpen , $sDomain ) 
 ; 创建SimpleSSL-请求 
 Global $sReturned = _WinHttpSimpleSSLRequest ( $hConnect , " POST ", $sPage , Default , $sAdditionalData ) 
 
 ; 等待应答 
 _WinHttpReceiveResponse ( $hRequest ) 
 
 _WinHttpCloseHandle ( $hConnect ) 
 _WinHttpCloseHandle ( $hOpen ) 
 
 ; 查看返回值 
 MsgBox ( 0 , " Returned ", $sReturned ) 
 
