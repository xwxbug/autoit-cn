
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 
6 
#include  <GuiConstantsEx.au3> 
#include  <GuiTreeView.au3> 
#include  <WindowsConstants.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_TV  =  False  ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 

_Main () 

Func _Main () 

    Local  $hItem ,  $hChild ,  $hFirst ,  $hTreeView 
    Local  $iStyle  =  BitOR ( $TVS_EDITLABELS ,  $TVS_HASBUTTONS ,  $TVS_HASLINES ,  $TVS_LINESATROOT ,  $TVS_DISABLEDRAGDROP ,  $TVS_SHOWSELALWAYS ,  $TVS_CHECKBOXES ) 
    
    GUICreate ( "TreeView Get Parent Handle" ,  400 ,  300 ) 

    $hTreeView  =  GUICtrlCreateTreeView ( 2 ,  2 ,  396 ,  268 ,  $iStyle ,  $WS_EX_CLIENTEDGE ) 
    GUISetState () 

    _GUICtrlTreeView_BeginUpdate ( $hTreeView ) 
  
  For  $x  =  0  To  20 
        $hItem  =  GUICtrlCreateTreeViewItem ( StringFormat ( "[%02d] New 
Item" ,  $x ),  $hTreeView ) 
  
      For  $y  =  0  To  2 
            $hChild  =  GUICtrlCreateTreeViewItem ( StringFormat ( "[%02d] New 
Item" ,  $y ),  $hItem ) 
    
    Next 
    Next 
    _GUICtrlTreeView_EndUpdate ( $hTreeView ) 

  
  _GUICtrlTreeView_SelectItem ( $hTreeView ,  $hChild ) 
    MsgBox ( 4160 ,  "Information" ,  "Parent Handle: "  &  _GUICtrlTreeView_GetParentHandle ( $hTreeView ,  $hChild )) 
    _GUICtrlTreeView_SelectItem ( $hTreeView ,  _GUICtrlTreeView_GetParentHandle ( $hTreeView ,  $hChild )) 

    ; 
循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 

