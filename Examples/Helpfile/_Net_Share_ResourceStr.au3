 
 #include  <GuiConstantsEx.au3> 
 #include  <NetShare.au3> 
 #include  <WindowsConstants.au3> 
 
 Opt ( 'MustDeclareVars' ,  1 ) 
 
 Global  $iMemo 
 
 _Main () 
 
 Func _Main () 
     Local  $hGUI ,  $sServer ,  $sShare ,  $aInfo 
 
     ; 创建界面 
     $hGUI  =  GUICreate ( "NetShare" ,  400 ,  300 ) 
 
     ; 创建memo控件 
     $iMemo  =  GUICtrlCreateEdit ( "" ,  2 ,  2 ,  396 ,  296 ,  $WS_VSCROLL ) 
     GUICtrlSetFont ( $iMemo ,  9 ,  400 ,  0 ,  "Courier New" ) 
     GUISetState () 
 
     ; 获取服务器及共享信息 
     $sServer  =  InputBox ( "NetWork Demo" ,  "Enter Server Name:" ,  "\\MyServer" ,  "" ,  200 ,  130 ) 
     If  @error  Then  Exit 
 
     $sShare  =  InputBox ( "NetWork Demo" ,  "Enter Share Name:" ,  "MyShare" ,  "" ,  200 ,  130 ) 
     If  @error  Then  Exit 
 
     ; 枚举网络连接 
     $aInfo  =  _Net_Share_ConnectionEnum  ( $sServer ,  $sShare ) 
     MemoWrite ( "Error ...................: "  &  @error ) 
     MemoWrite ( "Entries read ............: "  &  $aInfo [ 0 ][ 0 ]) 
     For  $iI  =  1  To  $aInfo [ 0 ][ 0 ] 
         MemoWrite ( "Connection ID ...........: "  &  $aInfo [ $iI ][ 0 ]) 
         MemoWrite ( "Connection type..........: "  &  _Net_Share_ResourceStr  ( $aInfo [ $iI ][ 1 ])) 
         MemoWrite ( "Number of files open ....: "  &  $aInfo [ $iI ][ 2 ]) 
         MemoWrite ( "Number of users .........: "  &  $aInfo [ $iI ][ 3 ]) 
         MemoWrite ( "Connection time .........: "  &  $aInfo [ $iI ][ 4 ]) 
         MemoWrite ( "Username ................: "  &  $aInfo [ $iI ][ 5 ]) 
         MemoWrite ( "Network name ............: "  &  $aInfo [ $iI ][ 6 ]) 
         MemoWrite () 
     Next 
 
 
     ; 循环至用户退出 
     Do 
     Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
 EndFunc    ;==>_Main 
 
 ; 向memo控件写入信息 
 Func MemoWrite ( $sMessage  =  "" ) 
     GUICtrlSetData ( $iMemo ,  $sMessage  &  @CRLF ,  1 ) 
 EndFunc    ;==>MemoWrite 
 
