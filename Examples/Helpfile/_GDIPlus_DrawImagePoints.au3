 
 #AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include  <GDIPlus.au3> 
 #include  <ScreenCapture.au3> 
 
 Opt ( 'MustDeclareVars' ,  1 ) 
 
 _Main () 
 
 Func _Main () 
     Local  $hBitmap1 ,  $hBitmap2 ,  $hImage1 ,  $hImage2 ,  $hGraphic 
 
     ; 初始化GDI+库 
     _GDIPlus_Startup () 
 
     ; 捕捉全屏 
     $hBitmap1  =  _ScreenCapture_Capture ( "" ) 
     $hImage1  =  _GDIPlus_BitmapCreateFromHBITMAP ( $hBitmap1 ) 
 
     ; 捕捉屏幕区域 
     $hBitmap2  =  _ScreenCapture_Capture ( "" ,  0 ,  0 ,  400 ,  300 ) 
     $hImage2  =  _GDIPlus_BitmapCreateFromHBITMAP ( $hBitmap2 ) 
 
     ; 在另一个中绘制一个图像 
     $hGraphic  =  _GDIPlus_ImageGetGraphicsContext ( $hImage1 ) 
     
     _GDIPlus_DrawImagePoints ( $hGraphic ,  $hImage2 ,  100 ,  100 ,  600 ,  170 ,  130 ,  570 ) 
 
     ; 绘制一个环绕插入图像的框架 
     _GDIPlus_GraphicsDrawRect ( $hGraphic ,  100 ,  100 ,  400 ,  300 ) 
 
     ; 保存组合的图像 
     _GDIPlus_ImageSaveToFile ( $hImage1 ,  @MyDocumentsDir  &  "\GDIPlus_Image.jpg" ) 
 
     ; 清除资源 
     _GDIPlus_ImageDispose ( $hImage1 ) 
     _GDIPlus_ImageDispose ( $hImage2 ) 
     _WinAPI_DeleteObject ( $hBitmap1 ) 
     _WinAPI_DeleteObject ( $hBitmap2 ) 
 
     ; 关闭GDI+库 
     _GDIPlus_Shutdown () 
 
 EndFunc    ;==>_Main 
 
