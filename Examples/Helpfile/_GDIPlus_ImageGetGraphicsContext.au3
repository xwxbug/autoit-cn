 
 #include  <GuiConstantsEx.au3> 
 #include  <GDIPlus.au3> 
 #include  <ScreenCapture.au3> 
 #include  <WinAPI.au3> 
 
 Opt ( 'MustDeclareVars' ,  1 ) 
 
 _Main () 
 
 Func _Main () 
     Local  $hBitmap1 ,  $hBitmap2 ,  $hImage1 ,  $hImage2 ,  $hGraphics 
 
     ; 初始化GDI+库 
     _GDIPlus_Startup  () 
 
     ; 全屏捕捉 
     $hBitmap1  =  _ScreenCapture_Capture  ( "" ) 
     $hImage1  =  _GDIPlus_BitmapCreateFromHBITMAP  ( $hBitmap1 ) 
 
     ; 捕捉屏幕区域 
     $hBitmap2  =  _ScreenCapture_Capture  ( "" ,  0 ,  0 ,  400 ,  300 ) 
     $hImage2  =  _GDIPlus_BitmapCreateFromHBITMAP  ( $hBitmap2 ) 
 
     ; 在另一个图像中绘制图像 
     $hGraphics  =  _GDIPlus_ImageGetGraphicsContext  ( $hImage1 ) 
     _GDIPlus_GraphicsDrawImage  ( $hGraphics ,  $hImage2 ,  100 ,  100 ) 
 
     ; 围绕插入的图像绘制框架 
     _GDIPlus_GraphicsDrawRect  ( $hGraphics ,  100 ,  100 ,  400 ,  300 ) 
 
     ; 保存所得的图像 
     _GDIPlus_ImageSaveToFile  ( $hImage1 ,  @MyDocumentsDir  &  "\GDIPlus_Image.jpg" ) 
 
     ; 清除资源 
     _GDIPlus_ImageDispose  ( $hImage1 ) 
     _GDIPlus_ImageDispose  ( $hImage2 ) 
     _WinAPI_DeleteObject  ( $hBitmap1 ) 
     _WinAPI_DeleteObject  ( $hBitmap2 ) 
 
     ; 关闭GDI+库 
     _GDIPlus_ShutDown  () 
 
 EndFunc    ;==>_Main  

