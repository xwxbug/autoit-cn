#include <FTPEx.au3>
#include <Array.au3>

$server = 'ftp.csx.cam.ac.uk'
$username = ''
$pass = ''

$Open = _FTP_Open('MyFTP Control')
$Conn = _FTP_Connect($Open, $server, $username, $pass)

$aFile = _FTP_ListToArrayEx($Conn, 0)
_ArrayDisplay($aFile)

$Ftpc = _FTP_Close($Open)
