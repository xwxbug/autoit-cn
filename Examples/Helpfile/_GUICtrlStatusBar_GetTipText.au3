
#include  <GuiConstantsEx.au3> 
#include  <GuiStatusBar.au3> 
#include  <WinAPI.au3> 
#include  <WindowsConstants.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_SB  =  False  ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 

Global  $iMemo 

示例1 () 
示例2 () 

Func 示例1 () 

    Local  $hGUI ,  $hIcon ,  $hStatus 
    Local  $aParts [ 4 ]  =  [ 75 ,  150 ,  300 ,  400 ] 
  
  
    ; 
创建界面 
    $hGUI  =  GUICreate ( "(示例 1) StatusBar Tip Text" ,  400 ,  300 ) 
  
  $hStatus  =  _GUICtrlStatusBar_Create  ( $hGUI ,  - 1 ,  "" ,  $SBARS_TOOLTIPS ) 
  
  
    ; 
创建memo控件 
    $iMemo  =  GUICtrlCreateEdit ( "" ,  2 ,  2 ,  396 ,  274 ,  $WS_VSCROLL ) 
    GUICtrlSetFont ( $iMemo ,  9 ,  400 ,  0 ,  "Courier New" ) 
    GUISetState () 

    ; 
设置部分 
    _GUICtrlStatusBar_SetParts  ( $hStatus ,  $aParts ) 
    _GUICtrlStatusBar_SetText  ( $hStatus ,  "Force tip to be shown when text is more than 
fits in the box" ,  1 ) 

    ; 设置图标 
    $hIcon  =  _WinAPI_LoadShell32Icon  ( 23 ) 
    _GUICtrlStatusBar_SetIcon  ( $hStatus ,  0 ,  $hIcon ) 

    ; 设置文本提示 
    _GUICtrlStatusBar_SetTipText  ( $hStatus ,  0 ,  "Tip works when only icon in part or text exceeds 
part" ) 
    _GUICtrlStatusBar_SetTipText  ( $hStatus ,  1 ,  "Force tip to be shown when text is more than fits in the 
box" ) 

    
MemoWrite ( "Hold Mouse Cursor over 
part to see tip."  &  @CRLF ) 

    ; 显示文本提示 
    MemoWrite ( "Text tip 1 .: "  &  _GUICtrlStatusBar_GetTipText  ( $hStatus ,  0 )  &  @CRLF ) 
    
MemoWrite ( "Text tip 2 .: 
"  &  _GUICtrlStatusBar_GetTipText  ( $hStatus ,  1 )) 

    ; 
循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    ; Free icons 
    _WinAPI_DestroyIcon  ( $hIcon ) 
    GUIDelete () 
EndFunc    ;==>示例1 

Func 示例2 () 

    Local  $hGUI ,  $hStatus 
    Local  $aParts [ 4 ]  =  [ 75 ,  150 ,  300 ,  400 ] 
    
    ; 
创建界面 
    $hGUI  =  GUICreate ( "(示例 2) StatusBar Tip Text" ,  400 ,  300 ) 
  
  $hStatus  =  _GUICtrlStatusBar_Create  ( $hGUI ,  - 1 ,  "" ,  $SBARS_TOOLTIPS ) 
  
  
    ; 
创建memo控件 
    $iMemo  =  GUICtrlCreateEdit ( "" ,  2 ,  2 ,  396 ,  274 ,  $WS_VSCROLL ) 
    GUICtrlSetFont ( $iMemo ,  9 ,  400 ,  0 ,  "Courier New" ) 
    GUISetState () 

    ; 
设置部分 
    _GUICtrlStatusBar_SetParts  ( $hStatus ,  $aParts ) 
    _GUICtrlStatusBar_SetText  ( $hStatus ,  "Force tip to be shown when text is more than 
fits in the box" ,  1 ) 

    ; 设置图标 
    _GUICtrlStatusBar_SetIcon  ( $hStatus ,  0 ,  23 ,  "shell32.dll" ) 

    ; 设置文本提示 
    _GUICtrlStatusBar_SetTipText  ( $hStatus ,  0 ,  "Tip works when only icon in part or text exceeds 
part" ) 
    _GUICtrlStatusBar_SetTipText  ( $hStatus ,  1 ,  "Force tip to be shown when text is more than fits in the 
box" ) 

    
MemoWrite ( "Hold Mouse Cursor over 
part to see tip."  &  @CRLF ) 

    ; 显示文本提示 
    MemoWrite ( "Text tip 1 .: "  &  _GUICtrlStatusBar_GetTipText  ( $hStatus ,  0 )  &  @CRLF ) 
    
MemoWrite ( "Text tip 2 .: 
"  &  _GUICtrlStatusBar_GetTipText  ( $hStatus ,  1 )) 

    ; 
循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>示例2 

; 
向memo控件写入信息 
Func MemoWrite ( $sMessage  =  "" ) 
    GUICtrlSetData ( $iMemo ,  $sMessage  &  @CRLF ,  1 ) 
EndFunc    ;==>MemoWrite 


