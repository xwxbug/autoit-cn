#include <WinAPIShellEx.au3>
#include <WinAPISys.au3>
#include <WinAPIGdi.au3>
#include <MsgBoxConstants.au3>

If _WinAPI_GetVersion() < '6.1' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows 7 or later.')
	Exit
EndIf

Local $tRECT = _WinAPI_ShellNotifyIconGetRect(WinGetHandle(AutoItWinGetTitle()), 1)

Local $Pos
If Not @error Then
	$Pos = _WinAPI_GetPosFromRect($tRECT)
	MouseMove($Pos[0] + 12, $Pos[1] + 12)
	MouseClick('left')
	While 1
		Sleep(1000)
	WEnd
EndIf
