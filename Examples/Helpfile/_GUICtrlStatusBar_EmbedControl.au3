
#include  <GuiConstantsEx.au3> 
#include  <GuiStatusBar.au3> 
#include  <ProgressConstants.au3> 
#include  <SendMessage.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_SB  =  False  ; 检查传递给函数的类名, 
设置为真并使用另一控件的句柄观察其工作 

_Main () 

Func _Main () 

    Local  $hGUI ,  $hProgress ,  $hInput ,  $input ,  $progress ,  $hStatus 
    Local  $aParts [ 4 ]  =  [ 80 ,  160 ,  300 ,  - 1 ] 
    
    ; 创建界面 
    $hGUI  =  GUICreate ( "StatusBar Embed 
Control" ,  400 ,  300 ) 

    ;=============================================================================== 
    ; 默认一个不带文本的部分 
    $hStatus  =  _GUICtrlStatusBar_Create  ( $hGUI ) 
    _GUICtrlStatusBar_SetMinHeight  ( $hStatus ,  20 ) 

    ;=============================================================================== 
    GUISetState () 

    ; 
初始部分 
    _GUICtrlStatusBar_SetParts  ( $hStatus ,  $aParts ) 
    _GUICtrlStatusBar_SetText  ( $hStatus ,  "Part 1" ) 
    _GUICtrlStatusBar_SetText  ( $hStatus ,  "Part 2" ,  1 ) 

    ; 嵌入一个进度条 
    If  @OSTYPE  =  "WIN32_WINDOWS"  Then 
        $progress  =  GUICtrlCreateProgress ( 0 ,  0 ,  - 1 ,  - 1 ,  $PBS_SMOOTH ) 
  
      $hProgress  =  GUICtrlGetHandle ( $progress ) 
    
    _GUICtrlStatusBar_EmbedControl  ( $hStatus ,  2 ,  $hProgress ) 
    Else 
        $progress  =  GUICtrlCreateProgress ( 0 ,  0 ,  - 1 ,  - 1 ,  $PBS_MARQUEE )  ; 该样式需要WinXP以上系统支持 
        $hProgress  =  GUICtrlGetHandle ( $progress ) 
    
    _GUICtrlStatusBar_EmbedControl  ( $hStatus ,  2 ,  $hProgress ) 
        _SendMessage ( $hProgress ,  $PBM_SETMARQUEE ,  True ,  200 )  ; 该样式需要WinXP以上系统支持 
    EndIf 
    
    $input  =  GUICtrlCreateInput ( "This is 
Embeded" ,  0 ,  0 ) 
    $hInput  =  GUICtrlGetHandle ( $input ) 
    _GUICtrlStatusBar_EmbedControl  ( $hStatus ,  3 ,  $hInput ,  3 ) 

    ; 
循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 


