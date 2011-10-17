 #include <GuiMenu.au3> 
 #include <GuiConstantsEx.au3> 
 
 Opt ( 'MustDeclareVars' , 1 ) 
 
 Global $iMemo 
 
 _Main () 
 
 Func _Main () 
   Local $hGUI , $hFile , $hEdit , $hHelp , $hMain 
   Local Enum $idNew = 1000 , $idOpen , $idSave , $idExit , $idCut , $idCopy , $idPaste , $idAbout 
 
   ; 创建界面 
   $hGUI = GUICreate ( "Menu" , 400 , 300 ) 
 
   ; 创建文件菜单 
   $hFile = _GUICtrlMenu_CreateMenu () 
   _GUICtrlMenu_InsertMenuItem ( $hFile , 0 , "&New" , $idNew ) 
   _GUICtrlMenu_InsertMenuItem ( $hFile , 1 , "&Open" , $idOpen ) 
   _GUICtrlMenu_InsertMenuItem ( $hFile , 2 , "&Save" , $idSave ) 
   _GUICtrlMenu_InsertMenuItem ( $hFile , 3 , "" , 0 ) 
   _GUICtrlMenu_InsertMenuItem ( $hFile , 4 , "E&xit" , $idExit ) 
 
   ; 创建编辑菜单 
   $hEdit = _GUICtrlMenu_CreateMenu () 
   _GUICtrlMenu_InsertMenuItem ( $hEdit , 0 , "&Cut" , $idCut ) 
   _GUICtrlMenu_InsertMenuItem ( $hEdit , 1 , "C&opy" , $idCopy ) 
   _GUICtrlMenu_InsertMenuItem ( $hEdit , 2 , "&Paste" , $idPaste ) 
 
   ; 创建帮助菜单 
   $hHelp = _GUICtrlMenu_CreateMenu () 
   _GUICtrlMenu_InsertMenuItem ( $hHelp , 0 , "&About" , $idAbout ) 
 
   ; 创建主菜单 
   $hMain = _GUICtrlMenu_CreateMenu () 
   _GUICtrlMenu_InsertMenuItem ( $hMain , 0 , "&File" , 0 , $hFile ) 
   _GUICtrlMenu_InsertMenuItem ( $hMain , 1 , "&Edit" , 0 , $hEdit ) 
   _GUICtrlMenu_InsertMenuItem ( $hMain , 2 , "&Help" , 0 , 0 ) 
 
   ; 设置窗体菜单 
   _GUICtrlMenu_SetMenu ( $hGUI , $hMain ) 
 
   ; 创建memo控件 
   $iMemo = GUICtrlCreateEdit ( "" , 2 , 2 , 396 , 276 , 0 ) 
   GUICtrlSetFont ( $iMemo , 9 , 400 , 0 , "Courier New" ) 
   GUISetState () 
 
   ; 获取/设置帮助菜单 
   MemoWrite ( "Help submenu handle: " & _GUICtrlMenu_GetItemSubMenu ( $hMain , 2 )) 
   _GUICtrlMenu_SetItemSubMenu ( $hMain , 2 , $hHelp ) 
   MemoWrite ( "Help submenu handle: " & _GUICtrlMenu_GetItemSubMenu ( $hMain , 2 )) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
 EndFunc    ;==>_Main 
 
 ; 向memo控件写入信息 
 Func MemoWrite ( $sMessage ) 
   GUICtrlSetData ( $iMemo , $sMessage & @CRLF , 1 ) 
 EndFunc    ;==>MemoWrite 
 
