; *******************************************************
; 示例 1 - 创建空白文档的word窗口, 并获取文档的集合.
; *******************************************************
#include  <Word.au3>
$oWordApp = _WordCreate()
_WordDocAdd($oWordApp)
$oDocuments = _WordDocGetCollection($oWordApp)
msgbox(0, "Document Count ", @extended)
_WordQuit($oWordApp)

