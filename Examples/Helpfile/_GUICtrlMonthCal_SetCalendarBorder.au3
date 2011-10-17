
#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 
6 
#include  <GuiConstantsEx.au3> 
#include  <GuiMonthCal.au3> 
#include  <WindowsConstants.au3> 
#include  <Constants.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_MC  =  False  ; 检查传递给MonthCal函数的类名, 
设置为真并使用另一控件的句柄观察其工作 

Global  $iMemo 

_Main () 

Func _Main () 
    Local  $hMonthCal 

    ; 创建界面 
    GUICreate ( "Month 
Calendar" ,  400 ,  300 ) 
    $hMonthCal  =  GUICtrlCreateMonthCal ( "" ,  4 ,  4 ,  - 1 ,  - 1 ,  $WS_BORDER ,  0x00000000 ) 
    
    ; 创建memo控件 
    $iMemo  =  GUICtrlCreateEdit ( "" ,  4 ,  168 ,  392 ,  128 ,  0 ) 
    GUICtrlSetFont ( $iMemo ,  9 ,  400 ,  0 ,  "Courier New" ) 
  
  GUISetState () 

    ; 
获取/设置月历边界 
    MemoWrite ( "Border in pixels: "  &  _GUICtrlMonthCal_GetCalendarBorder ( $hMonthCal )) 
  
  Sleep ( 3000 ) 
    GUISetState ( @SW_LOCK ) 
    _GUICtrlMonthCal_SetCalendarBorder ( $hMonthCal ,  2 ) 
    MemoWrite ( "Border in pixels: "  &  _GUICtrlMonthCal_GetCalendarBorder ( $hMonthCal )) 
  
  GUISetState ( @SW_UNLOCK ) 
  
  Sleep ( 3000 ) 
    GUISetState ( @SW_LOCK ) 
    _GUICtrlMonthCal_SetCalendarBorder ( $hMonthCal ,  0 ,  False ) 
    MemoWrite ( "Border in pixels: "  &  _GUICtrlMonthCal_GetCalendarBorder ( $hMonthCal )) 
  
  GUISetState ( @SW_UNLOCK ) 
  
  

    ; 
循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 

; 向memo写入信息 
Func MemoWrite ( $sMessage ) 
    GUICtrlSetData ( $iMemo ,  $sMessage  &  @CRLF ,  1 ) 
EndFunc    ;==>MemoWrite 

