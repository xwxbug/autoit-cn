#include <WinAPIProc.au3>
#include <ProcessConstants.au3>
#include <WinAPI.au3>
#include <WinAPISys.au3>
#include <Array.au3>

Global Const $PID = @AutoItPID

Local $hSource, $hTarget, $hObject

Local $Data = _WinAPI_EnumProcessHandles($PID)

If IsArray($Data) Then
	$hTarget = _WinAPI_GetCurrentProcess()
	$hSource = _WinAPI_OpenProcess($PROCESS_DUP_HANDLE, 0, $PID)
	If $hSource Then
		For $i = 1 To $Data[0][0]
			$hObject = _WinAPI_DuplicateHandle($hSource, $Data[$i][0], $hTarget, 0, 0, 2)
			If Not @error Then
				$Data[$i][1] = _WinAPI_GetObjectNameByHandle($hObject)
				_WinAPI_CloseHandle($hObject)
			EndIf
		Next
	EndIf
EndIf

_ArrayDisplay($Data, '_WinAPI_EnumProcessHandles')
