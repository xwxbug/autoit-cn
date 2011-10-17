
#include  <GuiConstantsEx.au3> 
#include  <GuiHeader.au3> 
#include  <GuiImageList.au3> 
#include  <WinAPI.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_HDR  =  False  ; 检查传递给控件的类名, 
设置为真并使用另一控件句柄观察其工作 

_Main () 

Func _Main () 
    Local  $hGUI ,  $hHeader ,  $hImage ,  $iMsg ,  $aSize ,  $tPos ,  $tRect ,  $hDC 

    ; 
创建界面 
    $hGUI  =  GUICreate ( "Header" ,  400 ,  300 ) 
    $hHeader  =  _GUICtrlHeader_Create  ( $hGUI ) 
    GUISetState () 

    ; 
添加列 
    _GUICtrlHeader_AddItem  ( $hHeader ,  "Column 1" ,  100 ) 
    _GUICtrlHeader_AddItem  ( $hHeader ,  "Column 2" ,  100 ) 
    _GUICtrlHeader_AddItem  ( $hHeader ,  "Column 3" ,  100 ) 
    _GUICtrlHeader_AddItem  ( $hHeader ,  "Column 4" ,  100 ) 

    ; 
创建一个拖曳图像 
    $hImage  =  _GUICtrlHeader_CreateDragImage  ( $hHeader ,  1 ) 
    $aSize  =  _GUIImageList_GetIconSize  ( $hImage ) 
    $hDC  =  _WinAPI_GetDC  ( $hGUI ) 

    ; 
在箭头位置显示拖曳图像直到用户退出 
    Do 
        $iMsg  =  GUIGetMsg () 
        If  $iMsg  =  $GUI_EVENT_MOUSEMOVE  Then 
            If  $tPos  <>  0  Then 
            
    $tRect  =  DllStructCreate ( $tagRECT ) 
    
            DllStructSetData ( $tRect ,  "Left" ,  DllStructGetData ( $tPos ,  "X" )) 
    
            DllStructSetData ( $tRect ,  "Top" ,  DllStructGetData ( $tPos ,  "Y" )) 
    
            DllStructSetData ( $tRect ,  "Right" ,  DllStructGetData ( $tPos ,  "X" )  +  $aSize [ 0 ]) 
                DllStructSetData ( $tRect ,  "Bottom" ,  DllStructGetData ( $tPos ,  "Y" )  +  $aSize [ 1 ]) 
                _WinAPI_InvalidateRect  ( $hGUI ,  $tRect ) 
            EndIf 
          
  $tRect  =  _WinAPI_GetClientRect  ( $hGUI ) 
            $tPos  =  _WinAPI_GetMousePos  ( True ,  $hGUI ) 
            If  _WinAPI_PtInRect  ( $tRect ,  $tPos )  Then 
    
            _GUIImageList_Draw  ( $hImage ,  0 ,  $hDC ,  DllStructGetData ( $tPos ,  "X" ),  DllStructGetData ( $tPos ,  "Y" )) 
    
        EndIf 
        EndIf 
    Until  $iMsg  =  $GUI_EVENT_CLOSE 
EndFunc    ;==>_Main 

