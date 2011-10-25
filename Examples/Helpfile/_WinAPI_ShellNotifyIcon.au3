#Include  <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $hWnd = WinGetHandle( AutoItWinGetTitle())
Global $tNOTIFYICONDATA = DllStructCreate($tagNOTIFYICONDATA)

DllStructSetData($tNOTIFYICONDATA, 'Size ', DllStructGetSize($tNOTIFYICONDATA))
DllStructSetData($tNOTIFYICONDATA, 'hWnd ', WinGetHandle( AutoItWinGetTitle()))
DllStructSetData($tNOTIFYICONDATA, 'Flags ', $NIF_ICON)

DllStructSetData($tNOTIFYICONDATA, 'ID ', 2)
DllStructSetData($tNOTIFYICONDATA, 'hIcon ', _WinAPI_ShellExtractIcon(@SystemDir & ' \shell32.dll ', 166, 32, 32))
_WinAPI_ShellNotifyIcon($NIM_ADD, $tNOTIFYICONDATA)

DllStructSetData($tNOTIFYICONDATA, 'ID ', 3)
DllStructSetData($tNOTIFYICONDATA, 'hIcon ', _WinAPI_ShellExtractIcon(@SystemDir & ' \shell32.dll ', 130, 32, 32))
_WinAPI_ShellNotifyIcon($NIM_ADD, $tNOTIFYICONDATA)

While 1
	Sleep(100)
WEnd

Func OnAutoItExit()
	DllStructSetData($tNOTIFYICONDATA, 'ID ', 2)
	_WinAPI_ShellNotifyIcon($NIM_DELETE, $tNOTIFYICONDATA)
	DllStructSetData($tNOTIFYICONDATA, 'ID ', 3)
	_WinAPI_ShellNotifyIcon($NIM_DELETE, $tNOTIFYICONDATA)
endfunc   ;==>OnAutoItExit

