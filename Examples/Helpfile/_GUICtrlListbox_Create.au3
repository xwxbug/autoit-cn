 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <GUIListBox.au3> 
 #include <GuiConstantsEx.au3> 
 #include <WindowsConstants.au3> 
 #include <Constants.au3> 
 #include <EditConstants.au3> 
 
 Opt ( 'MustDeclareVars' , 1 ) 
 
 $Debug_LB = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 
 
 Global $hListBox , $edit 
 
 _Main () 
 
 Func _Main () 
   Local $hGUI 
 
   ; 创建界面 
   $hGUI = GUICreate ( "(UDF Created) List Box Create" , 400 , 296 ) 
   $hListBox = _GUICtrlListBox_Create ( $hGUI , "String upon creation" , 2 , 2 , 396 , 296 ) 
   $edit = GUICtrlCreateEdit ( "" , 10 , 30 , 380 , 180 , BitOR ( $WS_VSCROLL , $ES_AUTOVSCROLL )) 
   GUISetState () 
 
   MsgBox ( 4160 , "Information" , "Adding Items" ) 
 
   GUIRegisterMsg ( $WM_COMMAND , "WM_COMMAND" ) 
 
   ; 添加文件 
   _GUICtrlListBox_BeginUpdate ( $hListBox ) 
   _GUICtrlListBox_ResetContent ( $hListBox ) 
   _GUICtrlListBox_InitStorage ( $hListBox , 100 , 4096 ) 
   _GUICtrlListBox_Dir ( $hListBox , @WindowsDir & "\win*.exe" ) 
   _GUICtrlListBox_AddFile ( $hListBox , @WindowsDir & "\Notepad.exe" ) 
   _GUICtrlListBox_Dir ( $hListBox , "" , $DDL_DRIVES ) 
   _GUICtrlListBox_Dir ( $hListBox , "" , $DDL_DRIVES , False ) 
   _GUICtrlListBox_EndUpdate ( $hListBox ) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
 EndFunc    ;==>_Main 
 
 Func WM_COMMAND ( $hWnd , $iMsg , $iwParam , $ilParam ) 
   #forceref $hWnd, $iMsg 
   Local $hWndFrom , $iIDFrom , $iCode , $hWndListBox 
   If Not IsHWnd ( $hListBox ) Then $hWndListBox = GUICtrlGetHandle ( $hListBox ) 
   $hWndFrom = $ilParam 
   $iIDFrom = BitAND ( $iwParam , 0xFFFF ) ; 小写字母 
   $iCode = BitShift ( $iwParam , 16 ) ; 大写字母 
 
   Switch $hWndFrom 
     Case $hListBox , $hWndListBox 
       Switch $iCode 
         Case $LBN_DBLCLK ; 用户双击列表箱中的字符串时发送 
           memowrite ( "$LBN_DBLCLK" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $IDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $Code ) 
           ; 无返回值 
         Case $LBN_ERRSPACE ; 列表箱无法给指定请求分配足够内存时发送 
           memowrite ( "$LBN_ERRSPACE" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $IDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $Code ) 
           ; 无返回值 
         Case $LBN_KILLFOCUS ; 列表箱丢失键盘焦点时发送 
           memowrite ( "$LBN_KILLFOCUS" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $IDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $Code ) 
           ; 无返回值 
         Case $LBN_SELCANCEL ; 用户取消在列表箱中的选项时发送 
           memowrite ( "$LBN_SELCANCEL" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $IDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $Code ) 
           ; 无返回值 
         Case $LBN_SELCHANGE ; 当列表箱中的选项改变时发送 
           memowrite ( "$LBN_SELCHANGE" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $IDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $Code ) 
           ; 无返回值 
         Case $LBN_SETFOCUS ; 当列表箱接收键盘焦点时发送 
           memowrite ( "$LBN_SETFOCUS" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $IDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $Code ) 
           ; 无返回值 
       EndSwitch 
   EndSwitch 
   ; 执行默认的Autoit3内部消息命令也可以完全忽略该行. 
   ; !!!但是没有任何值的'Return'将使得后续程序无法执行默认的Autoit3消息!!! 
   Return $GUI_RUNDEFMSG 
 EndFunc    ;==>WM_COMMAND 
 
 Func memowrite( $s_text ) 
   GUICtrlSetData ( $edit , $s_text & @CRLF , 1) 
 EndFunc    ;==>memowrite 

