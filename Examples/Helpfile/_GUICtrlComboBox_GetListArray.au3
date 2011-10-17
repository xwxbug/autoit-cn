 #AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GUIComboBox.au3> 
 #include <GuiConstantsEx.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 $Debug_CB = False ; 检查传递给函数的类名, 设置为真并使用另一控件句柄观察其工作 
 
 Global $iMemo 
 
 _Main() 
 
 Func _Main() 
   Local $aList , $hCombo 
 
   ; 创建界面 
   GUICreate ( " ComboBox Get List Array ", 400 , 296 ) 
   $hCombo = GUICtrlCreateCombo ( "", 2 , 2 , 396 , 296 ) 
   $iMemo = GUICtrlCreateEdit ( "", 10 , 50 , 396 , 266 , 0 ) 
   GUICtrlSetFont ( $iMemo , 9 , 400 , 0 , " Courier New " ) 
   GUISetState () 
 
   ; 添加文件 
   _GUICtrlComboBox_AddDir ( $hCombo , "", $DDL_DRIVES , False ) 
 
   ; 获取列表 
   $aList = _GUICtrlComboBox_GetListArray ( $hCombo ) 
   For $x = 1  To  $aList [ 0 ] 
     MemoWrite( $aList [ $x ]) 
   Next 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc ;==>_Main 
 
 ; 写入memo控件 
 Func MemoWrite( $sMessage ) 
   GUICtrlSetData ( $iMemo , $sMessage & @CRLF , 1 ) 
 EndFunc ;==>MemoWrite 
 
