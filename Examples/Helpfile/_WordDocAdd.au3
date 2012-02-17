; *******************************************************
; 示例 - 创建一个空白word窗口并添加一个空白文件
; *******************************************************
;
#include <Word.au3>

Local $oWordApp = _WordCreate("")
Local $oDoc = _WordDocAdd($oWordApp)
