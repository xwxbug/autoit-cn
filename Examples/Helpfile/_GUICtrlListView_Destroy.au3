
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 
6 
#include  <GuiConstantsEx.au3> 
#include  <GuiListView.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_LV  =  False  ; 检查传递给函数的类名, 
设置为真并使用另一控件句柄观察其工作 

_Main () 

Func _Main () 

    Local  $GUI ,  $HandleBefore ,  $hListView 
    
    $GUI  =  GUICreate ( "(UDF Created) 
ListView Destroy" ,  400 ,  300 ) 

    $hListView  =  _GUICtrlListView_Create ( $GUI ,  "" ,  2 ,  2 ,  394 ,  268 ) 
    $HandleBefore  =  $hListView 
    GUISetState () 
  
  
    ; 添加列 
    _GUICtrlListView_InsertColumn ( $hListView ,  0 ,  "Column 1" ,  100 ) 
    _GUICtrlListView_InsertColumn ( $hListView ,  1 ,  "Column 2" ,  100 ) 
  
  _GUICtrlListView_InsertColumn ( $hListView ,  2 ,  "Column 3" ,  100 ) 

    ; 添加项目 
    _GUICtrlListView_AddItem ( $hListView ,  "Row 1: Col 1" ) 
  
  _GUICtrlListView_AddSubItem ( $hListView ,  0 ,  "Row 1: Col 2" ,  1 ) 
    _GUICtrlListView_AddSubItem ( $hListView ,  0 ,  "Row 1: Col 3" ,  2 ) 
  
  _GUICtrlListView_AddItem ( $hListView ,  "Row 2: Col 1" ) 
    _GUICtrlListView_AddSubItem ( $hListView ,  1 ,  "Row 2: Col 2" ,  1 ) 
  
  _GUICtrlListView_AddItem ( $hListView ,  "Row 3: Col 1" ) 

    MsgBox ( 4160 ,  "Information" ,  "Destroying the Control 
for Handle: "  &  $hListView ) 
    MsgBox ( 4160 ,  "Information" ,  "Control Destroyed: 
"  &  _GUICtrlListView_Destroy ( $hListView )  &  @LF  &  _ 
      
      "Handel Before Destroy: "  &  $HandleBefore  &  @LF  &  _ 
            "Handle After Destroy: "  &  $hListView ) 

  
  ; 循环至用户退出 
    Do 
  
  Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 

