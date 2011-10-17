 #AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 

 #Include <WinHttp.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 ; 初始化并获取会话句柄 
 Global $hOpen = _WinHttpOpen () 
 ; 设置超时 
 _WinHttpSetTimeouts ( $hOpen , 10 , 10 , 10 , 10 ) 
 ; 获取连接句柄 
 Global $hConnect = _WinHttpConnect ( $hOpen , " msdn.microsoft.com " ) 
 ; 创建请求 
 Global $hRequest = _WinHttpOpenRequest ( $hConnect , Default , " en-us/library/aa384101(VS.85).aspx " ) 
 
 ; 发送请求 
 _WinHttpSendRequest ( $hRequest ) 
 
 ; 等待应答 
 _WinHttpReceiveResponse ( $hRequest ) 
 
 ; 检查是否有数据可用 
 If _WinHttpQueryDataAvailable ( $hRequest ) Then 
  Global $sHeader = _WinHttpQueryHeaders ( $hRequest ) 
  MsgBox ( 0 , " Header ", $sHeader ) 
 Else 
  MsgBox ( 48 , " Failure ", " Maybe the new timeouts are unrealistic ;) " ) 
 EndIf 
 
 ; 关闭句柄 
 _WinHttpCloseHandle ( $hRequest ) 
 _WinHttpCloseHandle ( $hConnect ) 
 _WinHttpCloseHandle ( $hOpen ) 
 
