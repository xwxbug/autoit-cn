#Include <Array.au3>
#Include <WinAPIEx.au3>

Global $Data

$Data = _WinAPI_EnumResourceTypes(@SystemDir & ' \shell32.dll')
_arraydisplay($Data, 'ResourceTypes')
$Data = _WinAPI_EnumResourceNames(@SystemDir & ' \shell32.dll ', $RT_DIALOG)
_arraydisplay($Data, 'ResourceNames')
$Data = _WinAPI_EnumResourceLanguages(@SystemDir & ' \shell32.dll ', $RT_DIALOG, 1003)
_arraydisplay($Data, 'ResourceLanguages')

