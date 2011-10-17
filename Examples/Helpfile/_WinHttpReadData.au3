 #AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 

 #Include <WinHttp.au3> 
 #include <GuiConstantsEx.au3> 
 #include <WindowsConstants.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 Global $iMemo 
 
 _Main () 
 
 Func _Main () 
   ; 创建界面 
   GUICreate ( "HTTP Status" ,  800 ,  600 ) 
 
   ; 创建memo控件 
   $iMemo  =  GUICtrlCreateEdit ( ,""  2 ,  2 ,  796 ,  596 ,  $WS_VSCROLL ) 
   GUICtrlSetFont ( $iMemo ,  9 ,  400 ,  0 ,  "Courier New" ) 
   GUISetState () 
 
   ; 初始化并获取会话句柄 
   Global $hOpen = _WinHttpOpen () 
   If @error Then 
     MsgBox ( 48 , " Error ", " Error initializing the usage of WinHTTP functions. " ) 
     Exit 1 
   EndIf 
   ; 获取连接句柄 
   Global $hConnect = _WinHttpConnect ( $hOpen , " yahoo.com " ) 
   If @error Then 
     MsgBox ( 48 , " Error ", " Error specifying the initial target server of an HTTP request. " ) 
     _WinHttpCloseHandle ( $hOpen ) 
   Exit 2 
   EndIf 
   ; 创建请求 
   Global $hRequest = _WinHttpOpenRequest ( $hConnect , Default , $sTarget ) 
   If @error Then 
     MsgBox ( 48 , " Error ", " Error creating an HTTP request handle. " ) 
     _WinHttpCloseHandle ( $hConnect ) 
     _WinHttpCloseHandle ( $hOpen ) 
     Exit 3 
   EndIf 
 
   ; 发送请求 
   _WinHttpSendRequest ( $hRequest ) 
   If @error Then 
     MsgBox ( 48 , " Error ", " Error sending specified request. " ) 
     _WinHttpCloseHandle ( $hConnect ) 
     _WinHttpCloseHandle ( $hOpen ) 
     Exit 4 
   EndIf 
 
   ; 等待应答 
   _WinHttpReceiveResponse ( $hRequest ) 
 
   ; 检查是否有可用于读取的数据 
   Global $sChunk , $sData , $hFile 
   If _WinHttpQueryDataAvailable ( $hRequest ) Then 
     While 1 
       $sChunk = _WinHttpReadData ( $hRequest ) 
       If @error Then ExitLoop 
       MemoWrite( $sChunk ) 
     Wend 
   Else 
     MsgBox ( 48 , " Error occurred ", " Site is experiencing problems. " ) 
   EndIf 
 
   ; 关闭句柄 
   _WinHttpCloseHandle ( $hRequest ) 
   _WinHttpCloseHandle ( $hConnect ) 
   _WinHttpCloseHandle ( $hOpen ) 
 
   ; 循环至用户退出 
   Do 
   Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
 EndFunc    ;==>_Main 
 
 ; 向memo控件写入信息 
 Func MemoWrite ( $sMessage  =  "" ) 
   GUICtrlSetData ( $iMemo ,  $sMessage  &  @CRLF ,  1 ) 
 EndFunc    ;==>MemoWrite 
 
