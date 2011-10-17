
 #AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 
 #include <WinHTTP.au3> 
 
 if _WinHttpCheckPlatform () Then 
    MsgBox ( '', ' Info ', ' This platform is supported by WinHTTP. ' ) 
 else 
    MsgBox ( '', ' Info ', ' This platform is NOT supported by WinHTTP. ' ) 
 EndIf 

