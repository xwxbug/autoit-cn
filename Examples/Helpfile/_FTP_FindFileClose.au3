#include <FTPEx.au3>

$server = 'ftp.csx.cam.ac.uk'
$username = ''
$pass = ''

$Open = _FTP_Open('MyFTP Control')
$Conn = _FTP_Connect($Open, $server, $username, $pass)

Local $h_Handle
$aFile = _FTP_FindFileFirst($Conn, "/pub/software/programming/pcre/", $h_Handle)

$FindClose = _FTP_FindFileClose($h_Handle)
ConsoleWrite('$FindClose = ' & $FindClose & '  -> Error code: ' & @error & @crlf)

$Ftpc = _FTP_Close($Open)
