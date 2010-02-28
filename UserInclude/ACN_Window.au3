#include-once
; _API_AnimateWindow() Commands
Global Const $AW_HOR_POSITIVE =            0x00000001
Global Const $AW_HOR_NEGATIVE =            0x00000002
Global Const $AW_VER_POSITIVE =            0x00000004
Global Const $AW_VER_NEGATIVE =            0x00000008
Global Const $AW_CENTER       =            0x00000010
Global Const $AW_HIDE         =            0x00010000
Global Const $AW_ACTIVATE     =            0x00020000
Global Const $AW_SLIDE        =            0x00040000
Global Const $AW_BLEND        =            0x00080000

; #FUNCTION# ====================================================================================================================
; Name...........:	_API_AnimateWindow
; Description ...:	动画窗口(比如百叶窗显示窗口)
; Syntax.........:	_API_AnimateWindow( $hwnd,$dwTime=200,$dwFlags)
; Parameters ....:	$hwnd	-	窗口句柄
; 					$dwTime	-	显示动画时间,单位为毫秒,默认200毫秒.
;					$dwFlags	-	显示效果
;						$AW_SLIDE	-	Uses slide animation. By default, roll animation is used. This flag is ignored when used with AW_CENTER. 
;						$AW_ACTIVATE	-	Activates the window. Do not use this value with AW_HIDE. 
;						$AW_BLEND	-	Uses a fade effect. This flag can be used only if hwnd is a top-level window. 
;						$AW_HIDE	-	Hides the window. By default, the window is shown. 
;						$AW_CENTER	-	Makes the window appear to collapse inward if AW_HIDE is used or expand outward if the AW_HIDE is not used. The various direction flags have no effect. 
;						$AW_HOR_POSITIVE	-	Animates the window from left to right. This flag can be used with roll or slide animation. It is ignored when used with AW_CENTER or AW_BLEND.
;						$AW_HOR_NEGATIVE	-	Animates the window from right to left. This flag can be used with roll or slide animation. It is ignored when used with AW_CENTER or AW_BLEND.
;						$AW_VER_POSITIVE	-	Animates the window from top to bottom. This flag can be used with roll or slide animation. It is ignored when used with AW_CENTER or AW_BLEND. 
;						$AW_VER_NEGATIVE	-	Animates the window from bottom to top. This flag can be used with roll or slide animation. It is ignored when used with AW_CENTER or AW_BLEND. 
; Return values .:	如果函数成功, 返回值为非 0.
;					如果函数失败, 返回值为 0. 
; Author ........:	thesnoW(rundll32@126.com)
; Modified.......:
; Remarks .......:	The function will fail in the following situations: 
;					If the window uses the window region. Windows XP: This does not cause the function to fail.
;					If the window is already visible and you are trying to show the window.
;					If the window is already hidden and you are trying to hide the window.
;					If there is no direction specified for the slide or roll animation.
;					When trying to animate a child window with AW_BLEND. 
;					If the thread does not own the window. Note that, in this case, AnimateWindow fails but GetLastError returns ERROR_SUCCESS.
;					To get extended error information, call the GetLastError function.
; Related .......:
; Link ..........; 
; Example .......;	No
; ===============================================================================================================================
Func _API_AnimateWindow( $hwnd,$dwTime=200,$dwFlags=0x1)
	Local $dll=DllOpen('user32.dll')
	If $dll = -1 Then Return -1
	Local $ret=DllCall($dll,"bool","AnimateWindow","HWnd",$hwnd,"dword",$dwTime,"dword",$dwFlags)
	DllClose($dll)
	Return $ret[0]
EndFunc   ;==>_API_AnimateWindow

