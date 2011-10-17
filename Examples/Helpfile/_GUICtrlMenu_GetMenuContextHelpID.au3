
#include  <GuiMenu.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

_Main () 

Func _Main () 
    Local  $hWnd ,  $hMain ,  $hFile 

    ; 打开记事本 
    Run ( "Notepad.exe" ) 
  
  WinWaitActive ( "[CLASS:Notepad]" ) 
    $hWnd  =  WinGetHandle ( "[CLASS:Notepad]" ) 
    $hMain  =  _GUICtrlMenu_GetMenu ( $hWnd ) 
    $hFile  =  _GUICtrlMenu_GetItemSubMenu ( $hMain ,  0 ) 

    ; 获取/设置文件菜单帮助的上下文ID 
    
Writeln ( "File help context ID: 
"  &  _GUICtrlMenu_GetMenuContextHelpID ( $hFile )) 
    _GUICtrlMenu_SetMenuContextHelpID ( $hFile ,  1234 ) 
    
Writeln ( "File help context ID: 
"  &  _GUICtrlMenu_GetMenuContextHelpID ( $hFile )) 

EndFunc    ;==>_Main 

; 
向记事本写入一行文本 
Func Writeln ( $sText ) 
    ControlSend ( "[CLASS:Notepad]" ,  "" ,  "Edit1" ,  $sText  &  @CR ) 
EndFunc    ;==>Writeln 

