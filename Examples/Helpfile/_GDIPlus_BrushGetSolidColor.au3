 
 #AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include  <GuiConstantsEx.au3> 
 #include  <GDIPlus.au3> 
 #include  <WindowsConstants.au3> 
 
 Opt ( 'MustDeclareVars' ,  1 ) 
 
 _Main () 
 
 Func _Main () 
     Local  $hGUI ,  $Label1 ,  $label2 ,  $hGraphic ,  $hBrush1 ,  $iClr1 ,  $iClr2 
 
     ; 创建界面 
     $hGUI  =  GUICreate ( "GDI+" ,  345 ,  150 ) 
     $Label1  =  GUICtrlCreateLabel ( "" ,  2 ,  2 ,  150 ,  20 ) 
     $label2  =  GUICtrlCreateLabel ( "" ,  202 ,  2 ,  150 ,  20 ) 
     GUISetState () 
     Sleep ( 100 ) 
 
     ; 启动GDIPlus 
     _GDIPlus_Startup () 
     $hGraphic  =  _GDIPlus_GraphicsCreateFromHWND ( $hGUI ) 
 
     ; 创建实心画刷 
     $hBrush1  =  _GDIPlus_BrushCreateSolid () 
 
     ; 获取实心画刷颜色 
     $iClr1  =  _GDIPlus_BrushGetSolidColor ( $hBrush1 ) 
 
     ; 以原始画刷颜色绘制一些图形 
     _GDIPlus_GraphicsFillEllipse ( $hGraphic ,  25 ,  25 ,  100 ,  100 ,  $hBrush1 ) 
 
     ; 设置画刷颜色(0xFFFF0000 = Red) 
     _GDIPlus_BrushSetSolidColor ( $hBrush1 ,  0xFFFF0000 ) 
 
     ; 获取新的画刷颜色 
     $iClr2  =  _GDIPlus_BrushGetSolidColor ( $hBrush1 ) 
 
     ; 以新的画刷颜色绘制一些图形 
     _GDIPlus_GraphicsFillRect ( $hGraphic ,  220 ,  25 ,  100 ,  100 ,  $hBrush1 ) 
 
     ; 将原始画刷色写入Label1 
     GUICtrlSetData ( $Label1 ,  "Brush orignal color: "  &  Hex ( $iClr1 )) 
 
     ; 将新画刷色写入Label2 
     GUICtrlSetData ( $label2 ,  "Brush new color: "  &  Hex ( $iClr2 )) 
 
     ; 循环至用户退出 
     Do 
     Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
 
     ; 清除资源 
     _GDIPlus_BrushDispose ( $hBrush1 ) 
     _GDIPlus_GraphicsDispose ( $hGraphic ) 
     _GDIPlus_Shutdown () 
 
 EndFunc    ;==>_Main 
 
