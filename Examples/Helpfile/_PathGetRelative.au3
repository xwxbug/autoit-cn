#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GuiConstantsEx.au3>
#include <EditConstants.au3>
#include <WindowsConstants.au3>
#include <File.au3>

Global $iMemo

_Main()

Func _Main()
	Local $from, $to, $path
	Local $sFile = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt", "InstallDir")

	; 创建界面
	GUICreate("String Instert", 400, 300)
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, BitOR($ES_AUTOVSCROLL, $ES_READONLY))
	GUISetState()

	$from = @ScriptDir
	memowrite("Source Path:" & $from & @CRLF)
	$to = $sFile & "\autoit3.exe"
	memowrite("Dest Path:" & $to & @CRLF)
	$path = _PathGetRelative($from, $to)
	If @error Then
		memowrite("Error:" & @error & @CRLF)
		memowrite("Path:" & $path & @CRLF)
	Else
		memowrite("Relative Path:" & $path & @CRLF)
		memowrite("Resolved Path:" & _PathFull($from & "\" & $path) & @CRLF)
	EndIf
endfunc   ;==>_Main

Func memowrite($s_text)
	GUICtrlSetData($iMemo, $s_text, 1)
endfunc   ;==>memowrite

