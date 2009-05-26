#include <FTPEx.au3>

$server = 'ftp.csx.cam.ac.uk'
$username = ''
$pass = ''

$Open = _FTP_Open('MyFTP Control')
$Conn = _FTP_Connect($Open, $server, $username, $pass)
; ...
$Ftpc = _FTP_Close($Open)
