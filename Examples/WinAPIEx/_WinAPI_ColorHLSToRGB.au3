#Include <EditConstants.au3>
#Include <GUIConstantsEx.au3>
#Include <StaticConstants.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

Global $hForm, $Msg, $Data, $Label, $Slider, $Input1, $Input2, $Input3, $Input4, $Hue, $Luminance, $Saturation, $RGB = 0xFF9C00

_WinAPI_ColorRGBToHLS($RGB, $Hue, $Luminance, $Saturation)

$hForm = GUICreate('MyGUI', 300, 298)
GUICtrlCreateLabel('', 20, 20, 120, 120)
GUICtrlSetBkColor(-1, $RGB)
$Label = GUICtrlCreateLabel('', 160, 20, 120, 120)
GUICtrlSetBkColor(-1, $RGB)
$Slider = GUICtrlCreateSlider(20, 160, 260, 26)
GUICtrlSetLimit(-1, 240, 0)
GUICtrlSetData(-1, $Luminance)
GUICtrlCreateLabel('Hue:', 20, 209, 30, 14, $SS_RIGHT)
GUICtrlCreateInput($Hue, 53, 206, 30, 19, $ES_READONLY)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateLabel('Sat:', 20, 235, 30, 14, $SS_RIGHT)
GUICtrlCreateInput($Saturation, 53, 232, 30, 19, $ES_READONLY)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateLabel('Lum:', 20, 261, 30, 14, $SS_RIGHT)
$Input1 = GUICtrlCreateInput($Luminance, 53, 258, 30, 19, $ES_READONLY)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetColor(-1, 0x000000)
GUICtrlCreateLabel('Reg:', 98, 209, 38, 14, $SS_RIGHT)
$Input2 = GUICtrlCreateInput(_WinAPI_GetRValue($RGB), 139, 206, 30, 19, $ES_READONLY)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetColor(-1, 0x000000)
GUICtrlCreateLabel('Green:', 98, 235, 38, 14, $SS_RIGHT)
$Input3 = GUICtrlCreateInput(_WinAPI_GetGValue($RGB), 139, 232, 30, 19, $ES_READONLY)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetColor(-1, 0x000000)
GUICtrlCreateLabel('Blue:', 98, 261, 38, 14, $SS_RIGHT)
$Input4 = GUICtrlCreateInput(_WinAPI_GetBValue($RGB), 139, 258, 30, 19, $ES_READONLY)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetColor(-1, 0x000000)

GUISetState()

Do
	$Data = GUICtrlRead($Slider)
	If $Data <> $Luminance Then
		$Luminance = $Data
		$RGB = _WinAPI_ColorHLSToRGB($Hue, $Luminance, $Saturation)
		GUICtrlSetBkColor($Label, $RGB)
		GUICtrlSetData($Input1, $Data)
		GUICtrlSetData($Input2, _WinAPI_GetRValue($RGB))
		GUICtrlSetData($Input3, _WinAPI_GetGValue($RGB))
		GUICtrlSetData($Input4, _WinAPI_GetBValue($RGB))
	EndIf
Until GUIGetMsg() = -3
