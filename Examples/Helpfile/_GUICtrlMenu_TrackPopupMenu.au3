 #include <GuiMenu.au3> 
 #include <GuiConstantsEx.au3> 
 #include <WinAPI.au3> 
 #include <WindowsConstants.au3> 
 
 Opt ( 'MustDeclareVars' , 1 ) 
 
 Global Enum $idOpen = 1000 , $idSave , $idInfo 
 
 _Main () 
 
 Func _Main () 
   Local $hGUI 
 
   ; 创建界面 
   $hGUI = GUICreate ( "Menu" , 400 , 300 ) 
   GUISetState () 
 
   ; 注册消息句柄 
   GUIRegisterMsg ( $WM_COMMAND , "WM_COMMAND" ) 
   GUIRegisterMsg ( $WM_CONTEXTMENU , "WM_CONTEXTMENU" ) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
 
 EndFunc    ;==>_Main 
 
 ; WM_COMMAND消息句柄 
 Func WM_COMMAND ( $hWnd , $iMsg , $iwParam , $ilParam ) 
   Switch $iwParam 
       Case $idOpen 
           _WinAPI_ShowMsg ( "Open" ) 
       Case $idSave 
           _WinAPI_ShowMsg ( "Save" ) 
       Case $idInfo 
           _WinAPI_ShowMsg ( "Info" ) 
   EndSwitch 
 EndFunc    ;==>WM_COMMAND 
 
 ; WM_CONTEXTMENU消息句柄 
 Func WM_CONTEXTMENU ( $hWnd , $iMsg , $iwParam , $ilParam ) 
   Local $hMenu 
 
   $hMenu = _GUICtrlMenu_CreatePopup () 
   _GUICtrlMenu_InsertMenuItem ( $hMenu , 0 , "Open" , $idOpen ) 
   _GUICtrlMenu_InsertMenuItem ( $hMenu , 1 , "Save" , $idSave ) 
   _GUICtrlMenu_InsertMenuItem ( $hMenu , 3 , "" , 0 ) 
   _GUICtrlMenu_InsertMenuItem ( $hMenu , 3 , "Info" , $idInfo ) 
   _GUICtrlMenu_TrackPopupMenu ( $hMenu , $iwParam ) 
   _GUICtrlMenu_DestroyMenu ( $hMenu ) 
   Return True 
 EndFunc    ;==>WM_CONTEXTMENU 
 
