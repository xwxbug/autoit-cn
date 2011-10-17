
#include  <GuiConstantsEx.au3> 
#include  <GuiHeader.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_HDR  =  False  ; 检查传递给控件的类名, 
设置为真并使用另一控件句柄观察其工作 

_Main () 

Func _Main () 
    Local  $hGUI ,  $hHeader 

    ; 创建界面 
    $hGUI  =  GUICreate ( "Header" ,  400 ,  300 ) 
    $hHeader  =  _GUICtrlHeader_Create  ( $hGUI ) 
    GUISetState () 

    ; 
添加列 
    _GUICtrlHeader_AddItem  ( $hHeader ,  "Column 1" ,  100 ) 
    _GUICtrlHeader_AddItem  ( $hHeader ,  "Column 2" ,  100 ) 
    _GUICtrlHeader_AddItem  ( $hHeader ,  "Column 3" ,  100 ) 
    _GUICtrlHeader_AddItem  ( $hHeader ,  "Column 4" ,  100 ) 

    ; 
设置过滤器 
    _GUICtrlHeader_EditFilter  ( $hHeader ,  0 ) 
    Send ( "Filter 1" ) 
    Sleep ( 1000 ) 
    Send ( " {ENTER} " ) 
    _GUICtrlHeader_EditFilter  ( $hHeader ,  1 ) 
    Send ( "Filter 2" ) 
    Sleep ( 1000 ) 
    Send ( " {ENTER} " ) 

    ; 
清除第一个过滤器 
    _GUICtrlHeader_ClearFilter  ( $hHeader ,  0 ) 

    ; 循环至用户退出 
    Do 
  
  Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
EndFunc    ;==>_Main 

