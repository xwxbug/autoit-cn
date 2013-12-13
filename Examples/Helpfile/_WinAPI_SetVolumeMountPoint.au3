#include <WinAPIFiles.au3>
#include <MsgBoxConstants.au3>

Global Const $sPath = @TempDir & '\Mount\'

Local $GUID = _WinAPI_GetVolumeNameForVolumeMountPoint(@HomeDrive & '\')

DirCreate($sPath)
_WinAPI_SetVolumeMountPoint($sPath, $GUID)
MsgBox($MB_SYSTEMMODAL, '', 'The drive (' & StringUpper(@HomeDrive) & ') has been associated with "' & $sPath & '".')
_WinAPI_DeleteVolumeMountPoint($sPath)
DirRemove($sPath)
