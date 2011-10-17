 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GUIComboBox.au3> 
 #include <GuiConstantsEx.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 _Main() 
 
 Func _Main() 
   Local $hCombo 
 
   ; 创建界面 
   GUICreate ( " ComboBox Insert String ", 400 , 296 ) 
   $hCombo = GUICtrlCreateCombo ( "", 2 , 2 , 396 , 296 ) 
   GUISetState () 
 
   ; 添加文件 
   _GUICtrlComboBox_BeginUpdate ( $hCombo ) 
   _GUICtrlComboBox_AddDir ( $hCombo , @WindowsDir & " \*.exe " ) 
   _GUICtrlComboBox_EndUpdate ( $hCombo ) 
 
   ; 插入字符串 
   _GUICtrlComboBox_InsertString ( $hCombo , " Some Inserted string ", 0 ) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc    ;==>_Main 
 
