
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 
6 
#include  <GuiConstantsEx.au3> 
#include  <GuiTreeView.au3> 
#include  <WindowsConstants.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_TV  =  False  ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 

; 
注意不要在由GUICtrlCreateTreeViewItem创建的项目上使用SetItemParam 
; 
参数是由建立函数建立的控件编号 

_Main () 

Func _Main () 

    Local  $GUI ,  $hItem [ 10 ],  $hItemChild [ 30 ],  $iYIndex  =  0 ,  $iRand ,  $iParam  =  1 ,  $hTreeView 
    Local  $iStyle  =  BitOR ( $TVS_EDITLABELS ,  $TVS_HASBUTTONS ,  $TVS_HASLINES ,  $TVS_LINESATROOT ,  $TVS_DISABLEDRAGDROP ,  $TVS_SHOWSELALWAYS ,  $TVS_CHECKBOXES ) 
    
    $GUI  =  GUICreate ( "(UDF Created) 
TreeView Set Item Param" ,  400 ,  300 ) 

    $hTreeView  =  _GUICtrlTreeView_Create ( $GUI ,  2 ,  2 ,  396 ,  268 ,  $iStyle ,  $WS_EX_CLIENTEDGE ) 
    GUISetState () 

    _GUICtrlTreeView_BeginUpdate ( $hTreeView ) 
  
  For  $x  =  0  To  9 
        $hItem [ $x ]  =  _GUICtrlTreeView_Add ( $hTreeView ,  0 ,  StringFormat ( "[%02d] New 
Item" ,  $x )) 
    
    _GUICtrlTreeView_SetItemParam ( $hTreeView ,  $hItem [ $x ],  $iParam ) 
    
    $iParam  +=  1 
        For  $y  =  $iYIndex  To  $iYIndex  +  2 
      
      $hItemChild [ $y ]  =  _GUICtrlTreeView_AddChild ( $hTreeView ,  $hItem [ $x ],  StringFormat ( "[%02d] New Item" ,  $y )) 
            _GUICtrlTreeView_SetItemParam ( $hTreeView ,  $hItemChild [ $y ],  $iParam ) 
    
        $iParam  +=  1 
        Next 
        $iYIndex  +=  3 
    Next 
    _GUICtrlTreeView_EndUpdate ( $hTreeView ) 

  
  $iRand  =  Random ( 0 ,  9 ,  1 ) 
  
  MsgBox ( 4160 ,  "Information" ,  StringFormat ( "Item Param 
for index %d: %s" ,  $iRand ,  _GUICtrlTreeView_GetItemParam ( $hTreeView ,  $hItem [ $iRand ]))) 
    $iRand  =  Random ( 0 ,  29 ,  1 ) 
    MsgBox ( 4160 ,  "Information" ,  StringFormat ( "Item Param 
for child index %d: %s" ,  $iRand ,  _GUICtrlTreeView_GetItemParam ( $hTreeView ,  $hItemChild [ $iRand ]))) 

  
  ; 循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 

