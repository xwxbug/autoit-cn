
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 
6 
#include  <GuiConstantsEx.au3> 
#include  <GuiTreeView.au3> 
#include  <GuiImageList.au3> 
#include  <WindowsConstants.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_TV  =  False  ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 

Global  $hImage ,  $hStateImage 

_Main () 

Func _Main () 

    Local  $hItem [ 10 ],  $hChildItem [ 30 ],  $iYItem  =  0 ,  $iRand ,  $hTreeView 
    Local  $iStyle  =  BitOR ( $TVS_EDITLABELS ,  $TVS_HASBUTTONS ,  $TVS_HASLINES ,  $TVS_LINESATROOT ,  $TVS_DISABLEDRAGDROP ,  $TVS_SHOWSELALWAYS ) 

    GUICreate ( "TreeView Is 
First Item" ,  400 ,  300 ) 

    $hTreeView  =  GUICtrlCreateTreeView ( 2 ,  2 ,  396 ,  268 ,  $iStyle ,  $WS_EX_CLIENTEDGE ) 
    _GUICtrlTreeView_SetUnicodeFormat ( $hTreeView ,  False ) 
    GUISetState () 

    _CreateNormalImageList () 
    _GUICtrlTreeView_SetNormalImageList ( $hTreeView ,  $hImage ) 

  
  _CreateStateImageList () 
    _GUICtrlTreeView_SetStateImageList ( $hTreeView ,  $hStateImage ) 

  
  _GUICtrlTreeView_BeginUpdate ( $hTreeView ) 
    For  $x  =  0  To  9 
        $hItem [ $x ]  =  _GUICtrlTreeView_Add ( $hTreeView ,  0 ,  StringFormat ( "[%02d] New 
Item" ,  $x ),  4 ,  5 ) 
      
  _GUICtrlTreeView_SetStateImageIndex ( $hTreeView ,  $hItem [ $x ],  1 ) 
      
  For  $y  =  1  To  3 
            $hChildItem [ $iYItem ]  =  _GUICtrlTreeView_AddChild ( $hTreeView ,  $hItem [ $x ],  StringFormat ( "[%02d] New Child" ,  $iYItem ),  0 ,  3 ) 
            _GUICtrlTreeView_SetStateImageIndex ( $hTreeView ,  $hChildItem [ $iYItem ],  1 ) 
      
      $iYItem  +=  1 
        Next 
    Next 
    _GUICtrlTreeView_EndUpdate ( $hTreeView ) 

  
  $iRand  =  Random ( 0 ,  9 ,  1 ) 
  
  MsgBox ( 4160 ,  "Information" ,  StringFormat ( "Is Index %d 
First Item? %s" ,  $iRand ,  _GUICtrlTreeView_IsFirstItem ( $hTreeView ,  $hItem [ $iRand ]))) 

    ; 
循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 

Func _CreateNormalImageList () 
  
  $hImage  =  _GUIImageList_Create ( 16 ,  16 ,  5 ,  3 ) 
    _GUIImageList_AddIcon ( $hImage ,  "shell32.dll" ,  110 ) 
    _GUIImageList_AddIcon ( $hImage ,  "shell32.dll" ,  131 ) 
    _GUIImageList_AddIcon ( $hImage ,  "shell32.dll" ,  165 ) 
    _GUIImageList_AddIcon ( $hImage ,  "shell32.dll" ,  168 ) 
    _GUIImageList_AddIcon ( $hImage ,  "shell32.dll" ,  137 ) 
    _GUIImageList_AddIcon ( $hImage ,  "shell32.dll" ,  146 ) 
EndFunc    ;==>_CreateNormalImageList 

Func _CreateStateImageList () 
    $hStateImage  =  _GUIImageList_Create ( 16 ,  16 ,  5 ,  3 ) 
  
  _GUIImageList_AddIcon ( $hStateImage ,  "shell32.dll" ,  3 ) 
    _GUIImageList_AddIcon ( $hStateImage ,  "shell32.dll" ,  4 ) 
EndFunc    ;==>_CreateStateImageList 

