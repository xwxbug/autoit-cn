;*******************************************************
; 例 1 - 获取和显示 Word.au3 版本信息
;******************************************************
#include <Word.au3>
$aVersion = _Word_VersionInfo()
msgbox(0, "Word.au3 Version ", $aVersion[5] & " released" & $aVersion[4])

