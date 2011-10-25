
#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GuiEdit.au3>
#include <WinAPI.au3> ; used for Lo/Hi word
#include <WindowsConstants.au3>
#include <GuiConstantsEx.au3>

Global $sFile, $hFile, $sText, $nBytes, $tBuffer
Global $iMemo

main()

Func main()

	; 创建界面
	GUICreate("api func", 400, 300)
	$iMemo = GUICtrlCreateEdit("", 2, 2, 394, 296, BitOR($ES_AUTOVSCROLL, $ES_READONLY))
	GUISetState()

	; 1) 创建文件并写入数据
	$sFile = @DesktopDir & '\test.txt'
	$sText = 'abcdefghijklmnopqrstuvwxyz'
	$tBuffer = DllStructCreate("byte[" & StringLen($sText) & "]")
	DllStructSetData($tBuffer, 1, $sText)
	$hFile = _WinAPI_CreateFile($sFile, 1)
	_WinAPI_WriteFile($hFile, DllStructGetPtr($tBuffer), StringLen($sText), $nBytes)
	_WinAPI_CloseHandle($hFile)
	MemoWrite('1)' & FileRead($sFile) & @LF)

	; 2) 从位置3读取6字节
	$tBuffer = DllStructCreate("byte[6]")
	$hFile = _WinAPI_CreateFile($sFile, 2, 2)
	_WinAPI_SetFilePointer($hFile, 3)
	_WinAPI_ReadFile($hFile, DllStructGetPtr($tBuffer), 6, $nBytes)
	_WinAPI_CloseHandle($hFile)
	$sText = BinaryToString( DllStructGetData($tBuffer, 1))
	MemoWrite('2)' & $sText & @LF)

	; 3) 在相同位置大写写入从位置3读取的6字节
	DllStructSetData($tBuffer, 1, StringUpper($sText))
	$hFile = _WinAPI_CreateFile($sFile, 2, 4)
	_WinAPI_SetFilePointer($hFile, 3)
	_WinAPI_WriteFile($hFile, DllStructGetPtr($tBuffer), 6, $nBytes)
	_WinAPI_CloseHandle($hFile)
	$tBuffer = 0
	MemoWrite('3)' & FileRead($sFile) & @LF)

	; 4) 将文本大小截为12字节
	$hFile = _WinAPI_CreateFile($sFile, 2, 4)
	_WinAPI_SetFilePointer($hFile, 12)
	_WinAPI_SetEndOfFile($hFile)
	_WinAPI_CloseHandle($hFile)
	MemoWrite('4)' & FileRead($sFile) & @LF)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>main

Func memowrite($s_text)
	GUICtrlSetData($iMemo, $s_text & @CRLF, 1)
endfunc   ;==>memowrite

