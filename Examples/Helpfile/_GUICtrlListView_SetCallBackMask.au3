
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 
6 
#include  <GuiConstantsEx.au3> 
#include  <GuiListView.au3> 
#include  <GuiImageList.au3> 

$Debug_LV  =  False  ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 

Example_UDF_Created () 

Func Example_UDF_Created () 
    Local  $GUI ,  $hImage ,  $hListView 
    
    $GUI  =  GUICreate ( "(UDF Created) 
ListView Set CallBack Mask" ,  400 ,  300 ) 

    $hListView  =  _GUICtrlListView_Create ( $GUI ,  "" ,  2 ,  2 ,  394 ,  268 ) 
    GUISetState () 

    _GUICtrlListView_SetCallBackMask ( $hListView ,  32 ) 
    MsgBox ( 4160 ,  "Information" ,  "CallBackMask: "  &  _GUICtrlListView_GetCallbackMask ( $hListView )) 

  
  ; 加载图像 
    $hImage  =  _GUIImageList_Create () 
    _GUIImageList_Add ( $hImage ,  _GUICtrlListView_CreateSolidBitMap ( $hListView ,  0xFF0000 ,  16 ,  16 )) 
  
  _GUIImageList_Add ( $hImage ,  _GUICtrlListView_CreateSolidBitMap ( $hListView ,  0x00FF00 ,  16 ,  16 )) 
  
  _GUIImageList_Add ( $hImage ,  _GUICtrlListView_CreateSolidBitMap ( $hListView ,  0x0000FF ,  16 ,  16 )) 
  
  _GUIImageList_Add ( $hImage ,  _GUICtrlListView_CreateSolidBitMap ( $hListView ,  0xC0C0C0 ,  16 ,  16 )) 
  
  _GUIImageList_Add ( $hImage ,  _GUICtrlListView_CreateSolidBitMap ( $hListView ,  0xFF00FF ,  16 ,  16 )) 
  
  _GUIImageList_Add ( $hImage ,  _GUICtrlListView_CreateSolidBitMap ( $hListView ,  0xFFFF00 ,  16 ,  16 )) 
  
  _GUICtrlListView_SetImageList ( $hListView ,  $hImage ,  1 ) 
    _GUICtrlListView_SetImageList ( $hListView ,  $hImage ,  2 ) 

    ; 添加列 
    _GUICtrlListView_AddColumn ( $hListView ,  "Column 1" ,  100 ) 
    _GUICtrlListView_AddColumn ( $hListView ,  "Column 2" ,  100 ) 
    _GUICtrlListView_AddColumn ( $hListView ,  "Column 3" ,  100 ) 

    ; 通过回叫项目文本添加项 
    _GUICtrlListView_AddItem ( $hListView ,  - 1 ,  0 ) 
    _GUICtrlListView_AddItem ( $hListView ,  - 1 ,  1 ) 
  
  _GUICtrlListView_AddItem ( $hListView ,  - 1 ,  2 ) 
    
    ; 循环至用户退出 
    Do 
  
  Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>示例_UDF_Created 

