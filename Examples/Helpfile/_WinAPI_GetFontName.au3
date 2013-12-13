#include <WinAPIGdi.au3>
#include <FontConstants.au3>

Local Const $FaceName = 'Arial'

ConsoleWrite($FaceName & ' Regular => ' & _WinAPI_GetFontName($FaceName, $FS_REGULAR) & @CRLF)
ConsoleWrite($FaceName & ' Bold => ' & _WinAPI_GetFontName($FaceName, $FS_BOLD) & @CRLF)
ConsoleWrite($FaceName & ' Italic => ' & _WinAPI_GetFontName($FaceName, $FS_ITALIC) & @CRLF)
ConsoleWrite($FaceName & ' Bold Italic => ' & _WinAPI_GetFontName($FaceName, BitOR($FS_BOLD, $FS_ITALIC)) & @CRLF)
