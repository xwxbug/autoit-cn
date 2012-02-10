;=============================
;例子1:显示当前目录中所有文件的文件名
;=============================
Local $hSearch = FileFindFirstFile("*.*")

; 检查搜索是否成功
If $hSearch = -1 Then
	MsgBox(4096, "错误", "没有文件/目录 匹配搜索")
	Exit
EndIf

While 1
	Local $sFile = FileFindNextFile($hSearch)
	If @error Then ExitLoop

	MsgBox(4096, "找到的文件:", $sFile)
WEnd

; 关闭搜索句柄
FileClose($hSearch)

;=============================
;例子2:递归查找当前目录及其子目录下的所有文件
;=============================
FindAllFile(@ScriptDir)
Func FindAllFile($sDir)
	Local $hSearch = FileFindFirstFile($sDir & "\*.*")
	; 检查搜索是否成功
	If $hSearch = -1 Then Return
	While 1
		Local $sFile = FileFindNextFile($hSearch)
		If @error Then ExitLoop
		
		If @extended Then 
			FindAllFile($sDir & "\" & $sFile)
			ContinueLoop
		EndIf
		FileWriteLine("找到的文件.txt",$sDir & "\" & $sFile)
	WEnd
	; 关闭搜索句柄
	FileClose($hSearch)
EndFunc