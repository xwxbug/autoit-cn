
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 
6 
#include  <GuiEdit.au3> 
#include  <GuiConstantsEx.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_Ed  =  False  ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 

_Main () 

Func _Main () 
    Local  $hEdit 

    ; 创建界面 
    GUICreate ( "Edit Set Limit 
Text" ,  400 ,  300 ) 
    $hEdit  =  GUICtrlCreateEdit ( "This is 
a test"  &  @CRLF  &  "Another 
Line" ,  2 ,  2 ,  394 ,  268 ) 
    GUISetState () 

    MsgBox ( 4160 ,  "Information" ,  "Text Limit: "  &  _GUICtrlEdit_GetLimitText ( $hEdit )) 

  
  MsgBox ( 4160 ,  "Information" ,  "Setting Text Limit" ) 
    _GUICtrlEdit_SetLimitText ( $hEdit ,  64000 ) 

    MsgBox ( 4160 ,  "Information" ,  "Text Limit: "  &  _GUICtrlEdit_GetLimitText ( $hEdit )) 

  
  ; 循环至用户退出 
    Do 
  
  Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 

