#include <WinAPIGdi.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

If Not _WinAPI_DwmIsCompositionEnabled() Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later with enabled Aero theme.')
	Exit
EndIf

Run(@SystemDir & '\calc.exe')
Local $hWnd = WinWaitActive("[CLASS:CalcFrame]", '', 3)
If Not $hWnd Then
	Exit
EndIf

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 400)

GUISetBkColor(0)

; Create the "sheet of glass" effect for the entire window. You must call this function whenever DWM composition is toggled.
_WinAPI_DwmExtendFrameIntoClientArea($hForm)

; Create a DWM thumbnail relationship (2:1)
Local $hThumbnail = _WinAPI_DwmRegisterThumbnail($hForm, $hWnd)
Local $tSIZE = _WinAPI_DwmQueryThumbnailSourceSize($hThumbnail)
Local $Width = DllStructGetData($tSIZE, 1)
Local $Height = DllStructGetData($tSIZE, 2)
Local $tDestRect = _WinAPI_CreateRectEx((400 - $Width / 2) / 2, (400 - $Height / 2) / 2, $Width / 2, $Height / 2)
Local $tSrcRect = _WinAPI_CreateRectEx(-20, -20, $Width + 40, $Height + 40)
_WinAPI_DwmUpdateThumbnailProperties($hThumbnail, 1, 0, 255, $tDestRect, $tSrcRect)

GUISetState()

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

WinClose("[CLASS:CalcFrame]", "")
