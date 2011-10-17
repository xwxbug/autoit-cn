
 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GuiConstantsEx.au3> 
 #include <GuiTreeView.au3> 
 #include <GuiImageList.au3> 
 #include <WindowsConstants.au3> 
 #include <EditConstants.au3> 
 
 Opt ( 'MustDeclareVars' , 1 ) 
 
 $Debug_TV = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 
 
 Global $hTreeView , $edit 
 
 _Main () 
 
 Func _Main () 
 
   Local $hItem , $hImage , $iImage 
   Local $iStyle = BitOR ( $TVS_EDITLABELS , $TVS_HASBUTTONS , $TVS_HASLINES , $TVS_LINESATROOT , $TVS_DISABLEDRAGDROP , $TVS_SHOWSELALWAYS , $TVS_CHECKBOXES ) 
 
   GUICreate ( "TreeView Click Item" , 400 , 300 ) 
 
   $edit = GUICtrlCreateEdit ( "" , 201 , 2 , 199 , 296 , BitOR ( $WS_VSCROLL , $ES_AUTOVSCROLL )) 
   $hTreeView = GUICtrlCreateTreeView ( 2 , 2 , 197 , 296 , $iStyle , $WS_EX_CLIENTEDGE ) 
   GUISetState () 
 
   GUIRegisterMsg ( $WM_NOTIFY , "WM_NOTIFY" ) 
 
   $hImage = _GUIImageList_Create ( 16 , 16 , 5 , 3 ) 
   _GUIImageList_AddIcon ( $hImage , "shell32.dll" , 110 ) 
   _GUIImageList_AddIcon ( $hImage , "shell32.dll" , 131 ) 
   _GUIImageList_AddIcon ( $hImage , "shell32.dll" , 165 ) 
   _GUIImageList_AddIcon ( $hImage , "shell32.dll" , 168 ) 
   _GUIImageList_AddIcon ( $hImage , "shell32.dll" , 137 ) 
   _GUIImageList_AddIcon ( $hImage , "shell32.dll" , 146 ) 
   _GUICtrlTreeView_SetNormalImageList ( $hTreeView , $hImage ) 
 
   _GUICtrlTreeView_BeginUpdate ( $hTreeView ) 
   For $x = 1 To Random ( 2 , 10 , 1 ) 
     $iImage = Random ( 0 , 5 , 1 ) 
     $hItem = _GUICtrlTreeView_Add ( $hTreeView , 0 , StringFormat ( "[%02d] New Item" , $x ), $iImage , $iImage ) 
     For $y = 1 To Random ( 2 , 10 , 1 ) 
       $iImage = Random ( 0 , 5 , 1 ) 
       _GUICtrlTreeView_AddChild ( $hTreeView , $hItem , StringFormat ( "[%02d] New Child" , $y ), $iImage , $iImage ) 
     Next 
   Next 
   _GUICtrlTreeView_EndUpdate ( $hTreeView ) 
 
   _GUICtrlTreeView_ClickItem ( $hTreeView , $hItem , "left" , False , 2 ) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc    ;==>_Main 
 
 Func WM_NOTIFY ( $hWnd , $iMsg , $iwParam , $ilParam ) 
   #forceref $hWnd, $iMsg, $iwParam 
   Local $hWndFrom , $iIDFrom , $iCode , $tNMHDR , $hWndTreeview 
   $hWndTreeview = $hTreeView 
   If Not IsHWnd ( $hTreeView ) Then $hWndTreeview = GUICtrlGetHandle ( $hTreeView ) 
 
   $tNMHDR = DllStructCreate ( $tagNMHDR , $ilParam ) 
  $hWndFrom = HWnd ( DllStructGetData ( $tNMHDR , "hWndFrom" )) 
   $iIDFrom = DllStructGetData ( $tNMHDR , "IDFrom" ) 
   $iCode = DllStructGetData ( $tNMHDR , "Code" ) 
   Switch $hWndFrom 
     Case $hWndTreeview 
       Switch $iCode 
         Case $NM_CLICK ; 在控件内单击鼠标左键 
           memowrite ( "$NM_CLICK" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode ) 
           ; 无返回值 
 ;~          Return 1 ; 非0为不允许默认操作 
           Return 0 ; 0 为允许默认操作 
         Case $NM_DBLCLK ; 在控件内双击鼠标左键 
           memowrite ( "$NM_DBLCLK" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode ) 
 ;~          Return 1 ; 非0为不允许默认操作 
           Return 0 ; 0 为允许默认操作 
         Case $NM_RCLICK ; 在控件内点击鼠标右键 
           memowrite ( "$NM_RCLICK" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode ) 
 ;~          Return 1 ; 非0为不允许默认操作 
           Return 0 ; 0 为允许默认操作 
         Case $NM_RDBLCLK ; 在控件内双击鼠标右键 
           memowrite ( "$NM_RDBLCLK" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode ) 
 ;~          Return 1 ; 非0为不允许默认操作 
         Return 0 ; 0 为允许默认操作 
       EndSwitch 
   EndSwitch 
   Return $GUI_RUNDEFMSG 
EndFunc    ;==>WM_NOTIFY 
 
 Func memowrite( $s_text ) 
   GUICtrlSetData ( $edit , $s_text & @CRLF , 1) 
 EndFunc    ;==>memowrite 

