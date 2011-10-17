
#include  <GuiMenu.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

_Main () 

Func _Main () 
    Local  $hWnd ,  $hMain 

    Run ( "Notepad.exe" ) 
  
  WinWaitActive ( "[CLASS:Notepad]" ) 
    $hWnd  =  WinGetHandle ( "[CLASS:Notepad]" ) 
    $hMain  =  _GUICtrlMenu_GetMenu ( $hWnd ) 

    ; 显示属于记事本的菜单句柄 
    
Writeln ( "Notepad handle: 
0x"  &  Hex ( $hWnd )) 
    
Writeln ( "Menu Parent ..: 
0x"  &  Hex ( _GUICtrlMenu_FindParent ( $hMain ))) 

EndFunc    ;==>_Main 

; 向记事本写入一行 
Func Writeln ( $sText ) 
    ControlSend ( "[CLASS:Notepad]" ,  "" ,  "Edit1" ,  $sText  &  @CR ) 
EndFunc    ;==>Writeln 

  
   
