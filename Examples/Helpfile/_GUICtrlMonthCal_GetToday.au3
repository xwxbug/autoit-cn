 
 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include  <GuiConstantsEx.au3> 
 #include  <GuiMonthCal.au3> 
 #include  <WindowsConstants.au3> 
 
 Opt ( 'MustDeclareVars' ,  1 ) 
 
 $Debug_MC  =  False  ; 检查传递给MonthCal函数的类名, 设置为真并使用另一控件的句柄观察其工作 
 
 Global  $iMemo 
 
 _Main () 
 
 Func _Main () 
     Local  $tToday ,  $hMonthCal 
 
     ; 创建界面 
     GUICreate ( "Month Calendar" ,  460 ,  190 ) 
     $hMonthCal  =  GUICtrlCreateMonthCal ( "" ,  4 ,  4 ,  - 1 ,  - 1 ,  $WS_BORDER ,  0x00000000 ) 
     
     ; 创建memo控件 
     $iMemo  =  GUICtrlCreateEdit ( "" ,  228 ,  4 ,  225 ,  180 ,  0 ) 
     GUICtrlSetFont ( $iMemo ,  9 ,  400 ,  0 ,  "Courier New" ) 
     GUISetState () 
 
     ; 获取/设置今日 
     _GUICtrlMonthCal_SetToday ( $hMonthCal ,  @YEAR ,  8 ,  19 ) 
     $tToday  =  _GUICtrlMonthCal_GetToday ( $hMonthCal ) 
     MemoWrite ( "Today: "  &  StringFormat ( "%02d/%02d/%04d" ,  DllStructGetData ( $tToday ,  "Month" ),  _ 
             DllStructGetData ( $tToday ,  "Day" ),  _ 
             DllStructGetData ( $tToday ,  "Year" ))) 
 
     ; 循环至用户退出 
     Do 
     Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
     GUIDelete () 
 EndFunc    ;==>_Main 
 
 ; 向memo控件写入信息 
 Func MemoWrite ( $sMessage ) 
     GUICtrlSetData ( $iMemo ,  $sMessage  &  @CRLF ,  1 ) 
 EndFunc    ;==>MemoWrite 
