
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 
6 
#include  <GuiConstantsEx.au3> 
#include  <GuiTreeView.au3> 
#include  <GuiImageList.au3> 
#include  <WindowsConstants.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_TV  =  False  ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 

_Main () 

Func _Main () 

    Local  $hItem [ 6 ],  $hImage ,  $tRect ,  $hTreeView 
    Local  $iStyle  =  BitOR ( $TVS_EDITLABELS ,  $TVS_HASBUTTONS ,  $TVS_HASLINES ,  $TVS_LINESATROOT ,  $TVS_DISABLEDRAGDROP ,  $TVS_SHOWSELALWAYS ,  $TVS_CHECKBOXES ) 
    
    GUICreate ( "TreeView End Edit" ,  400 ,  300 ) 

    $hTreeView  =  GUICtrlCreateTreeView ( 2 ,  2 ,  396 ,  268 ,  $iStyle ,  $WS_EX_CLIENTEDGE ) 
    ; 
关闭unicode，dllstruct此时不支持 
    _GUICtrlTreeView_SetUnicodeFormat ( $hTreeView ,  False ) 
    GUISetState () 

    $hImage  =  _GUIImageList_Create ( 16 ,  16 ,  5 ,  3 ) 
  
  _GUIImageList_AddIcon ( $hImage ,  "shell32.dll" ,  110 ) 
    _GUIImageList_AddIcon ( $hImage ,  "shell32.dll" ,  131 ) 
    _GUIImageList_AddIcon ( $hImage ,  "shell32.dll" ,  165 ) 
    _GUIImageList_AddIcon ( $hImage ,  "shell32.dll" ,  168 ) 
    _GUIImageList_AddIcon ( $hImage ,  "shell32.dll" ,  137 ) 
    _GUIImageList_AddIcon ( $hImage ,  "shell32.dll" ,  146 ) 
    _GUICtrlTreeView_SetNormalImageList ( $hTreeView ,  $hImage ) 

  
  For  $x  =  0  To  _GUIImageList_GetImageCount ( $hImage )  -  1 
        $hItem [ $x ]  =  _GUICtrlTreeView_Add ( $hTreeView ,  0 ,  StringFormat ( "[%02d] New 
Item" ,  $x  +  1 ),  $x ,  $x ) 
  
  Next 
    
    ; 
编辑项目0的标签 
    _GUICtrlTreeView_EditText ( $hTreeView ,  $hItem [ 0 ]) 
    Sleep ( 500 ) 
    Send ( "This is a 
test" ) 
    Sleep ( 500 ) 
    _GUICtrlTreeView_EndEdit ( $hTreeView ) 

  
  ; 循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 

