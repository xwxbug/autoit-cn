#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <WinAPI.au3>

; 获取窗口标题高度及窗口框架宽度 - 开启/关闭XP主题时可能不同
Global $htit = _WinAPI_GetSystemMetrics($SM_CYCAPTION)
Global $frame = _WinAPI_GetSystemMetrics($SM_CXDLGFRAME)

Local $gui = GUICreate("Test Windows regions", 350, 210)
Local $btn_default = GUICtrlCreateButton("Default region", 100, 30, 150)
Local $btn_round = GUICtrlCreateButton("Round region", 100, 60, 150)
Local $btn_buble = GUICtrlCreateButton("Buble region ", 100, 90, 150)
Local $btn_transparent = GUICtrlCreateButton("Transparent region", 100, 120, 150)
Local $btn_exit = GUICtrlCreateButton("Exit", 100, 150, 150)
GUISetState(@SW_SHOW)

Local $pos = WinGetPos($gui) ; 获取整个窗口大小(GUICreate定义的窗口不包含客户区)
Global $width = $pos[2]
Global $height = $pos[3]

Local $msg, $rgn
While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = $GUI_EVENT_CLOSE Or $msg = $btn_exit
			ExitLoop

		Case $msg = $btn_default
			$rgn = _WinAPI_CreateRectRgn(0, 0, $width, $height)
			_WinAPI_SetWindowRgn($gui, $rgn)

		Case $msg = $btn_round
			$rgn = _WinAPI_CreateRoundRectRgn(0, 0, $width, $height, $width / 3, $height / 3)
			_WinAPI_SetWindowRgn($gui, $rgn)

		Case $msg = $btn_buble
			Local $rgn1 = _WinAPI_CreateRoundRectRgn(0, 0, $width / 2, $height / 2, $width / 2, $height / 2) ; 左上
			Local $rgn2 = _WinAPI_CreateRoundRectRgn($width / 2, 0, $width, $height / 2, $width / 2, $height / 2) ; 右上
			_WinAPI_CombineRgn($rgn1, $rgn1, $rgn2, $RGN_OR)
			_WinAPI_DeleteObject($rgn2)
			$rgn2 = _WinAPI_CreateRoundRectRgn(0, $height / 2, $width / 2, $height, $width / 2, $height / 2) ; 左下
			_WinAPI_CombineRgn($rgn1, $rgn1, $rgn2, $RGN_OR)
			_WinAPI_DeleteObject($rgn2)
			$rgn2 = _WinAPI_CreateRoundRectRgn($width / 2, $height / 2, $width, $height, $width / 2, $height / 2) ; 右下
			_WinAPI_CombineRgn($rgn1, $rgn1, $rgn2, $RGN_OR)
			_WinAPI_DeleteObject($rgn2)
			$rgn2 = _WinAPI_CreateRoundRectRgn(10, 10, $width - 10, $height - 10, $width, $height) ; 中间
			_WinAPI_CombineRgn($rgn1, $rgn1, $rgn2, $RGN_OR)
			_WinAPI_DeleteObject($rgn2)
			_WinAPI_SetWindowRgn($gui, $rgn1)

		Case $msg = $btn_transparent
			_GuiHole($gui, 40, 40, 260, 170)

	EndSelect
WEnd

; 将内部区域透明并添加控件
Func _GuiHole($h_win, $i_x, $i_y, $i_sizew, $i_sizeh)
	Local $outer_rgn, $inner_rgn, $combined_rgn

	$outer_rgn = _WinAPI_CreateRectRgn(0, 0, $width, $height)
	$inner_rgn = _WinAPI_CreateRectRgn($i_x, $i_y, $i_x + $i_sizew, $i_y + $i_sizeh)
	$combined_rgn = _WinAPI_CreateRectRgn(0, 0, 0, 0)
	_WinAPI_CombineRgn($combined_rgn, $outer_rgn, $inner_rgn, $RGN_DIFF)
	_WinAPI_DeleteObject($outer_rgn)
	_WinAPI_DeleteObject($inner_rgn)
	_AddCtrlRegion($combined_rgn, $btn_default)
	_AddCtrlRegion($combined_rgn, $btn_round)
	_AddCtrlRegion($combined_rgn, $btn_buble)
	_AddCtrlRegion($combined_rgn, $btn_transparent)
	_AddCtrlRegion($combined_rgn, $btn_exit)
	_WinAPI_SetWindowRgn($h_win, $combined_rgn)
EndFunc   ;==>_GuiHole

; 根据窗口标题/外观尺寸添加控制区域
Func _AddCtrlRegion($full_rgn, $ctrl_id)
	Local $ctrl_pos, $ctrl_rgn

	$ctrl_pos = ControlGetPos($gui, "", $ctrl_id)
	$ctrl_rgn = _WinAPI_CreateRectRgn($ctrl_pos[0] + $frame, $ctrl_pos[1] + $htit + $frame, _
			$ctrl_pos[0] + $ctrl_pos[2] + $frame, $ctrl_pos[1] + $ctrl_pos[3] + $htit + $frame)
	_WinAPI_CombineRgn($full_rgn, $full_rgn, $ctrl_rgn, $RGN_OR)
	_WinAPI_DeleteObject($ctrl_rgn)
EndFunc   ;==>_AddCtrlRegion
