 #include <GuiMenu.au3> 
 #include <GuiConstantsEx.au3> 
 
 Opt ( 'MustDeclareVars' , 1 ) 
 
 _Main () 
 
 Func _Main () 
   Local $hGUI , $hFile , $hEdit , $hHelp , $hMain 
   Local Enum $idNew = 1000 , $idOpen , $idSave , $idExit , $idCut , $idCopy , $idPaste , $idAbout 
 
   ; 创建界面 
   $hGUI = GUICreate ( "Menu" , 400 , 300 ) 
 
   ; 创建文件菜单 
   $hFile = _GUICtrlMenu_CreateMenu () 
   _GUICtrlMenu_AddMenuItem ( $hFile , "&New" , $idNew ) 
   _GUICtrlMenu_AddMenuItem ( $hFile , "&Open" , $idOpen ) 
   _GUICtrlMenu_AddMenuItem ( $hFile , "&Save" , $idSave ) 
   _GUICtrlMenu_AddMenuItem ( $hFile , "" , 0 ) 
   _GUICtrlMenu_AddMenuItem ( $hFile , "E&xit" , $idExit ) 
 
   ; 创建编辑菜单 
   $hEdit = _GUICtrlMenu_CreateMenu () 
   _GUICtrlMenu_AddMenuItem ( $hEdit , "&Cut" , $idCut ) 
   _GUICtrlMenu_AddMenuItem ( $hEdit , "C&opy" , $idCopy ) 
   _GUICtrlMenu_AddMenuItem ( $hEdit , "&Paste" , $idPaste ) 
 
   ; 创建帮助菜单 
   $hHelp = _GUICtrlMenu_CreateMenu () 
   _GUICtrlMenu_AddMenuItem ( $hHelp , "&About" , $idAbout ) 
 
   ; 创建主菜单 
   $hMain = _GUICtrlMenu_CreateMenu () 
   _GUICtrlMenu_AddMenuItem ( $hMain , "&File" , 0 , $hFile ) 
   _GUICtrlMenu_AddMenuItem ( $hMain , "&Edit" , 0 , $hEdit ) 
   _GUICtrlMenu_AddMenuItem ( $hMain , "&Help" , 0 , $hHelp ) 
 
   ; 设置窗体菜单 
   _GUICtrlMenu_SetMenu ( $hGUI , $hMain ) 
   GUISetState () 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
 EndFunc    ;==>_Main 
 
