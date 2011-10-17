
#include  <GuiConstantsEx.au3> 
#include  <GuiIPAddress.au3> 

Opt ( "MustDeclareVars" ,  1 ) 

$Debug_IP  =  False  ; 检查传递给函数的类名, 
设置为真且使用另一控件的句柄观察其工作 

_Main () 

Func _Main () 
    Local  $hgui ,  $hIPAddress ,  $hIPAddress2 
    
    $hgui  =  GUICreate ( "IP Address 
Control Set Font 示例" ,  300 ,  150 ) 
  
  $hIPAddress  =  _GUICtrlIpAddress_Create  ( $hgui ,  10 ,  10 ,  150 ,  30 ) 
  
  $hIPAddress2  =  _GUICtrlIpAddress_Create  ( $hgui ,  10 ,  50 ,  150 ,  30 ) 
  
  GUISetState ( @SW_SHOW ) 

  
  _GUICtrlIpAddress_Set  ( $hIPAddress ,  "24.168.2.128" ) 
  
  _GUICtrlIpAddress_SetFont  ( $hIPAddress ,  "Times New 
Roman" ,  14 ,  800 ,  True ) 
    _GUICtrlIpAddress_Set  ( $hIPAddress2 ,  "24.168.2.128" ) 
    _GUICtrlIpAddress_SetFont  ( $hIPAddress2 ,  "Arial" ,  10 ,  300 ) 
  
  
    ; 
等待用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
EndFunc    ;==>_Main 


