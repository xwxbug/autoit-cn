 #include <Misc.au3> 
 Local $fTest 
 $fTest = _ClipPutFile ( @ScriptFullPath ) 
 If Not $fTest Then 
   MsgBox ( 0 , " _ClipPutFile() call Failed ", " @error =  " & @error ) 
 Else 
   MsgBox ( 0 , " _ClipPutFile() ", " Content of Clipboard: " & ClipGet ()) 
 EndIf 
 
