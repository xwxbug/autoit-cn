
#include  <GuiConstantsEx.au3> 
#include  <GuiHeader.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_HDR  =  False  ; 
检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 

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

    ; 插入新列 
    _GUICtrlHeader_InsertItem  ( $hHeader ,  1 ,  "Column X" ,  100 ,  2 ) 

    ; 循环至用户退出 
    Do 
  
  Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
EndFunc    ;==>_Main 

  
   
