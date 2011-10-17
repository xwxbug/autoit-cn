 ; ******************************************************* 
 ; 示例 1 - 创建一个Microsoft Word window 并打开一个文档 
 ; ******************************************************* 
 #include <Word.au3> 
 $oWordApp = _WordCreate ( @ScriptDir & " \Test.doc " ) 
 
 ; ******************************************************* 
 ; 示例 2 - 尝试将一个存在的word窗口连接到一个打开的指定文件. 
 ;         如果不存在则创建新窗口打开文件. 
 ; ******************************************************* 
 #include <Word.au3> 
 $oWordApp = _WordCreate ( @ScriptDir & " \Test.doc ", 1 ) 
 ; 检查@extended返回值以查看连接是否成功 
 If @extended Then 
     MsgBox ( 0 , "", " Attached to Existing Window " ) 
 Else 
     MsgBox ( 0 , "", " Created New Window " ) 
 EndIf 
 
 ; ******************************************************* 
 ; 示例 3 - 创建一个带空白文档的word窗体 
 ; ******************************************************* 
 #include <Word.au3> 
 $oWordApp = _WordCreate () 
 
 ; ******************************************************* 
 ; 示例 4 - 创建一个隐藏的word窗体并打开一个文件, 
 ;         添加一些文本后保存退出. 
 ; ******************************************************* 
 #include <Word.au3> 
 $oWordApp = _WordCreate ( @ScriptDir & " \Test.doc " , 0 , 0 ) 
 $oDoc = _WordDocGetCollection ( $oWordApp , 0 ) 
 $oDoc.Range.insertAfter ( " This is some text to insert. " ) 
 _WordQuit ( $oWordApp , -1 ) 
 
