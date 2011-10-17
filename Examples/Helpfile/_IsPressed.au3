
 #include <Misc.au3> 
 
 $dll = DllOpen ( "user32.dll" ) 
 
 While 1 
   Sleep ( 250 ) 
   If _IsPressed ( "23" , $dll ) Then 
     MsgBox ( 0 , "_IsPressed" , "End Key Pressed" ) 
     ExitLoop 
   EndIf 
 WEnd 
 DllClose ( $dll ) 
 
