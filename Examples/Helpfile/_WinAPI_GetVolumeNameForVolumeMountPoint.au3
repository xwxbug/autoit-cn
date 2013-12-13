#include <WinAPIFiles.au3>
#include <MsgBoxConstants.au3>

Local $sPath = @TempDir & '\Mount'
Local $Count = 0

While FileExists($sPath & $Count)
	$Count += 1
WEnd

$sPath &= $Count & '\'

If Not DirCreate($sPath) Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Unable to create folder.')
	Exit
EndIf

Local $GUID = _WinAPI_GetVolumeNameForVolumeMountPoint(@HomeDrive & '\')
If _WinAPI_SetVolumeMountPoint($sPath, $GUID) Then
	MsgBox(BitOR($MB_ICONINFORMATION, $MB_SYSTEMMODAL), '', 'The drive "' & StringUpper(@HomeDrive) & '" has been associated with "' & $sPath & '".' & @CRLF & @CRLF & 'Press OK to unmount folder.')
	_WinAPI_DeleteVolumeMountPoint($sPath)
Else
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Unable to mount folder.')
EndIf

DirRemove($sPath)
