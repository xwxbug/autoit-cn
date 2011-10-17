
#include  <GuiConstantsEx.au3> 
#include  <GuiStatusBar.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_SB  =  False  ; 检查传递给函数的类名, 
设置为真并使用另一控件的句柄观察其工作 

_Main () 

Func _Main () 

    Local  $hGUI ,  $HandleBefore ,  $hStatus 
    Local  $aParts [ 3 ]  =  [ 75 ,  150 ,  - 1 ] 
    
    ; 创建界面 
    $hGUI  =  GUICreate ( "StatusBar 
Destroy" ,  400 ,  300 ) 

    ;=============================================================================== 
    ; 默认不带文本的一个部分 
    $hStatus  =  _GUICtrlStatusBar_Create  ( $hGUI ) 
    ;=============================================================================== 
    _GUICtrlStatusBar_SetParts  ( $hStatus ,  $aParts ) 

    GUISetState () 

  
  $HandleBefore  =  $hStatus 
    MsgBox  ( 4160 ,  "Information" ,  "Destroying the Control 
for Handle: "  &  $hStatus ) 
    MsgBox  ( 4160 ,  "Information" ,  "Control Destroyed: 
"  &  _GUICtrlStatusBar_Destroy  ( $hStatus )  &  @LF  &  _ 
            "Handel 
Before Destroy: "  &  $HandleBefore  &  @LF  &  _ 
            "Handle After Destroy: "  &  $hStatus ) 

  
  ; 循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 


