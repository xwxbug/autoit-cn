#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Error = _WinAPI_NtStatusToDosError(0xC0000023) ; STATUS_BUFFER_TOO_SMALL

msgbox(0, $Error, _WinAPI_GetErrorMessage($Error))

