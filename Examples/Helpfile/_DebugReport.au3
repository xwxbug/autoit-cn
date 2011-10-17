 AutoItSetOption ( " MustDeclareVars ",  1 ) 
 
 #include <Debug.au3> 
 
 _DebugSetup () 
 
 _DebugReport ( " message1 " ) 
 _DebugReport ( " message2 ",  True ) ; 追加最近的错误消息 
 
