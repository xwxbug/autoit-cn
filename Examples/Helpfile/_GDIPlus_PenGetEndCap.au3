 
 #include  <GuiConstantsEx.au3> 
 #include  <GDIPlus.au3> 
 
 Opt ( 'MustDeclareVars' ,  1 ) 
 
 _Main () 
 
 Func _Main () 
     Local  $hGUI ,  $hWnd ,  $hGraphic ,  $hPen 
 
     ; 创建界面 
     $hGUI  =  GUICreate ( "GDI+" ,  400 ,  300 ) 
     $hWnd  =  WinGetHandle ( "GDI+" ) 
     GUISetState () 
 
     ; 创建资源 
     _GDIPlus_Startup  () 
     $hGraphic  =  _GDIPlus_GraphicsCreateFromHWND  ( $hWnd ) 
     $hPen  =  _GDIPlus_PenCreate  ( 0xFF000000 ,  8 ) 
     _GDIPlus_PenSetEndCap ( $hPen ,  $GDIP_LINECAPARROWANCHOR ) 
 
     ; 显示线终点线帽 
     MsgBox ( 4096 ,  "Information" ,  "Pen end cap type: "  &  _GDIPlus_PenGetEndCap  ( $hPen )) 
 
     ; 绘制箭头 
     _GDIPlus_GraphicsDrawLine  ( $hGraphic ,  10 ,  130 ,  390 ,  130 ,  $hPen ) 
     _GDIPlus_PenSetWidth ( $hPen ,  6 ) 
     _GDIPlus_GraphicsDrawLine  ( $hGraphic ,  10 ,  150 ,  390 ,  150 ,  $hPen ) 
     _GDIPlus_PenSetWidth ( $hPen ,  8 ) 
     _GDIPlus_GraphicsDrawLine  ( $hGraphic ,  10 ,  170 ,  390 ,  170 ,  $hPen ) 
 
     ; 循环至用户退出 
     Do 
     Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
 
     ; 清除资源 
     _GDIPlus_PenDispose  ( $hPen ) 
     _GDIPlus_GraphicsDispose  ( $hGraphic ) 
     _GDIPlus_ShutDown  () 
 
 EndFunc    ;==>_Main  

