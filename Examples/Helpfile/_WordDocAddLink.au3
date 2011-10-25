; *******************************************************
; 示例 - 创建一个新建空白文件的word窗体, 添加一个链接,
;         然后得到一个链接的集合.
; *******************************************************
#include <Word.au3>
$oWordApp = _WordCreate()
$oDoc = _WordDocGetCollection($oWordApp, 0)
_WordDocAddLink($oDoc, "", "www.AutoIt3.com ", "", "AutoIt" & @CRLF, "Link to AutoIt ")
$oLinks = _WordDocLinkGetCollection($oDoc)
msgbox(0, "Link Count ", @extended)

