
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 
6 
#include  <GuiConstantsEx.au3> 
#include  <GuiListView.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_LV  =  False  ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 

_Main () 

Func _Main () 
    Local  $tItem ,  $hListView 
    
    GUICreate ( "ListView Get ItemEX" ,  400 ,  300 ) 

    $hListView  =  GUICtrlCreateListView ( "Items" ,  2 ,  2 ,  394 ,  268 ) 
  
  GUISetState () 

    GUICtrlCreateListViewItem ( "Item 1" ,  $hListView ) 
  
  GUICtrlCreateListViewItem ( "Item 2" ,  $hListView ) 
    GUICtrlCreateListViewItem ( "Item 3" ,  $hListView ) 

  
  ; 显示项目1的自然状态 
    $tItem  =  DllStructCreate ( $tagLVITEM ) 
  
  DllStructSetData ( $tItem ,  "Mask" ,  $LVIF_STATE ) 
  
  DllStructSetData ( $tItem ,  "Item" ,  1 ) 
    DllStructSetData ( $tItem ,  "StateMask" ,  - 1 ) 
    _GUICtrlListView_GetItemEx ( $hListView ,  $tItem ) 
    MsgBox ( 4160 ,  "Information" ,  "Item 2 State: "  &  DllStructGetData ( $tItem ,  "State" )) 
    
    ; 选定项目 
2 
    _GUICtrlListView_SetItemSelected ( $hListView ,  1 ) 
    
    ; 显示项目1的自然状态 
    _GUICtrlListView_GetItemEx ( $hListView ,  $tItem ) 
    MsgBox ( 4160 ,  "Information" ,  "Item 2 State: "  &  DllStructGetData ( $tItem ,  "State" )) 

  
  ; 循环至用户退出 
    Do 
  
  Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 

