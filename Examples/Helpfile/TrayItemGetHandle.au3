#include <Constants.au3>

Opt("TrayMenuMode", 1) ; 不显示默认关联菜单

Global Const $MIM_APPLYTOSUBMENUS = 0x80000000
Global Const $MIM_BACKGROUND = 0x00000002

TraySetIcon("shell32.dll", 21)
TraySetToolTip("这里有一个小例子显示带颜色的托盘图标" & @LF & "只需你的系统高于 Windows 2000 就能看到.")

Local $OptionsMenu	= TrayCreateMenu("选项")
TrayCreateItem("总在最前", $OptionsMenu)
TrayItemSetState(-1, $TRAY_CHECKED)
TrayCreateItem("总是重复", $OptionsMenu)
TrayCreateItem("")
Local $AboutItem	= TrayCreateItem("关于")
TrayCreateItem("")
Local $ExitItem		= TrayCreateItem("退出例子")

SetMenuColor(0, 0xEEBB99)   ; BGR 颜色值, '0' 的意思是托盘关联菜单自己.
SetMenuColor($OptionsMenu, 0x66BB99); BGR 颜色值

While 1
	Local $Msg = TrayGetMsg()

	Switch $Msg
		Case $ExitItem
			ExitLoop

		Case $AboutItem
			MsgBox(64, "关于...", "带颜色的托盘图标例子")
	EndSwitch
WEnd

Exit


; 应用菜单颜色
Func SetMenuColor($nMenuID, $nColor)
	Local $hMenu  = TrayItemGetHandle($nMenuID) ; 得到内部菜单句柄

	Local $hBrush = DllCall("gdi32.dll", "hwnd", "CreateSolidBrush", "int", $nColor)
	$hBrush = $hBrush[0]

	Local $stMenuInfo = DllStructCreate("dword;dword;dword;uint;dword;dword;ptr")
	DllStructSetData($stMenuInfo, 1, DllStructGetSize($stMenuInfo))
	DllStructSetData($stMenuInfo, 2, BitOR($MIM_APPLYTOSUBMENUS, $MIM_BACKGROUND))
	DllStructSetData($stMenuInfo, 5, $hBrush)

	DllCall("user32.dll", "int", "SetMenuInfo", "hwnd", $hMenu, "ptr", DllStructGetPtr($stMenuInfo))
EndFunc   ;==>SetMenuColor
