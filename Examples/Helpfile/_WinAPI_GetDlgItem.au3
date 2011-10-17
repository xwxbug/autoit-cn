 #AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 Opt ( 'MustDeclareVars' , 1 ) 
 
 #include <WinAPI.au3> 
 
 _Main () 
 
 Func _Main () 
   Local $hwnd , $button 
   $hwnd = GUICreate ( "test" ) 
   $button = GUICtrlCreateButton ( "button" , 0 , 0 ) 
   MsgBox ( 4096 , "Handle" , "Get Dialog Item: " & _WinAPI_GetDlgItem ( $hwnd , $button )) 
 EndFunc    ;==>_Main 
