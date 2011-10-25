#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

; 将鼠标箭头的范围控制在左上角400x400的范围内
_WinAPI_ClipCursor( _WinAPI_CreateRectEx(0, 0, 400, 400))
Sleep(5000)
; 取消限制
_WinAPI_ClipCursor(0)

