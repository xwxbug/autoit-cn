$server = 'ftp.example.com'
$username = 'secretusers'
$pass = 'hiddenpass'

$Open = _FTPOpen('MyFTP Control')
$Conn = _FTPConnect($Open, $server, $username, $pass)
$Ftpp = _FtpPutFile($Conn, 'C:\WINDOWS\Notepad.exe', '/somedir/Example.exe')
$Ftpc = _FTPClose($Open)