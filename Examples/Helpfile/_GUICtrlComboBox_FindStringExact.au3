 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GUIComboBox.au3> 
 #include <GuiConstantsEx.au3> 
 #include <Constants.au3> 
 
 Opt ( ' MustDeclareVars ' , 1 ) 
 
 $Debug_CB = False ; 检查传递给函数的类名, 设置为真并使用另一控件句柄观察其工作 
 
 _Main() 
 
 Func _Main() 
   Local $hCombo 
 
   ; 创建界面 
   GUICreate ( " ComboBox Find String Exact ", 400 , 296 ) 
   $hCombo = GUICtrlCreateCombo ( "", 2 , 2 , 396 , 296 ) 
   GUISetState () 
 
   _GUICtrlComboBox_BeginUpdate ( $hCombo ) 
   _GUICtrlComboBox_AddDir ( $hCombo , "", $DDL_DRIVES , False ) 
   _GUICtrlComboBox_AddString ( $hCombo , " This is a test " ) 
   _GUICtrlComboBox_AddDir ( $hCombo , "", $DDL_DRIVES ) 
   _GUICtrlComboBox_AddString ( $hCombo , " This is eXact " ) 
   _GUICtrlComboBox_EndUpdate ( $hCombo ) 
 
   ; 查找字符串 
   MsgBox ( 4160 , " Information ", " Find String: " & _GUICtrlComboBox_FindStringExact ( $hCombo , " This is eXact " )) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc ;==>_Main 
 
