#include <WinAPIGdi.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>

Global Const $Text = 'String' & @TAB & 'with' & @TAB & 'tab' & @TAB & 'characters'

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 0, 0, -1, -1, BitOR($WS_CAPTION, $WS_POPUP, $WS_SYSMENU))
GUICtrlCreateLabel($Text, 0, 0)
GUICtrlSetFont(-1, 26, 400, 0, 'Comic Sans MS')

; Compute dimensions of a string and resize the window
Local $Size = _GetTabbedStringSize(-1, $Text)
If IsArray($Size) Then
	GUICtrlSetPos(-1, 0, 0, $Size[0], $Size[1])
	Local $Pos = WinGetPos($hForm)
	If Not @error Then
		WinMove($hForm, '', (@DesktopWidth - ($Pos[2] + $Size[0])) / 2, (@DesktopHeight - ($Pos[3] + $Size[1])) / 2, $Pos[2] + $Size[0], $Pos[3] + $Size[1])
	EndIf
EndIf

; Show GUI
GUISetState()

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func _GetTabbedStringSize($hWnd, $sText)
	Local $tTM = DllStructCreate($tagTEXTMETRIC)

	If Not IsHWnd($hWnd) Then
		$hWnd = GUICtrlGetHandle($hWnd)
		If Not $hWnd Then Return 0
	EndIf

	Local $hDC = _WinAPI_GetDC($hWnd)
	Local $hFont = _SendMessage($hWnd, $WM_GETFONT)
	Local $hSv = _WinAPI_SelectObject($hDC, $hFont)
	Local $Tab = 0
	Local $Ret = DllCall('gdi32.dll', 'int', 'GetTextMetricsW', 'handle', $hDC, 'struct*', $tTM)
	If Not @error And $Ret[0] Then
		$Tab = 8 * DllStructGetData($tTM, 'tmAveCharWidth')
	EndIf
	Local $Size = 0
	Local $tSIZE = _WinAPI_GetTabbedTextExtent($hDC, $sText, $Tab)
	If Not @error Then
		Dim $Size[2]
		For $i = 0 To 1
			$Size[$i] = DllStructGetData($tSIZE, $i + 1)
		Next
	EndIf
	_WinAPI_SelectObject($hDC, $hSv)
	_WinAPI_ReleaseDC($hWnd, $hDC)
	Return $Size
EndFunc   ;==>_GetTabbedStringSize
