#include <WinAPILocale.au3>
#include <APILocaleConstants.au3>

Local $ID = _WinAPI_GetUserGeoID()

ConsoleWrite('ID:        0x' & Hex($ID) & @CRLF)
ConsoleWrite('Latitude:  ' & _WinAPI_GetGeoInfo($ID, $GEO_LATITUDE) & @CRLF)
ConsoleWrite('Longitude: ' & _WinAPI_GetGeoInfo($ID, $GEO_LONGITUDE) & @CRLF)
ConsoleWrite('Name:      ' & _WinAPI_GetGeoInfo($ID, $GEO_FRIENDLYNAME) & @CRLF)
ConsoleWrite('ISO code:  ' & _WinAPI_GetGeoInfo($ID, $GEO_ISO3) & @CRLF)
