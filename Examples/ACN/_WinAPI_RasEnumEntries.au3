#Include  <Array.au3>
#Include  <WinAPIEx.au3>

Global $Ras = _WinAPI_RasEnumEntries()
_arraydisplay($Ras, 'RasEnumEntries')

