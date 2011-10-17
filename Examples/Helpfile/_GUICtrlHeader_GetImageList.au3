
#include  <GuiConstantsEx.au3> 
#include  <GuiHeader.au3> 
#include  <GuiImageList.au3> 
#include  <WinAPI.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_HDR  =  False  ; 检查传递给控件的类名, 
设置为真并使用另一控件句柄观察其工作 

Global  $iMemo 

_Main () 

Func _Main () 
    Local  $hGUI ,  $hHeader ,  $hImage 

    ; 创建界面 
    $hGUI  =  GUICreate ( "Header" ,  400 ,  300 ) 
    $hHeader  =  _GUICtrlHeader_Create  ( $hGUI ) 
    $iMemo  =  GUICtrlCreateEdit ( "" ,  2 ,  24 ,  396 ,  274 ,  0 ) 
    GUICtrlSetFont ( $iMemo ,  9 ,  400 ,  0 ,  "Courier New" ) 
  
  GUISetState () 

    ; 
创建带图像的图像列 
    $hImage  =  _GUIImageList_Create  ( 11 ,  11 ) 
    _GUIImageList_Add  ( $hImage ,  _WinAPI_CreateSolidBitmap  ( $hGUI ,  0xFF0000 ,  11 ,  11 )) 
    _GUIImageList_Add  ( $hImage ,  _WinAPI_CreateSolidBitmap  ( $hGUI ,  0x00FF00 ,  11 ,  11 )) 
    _GUIImageList_Add  ( $hImage ,  _WinAPI_CreateSolidBitmap  ( $hGUI ,  0x0000FF ,  11 ,  11 )) 
    _GUICtrlHeader_SetImageList  ( $hHeader ,  $hImage ) 

    ; 
添加列 
    _GUICtrlHeader_AddItem  ( $hHeader ,  "Column 1" ,  100 ,  0 ,  0 ) 
  
  _GUICtrlHeader_AddItem  ( $hHeader ,  "Column 2" ,  100 ,  0 ,  1 ) 
    _GUICtrlHeader_AddItem  ( $hHeader ,  "Column 3" ,  100 ,  0 ,  2 ) 
  
  _GUICtrlHeader_AddItem  ( $hHeader ,  "Column 4" ,  100 ) 

    ; 显示表头信息 
    
MemoWrite ( "Image list handle ....: 
"  &  "0x"  &  Hex ( _GUICtrlHeader_GetImageList  ( $hHeader ))) 

    ; 
循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
EndFunc    ;==>_Main 

; 向memo控件写入一行 
Func MemoWrite ( $sMessage ) 
    GUICtrlSetData ( $iMemo ,  $sMessage  &  @CRLF ,  1 ) 
EndFunc    ;==>MemoWrite 

