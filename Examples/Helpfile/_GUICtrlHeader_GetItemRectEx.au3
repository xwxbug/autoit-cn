
#include  <GuiConstantsEx.au3> 
#include  <GuiHeader.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_HDR  =  False  ; 检查传递给控件的类名, 
设置为真并使用另一控件句柄观察其工作 

Global  $iMemo 

_Main () 

Func _Main () 
    Local  $hGUI ,  $hHeader ,  $tRect 

    ; 创建界面 
    $hGUI  =  GUICreate ( "Header" ,  400 ,  300 ) 
    $hHeader  =  _GUICtrlHeader_Create  ( $hGUI ) 
    $iMemo  =  GUICtrlCreateEdit ( "" ,  2 ,  24 ,  396 ,  274 ,  0 ) 
    GUICtrlSetFont ( $iMemo ,  9 ,  400 ,  0 ,  "Courier New" ) 
  
  GUISetState () 

    ; 
添加列 
    _GUICtrlHeader_AddItem  ( $hHeader ,  "Column 1" ,  100 ) 
    _GUICtrlHeader_AddItem  ( $hHeader ,  "Column 2" ,  100 ) 
    _GUICtrlHeader_AddItem  ( $hHeader ,  "Column 3" ,  100 ) 
    _GUICtrlHeader_AddItem  ( $hHeader ,  "Column 4" ,  100 ) 

    ; 
显示列 1 矩形 
    $tRect  =  _GUICtrlHeader_GetItemRectEx  ( $hHeader ,  0 ) 
    MemoWrite ( "Column 1 left .: "  &  DllStructGetData ( $tRect ,  "Left" )) 
    
MemoWrite ( "Column 1 top ..: 
"  &  DllStructGetData ( $tRect ,  "Top" )) 
    
MemoWrite ( "Column 1 right : 
"  &  DllStructGetData ( $tRect ,  "Right" )) 
    
MemoWrite ( "Column 1 bottom: 
"  &  DllStructGetData ( $tRect ,  "Bottom" )) 


    ; 循环至用户退出 
    Do 
  
  Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
EndFunc    ;==>_Main 

; 
向memo控件写入一行 
Func MemoWrite ( $sMessage ) 
    GUICtrlSetData ( $iMemo ,  $sMessage  &  @CRLF ,  1 ) 
EndFunc    ;==>MemoWrite 

