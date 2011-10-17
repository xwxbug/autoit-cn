
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 
6 
#include  <GuiConstantsEx.au3> 
#include  <WindowsConstants.au3> 
#include  <GuiSlider.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_S  =  False  ; 检查传递给函数的类名, 
设置为真并使用另一控件的句柄观察其工作 

Global  $iMemo 

_Main () 

Func _Main () 
    Local  $hSlider ,  $aTics 

    ; 创建界面 
    GUICreate ( "Slider Get 
Logical Tic Positions" ,  400 ,  296 ) 
    $hSlider  =  GUICtrlCreateSlider ( 2 ,  2 ,  300 ,  20 ,  BitOR ( $TBS_TOOLTIPS ,  $TBS_AUTOTICKS )) 
  
  $iMemo  =  GUICtrlCreateEdit ( "" ,  2 ,  32 ,  396 ,  266 ,  $WS_VSCROLL ) 
  
  GUICtrlSetFont ( $iMemo ,  9 ,  400 ,  0 ,  "Courier New" ) 
  
  GUISetState () 

    $aTics  = _GUICtrlSlider_GetLogicalTics ( $hSlider ) 
    
MemoWrite ( "Number Tics Excluding 1st 
and last .....: "  &  UBound ( $aTics )) 
    For  $x  =  0  To  UBound ( $aTics )  -  1 
        
MemoWrite ( StringFormat ( "(%02d) Logical Tick Position .............: 
%d" ,  $x ,  $aTics [ $x ])) 
    Next 

    ; 
循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 

; 向memo控件写入文本 
Func MemoWrite ( $sMessage ) 
    GUICtrlSetData ( $iMemo ,  $sMessage  &  @CRLF ,  1 ) 
EndFunc    ;==>MemoWrite 

