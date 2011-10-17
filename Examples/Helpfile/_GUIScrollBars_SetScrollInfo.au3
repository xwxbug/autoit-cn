
 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GUIConstantsEx.au3> 
 #include <WindowsConstants.au3> 
 #include <StructureConstants.au3> 
 #include <GUIScrollBars.au3> 
 #include <ScrollBarConstants.au3> 
 
 Opt ( "MustDeclareVars" , 1 ) 
 
 _Main () 
 
 Func _Main () 
   Local $nFileMenu , $nExititem , $GUIMsg , $hGUI , $h_cGUI , $h_cGUI2 
   Local $listview , $button 
 
   $hGUI = GUICreate ( "ScrollBar Example" , 400 , 400 , - 1 , - 1 , BitOR ( $WS_MINIMIZEBOX , $WS_CAPTION , $WS_POPUP , $WS_SYSMENU , $WS_SIZEBOX )) 
   GUISetBkColor ( 0x88AABB ) 
   
   $nFileMenu = GUICtrlCreateMenu ( "File" ) 
   $nExititem = GUICtrlCreateMenuItem ( "Exit" , $nFileMenu ) 
   $listview = GUICtrlCreateListView ( "col1  |col2|col3  " , 10 , 10 , 200 , 150 ) ;,$LVS_SORTDESCENDING) 
   $button = GUICtrlCreateButton ( "Value?" , 75 , 170 , 70 , 20 ) 
   GUICtrlSetResizing ( $button , $GUI_DOCKALL ) 
   For $x = 1 To 30 
       GUICtrlCreateListViewItem ( "item" & $x & "|col2|col3" , $listview ) 
   Next 
   GUICtrlSetResizing ( $listview , $GUI_DOCKALL ) 
   
   $h_cGUI = GUICreate ( "Child GUI" , 200 , 200 , 10 , 200 , $WS_CHILD , $WS_EX_CLIENTEDGE , $hGUI ) 
   GUICtrlCreateButton ( "a button" , 10 , 10 , 90 , 20 ) 
   GUISetBkColor ( 0X006400 ) 
   GUISetState () 
   GUICtrlSetResizing ( $h_cGUI , $GUI_DOCKALL ) 
 
   GUISwitch ( $hGUI ) 
 
   $h_cGUI2 = GUICreate ( "Child GUI" , 200 , 200 , 215 , 10 , $WS_CHILD , $WS_EX_CLIENTEDGE , $hGUI ) 
   GUICtrlCreateButton ( "a button" , 10 , 10 , 90 , 20 ) 
   GUISetBkColor ( 0X006400 ) 
   GUISetState () 
   GUICtrlSetResizing ( $h_cGUI2 , $GUI_DOCKALL ) 
 
   GUISwitch ( $hGUI ) 
 
   GUIRegisterMsg ( $WM_SIZE , "WM_SIZE" ) 
   GUIRegisterMsg ( $WM_VSCROLL , "WM_VSCROLL" ) 
   GUIRegisterMsg ( $WM_HSCROLL , "WM_HSCROLL" ) 
   
   GUISetState () 
 
   _GUIScrollBars_Init ( $hGUI ) 
   _GUIScrollBars_Init ( $h_cGUI ) 
 
   While 1 
       $GUIMsg = GUIGetMsg () 
 
       Switch $GUIMsg 
           Case $GUI_EVENT_CLOSE , $nExititem 
               ExitLoop 
       EndSwitch 
   WEnd 
 
   Exit 
 EndFunc    ;==>_Main 
 
 Func WM_SIZE ( $hWnd , $Msg , $wParam , $lParam ) 
   #forceref $Msg, $wParam 
   Local $index = - 1 , $yChar , $xChar , $xClientMax , $xClient , $yClient , $ivMax 
   For $x = 0 To UBound ( $aSB_WindowInfo ) - 1 
       If $aSB_WindowInfo [ $x ][ 0 ] = $hWnd Then 
           $index = $x 
           $xClientMax = $aSB_WindowInfo [ $index ][ 1 ] 
           $xChar = $aSB_WindowInfo [ $index ][ 2 ] 
           $yChar = $aSB_WindowInfo [ $index ][ 3 ] 
           $ivMax = $aSB_WindowInfo [ $index ][ 7 ] 
           ExitLoop 
       EndIf 
   Next 
   If $index = - 1 Then Return 0 
 
   Local $tSCROLLINFO = DllStructCreate ( $tagSCROLLINFO ) 
 
   ; 修正客户区域尺寸 
   $xClient = BitAND ( $lParam , 0x0000FFFF ) 
   $yClient = BitShift ( $lParam , 16 ) 
   $aSB_WindowInfo [ $index ][ 4 ] = $xClient 
   $aSB_WindowInfo [ $index ][ 5 ] = $yClient 
 
   ; 设置垂直滚动范围和页面大小 
   DllStructSetData ( $tSCROLLINFO , "fMask" , BitOR ( $SIF_RANGE , $SIF_PAGE )) 
   DllStructSetData ( $tSCROLLINFO , "nMin" , 0 ) 
   DllStructSetData ( $tSCROLLINFO , "nMax" , $ivMax ) 
   DllStructSetData ( $tSCROLLINFO , "nPage" , $yClient / $yChar ) 
   _GUIScrollBars_SetScrollInfo ( $hWnd , $SB_VERT , $tSCROLLINFO ) 
 
   ; 设置水平滚动范围和页面大小 
   DllStructSetData ( $tSCROLLINFO , "fMask" , BitOR ( $SIF_RANGE , $SIF_PAGE )) 
   DllStructSetData ( $tSCROLLINFO , "nMin" , 0 ) 
   DllStructSetData ( $tSCROLLINFO , "nMax" , 2 + $xClientMax / $xChar ) 
   DllStructSetData ( $tSCROLLINFO , "nPage" , $xClient / $xChar ) 
   _GUIScrollBars_SetScrollInfo ( $hWnd , $SB_HORZ , $tSCROLLINFO ) 
 
   Return $GUI_RUNDEFMSG 
 EndFunc    ;==>WM_SIZE 
 
 Func WM_HSCROLL ( $hWnd , $Msg , $wParam , $lParam ) 
   #forceref $Msg, $lParam 
   Local $nScrollCode = BitAND ( $wParam , 0x0000FFFF ) 
 
   Local $index = - 1 , $xChar , $xPos 
   Local $Min , $Max , $Page , $Pos , $TrackPos 
 
   For $x = 0 To UBound ( $aSB_WindowInfo ) - 1 
       If $aSB_WindowInfo [ $x ][ 0 ] = $hWnd Then 
           $index = $x 
           $xChar = $aSB_WindowInfo [ $index ][ 2 ] 
           ExitLoop 
       EndIf 
   Next 
   If $index = - 1 Then Return 0 
 
 ;~  ; 获取所有水平滚动条信息 
   Local $tSCROLLINFO = _GUIScrollBars_GetScrollInfoEx ( $hWnd , $SB_HORZ ) 
   $Min = DllStructGetData ( $tSCROLLINFO , "nMin" ) 
   $Max = DllStructGetData ( $tSCROLLINFO , "nMax" ) 
   $Page = DllStructGetData ( $tSCROLLINFO , "nPage" ) 
   ; 为稍后进行比较保留位置 
   $xPos = DllStructGetData ( $tSCROLLINFO , "nPos" ) 
   $Pos = $xPos 
   $TrackPos = DllStructGetData ( $tSCROLLINFO , "nTrackPos" ) 
   #forceref $Min, $Max 
   Switch $nScrollCode 
 
       Case $SB_LINELEFT ; 点击向左箭头 
           DllStructSetData ( $tSCROLLINFO , "nPos" , $Pos - 1 ) 
 
       Case $SB_LINERIGHT ; 点击向右箭头 
           DllStructSetData ( $tSCROLLINFO , "nPos" , $Pos + 1 ) 
 
       Case $SB_PAGELEFT ; 点击快速向左 
           DllStructSetData ( $tSCROLLINFO , "nPos" , $Pos - $Page ) 
 
       Case $SB_PAGERIGHT ; 点击快速向右 
           DllStructSetData ( $tSCROLLINFO , "nPos" , $Pos + $Page ) 
 
       Case $SB_THUMBTRACK ; 拖动滚动箱 
           DllStructSetData ( $tSCROLLINFO , "nPos" , $TrackPos ) 
   EndSwitch 
 
 ;~    // 设置位置然后修正它. 由于窗口的调整可能会和设置的值不同. 
 
   DllStructSetData ( $tSCROLLINFO , "fMask" , $SIF_POS ) 
   _GUIScrollBars_SetScrollInfo ( $hWnd , $SB_HORZ , $tSCROLLINFO ) 
   _GUIScrollBars_GetScrollInfo ( $hWnd , $SB_HORZ , $tSCROLLINFO ) 
   ;// 如果位置改变, 滚动窗口并刷新 
   $Pos = DllStructGetData ( $tSCROLLINFO , "nPos" ) 
   If ( $Pos <> $xPos ) Then _GUIScrollBars_ScrollWindow ( $hWnd , $xChar * ( $xPos - $Pos ), 0 ) 
   Return $GUI_RUNDEFMSG 
 EndFunc    ;==>WM_HSCROLL 
 
 Func WM_VSCROLL ( $hWnd , $Msg , $wParam , $lParam ) 
   #forceref $Msg, $wParam, $lParam 
   Local $nScrollCode = BitAND ( $wParam , 0x0000FFFF ) 
   Local $index = - 1 , $yChar , $yPos 
   Local $Min , $Max , $Page , $Pos , $TrackPos 
 
   For $x = 0 To UBound ( $aSB_WindowInfo ) - 1 
       If $aSB_WindowInfo [ $x ][ 0 ] = $hWnd Then 
           $index = $x 
           $yChar = $aSB_WindowInfo [ $index ][ 3 ] 
           ExitLoop 
       EndIf 
   Next 
   If $index = - 1 Then Return 0 
 
 
   ; 获取所有垂直滚动条信息 
   Local $tSCROLLINFO = _GUIScrollBars_GetScrollInfoEx ( $hWnd , $SB_VERT ) 
   $Min = DllStructGetData ( $tSCROLLINFO , "nMin" ) 
   $Max = DllStructGetData ( $tSCROLLINFO , "nMax" ) 
   $Page = DllStructGetData ( $tSCROLLINFO , "nPage" ) 
   ; 为稍后的比较保存位置 
   $yPos = DllStructGetData ( $tSCROLLINFO , "nPos" ) 
   $Pos = $yPos 
   $TrackPos = DllStructGetData ( $tSCROLLINFO , "nTrackPos" ) 
 
   Switch $nScrollCode 
       Case $SB_TOP ; 点击HOME键盘键 
           DllStructSetData ( $tSCROLLINFO , "nPos" , $Min ) 
 
       Case $SB_BOTTOM ; 点击END键盘键 
           DllStructSetData ( $tSCROLLINFO , "nPos" , $Max ) 
 
       Case $SB_LINEUP ; 点击顶部箭头 
           DllStructSetData ( $tSCROLLINFO , "nPos" , $Pos - 1 ) 
 
       Case $SB_LINEDOWN ; 点击底部箭头 
           DllStructSetData ( $tSCROLLINFO , "nPos" , $Pos + 1 ) 
 
       Case $SB_PAGEUP ; 点击快速上滚箭头 
           DllStructSetData ( $tSCROLLINFO , "nPos" , $Pos - $Page ) 
 
       Case $SB_PAGEDOWN ; 点击快速下滚箭头 
           DllStructSetData ( $tSCROLLINFO , "nPos" , $Pos + $Page ) 
 
       Case $SB_THUMBTRACK ; 拖动滚动箱 
           DllStructSetData ( $tSCROLLINFO , "nPos" , $TrackPos ) 
   EndSwitch 
 
 ;~    // 设置位置然后修正它. 由于窗口的调整可能会和设置的值不同. 
 
   DllStructSetData ( $tSCROLLINFO , "fMask" , $SIF_POS ) 
   _GUIScrollBars_SetScrollInfo ( $hWnd , $SB_VERT , $tSCROLLINFO ) 
   _GUIScrollBars_GetScrollInfo ( $hWnd , $SB_VERT , $tSCROLLINFO ) 
   ;// 如果位置改变, 滚动窗口并升级 
   $Pos = DllStructGetData ( $tSCROLLINFO , "nPos" ) 
 
   If ( $Pos <> $yPos ) Then 
       _GUIScrollBars_ScrollWindow ( $hWnd , 0 , $yChar * ( $yPos - $Pos )) 
       $yPos = $Pos 
   EndIf 
 
   Return $GUI_RUNDEFMSG 
 
 EndFunc    ;==>WM_VSCROLL 
 
