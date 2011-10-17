
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 
6 
#include  <GuiConstantsEx.au3> 
#include  <GuiListView.au3> 
#include  <GuiImageList.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_LV  =  False  ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 

示例_UDF_Created () 

Func 示例_UDF_Created () 

    Local  $GUI ,  $hImage ,  $aDrag ,  $hListView 
    
    $GUI  =  GUICreate ( "(UDF Created) 
ListView Draw Drag Image" ,  400 ,  300 ) 

    $hListView  =  _GUICtrlListView_Create ( $GUI ,  "" ,  2 ,  2 ,  394 ,  268 ) 
    GUISetState () 
    
    ; 加载图像 
    $hImage  =  _GUIImageList_Create () 
    _GUIImageList_Add ( $hImage ,  _GUICtrlListView_CreateSolidBitMap ( $hListView ,  0xFF0000 ,  16 ,  16 )) 
    _GUIImageList_Add ( $hImage ,  _GUICtrlListView_CreateSolidBitMap ( $hListView ,  0x00FF00 ,  16 ,  16 )) 
    _GUIImageList_Add ( $hImage ,  _GUICtrlListView_CreateSolidBitMap ( $hListView ,  0x0000FF ,  16 ,  16 )) 
    _GUICtrlListView_SetImageList ( $hListView ,  $hImage ,  1 ) 

    ; 添加列 
    _GUICtrlListView_InsertColumn ( $hListView ,  0 ,  "Column 1" ,  100 ) 
    _GUICtrlListView_InsertColumn ( $hListView ,  1 ,  "Column 2" ,  100 ) 
  
  _GUICtrlListView_InsertColumn ( $hListView ,  2 ,  "Column 3" ,  100 ) 

    ; 添加项 
    _GUICtrlListView_AddItem ( $hListView ,  "Red" ,  0 ) 
    _GUICtrlListView_AddItem ( $hListView ,  "Green" ,  1 ) 
    _GUICtrlListView_AddItem ( $hListView ,  "Blue" ,  2 ) 
    
    ; 创建拖曳图像 
    $aDrag  =  _GUICtrlListView_CreateDragImage ( $hListView ,  0 ) 
    _GUICtrlListView_DrawDragImage ( $hListView ,  $aDrag ) 
    
    While  1 
      
  Switch  GUIGetMsg () 
  
          Case  $GUI_EVENT_MOUSEMOVE 
                _GUICtrlListView_DrawDragImage ( $hListView ,  $aDrag ) 
    
        Case  $GUI_EVENT_CLOSE 
    
            ExitLoop 
        EndSwitch 
    WEnd 
    
    ; 销毁图像列表 
    _GUIImageList_Destroy ( $aDrag [ 0 ]) 

    GUIDelete () 
EndFunc    ;==>示例_UDF_Created 

