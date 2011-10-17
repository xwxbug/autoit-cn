 ; ******************************************************* 
 ; 创建一个word窗体, 打开一个文档, 检查状态栏是否可见, 
 ; 如果可见则关闭, 如果不可见则打开. 
 ; ******************************************************* 
 
 #include  <Word.au3> 
 $oWordApp  =  _WordCreate  ( @ScriptDir  &  "\Test.doc" ) 
 If  _WordPropertyGet  ( $oWordApp ,  "statusbar" )  Then 
     MsgBox ( 0 ,  "StatusBar Status" ,  "StatusBar Visible, turning it off." ) 
     _WordPropertySet  ( $oWordApp ,  "statusbar" ,  False ) 
 Else 
     MsgBox ( 0 ,  "StatusBar Status" ,  "StatusBar Invisible, turning it on." ) 
     _WordPropertySet  ( $oWordApp ,  "statusbar" ,  True ) 
 EndIf 
 
