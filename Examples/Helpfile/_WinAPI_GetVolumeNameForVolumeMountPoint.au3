#include <WinApiEx.au3>

Global $GUID = _WinAPI_GetVolumeNameForVolumeMountPoint(@HomeDrive & ' \')

DirCreate($sPath)
_WinAPI_SetVolumeMountPoint($sPath, $GUID)
msgbox(0, '', 'The drive ('& StringUpper(@HomeDrive) & ' ) has been associated with "'& $sPath & ' " .')
_WinAPI_DeleteVolumeMountPoint($sPath)

