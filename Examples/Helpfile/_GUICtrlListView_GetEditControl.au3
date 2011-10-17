 
 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GuiConstantsEx.au3> 
 #include <GuiListView.au3> 
 #include <GuiImageList.au3> 
 #include <WindowsConstants.au3> 
 #include <EditConstants.au3> 
 
 Opt ( 'MustDeclareVars' , 1 ) 
 
 $Debug_LV = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 
 
 Global $hListView, $edit 
 
 _Main () 
 
 Func _Main () 
   Local $hImage 
   
   GUICreate ( "ListView Get Edit Control" , 400 , 400 ) 
   $hListView = GUICtrlCreateListView ( "" , 2 , 2 , 394 , 100 , BitOR ( $LVS_EDITLABELS , $LVS_REPORT )) 
   _GUICtrlListView_SetExtendedListViewStyle ( $hListView , BitOR ( $LVS_EX_GRIDLINES , $LVS_EX_FULLROWSELECT , $LVS_EX_DOUBLEBUFFER )) 
   _GUICtrlListView_SetUnicodeFormat ( $hListView , False ) 
   $edit = GUICtrlCreateEdit ( "" , 2 , 105 , 394 , 287 , BitOR ( $WS_VSCROLL , $ES_AUTOVSCROLL )) 
   GUISetState () 
 
   ; 加载图像 
   $hImage = _GUIImageList_Create () 
   _GUIImageList_Add ( $hImage , _GUICtrlListView_CreateSolidBitMap ( GUICtrlGetHandle ( $hListView ), 0xFF0000 , 16 , 16 )) 
   _GUIImageList_Add ( $hImage , _GUICtrlListView_CreateSolidBitMap ( GUICtrlGetHandle ( $hListView ), 0x00FF00 , 16 , 16 )) 
   _GUIImageList_Add ( $hImage , _GUICtrlListView_CreateSolidBitMap ( GUICtrlGetHandle ( $hListView ), 0x0000FF , 16 , 16 )) 
   _GUICtrlListView_SetImageList ( $hListView , $hImage , 1 ) 
 
   ; 添加列 
   _GUICtrlListView_AddColumn ( $hListView , "Column 1" , 100 ) 
   _GUICtrlListView_AddColumn ( $hListView , "Column 2" , 100 ) 
   _GUICtrlListView_AddColumn ( $hListView , "Column 3" , 100 ) 
 
   ; 添加项目 
   _GUICtrlListView_AddItem ( $hListView , "Row 1: Col 1" , 0 ) 
   _GUICtrlListView_AddSubItem ( $hListView , 0 , "Row 1: Col 2" , 1 ) 
   _GUICtrlListView_AddSubItem ( $hListView , 0 , "Row 1: Col 3" , 2 ) 
   _GUICtrlListView_AddItem ( $hListView , "Row 2: Col 1" , 1 ) 
   _GUICtrlListView_AddSubItem ( $hListView , 1 , "Row 2: Col 2" , 1 ) 
   _GUICtrlListView_AddItem ( $hListView , "Row 3: Col 1" , 2 ) 
 
   GUIRegisterMsg ( $WM_NOTIFY , "WM_NOTIFY" ) 
   ; 编辑项目0的标签 
   _GUICtrlListView_EditLabel ( $hListView , 0 ) 
   memowrite ( "Edit Handle: " & _GUICtrlListView_GetEditControl ( $hListView )) 
   
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc    ;==>_Main 
 
 Func WM_NOTIFY ( $hWnd , $iMsg , $iwParam , $ilParam ) 
   #forceref $hWnd, $iMsg, $iwParam 
   Local $hWndFrom , $iIDFrom , $iCode , $tNMHDR , $tInfo , $hWndListView = $hListView 
   If Not IsHWnd ( $hListView ) Then $hWndListView = GUICtrlGetHandle ( $hListView ) 
 
   $tNMHDR = DllStructCreate ( $tagNMHDR , $ilParam ) 
   $hWndFrom = HWnd ( DllStructGetData ( $tNMHDR , "hWndFrom" )) 
   $iIDFrom = DllStructGetData ( $tNMHDR , "IDFrom" ) 
   $iCode = DllStructGetData ( $tNMHDR , "Code" ) 
   Switch $hWndFrom 
     Case $hWndListView 
       Switch $iCode 
         Case $LVN_BEGINLABELEDITA , $LVN_BEGINLABELEDITW ;开始进行项目的标签编辑 
           $tInfo = DllStructCreate ( $tagNMLVDISPINFO , $ilParam ) 
           memowrite( "$LVN_BEGINLABELEDIT" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode & @LF ) 
           memowrite( "-->Mask:" & @TAB & $Mask & @LF ) 
           memowrite( "-->Item:" & @TAB & DllStructGetData ( $tInfo , "Item" ) & @LF ) 
           memowrite( "-->SubItem:" & @TAB & DllStructGetData ( $tInfo , "SubItem" ) & @LF ) 
           memowrite( "-->State:" & @TAB & $State & @LF ) 
           memowrite( "-->StateMask:" & @TAB & $iStateMask & @LF ) 
           memowrite( "-->Image:" & @TAB & DllStructGetData ( $tInfo , "Image" ) & @LF ) 
           memowrite( "-->Param:" & @TAB & DllStructGetData ( $tInfo , "Param" ) & @LF ) 
           memowrite( "-->Indent:" & @TAB & DllStructGetData ( $tInfo , "Indent" ) & @LF ) 
           memowrite( "-->GroupID:" & @TAB & DllStructGetData ( $tInfo , "GroupID" ) & @LF ) 
           memowrite( "-->Columns:" & @TAB & DllStructGetData ( $tInfo , "Columns" ) & @LF ) 
           memowrite( "-->pColumns:" & @TAB & DllStructGetData ( $tInfo , "pColumns" ) & @LF ) 
           Return False ; 禁止编辑标签 
           ;Return True ; 允许编辑标签 
         Case $LVN_COLUMNCLICK ; 点击一列 
           $tInfo = DllStructCreate ( $tagNMLISTVIEW , $ilParam ) 
           memowrite ( "$LVN_COLUMNCLICK" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode & @LF ) 
           memowrite( "-->Item:" & @TAB & DllStructGetData ( $tInfo , "Item" ) & @LF ) 
           memowrite( "-->SubItem:" & @TAB & DllStructGetData ( $tInfo , "SubItem" ) & @LF ) 
           memowrite( "-->NewState:" & @TAB & DllStructGetData ( $tInfo , "NewState" ) & @LF ) 
           memowrite( "-->OldState:" & @TAB & DllStructGetData ( $tInfo , "OldState" ) & @LF ) 
           memowrite( "-->Changed:" & @TAB & DllStructGetData ( $tInfo , "Changed" ) & @LF ) 
           memowrite( "-->ActionX:" & @TAB & DllStructGetData ( $tInfo , "ActionX" ) & @LF ) 
           memowrite( "-->ActionY:" & @TAB & DllStructGetData ( $tInfo , "ActionY" ) & @LF ) 
           memowrite( "-->Param:" & @TAB & DllStructGetData ( $tInfo , "Param" )) 
           ; 无返回值 
         Case $LVN_ENDLABELEDITA , $LVN_ENDLABELEDITW ; 项目标签编辑的结束 
           $tInfo = DllStructCreate ( $tagNMLVDISPINFO , $ilParam ) 
           If ( DllStructGetData ( $tInfo , "Text" ) <> 0 ) Then 
             Local $tBuffer = DllStructCreate ( "char Text[" & DllStructGetData ( $tInfo , "TextMax" ) & "]" , DllStructGetData ( $tInfo , "Text" )) 
           memowrite ( "$LVN_ENDLABELEDIT" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode & @LF ) 
           memowrite( "-->Mask:" & @TAB & $Mask & @LF ) 
           memowrite( "-->Item:" & @TAB & $Item & @LF ) 
           memowrite( "-->SubItem:" & @TAB & DllStructGetData ( $tInfo , "SubItem" ) & @LF ) 
           memowrite( "-->State:" & @TAB & $State & @LF ) 
           memowrite( "-->StateMask:" & @TAB & $iStateMask & @LF ) 
           memowrite( "-->Text:" & @TAB & $iText & @LF ) 
           memowrite( "-->TextMax:" & @TAB & DllStructGetData ( $tInfo , "TextMax" ) & @LF ) 
           memowrite( "-->Image:" & @TAB & DllStructGetData ( $tInfo , "Image" ) & @LF ) 
           memowrite( "-->Param:" & @TAB & DllStructGetData ( $tInfo , "Param" ) & @LF ) 
           memowrite( "-->Indent:" & @TAB & DllStructGetData ( $tInfo , "Indent" ) & @LF ) 
           memowrite( "-->GroupID:" & @TAB & DllStructGetData ( $tInfo , "GroupID" ) & @LF ) 
           memowrite( "-->Columns:" & @TAB & DllStructGetData ( $tInfo , "Columns" ) & @LF ) 
           memowrite( "-->pColumns:" & @TAB & DllStructGetData ( $tInfo , "pColumns" ) & @LF ) 
             ; 如果文本不为空, 返回真，进行项目标签的文本编辑, 返回假拒绝 
             Return True 
           EndIf 
           ; 如果文本为空忽略返回值 
         Case $NM_CLICK ; 用户用鼠标左键单击一个项目时，由列表视图控件发送 
           $tInfo = DllStructCreate ( $tagNMITEMACTIVATE , $ilParam ) 
           memowrite ( "$NM_CLICK" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode & @LF ) 
           memowrite( "-->Index:" & @TAB & DllStructGetData ( $tInfo , "Index" ) & @LF ) 
           memowrite( "-->SubItem:" & @TAB & DllStructGetData ( $tInfo , "SubItem" ) & @LF ) 
           memowrite( "-->NewState:" & @TAB & DllStructGetData ( $tInfo , "NewState" ) & @LF ) 
           memowrite( "-->OldState:" & @TAB & DllStructGetData ( $tInfo , "OldState" ) & @LF ) 
           memowrite( "-->Changed:" & @TAB & DllStructGetData ( $tInfo , "Changed" ) & @LF ) 
           memowrite( "-->ActionX:" & @TAB & DllStructGetData ( $tInfo , "ActionX" ) & @LF ) 
           memowrite( "-->ActionY:" & @TAB & DllStructGetData ( $tInfo , "ActionY" ) & @LF ) 
           memowrite( "-->lParam:" & @TAB & DllStructGetData ( $tInfo , "lParam" ) & @LF ) 
           memowrite( "-->KeyFlags:" & @TAB & DllStructGetData ( $tInfo , "KeyFlags" )) 
           ; 无返回值 
         Case $NM_DBLCLK ; 用户用鼠标左键双击一个项目时，由列表视图控件发送 
           $tInfo = DllStructCreate ( $tagNMITEMACTIVATE , $ilParam ) 
           memowrite ( "$NM_DBLCLK" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode & @LF ) 
           memowrite( "-->Index:" & @TAB & DllStructGetData ( $tInfo , "Index" ) & @LF ) 
           memowrite( "-->SubItem:" & @TAB & DllStructGetData ( $tInfo , "SubItem" ) & @LF ) 
           memowrite( "-->NewState:" & @TAB & DllStructGetData ( $tInfo , "NewState" ) & @LF ) 
           memowrite( "-->OldState:" & @TAB & DllStructGetData ( $tInfo , "OldState" ) & @LF ) 
           memowrite( "-->Changed:" & @TAB & DllStructGetData ( $tInfo , "Changed" ) & @LF ) 
           memowrite( "-->ActionX:" & @TAB & DllStructGetData ( $tInfo , "ActionX" ) & @LF ) 
           memowrite( "-->ActionY:" & @TAB & DllStructGetData ( $tInfo , "ActionY" ) & @LF ) 
           memowrite( "-->lParam:" & @TAB & DllStructGetData ( $tInfo , "lParam" ) & @LF ) 
           memowrite( "-->KeyFlags:" & @TAB & DllStructGetData ( $tInfo , "KeyFlags" )) 
           ; 无返回值 
         Case $NM_KILLFOCUS ; 控件失去输入焦点 
           memowrite ( "$NM_KILLFOCUS" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode ) 
           ; 无返回值 
         Case $NM_RCLICK ; 用户用鼠标右键单击一个项目时，由列表视图控件发送 
           $tInfo = DllStructCreate ( $tagNMITEMACTIVATE , $ilParam ) 
           memowrite ( "$NM_RCBLCLK" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode & @LF ) 
           memowrite( "-->Index:" & @TAB & DllStructGetData ( $tInfo , "Index" ) & @LF ) 
           memowrite( "-->SubItem:" & @TAB & DllStructGetData ( $tInfo , "SubItem" ) & @LF ) 
           memowrite( "-->NewState:" & @TAB & DllStructGetData ( $tInfo , "NewState" ) & @LF ) 
           memowrite( "-->OldState:" & @TAB & DllStructGetData ( $tInfo , "OldState" ) & @LF ) 
           memowrite( "-->Changed:" & @TAB & DllStructGetData ( $tInfo , "Changed" ) & @LF ) 
           memowrite( "-->ActionX:" & @TAB & DllStructGetData ( $tInfo , "ActionX" ) & @LF ) 
           memowrite( "-->ActionY:" & @TAB & DllStructGetData ( $tInfo , "ActionY" ) & @LF ) 
           memowrite( "-->lParam:" & @TAB & DllStructGetData ( $tInfo , "lParam" ) & @LF ) 
           memowrite( "-->KeyFlags:" & @TAB & DllStructGetData ( $tInfo , "KeyFlags" )) 
           ;Return 1 ; 不允许默认执行 
           Return 0 ; 允许默认执行 
         Case $NM_RDBLCLK ; 用户用鼠标右键双击一个项目时，由列表视图控件发送 
           $tInfo = DllStructCreate ( $tagNMITEMACTIVATE , $ilParam ) 
           memowrite ( "$NM_RDBLCLK" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode & @LF ) 
           memowrite( "-->Index:" & @TAB & DllStructGetData ( $tInfo , "Index" ) & @LF ) 
           memowrite( "-->SubItem:" & @TAB & DllStructGetData ( $tInfo , "SubItem" ) & @LF ) 
           memowrite( "-->NewState:" & @TAB & DllStructGetData ( $tInfo , "NewState" ) & @LF ) 
           memowrite( "-->OldState:" & @TAB & DllStructGetData ( $tInfo , "OldState" ) & @LF ) 
           memowrite( "-->Changed:" & @TAB & DllStructGetData ( $tInfo , "Changed" ) & @LF ) 
           memowrite( "-->ActionX:" & @TAB & DllStructGetData ( $tInfo , "ActionX" ) & @LF ) 
           memowrite( "-->ActionY:" & @TAB & DllStructGetData ( $tInfo , "ActionY" ) & @LF ) 
           memowrite( "-->lParam:" & @TAB & DllStructGetData ( $tInfo , "lParam" ) & @LF ) 
           memowrite( "-->KeyFlags:" & @TAB & DllStructGetData ( $tInfo , "KeyFlags" )) 
           ; 无返回值 
         Case $NM_RETURN ; 控件有输入焦点且用户点击了ENTER键 
           memowrite ( "$NM_RETURN" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode ) 
           ; 无返回值 
         Case $NM_SETFOCUS ; 控件接收输入焦点 
           memowrite ( "$NM_SETFOCUS" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode ) 
           ; 无返回值 
       EndSwitch 
   EndSwitch 
   Return $GUI_RUNDEFMSG 
 EndFunc    ;==>WM_NOTIFY 
 
 Func memowrite( $s_text ) 
   GUICtrlSetData ( $edit , $s_text & @CRLF , 1) 
 EndFunc    ;==>memowrite 
 
