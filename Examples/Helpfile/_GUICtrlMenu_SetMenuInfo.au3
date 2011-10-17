 #include <GuiMenu.au3> 
 
 Opt ( 'MustDeclareVars' , 1 ) 
 
 _Main () 
 
 Func _Main () 
   Local $hWnd , $hMain , $hFile , $tInfo 
 
   ; 打开记事本 
   Run ( "Notepad.exe" ) 
   WinWaitActive ( "[CLASS:Notepad]" ) 
   $hWnd = WinGetHandle ( "[CLASS:Notepad]" ) 
   $hMain = _GUICtrlMenu_GetMenu ( $hWnd ) 
   $hFile = _GUICtrlMenu_GetItemSubMenu ( $hMain , 0 ) 
 
   ; 获取/设置文件菜单信息 
   $tInfo = _GUICtrlMenu_GetMenuInfo ( $hFile ) 
   Writeln ( "Menu style ..........: " & DllStructGetData ( $tInfo , "Style" )) 
   Writeln ( "Menu max height .....: " & DllStructGetData ( $tInfo , "YMax" )) 
   Writeln ( "Menu background brush: " & DllStructGetData ( $tInfo , "hBack" )) 
   Writeln ( "Menu context help ID : " & DllStructGetData ( $tInfo , "ContextHelpID" )) 
   Writeln ( "Menu data ...........: " & DllStructGetData ( $tInfo , "MenuData" )) 
   Writeln ( "" ) 
   $tInfo = DllStructCreate ( $tagMENUINFO ) 
   DllStructSetData ( $tInfo , "Size" , DllStructGetSize ( $tInfo )) 
   DllStructSetData ( $tInfo , "Mask" , BitOR ( $MIM_HELPID , $MIM_MAXHEIGHT , $MIM_MENUDATA )) 
   DllStructSetData ( $tInfo , "YMax" , 100 ) 
   DllStructSetData ( $tInfo , "ContextHelpID" , 1234 ) 
   DllStructSetData ( $tInfo , "MenuData" , 4567 ) 
   _GUICtrlMenu_SetMenuInfo ( $hFile , $tInfo ) 
   $tInfo = _GUICtrlMenu_GetMenuInfo ( $hFile ) 
   Writeln ( "Menu style ..........: " & DllStructGetData ( $tInfo , "Style" )) 
   Writeln ( "Menu max height .....: " & DllStructGetData ( $tInfo , "YMax" )) 
   Writeln ( "Menu background brush: " & DllStructGetData ( $tInfo , "hBack" )) 
   Writeln ( "Menu context help ID : " & DllStructGetData ( $tInfo , "ContextHelpID" )) 
   Writeln ( "Menu data ...........: " & DllStructGetData ( $tInfo , "MenuData" )) 
   Writeln ( "" ) 
 
 EndFunc    ;==>_Main 
 
 ; 向记事本写入一行文本 
 Func Writeln ( $sText ) 
   ControlSend ( "[CLASS:Notepad]" , "" , "Edit1" , $sText & @CR ) 
 EndFunc    ;==>Writeln 
 
