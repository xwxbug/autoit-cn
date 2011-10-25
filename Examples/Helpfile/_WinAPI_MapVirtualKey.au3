#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

msgbox(0, 'result ', 'Virtual-key code: 0x' & Hex($VK_A) & @CRLF & _
		' Scan code: 0x' & Hex( _WinAPI_MapVirtualKey($VK_A, $MAPVK_VK_TO_VSC)))

