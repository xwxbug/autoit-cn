; *******************************************************
; 示例 1 - 创建含新的空文档的 word 窗口,
;				添加链接, 然后获取链接集合.
; *******************************************************
;
#include <Word.au3>

Local $oWordApp = _WordCreate()
Local $oDoc = _WordDocGetCollection($oWordApp, 0)
_WordDocAddLink($oDoc, "", "www.AutoIt3.com", "", "AutoIt" & @CRLF, "Link to AutoIt")
Local $oLinks = _WordDocLinkGetCollection($oDoc)
MsgBox(4096, "Link Count", @extended)
