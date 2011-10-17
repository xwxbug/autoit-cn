
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 
6 
#include  <GuiConstantsEx.au3> 
#include  <GuiListView.au3> 
#include  <GuiImageList.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_LV  =  False  ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 

_Main () 

Func _Main () 
    Local  $hImage ,  $hListView 
    
    GUICreate ( "ListView Get ISearch" ,  400 ,  300 ) 

    $hListView  =  GUICtrlCreateListView ( "" ,  2 ,  2 ,  394 ,  268 ) 
  
  GUICtrlSetStyle ( $hListView ,  $LVS_ICON ) 
    GUISetState () 

    ; 加载图像 
    $hImage  =  _GUIImageList_Create () 
    _GUIImageList_Add ( $hImage ,  _GUICtrlListView_CreateSolidBitMap ( $hListView ,  0xFF0000 ,  16 ,  16 )) 
  
  _GUICtrlListView_SetImageList ( $hListView ,  $hImage ,  0 ) 
    
    _GUICtrlListView_BeginUpdate ( $hListView ) 
  
  For  $x  =  1  To  10 
        _GUICtrlListView_InsertItem ( $hListView ,  "Item "  &  $x ,  - 1 ,  0 ) 
    Next 
    _GUICtrlListView_EndUpdate ( $hListView ) 
  
  
    Send ( "Item 1" ) 
    
    ; 获取增量搜索字符串 
    MsgBox ( 4160 ,  "Information" ,  "Incremental Search String: "  &  _GUICtrlListView_GetISearchString ( $hListView )) 

  
  ; 循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 

  
  GUIDelete () 
EndFunc    ;==>_Main 

