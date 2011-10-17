 #include <GuiConstantsEx.au3> 
 #include <GuiHeader.au3> 
 #include <WindowsConstants.au3> 
 #include <EditConstants.au3> 
 
 Opt ( 'MustDeclareVars' , 1 ) 
 
 $Debug_HDR = False ; 检查传递给控件的类名, 设置为真并使用另一控件句柄观察其工作 
 
 Global $hHeader , $edit 
 
 _Main () 
 
 Func _Main () 
   Local $hGUI 
 
   ; 创建界面 
   $hGUI = GUICreate ( "Header" , 400 , 300 ) 
   $hHeader = _GUICtrlHeader_Create ( $hGUI ) 
   $edit = GUICtrlCreateEdit ( "" , 2 , 40 , 394 , 258 , BitOR ( $WS_VSCROLL , $ES_AUTOVSCROLL )) 
   GUISetState () 
   
   GUIRegisterMsg ( $WM_NOTIFY , "WM_NOTIFY" ) 
 
   ; 添加列 
   _GUICtrlHeader_AddItem ( $hHeader , "1" , 100 ) 
   _GUICtrlHeader_AddItem ( $hHeader , "2" , 100 ) 
   _GUICtrlHeader_AddItem ( $hHeader , "3" , 100 ) 
   _GUICtrlHeader_AddItem ( $hHeader , "4" , 100 ) 
 
   ; 清除所有过滤器 
   _GUICtrlHeader_ClearFilterAll ( $hHeader ) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
 EndFunc    ;==>_Main 
 
 Func WM_NOTIFY ( $hWnd , $iMsg , $iwParam , $ilParam ) 
   Local $hWndFrom , $iIDFrom , $iCode 
   Local $tNMHDR , $tNMHEADER , $tNMHDFILTERBTNCLICK , $tNMHDDISPINFO 
 
   $tNMHDR = DllStructCreate ( $tagNMHDR , $ilParam ) 
   $hWndFrom = HWnd ( DllStructGetData ( $tNMHDR , "hWndFrom" )) 
   $iIDFrom = DllStructGetData ( $tNMHDR , "IDFrom" ) 
   $iCode = DllStructGetData ( $tNMHDR , "Code" ) 
   Switch $hWndFrom 
     Case $hHeader 
       Switch $iCode 
         Case $HDN_BEGINDRAG ; 当控件的一个项目被拖曳时发送 
           $tNMHEADER = DllStructCreate ( $tagNMHEADER , $ilParam ) 
           memowrite( "$HDN_BEGINDRAG" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & DllStructGetData ( $tNMHEADER , "hWndFrom" ) & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & DllStructGetData ( $tNMHEADER , "IDFrom" ) & @LF ) 
           memowrite( "-->Code:" & @TAB & DllStructGetData ( $tNMHEADER , "Code" ) & @LF ) 
           memowrite( "-->Item:" & @TAB & DllStructGetData ( $tNMHEADER , "Item" ) & @LF ) 
           memowrite( "-->Button:" & @TAB & DllStructGetData ( $tNMHEADER , "Button" )) 
           Return False ; 允许控件自动管理拖曳操作 
 ;~            Return True  ; 指示外部(手动)拖曳管理允许控件宿主提供作为拖曳过程一部分的自定义服务 
         Case $HDN_BEGINTRACK , $HDN_BEGINTRACKW ; 通知控件父窗口用户开始拖动控件中的分隔符 
           $tNMHEADER = DllStructCreate ( $tagNMHEADER , $ilParam ) 
           memowrite( "$HDN_BEGINTRACK" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & DllStructGetData ( $tNMHEADER , "hWndFrom" ) & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & DllStructGetData ( $tNMHEADER , "IDFrom" ) & @LF ) 
           memowrite( "-->Code:" & @TAB & DllStructGetData ( $tNMHEADER , "Code" ) & @LF ) 
           memowrite( "-->Item:" & @TAB & DllStructGetData ( $tNMHEADER , "Item" ) & @LF ) 
           memowrite( "-->Button:" & @TAB & DllStructGetData ( $tNMHEADER , "Button" )) 
           Return False ; 允许跟踪分隔符 
 ;~            Return True  ; 禁止跟踪 
         Case $HDN_DIVIDERDBLCLICK , $HDN_DIVIDERDBLCLICKW ; 通知控件父窗口用户双击控件中的分隔区 
           $tNMHEADER = DllStructCreate ( $tagNMHEADER , $ilParam ) 
           memowrite( "$HDN_DIVIDERDBLCLICK" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & DllStructGetData ( $tNMHEADER , "hWndFrom" ) & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & DllStructGetData ( $tNMHEADER , "IDFrom" ) & @LF ) 
           memowrite( "-->Code:" & @TAB & DllStructGetData ( $tNMHEADER , "Code" ) & @LF ) 
           memowrite( "-->Item:" & @TAB & DllStructGetData ( $tNMHEADER , "Item" ) & @LF ) 
           memowrite( "-->Button:" & @TAB & DllStructGetData ( $tNMHEADER , "Button" )) 
           ; 无返回值 
         Case $HDN_ENDDRAG ; 针对控件的拖动结束时由控件发送 
           $tNMHEADER = DllStructCreate ( $tagNMHEADER , $ilParam ) 
           memowrite( "$HDN_ENDDRAG" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & DllStructGetData ( $tNMHEADER , "hWndFrom" ) & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & DllStructGetData ( $tNMHEADER , "IDFrom" ) & @LF ) 
           memowrite( "-->Code:" & @TAB & DllStructGetData ( $tNMHEADER , "Code" ) & @LF ) 
           memowrite( "-->Item:" & @TAB & DllStructGetData ( $tNMHEADER , "Item" ) & @LF ) 
           memowrite( "-->Button:" & @TAB & DllStructGetData ( $tNMHEADER , "Button" )) 
           Return False ; 允许控件自动放置和记录项目 
 ;~            Return True  ; 阻止放置项目 
         Case $HDN_ENDTRACK , $HDN_ENDTRACKW ; 通知控件父窗口用户完成拖动控件中的分隔区 
           $tNMHEADER = DllStructCreate ( $tagNMHEADER , $ilParam ) 
           memowrite( "$HDN_ENDTRACK" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & DllStructGetData ( $tNMHEADER , "hWndFrom" ) & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & DllStructGetData ( $tNMHEADER , "IDFrom" ) & @LF ) 
           memowrite( "-->Code:" & @TAB & DllStructGetData ( $tNMHEADER , "Code" ) & @LF ) 
           memowrite( "-->Item:" & @TAB & DllStructGetData ( $tNMHEADER , "Item" ) & @LF ) 
           memowrite( "-->Button:" & @TAB & DllStructGetData ( $tNMHEADER , "Button" )) 
           ; 无返回值 
         Case $HDN_FILTERBTNCLICK ; 单击过滤按键或应答$HDM_SETITEM消息时通知控件父窗口 
           $tNMHDFILTERBTNCLICK = DllStructCreate ( $tagNMHDFILTERBTNCLICK , $ilParam ) 
           memowrite( "$HDN_FILTERBTNCLICK" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & DllStructGetData ( $HDN_FILTERBTNCLICK , "hWndFrom" ) & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & DllStructGetData ( $HDN_FILTERBTNCLICK , "IDFrom" ) & @LF ) 
           memowrite( "-->Code:" & @TAB & DllStructGetData ( $HDN_FILTERBTNCLICK , "Code" ) & @LF ) 
           memowrite( "-->Item:" & @TAB & DllStructGetData ( $HDN_FILTERBTNCLICK , "Item" ) & @LF ) 
           memowrite( "-->Left:" & @TAB & DllStructGetData ( $HDN_FILTERBTNCLICK , "Left" ) & @LF ) 
           memowrite( "-->Top:" & @TAB & DllStructGetData ( $HDN_FILTERBTNCLICK , "Top" ) & @LF ) 
           memowrite( "-->Right:" & @TAB & DllStructGetData ( $HDN_FILTERBTNCLICK , "Right" ) & @LF ) 
           memowrite( "-->Bottom:" & @TAB & DllStructGetData ( $HDN_FILTERBTNCLICK , "Bottom" )) 
 ;~            Return True  ; $HDN_FILTERCHANGE通知将发送到控件父窗口 
           ; 该通知使父窗口可将用户界面元素同步 
           Return False ; 当不想发送通知时 
         Case $HDN_FILTERCHANGE ; 通知控件父窗口控件过滤器属性正在改变或被编辑 
           $tNMHEADER = DllStructCreate ( $tagNMHEADER , $ilParam ) 
           memowrite( "$HDN_FILTERCHANGE" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & DllStructGetData ( $tNMHEADER , "hWndFrom" ) & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & DllStructGetData ( $tNMHEADER , "IDFrom" ) & @LF ) 
           memowrite( "-->Code:" & @TAB & DllStructGetData ( $tNMHEADER , "Code" ) & @LF ) 
           memowrite( "-->Item:" & @TAB & DllStructGetData ( $tNMHEADER , "Item" ) & @LF ) 
           memowrite( "-->Button:" & @TAB & DllStructGetData ( $tNMHEADER , "Button" )) 
           ; 无返回值 
         Case $HDN_GETDISPINFO , $HDN_GETDISPINFOW ; 发送给控件宿主控件需要回调标题项的信息 
           $HDN_GETDISPINFO = DllStructCreate ( $tagNMHDDISPINFO , $ilParam ) 
           memowrite( "$HDN_GETDISPINFO" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & DllStructGetData ( $HDN_GETDISPINFO , "hWndFrom" ) & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & DllStructGetData ( $HDN_GETDISPINFO , "IDFrom" ) & @LF ) 
           memowrite( "-->Code:" & @TAB & DllStructGetData ( $HDN_GETDISPINFO , "Code" ) & @LF ) 
           memowrite( "-->Item:" & @TAB & DllStructGetData ( $HDN_GETDISPINFO , "Item" )) 
 ;~            无返回值 
         Case $HDN_ITEMCHANGED , $HDN_ITEMCHANGEDW ; 通知控件父窗口标题项属性已改变 
           $tNMHEADER = DllStructCreate ( $tagNMHEADER , $ilParam ) 
           memowrite( "$HDN_ITEMCHANGED" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & DllStructGetData ( $tNMHEADER , "hWndFrom" ) & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & DllStructGetData ( $tNMHEADER , "IDFrom" ) & @LF ) 
           memowrite( "-->Code:" & @TAB & DllStructGetData ( $tNMHEADER , "Code" ) & @LF ) 
           memowrite( "-->Item:" & @TAB & DllStructGetData ( $tNMHEADER , "Item" ) & @LF ) 
           memowrite( "-->Button:" & @TAB & DllStructGetData ( $tNMHEADER , "Button" )) 
           ; 无返回值 
         Case $HDN_ITEMCHANGING , $HDN_ITEMCHANGINGW ; 通知控件父窗口标题项属性将改变 
           $tNMHEADER = DllStructCreate ( $tagNMHEADER , $ilParam ) 
           memowrite( "$HDN_ITEMCHANGING" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & DllStructGetData ( $tNMHEADER , "hWndFrom" ) & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & DllStructGetData ( $tNMHEADER , "IDFrom" ) & @LF ) 
           memowrite( "-->Code:" & @TAB & DllStructGetData ( $tNMHEADER , "Code" ) & @LF ) 
           memowrite( "-->Item:" & @TAB & DllStructGetData ( $tNMHEADER , "Item" ) & @LF ) 
           memowrite( "-->Button:" & @TAB & DllStructGetData ( $tNMHEADER , "Button" )) 
           Return False ; 允许改变 
 ;~            Return True  ; 阻止改变 
         Case $HDN_ITEMCLICK , $HDN_ITEMCLICKW ; 通知控件父窗口用户单击控件 
           $tNMHEADER = DllStructCreate ( $tagNMHEADER , $ilParam ) 
           memowrite( "$HDN_ITEMCLICK" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & DllStructGetData ( $tNMHEADER , "hWndFrom" ) & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & DllStructGetData ( $tNMHEADER , "IDFrom" ) & @LF ) 
           memowrite( "-->Code:" & @TAB & DllStructGetData ( $tNMHEADER , "Code" ) & @LF ) 
           memowrite( "-->Item:" & @TAB & DllStructGetData ( $tNMHEADER , "Item" ) & @LF ) 
           memowrite( "-->Button:" & @TAB & DllStructGetData ( $tNMHEADER , "Button" )) 
           ; 无返回值 
         Case $HDN_ITEMDBLCLICK , $HDN_ITEMDBLCLICKW ; 通知控件父窗口用户双击控件 
           $tNMHEADER = DllStructCreate ( $tagNMHEADER , $ilParam ) 
           memowrite( "$HDN_ITEMDBLCLICK" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & DllStructGetData ( $tNMHEADER , "hWndFrom" ) & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & DllStructGetData ( $tNMHEADER , "IDFrom" ) & @LF ) 
           memowrite( "-->Code:" & @TAB & DllStructGetData ( $tNMHEADER , "Code" ) & @LF ) 
           memowrite( "-->Item:" & @TAB & DllStructGetData ( $tNMHEADER , "Item" ) & @LF ) 
           memowrite( "-->Button:" & @TAB & DllStructGetData ( $tNMHEADER , "Button" )) 
           ; 无返回值 
         Case $HDN_TRACK , $HDN_TRACKW ; 通知控件父窗口用户正在拖曳标题栏控件中的一个分割区 
           $tNMHEADER = DllStructCreate ( $tagNMHEADER , $ilParam ) 
           memowrite( "$HDN_TRACK" & @LF ) 
           memowrite( "-->hWndFrom:" & @TAB & DllStructGetData ( $tNMHEADER , "hWndFrom" ) & @LF ) 
           memowrite( "-->IDFrom:" & @TAB & DllStructGetData ( $tNMHEADER , "IDFrom" ) & @LF ) 
           memowrite( "-->Code:" & @TAB & DllStructGetData ( $tNMHEADER , "Code" ) & @LF ) 
           memowrite( "-->Item:" & @TAB & DllStructGetData ( $tNMHEADER , "Item" ) & @LF ) 
           memowrite( "-->Button:" & @TAB & DllStructGetData ( $tNMHEADER , "Button" )) 
           Return False ; 继续跟踪分割区 
 ;~            Return True  ; 结束跟踪 
       EndSwitch 
   EndSwitch 
   Return $GUI_RUNDEFMSG 
 EndFunc    ;==>WM_NOTIFY 
 
 Func memowrite ( $s_text ) 
   GUICtrlSetData ( $edit , $s_text & @CRLF , 1) 
 EndFunc    ;==>memowrite 
 
