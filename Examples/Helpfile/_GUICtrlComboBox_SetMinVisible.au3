 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GUIComboBox.au3> 
 #include <GuiConstantsEx.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 _Main() 
 
 Func _Main() 
   Local $hCombo 
 
   ; 创建界面 
   GUICreate ( " ComboBox Min Visible ", 400 , 296 ) 
   $hCombo = GUICtrlCreateCombo ( "", 2 , 2 , 396 , 296 ) 
   GUISetState () 
 
   ; 添加文件 
   _GUICtrlComboBox_BeginUpdate ( $hCombo ) 
   _GUICtrlComboBox_AddDir ( $hCombo , @WindowsDir & " \*.exe " ) 
   _GUICtrlComboBox_EndUpdate ( $hCombo ) 
 
   ; 获取最小的可见数量 
   MsgBox ( 4160 , " Information ", " Min Visible: " & @TAB & _GUICtrlComboBox_GetMinVisible ( $hCombo ) , 3 ) 
 
   ; 显示下拉框 
   _GUICtrlComboBox_ShowDropDown ( $hCombo , True ) 
 
   Sleep ( 500 ) 
 
   ; 设置最小的可见数量 
   _GUICtrlComboBox_SetMinVisible ( $hCombo , 50 ) 
 
   ; 显示下拉框 
   _GUICtrlComboBox_ShowDropDown ( $hCombo ) 
 
   Sleep ( 500 ) 
 
   _GUICtrlComboBox_ShowDropDown ( $hCombo , True ) 
 
   Sleep ( 500 ) 
 
   ; 获取最小的可见数量 
   MsgBox ( 4160 , " Information ", " Min Visible: " & @TAB & _GUICtrlComboBox_GetMinVisible ( $hCombo ) , 3 ) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc    ;==>_Main 
 
