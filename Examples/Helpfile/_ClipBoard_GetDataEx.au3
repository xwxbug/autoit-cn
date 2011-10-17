 #include <GuiConstantsEx.au3> 
 #include <ClipBoard.au3> 
 #include <WindowsConstants.au3> 
 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 Global $iMemo 
 
 _Main() 
 
 Func _Main() 
 >  Local $hGUI , $btn_SetData , $btn_GetData , $hMemory , $tData 
 
   ; 创建界面 
   $hGUI = GUICreate ( " Clipboard ", 400 , 350 ) 
   $iMemo = GUICtrlCreateEdit ( "", 2 , 2 , 396 , 296 , $WS_VSCROLL ) 
   GUICtrlSetFont ( $iMemo , 9 , 400 , 0 , " Courier New " ) 
   $btn_SetData = GUICtrlCreateButton ( " Set ClipBoard Data ", 50 , 310 , 120 , 30 ) 
   $btn_GetData = GUICtrlCreateButton ( " Get ClipBoard Data ", 210 , 310 , 120 , 30 ) 
   GUISetState () 
 
   ; 循环至用户退出 
   While 1 
     Switch GUIGetMsg () 
       Case $GUI_EVENT_CLOSE 
         ExitLoop 
       Case $btn_SetData 
         _ClipBoard_SetData ( " ClipBoard Library " ) 
       Case $btn_GetData 
         ; 打开剪贴板 
         If Not _ClipBoard_Open ( $hGUI ) Then _WinAPI_ShowError ( " _ClipBoard_Open failed " ) 
 
         ; 读取剪贴板文本 
         $hMemory = _ClipBoard_GetDataEx ( $CF_TEXT ) 
         If $hMemory = 0 Then _WinAPI_ShowError ( " _ClipBoard_GetDataEx failed " ) 
         ; 关闭剪贴版 
         _ClipBoard_Close () 
         $tData = DllStructCreate ( " char Text[8192] ", $hMemory ) 
         MemoWrite( DllStructGetData ( $tData , " Text " )) 
     EndSwitch 
   WEnd 
 
 EndFunc ;==>_Main 
 
 ; 向memo写入信息 
 Func MemoWrite ( $sMessage = "" ) 
   GUICtrlSetData ( $iMemo , $sMessage & @CRLF , 1 ) 
 EndFunc    ;==>MemoWrite 
 
