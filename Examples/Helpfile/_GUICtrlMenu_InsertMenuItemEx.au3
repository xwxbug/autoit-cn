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
   InsertItem ( $hFile , 0 , "&New" , $idNew ) 
   InsertItem ( $hFile , 1 , "&Open" , $idOpen ) 
   InsertItem ( $hFile , 2 , "&Save" , $idSave ) 
   InsertItem ( $hFile , 3 , "" , 0 ) 
   InsertItem ( $hFile , 4 , "E&xit" , $idExit ) 
 
   ; 创建编辑菜单 
   $hEdit = _GUICtrlMenu_CreateMenu () 
   InsertItem ( $hEdit , 0 , "&Cut" , $idCut ) 
   InsertItem ( $hEdit , 1 , "C&opy" , $idCopy ) 
   InsertItem ( $hEdit , 2 , "&Paste" , $idPaste ) 
 
   ; 创建帮助菜单 
   $hHelp = _GUICtrlMenu_CreateMenu () 
   InsertItem ( $hHelp , 0 , "&About" , $idAbout ) 
 
   ; 创建主菜单 
   $hMain = _GUICtrlMenu_CreateMenu () 
   InsertItem ( $hMain , 0 , "&File" , 0 , $hFile ) 
   InsertItem ( $hMain , 1 , "&Edit" , 0 , $hEdit ) 
   InsertItem ( $hMain , 2 , "&Help" , 0 , $hHelp ) 
 
   ; 设置窗体菜单 
   _GUICtrlMenu_SetMenu ( $hGUI , $hMain ) 
   GUISetState () 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
 EndFunc    ;==>_Main 
 
 ; 插入菜单项(较难的方法) 
 Func InsertItem ( $hMenu , $iIndex , $sText , $iCmdID = 0 , $hSubMenu = 0 ) 
   Local $tMenu , $tText , $aResult 
 
   $tMenu = DllStructCreate ( $tagMENUITEMINFO ) 
   DllStructSetData ( $tMenu , "Size" , DllStructGetSize ( $tMenu )) 
   DllStructSetData ( $tMenu , "Mask" , BitOR ( $MIIM_ID , $MIIM_STRING , $MIIM_SUBMENU )) 
   DllStructSetData ( $tMenu , "ID" , $iCmdID ) 
   DllStructSetData ( $tMenu , "SubMenu" , $hSubMenu ) 
   If $sText = "" Then 
     DllStructSetData ( $tMenu , "Mask" , $MIIM_FTYPE ) 
     DllStructSetData ( $tMenu , "Type" , $MFT_SEPARATOR ) 
   Else 
     DllStructSetData ( $tMenu , "Mask" , BitOR ( $MIIM_ID , $MIIM_STRING , $MIIM_SUBMENU )) 
     $tText = DllStructCreate ( "char Text[" & StringLen ( $sText ) + 1 & "]" ) 
     DllStructSetData ( $tText , "Text" , $sText ) 
     DllStructSetData ( $tMenu , "TypeData" , DllStructGetPtr ( $tText )) 
   EndIf 
   _GUICtrlMenu_InsertMenuItemEx ( $hMenu , $iIndex , $tMenu ) 
 EndFunc    ;==>InsertItem 
 
