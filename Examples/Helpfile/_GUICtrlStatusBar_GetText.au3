 #include <GuiConstantsEx.au3> 
 #include <GuiStatusBar.au3> 
 #include <WinAPI.au3> 
 #include <WindowsConstants.au3> 
 
 Opt ( 'MustDeclareVars' , 1 ) 
 
 $Debug_SB = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 
 
 Global $iMemo 
 
 Example1 () 
 Example2 () 
 
 Func Example1 () 
 
   Local $hGUI , $hIcons [ 2 ], $hStatus 
   Local $aParts [ 4 ] = [ 75 , 150 , 300 , 400 ] 
   
   ; 创建界面 
   $hGUI = GUICreate ( "(Example 1) StatusBar Get Text" , 400 , 300 ) 
   $hStatus = _GUICtrlStatusBar_Create ( $hGUI ) 
   
   ; 创建memo控件 
   $iMemo = GUICtrlCreateEdit ( "" , 2 , 2 , 396 , 274 , $WS_VSCROLL ) 
   GUICtrlSetFont ( $iMemo , 9 , 400 , 0 , "Courier New" ) 
   GUISetState () 
 
   ; 设置部分 
   _GUICtrlStatusBar_SetParts ( $hStatus , $aParts ) 
   _GUICtrlStatusBar_SetText ( $hStatus , "Part 1" ) 
   _GUICtrlStatusBar_SetText ( $hStatus , "Part 2" , 1 ) 
 
   ; 设置图标 
   $hIcons [ 0 ] = _WinAPI_LoadShell32Icon ( 23 ) 
   $hIcons [ 1 ] = _WinAPI_LoadShell32Icon ( 40 ) 
   _GUICtrlStatusBar_SetIcon ( $hStatus , 0 , $hIcons [ 0 ]) 
   _GUICtrlStatusBar_SetIcon ( $hStatus , 1 , $hIcons [ 1 ]) 
 
   ; 显示部分文本 
   MemoWrite ( "Part 1 text ........: " & _GUICtrlStatusBar_GetText ( $hStatus , 0 )) 
   MemoWrite ( "Part 2 text ........: " & _GUICtrlStatusBar_GetText ( $hStatus , 1 )) 
 
   ; 显示图标句柄 
   MemoWrite ( "Part 1 icon handle .: 0x" & Hex ( _GUICtrlStatusBar_GetIcon ( $hStatus , 0 ))) 
   MemoWrite ( "Part 2 icon handle .: 0x" & Hex ( _GUICtrlStatusBar_GetIcon ( $hStatus , 1 ))) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
 
   ; 释放图标 
   _WinAPI_DestroyIcon ( $hIcons [ 0 ]) 
   _WinAPI_DestroyIcon ( $hIcons [ 1 ]) 
   GUIDelete () 
 EndFunc    ;==>Example1 
 
 Func Example2 () 
 
   Local $hGUI , $hStatus 
   Local $aParts [ 4 ] = [ 75 , 150 , 300 , 400 ] 
   
   ; 创建界面 
   $hGUI = GUICreate ( "(Example 2) StatusBar Get Text" , 400 , 300 ) 
   $hStatus = _GUICtrlStatusBar_Create ( $hGUI ) 
  
   ; 创建memo控件 
  $iMemo = GUICtrlCreateEdit ( "" , 2 , 2 , 396 , 274 , $WS_VSCROLL ) 
   GUICtrlSetFont ( $iMemo , 9 , 400 , 0 , "Courier New" ) 
   GUISetState () 
 
   ; 设置部分 
   _GUICtrlStatusBar_SetParts ( $hStatus , $aParts ) 
   _GUICtrlStatusBar_SetText ( $hStatus , "Part 1" ) 
   _GUICtrlStatusBar_SetText ( $hStatus , "Part 2" , 1 ) 
 
   ; 设置图标 
   _GUICtrlStatusBar_SetIcon ( $hStatus , 0 , 23 , "shell32.dll" ) 
   _GUICtrlStatusBar_SetIcon ( $hStatus , 1 , 40 , "shell32.dll" ) 
 
   ; 显示部分文本 
   MemoWrite ( "Part 1 text ........: " & _GUICtrlStatusBar_GetText ( $hStatus , 0 )) 
   MemoWrite ( "Part 2 text ........: " & _GUICtrlStatusBar_GetText ( $hStatus , 1 )) 
 
   ; 显示图标句柄 
   MemoWrite ( "Part 1 icon handle .: 0x" & Hex ( _GUICtrlStatusBar_GetIcon ( $hStatus , 0 ))) 
   MemoWrite ( "Part 2 icon handle .: 0x" & Hex ( _GUICtrlStatusBar_GetIcon ( $hStatus , 1 ))) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc    ;==>Example2 
 
 ; 向memo控件写入信息 
 Func MemoWrite ( $sMessage = "" ) 
   GUICtrlSetData ( $iMemo , $sMessage & @CRLF , 1 ) 
 EndFunc    ;==>MemoWrite 


