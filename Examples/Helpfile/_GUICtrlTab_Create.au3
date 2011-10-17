 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GuiConstantsEx.au3> 
 #include <GuiTab.au3> 
 #include <WindowsConstants.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 $Debug_TAB = False ; 检查传递给函数的类名, 设置为真并使用另一控件句柄观察其工作 
 
 Global $hTab 
 
 _Main() 
 
 Func _Main() 
   Local $hGUI 
 
   ; 创建界面 
   $hGUI = GUICreate ( " (UDF Created) Tab Control Create " , 400 , 300 ) 
   $hTab = _GUICtrlTab_Create ( $hGUI , 2 , 2 , 396 , 296 ) 
   $iMemo = GUICtrlCreateEdit ( " " , 2 , 32 , 396 , 266 , BitOR ( $WS_VSCROLL , $ES_AUTOVSCROLL )) 
   GUISetState () 
 
   GUIRegisterMsg ( $WM_NOTIFY , " WM_NOTIFY " ) 
 
   ; 添加标签页 
   _GUICtrlTab_InsertItem ( $hTab , 0 , " Tab 1 " ) 
   _GUICtrlTab_InsertItem ( $hTab , 1 , " Tab 2 " ) 
   _GUICtrlTab_InsertItem ( $hTab , 2 , " Tab 3 " ) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc    ;==>_Main 
 
 Func WM_NOTIFY ( $hWnd , $iMsg , $iwParam , $ilParam ) 
   #forceref $hWnd, $iMsg, $iwParam 
   Local $hWndFrom , $iIDFrom , $iCode , $tNMHDR , $hWndTab 
   $hWndTab = $hTab 
   If Not IsHWnd ( $hTab ) Then $hWndTab = GUICtrlGetHandle ( $hTab ) 
 
   $tNMHDR = DllStructCreate ( $tagNMHDR , $ilParam ) 
   $hWndFrom = HWnd ( DllStructGetData ( $tNMHDR , " hWndFrom " )) 
   $iIDFrom = DllStructGetData ( $tNMHDR , " IDFrom " ) 
   $iCode = DllStructGetData ( $tNMHDR , " Code " ) 
   Switch $hWndFrom 
     Case $hWndTab 
       Switch $iCode 
         Case $NM_CLICK ; 在控件中点击鼠标左键 
           memowrite( " $NM_CLICK " ) 
           memowrite( " --> hWndFrom: " & @TAB & $hWndFrom ) 
           memowrite( " -->DFrom: " & @TAB & $iIDFrom ) 
           memowrite( " -->Code: " & @TAB & $iCode ) 
           ; 标签控件忽略返回值 
         Case $NM_DBLCLK ; 在控件中双击鼠标左键 
           memowrite( " $NM_DBLCLK " ) 
           memowrite( " --> hWndFrom: " & @TAB & $hWndFrom ) 
           memowrite( " -->DFrom: " & @TAB & $iIDFrom ) 
           memowrite( " -->Code: " & @TAB & $iCode ) 
 ;~          Return 1 ; 非0为不允许默认操作 
           Return 0 ; 0为允许默认操作 
         Case $NM_RCLICK ; 在控件中点击鼠标右键 
           memowrite( " $NM_RCLICK " ) 
           memowrite( " --> hWndFrom: " & @TAB & $hWndFrom ) 
           memowrite( " -->DFrom: " & @TAB & $iIDFrom ) 
           memowrite( " -->Code: " & @TAB & $iCode ) 
 ;~          Return 1 ; 非0为不允许默认操作 
           Return 0 ; 0为允许默认操作 
         Case $NM_RDBLCLK ; 在控件中双击鼠标右键 
           memowrite( " $NM_RDBLCLK " ) 
           memowrite( " --> hWndFrom: " & @TAB & $hWndFrom ) 
           memowrite( " -->DFrom: " & @TAB & $iIDFrom ) 
           memowrite( " -->Code: " & @TAB & $iCode ) 
 ;~          Return 1 ; 非0为不允许默认操作 
           Return 0 ; 0为允许默认操作 
         Case $NM_RELEASEDCAPTURE ; 控件释放鼠标捕捉 
           memowrite( " $NM_RELEASEDCAPTURE " ) 
           memowrite( " --> hWndFrom: " & @TAB & $hWndFrom ) 
           memowrite( " -->DFrom: " & @TAB & $iIDFrom ) 
           memowrite( " -->Code: " & @TAB & $iCode ) 
           ; 无返回值 
       EndSwitch 
   EndSwitch 
   Return $GUI_RUNDEFMSG 
 EndFunc ;==>WM_NOTIFY 
 
 Func memowrite( $s_text ) 
   GUICtrlSetData ( $iMemo , $s_text , 1 ) 
 EndFunc ;==>memowrite 
 
