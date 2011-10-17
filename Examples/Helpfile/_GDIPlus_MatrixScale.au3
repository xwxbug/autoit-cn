 
 #include  <GUIConstants.au3> 
 #include  <ScreenCapture.au3> 
 #include  <WinAPI.au3> 
 
 ; 创建界面 
 $hWnd  =  GUICreate ( "GDI+ 示例" ,  500 ,  500 ) 
 GUISetState () 
 
 ; 启动GDI+ 
 _GDIPlus_Startup () 
 $hGraphics  =  _GDIPlus_GraphicsCreateFromHWND ( $hWnd ) 
 _GDIPlus_GraphicsClear ( $hGraphics ) 
 
 ; 获取屏幕左下侧的截图 
 $hScreenCap_hBitmap  =  _ScreenCapture_Capture ( "" ,  0 ,  @DesktopHeight  -  500 ,  500 ,  @DesktopHeight ) 
 $hScreenCap_Bitmap  =  _GDIPlus_BitmapCreateFromHBITMAP ( $hScreenCap_hBitmap ) 
 
 $hMatrix  =  _GDIPlus_MatrixCreate () 
 ; 放大2倍 
 _GDIPlus_MatrixScale ( $hMatrix ,  2.0 ,  2.0 ) 
 
 
 _GDIPlus_GraphicsSetTransform ( $hGraphics ,  $hMatrix ) 
 _GDIPlus_GraphicsDrawImageRect ( $hGraphics ,  $hScreenCap_Bitmap ,  0 ,  0 ,  500 ,  500 ) 
 
 Do 
 Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
 
 ; 清除资源 
 _WinAPI_DeleteObject ( $hScreenCap_hBitmap ) 
 _GDIPlus_BitmapDispose ( $hScreenCap_Bitmap ) 
 _GDIPlus_MatrixDispose ( $hMatrix ) 
 _GDIPlus_GraphicsDispose ( $hGraphics ) 
 _GDIPlus_Shutdown ()  

