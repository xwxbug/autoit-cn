; *******************************************************
; 示例 1 - 创建含新的空文档的 word 窗口,
;				添加第二个空文档, 并且获取文档集合.
; *******************************************************
;
#include <Word.au3>

Local $oWordApp = _WordCreate()
_WordDocAdd($oWordApp)
Local $oDocuments = _WordDocGetCollection($oWordApp)
MsgBox(4096, "Document Count", @extended)
_WordQuit($oWordApp)
