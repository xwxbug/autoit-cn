#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $Data = _WinAPI_GetDiskFreeSpaceEx(@HomeDrive)

msgbox("", "disk space ", 'Total available free space on' & @HomeDrive & ' =>' & $Data[0] & '  bytes' & @CR & _
		' Total available space on' & @HomeDrive & ' =>' & $Data[1] & '  bytes' & @CR & _
		' Total free space on' & @HomeDrive & ' =>' & $Data[2] & '  bytes')

