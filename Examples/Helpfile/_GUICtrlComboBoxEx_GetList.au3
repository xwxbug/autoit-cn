 #include <GuiComboBoxEx.au3> 
 #include <GuiConstantsEx.au3> 
 #include <Constants.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 $Debug_CB = False ; 检查传递给函数的类名 , 设置为真并使用另一控件的句柄观察其工作 
 
 Global $iMemo 
 
 _Main() 
 
 Func _Main() 
   Local $hGUI , $aItem , $Delimiter = , " ; ", $hCombo 
 
   Opt ( ' GUIDataSeparatorChar ', $Delimiter ) 
 
   ; 创建界面 
   $hGUI = GUICreate ( " ComboBoxEx Get List ", 400 , 300 ) 
   $hCombo = _GUICtrlComboBoxEx_Create ( $hGUI , "", 2 , 2 , 394 , 100 ) 
   $iMemo = GUICtrlCreateEdit ( "", 2 , 32 , 396 , 266 , 0 ) 
   GUICtrlSetFont ( $iMemo , 9 , 400 , 0 , " Courier New " ) 
   GUISetState () 
 
   ; 添加文件 
   _GUICtrlComboBoxEx_AddDir ( $hCombo , "", $DDL_DRIVES , False ) 
 
   ; 获取列表 
   $aItem = StringSplit ( _GUICtrlComboBoxEx_GetList ( $hCombo ) , $Delimiter ) 
 
   For $x = 1  To  $aItem [ 0 ] 
     MemoWrite( $aItem [ $x ]) 
   Next 
 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
 EndFunc ;==>_Main 
 
 ; 写入memo控件 
 Func MemoWrite( $sMessage ) 
   GUICtrlSetData ( $iMemo , $sMessage & @CRLF , 1 ) 
 EndFunc ;==>MemoWrite 
 
