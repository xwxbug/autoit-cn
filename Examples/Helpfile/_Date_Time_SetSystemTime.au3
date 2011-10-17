 
 #include  <GuiConstantsEx.au3> 
 #include  <Date.au3> 
 #include  <WindowsConstants.au3> 
 
 Global  $iMemo 
 
 _Main () 
 
 Func _Main () 
     Local  $hGUI ,  $tCur ,  $tNew 
 
     ; 创建界面 
     $hGUI  =  GUICreate ( "Time" ,  400 ,  300 ) 
     $iMemo  =  GUICtrlCreateEdit ( "" ,  2 ,  2 ,  396 ,  296 ,  $WS_VSCROLL ) 
     GUICtrlSetFont ( $iMemo ,  9 ,  400 ,  0 ,  "Courier New" ) 
     GUISetState () 
 
     ; 获取当前系统时间 
     $tCur  =  _Date_Time_GetSystemTime () 
     MemoWrite ( "Current system date/time .: "  &  _Date_Time_SystemTimeToDateTimeStr ( $tCur )) 
 
     ; 设置新的系统时间 
     $tNew  =  _Date_Time_EncodeSystemTime ( 8 ,  19 ,  @YEAR ,  3 ,  10 ,  45 ) 
     _Date_Time_SetSystemTime ( DllStructGetPtr ( $tNew )) 
     $tNew  =  _Date_Time_GetSystemTime () 
     MemoWrite ( "New system date/time .....: "  &  _Date_Time_SystemTimeToDateTimeStr ( $tNew )) 
 
     ; 恢复系统时间 
     _Date_Time_SetSystemTime ( DllStructGetPtr ( $tCur )) 
 
     ; 获取当前系统时间 
     $tCur  =  _Date_Time_GetSystemTime () 
     MemoWrite ( "Current system date/time .: "  &  _Date_Time_SystemTimeToDateTimeStr ( $tCur )) 
 
     ; 循环至用户退出 
     Do 
     Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
     
 EndFunc    ;==>_Main 
 
 ; 写入memo控件 
 Func MemoWrite ( $sMessage ) 
     GUICtrlSetData ( $iMemo ,  $sMessage  &  @CRLF ,  1 ) 
 EndFunc    ;==>MemoWrite 

