
#include  <FTPEx.au3>
#include  <Array.au3>

$server = 'ftp.csx.cam.ac.uk'
$username = ''
$pass = ''

$Open = _FTP_Open('MyFTP Control')
$Conn = _FTP_Connect($Open, $server, $username, $pass)

$aFile = _WinINet_FtpListToArrayEx($Conn, 0)
_arraydisplay($aFile)

$Ftpc = _FTP_Close($Open)

