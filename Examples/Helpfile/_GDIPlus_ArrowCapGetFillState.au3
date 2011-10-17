 
 #include  <GuiConstantsEx.au3> 
 #include  <GDIPlus.au3> 
 
 Opt ( 'MustDeclareVars' ,  1 ) 
 
 _Main () 
 
 Func _Main () 
     Local  $hGUI ,  $hWnd ,  $hGraphic ,  $hPen ,  $hEndCap 
 
     ; 创建界面 
     $hGUI  =  GUICreate ( "GDI+" ,  400 ,  300 ) 
     $hWnd  =  WinGetHandle ( "GDI+" ) 
     GUISetState () 
 
     ; 创建资源 
     _GDIPlus_Startup  () 
     $hGraphic  =  _GDIPlus_GraphicsCreateFromHWND  ( $hWnd ) 
     $hPen  =  _GDIPlus_PenCreate  ( 0xFF000000 ,  4 ) 
     $hEndCap  =  _GDIPlus_ArrowCapCreate  ( 4 ,  6 ) 
 
     ; 显示填充状态 
     MsgBox ( 4096 ,  "Information" ,  "Fill state: "  &  _GDIPlus_ArrowCapGetFillState ( $hEndCap )) 
 
     ; 绘制箭头1 
     _GDIPlus_PenSetCustomEndCap ( $hPen ,  $hEndCap ) 
     _GDIPlus_GraphicsDrawLine ( $hGraphic ,  10 ,  130 ,  390 ,  130 ,  $hPen ) 
 
     ; 绘制箭头2 
     _GDIPlus_ArrowCapSetFillState ( $hEndCap ,  False ) 
     _GDIPlus_PenSetCustomEndCap ( $hPen ,  $hEndCap ) 
     _GDIPlus_GraphicsDrawLine ( $hGraphic ,  10 ,  160 ,  390 ,  160 ,  $hPen ) 
 
     ; 循环至用户退出 
     Do 
     Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
 
     ; 清除资源 
     _GDIPlus_ArrowCapDispose  ( $hEndCap ) 
     _GDIPlus_PenDispose  ( $hPen ) 
     _GDIPlus_GraphicsDispose  ( $hGraphic ) 
     _GDIPlus_Shutdown  () 
 EndFunc    ;==>_Main 
 

