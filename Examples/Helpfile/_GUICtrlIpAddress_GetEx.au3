
#include  <GuiConstantsEx.au3> 
#include  <GuiIPAddress.au3> 

Opt ( "MustDeclareVars" ,  1 ) 

$Debug_IP  =  False  ; 检查传递给函数的类名, 
设置为真且使用另一控件的句柄观察其工作 

Global  $iMemo 

_Main () 

Func _Main () 
    Local  $hgui ,  $tIP  =  DllStructCreate ( $tagGetIPAddress ),  $aIP [ 4 ]  =  [ 24 ,  168 ,  2 ,  128 ],  $hIPAddress 
    
    $hgui  =  GUICreate ( "IP Address 
Control GetEx 示例" ,  400 ,  300 ) 
    $hIPAddress  =  _GUICtrlIpAddress_Create  ( $hgui ,  2 ,  4 ,  125 ,  20 ) 
  
  $iMemo  =  GUICtrlCreateEdit ( "" ,  2 ,  28 ,  396 ,  270 ,  0 ) 
    GUICtrlSetFont ( $iMemo ,  9 ,  400 ,  0 ,  "Courier New" ) 
  
  GUISetState ( @SW_SHOW ) 
    
    For  $x  =  0  To  3 
        DllStructSetData ( $tIP ,  "Field"  &  $x  +  1 ,  $aIP [ $x ]) 
    Next 
    
    _GUICtrlIpAddress_SetEx  ( $hIPAddress ,  $tIP ) 

    $tIP  =  _GUICtrlIpAddress_GetEx  ( $hIPAddress ) 

    For  $x  =  0  To  3 
        
MemoWrite ( "Field "  &  $x  +  1  &  " .....: 
"  &  DllStructGetData ( $tIP ,  "Field"  &  $x  +  1 )) 
    Next 

    ; 
等待用户关闭界面 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
EndFunc    ;==>_Main 

; 向memo控件写入文本 
Func MemoWrite ( $sMessage ) 
    GUICtrlSetData ( $iMemo ,  $sMessage  &  @CRLF ,  1 ) 
EndFunc    ;==>MemoWrite 


