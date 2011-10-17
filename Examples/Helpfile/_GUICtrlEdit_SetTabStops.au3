
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 
6 
#include  <GuiEdit.au3> 
#include  <GuiStatusBar.au3> 
#include  <GuiConstantsEx.au3> 
#include  <WindowsConstants.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_Ed  =  False  ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 

_Main () 

Func _Main () 
    Local  $StatusBar ,  $hEdit ,  $hGUI 
    Local  $sFile  =  RegRead ( "HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt" ,  "InstallDir" )  &  "\include\changelog.txt" 
    Local  $aPartRightSide [ 3 ]  =  [ 190 ,  378 ,  - 1 ],  $aTabStops [ 3 ]  =  [ 10 ,  30 ,  50 ] 
    
    ; 创建界面 
    $hGUI  =  GUICreate ( "Edit Set Tab Stops" ,  400 ,  300 ) 
  
  $hEdit  =  GUICtrlCreateEdit ( "" ,  2 ,  2 ,  394 ,  268 ,  BitOR ( $ES_WANTRETURN ,  $WS_VSCROLL )) 
    $StatusBar  =  _GUICtrlStatusBar_Create ( $hGUI ,  $aPartRightSide ) 
  
  _GUICtrlStatusBar_SetIcon ( $StatusBar ,  2 ,  97 ,  "shell32.dll" ) 
    GUISetState () 

    ; 
设置边界 
    _GUICtrlEdit_SetMargins ( $hEdit ,  BitOR ( $EC_LEFTMARGIN ,  $EC_RIGHTMARGIN ),  10 ,  10 ) 

    ; 设置文本 
    _GUICtrlEdit_SetText ( $hEdit ,  @TAB  &  "1st"  &  @TAB  &  "2nd"  &  @TAB  &  "3rd" ) 

    MsgBox ( 4160 ,  "Information" ,  "Set Tab Stops" ) 
  
  ; 设置制表符 
  
  _GUICtrlEdit_SetTabStops ( $hEdit ,  $aTabStops ) 
    
    ; 循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 

