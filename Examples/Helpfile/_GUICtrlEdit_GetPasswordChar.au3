
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 
6 
#include  <GuiEdit.au3> 
#include  <GuiConstantsEx.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_Ed  =  False  ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 

_Main () 

Func _Main () 
    Local  $hEdit 

    ; 创建界面 
    GUICreate ( "Edit Get 
Password Char" ,  400 ,  300 ) 
    $hEdit  =  GUICtrlCreateInput ( "Test of 
build-in control" ,  2 ,  2 ,  394 ,  25 ,  $ES_PASSWORD ) 
  
  GUISetState () 

    MsgBox ( 4096 ,  "Information" ,  "Password Char: 
"  &  _GUICtrlEdit_GetPasswordChar ( $hEdit )) 

    _GUICtrlEdit_SetPasswordChar ( $hEdit ,  "$" )  ; 将密码字符变为$ 
    
    MsgBox ( 4096 ,  "Information" ,  "Password Char: "  &  _GUICtrlEdit_GetPasswordChar ( $hEdit )) 

  
  _GUICtrlEdit_SetPasswordChar ( $hEdit )  ; 显示用户键入的字符 

    MsgBox ( 4096 ,  "Information" ,  "Password Char: 
"  &  _GUICtrlEdit_GetPasswordChar ( $hEdit )) 

    ; 
循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 

