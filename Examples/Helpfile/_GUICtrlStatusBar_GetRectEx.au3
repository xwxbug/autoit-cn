
#include  <GuiConstantsEx.au3> 
#include  <GuiStatusBar.au3> 
#include  <WindowsConstants.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_SB  =  False  ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 

Global  $iMemo 

_Main () 

Func _Main () 

    Local  $hGUI ,  $tRect ,  $hStatus 
    Local  $aParts [ 3 ]  =  [ 75 ,  150 ,  - 1 ] 
    
    ; 创建界面 
    $hGUI  =  GUICreate ( "StatusBar Get 
RectEx" ,  400 ,  300 ) 
    $hStatus  =  _GUICtrlStatusBar_Create  ( $hGUI ) 
    
    ; 创建memo控件 
    $iMemo  =  GUICtrlCreateEdit ( "" ,  2 ,  2 ,  396 ,  274 ,  $WS_VSCROLL ) 
    GUICtrlSetFont ( $iMemo ,  9 ,  400 ,  0 ,  "Courier New" ) 
    GUISetState () 

    ; 
设置/获取部分 
    _GUICtrlStatusBar_SetParts  ( $hStatus ,  $aParts ) 

    ; 
获取部分1的矩形框 
    $tRect  =  _GUICtrlStatusBar_GetRectEx  ( $hStatus ,  0 ) 
    MemoWrite ( "Part 1 left ...: "  &  DllStructGetData ( $tRect ,  "Left" )) 
    
MemoWrite ( "Part 1 top ....: 
"  &  DllStructGetData ( $tRect ,  "Top" )) 
    
MemoWrite ( "Part 1 right ..: 
"  &  DllStructGetData ( $tRect ,  "Right" )) 
    
MemoWrite ( "Part 1 bottom .: 
"  &  DllStructGetData ( $tRect ,  "Bottom" )) 

  
  ; 循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 

; 向memo控件写入信息 
Func MemoWrite ( $sMessage  =  "" ) 
    GUICtrlSetData ( $iMemo ,  $sMessage  &  @CRLF ,  1 ) 
EndFunc    ;==>MemoWrite 


