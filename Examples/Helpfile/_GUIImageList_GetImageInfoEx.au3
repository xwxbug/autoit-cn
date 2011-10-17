
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 
6 
#include  <GuiConstantsEx.au3> 
#include  <WinAPI.au3> 
#include  <GuiImageList.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

Global  $iMemo 

_Main () 

Func _Main () 
    Local  $hImage ,  $hGUI ,  $hDC ,  $tInfo 
    
    $hGUI  =  GUICreate ( "ImageList Get 
Icon InfoEx" ,  400 ,  300 ) 
    $iMemo  =  GUICtrlCreateEdit ( "" ,  2 ,  32 ,  396 ,  266 ,  0 ) 
    GUICtrlSetFont ( $iMemo ,  9 ,  400 ,  0 ,  "Courier New" ) 
  
  GUISetState () 
    
    ; 加载图像 
    $hImage  =  _GUIImageList_Create ( 32 ,  24 ) 
  
  _GUIImageList_Add ( $hImage ,  _WinAPI_CreateSolidBitmap ( $hGUI ,  0xFF0000 ,  32 ,  24 )) 
  
  _GUIImageList_Add ( $hImage ,  _WinAPI_CreateSolidBitmap ( $hGUI ,  0x00FF00 ,  32 ,  24 )) 
  
  _GUIImageList_Add ( $hImage ,  _WinAPI_CreateSolidBitmap ( $hGUI ,  0x0000FF ,  32 ,  24 )) 

    ; 绘制图像 
    $hDC  =  _WinAPI_GetDC ( $hGUI ) 
    _GUIImageList_Draw ( $hImage ,  0 ,  $hDC ,  4 ,  4 ) 
    _GUIImageList_Draw ( $hImage ,  1 ,  $hDC ,  40 ,  4 ) 
    _GUIImageList_Draw ( $hImage ,  2 ,  $hDC ,  76 ,  4 ) 

    _WinAPI_ReleaseDC ( $hGUI ,  $hDC ) 

    ; 显示第二个图像的信息 
    $tInfo  =  _GUIImageList_GetImageInfoEx ( $hImage ,  1 ) 
    
MemoWrite ( "Image handle .: 
0x"  &  Hex ( DllStructGetData ( $tInfo ,  "hBitmap" ))) 
  
  MemoWrite ( "Mask handle ..: 
"  &  DllStructGetData ( $tInfo ,  "hMask" )) 
    
MemoWrite ( "Image Left ...: 
"  &  DllStructGetData ( $tInfo ,  "Left" )) 
    
MemoWrite ( "Image Top ....: 
"  &  DllStructGetData ( $tInfo ,  "Top" )) 
    
MemoWrite ( "Image Right ..: 
"  &  DllStructGetData ( $tInfo ,  "Right" )) 
    
MemoWrite ( "Image Bottom .: 
"  &  DllStructGetData ( $tInfo ,  "Bottom" )) 

  
  ; 循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 

; 向memo控件写入一行 
Func MemoWrite ( $sMessage ) 
    GUICtrlSetData ( $iMemo ,  $sMessage  &  @CRLF ,  1 ) 
EndFunc    ;==>MemoWrite 

