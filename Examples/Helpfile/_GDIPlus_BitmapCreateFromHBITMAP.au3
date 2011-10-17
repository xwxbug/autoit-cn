 
 #include  <GuiConstantsEx.au3> 
 #include  <GDIPlus.au3> 
 #include  <ScreenCapture.au3> 
 
 Opt ( 'MustDeclareVars' ,  1 ) 
 
 _Main () 
 
 Func _Main () 
     Local  $hGUI ,  $hBMP ,  $hBitmap ,  $hGraphic 
 
     ; 捕捉屏幕左上角 
     $hBMP  =  _ScreenCapture_Capture  ( "" ,  0 ,  0 ,  400 ,  300 ) 
 
     ; 创建界面 
     $hGUI  =  GUICreate ( "GDI+" ,  400 ,  300 ) 
     GUISetState () 
 
     ; 初始化GDI+库 
     _GDIPlus_Startup  () 
 
     ; 将位图绘制到GUI 
     $hBitmap  =  _GDIPlus_BitmapCreateFromHBITMAP  ( $hBMP ) 
     $hGraphic  =  _GDIPlus_GraphicsCreateFromHWND  ( $hGUI ) 
     _GDIPlus_GraphicsDrawImage  ( $hGraphic ,  $hBitmap ,  0 ,  0 ) 
 
     ; 清除资源 
     _GDIPlus_GraphicsDispose  ( $hGraphic ) 
     _GDIPlus_ImageDispose  ( $hBitmap ) 
     _WinAPI_DeleteObject  ( $hBMP ) 
 
     ; 关闭GDI+库 
     _GDIPlus_ShutDown  () 
 
     ; 循环至用户退出 
     Do 
     Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
 
 EndFunc    ;==>_Main 
 
