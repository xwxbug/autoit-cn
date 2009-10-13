' SpellCheck v4
' Адаптировал классический скрипт для SciTE: mozers™
' Обход ошибки Word 2003: Lex1
' -----------------------------------------------------------------------
' Проверка орфографии выделенного текста с помощью объекта "Word.Application"
' т.е. необходимо чтобы на машине был установлен MS Word с компонентом "Проверка орфографии"
' Для подключения добавьте в свой файл .properties следующие строки:
' command.name.22.*=Проверка орфографии
' command.22.*=wscript "$(SciteDefaultHome)\tools\SpellCheck.vbs"
' command.input.22.*=$(CurrentSelection)
' command.mode.22.*=subsystem:windows,replaceselection:auto,savebefore:no,quiet:yes
' -----------------------------------------------------------------------
Option Explicit
Dim objWord, exit_code, Text_In, Text_Out, TextRange

Text_In = WScript.StdIn.ReadAll
If len(Text_In) > 1 then
	Set objWord = WScript.CreateObject("Word.Application")
	objWord.WindowState = 2 'wdWindowStateMinimize
	objWord.Visible = False
	objWord.Documents.Add
	objWord.Selection = Text_In
	exit_code = 1

	On Error Resume Next
	Set TextRange = objWord.ActiveDocument.Range(0,objWord.Selection.End)
	If Not objWord.CheckSpelling(TextRange) Or Not objWord.CheckGrammar(TextRange) Then
		If Err.Number = 0 Then
			objWord.ActiveDocument.CheckGrammar
		Else
			objWord.ActiveDocument.CheckSpelling
		End If
		Text_Out = objWord.ActiveDocument.Range(0,objWord.Selection.End)
		If Text_Out <> Text_In Then
			WScript.StdOut.Write Text_Out
			exit_code = 0
		end if
	End If

	objWord.ActiveDocument.Close 0 'wdDoNotSaveChanges
	objWord.Quit True
	Set objWord = Nothing

	if exit_code = 1 Then MsgBox "Текст не содержит ошибок" & vbNewLine & "или была выбрана ""Отмена""", vbInformation, "Проверка орфографии"
Else
	MsgBox "Сначала необходимо выделить проверяемый текст!", vbExclamation, "Проверка орфографии"
End If
WScript.Quit (exit_code)