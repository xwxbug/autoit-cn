 
 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include  <GuiConstantsEx.au3> 
 #include  <GuiMonthCal.au3> 
 #include  <WindowsConstants.au3> 
 
 Opt ( 'MustDeclareVars' ,  1 ) 
 
 $Debug_MC  =  False  ; 检查传递给MonthCal函数的类名, 设置为真并使用另一控件的句柄观察其工作 
 
 Global  $iMemo 
 
 _Main () 
 
 Func _Main () 
     Local  $tMin ,  $tMax ,  $hMonthCal 
 
     ; 创建界面 
     GUICreate ( "Month Calendar Get Range Max & Min" ,  400 ,  300 ) 
     $hMonthCal  =  GUICtrlCreateMonthCal ( "" ,  4 ,  4 ,  - 1 ,  - 1 ,  BitOR ( $WS_BORDER ,  $MCS_MULTISELECT ),  0x00000000 ) 
     
     ; 创建memo控件 
     $iMemo  =  GUICtrlCreateEdit ( "" ,  4 ,  168 ,  392 ,  128 ,  0 ) 
     GUICtrlSetFont ( $iMemo ,  9 ,  400 ,  0 ,  "Courier New" ) 
     GUISetState () 
 
     ; 获取/设置范围 
     _GUICtrlMonthCal_SetRange ( $hMonthCal ,  @YEAR ,  1 ,  1 ,  @YEAR ,  12 ,  31 ) 
     $tMin  =  _GUICtrlMonthCal_GetRangeMin ( $hMonthCal ) 
     $tMax  =  _GUICtrlMonthCal_GetRangeMax ( $hMonthCal ) 
     MemoWrite ( "Minimum selectable date: "  &  StringFormat ( "%02d/%02d/%04d" ,  DllStructGetData ( $tMin ,  "Month" ),  _ 
             DllStructGetData ( $tMin ,  "Day" ),  _ 
             DllStructGetData ( $tMin ,  "Year" ))) 
     MemoWrite ( "Maximum selectable date: "  &  StringFormat ( "%02d/%02d/%04d" ,  DllStructGetData ( $tMax ,  "Month" ),  _ 
             DllStructGetData ( $tMax ,  "Day" ),  _ 
             DllStructGetData ( $tMax ,  "Year" ))) 
 
     ; 循环至用户退出 
     Do 
     Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
     GUIDelete () 
 EndFunc    ;==>_Main 
 
 ; 向memo写入信息 
 Func MemoWrite ( $sMessage ) 
     GUICtrlSetData ( $iMemo ,  $sMessage  &  @CRLF ,  1 ) 
 EndFunc    ;==>MemoWrite 
