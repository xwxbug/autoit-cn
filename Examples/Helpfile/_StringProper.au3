 #include <String.au3> 
 ; 将返回: Somebody Lastnames 
 Msgbox ( 0 , '', _StringProper ( " somebody lastnames " )) 
 ; 将返回: Some.Body Last(Name) 
 Msgbox ( 0 , '', _StringProper ( " SOME.BODY LAST(NAME) " )) 
 Exit 
 
