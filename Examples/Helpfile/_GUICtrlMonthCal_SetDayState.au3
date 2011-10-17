
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 
6 
#include  <GuiConstantsEx.au3> 
#include  <GuiMonthCal.au3> 
#include  <WindowsConstants.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_MC  =  False  ; 检查传递给MonthCal函数的类名, 设置为真并使用另一控件的句柄观察其工作 

_Main () 

Func _Main () 
    Local  $hMonthCal 

    ; 创建界面 
    GUICreate ( "Month Calendar 
Set Day State" ,  400 ,  300 ) 
    $hMonthCal  =  GUICtrlCreateMonthCal ( "" ,  4 ,  4 ,  - 1 ,  - 1 ,  BitOR ( $WS_BORDER ,  $MCS_DAYSTATE ),  0x00000000 ) 

    ; 
获取支持掩码的月份的数字. 通常, 该数字为3. 
    Local  $aMasks [ _GUICtrlMonthCal_GetMonthRangeSpan ( $hMonthCal ,  True )] 

    ; 粗体化当前月的1号, 8号和16号. 该结果使用1000 0000 
1000 0001的二进制掩码或十六进制的0x8081. 
    $aMasks [ 1 ]  =  0x8081 
    _GUICtrlMonthCal_SetDayState ( $hMonthCal ,  $aMasks ) 

  
  GUISetState () 

    ; 
循环至用户瑞出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 

