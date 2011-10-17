
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 
6 
#include  <GuiConstantsEx.au3> 
#include  <GuiSlider.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_S  =  False  ; 检查传递给函数的类名, 
设置为真并使用另一控件的句柄观察其工作 

_Main () 

Func _Main () 
    Local  $hSlider 

    ; 创建界面 
    GUICreate ( "Slider Get/Set Thumb 
Length" ,  400 ,  296 ) 
    $hSlider  =  GUICtrlCreateSlider ( 2 ,  2 ,  396 ,  25 ,  BitOR ( $TBS_TOOLTIPS ,  $TBS_AUTOTICKS ,  $TBS_FIXEDLENGTH )) 
    GUISetState () 

    ; 
获取滑动条长度 
    MsgBox ( 4160 ,  "Information" ,  "Thumb Length: 
"  &  _GUICtrlSlider_GetThumbLength ( $hSlider )) 

    ; 
设置滑动条长度 
    _GUICtrlSlider_SetThumbLength ( $hSlider ,  10 ) 

    ; 获取滑动条长度 
    MsgBox ( 4160 ,  "Information" ,  "Thumb Length: "  &  _GUICtrlSlider_GetThumbLength ( $hSlider )) 

  
  ; 循环至用户退出 
    Do 
  
  Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 

