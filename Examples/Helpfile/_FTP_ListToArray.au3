#include <FTPEx.au3>

$server = 'ftp.csx.cam.ac.uk'
$username = ''
$pass = ''

$Open = _FTP_Open('MyFTP Control')
$Conn = _FTP_Connect($Open, $server, $username, $pass)

$aFile = _FTP_ListToArray($Conn, 2)
ConsoleWrite('$NbFound = ' & $aFile[0] & '  -> Error code: ' & @error & @crlf)
ConsoleWrite('$Filename = ' & $aFile[1] & @crlf)

$Ftpc = _FTP_Close($Open)
