 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GuiConstantsEx.au3> 
 #include <GuiTab.au3> 
 #include <WinAPI.au3> 
 #include <GuiImageList.au3> 
 #include <WindowsConstants.au3> 
 
 Opt (' MustDeclareVars ' , 1 ) 
 
 $Debug_TAB = False ; 检查传递给函数的类名 , 设置为真并使用另一控件句柄观察其工作 
 
 Global $iMemo 
 
 _Main() 
 
 Func _Main () 
   Local $aItem , $hTab , $hImage , $tab0 
 
   ; 创建界面 
   GUICreate ( " Tab Control Get Item ", 400 , 300 ) 
   $hTab = GUICtrlCreateTab ( 2 , 2 , 396 , 296 ) 
   GUISetState () 
 
   ; 创建图像 
   $hImage = _GUIImageList_Create ( 16 , 16 , 5 , 3 ) 
   _GUIImageList_AddIcon ( $hImage , @SystemDir & " \shell32.dll ", 110 ) 
   _GUIImageList_AddIcon ( $hImage , @SystemDir & " \shell32.dll ", 131 ) 
   _GUIImageList_AddIcon ( $hImage , @SystemDir & " \shell32.dll ", 165 ) 
   _GUIImageList_AddIcon ( $hImage , @SystemDir & " \shell32.dll ", 168 ) 
   _GUIImageList_AddIcon ( $hImage , @SystemDir & " \shell32.dll ", 137 ) 
   _GUIImageList_AddIcon ( $hImage , @SystemDir & " \shell32.dll ", 146 ) 
   _GUICtrlTab_SetImageList ( $hTab , $hImage ) 
 
   ; 添加标签页 
   $tab0 = GUICtrlCreateTabItem ( " Tab 0 " ) 
   $iMemo = GUICtrlCreateEdit ( "", 4 , 28 , 390 , 265 ) 
   GUICtrlSetFont ( $iMemo , 9 , 400 , 0 , "Courier New" ) 
   GUICtrlCreateTabItem ( "" ) 
   GUICtrlCreateTabItem ( " Tab 1 " ) 
   GUICtrlCreateTabItem ( "" ) 
   GUICtrlCreateTabItem ( " Tab 2 " ) 
   GUICtrlCreateTabItem ( "" ) 
   GUICtrlSetState ( $tab0 , $GUI_SHOW ) 
 
   ; 获取标签 0 
   _GUICtrlTab_SetItem ( $hTab , 0 , " New Text ", BitOR ( $TCIS_BUTTONPRESSED , $TCIS_BUTTONPRESSED ) , 2 ) 
   _GUICtrlTab_SetItem ( $hTab , 1 , -1 , -1 , 4 ) 
   _GUICtrlTab_SetItem ( $hTab , 2 , -1 , -1 , 5 ) 
   GUISetState ( @SW_LOCK ) 
   For $x = 0  To 2 
     $aItem = _GUICtrlTab_GetItem ( $hTab , $x ) 
     MemoWrite( " Tab Item " & $x & @CRLF & " --------------------- " ) 
     For $y = 0  To 3 
       MemoWrite( " $aItem[ " & $y & " ]:  " & $aItem [ $y ]) 
     Next 
     MemoWrite( @CRLF & " --------------------- " ) 
   Next 
   GUISetState ( @SW_UNLOCK ) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc    ;==>_Main 
 
 ; 写入memo控件 
 Func MemoWrite ( $sMessage ) 
   GUICtrlSetData ( $iMemo , $sMessage & @CRLF , 1 ) 
 EndFunc ;==>MemoWrite 
 
