 
 #include  <GDIPlus.au3> 
 #include  <GUIConstantsEx.au3> 
 
 $hWnd  =  GUICreate ( "GDI+ Ê¾Àý" ,  400 ,  300 ) 
 GUISetState () 
 
 _GDIPlus_Startup () 
 $hGraphics  =  _GDIPlus_GraphicsCreateFromHWND ( $hWnd ) 
 _GDIPlus_GraphicsClear ( $hGraphics ) 
 
 $hBrush  =  _GDIPlus_BrushCreateSolid ( 0xFF009900 ) 
 $hFamily  =  _GDIPlus_FontFamilyCreate ( "Arial" ) 
 $hFont  =  _GDIPlus_FontCreate ( $hFamily ,  36 ) 
 $hLayout  =  _GDIPlus_RectFCreate ( 0 ,  0 ,  400 ,  300 ) 
 $hStringFormat  =  _GDIPlus_StringFormatCreate () 
 _GDIPlus_StringFormatSetAlign ( $hStringFormat ,  1 ) 
 _GDIPlus_GraphicsDrawStringEx ( $hGraphics ,  "AutoIt Rocks" ,  $hFont ,  $hLayout ,  $hStringFormat ,  $hBrush ) 
 
 Do 
     $msg  =  GUIGetMsg () 
 Until  $msg  =  $GUI_EVENT_CLOSE 
 
 
 _GDIPlus_BrushDispose ( $hBrush ) 
 _GDIPlus_FontFamilyDispose ( $hFamily ) 
 _GDIPlus_FontDispose ( $hFont ) 
 _GDIPlus_StringFormatDispose ( $hStringFormat ) 
 _GDIPlus_GraphicsDispose ( $hGraphics ) 
 _GDIPlus_Shutdown () 
 
