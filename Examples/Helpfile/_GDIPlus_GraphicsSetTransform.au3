 
 #AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include  <GDIPlus.au3> 
 #include  <ScreenCapture.au3> 
 #include  <WinAPI.au3> 
 
 Opt ( 'MustDeclareVars' ,  1 ) 
 
 _Main () 
 
 Func _Main () 
     Local  $hBitmap1 ,  $hBitmap2 ,  $hImage1 ,  $hImage2 ,  $hGraphic ,  $width ,  $height 
 
     ; 初始化GDI+库 
     _GDIPlus_Startup () 
 
     ; 捕捉全屏幕 
     $hBitmap1  =  _ScreenCapture_Capture ( "" ) 
     $hImage1  =  _GDIPlus_BitmapCreateFromHBITMAP ( $hBitmap1 ) 
 
     ; 捕捉屏幕区域 
     $hBitmap2  =  _ScreenCapture_Capture ( "" ,  0 ,  0 ,  400 ,  300 ) 
     $hImage2  =  _GDIPlus_BitmapCreateFromHBITMAP ( $hBitmap2 ) 
 
     $width  =  _GDIPlus_ImageGetWidth ( $hImage2 ) 
     $height  =  _GDIPlus_ImageGetHeight ( $hImage2 ) 
 
     ; 将指定图像绘制到另一个 
     $hGraphic  =  _GDIPlus_ImageGetGraphicsContext ( $hImage1 ) 
 
     ;DrawInsert($hGraphic, $hImage2, $iX, $iY, $nAngle,    $iWidth,    $iHeight, $iARGB = 0xFF000000, $nWidth = 1) 
     DrawInsert ( $hGraphic ,  $hImage2 ,  350 ,  100 ,  0 ,  $width  +  2 ,  $height  +  2 ,  0xFFFF8000 ,  2 ) 
     DrawInsert ( $hGraphic ,  $hImage2 ,  340 ,  50 ,  15 ,  200 ,  150 ,  0xFFFF8000 ,  4 ) 
     DrawInsert ( $hGraphic ,  $hImage2 ,  310 ,  30 ,  35 ,  $width  +  4 ,  $height  +  4 ,  0xFFFF00FF ,  4 ) 
     DrawInsert ( $hGraphic ,  $hImage2 ,  320 ,  790 ,  - 35 ,  $width ,  $height ) 
 
     ; 保存相应的图像 
     _GDIPlus_ImageSaveToFile ( $hImage1 ,  @MyDocumentsDir  &  "\GDIPlus_Image.jpg" ) 
 
     ; 清除资源 
     _GDIPlus_ImageDispose ( $hImage1 ) 
     _GDIPlus_ImageDispose ( $hImage2 ) 
     _WinAPI_DeleteObject ( $hBitmap1 ) 
     _WinAPI_DeleteObject ( $hBitmap2 ) 
     ; Shut down GDI+ library 
     _GDIPlus_Shutdown () 
 
 EndFunc    ;==>_Main 
 
 ; #FUNCTION# ================================================================================================== 
 ; 名称..: DrawInsert 
 ; 描述..: 将一个图像绘制到另一个图像中 
 ; 语法..: DrawInsert($hGraphic, $hImage2, $iX, $iY, $nAngle, $iWidth, $iHeight, $iARGB = 0xFF000000, $nWidth = 1) 
 ;      将图形$hImage2插入到$hGraphic中 
 ; 参数..: $hGraphics - 图形对象句柄 
 ;      $hImage   - 被插入图像的句柄 
 ;      $iX     - 被插入图像的左上角X坐标 
 ;      $iY     - 被插入图像的左上角Y坐标 
 ;      $iWidth   - 围绕插入对象的矩形边界宽度 
 ;      $iHeight  - 围绕插入对象的矩形边界高度 
 ;      $iARGB   - 画笔颜色的Alpha, 红色, 绿色和蓝色部分 - 边界色 
 ;      $nWidth   - 由$iUnit参数指定单位的画笔宽度 - 边界宽度 
 ; 返回值: 成功 - 真 
 ;      失败 - 假 
 ;================================================================================================== 
 Func DrawInsert ( $hGraphic ,  $hImage2 ,  $iX ,  $iY ,  $nAngle ,  $iWidth ,  $iHeight ,  $iARGB  =  0xFF000000 ,  $nWidth  =  1 ) 
     Local  $hMatrix ,  $hPen2 
 
     ; 旋转矩阵 
     $hMatrix  =  _GDIPlus_MatrixCreate () 
     _GDIPlus_MatrixRotate ( $hMatrix ,  $nAngle ,  "False" ) 
     _GDIPlus_GraphicsSetTransform ( $hGraphic ,  $hMatrix ) 
 
     _GDIPlus_GraphicsDrawImage ( $hGraphic ,  $hImage2 ,  $iX ,  $iY ) 
 
     ; 获取画笔和颜色 
     $hPen2  =  _GDIPlus_PenCreate ( $iARGB ,  $nWidth ) 
 
     ; 围绕插入图像绘制一个框架 
     _GDIPlus_GraphicsDrawRect ( $hGraphic ,  $iX ,  $iY ,  $iWidth ,  $iHeight ,  $hPen2 ) 
 
     ; 清除资源 
     _GDIPlus_MatrixDispose ( $hMatrix ) 
     _GDIPlus_PenDispose ( $hPen2 ) 
     Return  1 
 EndFunc    ;==>DrawInsert  

