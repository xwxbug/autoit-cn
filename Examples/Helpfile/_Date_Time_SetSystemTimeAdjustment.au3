#include <Date.au3>
#include <WinAPI.au3>

; 由于系统安全性,在 Vista 中 Windows API "SetSystemTimeAdjustment" 可能被拒绝

_Main()

Func _Main()
	Local $aInfo

	; 打开时钟这样我们可以观察到有趣的现象
	Run("RunDll32.exe shell32.dll,Control_RunDLL timedate.cpl")
	WinWaitActive("[CLASS:#32770]")

	; 获取当前时间调整设置
	$aInfo = _Date_Time_GetSystemTimeAdjustment()

	; 减慢时钟
	If Not _Date_Time_SetSystemTimeAdjustment($aInfo[1] / 10, False) Then
		MsgBox(4096, "Error", "System clock cannot be DOWN" & @CRLF & @CRLF & _WinAPI_GetLastErrorMessage())
		Exit
	EndIf
	MsgBox(4096, "Information", "Slowing down system clock", 2)

	Sleep(5000)

	; 加快时钟
	If Not _Date_Time_SetSystemTimeAdjustment($aInfo[1] * 10, False) Then
		MsgBox(4096, "Error", "System clock cannot be UP" & @CRLF & @CRLF & _WinAPI_GetLastErrorMessage())
	EndIf
	MsgBox(4096, "Information", "Speeding up system clock", 2)

	Sleep(5000)

	; 重设时间调整设置
	If Not _Date_Time_SetSystemTimeAdjustment($aInfo[1], True) Then
		MsgBox(4096, "Error", "System clock cannot be RESET" & @CRLF & @CRLF & _WinAPI_GetLastErrorMessage())
	Else
		MsgBox(4096, "Information", "System clock restored")
	EndIf

EndFunc   ;==>_Main
