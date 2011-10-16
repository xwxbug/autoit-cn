#Include <APIConstants.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

Global Const $STM_SETIMAGE = 0x0172

Global $hIcon, $hOverlay, $hResult

; 创建带遮罩(层叠)的图标(48x48)
$hIcon = _WinAPI_ShellExtractIcon(@SystemDir & '\shell32.dll', 1, 32, 32)
If _WinAPI_GetVersion() >= '6.0' Then
	$hOverlay = _WinAPI_ShellExtractIcon(@SystemDir & '\imageres.dll', 154, 32, 32)
Else
	$hOverlay = _WinAPI_ShellExtractIcon(@SystemDir & '\shell32.dll', 29, 32, 32)
EndIf
$hResult = _WinAPI_AddIconOverlay($hIcon, $hOverlay)
_WinAPI_DestroyIcon($hIcon)
_WinAPI_DestroyIcon($hOverlay)

; 创建 GUI
GUICreate('MyGUI', 128, 128)
GUICtrlCreateIcon('', 0, 48, 48, 32, 32)
GUICtrlSendMsg(-1, $STM_SETIMAGE, 1, $hResult)
GUISetState()

Do
Until GUIGetMsg() = -3
