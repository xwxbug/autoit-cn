 
 #include  <GuiConstantsEx.au3> 
 #include  <GDIPlus.au3> 
 #include  <ScreenCapture.au3> 
 #include  <WinAPI.au3> 
 
 Opt ( 'MustDeclareVars' ,  1 ) 
 
 _Main () 
 
 Func _Main () 
     Local  $hBitmap ,  $hImage ,  $hGraphic 
 
     ; 初始化GDI+库 
     _GDIPlus_Startup  () 
 
     ; 捕捉屏幕区域 
     $hBitmap  =  _ScreenCapture_Capture  ( "" ,  0 ,  0 ,  400 ,  300 ) 
     $hImage  =  _GDIPlus_BitmapCreateFromHBITMAP  ( $hBitmap ) 
 
     ; 清除屏幕的蓝色 
     $hGraphic  =  _GDIPlus_ImageGetGraphicsContext  ( $hImage ) 
     _GDIPlus_GraphicsClear  ( $hGraphic ) 
 
     ; 保存相应的图像 
     _GDIPlus_ImageSaveToFile  ( $hImage ,  @MyDocumentsDir  &  "\GDIPlus_Image.jpg" ) 
 
     ; 清除资源 
     _GDIPlus_GraphicsDispose  ( $hGraphic ) 
     _GDIPlus_ImageDispose  ( $hImage ) 
     _WinAPI_DeleteObject  ( $hBitmap ) 
 
     ; 关闭GDI+库 
     _GDIPlus_ShutDown  () 
 
 EndFunc    ;==>_Main  

