
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 
6 
#include  <GuiConstantsEx.au3> 
#include  <GuiTreeView.au3> 
#include  <WindowsConstants.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_TV  =  False  ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 

Global  $hImage ,  $hStateImage 

_Main () 

Func _Main () 

    Local  $hItem [ 10 ],  $hChildItem [ 30 ],  $iYItem  =  0 ,  $iX  =  9 ,  $iY  =  29 ,  $iRand ,  $hTreeView 
    Local  $iStyle  =  BitOR ( $TVS_EDITLABELS ,  $TVS_HASBUTTONS ,  $TVS_HASLINES ,  $TVS_LINESATROOT ,  $TVS_DISABLEDRAGDROP ,  $TVS_SHOWSELALWAYS ) 
    
    GUICreate ( "TreeView 
Sort" ,  400 ,  300 ) 
    
    $hTreeView  =  GUICtrlCreateTreeView ( 2 ,  2 ,  396 ,  268 ,  $iStyle ,  $WS_EX_CLIENTEDGE ) 
    _GUICtrlTreeView_SetUnicodeFormat ( $hTreeView ,  False ) 
    GUISetState () 

    _GUICtrlTreeView_BeginUpdate ( $hTreeView ) 
  
  For  $x  =  0  To  9 
        $iRand  =  Random ( 0 ,  5 ,  1 ) 
        $hItem [ $x ]  =  GUICtrlCreateTreeViewItem ( StringFormat ( "[%02d] New Item" ,  $iX ),  $hTreeView ) 
        $iX  -=  1 
        For  $y  =  1  To  3 
        
    $iRand  =  Random ( 0 ,  5 ,  1 ) 
  
          $hChildItem [ $iYItem ]  =  GUICtrlCreateTreeViewItem ( StringFormat ( "[%02d] New 
Child" ,  $iY ),  $hItem [ $x ]) 
            $iYItem  +=  1 
            $iY  -=  1 
      
  Next 
    Next 
    _GUICtrlTreeView_Expand ( $hTreeView ) 
  
  _GUICtrlTreeView_EndUpdate ( $hTreeView ) 

    MsgBox ( 4160 ,  "Information" ,  "Sort" ) 
    _GUICtrlTreeView_Sort ( $hTreeView ) 
  
  _GUICtrlTreeView_SelectItem ( $hTreeView ,  $hItem [ 9 ]) 

    ; 循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 

