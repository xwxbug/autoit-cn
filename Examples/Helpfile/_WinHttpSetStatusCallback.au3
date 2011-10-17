 #AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 

 #Include <WinHttp.au3> 
 #include <GuiConstantsEx.au3> 
 #include <WindowsConstants.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 Global $iMemo 
 ; 注册回调函数 
 Global $hWINHTTP_STATUS_CALLBACK = DllCallbackRegister ( " __WINHTTP_STATUS_CALLBACK ", " none ", " handle;dword_ptr;dword;ptr;dword ") 
 
 _Main () 
 
 Func _Main () 
   ; 创建界面 
   GUICreate ( "HTTP Status" ,  400 ,  300 ) 
 
   ; 创建memo控件 
   $iMemo  =  GUICtrlCreateEdit ("" ,  2 ,  2 ,  396 ,  296 ,  $WS_VSCROLL ) 
   GUICtrlSetFont ( $iMemo ,  9 ,  400 ,  0 ,  "Courier New" ) 
   GUISetState () 
 
   ; 初始化并获取会话句柄 
   Global $hOpen = _WinHttpOpen () 
   ; 将回调函数与该句柄关联 
   _WinHttpSetStatusCallback ( $hOpen , $hWINHTTP_STATUS_CALLBACK ) 
 
   ; 获取连接句柄 
   Global $hConnect = _WinHttpConnect ( $hOpen , " google.com " ) 
   ; 创建请求 
   Global $hRequest = _WinHttpOpenRequest ( $hConnect ) 
   ; 发送请求 
   _WinHttpSendRequest ( $hRequest ) 
   ; 等待应答 
   _WinHttpReceiveResponse ( $hRequest ) 
 
   ; 检查是否有数据可用 
   If _WinHttpQueryDataAvailable ( $hRequest ) Then 
     Global $sHeader = _WinHttpQueryHeaders ( $hRequest ) 
   EndIf 
 
   ; 关闭句柄 
   _WinHttpCloseHandle ( $hRequest ) 
   _WinHttpCloseHandle ( $hConnect ) 
   _WinHttpCloseHandle ( $hOpen ) 
 
   ; 显示数据 
   MsgBox ( 0 , " Query ", $option & @CRLF & @CRLF & $sHeader ) 
 
   ; 稍微延迟查看是否有更多事件 
   Sleep ( 2000 ) 
 
   ; 不再需要时释放回调函数(本例情况可忽略) 
   DllCallbackFree ( $hWINHTTP_STATUS_CALLBACK ) 
 
   ; 循环至用户退出 
   Do 
   Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
 EndFunc    ;==>_Main 
 
 ; 定义回调函数 
 Func __WINHTTP_STATUS_CALLBACK( $hInternet , $iContext , $iInternetStatus , $pStatusInformation , $iStatusInformationLength ) 
  #forceref $hInternet, $iContext, $pStatusInformation, $iStatusInformationLength 
  ; 解释状态 
  Local $sStatus 
  Switch $iInternetStatus 
    Case $WINHTTP_CALLBACK_STATUS_CLOSING_CONNECTION 
      $sStatus = " Closing the connection to the server " 
    Case $WINHTTP_CALLBACK_STATUS_CONNECTED_TO_SERVER 
      $sStatus = " Successfully connected to the server. " 
    Case $WINHTTP_CALLBACK_STATUS_CONNECTING_TO_SERVER 
      $sStatus = " Connecting to the server. " 
    Case $WINHTTP_CALLBACK_STATUS_CONNECTION_CLOSED 
      $sStatus = " Successfully closed the connection to the server. " 
    Case $WINHTTP_CALLBACK_STATUS_DATA_AVAILABLE 
      $sStatus = " Data is available to be retrieved with WinHttpReadData. " 
    Case $WINHTTP_CALLBACK_STATUS_HANDLE_CREATED 
      $sStatus = " An HINTERNET handle has been created. " 
    Case $WINHTTP_CALLBACK_STATUS_HANDLE_CLOSING 
      $sStatus = " This handle value has been terminated. " 
    Case $WINHTTP_CALLBACK_STATUS_HEADERS_AVAILABLE 
      $sStatus = " The response header has been received and is available with WinHttpQueryHeaders. " 
    Case $WINHTTP_CALLBACK_STATUS_INTERMEDIATE_RESPONSE 
      $sStatus = " Received an intermediate (100 level) status code message from the server. " 
    Case $WINHTTP_CALLBACK_STATUS_NAME_RESOLVED 
      $sStatus = " Successfully found the IP address of the server. " 
    Case $WINHTTP_CALLBACK_STATUS_READ_COMPLETE 
      $sStatus = " Data was successfully read from the server. " 
    Case $WINHTTP_CALLBACK_STATUS_RECEIVING_RESPONSE 
      $sStatus = " Waiting for the server to respond to a request. " 
    Case $WINHTTP_CALLBACK_STATUS_REDIRECT 
      $sStatus = " An HTTP request is about to automatically redirect the request. " 
    Case $WINHTTP_CALLBACK_STATUS_REQUEST_ERROR 
      $sStatus = " An error occurred while sending an HTTP request. " 
    Case $WINHTTP_CALLBACK_STATUS_REQUEST_SENT 
      $sStatus = " Successfully sent the information request to the server. " 
    Case $WINHTTP_CALLBACK_STATUS_RESOLVING_NAME 
      $sStatus = " Looking up the IP address of a server name. " 
    Case $WINHTTP_CALLBACK_STATUS_RESPONSE_RECEIVED 
      $sStatus = " Successfully received a response from the server. " 
    Case $WINHTTP_CALLBACK_STATUS_SECURE_FAILURE 
      $sStatus = " One or more errors were encountered while retrieving a Secure Sockets Layer (SSL) certificate from the server. " 
    Case $WINHTTP_CALLBACK_STATUS_SENDING_REQUEST 
      $sStatus = " Sending the information request to the server. " 
    Case $WINHTTP_CALLBACK_STATUS_SENDREQUEST_COMPLETE 
      $sStatus = " The request completed successfully. " 
    Case $WINHTTP_CALLBACK_STATUS_WRITE_COMPLETE 
      $sStatus = " Data was successfully written to the server. " 
  EndSwitch 
  ; 输出 
  MemoWrite( $iInternetStatus & @CRLF & $sStatus ) 
 EndFunc ;==>__WINHTTP_STATUS_CALLBACK 
 
 ; 向memo控件写入信息 
 Func MemoWrite ( $sMessage  =  "" ) 
     GUICtrlSetData ( $iMemo ,  $sMessage  &  @CRLF ,  1 ) 
 EndFunc    ;==>MemoWrite 
 
