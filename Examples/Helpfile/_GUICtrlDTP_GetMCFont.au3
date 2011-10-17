 #AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include  <GuiConstantsEx.au3> 
 #include  <GuiDateTimePicker.au3> 
 
 Opt ( " MustDeclareVars ", 1 ) 
 
 $Debug_DTP = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 
 
 Global $iMemo 
 
 _Main() 
 
 Func _Main() 
   Local $tLOGFONT , $hFont , $hDTP 
 
   ; 创建界面 
   GUICreate ( " DateTimePick Get Month Calendar Font ", 400 , 300 ) 
   $hDTP = GUICtrlGetHandle ( GUICtrlCreateDate ( "", 2 , 6 , 190 )) 
   $iMemo = GUICtrlCreateEdit ( "", 2 , 32 , 396 , 266 , 0 ) 
   GUICtrlSetFont ( $iMemo , 9 , 400 , 0 , " Courier New " ) 
   GUISetState () 
 
   ; 设置显示格式 
   _GUICtrlDTP_SetFormat ( $hDTP , " ddd MMM dd , yyyy hh:mm ttt " ) 
 
   ; 给月历控件新建一个字体 
   $tLOGFONT = DllStructCreate ( $tagLOGFONT ) 
   DllStructSetData ( $tLOGFONT , " Height ", 13 ) 
   DllStructSetData ( $tLOGFONT , " Weight ", 400 ) 
   DllStructSetData ( $tLOGFONT , " FaceName ", " Verdana " ) 
   $hFont = _WinAPI_CreateFontIndirect ( $tLOGFONT ) 
   _GUICtrlDTP_SetMCFont ( $hDTP , $hFont ) 
 
   ; 获取月历字体句柄 
   GUICtrlSetData ( $iMemo , " Font Handle:  " & " 0x ", & Hex ( _GUICtrlDTP_GetMCFont ( $hDTP ) , 6 ) & @CRLF , 1 ) 
 
   ; 循环至用户退出 
   Do 
   Until GUIGetMsg () = $GUI_EVENT_CLOSE 
   GUIDelete () 
 EndFunc ;==>_Main 
 
 ; 向memo控件写入一行 
 Func MemoWrite( $sMessage ) 
   GUICtrlSetData ( $iMemo , $sMessage & @CRLF , 1 ) 
 EndFunc ;==>MemoWrite 
 
