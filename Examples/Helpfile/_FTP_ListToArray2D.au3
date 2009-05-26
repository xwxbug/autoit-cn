#include <FTPEx.au3>

$server = 'ftp.csx.cam.ac.uk'
$username = ''
$pass = ''

$Open = _FTP_Open('MyFTP Control')
$Conn = _FTP_Connect($Open, $server, $username, $pass)

$aFile = _FTP_ListToArray2D($Conn, 0)
ConsoleWrite('$Filename = ' & $aFile[0][0] & '  -> Error code: ' & @error & @crlf)
ConsoleWrite('$Filename = ' & $aFile[1][0] & ' size = ' & $aFile[1][1] & @error & @crlf)
ConsoleWrite('$Filename = ' & $aFile[2][0] & ' size = ' & $aFile[2][1] & @crlf)

$Ftpc = _FTP_Close($Open)
