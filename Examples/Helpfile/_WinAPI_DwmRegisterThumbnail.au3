#include <WinApiEx.au3>

Opt('MustDeclareVars ', 1)

If Not _WinAPI_DwmIsCompositionEnabled() Then
	msgbox(16, 'Error ', 'Require Windows Vista or above with enabled Aero theme.')
	Exit
EndIf

Global $hForm, $hWnd, $hThumbnail, $tSize, $tDestRect, $tSrcRect, $Width, $Height

Run(@SystemDir & ' \calc.exe')
$hWnd = WinWaitActive('Calculator ', '', 3)
If Not $hWnd Then
	Exit
EndIf

; 创建界面
$hForm = GUICreate('MyGUI ', 400, 400)

GUISetBkColor(0)

_WinAPI_DwmExtendFrameIntoClientArea($hForm)

; 创建DWM缩略图关系(2:1)
$hThumbnail = _WinAPI_DwmRegisterThumbnail($hForm, $hWnd)
$tSize = _WinAPI_DwmQueryThumbnailSourceSize($hThumbnail)
$Width = DllStructGetData($tSize, 1)
$Height = DllStructGetData($tSize, 2)
$tDestRect = _WinAPI_CreateRectEx((400 - $Width / 2) / 2, (400 - $Height / 2) / 2, $Width / 2, $Height / 2)
$tSrcRect = _WinAPI_CreateRectEx(-20, -20, $Width + 40, $Height + 40)
_WinAPI_DwmUpdateThumbnailProperties($hThumbnail, 1, 0, 255, $tDestRect, $tSrcRect)

GUISetState()

Do
Until GUIGetMsg() = -3

