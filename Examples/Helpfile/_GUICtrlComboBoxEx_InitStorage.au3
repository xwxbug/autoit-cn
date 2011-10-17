 #include <GuiComboBoxEx.au3> 
 #include <GuiConstantsEx.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 $Debug_CB = False ; 检查传递给函数的类名 , 设置为真并使用另一控件的句柄观察其工作 
 
 _Main() 
 
 Func _Main() 
   Local $hGUI , $hCombo 
 
   ; 创建界面 
   $hGUI = GUICreate ( " ComboBoxEx Unicode ", 400 , 300 ) 
   $hCombo = _GUICtrlComboBoxEx_Create ( $hGUI , "", 2 , 2 , 394 , 100 ) 
   GUISetState () 
 
 
   MsgBox ( 4160 , " Information ", " Innit Storage Pre-Allocated Memory For: " & _GUICtrlComboBoxEx_InitStorage ( $hCombo , 150 , 300 ) & " Items " ) 
   _GUICtrlComboBoxEx_BeginUpdate ( $hCombo ) 
 
   For $x = 0  To 149 
     _GUICtrlComboBoxEx_AddString ( $hCombo , StringFormat ( " %03d : Random string ", Random ( 1 , 100 , 1 ))) 
   Next 
   _GUICtrlComboBoxEx_EndUpdate ( $hCombo ) 
 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
 EndFunc ;==>_Main 
 
