 #include <GuiToolbar.au3> 
 #include <GuiConstantsEx.au3> 
 #include <WindowsConstants.au3> 
 #include <Constants.au3> 
 
 Opt (' MustDeclareVars ', 1 ) 
 
 $Debug_TB = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 
 
 Global $hToolbar , $iMemo 
 Global $iItem ; 与通知相关的按钮的命令标识. 
 Global Enum $idNew = 1000 , $idOpen , $idSave , $idHelp 
 
 _Main() 
 
 Func _Main() 
   Local $hGUI , $aSize 
 
   ; 创建界面 
   $hGUI = GUICreate (" Toolbar ", 600 , 400 ) 
   $hToolbar = _GUICtrlToolbar_Create ( $hGUI ) 
   $aSize = _GUICtrlToolbar_GetMaxSize ( $hToolbar ) 
 
   $iMemo = GUICtrlCreateEdit ("", 2 , $aSize [ 1 ] + 20 , 596 , 396 - ( $aSize [ 1 ] + 20 ), $WS_VSCROLL ) 
   GUICtrlSetFont ( $iMemo , 9 , 400 , 0 , " Courier New ") 
   GUISetState () 
   GUIRegisterMsg ( $WM_NOTIFY , "_WM_NOTIFY" ) 
 
   ; 添加标准系统位图 
   _GUICtrlToolbar_AddBitmap ( $hToolbar , 1 , -1 , $IDB_STD_LARGE_COLOR ) 
 
   ; 添加按钮 
   _GUICtrlToolbar_AddButton ( $hToolbar , $idNew , $STD_FILENEW ) 
   _GUICtrlToolbar_AddButton ( $hToolbar , $idOpen , $STD_FILEOPEN ) 
   _GUICtrlToolbar_AddButton ( $hToolbar , $idSave , $STD_FILESAVE ) 
   _GUICtrlToolbar_AddButtonSep ( $hToolbar ) 
   _GUICtrlToolbar_AddButton ( $hToolbar , $idHelp , $STD_HELP ) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
 
 EndFunc ;==>_Main 
 
 ; 向memo控件写入信息 
 Func MemoWrite( $sMessage = "") 
   GUICtrlSetData ( $iMemo , $sMessage & @CRLF , 1 ) 
 EndFunc ;==>MemoWrite 
 
 ; WM_NOTIFY事件句柄 
 Func _WM_NOTIFY( $hWndGUI , $MsgID , $wParam , $lParam ) 
   #forceref $hWndGUI, $MsgID, $wParam 
   Local $tNMHDR , $event , $hwndFrom , $code , $i_idNew , $dwFlags , $lResult , $idFrom , $i_idOld 
   Local $tNMTOOLBAR , $tNMTBHOTITEM 
   $tNMHDR = DllStructCreate ( $tagNMHDR , $lParam ) 
   $hwndFrom = DllStructGetData ( $tNMHDR , " hWndFrom ") 
   $idFrom = DllStructGetData ( $tNMHDR , " IDFrom ") 
   $code = DllStructGetData ( $tNMHDR , " Code ") 
   Switch $hwndFrom 
     Case $hToolbar 
       Switch $code 
         Case $NM_LDOWN 
           ;--------------------------------------------------- 
           MemoWrite(" $NM_LDOWN: Clicked Item: " & $iItem & " at index: " & _GUICtrlToolbar_CommandToIndex ( $hToolbar , $iItem )) 
           ;--------------------------------------------------- 
         Case $TBN_HOTITEMCHANGE 
           $tNMTBHOTITEM = DllStructCreate ( $tagNMTBHOTITEM , $lParam ) 
           $i_idOld = DllStructGetData ( $tNMTBHOTITEM , "idOld" ) 
           $i_idNew = DllStructGetData ( $tNMTBHOTITEM , "idNew" ) 
           $iItem = $i_idNew 
           $dwFlags = DllStructGetData ( $tNMTBHOTITEM , " dwFlags ") 
           If BitAND ( $dwFlags , $HICF_LEAVING ) = $HICF_LEAVING Then 
             MemoWrite(" $HICF_LEAVING: " & $i_idOld ) 
           Else 
             Switch $i_idNew 
               Case $idNew 
                 ;--------------------------------------------------- 
                 MemoWrite(" $TBN_HOTITEMCHANGE: $idNew ") 
                 ;--------------------------------------------------- 
               Case $idOpen 
                 ;--------------------------------------------------- 
                 MemoWrite(" $TBN_HOTITEMCHANGE: $idOpen ") 
                 ;--------------------------------------------------- 
               Case $idSave 
                 ;--------------------------------------------------- 
                 MemoWrite(" $TBN_HOTITEMCHANGE: $idSave ") 
                 ;--------------------------------------------------- 
               Case $idHelp 
                 ;--------------------------------------------------- 
                 MemoWrite(" $TBN_HOTITEMCHANGE: $idHelp ") 
                 ;--------------------------------------------------- 
             EndSwitch 
           EndIf 
       EndSwitch 
   EndSwitch 
   Return $GUI_RUNDEFMSG 
 EndFunc ;==>_WM_NOTIFY 
 
