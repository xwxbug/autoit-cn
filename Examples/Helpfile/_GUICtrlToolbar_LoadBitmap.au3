
#include  <GuiToolbar.au3> 
#include  <GuiConstantsEx.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_TB  =  False  ; 检查传递给函数的类名, 
设置为真并使用另一控件的句柄观察其工作 

_Main () 

Func _Main () 
    Local  $hGUI ,  $hToolbar 
    Local  Enum  $idRed = 1000 ,  $idGreen ,  $idBlue 

    ; 创建界面 
    $hGUI  =  GUICreate ( "Toolbar" ,  400 ,  300 ) 
    $hToolbar  =  _GUICtrlToolbar_Create ( $hGUI ) 
    GUISetState () 

    ; 添加位图 
    _GUICtrlToolbar_LoadBitmap ( $hToolbar ,  @ScriptDir  &  "\images\Red.bmp" ) 
    _GUICtrlToolbar_LoadBitmap ( $hToolbar ,  @ScriptDir  &  "\Images\Green.bmp" ) 
    _GUICtrlToolbar_LoadBitmap ( $hToolbar ,  @ScriptDir  &  "\Images\Blue.bmp" ) 

    ; 添加按钮 
    _GUICtrlToolbar_AddButton ( $hToolbar ,  $idRed ,  0 ) 
    _GUICtrlToolbar_AddButton ( $hToolbar ,  $idGreen ,  1 ) 
    _GUICtrlToolbar_AddButton ( $hToolbar ,  $idBlue ,  2 ) 

    ; 循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 

EndFunc    ;==>_Main 

