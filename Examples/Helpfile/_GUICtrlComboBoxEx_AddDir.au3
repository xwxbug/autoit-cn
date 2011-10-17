 #include <GuiComboBoxEx.au3> 
 #include <GuiConstantsEx.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 $Debug_CB = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 
 
 _Main() 
 
 Func _Main() 
   Local $hGUI , $hImage , $input , $hCombo 
 
   ; 创建界面 
   $hGUI = GUICreate ( " ComboBoxEx Add Dir ", 400 , 300 , -1 , -1 , -1 ) 
   $hCombo = _GUICtrlComboBoxEx_Create ( $hGUI , "", 2 , 2 , 394 , 100 ) 
   $input = GUICtrlCreateInput ( " Input control ", 2 , 30 , 120 ) 
   GUISetState () 
 
   ; 添加文件 
 ;~  _GUICtrlComboBoxEx_BeginUpdate ($input) ; 检查正常工作的类名 
   _GUICtrlComboBoxEx_BeginUpdate ( $hCombo ) 
   _GUICtrlComboBoxEx_AddDir ( $hCombo , @WindowsDir & " \*.exe " ) 
   _GUICtrlComboBoxEx_EndUpdate ( $hCombo ) 
 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
 EndFunc ;==>_Main 
 
