 #AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 

 #Include <WinHttp.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 ; !!!注意该示例将因为无效用户名和密码失败!!! 

 Global $sAddress = " secure.imdb.com " 
 Global $sUserName = " SomeUserName " 
 Global $sPassword = " SomePassword " 
 ; Post数据: 
 Global $sPostData = " login= " & $sUserName & " &password= " & $sPassword & " &u=https%3A%2F%2Fsecure.imdb.com%2Fregister-imdb%2Flogin " 

 ; 初始化并获取会话句柄 
 Global $hOpen = _WinHttpOpen ( " Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1) Gecko/20090624 Firefox/3.5 " ) 
 
 ; 获取连接句柄 
 Global $hConnect = _WinHttpConnect ( $hOpen , $sAddress , $INTERNET_DEFAULT_HTTPS_PORT ) 
 
 ; 创建请求 
 Global $hRequest = _WinHttpOpenRequest ( $hConnect , _ 
    " POST ", _ 
    " register-imdb/login ", _ 
    Default , _ 
    Default , _ 
    " text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8 ", _ 
    $WINHTTP_FLAG_SECURE ) 
 
 ; 启用cookies确定 
 _WinHttpSetOption ( $hRequest , $WINHTTP_OPTION_DISABLE_FEATURE , $WINHTTP_DISABLE_COOKIES ) 
 ; 向请求添加文件头 
 _WinHttpAddRequestHeaders ( $hRequest , " Accept-Language: en-us,en;q=0.5 " ) 
 _WinHttpAddRequestHeaders ( $hRequest , " Content-Type: application/x-www-form-urlencoded " ) 
 _WinHttpAddRequestHeaders ( $hRequest , " Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7 " ) 
 _WinHttpAddRequestHeaders ( $hRequest , " Keep-Alive: 300 " ) 
 _WinHttpAddRequestHeaders ( $hRequest , " Connection: keep-alive " ) 
 
 ; 发送 
 _WinHttpSendRequest ( $hRequest , -1 , $sPostData ) 
 ; 等待应答 
 _WinHttpReceiveResponse ( $hRequest ) 
 ; 检查是否有请求 
 Global $sHeader , $sReturned 
 If _WinHttpQueryDataAvailable ( $hRequest ) Then 
  $sHeader = _WinHttpQueryHeaders ( $hRequest ) 
  MsgBox (64 , " Header ", $sHeader ) 
  Do 
    $sReturned  &= _WinHttpReadData ( $hRequest ) 
  Until @error 
  ; 输出返回值 
  MsgBox ( 0 , " Success ", $sReturned ) 
 Else 
  MsgBox ( 48 , " Failure ", " No data available. " ) 
 EndIf 
 
 ; 关闭句柄 
 _WinHttpCloseHandle ( $hRequest ) 
 _WinHttpCloseHandle ( $hConnect ) 
 _WinHttpCloseHandle ( $hOpen ) 
 
