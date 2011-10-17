
#include  <GuiConstantsEx.au3> 
#include  <Date.au3> 
#include  <WindowsConstants.au3> 

Global  $iMemo 

_Main () 

Func _Main () 
    Local  $hGUI ,  $aDate 

    ; 创建界面 
    $hGUI  =  GUICreate ( "Time" ,  400 ,  300 ) 
    $iMemo  =  GUICtrlCreateEdit ( "" ,  2 ,  2 ,  396 ,  296 ,  $WS_VSCROLL ) 
  
  GUICtrlSetFont ( $iMemo ,  9 ,  400 ,  0 ,  "Courier New" ) 
  
  GUISetState () 

    ; 
显示FAT日期/时间 
    $aDate  =  _Date_Time_DOSDateTimeToArray ( 0x3621 ,  0x944a )  ; 01/01/2007 18:34:20 
    MemoWrite ( "FAT date .: "  &  StringFormat ( "%02d/%02d/%04d" ,  $aDate [ 0 ],  $aDate [ 1 ],  $aDate [ 2 ])) 
    MemoWrite ( "FAT time .: "  &  StringFormat ( "%02d:%02d:%02d" ,  $aDate [ 3 ],  $aDate [ 4 ],  $aDate [ 5 ])) 

    ; 循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 

EndFunc    ;==>_Main 

; 写入memo控件 
 Func MemoWrite ( $sMessage ) 
    GUICtrlSetData ( $iMemo ,  $sMessage  &  @CRLF ,  1 ) 
EndFunc    ;==>MemoWrite 

