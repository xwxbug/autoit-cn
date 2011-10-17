 #include <GuiComboBoxEx.au3> 
 #include <GuiConstantsEx.au3> 
 #include <Constants.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 $Debug_CB = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 
 
 _Main() 
 
 Func _Main() 
   Local $hGUI , $hCombo 
 
   ; 创建界面 
   $hGUI = GUICreate ( " ComboBoxEx Get Locale ", 400 , 300 ) 
   $hCombo = _GUICtrlComboBoxEx_Create ( $hGUI , "", 2 , 2 , 394 , 100 ) 
   GUISetState () 
 
   ; 添加文件 
   _GUICtrlComboBoxEx_AddDir ( $hCombo , "", $DDL_DRIVES , False ) 
 
   ; 显示地区, 国家代码, 语言标识, 主语言编号, 子语言编号 
   MsgBox ( 4160 , " Information ", _ 
       " Locale .................:  " & _GUICtrlComboBoxEx_GetLocale ( $hCombo ) & @LF & _ 
       " Country code ........:  " & _GUICtrlComboBoxEx_GetLocaleCountry ( $hCombo ) & @LF & _ 
       " Language identifier..:  " & _GUICtrlComboBoxEx_GetLocaleLang ( $hCombo ) & @LF & _ 
       " Primary Language id :  " & _GUICtrlComboBoxEx_GetLocalePrimLang ( $hCombo ) & @LF & _ 
       " Sub-Language id ....:  " & _GUICtrlComboBoxEx_GetLocaleSubLang ( $hCombo )) 
 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
 EndFunc ;==>_Main 
 
