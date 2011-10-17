 
 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include  <GUIConstantsEx.au3> 
 #include  <WindowsConstants.au3> 
 #include  <StructureConstants.au3> 
 #include  <GUIScrollBars.au3> 
 #include  <ScrollBarConstants.au3> 
 
 Opt ( "MustDeclareVars" ,  1 ) 
 
 Global  $iMemo 
 
 _Main () 
 
 Func _Main () 
     Local  $GUIMsg ,  $hGUI ,  $RangeMinMax 
 
     $hGUI  =  GUICreate ( "ScrollBar 示例" ,  400 ,  400 ,  - 1 ,  - 1 ,  BitOR ( $WS_MINIMIZEBOX ,  $WS_CAPTION ,  $WS_POPUP ,  $WS_SYSMENU ,  $WS_SIZEBOX )) 
     $iMemo  =  GUICtrlCreateEdit ( "" ,  2 ,  2 ,  380 ,  380 ,  BitOR ( $WS_HSCROLL ,  $WS_VSCROLL )) 
     GUICtrlSetResizing ( $iMemo ,  $GUI_DOCKALL ) 
     GUICtrlSetFont ( $iMemo ,  9 ,  400 ,  0 ,  "Courier New" ) 
     GUISetBkColor ( 0x88AABB ) 
     
     GUISetState () 
 
     _GUIScrollBars_Init ( $hGUI ) 
 
     $RangeMinMax  =  _GUIScrollBars_GetScrollRange ( $hGUI ,  $SB_VERT ) 
     MemoWrite ( "Vertical Min/Max: "  &  $RangeMinMax [ 0 ]  &  "/"  &  $RangeMinMax [ 1 ]) 
     $RangeMinMax  =  _GUIScrollBars_GetScrollRange ( $hGUI ,  $SB_HORZ ) 
     MemoWrite ( "Horizontal Min/Max: "  &  $RangeMinMax [ 0 ]  &  "/"  &  $RangeMinMax [ 1 ]) 
     Sleep ( 1000 ) 
     _GUIScrollBars_SetScrollRange ( $hGUI ,  $SB_VERT ,  3 ,  30 ) 
     $RangeMinMax  =  _GUIScrollBars_GetScrollRange ( $hGUI ,  $SB_VERT ) 
     MemoWrite ( "New Vertical Min/Max: "  &  $RangeMinMax [ 0 ]  &  "/"  &  $RangeMinMax [ 1 ]) 
     Sleep ( 1000 ) 
     _GUIScrollBars_SetScrollRange ( $hGUI ,  $SB_HORZ ,  10 ,  98 ) 
     $RangeMinMax  =  _GUIScrollBars_GetScrollRange ( $hGUI ,  $SB_HORZ ) 
     MemoWrite ( "New Horizontal Min/Max: "  &  $RangeMinMax [ 0 ]  &  "/"  &  $RangeMinMax [ 1 ]) 
 
     While  1 
         $GUIMsg  =  GUIGetMsg () 
 
         Switch  $GUIMsg 
             Case  $GUI_EVENT_CLOSE 
                 ExitLoop 
         EndSwitch 
     WEnd 
 
     Exit 
 EndFunc    ;==>_Main 
 
 ; 向memo控件写入一行 
 Func MemoWrite ( $sMessage ) 
     GUICtrlSetData ( $iMemo ,  $sMessage  &  @CRLF ,  1 ) 
 EndFunc    ;==>MemoWrite 
