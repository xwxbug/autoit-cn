
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 
6 
#include  <GuiConstantsEx.au3> 
#include  <GuiListView.au3> 
#include  <Constants.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_LV  =  False  ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 

_Main () 

Func _Main () 
    Local  $hListView 
    
    GUICreate ( "ListView Set Text Color" ,  400 ,  300 ) 
    $hListView  =  GUICtrlCreateListView ( "" ,  2 ,  2 ,  394 ,  268 ) 
  
  GUISetState () 

    ; 
设置颜色 
    _GUICtrlListView_SetBkColor ( $hListView ,  $CLR_MONEYGREEN ) 
  
  _GUICtrlListView_SetTextColor ( $hListView ,  $CLR_BLACK ) 
    _GUICtrlListView_SetTextBkColor ( $hListView ,  $CLR_MONEYGREEN ) 

    ; 添加列 
    _GUICtrlListView_AddColumn ( $hListView ,  "Items" ,  100 ) 

    ; 添加项目 
    _GUICtrlListView_BeginUpdate ( $hListView ) 
  
  For  $iI  =  1  To  10 
        _GUICtrlListView_AddItem ( $hListView ,  "Item "  &  $iI ) 
    Next 
    _GUICtrlListView_EndUpdate ( $hListView ) 

  
  ; 显示颜色 
    MsgBox ( 4160 ,  "Information" ,  "Back Color ....: "  &  _GUICtrlListView_GetBkColor ( $hListView )  &  @CRLF  &  _ 
            "Text Color ....: "  &  _GUICtrlListView_GetTextColor ( $hListView )  &  @CRLF  &  _ 
            "Text Back Color: "  &  _GUICtrlListView_GetTextBkColor ( $hListView )) 

  
  ; 循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 

