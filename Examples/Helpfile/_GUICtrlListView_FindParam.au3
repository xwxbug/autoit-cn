
#include  <GuiConstantsEx.au3> 
#include  <GuiListView.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_LV  =  False  ; 检查传递给函数的类名, 
设置为真并使用另一控件句柄观察其工作 

; 警告不要对GuiCtrlCreateListViewItem创建的项目使用 
SetItemParam 
; 参数是项目的controlId 

_Main () 

Func _Main () 
    Global  $GUI ,  $iI ,  $hListView 

    ; 创建界面 
    $GUI  =  GUICreate ( "(UDF Created) ListView Find Param" ,  400 ,  300 ) 
  
  $hListView  =  _GUICtrlListView_Create ( $GUI ,  "" ,  2 ,  2 ,  394 ,  268 ) 
    GUISetState () 

    ; 添加列 
    _GUICtrlListView_AddColumn ( $hListView ,  "Items" ,  100 ) 

    ; 添加项目 
    _GUICtrlListView_BeginUpdate ( $hListView ) 
    For  $iI  =  1  To  100 
        _GUICtrlListView_AddItem ( $hListView ,  "Item "  &  $iI ) 
    Next 
    _GUICtrlListView_EndUpdate ( $hListView ) 

  
  ; 设置项目50的参数值 
    _GUICtrlListView_SetItemParam ( $hListView ,  49 ,  1234 ) 

    ; 搜索目标项 
  
  $iI  =  _GUICtrlListView_FindParam ( $hListView ,  1234 ) 
    MsgBox ( 4160 ,  "Information" ,  "Target Item Index: "  &  $iI ) 
    _GUICtrlListView_EnsureVisible ( $hListView ,  $iI ) 

    ; 循环至用户退出 
  
  Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 

