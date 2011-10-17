
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 
6 
#include  <GUIListBox.au3> 
#include  <GuiConstantsEx.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_LB  =  False  ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 

; 
该函数不被用于由建立函数创建的项目 
; 
项目数据是每个字符串的ControlID 

_Main () 

Func _Main () 
    Local  $hListBox 

    ; 创建界面 
    GUICreate ( "List Box Get/Set 
Item Data" ,  400 ,  296 ) 
    $hListBox  =  GUICtrlCreateList ( "" ,  2 ,  2 ,  396 ,  296 ) 
    GUISetState () 

    ; 添加字符串 
    _GUICtrlListBox_BeginUpdate ( $hListBox ) 
    For  $iI  =  1  To  9 
        _GUICtrlListBox_AddString ( $hListBox ,  StringFormat ( "%03d : Random 
string" ,  Random ( 1 ,  100 ,  1 ))) 
    Next 
    _GUICtrlListBox_EndUpdate ( $hListBox ) 

  
  ; 设置项目数据 
    _GUICtrlListBox_SetItemData ( $hListBox ,  4 ,  1234 ) 

    ; 获取项目数据 
    MsgBox ( 4160 ,  "Information" ,  "Item 5 Data: "  &  _GUICtrlListBox_GetItemData ( $hListBox ,  4 )) 

    ; 循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 

