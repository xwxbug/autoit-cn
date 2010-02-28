#include-once
Global $WM_MOUSEACTIVATE				= 0x0021
Global $WM_NCHITTEST					= 0x0084
Global $WM_NCMOUSEMOVE					= 0x00A0
Global $WM_NCLBUTTONDOWN				= 0x00A1
Global $WM_NCLBUTTONUP					= 0x00A2
Global $WM_NCLBUTTONDBLCLK				= 0x00A3
Global $WM_NCRBUTTONDOWN				= 0x00A4
Global $WM_NCRBUTTONUP					= 0x00A5
Global $WM_NCRBUTTONDBLCLK				= 0x00A6
Global $WM_NCMBUTTONDOWN				= 0x00A7
Global $WM_NCMBUTTONUP					= 0x00A8
Global $WM_NCMBUTTONDBLCLK				= 0x00A9
Global $WM_NCXBUTTONDOWN				= 0x00AB
Global $WM_NCXBUTTONUP					= 0x00AC
Global $WM_NCXBUTTONDBLCLK				= 0x00AD
Global $WM_MOUSEFIRST					= 0x0200
Global $WM_MOUSEMOVE					= 0x0200
Global $WM_LBUTTONDOWN					= 0x0201
Global $WM_LBUTTONUP					= 0x0202
Global $WM_LBUTTONDBLCLK				= 0x0203
Global $WM_RBUTTONDOWN					= 0x0204
Global $WM_RBUTTONUP					= 0x0205
Global $WM_RBUTTONDBLCLK				= 0x0206
Global $WM_MBUTTONDOWN					= 0x0207
Global $WM_MBUTTONUP					= 0x0208
Global $WM_MBUTTONDBLCLK				= 0x0209
Global $WM_MOUSEWHEEL					= 0x020A
Global $WM_XBUTTONDOWN                  = 0x020B
Global $WM_XBUTTONUP                    = 0x020C
Global $WM_XBUTTONDBLCLK                = 0x020D
Global $WM_CAPTURECHANGED				= 0x0215
Global $WM_MOUSEHOVER					= 0x02A1
Global $WM_NCMOUSEHOVER					= 0x02A0
Global $WM_NCMOUSELEAVE					= 0x02A2
Global $WM_MOUSELEAVE					= 0x02A3


; #FUNCTION# ====================================================================================================================
; Name...........: _API_GetDoubleClickTime
; Description ...: The GetDoubleClickTime function retrieves the current double-click time for the mouse.
;					A double-click is a series of two clicks of the mouse button, the second occurring within a specified time after the first. 
;					The double-click time is the maximum number of milliseconds that may occur between the first and second click of a double-click. 
; Syntax.........: _API_GetDoubleClickTime()
; Parameters ....: 
; Return values .: The return value specifies the current double-click time, in milliseconds.
; Author ........: thesnoW(rundll32@126.com)
; Modified.......:
; Remarks .......: 
; Related .......:
; Link ..........; http://msdn.microsoft.com/en-us/library/ms646258(VS.85).aspx
; Example .......; Yes
; ===============================================================================================================================
 

Func _API_GetDoubleClickTime()
	Local $rt=DllCall("user32.dll","uint","GetDoubleClickTime")
	Return $rt[0]
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _API_SetDoubleClickTime
; Description ...: The SetDoubleClickTime function sets the double-click time for the mouse. 
;					A double-click is a series of two clicks of a mouse button, the second occurring within a specified time after the first. 
;					The double-click time is the maximum number of milliseconds that may occur between the first and second clicks of a double-click. 
; Syntax.........: _API_SetDoubleClickTime()
; Parameters ....: $uInterval = time with milliseconds(双击间隔时间,单位为毫秒).
; Return values .: Returns 1 if successful(成功); otherwise, 0(失败).
; Author ........: thesnoW(rundll32@126.com)
; Modified.......:
; Remarks .......: 
; Related .......:
; Link ..........; http://msdn.microsoft.com/en-us/library/ms646263(VS.85).aspx
; Example .......; Yes
; ===============================================================================================================================

Func _API_SetDoubleClickTime($uInterval=500)
	Local $rt=DllCall("user32.dll","bool","SetDoubleClickTime","UINT",$uInterval)
	Return $rt[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _API_SwapMouseButton
; Description ...: The SwapMouseButton function reverses or restores the meaning of the left and right mouse buttons. 
; Syntax.........: _API_SwapMouseButton()
; Parameters ....: $fSwap = Specifies whether the mouse button meanings are reversed or restored. 
;					If this parameter is TRUE, the left button generates right-button messages and the right button generates left-button messages. 
;					If this parameter is FALSE, the buttons are restored to their original meanings. 
; Return values .: Returns 1 if successful(成功); otherwise, 0(失败).
; Author ........: thesnoW(rundll32@126.com)
; Modified.......:
; Remarks .......: 
; Related .......:
; Link ..........; http://msdn.microsoft.com/en-us/library/ms646263(VS.85).aspx
; Example .......; _API_SwapMouseButton(0)
; ===============================================================================================================================

Func _API_SwapMouseButton($fSwap=False)
	Local $rt=DllCall("user32.dll","bool","SwapMouseButton","BOOL",$fSwap)
	Return $rt[0]
EndFunc


; 下方函数不易工作,小心使用.
; #FUNCTION# ====================================================================================================================
; Name...........: _API_MouseNotification()
; Description ...: Mouse Notification
; Syntax.........: _API_MouseNotification()
; Parameters ....: 
; Return values .: 
; Author ........: thesnoW(rundll32@126.com)
; Modified.......:
; Remarks .......: 
; Related .......:
; Link ..........; http://msdn.microsoft.com/en-us/library/dd458632(VS.85).aspx
; Example .......; Yes
; ===============================================================================================================================
Func _API_MouseNotification($Window,$Notification,$wParam,$lParam)
	DllCall("user32.dll", "int", "SendMessage", _
        "hwnd",  WinGetHandle( $Window ), _
        "int",   $Notification, _
        "int",   $wParam, _
        "ptr",  DllStructGetPtr($lParam))
EndFunc
	
Func _API_MousePOINTS($X,$Y)
	Local $POINTS=DllStructCreate("int;int")
	DllStructSetData($POINTS,1,$X)
	DllStructSetData($POINTS,2,$Y)
	Return $POINTS
EndFunc	