#include <WinAPIFiles.au3>
#include <MsgBoxConstants.au3>

Local $Drive = DriveGetDrive('CDROM')

If IsArray($Drive) Then
	_WinAPI_LockDevice($Drive[1], 1)
	MsgBox($MB_SYSTEMMODAL, '', 'The drive (' & StringUpper($Drive[1]) & ') is locked.')
	_WinAPI_LockDevice($Drive[1], 0)
	MsgBox($MB_SYSTEMMODAL, '', 'The drive (' & StringUpper($Drive[1]) & ') is unlocked.')
EndIf
