
 #include <GuiConstantsEx.au3> 
 #include <GuiStatusBar.au3> 
 #include  <ComboConstants.au3> 
#include <EditConstants.au3> 
 #include <WindowsConstants.au3> 
 
 Opt ( 'MustDeclareVars' , 1 ) 
 
 $Debug_SB =  False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 
 
 Global $iMemo , $MainGUI , $hStatus , $edit 
 
 Example1 () 
 Example2 () 
 Example3 () 
 Example4 () 
 Example5 () 
 Example6 () 
 
 Func Example1 () 
 
     Local $hGUI 
     Local $aParts [ 3 ] = [ 75 , 150 , - 1 ] 
 
     ; 创建界面 
     $hGUI = GUICreate ( "(Example 1) StatusBar Create" , 400 , 300 ) 
 
     ; 默认一个部分, 无文本 
     $hStatus = _GUICtrlStatusBar_Create ( $hGUI ) 
     _GUICtrlStatusBar_SetParts ( $hStatus , $aParts ) 
 
     ; 创建记录相关操作的控件 
     $edit = GUICtrlCreateEdit ( "" , 2 , 136 , 396 , 138 , BitOR ( $WS_VSCROLL , $ES_AUTOVSCROLL , $ES_READONLY )) 
     ; 创建显示控件信息的控件 
     $iMemo = GUICtrlCreateEdit ( "" , 2 , 2 , 396 , 133 , $WS_VSCROLL ) 
     GUICtrlSetFont ( $iMemo , 9 , 400 , 0 , "Courier New" ) 
     GUICtrlSendMsg ( $iMemo , $EM_SETREADONLY , True , 0 ) 
    GUICtrlSetBkColor ( $iMemo , 0xFFFFFF ) 
     infoout ( "StatusBar Created with:" & @CRLF & @TAB & "Handle to GUI window" & @CRLF ) 
     GUISetState () 
 
     GUIRegisterMsg ( $WM_NOTIFY , "WM_NOTIFY" ) 
 
     ; 获取边界尺寸 
     infoout ( "Horizontal border width .: " & _GUICtrlStatusBar_GetBordersHorz ( $hStatus )) 
     infoout ( "Vertical border width ...: " & _GUICtrlStatusBar_GetBordersVert ( $hStatus )) 
     infoout ( "Width between rectangles : " & _GUICtrlStatusBar_GetBordersRect ( $hStatus )) 
     infoout ( " " ) 
 
     ; 循环至用户退出 
     Do 
    Until GUIGetMsg () = $GUI_EVENT_CLOSE 
       GUISetState ( @SW_ENABLE , $MainGUI ) 
       GUIDelete ( $hGUI ) 
 EndFunc    ;==>Example1 
 
 Func Example2 () 
 
     Local $hGUI 
     Local $aParts [ 3 ] = [ 75 , 150 , - 1 ] 
 
     ; 创建界面 
     $hGUI = GUICreate ( "(Example 2) StatusBar Create" , 400 , 300 ) 
 
     ; 设置不带文本的多个部分 
     $hStatus = _GUICtrlStatusBar_Create ( $hGUI , $aParts ) 
 
     ; 创建记录相关操作的控件 
     $edit = GUICtrlCreateEdit ( "" , 2 , 136 , 396 , 138 , BitOR ( $WS_VSCROLL , $ES_AUTOVSCROLL , $ES_READONLY )) 
     ; 创建显示控件信息的控件 
     $iMemo = GUICtrlCreateEdit ( "" , 2 , 2 , 396 , 133 , $WS_VSCROLL ) 
     GUICtrlSetFont ( $iMemo , 9 , 400 , 0 , "Courier New" ) 
     GUICtrlSendMsg ( $iMemo , $EM_SETREADONLY , True , 0 ) 
     GUICtrlSetBkColor ( $iMemo , 0xFFFFFF ) 
     infoout ( "StatusBar Created with:" & @CRLF & _ 
             @TAB & "Handle to GUI window" & @CRLF & _ 
             @TAB & "part width array of 3 elements" & @CRLF ) 
     GUISetState () 
 
     GUIRegisterMsg ( $WM_NOTIFY , "WM_NOTIFY" ) 
 
     ; 获取边界尺寸 
     infoout ( "Horizontal border width .: " & _GUICtrlStatusBar_GetBordersHorz ( $hStatus )) 
     infoout ( "Vertical border width ...: " & _GUICtrlStatusBar_GetBordersVert ( $hStatus )) 
     infoout ( "Width between rectangles : " & _GUICtrlStatusBar_GetBordersRect ( $hStatus )) 
     infoout ( " " ) 
 
     ; 循环至用户退出 
     Do 
     Until GUIGetMsg () = $GUI_EVENT_CLOSE 
     GUISetState ( @SW_ENABLE , $MainGUI ) 
     GUIDelete ( $hGUI ) 
 EndFunc    ;==>Example2 
 
 Func Example3 () 
 
     Local $hGUI 
     Local $aText [ 3 ] = [ "Left Justified" , @TAB & "Centered" , @TAB & @TAB & "Right Justified" ] 
     Local $aParts [ 3 ] = [ 100 , 175 , - 1 ] 
 
     ; 创建界面 
     $hGUI = GUICreate ( "(Example 3) StatusBar Create" , 400 , 300 ) 

     ; 设置带文本的多个部分 
     $hStatus = _GUICtrlStatusBar_Create ( $hGUI , $aParts , $aText ) 
 
     ; 创建记录相关操作的控件 
     $edit = GUICtrlCreateEdit ( "" , 2 , 136 , 396 , 138 , BitOR ( $WS_VSCROLL , $ES_AUTOVSCROLL , $ES_READONLY )) 
     ; 创建显示控件信息的控件 
     $iMemo = GUICtrlCreateEdit ( "" , 2 , 2 , 396 , 133 , $WS_VSCROLL ) 
     GUICtrlSendMsg ( $iMemo , $EM_SETREADONLY , True , 0 ) 
     GUICtrlSetBkColor ( $iMemo , 0xFFFFFF ) 
     infoout ( "StatusBar Created with:" & @CRLF & _ 
             @TAB & "only Handle," & @CRLF & _ 
             @TAB & "part width array of 3 elements" & @CRLF & _ 
             @TAB & "part text array of 3 elements" & @CRLF ) 
     GUISetState () 
 
     GUIRegisterMsg ( $WM_NOTIFY , "WM_NOTIFY" ) 
 
    ; 获取边界尺寸 
     infoout ( "Horizontal border width .: " & _GUICtrlStatusBar_GetBordersHorz ( $hStatus )) 
     infoout ( "Vertical border width ...: " & _GUICtrlStatusBar_GetBordersVert ( $hStatus )) 
     infoout ( "Width between rectangles : " & _GUICtrlStatusBar_GetBordersRect ( $hStatus )) 
     infoout ( " " ) 
 
     ; 循环至用户退出 
     Do 
     Until GUIGetMsg () = $GUI_EVENT_CLOSE 
     GUISetState ( @SW_ENABLE , $MainGUI ) 
     GUIDelete ( $hGUI ) 
 EndFunc    ;==>Example3 
 
 Func Example4 () 
 
     Local $hGUI 
     Local $aText [ 3 ] = [ "Left Justified" , @TAB & "Centered" , @TAB & @TAB & "Right Justified" ] 
 
     ; 创建界面 
     $hGUI = GUICreate ( "(Example 4) StatusBar Create" , 400 , 300 ) 
 
     ; 创建基于宽度参数的部分 
     $hStatus = _GUICtrlStatusBar_Create ( $hGUI , 100 , $aText ) 
     ; 创建记录相关操作的控件 
     $edit = GUICtrlCreateEdit ( "" , 2 , 136 , 396 , 138 , BitOR ( $WS_VSCROLL , $ES_AUTOVSCROLL , $ES_READONLY )) 
     ; 创建显示控件信息的控件 
     $iMemo = GUICtrlCreateEdit ( "" , 2 , 2 , 396 , 133 , $WS_VSCROLL ) 
     GUICtrlSetFont ( $iMemo , 9 , 400 , 0 , "Courier New" ) 
     GUICtrlSendMsg ( $iMemo , $EM_SETREADONLY , True , 0 ) 
     GUICtrlSetBkColor ( $iMemo , 0xFFFFFF ) 
     infoout ( "StatusBar Created with:" & @CRLF & _ 
             @TAB & "only Handle," & @CRLF & _ 
             @TAB & "part width number" & @CRLF & _ 
             @TAB & "part text array of 3 elements" & @CRLF ) 
     GUISetState () 
 
     GUIRegisterMsg ( $WM_NOTIFY , "WM_NOTIFY" ) 
 
     ; 获取边界尺寸 
     infoout ( "Horizontal border width .: " & _GUICtrlStatusBar_GetBordersHorz ( $hStatus )) 
     infoout ( "Vertical border width ...: " & _GUICtrlStatusBar_GetBordersVert ( $hStatus )) 
     infoout ( "Width between rectangles : " & _GUICtrlStatusBar_GetBordersRect ( $hStatus )) 
     infoout ( " " ) 
 
     ; 循环至用户退出 
     Do 
     Until GUIGetMsg () = $GUI_EVENT_CLOSE 
     GUISetState ( @SW_ENABLE , $MainGUI ) 
     GUIDelete ( $hGUI ) 
 EndFunc    ;==>Example4 
 
 Func Example5 () 
 
     Local $hGUI 
     Local $aText [ 3 ] = [ "Left Justified" , @TAB & "Centered" , @TAB & @TAB & "Right Justified" ] 
     Local $aParts [ 2 ] = [ 100 , 175 ] 
 
     ; 创建界面 
     $hGUI = GUICreate ( "(Example 5) StatusBar Create" , 400 , 300 ) 
 
     ; 调整为传递过来的最大数组 (文本数组最大) 
     $hStatus = _GUICtrlStatusBar_Create ( $hGUI , $aParts , $aText ) 
 
     ; 创建记录相关操作的控件 
     $edit = GUICtrlCreateEdit ( "" , 2 , 136 , 396 , 138 , BitOR ( $WS_VSCROLL , $ES_AUTOVSCROLL , $ES_READONLY )) 
     ; 创建显示控件信息的控件 
     $iMemo = GUICtrlCreateEdit ( "" , 2 , 2 , 396 , 133 , $WS_VSCROLL ) 
     GUICtrlSendMsg ( $iMemo , $EM_SETREADONLY , True , 0 ) 
     GUICtrlSetBkColor ( $iMemo , 0xFFFFFF ) 
     infoout ( "StatusBar Created with:" & @CRLF & _ 
             @TAB & "only Handle," & @CRLF & _ 
             @TAB & "part width array of 2 elements" & @CRLF & _ 
             @TAB & "part text array of 3 elements" & @CRLF ) 
     GUISetState () 
 
     GUIRegisterMsg ( $WM_NOTIFY , "WM_NOTIFY" ) 
 
     ; 获取边界尺寸 
     infoout ( "Horizontal border width .: " & _GUICtrlStatusBar_GetBordersHorz ( $hStatus )) 
     infoout ( "Vertical border width ...: " & _GUICtrlStatusBar_GetBordersVert ( $hStatus )) 
     infoout ( "Width between rectangles : " & _GUICtrlStatusBar_GetBordersRect ( $hStatus )) 
     infoout ( " " ) 
 
     ; 循环至用户退出 
     Do 
     Until GUIGetMsg () = $GUI_EVENT_CLOSE 
     GUISetState ( @SW_ENABLE , $MainGUI ) 
     GUIDelete ( $hGUI ) 
 EndFunc    ;==>Example5 
 
 Func Example6 () 
 
     Local $hGUI 
     Local $aText [ 2 ] = [ "Left Justified" , @TAB & "Centered" ] 
     Local $aParts [ 3 ] = [ 100 , 175 , - 1 ] 
 
     ; 创建界面 
     $hGUI = GUICreate ( "(Example 6) StatusBar Create" , 400 , 300 ) 
 
     ; 调整为传递过来的最大数组(部分宽度最大) 
     $hStatus = _GUICtrlStatusBar_Create ( $hGUI , $aParts , $aText ) 
     ; 创建记录相关操作的控件 
     $edit = GUICtrlCreateEdit ( "" , 2 , 136 , 396 , 138 , BitOR ( $WS_VSCROLL , $ES_AUTOVSCROLL , $ES_READONLY )) 
     ; 创建显示控件信息的控件 
     $iMemo = GUICtrlCreateEdit ( "" , 2 , 2 , 396 , 133 , $WS_VSCROLL ) 
     GUICtrlSetFont ( $iMemo , 9 , 400 , 0 , "Courier New" ) 
     GUICtrlSendMsg ( $iMemo , $EM_SETREADONLY , True , 0 ) 
     GUICtrlSetBkColor ( $iMemo , 0xFFFFFF ) 
     infoout ( "StatusBar Created with:" & @CRLF & _ 
             @TAB & "only Handle," & @CRLF & _ 
             @TAB & "part width array of 3 elements" & @CRLF & _ 
             @TAB & "part text array of 2 elements" & @CRLF ) 
     GUISetState () 
 
     GUIRegisterMsg ( $WM_NOTIFY , "WM_NOTIFY" ) 
 
     ; 获取边界尺寸 
     infoout ( "Horizontal border width .: " & _GUICtrlStatusBar_GetBordersHorz ( $hStatus )) 
     infoout ( "Vertical border width ...: " & _GUICtrlStatusBar_GetBordersVert ( $hStatus )) 
     infoout ( "Width between rectangles : " & _GUICtrlStatusBar_GetBordersRect ( $hStatus )) 
     infoout ( " " ) 
 
     ; 循环至用户退出 
     Do 
     Until GUIGetMsg () = $GUI_EVENT_CLOSE 
     GUISetState ( @SW_ENABLE , $MainGUI ) 
     GUIDelete ( $hGUI ) 
 EndFunc    ;==>Example6 
 
 ; 向memo控件写入信息 
 Func infoout ( $sMessage = "" ) 
     GUICtrlSetData ( $iMemo , $sMessage & @CRLF , 1 ) 
 EndFunc    ;==>infoout 
 
 Func WM_NOTIFY( $hWnd , $iMsg , $iwParam , $ilParam ) 
   #forceref $hWnd, $iMsg, $iwParam 
   Local $hWndFrom , $iIDFrom , $iCode , $tNMHDR , $tInfo 
 
   $tNMHDR = DllStructCreate ( $tagNMHDR , $ilParam ) 
   $hWndFrom = HWnd ( DllStructGetData ( $tNMHDR , "hWndFrom" )) 
   $iIDFrom = DllStructGetData ( $tNMHDR , "IDFrom" ) 
   $iCode = DllStructGetData ( $tNMHDR , "Code" ) 
   Switch $hWndFrom 
     Case $hStatus 
       Switch $iCode 
         Case $NM_CLICK ; 鼠标左键点击项目时由控件发送 
           $tInfo = DllStructCreate ( $tagNMMOUSE , $ilParam ) 
           $hWndFrom = DllStructCreate ( $tagNMMOUSE , "hWndFrom" ) 
           $iIDFrom = DllStructCreate ( $tagNMMOUSE , "IDFrom" ) 
           $iCode = DllStructCreate ( $tagNMMOUSE , "Code" ) 
           memowrite( "$NM_CLICK" & @LF ) 
           memowrite( "-->$hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode & @LF ) 
           memowrite( "-->ItemSpec:" & @TAB & DllStructGetData ( $tInfo , "ItemSpec" ) & @LF ) 
           memowrite( "-->ItemData:" & @TAB & DllStructGetData ( $tInfo , "ItemData" ) & @LF ) 
           memowrite( "-->X:" & @TAB & DllStructGetData ( $tInfo , "X" ) & @LF ) 
           memowrite( "-->Y:" & @TAB & DllStructGetData ( $tInfo , "Y" ) & @LF ) 
           memowrite( "-->HitInfo:" & @TAB & DllStructGetData ( $tInfo , "HitInfo" )) 
           Return TRUE ; 表示已获取鼠标点击并由系统禁止默认操作 
 ;~         Return FALSE ;允许点击的默认操作. 
         Case $NM_DBLCLK   ; 在控件内双击鼠标左键 
           $tInfo = DllStructCreate ( $tagNMMOUSE , $ilParam ) 
           $hWndFrom = DllStructCreate ( $tagNMMOUSE , "hWndFrom" ) 
           $iIDFrom = DllStructCreate ( $tagNMMOUSE , "IDFrom" ) 
           $iCode = DllStructCreate ( $tagNMMOUSE , "Code" ) 
           memowrite ( "$NM_DBLCLK" & @LF ) 
           memowrite( "-->$hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode & @LF ) 
           memowrite( "-->ItemSpec:" & @TAB & DllStructGetData ( $tInfo , "ItemSpec" ) & @LF ) 
           memowrite( "-->ItemData:" & @TAB & DllStructGetData ( $tInfo , "ItemData" ) & @LF ) 
           memowrite( "-->X:" & @TAB & DllStructGetData ( $tInfo , "X" ) & @LF ) 
           memowrite( "-->Y:" & @TAB & DllStructGetData ( $tInfo , "Y" ) & @LF ) 
           memowrite( "-->HitInfo:" & @TAB & DllStructGetData ( $tInfo , "HitInfo" )) 
           Return TRUE ; 表示已获取鼠标点击并由系统禁止默认操作 
 ;~         Return FALSE ;允许点击的默认操作. 
         Case $NM_RCLICK ; 鼠标右键点击项目时由控件发送 
           $tInfo = DllStructCreate ( $tagNMMOUSE , $ilParam ) 
           $hWndFrom = DllStructCreate ( $tagNMMOUSE , "hWndFrom" ) 
           $iIDFrom = DllStructCreate ( $tagNMMOUSE , "IDFrom" ) 
           $iCode = DllStructCreate ( $tagNMMOUSE , "Code" ) 
           memowrite ( "$NM_RCLICK" & @LF ) 
           memowrite( "-->$hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode & @LF ) 
           memowrite( "-->ItemSpec:" & @TAB & DllStructGetData ( $tInfo , "ItemSpec" ) & @LF ) 
           memowrite( "-->ItemData:" & @TAB & DllStructGetData ( $tInfo , "ItemData" ) & @LF ) 
           memowrite( "-->X:" & @TAB & DllStructGetData ( $tInfo , "X" ) & @LF ) 
           memowrite( "-->Y:" & @TAB & DllStructGetData ( $tInfo , "Y" ) & @LF ) 
           memowrite( "-->HitInfo:" & @TAB & DllStructGetData ( $tInfo , "HitInfo" )) 
           Return TRUE ; 表示已获取鼠标点击并由系统禁止默认操作 
 ;~         Return FALSE ;允许点击的默认操作. 
         Case $NM_RDBLCLK   ; 在控件内双击鼠标右键 
           $tInfo = DllStructCreate ( $tagNMMOUSE , $ilParam ) 
           $hWndFrom = DllStructCreate ( $tagNMMOUSE , "hWndFrom" ) 
           $iIDFrom = DllStructCreate ( $tagNMMOUSE , "IDFrom" ) 
           $iCode = DllStructCreate ( $tagNMMOUSE , "Code" ) 
           memowrite ( "$NM_DBLCLK" & @LF ) 
           memowrite( "-->$hWndFrom:" & @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode & @LF ) 
           memowrite( "-->ItemSpec:" & @TAB & DllStructGetData ( $tInfo , "ItemSpec" ) & @LF ) 
           memowrite( "-->ItemData:" & @TAB & DllStructGetData ( $tInfo , "ItemData" ) & @LF ) 
           memowrite( "-->X:" & @TAB & DllStructGetData ( $tInfo , "X" ) & @LF ) 
           memowrite( "-->Y:" & @TAB & DllStructGetData ( $tInfo , "Y" ) & @LF ) 
           memowrite( "-->HitInfo:" & @TAB & DllStructGetData ( $tInfo , "HitInfo" )) 
           Return TRUE ; 表示已获取鼠标点击并由系统禁止默认操作 
 ;~         Return FALSE ;允许点击的默认操作. 
         Case $SBN_SIMPLEMODECHANGE   ; 在控件内双击鼠标右键 
           memowrite ( "$SBN_SIMPLEMODECHANGE" & @LF ) 
           memowrite( "-->$hWndFrom:" = @TAB & $hWndFrom & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & $iIDFrom & @LF ) 
           memowrite( "-->Code:" & @TAB & $iCode ) 
       EndSwitch 
   EndSwitch 
   Return $GUI_RUNDEFMSG 
 EndFunc ;==>WM_NOTIFY 
 
 Func memowrite( $s_text ) 
   GUICtrlSetData ( $edit , $s_text & @CRLF , 1) 
 EndFunc    ;==>memowrite 

