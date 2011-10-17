 
 #AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 
 #include  <GuiConstantsEx.au3> 
 #include  <WindowsConstants.au3> 
 #include  <GDIPlus.au3> 
 #include  <ScreenCapture.au3> 
 #include  <WinAPI.au3> 
 
 
 Opt ( 'MustDeclareVars' ,  1 ) 
 
 Global  $iMemo 
 
 _Main () 
 
 Func _Main () 
     Local  $hGUI ,  $hBitmap ,  $hImage ,  $aRet 
 
     ; 创建界面 
     $hGUI  =  GUICreate ( "GDI+" ,  600 ,  400 ) 
     $iMemo  =  GUICtrlCreateEdit ( "" ,  2 ,  2 ,  596 ,  396 ,  $WS_VSCROLL ) 
     GUICtrlSetFont ( $iMemo ,  9 ,  400 ,  0 ,  "Courier New" ) 
     GUISetState () 
 
     ; 初始化GDI+库 
     _GDIPlus_Startup () 
 
     ; 捕捉32位位图 
     $hBitmap  =  _ScreenCapture_Capture ( "" ) 
     $hImage  =  _GDIPlus_BitmapCreateFromHBITMAP ( $hBitmap ) 
     
     ; 显示屏幕捕捉的像素格式 
     $aRet  =  _GDIPlus_ImageGetPixelFormat ( $hImage ) 
     MemoWrite ( "Image pixel format of screen capture: "  &  $aRet [ 1 ]) ; 
     MemoWrite ( "Image pixel format constant: "  &  $aRet [ 0 ]) ; 
     MemoWrite () ; 
     
     ; 将屏幕捕捉位图保存为文件 
     _GDIPlus_ImageSaveToFile ( $hImage ,  @MyDocumentsDir  &  "\GDIPlus_Image.jpg" ) 
     
     ; 清除资源 
     _GDIPlus_ImageDispose ( $hImage ) 
     _WinAPI_DeleteObject ( $hBitmap ) 
     
     ; 从文件加载屏幕捕捉位图 
     $hImage  =  _GDIPlus_ImageLoadFromFile ( @MyDocumentsDir  &  "\GDIPlus_Image.jpg" ) 
     
     ; 显示保存文件的像素格式 
     $aRet  =  _GDIPlus_ImageGetPixelFormat ( $hImage ) 
     MemoWrite ( "Image pixel format of saved file: "  &  $aRet [ 1 ]) ; 
     MemoWrite ( "Image pixel format constant: "  &  $aRet [ 0 ]) ; 
     
     ; 清除资源 
     _GDIPlus_ImageDispose ( $hImage ) 
 
     ; 关闭GDI+库 
     _GDIPlus_Shutdown () 
 
     ; 循环至用户退出 
     Do 
     Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
 
 EndFunc    ;==>_Main 
 
 ; 写入memo控件 
 Func MemoWrite ( $sMessage  =  '' ) 
     GUICtrlSetData ( $iMemo ,  $sMessage  &  @CRLF ,  1 ) 
 EndFunc    ;==>MemoWrite  

