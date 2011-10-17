 #AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 Opt ( 'MustDeclareVars' , 1 ) 
 
 #includ <WinAPI.au3> 
 
 MsgBox ( 4096 , "Handle" , "Get Foreground Window: " & _WinAPI_GetForegroundWindow ()) 
 
