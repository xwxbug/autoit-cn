
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
    
    GUICreate ( "ListView End Update" ,  400 ,  300 ) 

    $hListView  =  GUICtrlCreateListView ( "" ,  2 ,  2 ,  394 ,  268 ) 
  
  GUICtrlSetStyle ( $hListView ,  $LVS_ICON ) 
    GUISetState () 
    
    ; 加载图像 
    $hImage  =  _GUIImageList_Create ( 32 ,  32 ) 
  
  _GUIImageList_Add ( $hImage ,  _GUICtrlListView_CreateSolidBitMap ( GUICtrlGetHandle ( $hListView ),  0xFF0000 ,  32 ,  32 )) 
  
  _GUIImageList_Add ( $hImage ,  _GUICtrlListView_CreateSolidBitMap ( GUICtrlGetHandle ( $hListView ),  0x00FF00 ,  32 ,  32 )) 
  
  _GUIImageList_Add ( $hImage ,  _GUICtrlListView_CreateSolidBitMap ( GUICtrlGetHandle ( $hListView ),  0x0000FF ,  32 ,  32 )) 
  
  _GUICtrlListView_SetImageList ( $hListView ,  $hImage ,  0 ) 

    ; 添加项 
    _GUICtrlListView_BeginUpdate ( $hListView ) 
  
  For  $iI  =  1  To  10 
        _GUICtrlListView_AddItem ( $hListView ,  "Red" ,  0 ) 
      
  _GUICtrlListView_AddItem ( $hListView ,  "Green" ,  1 ) 
        _GUICtrlListView_AddItem ( $hListView ,  "Blue" ,  2 ) 
    Next 
    _GUICtrlListView_EndUpdate ( $hListView ) 

  
  ; 循环至用户退出 
    Do 
  
  Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 

