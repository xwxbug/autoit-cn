 ; ******************************************************* 
 ; 示例 - 创建空白文档窗口, 添加一个链接，然后获取链接集合 
 ; ******************************************************* 
 ; 
 #include  <Word.au3> 
 $oWordApp = _WordCreate () 
 $oDoc = _WordDocGetCollection ( $oWordApp , 0 ) 
 _WordDocAddLink ( $oDoc , "", " www.AutoIt3.com ", "", " AutoIt " & @CRLF , " Link to AutoIt " ) 
 $oLinks = _WordDocLinkGetCollection ( $oDoc ) 
 MsgBox ( 0 , " Link Count ", @extended ) 
 
