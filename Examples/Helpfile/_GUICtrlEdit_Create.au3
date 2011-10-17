
 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GuiEdit.au3> 
 #include <WinAPI.au3> ; used for Lo/Hi word 
 #include <WindowsConstants.au3> 
 #include <GuiConstantsEx.au3> 
 
 Opt ( 'MustDeclareVars' , 1 ) 
 
 $Debug_Ed = False ; 查看传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 
 
 Global $hEdit 
 
 _Example1 () 
 _Example2 () 
 
 Func _Example1 () 
   Local $hGUI 
 
   ; 创建界面 
   $hGUI = GUICreate ( "Edit Create" , 400 , 532 ) 
   $hEdit = _GUICtrlEdit_Create ( $hGUI , "This is a test" & @CRLF & "Another Line" , 2 , 2 , 394 , 268 ) 
   $iMemo = GUICtrlCreateEdit ( "" , 2 , 272 , 394 , 258 , BitOR ( $WS_VSCROLL , $ES_AUTOVSCROLL , $ES_READONLY )) 
   GUISetState () 
 
   GUIRegisterMsg ( $WM_COMMAND , "WM_COMMAND" ) 
 
   _GUICtrlEdit_AppendText ( $hEdit , @CRLF & "Append to the end?" ) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc    ;==>_Example1 
 
 Func _Example2 () 
   Local $hGUI 
 
   ; 创建界面 
   $hGUI = GUICreate ( "Edit Create" , 400 , 532 ) 
   $hEdit = _GUICtrlEdit_Create ( $hGUI , "" , 2 , 2 , 394 , 268 ) 
   $iMemo = GUICtrlCreateEdit ( "" , 2 , 272 , 394 , 258 , BitOR ( $WS_VSCROLL , $ES_AUTOVSCROLL , $ES_READONLY )) 
   GUISetState () 
 
   GUIRegisterMsg ( $WM_COMMAND , "WM_COMMAND" ) 
 
   _GUICtrlEdit_SetText ( $hEdit , "This is a test" & @CRLF & "Another Line" ) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc    ;==>_Example2 
 
 Func WM_COMMAND ( $hWnd , $iMsg , $iwParam , $ilParam ) 
   #forceref $hWnd, $iMsg 
   Local $hWndFrom , $iIDFrom , $iCode , $hWndEdit 
   If Not IsHWnd ( $hEdit ) Then $hWndEdit = GUICtrlGetHandle ( $hEdit ) 
   $hWndFrom = $ilParam 
  $iIDFrom = _WinAPI_LoWord ( $iwParam ) 
   $iCode = _WinAPI_HiWord ( $iwParam ) 
   Switch $hWndFrom 
     Case $hEdit , $hWndEdit 
       Switch $iCode 
         Case $EN_ALIGN_LTR_EC ; 将编辑控件方向改为从左到右时发送 
           memowrite ( "$EN_ALIGN_LTR_EC" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode & @LF ) 
           ; 无返回值 
         Case $EN_ALIGN_RTL_EC ; 将编辑控件方向改为从右到左时发送 
           memowrite ( "$EN_ALIGN_RTL_EC" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode & @LF ) 
           ; 无返回值 
         Case $EN_CHANGE ; 改变控件中的文本时发送 
           memowrite ( "$EN_CHANGE" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode & @LF ) 
           ; 无返回值 
         Case $EN_ERRSPACE ; 控件无法分配足够内存用于指定请求时发送 
           memowrite ( "$EN_ERRSPACE" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode & @LF ) 
           ; 无返回值 
         Case $EN_HSCROLL ; 点击控件水平滚动条时发送 
           memowrite ( "$EN_HSCROLL" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode & @LF ) 
           ; 无返回值 
         Case $EN_KILLFOCUS ; 控件丢失键盘焦点时发送 
           memowrite ( "$EN_KILLFOCUS" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode & @LF ) 
           ; 无返回值 
         Case $EN_MAXTEXT ; 当前文本插入已超过编辑框字符的指定数量时发送 
           memowrite ( "$EN_MAXTEXT" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode & @LF ) 
           ; 当编辑控件不具有$ES_AUTOHSCROLL样式且将插入的字符的数量超过编辑控件宽度时会发送. 
           ; 当编辑控件不具有$ES_AUTOVSCROLL样式且插入文本行数加原文本行数总行数超过控件高度时也会发送 
           ; 无返回值 
         Case $EN_SETFOCUS ; 控件收到键盘焦点时发送 
           memowrite ( "$EN_SETFOCUS" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode & @LF ) 
           ; 无返回值 
         Case $EN_UPDATE ; 编辑控件将重绘时发送 
           memowrite ( "$EN_UPDATE" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode & @LF ) 
           ; 无返回值 
         Case $EN_VSCROLL ; 点击编辑控件垂直滚动条或在控件上转动鼠标滚轮时发送 
           memowrite ( "$EN_VSCROLL" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode & @LF ) 
           ; 无返回值 
       EndSwitch 
   EndSwitch 
   Return $GUI_RUNDEFMSG 
 EndFunc    ;==>WM_COMMAND 
 
 Func memowrite( $s_text ) 
   GUICtrlSetData ( $iMemo , $s_text & @CRLF , 1) 
 EndFunc    ;==>memowrite 

