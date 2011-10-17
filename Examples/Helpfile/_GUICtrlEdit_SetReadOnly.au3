 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GuiEdit.au3> 
 #include <GuiStatusBar.au3> 
 #include <GuiConstantsEx.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 $Debug_Ed = False ; 检查传递给Edit 函数的类名 , 设置为真并使用另一控件的句柄观察其工作 
 
 _Main() 
 
 Func _Main() 
   Local $StatusBar , $hEdit , $hGUI 
   Local $sFile = RegRead ( " HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt" , " InstallDir " ) & " \include\changelog.txt " 
   Local $aPartRightSide [ 4 ] = [ 120 , 248 , 378 , -1 ] 
 
   ; 创建界面 
   $hGUI = GUICreate ( " Edit Set Read Only ", 400 , 300 ) 
   $hEdit = GUICtrlCreateEdit ( "", 2 , 2 , 394 , 268 ) 
   $StatusBar = _GUICtrlStatusBar_Create ( $hGUI , $aPartRightSide ) 
   _GUICtrlStatusBar_SetIcon ( $StatusBar , 3 , 97 , " shell32.dll " ) 
   GUISetState () 
 
   ; 设置边界 
   _GUICtrlEdit_SetMargins ( $hEdit , BitOR ( $EC_LEFTMARGIN , $EC_RIGHTMARGIN ) , 10 , 10 ) 
 
   ; 添加文本 
   _GUICtrlEdit_SetText ( $hEdit , FileRead ( $sFile )) 
   _GUICtrlEdit_LineScroll ( $hEdit , 0 , _GUICtrlEdit_GetLineCount ( $hEdit ) * -1 ) 
 
   ; 获取修订标记 
   _GUICtrlStatusBar_SetText ( $StatusBar , " Modified: " & _GUICtrlEdit_GetModify ( $hEdit ) , 2 ) 
 
   ; 设置只读 
   _GUICtrlEdit_SetReadOnly ( $hEdit , True ) 
  
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc    ;==>_Main 
 
