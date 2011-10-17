 #include <GuiConstantsEx.au3> 
 #include <GuiHeader.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 $Debug_HDR = False ; 检查传递给函数的类名 , 设置为真并使用另一控件的句柄观察其工作 
 
 Global $iMemo 
 
 Func _Main () 
   Local $hGUI , $hHeader , $iTicks , $iIndex , $begin 
 
   ; 创建界面 
   $hGUI = GUICreate ( ' Header ', 400 , 300 ) 
   $hHeader = _GUICtrlHeader_Create ( $hGUI ) 
   GUISetState () 
 
   ; 添加列 
   _GUICtrlHeader_AddItem ( $hHeader , " Column 1 ", 100 ) 
   _GUICtrlHeader_AddItem ( $hHeader , " Column 2 ", 100 ) 
   _GUICtrlHeader_AddItem ( $hHeader , " Column 3 ", 100 ) 
   _GUICtrlHeader_AddItem ( $hHeader , " Column 4 ", 100 ) 
 
   Do 
     If TimerDiff ( $begin ) > 500  Then 
       $iIndex = Mod ( $iIndex + 1 , 4 ) 
       _GUICtrlHeader_SetHotDivider ( $hHeader , False , $iIndex ) 
       $begin = TimerInit () 
     EndIf 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
 EndFunc ;==>_Main 
 
