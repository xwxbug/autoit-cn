#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

Run(@SystemDir & '\taskmgr.exe')

MsgBox(64 + 262144, '', 'Look at the memory used by the "' & _WinAPI_PathStripPath(FileGetLongName(@AutoItExe)) & '" process.')

; 分配内存来创建数组
Dim $Data[1000000]
For $i = 0 To UBound($Data) - 1
	$Data[$i] = 'AutoIt v3 is a freeware BASIC-like scripting language designed for automating the Windows GUI and general scripting. It uses a combination of simulated keystrokes, mouse movement and window/control manipulation in order to automate tasks in a way not possible or reliable with other languages (e.g. VBScript and SendKeys). AutoIt is also very small, self-contained and will run on all versions of Windows out-of-the-box with no annoying "runtimes" required!'
Next

MsgBox(64 + 262144, '', 'Step 1')

; 清空工作集
_WinAPI_EmptyWorkingSet()

MsgBox(64 + 262144, '', 'Step 2')

; 从数据中读取数据
For $i = 0 To UBound($Data) - 1
	If $Data[$i] Then
		; 某些
	EndIf
Next

MsgBox(64 + 262144, '', 'Step 3')

; 清空工作集
_WinAPI_EmptyWorkingSet()

MsgBox(64 + 262144, '', 'Step 4')
