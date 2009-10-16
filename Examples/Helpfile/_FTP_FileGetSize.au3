#include <FTPEx.au3>

$server = 'ftp.csx.cam.ac.uk'
$username = ''
$pass = ''

$Open = _FTP_Open('MyFTP Control')
$Conn = _FTP_Connect($Open, $server, $username, $pass)

Local $h_Handle
$aFile = _FTP_FindFileFirst($Conn, "/pub/software/programming/pcre/", $h_Handle)
ConsoleWrite('$Filename = ' & $aFile[10] & ' attribute = ' & $aFile[1] & '  -> Error code: ' & @error & ' extended: ' & @extended & @crlf)

$dirset=_FTP_DirSetCurrent($Conn, "/pub/software/programming/pcre/")
ConsoleWrite('$dirset = ' & $dirset & '  -> Error code: ' & @error & ' extended: ' & @extended  & @crlf)

$FileSize = _FTP_FileGetSize($Conn, $aFile[10])
ConsoleWrite('$Filename = ' & $aFile[10] & ' size = ' & $FileSize & '  -> Error code: ' & @error & ' extended: ' & @extended  & @crlf)

Local $Err, $Message
$FileSize = _FTP_GetLastResponseInfo($Err, $Message)	; error =  Contrib: Not a regular file
ConsoleWrite('$Message = ' & $Message & ' err = ' & $Err & '  -> Error code: ' & @error & ' extended: ' & @extended  & @crlf)

$aFile = _FTP_FindFileNext($h_Handle)
ConsoleWrite('$FilenameNext1 = ' & $aFile[10] & ' attribute = ' & $aFile[1] & '  -> Error code: ' & @error & ' extended: ' & @extended  & @crlf)

$FileSize = _FTP_FileGetSize($Conn, $aFile[10])
ConsoleWrite('$FilenameNext1 = ' & $aFile[10] & ' size = ' & $FileSize & '  -> Error code: ' & @error & ' extended: ' & @extended  & @crlf)

$FileSize = _FTP_GetLastResponseInfo($Err, $Message)	; no error
ConsoleWrite('$Message = ' & $Message & ' err = ' & $Err & '  -> Error code: ' & @error & ' extended: ' & @extended  & @crlf)

$FindClose = _FTP_FindFileClose($h_Handle)

$Ftpc = _FTP_Close($Open)
