
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 
6 
#include  <GuiConstantsEx.au3> 
#include  <GuiDateTimePicker.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_DTP  =  False  ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 

Global  $iMemo ,  $tRange 

_Main () 

Func _Main () 
    Local  $hDTP 

    ; 创建界面 
    GUICreate ( "DateTimePick Get 
RangeEx" ,  400 ,  300 ) 
    $hDTP  =  GUICtrlGetHandle ( GUICtrlCreateDate ( "" ,  2 ,  6 ,  190 )) 
    $iMemo  =  GUICtrlCreateEdit ( "" ,  2 ,  32 ,  396 ,  266 ,  0 ) 
    GUICtrlSetFont ( $iMemo ,  9 ,  400 ,  0 ,  "Courier New" ) 
  
  GUISetState () 

    ; 
设置显示格式 
    _GUICtrlDTP_SetFormat ( $hDTP ,  "ddd MMM dd, yyyy hh:mm ttt" ) 

    ; 设置日期范围 
    $tRange  =  DllStructCreate ( $tagDTPRANGE ) 
  
  DllStructSetData ( $tRange ,  "MinValid" ,  True ) 
    DllStructSetData ( $tRange ,  "MinYear" ,  @YEAR ) 
    DllStructSetData ( $tRange ,  "MinMonth" ,  1 ) 
    DllStructSetData ( $tRange ,  "MinDay" ,  1 ) 
    DllStructSetData ( $tRange ,  "MinHour" ,  0 ) 
    DllStructSetData ( $tRange ,  "MinMinute" ,  0 ) 
    DllStructSetData ( $tRange ,  "MinSecond" ,  1 ) 
    DllStructSetData ( $tRange ,  "MaxValid" ,  True ) 
    DllStructSetData ( $tRange ,  "MaxYear" ,  @YEAR ) 
    DllStructSetData ( $tRange ,  "MaxMonth" ,  12 ) 
    DllStructSetData ( $tRange ,  "MaxDay" ,  31 ) 
    DllStructSetData ( $tRange ,  "MaxHour" ,  12 ) 
    DllStructSetData ( $tRange ,  "MaxMinute" ,  59 ) 
    DllStructSetData ( $tRange ,  "MaxSecond" ,  59 ) 
    _GUICtrlDTP_SetRangeEx ( $hDTP ,  $tRange ) 

  
  ; 显示日期范围 
    $tRange  =  _GUICtrlDTP_GetRangeEx ( $hDTP ) 
    
MemoWrite ( "Minimum date: 
"  & GetDateStr ( "Min" )) 
    MemoWrite ( "Maximum date: "  & GetDateStr ( "Max" )) 
    MemoWrite ( "Minimum time: "  & GetTimeStr ( "Min" )) 
    MemoWrite ( "Maximum time: "  & GetTimeStr ( "Max" )) 

    ; 
循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 

; 返回日期部分 
Func GetDateStr ( $sPrefix ) 
    If  $sPrefix  =  "Min"  Then 
    
    Return  StringFormat ( "%02d/%02d/%04d" ,  DllStructGetData ( $tRange ,  "MinMonth" ),  DllStructGetData ( $tRange ,  "MinDay" ),  DllStructGetData ( $tRange ,  "MinYear" )) 
  
  Else 
      
  Return  StringFormat ( "%02d/%02d/%04d" ,  DllStructGetData ( $tRange ,  "MaxMonth" ),  DllStructGetData ( $tRange ,  "MaxDay" ),  DllStructGetData ( $tRange ,  "MaxYear" )) 
  
  EndIf 
EndFunc    ;==>GetDateStr 

; 返回时间部分 
Func GetTimeStr ( $sPrefix ) 
    If  $sPrefix  =  "Min"  Then 
    
    Return  StringFormat ( "%02d:%02d:%02d" ,  DllStructGetData ( $tRange ,  "MinHour" ),  DllStructGetData ( $tRange ,  "MinMinute" ),  DllStructGetData ( $tRange ,  "MinSecond" )) 
  
  Else 
      
  Return  StringFormat ( "%02d:%02d:%02d" ,  DllStructGetData ( $tRange ,  "MaxHour" ),  DllStructGetData ( $tRange ,  "MaxMinute" ),  DllStructGetData ( $tRange ,  "MaxSecond" )) 
  
  EndIf 
EndFunc    ;==>GetTimeStr 

; 
向memo控件写入一行 
Func MemoWrite ( $sMessage ) 
    GUICtrlSetData ( $iMemo ,  $sMessage  &  @CRLF ,  1 ) 
EndFunc    ;==>MemoWrite 

