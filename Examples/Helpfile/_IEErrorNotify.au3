 ; ******************************************************* 
 ; 检查_IEErrorNotify的当前状态, 如果为打开时关闭, 关闭则打开 
 ; ******************************************************* 
 ; 
 #include <IE.au3> 
 If _IEErrorNotify () Then 
   MsgBox ( 0 , " _IEErrorNotify Status ", " span class=S7>Notification is ON, turning it OFF " ) 
   _IEErrorNotify ( False ) 
 Else 
   MsgBox ( 0 , " _IEErrorNotify Status ", " span class=S7>Notification is OFF, turning it ON " ) 
   _IEErrorNotify ( True ) 
 EndIf 
 
