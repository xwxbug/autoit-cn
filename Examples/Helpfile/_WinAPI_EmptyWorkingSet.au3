#include <WinAPIProc.au3>
#include <MsgBoxConstants.au3>

Run(@SystemDir & '\taskmgr.exe')
Sleep(1000)

MsgBox(BitOR($MB_ICONINFORMATION, $MB_SYSTEMMODAL), 'Step 0', 'Look at the memory used by the "' & _WinAPI_PathStripPath(FileGetLongName(@AutoItExe)) & '" (' & @AutoItPID & ') process.')

; Allocate memory to create an array
Local $Data[1000000]
For $i = 0 To UBound($Data) - 1
	$Data[$i] = 'AutoIt v3 is a freeware BASIC-like scripting language designed for automating the Windows GUI and general scripting. It uses a combination of simulated keystrokes, mouse movement and window/control manipulation in order to automate tasks in a way not possible or reliable with other languages (e.g. VBScript and SendKeys). AutoIt is also very small, self-contained and will run on all versions of Windows out-of-the-box with no annoying "runtimes" required!'
Next

MsgBox(BitOR($MB_ICONINFORMATION, $MB_SYSTEMMODAL), 'Step 1', 'Allocate memory to create an array')

; Empty the working set
_WinAPI_EmptyWorkingSet()

MsgBox(BitOR($MB_ICONINFORMATION, $MB_SYSTEMMODAL), 'Step 2', 'Empty the working set')

; Read data from an array
For $i = 0 To UBound($Data) - 1
	If $Data[$i] Then
		; Something
	EndIf
Next

MsgBox(BitOR($MB_ICONINFORMATION, $MB_SYSTEMMODAL), 'Step 3', 'Read data from an array')

; Empty the working set
_WinAPI_EmptyWorkingSet()

MsgBox(BitOR($MB_ICONINFORMATION, $MB_SYSTEMMODAL), 'Step 4', 'Empty the working set')
