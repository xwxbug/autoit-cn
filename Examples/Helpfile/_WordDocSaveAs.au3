 ; ******************************************************* 
 ; 示例 - 打开word窗口新建空白文档, 添加文本, 执行另存操作，然后退出. 
 ; ******************************************************* 
 #include  <Word.au3> 
 $oWordApp = _WordCreate () 
 $oDoc = _WordDocGetCollection ( $oWordApp , 0 ) 
 $oDoc.Range.Text = " This is some text to insert. " 
 _WordDocSaveAs ( $oDoc , @ScriptDir & " \Test.doc " ) 
 _WordQuit ( $oWordApp ) 
 
