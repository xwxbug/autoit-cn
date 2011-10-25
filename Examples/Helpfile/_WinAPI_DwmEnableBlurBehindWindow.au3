#include <WinApiEx.au3>

Opt('MustDeclareVars ', 1)

If Not _WinAPI_DwmIsCompositionEnabled() Then
	msgbox(16, 'Error ', 'Require Windows Vista or above with enabled Aero theme.')
	Exit
EndIf

Global $hForm, $hRgn

; 创建界面
$hForm = GUICreate('MyGUI ', 400, 400)

GUISetBkColor(0)

; 为指定区域创建玻璃"板"效果. 无论何时切换DWM组成都需调用该函数
_WinAPI_DwmIsCompositionEnabled()
If Not @extended Then
	$hRgn = _WinAPI_CreateEllipticRgn( _WinAPI_CreateRectEx(50, 50, 300, 300))
Else
	$hRgn = 0
EndIf
_WinAPI_DwmEnableBlurBehindWindow($hForm, 1, 0, $hRgn)
If $hRgn Then
	_WinAPI_FreeObject($hRgn)
EndIf

GUISetState()

Do
Until GUIGetMsg() = -3

