 #AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GUIComboBox.au3> 
 #include <GuiConstantsEx.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 $Debug_CB = False ; 检查传递给函数的类名, 设置为真并使用另一控件句柄观察其工作 
 
 Global $iMemo 
 
 _Main() 
 
 Func _Main() 
   Local $aSel , $hCombo 
 
   ; 创建界面 
   GUICreate ( " ComboBoxEx Edit Sel ", 400 , 296 ) 
   $hCombo = GUICtrlCreateCombo ( Courier New " ) 
   GUISetState () 
 
   ; 添加文件 
   _GUICtrlComboBox_BeginUpdate ( $hCombo ) 
   _GUICtrlComboBox_AddDir ( $hCombo , @WindowsDir & " \*.exe " ) 
   _GUICtrlComboBox_EndUpdate ( $hCombo ) 
 
   ; 选定项目 
   _GUICtrlComboBox_SetCurSel ( $hCombo , 2 ) 
 
   ; 设置编辑选项 
   _GUICtrlComboBox_SetEditSel ( $hCombo , 0 , 4 ) 
 
   ; 获取编辑选项 
   $aSel = _GUICtrlComboBox_GetEditSel ( $hCombo ) 
     MemoWrite( StringFormat ( " Edit Sel: %d - %d $aSel [ 0 ] , $aSel [ 1 ])) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc ;==>_Main 
 
 ; 写入memo控件 
 Func MemoWrite( $sMessage ) 
   GUICtrlSetData ( $iMemo , $sMessage & @CRLF , 1 ) 
 EndFunc ;==>MemoWrite 
 
