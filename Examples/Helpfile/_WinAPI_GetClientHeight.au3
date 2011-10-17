 #AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 Opt ( ' MustDeclareVars ', 1 ) 
 
 #include  <WinAPI.au3> 
 
 _Main() 
 
 Func _Main () 
   Local $hwnd 
   $hwnd = GUICreate ( " test " ) 
   MsgBox ( 4096 , " Client ", " Client Height:  " & _WinAPI_GetClientHeight ( $hwnd )) 
 EndFunc    ;==>_Main 
 
