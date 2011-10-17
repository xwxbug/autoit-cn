 #AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include  <GDIPlus.au3> 
 #include  <GuiConstantsEx.au3> 
 
 Global Const $nPI = 3.1415926535897932384626433832795 
 Global $hGraphic , $hBrush , $hFormat , $hFamily , $hFont , $tLayout , $hBitmap1 , $hImage , $hClone , $iX , $iY , $hBitmap 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 _Main() 
 
 Func _Main() 
   Local $hGUI , $hWnd , $hMatrix , $width , $height , $hBitmap1 , $hImage1 
 
   ; 创建界面 
   $hGUI = GUICreate ( " GDI+ ", 400 , 300 ) 
   GUISetBkColor ( 0xEAFEFE ) 
   $hWnd = WinGetHandle ( " GDI+ " ) 
   GUISetState () 
 
   ; 绘制字符串 
   _GDIPlus_Startup () 
   $hGraphic = _GDIPlus_GraphicsCreateFromHWND ( $hWnd ) 
 
   ;环 
   DrawGraphic( $hGraphic , 120 , 150 , 45 , 100 , 20 , 0xFFFF8000 ) 
   DrawGraphic( $hGraphic , 120 , 150 , 135 , 100 , 20 , 0xFF00FF00 ) 
   DrawGraphic( $hGraphic , 120 , 150 , 225 , 100 , 20 , 0xFF0505FB ) 
   DrawGraphic( $hGraphic , 120 , 150 , 315 , 100 , 20 , 0xFFFF00FF ) 
 
   ;方阵 
   DrawGraphic( $hGraphic , 260 , 200 , 0 , 100 , 20 , 0xFFFF8000 ) 
   DrawGraphic( $hGraphic , 260 , 100 , 90 , 100 , 20 , 0xFF00FF00 ) 
   DrawGraphic( $hGraphic , 360 , 100 , 180 , 100 , 20 , 0xFF0505FB ) 
   DrawGraphic( $hGraphic , 360 , 200 , 270 , 100 , 20 , 0xFFFF00FF ) 
 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
 
   ; 清理资源 
   _GDIPlus_ImageDispose ( $hClone ) 
   _GDIPlus_ImageDispose ( $hImage ) 
   _WinAPI_DeleteObject ( $hBitmap1 ) 
   _GDIPlus_FontDispose ( $hFont ) 
   _GDIPlus_FontFamilyDispose ( $hFamily ) 
   _GDIPlus_StringFormatDispose ( $hFormat ) 
   _GDIPlus_BrushDispose ( $hBrush ) 
 
   ; 关闭GDI+库 
   _GDIPlus_Shutdown () 
 
 EndFunc ;==>_Main 
 
 Func DrawGraphic( $hGraphic , $nX , $nY , $nAngle , $nWidth , $nHeight , $iARGB = 0xFF000000 ) 
   Local $hMatrix , $nXt , $nYt 
 
   ; 旋转矩阵 
   $hMatrix = _GDIPlus_MatrixCreate () 
   _GDIPlus_MatrixRotate ( $hMatrix , $nAngle , " False " ) 
   _GDIPlus_GraphicsSetTransform ( $hGraphic , $hMatrix ) 
 
   ; 坐标轴旋转公式 
   $nXt = $nX * Cos ( $nAngle * $nPI / 180 ) + $nY * Sin ( $nAngle * $nPI / 180 ) ; $nXt - 转换前的X坐标 
   $nYt = -$nX * Sin ( $nAngle * $nPI / 180 ) + $nY * Cos ( $nAngle * $nPI / 180 ) ; $nYt - 转换前的Y坐标 
 
   $hBrush = _GDIPlus_BrushCreateSolid ( $iARGB ) 
   $hFormat = _GDIPlus_StringFormatCreate () 
   $hFamily = _GDIPlus_FontFamilyCreate ( " Arial " ) 
   $hFont = _GDIPlus_FontCreate ( $hFamily , 12 , 1 ) 
   $tLayout = _GDIPlus_RectFCreate ( $nXt , $nYt , $nWidth , $nHeight ) 
   _GDIPlus_GraphicsDrawStringEx ( $hGraphic , " Hello world ", $hFont , $tLayout , $hFormat , $hBrush ) 
   Sleep ( 1000 ) 
 
   ; 清除资源 
   _GDIPlus_MatrixDispose ( $hMatrix ) 
 
   Return 1 
 EndFunc ;==>DrawGraphic 
 
