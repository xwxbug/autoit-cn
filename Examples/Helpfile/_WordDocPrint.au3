 ;******************************************************* 
 ; 示例 1 - 创建word窗口, 打开文档, 设置文本, 默认值打印，不保存退出 
 ;******************************************************* 
 ; 
 #include  <Word.au3> 
 $oWordApp = _WordCreate ( @ScriptDir & " \Test.doc " ) 
 $oDoc = _WordDocGetCollection ( $oWordApp , 0 ) 
 $oDoc .Range.Text = " This is some text to print. " 
 _WordDocPrint ( $oDoc ) 
 _WordQuit ( $oWordApp , 0 ) 
 
 ;******************************************************* 
 ; 示例 2 - 创建word窗口, 打开文档, 设置文本, 大纲打印，不保存退出 
 ;******************************************************* 
 ; 
 #include  <Word.au3> 
 $oWordApp = _WordCreate ( @ScriptDir & " \Test.doc " ) 
 $oDoc = _WordDocGetCollection ( $oWordApp , 0 ) 
 $oDoc .Range.Text = " This is some text to print. " 
 _WordDocPrint ( $oDoc , 0 , 1 , 1 ) 
 _WordQuit ( $oWordApp , 0 ) 
 
 ;******************************************************* 
 ; 示例 3 - 创建word窗口, 打开文档, 设置文本, 打印到名为"My Printer" 
 ;          的打印机，不保存退出. 
 ;******************************************************* 
 ; 
 #include  <Word.au3> 
 $oWordApp = _WordCreate ( @ScriptDir & " \Test.doc " ) 
 $oDoc = _WordDocGetCollection ( $oWordApp , 0 ) 
 $oDoc .Range.Text = " This is some text to print. " 
 _WordDocPrint ( $oDoc , 0 , 1 , 0 , 1 , " My Printer " ) 
 _WordQuit ( $oWordApp , 0 ) 
 
