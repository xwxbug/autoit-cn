; *******************************************************
; 示例 1 - 创建含新的空文档的 word 窗口,
;				然后添加一些图片到文档.
; *******************************************************
;
#include <Word.au3>

Local $sPath = @WindowsDir & "\"
Local $search = FileFindFirstFile($sPath & "*.bmp")

; 检查搜索是否成功
If $search = -1 Then
	MsgBox(4096, "Error", "No images found")
	Exit
EndIf

Local $oWordApp = _WordCreate()
Local $oDoc = _WordDocGetCollection($oWordApp, 0)

While 1
	Local $file = FileFindNextFile($search)
	If @error Then ExitLoop
	Local $oShape = _WordDocAddPicture($oDoc, $sPath & $file, 0, 1)
	If Not @error Then $oShape.Range.InsertAfter(@CRLF)
WEnd

; 关闭搜索句柄
FileClose($search)
