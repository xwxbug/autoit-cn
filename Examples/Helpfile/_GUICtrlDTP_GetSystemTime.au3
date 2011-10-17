 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include  <GuiConstantsEx.au3> 
 #include  <GuiDateTimePicker.au3> 
 
 Opt ( " MustDeclareVars ", 1 ) 
 
 $Debug_DTP = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 
 
 Global $iMemo , $aDate , $tRange 
 
 _Main() 
 
 Func _Main() 
   Local $hDTP , $a_Date [ 7 ] = [ False , @YEAR , 8 , 19 , 21 , 57 , 53 ] 
 
   ; 创建界面 
   GUICreate ( " DateTimePick System Time ", 400 , 300 ) 
   $hDTP = GUICtrlGetHandle ( GUICtrlCreateDate ( "", 2 , 6 , 190 )) 
   $iMemo = GUICtrlCreateEdit ( "", 2 , 32 , 396 , 266 , 0 ) 
   GUICtrlSetFont ( $iMemo , 9 , 400 , 0 , " Courier New " ) 
   GUISetState () 
 
   ; 设置显示格式 
   _GUICtrlDTP_SetFormat ( $hDTP , " ddd MMM dd , yyyy hh:mm ttt " ) 
 
   ; 设置系统时间 
   _GUICtrlDTP_SetSystemTime ( $hDTP , $a_Date ) 
 
   ; 显示系统时间 
   $aData = _GUICtrlDTP_GetSystemTime ( $hDTP ) 
   MemoWrite( " Current date: " & GetDateStr()) 
   MemoWrite( " Current time: " & GetTimeStr()) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc ;==>_Main 
 
 ; 返回日期部分 
 Func GetDateStr() 
   Return StringFormat ( " %02d/%02d/%04d ", $aData [ 1 ] , $aData [ 2 ] , $aData [ 0 ]) 
 EndFunc ;==>GetDateStr 
 
 ; 返回时间部分 
 Func GetTimeStr() 
   Return StringFormat ( " %02d:%02d:%02d ", $aData [ 3 ] , $aData[ 4 ] , $aData [ 5 ]) 
 EndFunc ;==>GetTimeStr 
 
 ; 向memo控件写入一行 
 Func MemoWrite( $sMessage ) 
   GUICtrlSetData ( $iMemo , $sMessage & @CRLF , 1 ) 
 EndFunc ;==>MemoWrite 
 
