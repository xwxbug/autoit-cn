 #Include <WinHTTP.au3> 
 #Include <EditConstants.au3> 
 #Include <GUIConstantsEx.au3> 
 #Include <WindowsConstants.au3> 
 
 _Main () 
 
 Func _Main () 
   Local $hGUI , $iMemo 
 
   ; 创建界面 
   $hGUI = GUICreate ( "_WinHttpWriteData Example" , 400 , 300 ) 
 
   ; 创建memo控件 
   $iMemo = GUICtrlCreateEdit ("", 2 , 2 , 396 , 296 , BitOR ( $ES_MULTILINE , $ES_WANTRETURN , $WS_VSCROLL , $ES_AUTOVSCROLL ) 
   GUISetState () 
 
 
   $LocalIP = " www.snee.com "  ; 测试用地址 
 
   $hw_open = _WinHttpOpen () 
   $hw_connect = _WinHttpConnect ( $hw_open , $LocalIP ) 
   $h_openRequest = _WinHttpOpenRequest ( $hw_connect , " POST ", " xml/crud/posttest.cgi?sgs " ) 
 
   $data = " abcdefghijklmnopqrstuvwxyz " 
 
   _WinHttpSendRequest ( $h_openRequest , $WINHTTP_NO_ADDITIONAL_HEADERS , $WINHTTP_NO_REQUEST_DATA , StringLen ( $data ) , 0 ) 
   _WinHttpWriteData ( $h_openRequest , $data ) ;向网页源码提交数据 
   _WinHttpReceiveResponse ( $h_openRequest ) 
 
   If _WinHttpQueryDataAvailable ( $h_openRequest ) Then 
     $sText = _WinHttpReadData ( $h_openRequest ) 
     $sRer = StringRegExpReplace ( $sText , ' (? )( ',  @CRLF & ' $1 ' ) 
     GUICtrlSetData ( $iMemo , $sRer ) 
   EndIf 
 
   _WinHttpCloseHandle ( $h_openRequest ) 
   _WinHttpCloseHandle ( $hw_connect ) 
   _WinHttpCloseHandle ( $hw_open ) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
 EndFunc    ;==>_Main 
 
