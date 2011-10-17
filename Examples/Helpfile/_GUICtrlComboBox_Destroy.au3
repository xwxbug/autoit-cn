 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GUIComboBox.au3> 
 #include <GuiConstantsEx.au3> 
 #include <Constants.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 $Debug_CB = False ; 检查传递给函数的类名, 设置为真并使用另一控件句柄观察其工作 
 
 _Main() 
 
 Func _Main() 
   Local $hGUI , $hCombo 
 
   ; 创建界面 
   $hGUI = GUICreate ( " (UDF Created) ComboBox Destroy ", 400 , 296 ) 
   $hCombo = _GUICtrlComboBox_Create ( $hGUI , "", 2 , 2 , 396 , 296 ) 
   GUISetState () 
 
   ; Add files 
   _GUICtrlComboBox_BeginUpdate ( $hCombo ) 
   _GUICtrlComboBox_AddDir ( $hCombo , "", $DDL_DRIVES , False ) 
   _GUICtrlComboBox_EndUpdate ( $hCombo ) 
 
   ; 销毁组合框 
   MsgBox ( 4160 , " Information ", " Destroy ComboBox " ) 
   MsgBox ( 4160 , " Information ", " Destroyed: ", & _GUICtrlComboBox_Destroy ( $hCombo)) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc ;==>_Main 
