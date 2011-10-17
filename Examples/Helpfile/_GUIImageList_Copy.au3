 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GuiConstantsEx.au3> 
 #include <WinAPI.au3> 
 #include <GuiListView.au3> 
 #include <GuiImageList.au3> 
 #include <WindowsConstants.au3> 
 
 Opt ( 'MustDeclareVars' , 1 ) 
 
 _Main () 

Func _Main () 
     Local $listview , $hImage , $AutoItDir = RegRead ( "HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt" , "InstallDir" ) 
 
     GUICreate ( "ImageList Copy" , 410 , 300 ) 
     $listview = GUICtrlCreateListView ( "" , 2 , 2 , 404 , 268 , BitOR ( $LVS_SHOWSELALWAYS , $LVS_NOSORTHEADER , $LVS_REPORT )) 
     GUISetState () 
 
     ; 创建带图像的图像列表 
     $hImage = _GUIImageList_Create ( 11 , 11 ) 
     MsgBox ('', ' ImgLst ', _GUIImageList_AddIcon ( $hImage , $AutoItDir & "\Aut2Exe\Icons\apple.ico" ) & @CRLF & _ 
     _GUIImageList_AddIcon ( $hImage , $AutoItDir & "\Aut2Exe\Icons\cherry.ico" ) & @CRLF & _ 
     _GUIImageList_AddIcon ( $hImage , $AutoItDir & "\Aut2Exe\Icons\lemon.ico" ) & @CRLF & _ 
     _GUIImageList_AddIcon ( $hImage , $AutoItDir & "\Aut2Exe\Icons\plum.ico" )) 
     _GUIImageList_Copy ( $hImage , 0 , 3 ) 
     _GUICtrlListView_SetImageList ( $listview , $hImage , 1 ) 
 
     ; 添加列 
     _GUICtrlListView_AddColumn ( $listview , "Column 1" , 100 , 1 , 0 , True ) 
     _GUICtrlListView_AddColumn ( $listview , "Column 2" , 100 , 0 , 1 , True ) 
     _GUICtrlListView_AddColumn ( $listview , "Column 3" , 100 , 2 , 2 , True ) 
     _GUICtrlListView_AddColumn ( $listview , "Column 4" , 100 , 0 , 3 ) 
 
     ; 循环至用户退出 
     Do 
     Until GUIGetMsg () = $GUI_EVENT_CLOSE 
     GUIDelete () 
 EndFunc    ;==>_Main 

