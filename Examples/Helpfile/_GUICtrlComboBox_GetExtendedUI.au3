 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include  <GUIComboBox.au3> 
 #include  <GuiConstantsEx.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 $Debug_CB = False ; 检查传递给函数的类名, 设置为真并使用另一控件句柄观察其工作 
 
 Global $iMemo 
 
 _Main() 
 
 Func _Main() 
    Local $hCombo 
 
   ; 创建界面 
   GUICreate ( " ComboBoxEx Extended UI ", 400 , 296 ) 
   $hCombo = GUICtrlCreateCombo ( "", 2 , 2 , 396 , 296 ) 
   $iMemo = GUICtrlCreateEdit ( "", 10 , 50 , 396 , 266 , 0 ) 
   GUICtrlSetFont ( $iMemo , 9 , 400 , 0 , " Courier New " ) 
   GUISetState () 
 
   ; 添加文件 
   _GUICtrlComboBox_BeginUpdate ( $hCombo ) 
   _GUICtrlComboBox_AddDir ( $hCombo , @WindowsDir & " \*.exe " ) 
   _GUICtrlComboBox_EndUpdate ( $hCombo ) 
 
   ; 获取扩展用户界面 
   MemoWrite( " Extended UI: " & _GUICtrlComboBox_GetExtendedUI ( $hCombo )) 
 
   ; 设置扩展用户界面 
   _GUICtrlComboBox_SetExtendeddUI ( $hCombo , True ) 
 
   ; 获取扩展用户界面 
   MemoWrite( " Extended UI: " & _GUICtrlComboBox_GetExtendedUI ( $hCombo )) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc ;==>_Main 
 
 ; 写入memo控件 
 Func MemoWrite( $sMessage ) 
   GUICtrlSetData ( $iMemo , $sMessage & @CRLF , 1 ) 
 EndFunc ;==>MemoWrite 
 
