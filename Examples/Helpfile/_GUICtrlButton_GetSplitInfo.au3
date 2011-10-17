143
   _GUICtrlButton_GetSplitInfo   MustDeclareVars " , 1 ) 
 
 Global $btn , $iMemo , $btn2 
 
 ; 注意这些按钮的控件ID不能被GuiCtrlRead读取 
 
 _Main () 
 
 Func _Main () 
   Local $hGUI , $aInfo 
 
   $hGUI = GUICreate ( " Buttons " , 400 , 400 ) 
   $iMemo = GUICtrlCreateEdit ( " " , 10 , 100 , 390 , 284 , $WS_VSCROLL ) 
   GUICtrlSetFont ( $iMemo , 9 , 400 , 0 , " Courier New " ) 
 
   $btn = _GUICtrlButton_Create ( $hGUI , " Split Button " , 10 , 10 , 120 , 30 , $BS_SPLITBUTTON ) 
   _GUICtrlButton_SetSplitInfo ( $btn ) 
   $btn2 = _GUICtrlButton_Create ( $hGUI , " Split Button 2 " , 10 , 50 , 120 , 30 , $BS_SPLITBUTTON ) 
 
   GUIRegisterMsg ( $WM_COMMAND , " WM_COMMAND " ) 
   GUIRegisterMsg ( $WM_NOTIFY , " WM_NOTIFY " ) 
 
   GUISetState () 
 
   $aInfo = _GUICtrlButton_GetSplitInfo ( $btn ) 
   MemoWrite ( " Split Info " & @LF & " ---------------- " ) 
   For $x = 0 To 3 
     MemoWrite ( " $ainfo[ " & $x & " ] = " & $aInfo [ $x ]) 
   Next 
   MemoWrite ( " Split Info " & @LF & " ---------------- " ) 
 
   While 1 
     Switch GUIGetMsg () 
       Case $GUI_EVENT_CLOSE 
         ExitLoop 
     EndSwitch 
   WEnd 
 
   Exit 
 
 EndFunc ;==>_Main 
 
 ; 向编辑框写入信息： 
 Func MemoWrite ( $sMessage ) 
   GUICtrlSetData ( $iMemo , $sMessage & @CRLF , 1 ) 
 EndFunc ;==>MemoWrite 
 
 Func WM_NOTIFY ( $hWnd , $Msg , $wParam , $lParam ) 
   #forceref $hWnd , $Msg , $wParam 
   Local Const $BCN_HOTITEMCHANGE = -1249 
   Local $tNMBHOTITEM = DllStructCreate ( " hwnd hWndFrom;int IDFrom;int Code;dword dwFlags " , $lParam ) 
   Local $nNotifyCode = DllStructGetData ( $tNMBHOTITEM , " Code " ) 
   Local $nID = DllStructGetData ( $tNMBHOTITEM , " IDFrom " ) 
   Local $hCtrl = DllStructGetData ( $tNMBHOTITEM , " hWndFrom " ) 
   Local $dwFlags = DllStructGetData ( $tNMBHOTITEM , " dwFlags " ) 
   Local $sText = "" 
   
   Switch $nNotifyCode 
     Case $BCN_HOTITEMCHANGE ; Win XP and Above 
       If BitAND ( $dwFlags , 0x10 ) = 0x10 Then 
         $sText = " $BCN_HOTITEMCHANGE - Entering: " & @CRLF 
       ElseIf BitAND ( $dwFlags , 0x20 ) = 0x20 Then 
         $sText = " $BCN_HOTITEMCHANGE - Leaving: " & @CRLF 
       EndIf 
       MemoWrite ( $sText & _ 
           " ----------------------------- " & @CRLF & _ 
           " WM_NOTIFY - Infos: " & @CRLF & _ 
           " ----------------------------- " & @CRLF & _ 
           " Code " & @TAB & " : " & $nNotifyCode & @CRLF & _ 
           " CtrlID " & @TAB & " : " & $nID & @CRLF & _ 
           " CtrlHWnd: " & $hCtrl & @CRLF & _ 
           _GUICtrlButton_GetText ( $hCtrl ) & @CRLF ) 
     Case $BCN_DROPDOWN 
       MemoWrite( " $BCN_DROPDOWN " ) 
       _Popup_Menu( $hCtrl ) 
   EndSwitch 
   Return $GUI_RUNDEFMSG 
 EndFunc ;==>WM_NOTIFY 
 
 Func _Popup_Menu ( $hCtrl ) 
   Local $hMenu 
   Local Enum $idOpen = 1000 , $idSave , $idInfo 
   $hMenu = _GUICtrlMenu_CreatePopup () 
   _GUICtrlMenu_InsertMenuItem ( $hMenu , 0 , " Open " , $idOpen ) 
   _GUICtrlMenu_InsertMenuItem ( $hMenu , 1 , " Save " , $idSave ) 
   _GUICtrlMenu_InsertMenuItem ( $hMenu , 3 , "", 0 ) 
   _GUICtrlMenu_InsertMenuItem ( $hMenu , 3 , " Info " , $idInfo ) 
   Switch _GUICtrlMenu_TrackPopupMenu ( $hMenu , $hCtrl , -1 , - 1 , 1 , 1 , 2 ) 
     Case $idOpen 
       MemoWrite( " Open - Selected " ) 
     Case $idSave 
       MemoWrite( " Save - Selected " ) 
     Case $idInfo 
       MemoWrite( " Info - Selected " ) 
   EndSwitch 
   _GUICtrlMenu_DestroyMenu ( $hMenu ) 
 EndFunc ;==>_Popup_Menu 
 
 ; 处理点击动作，并向编辑框写入信息 
 Func WM_COMMAND( $hWnd , $Msg , $wParam , $lParam ) 
   #forceref $hWnd, $Msg 
   Local $nNotifyCode = BitShift ( $wParam , 16 ) 
   Local $nID = BitAND ( $wParam , 0x0000FFFF ) 
   Local $hCtrl = $lParam 
   Local $sText = " " 
 
   Switch $hCtrl 
     Case $btn , $btn2 
       Switch $nNotifyCode 
         Case $BN_CLICKED 
           $sText = " $BN_CLICKED " & @CRLF 
         Case $BN_PAINT 
           $sText = " $BN_PAINT " & @CRLF 
         Case $BN_PUSHED , $BN_HILITE 
           $sText = " $BN_PUSHED , $BN_HILITE " & @CRLF 
         Case $BN_UNPUSHED , $BN_UNHILITE 
           $sText = " $BN_UNPUSHED " & @CRLF 
         Case $BN_DISABLE 
           $sText = " $BN_DISABLE " & @CRLF 
         Case $BN_DBLCLK , $BN_DOUBLECLICKED 
           $sText = " 双击 " & @CRLF 
         Case $BN_SETFOCUS 
           $sText = " $BN_SETFOCUS " & @CRLF 
         Case $BN_KILLFOCUS 
           $sText = " $BN_KILLFOCUS " & @CRLF 
       EndSwitch 
       MemoWrite( $sText & _ 
           " ----------------------------- " & @CRLF & _ 
           " WM_COMMAND - Infos: " & @CRLF & _ 
           " ----------------------------- " & @CRLF & _ 
           " Code " & @TAB & " : " & $nNotifyCode & @CRLF & _ 
           " CtrlID " & @TAB & " : " & $nID & @CRLF & _ 
           " CtrlHWnd: " & $hCtrl & @CRLF & _ 
           _GUICtrlButton_GetText ( $hCtrl ) & @CRLF ) 
       Return 0 ; Only workout clicking on the button 
   EndSwitch 
   ; 执行默认的Autoit3内部消息命令. 你完全可以将所需行拆分出来. 
   ; !!! 但是不带任何值的'Return'将不会在后续操作中执行默认的Autoit3消息 !!! 
   Return $GUI_RUNDEFMSG 
 EndFunc ;==>WM_COMMAND 
 
