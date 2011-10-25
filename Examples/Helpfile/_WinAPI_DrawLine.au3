
#include <WindowsConstants.au3>
#include <WinAPI.au3>

ShowCros(@DesktopWidth / 2, @DesktopHeight / 2, 20, 2, 0xFF, 3000)

Func ShowCross($start_x, $start_y, $length, $width, $color, $time)
	Local $hDC, $hPen, $obj_orig

	$hDC = _WinAPI_GetWindowDC(0) ; 全部屏幕的场景(桌面)
	$hPen = _WinAPI_CreatePen($PS_SOLID, $width, $color)
	$obj_orig = _WinAPI_SelectObject($hDC, $hPen)

	_WinAPI_DrawLine($hDC, $start_x - $length, $start_y, $start_x - 5, $start_y) ; 水平左
	_WinAPI_DrawLine($hDC, $start_x + $length, $start_y, $start_x + 5, $start_y) ; 水平右
	_WinAPI_DrawLine($hDC, $start_x, $start_y - $length, $start_x, $start_y - 5) ; 垂直上
	;_WinAPI_DrawLine($hDC, $start_x, $start_y + $length, $start_x, $start_y + 5) ; 垂直下
	_WinAPI_MoveTo($hDC, $start_x, $start_y + $length)
	_WinAPI_LineTo($hDC, $start_x, $start_y + 5)

	Sleep($time) ; 穿过屏幕几秒

	; 刷新桌面(清扫穿过)
	_WinAPI_RedrawWindow( _WinAPI_GetDesktopWindow(), 0, 0, $RDW_INVALIDATE + $RDW_ALLCHILDREN)

	; 清除资源
	_WinAPI_SelectObject($hDC, $obj_orig)
	_WinAPI_DeleteObject($hPen)
	_WinAPI_ReleaseDC(0, $hDC)
endfunc   ;==>ShowCross

