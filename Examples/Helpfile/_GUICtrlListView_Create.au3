 
 #AutoIt3Wrapper_au3check_parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GuiConstantsEx.au3> 
 #include <GuiListView.au3> 
 #include <GuiImageList.au3> 
 #include <WindowsConstants.au3> 
 #include <EditConstants.au3> 
 
 Opt ( 'MustDeclareVars' , 1 ) 
 
 $Debug_LV = False ; 检查传递给函数的类名, 设置为真并使用另一控件句柄观察其工作 
 
 Global $hListView , $edit 
 
 _Main () 
 
 Func _Main () 
 
   Local $GUI , $hImage 
   $GUI = GUICreate ( "(UDF Created) ListView Create" , 400 , 540 ) 
 
   $edit = GUICtrlCreateEdit ( "" , 2 , 277 , 394 , 258 , BitOR ( $WS_VSCROLL , $ES_AUTOVSCROLL )) 
   $hListView = _GUICtrlListView_Create ( $GUI , "" , 2 , 2 , 394 , 268 ) 
   _GUICtrlListView_SetExtendedListViewStyle ( $hListView , BitOR ( $LVS_EX_GRIDLINES , $LVS_EX_FULLROWSELECT , $LVS_EX_SUBITEMIMAGES )) 
   GUISetState () 
   
   GUIRegisterMsg ( $WM_NOTIFY , "WM_NOTIFY" ) 
 
   ; 加载图像 
   $hImage = _GUIImageList_Create () 
   _GUIImageList_Add ( $hImage , _GUICtrlListView_CreateSolidBitMap ( $hListView , 0xFF0000 , 16 , 16 )) 
   _GUIImageList_Add ( $hImage , _GUICtrlListView_CreateSolidBitMap ( $hListView , 0x00FF00 , 16 , 16 )) 
   _GUIImageList_Add ( $hImage , _GUICtrlListView_CreateSolidBitMap ( $hListView , 0x0000FF , 16 , 16 )) 
   _GUICtrlListView_SetImageList ( $hListView , $hImage , 1 ) 
 
   ; 添加列 
   _GUICtrlListView_InsertColumn ( $hListView , 0 , "Column 1" , 100 ) 
   _GUICtrlListView_InsertColumn ( $hListView , 1 , "Column 2" , 100 ) 
   _GUICtrlListView_InsertColumn ( $hListView , 2 , "Column 3" , 100 ) 
 
   ; 添加项 
   _GUICtrlListView_AddItem ( $hListView , "Row 1: Col 1" , 0 ) 
   _GUICtrlListView_AddSubItem ( $hListView , 0 , "Row 1: Col 2" , 1 ) 
   _GUICtrlListView_AddSubItem ( $hListView , 0 , "Row 1: Col 3" , 2 ) 
   _GUICtrlListView_AddItem ( $hListView , "Row 2: Col 1" , 1 ) 
   _GUICtrlListView_AddSubItem ( $hListView , 1 , "Row 2: Col 2" , 1 ) 
   _GUICtrlListView_AddItem ( $hListView , "Row 3: Col 1" , 2 ) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc    ;==>_Main 
 
 Func WM_NOTIFY ( $hWnd , $iMsg , $iwParam , $ilParam ) 
   #forceref $hWnd, $iMsg, $iwParam 
   Local $hWndFrom , $iIDFrom , $iCode , $tNMHDR , $hWndListView , $tInfo 
 ;~Local $tBuffer 
   $hWndListView = $hListView 
   If Not IsHWnd ( $hListView ) Then $hWndListView = GUICtrlGetHandle ( $hListView ) 
 
   $tNMHDR = DllStructCreate ( $tagNMHDR , $ilParam ) 
   $hWndFrom = HWnd ( DllStructGetData ( $tNMHDR , "hWndFrom" )) 
   $iIDFrom = DllStructGetData ( $tNMHDR , "IDFrom" ) 
   $iCode = DllStructGetData ( $tNMHDR , "Code" ) 
   Switch $hWndFrom 
     Case $hWndListView 
       Switch $iCode 
 ;~      Case $LVN_BEGINDRAG ; 初始化鼠标左键的拖曳操作 
 ;~        $tInfo = DllStructCreate($tagNMLISTVIEW, $ilParam) 
 ;~        memowrite("$LVN_BEGINDRAG" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF) 
 ;~        memowrite("IDFrom:" & @TAB & $iIDFrom & @LF) 
 ;~        memowrite("Code:" & @TAB & $iCode & @LF) 
 ;~        memowrite("Item:" & @TAB & DllStructGetData($tInfo, "Item") & @LF) 
 ;~        memowrite("SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF) 
 ;~        memowrite("NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF) 
 ;~        memowrite("OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF) 
 ;~        memowrite("Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF) 
 ;~        memowrite("ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF) 
 ;~        memowrite("ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF) 
 ;~        memowrite("Param:" & @TAB & DllStructGetData($tInfo, "Param")) 
 ;~        ; 无返回值 
 ;~      Case $LVN_BEGINLABELEDIT ; 开始编辑项目标签 
 ;~        $tInfo = DllStructCreate($tagNMLVDISPINFO, $ilParam) 
 ;~        memowrite("$LVN_BEGINLABELEDIT" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF) 
 ;~        memowrite("IDFrom:" & @TAB & $iIDFrom & @LF) 
 ;~        memowrite("Code:" & @TAB & $iCode & @LF) 
 ;~        memowrite("Mask:" & @TAB & DllStructGetData($tInfo, "Mask") & @LF) 
 ;~        memowrite("Item:" & @TAB & DllStructGetData($tInfo, "Item") & @LF) 
 ;~        memowrite("SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF) 
 ;~        memowrite("State:" & @TAB & DllStructGetData($tInfo, "State") & @LF) 
 ;~        memowrite("StateMask:" & @TAB & DllStructGetData($tInfo, "StateMask") & @LF) 
 ;~        memowrite("Image:" & @TAB & DllStructGetData($tInfo, "Image") & @LF) 
 ;~        memowrite("Param:" & @TAB & DllStructGetData($tInfo, "Param") & @LF) 
 ;~        memowrite("Indent:" & @TAB & DllStructGetData($tInfo, "Indent") & @LF) 
 ;~        memowrite("GroupID:" & @TAB & DllStructGetData($tInfo, "GroupID") & @LF) 
 ;~        memowrite("Columns:" & @TAB & DllStructGetData($tInfo, "Columns") & @LF) 
 ;~        memowrite("pColumns:" & @TAB & DllStructGetData($tInfo, "pColumns")) 
 ;~        Return False ; 允许编辑标签 
 ;~        ;Return True  ; 进制编辑标签 
 ;~      Case $LVN_BEGINRDRAG ; 初始化鼠标右键的拖曳操作 
 ;~        $tInfo = DllStructCreate($tagNMLISTVIEW, $ilParam) 
 ;~        memowrite("$LVN_BEGINRDRAG" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF) 
 ;~        memowrite("IDFrom:" & @TAB & $iIDFrom & @LF) 
 ;~        memowrite("Code:" & @TAB & $iCode & @LF) 
 ;~        memowrite("Item:" & @TAB & DllStructGetData($tInfo, "Item") & @LF) 
 ;~        memowrite("SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF) 
 ;~        memowrite("NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF) 
 ;~        memowrite("OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF) 
 ;~        memowrite("Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF) 
 ;~        memowrite("ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF) 
 ;~        memowrite("ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF) 
 ;~        memowrite("Param:" & @TAB & DllStructGetData($tInfo, "Param")) 
 ;~        ; 无返回值 
 ;~      Case $LVN_BEGINSCROLL ; 开始滚动操作, 最小系统WinXP 
 ;~        $tInfo = DllStructCreate($tagNMLVSCROLL, $ilParam) 
 ;~        memowrite("$LVN_BEGINSCROLL" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF) 
 ;~        memowrite("IDFrom:" & @TAB & $iIDFrom & @LF) 
 ;~        memowrite("Code:" & @TAB & $iCode & @LF) 
 ;~        memowrite("DX:" & @TAB & DllStructGetData($tInfo, "DX") & @LF) 
 ;~        memowrite("DY:" & @TAB & DllStructGetData($tInfo, "DY")) 
 ;~        ; 无返回值 
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
 ;~      Case $LVN_DELETEALLITEMS ; 将删除控件中所有项 
 ;~        $tInfo = DllStructCreate($tagNMLISTVIEW, $ilParam) 
 ;~        memowrite("$LVN_DELETEALLITEMS" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF) 
 ;~        memowrite("IDFrom:" & @TAB & $iIDFrom & @LF) 
 ;~        memowrite("Code:" & @TAB & $iCode & @LF) 
 ;~        memowrite("Item:" & @TAB & DllStructGetData($tInfo, "Item") & @LF) 
 ;~        memowrite("SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF) 
 ;~        memowrite("NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF) 
 ;~        memowrite("OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF) 
 ;~        memowrite("Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF) 
 ;~        memowrite("ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF) 
 ;~        memowrite("ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF) 
 ;~        memowrite("Param:" & @TAB & DllStructGetData($tInfo, "Param")) 
 ;~        Return True ; To suppress subsequent $LVN_DELETEITEM messages 
 ;~        ;Return False ; To receive subsequent $LVN_DELETEITEM messages 
 ;~      Case $LVN_DELETEITEM ; 将删除一项 
 ;~        $tInfo = DllStructCreate($tagNMLISTVIEW, $ilParam) 
 ;~        memowrite("$LVN_DELETEITEM" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF) 
 ;~        memowrite("IDFrom:" & @TAB & $iIDFrom & @LF) 
 ;~        memowrite("Code:" & @TAB & $iCode & @LF) 
 ;~        memowrite("Item:" & @TAB & DllStructGetData($tInfo, "Item") & @LF) 
 ;~        memowrite("SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF) 
 ;~        memowrite("NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF) 
 ;~        memowrite("OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF) 
 ;~        memowrite("Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF) 
 ;~        memowrite("ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF) 
 ;~        memowrite("ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF) 
 ;~        memowrite("Param:" & @TAB & DllStructGetData($tInfo, "Param")) 
 ;~        ; 无返回值 
 ;~      Case $LVN_ENDLABELEDIT ; 项目标签编辑结束 
 ;~        $tInfo = DllStructCreate($tagNMLVDISPINFO, $ilParam) 
 ;~        $tBuffer = DllStructCreate("char Text[" & DllStructGetData($tInfo, "TextMax") & "]", DllStructGetData($tInfo, "Text")) 
 ;~        memowrite("$LVN_ENDLABELEDIT" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF) 
 ;~        memowrite("IDFrom:" & @TAB & $iIDFrom & @LF) 
 ;~        memowrite("Code:" & @TAB & $iCode & @LF) 
 ;~        memowrite("Mask:" & @TAB & DllStructGetData($tInfo, "Mask") & @LF) 
 ;~        memowrite("Item:" & @TAB & DllStructGetData($tInfo, "Item") & @LF) 
 ;~        memowrite("SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF) 
 ;~        memowrite("State:" & @TAB & DllStructGetData($tInfo, "State") & @LF) 
 ;~        memowrite("StateMask:" & @TAB & DllStructGetData($tInfo, "StateMask") & @LF) 
 ;~        memowrite("Text:" & @TAB & DllStructGetData($tBuffer, "Text") & @LF) 
 ;~        memowrite("TextMax:" & @TAB & DllStructGetData($tInfo, "TextMax") & @LF) 
 ;~        memowrite("Image:" & @TAB & DllStructGetData($tInfo, "Image") & @LF) 
 ;~        memowrite("Param:" & @TAB & DllStructGetData($tInfo, "Param") & @LF) 
 ;~        memowrite("Indent:" & @TAB & DllStructGetData($tInfo, "Indent") & @LF) 
 ;~        memowrite("GroupID:" & @TAB & DllStructGetData($tInfo, "GroupID") & @LF) 
 ;~        memowrite("Columns:" & @TAB & DllStructGetData($tInfo, "Columns") & @LF) 
 ;~        memowrite("pColumns:" & @TAB & DllStructGetData($tInfo, "pColumns")) 
 ;~        ; 如果文本非空, 返回真以设置项目标签为编辑的文本, 返回假拒绝 
 ;~        ; 如果文本为空忽略返回值 
 ;~        Return True 
 ;~      Case $LVN_ENDSCROLL ; 结束滚动操作, 最小系统WinXP 
 ;~        $tInfo = DllStructCreate($tagNMLVSCROLL, $ilParam) 
 ;~        memowrite("$LVN_ENDSCROLL" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF) 
 ;~        memowrite("IDFrom:" & @TAB & $iIDFrom & @LF) 
 ;~        memowrite("Code:" & @TAB & $iCode & @LF) 
 ;~        memowrite("DX:" & @TAB & DllStructGetData($tInfo, "DX") & @LF) 
 ;~        memowrite("DY:" & @TAB & DllStructGetData($tInfo, "DY")) 
 ;~        ; 无返回值 
 ;~      Case $LVN_GETDISPINFO ; 提供显示或排序列表项目的必要信息 
 ;~        $tInfo = DllStructCreate($tagNMLVDISPINFO, $ilParam) 
 ;~        $tBuffer = DllStructCreate("char Text[" & DllStructGetData($tInfo, "TextMax") & "]", DllStructGetData($tInfo, "Text")) 
 ;~        memowrite("$LVN_GETDISPINFO" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF) 
 ;~        memowrite("IDFrom:" & @TAB & $iIDFrom & @LF) 
 ;~        memowrite("Code:" & @TAB & $iCode & @LF) 
 ;~        memowrite("Mask:" & @TAB & DllStructGetData($tInfo, "Mask") & @LF) 
 ;~        memowrite("Item:" & @TAB & DllStructGetData($tInfo, "Item") & @LF) 
 ;~        memowrite("SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF) 
 ;~        memowrite("State:" & @TAB & DllStructGetData($tInfo, "State") & @LF) 
 ;~        memowrite("StateMask:" & @TAB & DllStructGetData($tInfo, "StateMask") & @LF) 
 ;~        memowrite("Text:" & @TAB & DllStructGetData($tBuffer, "Text") & @LF) 
 ;~        memowrite("TextMax:" & @TAB & DllStructGetData($tInfo, "TextMax") & @LF) 
 ;~        memowrite("Image:" & @TAB & DllStructGetData($tInfo, "Image") & @LF) 
 ;~        memowrite("Param:" & @TAB & DllStructGetData($tInfo, "Param") & @LF) 
 ;~        memowrite("Indent:" & @TAB & DllStructGetData($tInfo, "Indent") & @LF) 
 ;~        memowrite("GroupID:" & @TAB & DllStructGetData($tInfo, "GroupID") & @LF) 
 ;~        memowrite("Columns:" & @TAB & DllStructGetData($tInfo, "Columns") & @LF) 
 ;~        memowrite("pColumns:" & @TAB & DllStructGetData($tInfo, "pColumns")) 
 ;~        ; 无返回值 
 ;~      Case $LVN_GETINFOTIP ; 由$LVS_EX_INFOTIP样式的大图标列表视图发送 
 ;~        $tInfo = DllStructCreate($tagNMLVGETINFOTIP, $ilParam) 
 ;~        $tBuffer = DllStructCreate("char Text[" & DllStructGetData($tInfo, "TextMax") & "]", DllStructGetData($tInfo, "Text")) 
 ;~        memowrite("$LVN_GETINFOTIP" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF) 
 ;~        memowrite("IDFrom:" & @TAB & $iIDFrom & @LF) 
 ;~        memowrite("Code:" & @TAB & $iCode & @LF) 
 ;~        memowrite("Flags:" & @TAB & DllStructGetData($tInfo, "Flags") & @LF) 
 ;~        memowrite("Text:" & @TAB & DllStructGetData($tBuffer, "Text") & @LF) 
 ;~        memowrite("TextMax:" & @TAB & DllStructGetData($tInfo, "TextMax") & @LF) 
 ;~        memowrite("Item:" & @TAB & DllStructGetData($tInfo, "Item") & @LF) 
 ;~        memowrite("SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF) 
 ;~        memowrite("lParam:" & @TAB & DllStructGetData($tInfo, "lParam")) 
 ;~        ; 无返回值 
 ;~      Case $LVN_HOTTRACK ; 用户将鼠标移至一项上时由列表视图控件发送 
 ;~        $tInfo = DllStructCreate($tagNMLISTVIEW, $ilParam) 
 ;~        memowrite("$LVN_HOTTRACK" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF) 
 ;~        memowrite("IDFrom:" & @TAB & $iIDFrom & @LF) 
 ;~        memowrite("Code:" & @TAB & $iCode & @LF) 
 ;~        memowrite("Item:" & @TAB & DllStructGetData($tInfo, "Item") & @LF) 
 ;~        memowrite("SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF) 
 ;~        memowrite("NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF) 
 ;~        memowrite("OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF) 
 ;~        memowrite("Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF) 
 ;~        memowrite("ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF) 
 ;~        memowrite("ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF) 
 ;~        memowrite("Param:" & @TAB & DllStructGetData($tInfo, "Param")) 
 ;~        Return 0 ; 允许列表视图执行简单的跟踪选定进程. 
 ;~        ;Return 1 ; 项目不被选定. 
 ;~      Case $LVN_INSERTITEM ; 插入新项目 
 ;~        $tInfo = DllStructCreate($tagNMLISTVIEW, $ilParam) 
 ;~        memowrite("$LVN_INSERTITEM" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF) 
 ;~        memowrite("IDFrom:" & @TAB & $iIDFrom & @LF) 
 ;~        memowrite("Code:" & @TAB & $iCode & @LF) 
 ;~        memowrite("Item:" & @TAB & DllStructGetData($tInfo, "Item") & @LF) 
 ;~        memowrite("SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF) 
 ;~        memowrite("NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF) 
 ;~        memowrite("OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF) 
 ;~        memowrite("Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF) 
 ;~        memowrite("ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF) 
 ;~        memowrite("ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF) 
 ;~        memowrite("Param:" & @TAB & DllStructGetData($tInfo, "Param")) 
 ;~        ; 无返回值 
 ;~      Case $LVN_ITEMACTIVATE ; 激活一项时由列表视图控件发送 
 ;~        $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam) 
 ;~        memowrite("$LVN_ITEMACTIVATE" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF) 
 ;~        memowrite("IDFrom:" & @TAB & $iIDFrom & @LF) 
 ;~        memowrite("Code:" & @TAB & $iCode & @LF) 
 ;~        memowrite("Index:" & @TAB & DllStructGetData($tInfo, "Index") & @LF) 
 ;~        memowrite("SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF) 
 ;~        memowrite("NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF) 
 ;~        memowrite("OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF) 
 ;~        memowrite("Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF) 
 ;~        memowrite("ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF) 
 ;~        memowrite("ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF) 
 ;~        memowrite("lParam:" & @TAB & DllStructGetData($tInfo, "lParam") & @LF) 
 ;~        memowrite("KeyFlags:" & @TAB & DllStructGetData($tInfo, "KeyFlags")) 
 ;~        Return 0 
 ;~      Case $LVN_ITEMCHANGED ; 已改变一项 
 ;~        $tInfo = DllStructCreate($tagNMLISTVIEW, $ilParam) 
 ;~        memowrite("$LVN_ITEMCHANGED" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF) 
 ;~        memowrite("IDFrom:" & @TAB & $iIDFrom & @LF) 
 ;~        memowrite("Code:" & @TAB & $iCode & @LF) 
 ;~        memowrite("Item:" & @TAB & DllStructGetData($tInfo, "Item") & @LF) 
 ;~        memowrite("SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF) 
 ;~        memowrite("NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF) 
 ;~        memowrite("OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF) 
 ;~        memowrite("Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF) 
 ;~        memowrite("ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF) 
 ;~        memowrite("ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF) 
 ;~        memowrite("Param:" & @TAB & DllStructGetData($tInfo, "Param")) 
 ;~        ; 无返回值 
 ;~      Case $LVN_ITEMCHANGING ; 已改变一项 
 ;~        $tInfo = DllStructCreate($tagNMLISTVIEW, $ilParam) 
 ;~        memowrite("$LVN_ITEMCHANGING" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF) 
 ;~        memowrite("IDFrom:" & @TAB & $iIDFrom & @LF) 
 ;~        memowrite("Code:" & @TAB & $iCode & @LF) 
 ;~        memowrite("Item:" & @TAB & DllStructGetData($tInfo, "Item") & @LF) 
 ;~        memowrite("SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF) 
 ;~        memowrite("NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF) 
 ;~        memowrite("OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF) 
 ;~        memowrite("Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF) 
 ;~        memowrite("ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF) 
 ;~        memowrite("ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF) 
 ;~        memowrite("Param:" & @TAB & DllStructGetData($tInfo, "Param")) 
 ;~        Return True ; 阻止改变 
 ;~        ;Return False ; 允许改变 
         Case $LVN_KEYDOWN ; 已按下一键 
           $tInfo = DllStructCreate ( $tagNMLVKEYDOWN , $ilParam ) 
           memowrite ( "$LVN_KEYDOWN" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode & @LF ) 
           memowrite( "-->VKey:" & @TAB & DllStructGetData ( $tInfo , "VKey" ) & @LF ) 
           memowrite( "-->Flags:" & @TAB & DllStructGetData ( $tInfo , "Flags" )) 
           ; 无返回值 
 ;~      Case $LVN_MARQUEEBEGIN ; 已开始绑定矩形选取 
 ;~        memowrite("$LVN_MARQUEEBEGIN" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF) 
 ;~        memowrite("IDFrom:" & @TAB & $iIDFrom & @LF) 
 ;~        memowrite("Code:" & @TAB & $iCode) 
 ;~        Return 0 ; 接收信息 
 ;~        ;Return 1 ; 退出绑定选取 
 ;~      Case $LVN_SETDISPINFO ; 更新维持项目的信息 
 ;~        $tInfo = DllStructCreate($tagNMLVDISPINFO, $ilParam) 
 ;~        $tBuffer = DllStructCreate("char Text[" & DllStructGetData($tInfo, "TextMax") & "]", DllStructGetData($tInfo, "Text")) 
 ;~        memowrite("$LVN_SETDISPINFO" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF) 
 ;~        memowrite("IDFrom:" & @TAB & $iIDFrom & @LF) 
 ;~        memowrite("Code:" & @TAB & $iCode & @LF) 
 ;~        memowrite("Mask:" & @TAB & DllStructGetData($tInfo, "Mask") & @LF) 
 ;~        memowrite("Item:" & @TAB & DllStructGetData($tInfo, "Item") & @LF) 
 ;~        memowrite("SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF) 
 ;~        memowrite("State:" & @TAB & DllStructGetData($tInfo, "State") & @LF) 
 ;~        memowrite("StateMask:" & @TAB & DllStructGetData($tInfo, "StateMask") & @LF) 
 ;~        memowrite("Text:" & @TAB & DllStructGetData($tBuffer, "Text") & @LF) 
 ;~        memowrite("TextMax:" & @TAB & DllStructGetData($tInfo, "TextMax") & @LF) 
 ;~        memowrite("Image:" & @TAB & DllStructGetData($tInfo, "Image") & @LF) 
 ;~        memowrite("Param:" & @TAB & DllStructGetData($tInfo, "Param") & @LF) 
 ;~        memowrite("Indent:" & @TAB & DllStructGetData($tInfo, "Indent") & @LF) 
 ;~        memowrite("GroupID:" & @TAB & DllStructGetData($tInfo, "GroupID") & @LF) 
 ;~        memowrite("Columns:" & @TAB & DllStructGetData($tInfo, "Columns") & @LF) 
 ;~        memowrite("pColumns:" & @TAB & DllStructGetData($tInfo, "pColumns")) 
 ;~        ; 无返回值 
         Case $NM_CLICK ; 鼠标左键点击项目时由控件发送 
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
         Case $NM_DBLCLK ; 鼠标左键双击项目时由控件发送 
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
 ;~      Case $NM_HOVER ; 鼠标置于项目上时由控件发送 
 ;~        memowrite("$NM_HOVER" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF) 
 ;~        memowrite("IDFrom:" & @TAB & $iIDFrom & @LF) 
 ;~        memowrite("Code:" & @TAB & $iCode) 
 ;~        Return 0 ; 简单击热 
 ;~        ;Return 1 ; 阻止热项操作 
         Case $NM_KILLFOCUS ; 控件失去输入焦点 
           memowrite ( "$NM_KILLFOCUS" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode ) 
           ; 无返回值 
         Case $NM_RCLICK ; 鼠标右键点击项目时由控件发送 
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
           ;Return 1 ; 不允许默认操作 
           Return 0 ; 允许默认操作 
         Case $NM_RDBLCLK ; 鼠标右键双击项目时由控件发送 
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
         Case $NM_RETURN ; 控件具有输入焦点且用户已按下ENTER键 
           memowrite ( "$NM_RETURN" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode ) 
           ; 无返回值 
         Case $NM_SETFOCUS ; 控件已收到输入焦点 
           memowrite ( "$NM_SETFOCUS" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode ) 
           ; 无返回值 
       EndSwitch 
   EndSwitch 
   Return $GUI_RUNDEFMSG 
 EndFunc    ;==>WM_NOTIFY 
 
 Func memowrite ( $s_text ) 
   GUICtrlSetData ( $edit , $s_text & @CRLF , 1) 
 EndFunc    ;==>memowrite 
 
