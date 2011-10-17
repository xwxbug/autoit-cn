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
 Global $hOpen = _WinHttpOpen ( " Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.6) Gecko/20100625 Firefox/3.6.6 " ) 
 ; 获取连接句柄 
 Global $hConnect = _WinHttpConnect ( $hOpen , $sDomain ) 
 ; 创建请求 
 Global $hRequest = _WinHttpOpenRequest ( $hConnect , " POST ", $sPage , -1 , -1 , -1 , $WINHTTP_FLAG_SECURE ) 
 ; 发送请求, 并制定额外数据, 需要Google API 
 _WinHttpSendRequest ( $hRequest , " Content-Type: application/x-www-form-urlencoded ", $sAdditionalData ) 
 
 ; 等待应答 
 _WinHttpReceiveResponse ( $hRequest ) 
 
 ; 检查返回数据 
 Global $sReturned 
 If _WinHttpQueryDataAvailable ( $hRequest ) Then 
  Do 
    $sReturned &= _WinHttpReadData ( $hRequest ) 
  Until @error 
 EndIf 
 
 ; 关闭句柄 
 _WinHttpCloseHandle ( $hRequest ) 
 _WinHttpCloseHandle ( $hConnect ) 
 _WinHttpCloseHandle ( $hOpen ) 
 
 ; 查看返回值 
 MsgBox ( 0 , " Returned ", $sReturned ) 
 
