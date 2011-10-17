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
   $iMemo  =  GUICtrlCreateEdit ("" ,  2 ,  2 ,  796 ,  596 ,  $WS_VSCROLL ) 
   GUICtrlSetFont ( $iMemo ,  9 ,  400 ,  0 ,  "Courier New" ) 
   GUISetState () 
 
   ; 初始化并获取会话句柄 
   Global $hOpen = _WinHttpOpen () 
   ; 获取连接句柄 
   Global $hConnect = _WinHttpConnect ( $hOpen , " google.com " ) 
   ; 创建请求 
   Global $hRequest = _WinHttpSimpleSendRequest ( $hConnect , Default , " tags/tag_input.asp " ) 
 
   If $hRequest Then 
     ; 简单读取... 
     MemoWrite( _WinHttpSimpleReadData ( $hRequest ) & @CRLF ) 
     MsgBox ( 64 , " Ok ", " Returned source is print to concole. Check it. " ) 
   Else 
     MsgBox ( 48 , " Error ", " Error ocurred for _WinHttpSimpleSendRequest, Error number is " & @error ) 
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
 
