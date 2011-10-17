 #include <ClipBoard.au3> 
 #include <GuiConstantsEx.au3> 
 #include <WindowsConstants.au3> 
 #include <SendMessage.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 Global $iMemo , $hNext = 0 
 
 _Main() 
 
 Func _Main() 
   Local $hGUI 
 
   ; 创建界面 
   $hGUI = GUICreate ( " Clipboard ", 600 , 400 ) 
   $iMemo = GUICtrlCreateEdit ( "", 2 , 2 , 596 , 396 , $WS_VSCROLL ) 
   GUICtrlSetFont ( $iMemo , 9 , 400 , 0 , " Courier New " ) 
   GUISetState () 
 
   ; 初始化剪贴板浏览器 
   $hNext = _ClipBoard_SetViewer ( $hGUI ) 
 
   GUIRegisterMsg ( $WM_CHANGECBCHAIN , " WM_CHANGECBCHAIN " ) 
   GUIRegisterMsg ( $WM_DRAWCLIPBOARD , " WM_DRAWCLIPBOARD " ) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
 
   ; 关闭剪贴板浏览器 
   _ClipBoard_ChangeChain ( $hGUI , $hNext ) 
 EndFunc ;==>_Main 
 
 ; 向memo控件写入信息 
 Func MemoWrite( $sMessage = "" ) 
   GUICtrlSetData ( $iMemo , $sMessage & @CRLF , 1 ) 
 EndFunc ;==>MemoWrite 
 
 ; 执行$WM_CHANGECBCHAIN消息 
 Func WM_CHANGECBCHAIN( $hWnd , $iMsg , $iwParam , $ilParam ) 
   ; 显示收到的消息 
   MemoWrite( " ***** $WM_CHANGECBCHAIN ***** " ) 
 
   ; 如果下一窗体正在关闭, 修复剪贴板链 
   If $iwParam = $hNext Then 
     $hNext = $ilParam 
     ; 否则将消息传递给下一剪贴板 
   ElseIf $hNext <> 0  Then 
     _SendMessage ( $hNext , $WM_CHANGECBCHAIN , $iwParam , $ilParam , 0 , " hwnd ", " hwnd " ) 
   EndIf 
 EndFunc ;==>WM_CHANGECBCHAIN 
 
 ; 执行$WM_DRAWCLIPBOARD消息 
 Func WM_DRAWCLIPBOARD( $hWnd , $iMsg , $iwParam , $ilParam ) 
   ; 显示剪贴板上的所有文本 
   MemoWrite( _ClipBoard_GetData ()) 
 
   ; 传递消息到下一个剪贴板 
   If $hNext <> 0  Then  _SendMessage ( $hNext , $WM_DRAWCLIPBOARD , $iwParam , $ilParam ) 
 EndFunc ;==>WM_DRAWCLIPBOARD 
 
