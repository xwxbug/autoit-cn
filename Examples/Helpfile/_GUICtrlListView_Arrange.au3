
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 
6 
#include  <GuiConstantsEx.au3> 
#include  <GuiListView.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_LV  =  False  ; 检查传递给函数的类名, 
设置为真并使用另一控件句柄观察其工作 

_Main () 

Func _Main () 
    Local  $hListView 
    
    GUICreate ( "ListView Arrange" ,  400 ,  300 ) 
    $hListView  =  GUICtrlCreateListView ( "" ,  2 ,  2 ,  394 ,  268 ) 
  
  _GUICtrlListView_SetUnicodeFormat ( $hListView ,  False ) 
    GUISetState () 
    
    ; 添加列 
    _GUICtrlListView_InsertColumn ( $hListView ,  0 ,  "Items" ,  100 ) 

    ; 添加项 
    _GUICtrlListView_BeginUpdate ( $hListView ) 
    For  $iI  =  1  To  10 
        _GUICtrlListView_AddItem ( $hListView ,  "Item "  &  $iI ) 
    Next 
    _GUICtrlListView_EndUpdate ( $hListView ) 

  
  ; 移动项目 2 
  
  _GUICtrlListView_SetView ( $hListView ,  3 ) 
    _GUICtrlListView_SetItemPosition ( $hListView ,  1 ,  100 ,  100 ) 
    
    MsgBox ( 4160 ,  "Information" ,  "Arranging items" ) 
    _GUICtrlListView_Arrange ( $hListView ) 
  
  
    ; 循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 

