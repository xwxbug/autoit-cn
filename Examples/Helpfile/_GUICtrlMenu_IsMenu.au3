 #include <GuiMenu.au3> 
 
 Opt ( 'MustDeclareVars' , 1 ) 
 
 _Main () 
 
 Func _Main () 
   Local $hWnd , $hMain 
 
   ; 打开记事本 
   Run ( "Notepad.exe" ) 
   WinWaitActive ( "[CLASS:Notepad]" ) 
   $hWnd = WinGetHandle ( "[CLASS:Notepad]" ) 
   $hMain = _GUICtrlMenu_GetMenu ( $hWnd ) 
 
   ; 检查返回值 
   Writeln ( "Is Menu: " & _GUICtrlMenu_IsMenu ( $hWnd )) 
   Writeln ( "Is Menu: " & _GUICtrlMenu_IsMenu ( $hMain )) 
 
 EndFunc    ;==>_Main 
 
 ; 向记事本写入一行 
 Func Writeln ( $sText ) 
   ControlSend ( "[CLASS:Notepad]" , "" , "Edit1" , $sText & @CR ) 
 EndFunc    ;==>Writeln 
 
