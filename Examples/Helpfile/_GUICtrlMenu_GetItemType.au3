示例  

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

    ; 改变打开项目类型 
    
Writeln ( "Open item type: 
0x"  &  Hex ( _GUICtrlMenu_GetItemType ( $hFile ,  1 ))) 
    _GUICtrlMenu_SetItemType ( $hFile ,  1 ,  $MFT_RADIOCHECK ) 
    _GUICtrlMenu_CheckRadioItem ( $hFile ,  0 ,  8 ,  1 ) 
    
Writeln ( "Open item type: 
0x"  &  Hex ( _GUICtrlMenu_GetItemType ( $hFile ,  1 ))) 

EndFunc    ;==>_Main 

; 向记事本写入文本 
Func Writeln ( $sText ) 
    ControlSend ( "[CLASS:Notepad]" ,  "" ,  "Edit1" ,  $sText  &  @CR ) 
EndFunc    ;==>Writeln 

  
   
