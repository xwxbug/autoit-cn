 
 #include  <GuiConstantsEx.au3> 
 #include  <GuiStatusBar.au3> 
 
 Opt ( 'MustDeclareVars' ,  1 ) 
 
 $Debug_SB  =  False  ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 
 
 _Main () 
 
 Func _Main () 
 
     Local  $hGUI ,  $hStatus 
     Local  $aParts [ 3 ]  =  [ 75 ,  150 ,  - 1 ] 
     
     ; 创建界面 
     $hGUI  =  GUICreate ( "StatusBar Show/Hide" ,  400 ,  300 ) 
 
     ;=============================================================================== 
     ; 默认为 1 部分, 无文本 
     $hStatus  =  _GUICtrlStatusBar_Create  ( $hGUI ) 
     ;=============================================================================== 
     _GUICtrlStatusBar_SetParts  ( $hStatus ,  $aParts ) 
 
     GUISetState () 
 
     MsgBox  ( 4160 ,  "Information" ,  "Hide StatusBar" ) 
     _GUICtrlStatusBar_ShowHide  ( $hStatus ,  @SW_HIDE ) 
     MsgBox  ( 4160 ,  "Information" ,  "Show StatusBar" ) 
     _GUICtrlStatusBar_ShowHide  ( $hStatus ,  @SW_SHOW ) 
 
     ; 循环至用户退出 
     Do 
     Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
     GUIDelete () 
 EndFunc    ;==>_Main 
 

