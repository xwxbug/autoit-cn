;CONSTANTS
Global Const $AW_FADE_IN = 0x00080000;fade-in
Global Const $AW_FADE_OUT = 0x00090000;fade-out
Global Const $AW_SLIDE_IN_LEFT = 0x00040001;slide in from left
Global Const $AW_SLIDE_OUT_LEFT = 0x00050002;slide out to left
Global Const $AW_SLIDE_IN_RIGHT = 0x00040002;slide in from right
Global Const $AW_SLIDE_OUT_RIGHT = 0x00050001;slide out to right
Global Const $AW_SLIDE_IN_TOP = 0x00040004;slide-in from top
Global Const $AW_SLIDE_OUT_TOP = 0x00050008;slide-out to top
Global Const $AW_SLIDE_IN_BOTTOM = 0x00040008;slide-in from bottom
Global Const $AW_SLIDE_OUT_BOTTOM = 0x00050004;slide-out to bottom
Global Const $AW_DIAG_SLIDE_IN_TOPLEFT = 0x00040005;diag slide-in from Top-left
Global Const $AW_DIAG_SLIDE_OUT_TOPLEFT = 0x0005000a;diag slide-out to Top-left
Global Const $AW_DIAG_SLIDE_IN_TOPRIGHT = 0x00040006;diag slide-in from Top-Right
Global Const $AW_DIAG_SLIDE_OUT_TOPRIGHT = 0x00050009;diag slide-out to Top-Right
Global Const $AW_DIAG_SLIDE_IN_BOTTOMLEFT = 0x00040009;diag slide-in from Bottom-left
Global Const $AW_DIAG_SLIDE_OUT_BOTTOMLEFT = 0x00050006;diag slide-out to Bottom-left
Global Const $AW_DIAG_SLIDE_IN_BOTTOMRIGHT = 0x0004000a;diag slide-in from Bottom-right
Global Const $AW_DIAG_SLIDE_OUT_BOTTOMRIGHT = 0x00050005;diag slide-out to Bottom-right
Global Const $AW_EXPLODE = 0x00040010;explode
Global Const $AW_IMPLODE = 0x00050010;implode

Func _WinAnimate($v_gui, $i_mode, $i_duration = 1000)
    If @OSVersion = "WIN_XP" OR @OSVersion = "WIN_2000" Then
        DllCall("user32.dll", "int", "AnimateWindow", "hwnd", WinGetHandle($v_gui), "int", $i_duration, "long", $i_mode)
        Local $ai_gle = DllCall('kernel32.dll', 'int', 'GetLastError')
        If $ai_gle[0] <> 0 Then
            SetError(1)
            Return 0
        EndIf
        Return 1
    EndIf
EndFunc;==> _WinAnimate()

#cs DEMO - For lazy guys like me - to copy paste
    $hwnd = GUICreate("AnimateWindow - Demo", 300, 300)
    _WinAnimate($hwnd, $AW_FADE_IN)
    ConsoleWrite('er: ' & @error & @LF & 'ex: ' & @extended & @CRLF)
    Sleep(1500)
    _WinAnimate($hwnd, $AW_FADE_OUT)
    ConsoleWrite('er: ' & @error & @LF & 'ex: ' & @extended & @CRLF)
    Sleep(1500)
    _WinAnimate($hwnd, $AW_SLIDE_IN_LEFT)
    ConsoleWrite('er: ' & @error & @LF & 'ex: ' & @extended & @CRLF)
    Sleep(1500)
    _WinAnimate($hwnd, $AW_SLIDE_OUT_LEFT)
    ConsoleWrite('er: ' & @error & @LF & 'ex: ' & @extended & @CRLF)
    Sleep(1500)
    _WinAnimate($hwnd, $AW_SLIDE_IN_RIGHT)
    ConsoleWrite('er: ' & @error & @LF & 'ex: ' & @extended & @CRLF)
    Sleep(1500)
    _WinAnimate($hwnd, $AW_SLIDE_OUT_RIGHT)
    ConsoleWrite('er: ' & @error & @LF & 'ex: ' & @extended & @CRLF)
    Sleep(1500)
    _WinAnimate($hwnd, $AW_SLIDE_IN_TOP)
    ConsoleWrite('er: ' & @error & @LF & 'ex: ' & @extended & @CRLF)
    Sleep(1500)
    _WinAnimate($hwnd, $AW_SLIDE_OUT_TOP)
    ConsoleWrite('er: ' & @error & @LF & 'ex: ' & @extended & @CRLF)
    Sleep(1500)
    _WinAnimate($hwnd, $AW_SLIDE_IN_BOTTOM)
    ConsoleWrite('er: ' & @error & @LF & 'ex: ' & @extended & @CRLF)
    Sleep(1500)
    _WinAnimate($hwnd, $AW_SLIDE_OUT_BOTTOM)
    ConsoleWrite('er: ' & @error & @LF & 'ex: ' & @extended & @CRLF)
    Sleep(1500)
    _WinAnimate($hwnd, $AW_DIAG_SLIDE_IN_TOPLEFT)
    ConsoleWrite('er: ' & @error & @LF & 'ex: ' & @extended & @CRLF)
    Sleep(1500)
    _WinAnimate($hwnd, $AW_DIAG_SLIDE_OUT_TOPLEFT)
    ConsoleWrite('er: ' & @error & @LF & 'ex: ' & @extended & @CRLF)
    Sleep(1500)
    _WinAnimate($hwnd, $AW_DIAG_SLIDE_IN_TOPRIGHT)
    ConsoleWrite('er: ' & @error & @LF & 'ex: ' & @extended & @CRLF)
    Sleep(1500)
    _WinAnimate($hwnd, $AW_DIAG_SLIDE_OUT_TOPRIGHT)
    ConsoleWrite('er: ' & @error & @LF & 'ex: ' & @extended & @CRLF)
    Sleep(1500)
    _WinAnimate($hwnd, $AW_DIAG_SLIDE_IN_BOTTOMLEFT)
    ConsoleWrite('er: ' & @error & @LF & 'ex: ' & @extended & @CRLF)
    Sleep(1500)
    _WinAnimate($hwnd, $AW_DIAG_SLIDE_OUT_BOTTOMLEFT)
    ConsoleWrite('er: ' & @error & @LF & 'ex: ' & @extended & @CRLF)
    Sleep(1500)
    _WinAnimate($hwnd, $AW_DIAG_SLIDE_IN_BOTTOMRIGHT)
    ConsoleWrite('er: ' & @error & @LF & 'ex: ' & @extended & @CRLF)
    Sleep(1500)
    _WinAnimate($hwnd, $AW_DIAG_SLIDE_OUT_BOTTOMRIGHT)
    ConsoleWrite('er: ' & @error & @LF & 'ex: ' & @extended & @CRLF)
    Sleep(1500)
    _WinAnimate($hwnd, $AW_EXPLODE)
    ConsoleWrite('er: ' & @error & @LF & 'ex: ' & @extended & @CRLF)
    Sleep(1500)
    _WinAnimate($hwnd, $AW_IMPLODE)
    ConsoleWrite('er: ' & @error & @LF & 'ex: ' & @extended & @CRLF)
#ce
