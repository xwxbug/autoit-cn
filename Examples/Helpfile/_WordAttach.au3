 ; **************************************************************** 
 ; 示例 1 - 将word窗口连接到名为"Test.doc"的打开文件, 然后显示文件的完整路径 
 ; **************************************************************** 
 #include <Word.au3> 
 $oWordApp = _WordAttach ( "Test.doc" , "FileName" ) 
 If Not @error Then 
   $oDoc = _WordDocGetCollection ( $oWordApp , 0 ) 
   MsgBox ( 64 , "Document FileName" , $oDoc.FullName ) 
 EndIf 
 
 ; **************************************************************** 
 ; 示例 2 - 将word窗口连接到包含"The quick brown fox"文本的文档 
 ; **************************************************************** 
 #include <Word.au3> 
 $oWordApp = _WordAttach ( "The quick brown fox" , "Text" ) 
 
