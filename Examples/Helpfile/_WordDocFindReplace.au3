 ; ******************************************************* 
 ; 示例 - 创建word窗口, 打开一个文件, 查找"this", 
 ;         用"THIS"替换所有找到的, 不保存推出. 
 ; ******************************************************* 
 #include <Word.au3> 
 $oWordApp = _WordCreate ( @ScriptDir & "\Test.doc" ) 
 $oDoc = _WordDocGetCollection ( $oWordApp , 0 ) 
 $oFind = _WordDocFindReplace ( $oDoc , "this" , "THIS" ) 
 If $oFind Then 
     MsgBox ( 0 , "FindReplace" , "Found and replaced." ) 
 Else 
     MsgBox ( 0 , "FindReplace" , "Not Found" ) 
 EndIf 
 _WordQuit ( $oWordApp , 0 ) 
 
