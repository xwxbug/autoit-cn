#include <WinApiEx.au3>

Opt('MustDeclareVars ', 1)

Global $hPseudo = _WinAPI_GetCurrentProcess()
Global $hReal = _WinAPI_DuplicateHandle($hPseudo, $hPseudo, $hPseudo)

msgbox(64, '_WinAPI_DuplicateHandle ', 'Process name:' & _WinAPI_GetProcessName() & @CRLF & _
		' Process ID:' & _WinAPI_GetCurrentProcessID() & @CRLF & _
		' Pseudo handle:' & $hPseudo & @CRLF & _
		' Real handle:' & $hReal)

_WinAPI_CloseHandle($hReal)

