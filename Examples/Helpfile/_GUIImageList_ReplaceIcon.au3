
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 
6 
#include  <GuiConstantsEx.au3> 
#include  <WinAPI.au3> 
#include  <GuiListView.au3> 
#include  <GuiImageList.au3> 
#include  <WindowsConstants.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

_Main () 

Func _Main () 
    Local  $listview ,  $hImage ,  $AutoItDir  =  RegRead ( "HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt" ,  "InstallDir" ) 
    
    GUICreate ( "ImageList AddIcon" ,  410 ,  300 ) 
    $listview  =  GUICtrlCreateListView ( "" ,  2 ,  2 ,  404 ,  268 ,  BitOR ( $LVS_SHOWSELALWAYS ,  $LVS_NOSORTHEADER ,  $LVS_REPORT )) 
    GUISetState () 

  
  ; 创建带图像的图像列表 
    $hImage  =  _GUIImageList_Create ( 11 ,  11 ) 
    
AddIcon ( $hImage ,  $AutoItDir  &  "\Icons\filetype1.ico" ) 
    AddIcon ( $hImage ,  $AutoItDir  &  "\Icons\filetype2.ico" ) 
    AddIcon ( $hImage ,  $AutoItDir  &  "\Icons\filetype3.ico" ) 
    _GUICtrlListView_SetImageList ( $listview ,  $hImage ,  1 ) 

    ; 添加项目 
    _GUICtrlListView_AddColumn ( $listview ,  "Column 1" ,  100 ,  0 ,  0 ) 
    _GUICtrlListView_AddColumn ( $listview ,  "Column 2" ,  100 ,  1 ,  1 ) 
  
  _GUICtrlListView_AddColumn ( $listview ,  "Column 3" ,  100 ,  2 ,  2 ) 
  
  _GUICtrlListView_AddColumn ( $listview ,  "Column 4" ,  100 ) 

    ; 循环至用户退出 
    Do 
  
  Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 

; 使用此方法添加图标需要较长时间. 
使用_GUIImageList_AddIcon代替 
Func AddIcon ( $hWnd ,  $sFile ,  $iIndex  =  0 ) 
    Local  $pIcon ,  $tIcon ,  $hIcon 

    $tIcon  =  DllStructCreate ( "int Icon" ) 
    $pIcon  =  DllStructGetPtr ( $tIcon ) 
    _WinAPI_ExtractIconEx ( $sFile ,  $iIndex ,  0 ,  $pIcon ,  1 ) 
  
  $hIcon  =  DllStructGetData ( $tIcon ,  "Icon" ) 
    _GUIImageList_ReplaceIcon ( $hWnd ,  - 1 ,  $hIcon ) 
    _WinAPI_DestroyIcon ( $hIcon ) 
EndFunc    ;==>AddIcon 

