
#include  <GuiToolbar.au3> 
#include  <GuiConstantsEx.au3> 
#include  <WindowsConstants.au3> 
#include  <Constants.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_TB  =  False  ; 检查传递给函数的类名, 
设置为真并使用另一控件的句柄观察其工作 
Global  $iMemo 

_Main () 

Func _Main () 
    Local  $hGUI ,  $hToolbar ,  $fUnicode 
    Local  Enum  $idNew  =  1000 ,  $idOpen ,  $idSave ,  $idHelp 

    ; 创建界面 
    $hGUI  =  GUICreate ( "Toolbar" ,  400 ,  300 ) 
    $hToolbar  =  _GUICtrlToolbar_Create ( $hGUI ) 
    $iMemo  =  GUICtrlCreateEdit ( "" ,  2 ,  36 ,  396 ,  262 ,  $WS_VSCROLL ) 
  
  GUICtrlSetFont ( $iMemo ,  10 ,  400 ,  0 ,  "Courier New" ) 
  
  GUISetState () 

    ; 
添加标准系统位图 
    Switch  _GUICtrlToolbar_GetBitmapFlags ( $hToolbar ) 
    
    Case  0 
            _GUICtrlToolbar_AddBitmap ( $hToolbar ,  1 ,  - 1 ,  $IDB_STD_SMALL_COLOR ) 
        Case  2 
      
      _GUICtrlToolbar_AddBitmap ( $hToolbar ,  1 ,  - 1 ,  $IDB_STD_LARGE_COLOR ) 
    EndSwitch 

    ; 添加按钮 
    _GUICtrlToolbar_AddButton ( $hToolbar ,  $idNew ,  $STD_FILENEW ) 
  
  _GUICtrlToolbar_AddButton ( $hToolbar ,  $idOpen ,  $STD_FILEOPEN ) 
    _GUICtrlToolbar_AddButton ( $hToolbar ,  $idSave ,  $STD_FILESAVE ) 
  
  _GUICtrlToolbar_AddButtonSep ( $hToolbar ) 
    _GUICtrlToolbar_AddButton ( $hToolbar ,  $idHelp ,  $STD_HELP ) 

  
  ; 显示Unicode格式 
  
  $fUnicode  =  _GUICtrlToolbar_GetUnicodeFormat ( $hToolbar ) 
    
MemoWrite ( "Unicode format 
.:"  &  $fUnicode ) 

    ; 改变Unicode格式 
    _GUICtrlToolbar_SetUnicodeFormat ( $hToolbar ,  Not  $fUnicode ) 
    MemoWrite ( "Unicode format .:"  &  _GUICtrlToolbar_GetUnicodeFormat ( $hToolbar )) 

  
  ; 循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 

EndFunc    ;==>_Main 

; 向memo控件写入信息 
Func MemoWrite ( $sMessage  =  "" ) 
    GUICtrlSetData ( $iMemo ,  $sMessage  &  @CRLF ,  1 ) 
EndFunc    ;==>MemoWrite 

