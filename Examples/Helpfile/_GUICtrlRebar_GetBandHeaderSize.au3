 
 #include  <GuiConstantsEx.au3> 
 #include  <GuiReBar.au3> 
 #include  <GuiToolBar.au3> 
 #include  <WindowsConstants.au3> 
 #include  <Constants.au3> 
 
 Opt ( "MustDeclareVars" ,  1 ) 
 
 $Debug_RB  =  False 
 
 Global  $iMemo 
 
 _Main () 
 
 Func _Main () 
     Local  $hgui ,  $btnExit ,  $hReBar ,  $hToolbar ,  $hInput 
     Local  Enum  $idNew  =  1000 ,  $idOpen ,  $idSave ,  $idHelp 
 
     $hgui  =  GUICreate ( "Rebar" ,  400 ,  396 ,  - 1 ,  - 1 ,  BitOR ( $WS_MINIMIZEBOX ,  $WS_CAPTION ,  $WS_POPUP ,  $WS_SYSMENU ,  $WS_MAXIMIZEBOX )) 
     
     ; 创建伸缩条控件 
     $hReBar  =  _GUICtrlReBar_Create ( $hgui ,  BitOR ( $CCS_TOP ,  $WS_BORDER ,  $RBS_VARHEIGHT ,  $RBS_AUTOSIZE ,  $RBS_BANDBORDERS )) 
     
     $iMemo  =  GUICtrlCreateEdit ( "" ,  2 ,  100 ,  396 ,  250 ,  $WS_VSCROLL ) 
     GUICtrlSetFont ( $iMemo ,  10 ,  400 ,  0 ,  "Courier New" ) 
 
     
     ; 创建置于伸缩条中的工具栏 
     $hToolbar  =  _GUICtrlToolBar_Create ( $hgui ,  BitOR ( $TBSTYLE_FLAT ,  $CCS_NORESIZE ,  $CCS_NOPARENTALIGN )) 
     
     ; 添加标准系统位图 
     Switch  _GUICtrlToolbar_GetBitmapFlags ( $hToolbar ) 
         Case  0 
             _GUICtrlToolbar_AddBitmap ( $hToolbar ,  1 ,  - 1 ,  $IDB_STD_SMALL_COLOR ) 
         Case  2 
             _GUICtrlToolbar_AddBitmap ( $hToolbar ,  1 ,  - 1 ,  $IDB_STD_LARGE_COLOR ) 
     EndSwitch 
 
     ; 添加按钮 
     _GUICtrlToolbar_AddButton ( $hToolbar ,  $idNew ,  $STD_FILENEW ) 
     _GUICtrlToolbar_AddButton ( $hToolbar ,  $idOpen ,  $STD_FILEOPEN ) 
     _GUICtrlToolbar_AddButton ( $hToolbar ,  $idSave ,  $STD_FILESAVE ) 
     _GUICtrlToolbar_AddButtonSep ( $hToolbar ) 
     _GUICtrlToolbar_AddButton ( $hToolbar ,  $idHelp ,  $STD_HELP ) 
 
     ; 创建置于伸缩条中的输入框 
     $hInput  =  GUICtrlCreateInput ( "Input control" ,  0 ,  0 ,  120 ,  20 ) 
 
     ; 添加包含控件的区段 
     _GUICtrlReBar_AddBand ( $hReBar ,  GUICtrlGetHandle ( $hInput ),  120 ,  200 ,  "Name:" ) 
     
     ; 在伸缩条起点添加包含控件的区段 
     _GUICtrlReBar_AddToolBarBand ( $hReBar ,  $hToolbar ,  "" ,  0 ) 
 
     _GUICtrlRebar_SetBandBackColor ( $hReBar ,  1 ,  Int ( 0x00008B )) 
     _GUICtrlRebar_SetBandForeColor ( $hReBar ,  1 ,  Int ( 0xFFFFFF )) 
     
     $btnExit  =  GUICtrlCreateButton ( "Exit" ,  150 ,  360 ,  100 ,  25 ) 
     GUICtrlSetState ( $btnExit ,  $GUI_DEFBUTTON ) 
     GUICtrlSetState ( $btnExit ,  $GUI_FOCUS ) 
 
     GUISetState ( @SW_SHOW ) 
 
     For  $x  =  0  To  _GUICtrlRebar_GetBandCount ( $hReBar )  -  1 
         MemoWrite ( "============================================" ) 
         MemoWrite ( "Band Index "  &  $x  &  @TAB  &  "Header Size: "  &  _GUICtrlRebar_GetBandHeaderSize ( $hReBar ,  $x )) 
     Next 
 
     MsgBox ( 4096 ,  "Information" ,  "Setting Band Header Size" ) 
     _GUICtrlRebar_SetBandHeaderSize ( $hReBar ,  1 ,  50 ) 
 
     For  $x  =  0  To  _GUICtrlRebar_GetBandCount ( $hReBar )  -  1 
         MemoWrite ( "============================================" ) 
         MemoWrite ( "Band Index "  &  $x  &  @TAB  &  "Header Size: "  &  _GUICtrlRebar_GetBandHeaderSize ( $hReBar ,  $x )) 
     Next 
 
     While  1 
         Switch  GUIGetMsg () 
             Case  $GUI_EVENT_CLOSE ,  $btnExit 
                 Exit 
         EndSwitch 
     WEnd 
 EndFunc    ;==>_Main 
 
 ; 向memo控件写入信息 
 Func MemoWrite ( $sMessage  =  "" ) 
     GUICtrlSetData ( $iMemo ,  $sMessage  &  @CRLF ,  1 ) 
 EndFunc    ;==>MemoWrite 
