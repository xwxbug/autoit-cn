 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GuiReBar.au3> 
 #include <GuiToolBar.au3> 
 #include <GuiComboBox.au3> 
 #include <GuiDateTimePicker.au3> 
 #include <WindowsConstants.au3> 
 #include <Constants.au3> 
 #include <GuiConstantsEx.au3> 
 #include <EditConstants.au3> 
 
 Opt ( "MustDeclareVars" , 1 ) 
 
 $Debug_RB = False 
 
 Global $hReBar , $edit 
 
 _Main () 
 
 Func _Main() 
   Local $hgui , $btnExit , $hToolbar , $hCombo , $hDTP , $hInput 
   Local Enum $idNew = 1000 , $idOpen , $idSave , $idHelp 
 
   $hgui = GUICreate ( "Rebar" , 400 , 396 , - 1 , - 1 , BitOR ( $WS_MINIMIZEBOX , $WS_CAPTION , $WS_POPUP , $WS_SYSMENU , $WS_MAXIMIZEBOX )) 
 
   GUIRegisterMsg ( $WM_NOTIFY , "WM_NOTIFY" ) 
 
   ; 创建伸缩条控件 
   $hReBar = _GUICtrlReBar_Create ( $hgui , BitOR ( $CCS_TOP , $WS_BORDER , $RBS_VARHEIGHT , $RBS_AUTOSIZE , $RBS_BANDBORDERS )) 
 
 
   ; 在伸缩条中创建工具栏 
   $hToolbar = _GUICtrlToolBar_Create ( $hgui , BitOR ( $TBSTYLE_FLAT , $CCS_NORESIZE , $CCS_NOPARENTALIGN )) 
 
   ; 添加标准系统位图 
   Switch _GUICtrlToolbar_GetBitmapFlags ( $hToolbar ) 
     Case 0 
       _GUICtrlToolbar_AddBitmap ( $hToolbar , 1 , -1 , $IDB_STD_SMALL_COLOR ) 
     Case 2 
       _GUICtrlToolbar_AddBitmap ( $hToolbar , 1 , -1 , $IDB_STD_LARGE_COLOR ) 
   EndSwitch 
 
   ; 添加按钮 
   _GUICtrlToolbar_AddButton ( $hToolbar , $idNew , $STD_FILENEW ) 
   _GUICtrlToolbar_AddButton ( $hToolbar , $idOpen , $STD_FILEOPEN ) 
   _GUICtrlToolbar_AddButton ( $hToolbar , $idSave , $STD_FILESAVE ) 
   _GUICtrlToolbar_AddButtonSep ( $hToolbar ) 
   _GUICtrlToolbar_AddButton ( $hToolbar , $idHelp , $STD_HELP ) 
 
   ; 在伸缩条内创建组合框 
   $hCombo = _GUICtrlComboBox_Create ( $hgui , "" , 0 , 0 , 120 ) 
   _GUICtrlComboBox_BeginUpdate ( $hCombo ) 
   _GUICtrlComboBox_AddDir ( $hCombo , @WindowsDir & "\*.exe" ) 
  _GUICtrlComboBox_EndUpdate ( $hCombo ) 
 
   ; 在伸缩条内创建日期时间拾取器 
   $hDTP = _GUICtrlDTP_Create ( $hgui , 0 , 0 , 190 ) 
 
   ; 在伸缩条内创建输入框 
   $hInput = GUICtrlCreateInput ( "Input control" , 0 , 0 , 120 , 20 ) 
 
   ; 默认添加为附加 
 
   ; 添加带控件的区段 
   _GUICtrlReBar_AddBand ( $hReBar , $hCombo , 120 , 200 , "Dir *.exe" ) 
 
   ; 添加带日期时间拾取器的区段 
   _GUICtrlReBar_AddBand ( $hReBar , $hDTP , 120 ) 
 
   ; 在伸缩条起始处添加带工具栏的区段 
   _GUICtrlReBar_AddToolBarBand ( $hReBar , $hToolbar , "" , 0 ) 
 
   ; 添加其他控件 
   _GUICtrlReBar_AddBand ( $hReBar , GUICtrlGetHandle ( $hInput ), 120 , 200 , "Name:" ) 
 
   ; 添加memo控件查看操作 
   $edit = GUICtrlCreateEdit ( "" , 2 , 60 , 396 , 296 , $WS_VSCROLL ) 
 
   $btnExit = GUICtrlCreateButton ( "Exit" , 150 , 360 , 100 , 25 ) 
   GUISetState ( @SW_SHOW ) 
 
   While 1 
     Switch GUIGetMsg () 
         Case $GUI_EVENT_CLOSE , $btnExit 
         Exit 
     EndSwitch 
   WEnd 
 EndFunc    ;==>_Main 
 
 Func WM_NOTIFY( $hWnd , $iMsg , $iwParam , $ilParam ) 
   #forceref $hWnd, $iMsg, $iwParam 
   Local $hWndFrom , $iIDFrom , $tNMREBAR , $iCode , $tNMHDR 
   Local $tAUTOBREAK , $tAUTOSIZE , $tCHEVRON , $tOBJECTNOTIFY , $tCHILDSIZE 
 
   $tNMHDR = DllStructCreate ( $tagNMHDR , $ilParam ) 
   $hWndFrom = HWnd ( DllStructGetData ( $tNMHDR , "hWndFrom" )) 
   $iIDFrom = DllStructGetData ( $tNMHDR , "IDFrom" ) 
   $iCode = DllStructGetData ( $tNMHDR , "Code" ) 
   Switch $hWndFrom 
     Case $hReBar 
       Switch $iCode 
         Case $RBN_AUTOBREAK 
           ; 通知伸缩条主窗体控件中将显示中断符号. 主窗体确定是否生成中断符 
           $tAUTOBREAK = DllStructCreate ( $tagNMREBARAUTOBREAK , $ilParam ) 
           memowrite ( "$RBN_AUTOBREAK" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & DllStructGetData ( $tAUTOBREAK , "hWndFrom" ) & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & DllStructGetData ( $tAUTOBREAK , "IDFrom" ) & @LF ) 
           memowrite( "-->Code:" & @TAB & DllStructGetData ( $tAUTOBREAK , "Code" ) & @LF ) 
           memowrite( "-->uBand:" & @TAB & DllStructGetData ( $tAUTOBREAK , "uBand" ) & @LF ) 
           memowrite( "-->wID:" & @TAB & DllStructGetData ( $tAUTOBREAK , "wID" ) & @LF ) 
           memowrite( "-->lParam:" & @TAB & DllStructGetData ( $tAUTOBREAK , "lParam" ) & @LF ) 
           memowrite( "-->uMsg:" & @TAB & DllStructGetData ( $tAUTOBREAK , "uMsg" ) & @LF ) 
           memowrite( "-->fStyleCurrent:" & @TAB & DllStructGetData ( $tAUTOBREAK , "fStyleCurrent" ) & @LF ) 
           memowrite( "-->fAutoBreak:" & @TAB & DllStructGetData ( $tAUTOBREAK , "fAutoBreak" )) 
           ; 无效返回值 
           Case $RBN_AUTOSIZE 
           ; 伸缩条自动伸缩时由具有$RBS_AUTOSIZE样式的控件发送 
           $tAUTOSIZE = DllStructCreate ( $tagNMRBAUTOSIZE , $ilParam ) 
           memowrite ( "$RBN_AUTOSIZE" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & DllStructGetData ( $tAUTOSIZE , "hWndFrom" ) & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & DllStructGetData ( $tAUTOSIZE , "IDFrom" ) & @LF ) 
           memowrite( "-->Code:" & @TAB & DllStructGetData ( $tAUTOSIZE , "Code" ) & @LF ) 
           memowrite( "-->fChanged:" & @TAB & DllStructGetData ( $tAUTOSIZE , "fChanged" ) & @LF ) 
           memowrite( "-->TargetLeft:" & @TAB & DllStructGetData ( $tAUTOSIZE , "TargetLeft" ) & @LF ) 
           memowrite( "-->TargetTop:" & @TAB & DllStructGetData ( $tAUTOSIZE , "TargetTop" ) & @LF ) 
           memowrite( "-->TargetRight:" & @TAB & DllStructGetData ( $tAUTOSIZE , "TargetRight" ) & @LF ) 
           memowrite( "-->TargetBottom:" & @TAB & DllStructGetData ( $tAUTOSIZE , "TargetBottom" ) & @LF ) 
           memowrite( "-->ActualLeft:" & @TAB & DllStructGetData ( $tAUTOSIZE , "ActualLeft" ) & @LF ) 
           memowrite( "-->ActualTop:" & @TAB & DllStructGetData ( $tAUTOSIZE , "ActualTop" ) & @LF ) 
           memowrite( "-->ActualRight:" & @TAB & DllStructGetData ( $tAUTOSIZE , "ActualRight" ) & @LF ) 
           memowrite( "-->ActualBottom:" & @TAB & DllStructGetData ( $tAUTOSIZE , "ActualBottom" )) 
           ; 无返回值 
           Case $RBN_BEGINDRAG 
           ; 拖曳区段时发送 
           $tNMREBAR = DllStructCreate ( $tagNMREBAR , $ilParam ) 
           memowrite ( "$RBN_BEGINDRAG" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & DllStructGetData ( $tNMREBAR , "hWndFrom" ) & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & DllStructGetData ( $tNMREBAR , "IDFrom" ) & @LF ) 
           memowrite( "-->Code:" & @TAB & DllStructGetData ( $tNMREBAR , "Code" ) & @LF ) 
           memowrite( "-->dwMask:" & @TAB & DllStructGetData ( $tNMREBAR , "dwMask" ) & @LF ) 
           memowrite( "-->uBand:" & @TAB & DllStructGetData ( $tAUTOBREAK , "uBand" ) & @LF ) 
           memowrite( "-->fStyle:" & @TAB & DllStructGetData ( $tAUTOBREAK , "fStyle" ) & @LF ) 
           memowrite( "-->wID:" & @TAB & DllStructGetData ( $tAUTOBREAK , "wID" ) & @LF ) 
           memowrite( "-->lParam:" & @TAB & DllStructGetData ( $tAUTOBREAK , "lParam" )) 
           Return 0 ; 允许伸缩调继续执行拖曳操作 
 ;~          Return 1 ; 非0值表示退出拖曳操作 
         Case $RBN_CHEVRONPUSHED 
           ; 按下箭头时由控件发送 
           ; 应用程序收到该通知时将显示带有各隐藏工具项的弹出菜单 
           ; 使用NMREBARCHEVRON的rc成员查找弹出菜单的正确位置 
           $tCHEVRON = DllStructCreate ( $tagNMREBARCHEVRON , $ilParam ) 
           memowrite ( "$RBN_CHEVRONPUSHED" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & DllStructGetData ( $tCHEVRON , "hWndFrom" ) & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & DllStructGetData ( $tCHEVRON , "IDFrom" ) & @LF ) 
           memowrite( "-->Code:" & @TAB & DllStructGetData ( $tCHEVRON , "Code" ) & @LF ) 
           memowrite( "-->uBand:" & @TAB & DllStructGetData ( $tCHEVRON , "uBand" ) & @LF ) 
           memowrite( "-->wID:" & @TAB & DllStructGetData ( $tCHEVRON , "wID" ) & @LF ) 
           memowrite( "-->lParam:" & @TAB & DllStructGetData ( $tCHEVRON , "lParam" ) & @LF ) 
           memowrite( "-->Left:" & @TAB & DllStructGetData ( $tCHEVRON , "Left" ) & @LF ) 
           memowrite( "-->Top:" & @TAB & DllStructGetData ( $tCHEVRON , "Top" ) & @LF ) 
           memowrite( "-->Right:" & @TAB & DllStructGetData ( $tCHEVRON , "Right" ) & @LF ) 
           memowrite( "-->lParamNM:" & @TAB & DllStructGetData ( $tCHEVRON , "lParamNM" )) 
           ; 无返回值 
           Case $RBN_CHILDSIZE 
           ; 区段子窗体改变大小时由控件发送 
           $tCHILDSIZE = DllStructCreate ( $tagNMREBARCHILDSIZE , $ilParam ) 
           memowrite ( "$RBN_CHILDSIZE" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & DllStructGetData ( $tCHILDSIZE , "hWndFrom" ) & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & DllStructGetData ( $tCHILDSIZE , "IDFrom" ) & @LF ) 
           memowrite( "-->Code:" & @TAB & DllStructGetData ( $tCHILDSIZE , "Code" ) & @LF ) 
           memowrite( "-->uBand:" & @TAB & DllStructGetData ( $tCHILDSIZE , "uBand" ) & @LF ) 
           memowrite( "-->wID:" & @TAB & DllStructGetData ( $tCHILDSIZE , "wID" ) & @LF ) 
           memowrite( "-->CLeft:" & @TAB & DllStructGetData ( $tCHILDSIZE , "CLeft" ) & @LF ) 
           memowrite( "-->CTop:" & @TAB & DllStructGetData ( $tCHILDSIZE , "CTop" ) & @LF ) 
           memowrite( "-->CRight:" & @TAB & DllStructGetData ( $tCHILDSIZE , "CRight" ) & @LF ) 
           memowrite( "-->CBottom:" & @TAB & DllStructGetData ( $tCHILDSIZE , "CBottom" ) & @LF ) 
           memowrite( "-->BLeft:" & @TAB & DllStructGetData ( $tCHILDSIZE , "BLeft" ) & @LF ) 
           memowrite( "-->BTop:" & @TAB & DllStructGetData ( $tCHILDSIZE , "BTop" ) & @LF ) 
           memowrite( "-->BRight:" & @TAB & DllStructGetData ( $tCHILDSIZE , "BRight" ) & @LF ) 
           memowrite( "-->BBottom:" & @TAB & DllStructGetData ( $tCHILDSIZE , "BBottom" )) 
           ; 无返回值 
           Case $RBN_DELETEDBAND 
           ; 区段被删除后由控件发送 
           $tNMREBAR = DllStructCreate ( $tagNMREBAR , $ilParam ) 
           memowrite ( "$RBN_DELETEDBAND" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & DllStructGetData ( $tNMREBAR , "hWndFrom" ) & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & DllStructGetData ( $tNMREBAR , "IDFrom" ) & @LF ) 
           memowrite( "-->Code:" & @TAB & DllStructGetData ( $tNMREBAR , "Code" ) & @LF ) 
           memowrite( "-->dwMask:" & @TAB & DllStructGetData ( $tNMREBAR , "dwMask" ) & @LF ) 
           memowrite( "-->uBand:" & @TAB & DllStructGetData ( $tAUTOBREAK , "uBand" ) & @LF ) 
           memowrite( "-->fStyle:" & @TAB & DllStructGetData ( $tAUTOBREAK , "fStyle" ) & @LF ) 
           memowrite( "-->wID:" & @TAB & DllStructGetData ( $tAUTOBREAK , "wID" ) & @LF ) 
           memowrite( "-->lParam:" & @TAB & DllStructGetData ( $tAUTOBREAK , "lParam" )) 
           ; 无返回值 
         Case $RBN_DELETINGBAND 
           ; 区段将被删除时由控件发送 
           $tNMREBAR = DllStructCreate ( $tagNMREBAR , $ilParam ) 
           memowrite ( "$RBN_DELETEDBAND" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & DllStructGetData ( $tNMREBAR , "hWndFrom" ) & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & DllStructGetData ( $tNMREBAR , "IDFrom" ) & @LF ) 
           memowrite( "-->Code:" & @TAB & DllStructGetData ( $tNMREBAR , "Code" ) & @LF ) 
           memowrite( "-->dwMask:" & @TAB & DllStructGetData ( $tNMREBAR , "dwMask" ) & @LF ) 
           memowrite( "-->uBand:" & @TAB & DllStructGetData ( $tAUTOBREAK , "uBand" ) & @LF ) 
           memowrite( "-->fStyle:" & @TAB & DllStructGetData ( $tAUTOBREAK , "fStyle" ) & @LF ) 
           memowrite( "-->wID:" & @TAB & DllStructGetData ( $tAUTOBREAK , "wID" ) & @LF ) 
           memowrite( "-->lParam:" & @TAB & DllStructGetData ( $tAUTOBREAK , "lParam" )) 
           ; 无返回值 
         Case $RBN_ENDDRAG 
           ; 停止拖曳时由控件发送 
           $tNMREBAR = DllStructCreate ( $tagNMREBAR , $ilParam ) 
           memowrite ( "$RBN_ENDDRAG" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & DllStructGetData ( $tNMREBAR , "hWndFrom" ) & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & DllStructGetData ( $tNMREBAR , "IDFrom" ) & @LF ) 
           memowrite( "-->Code:" & @TAB & DllStructGetData ( $tNMREBAR , "Code" ) & @LF ) 
           memowrite( "-->dwMask:" & @TAB & DllStructGetData ( $tNMREBAR , "dwMask" ) & @LF ) 
           memowrite( "-->uBand:" & @TAB & DllStructGetData ( $tAUTOBREAK , "uBand" ) & @LF ) 
           memowrite( "-->fStyle:" & @TAB & DllStructGetData ( $tAUTOBREAK , "fStyle" ) & @LF ) 
           memowrite( "-->wID:" & @TAB & DllStructGetData ( $tAUTOBREAK , "wID" ) & @LF ) 
           memowrite( "-->lParam:" & @TAB & DllStructGetData ( $tAUTOBREAK , "lParam" )) 
           ; 无返回值 
         Case $RBN_GETOBJECT 
           ; 当对象被拖到控件区段上时由带有$RBS_REGISTERDROP样式的伸缩条控件发送 
           $tOBJECTNOTIFY = DllStructCreate ( $tagNMOBJECTNOTIFY , $ilParam ) 
           memowrite ( "$RBN_GETOBJECT" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & DllStructGetData ( $tOBJECTNOTIFY , "hWndFrom" ) & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & DllStructGetData ( $tOBJECTNOTIFY , "IDFrom" ) & @LF ) 
           memowrite( "-->Code:" & @TAB & DllStructGetData ( $tOBJECTNOTIFY , "Code" ) & @LF ) 
           memowrite( "-->Item:" & @TAB & DllStructGetData ( $tOBJECTNOTIFY , "Item" ) & @LF ) 
           memowrite( "-->piid:" & @TAB & DllStructGetData ( $tAUTOBREAK , "piid" ) & @LF ) 
           memowrite( "-->pObject:" & @TAB & DllStructGetData ( $tAUTOBREAK , "pObject" ) & @LF ) 
           memowrite( "-->Result:" & @TAB & DllStructGetData ( $tAUTOBREAK , "Result" )) 
           ; 无返回值 
           Case $RBN_HEIGHTCHANGE 
           ; 控件高度改变时发送 
           ; 带有$CCS_VERT样式的伸缩条控件在其高度改变时发送 
           memowrite ( "$RBN_HEIGHTCHANGE" & @LF ) 
           memowrite( "-->hWndFrom:" & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & $iCode ) 
           ; 无返回值 
           Case $RBN_LAYOUTCHANGED 
           ; 控件区段布局改变时发送 
           memowrite ( "$RBN_LAYOUTCHANGED" & @LF ) 
           memowrite( "-->hWndFrom:" & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & $iCode ) 
           ; 无返回值 
           Case $RBN_MINMAX 
           ; 区段最大化或最小化前由控件发送 
           memowrite ( "$RBN_MINMAX" & @LF ) 
           memowrite( "-->hWndFrom:" & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & $iCode ) 
 ;~          Return 1 ; 非0值为禁止操作 
           Return 0 ; 0为允许继续 
       EndSwitch 
   EndSwitch 
   Return $GUI_RUNDEFMSG 
 EndFunc    ;==>WM_NOTIFY 
 
 Func memowrite ( $s_text ) 
     GUICtrlSetData ( $edit , $s_text & @CRLF , 1) 
 EndFunc    ;==>memowrite 
 
