#include <FTPEx.au3>
#include <Debug.au3>

_DebugSetup( StringTrimRight(@ScriptName,4) &' example', True)

$server = 'ftp.mozilla.org'
$username = ''
$pass = ''

$Open = _FTP_Open('MyFTP Control')
$Callback = _FTP_SetStatusCallback($Open, 'FTPStatusCallbackHandler')

$Conn = _FTP_Connect($Open, $server, $username, $pass, 0, $INTERNET_DEFAULT_FTP_PORT, $INTERNET_SERVICE_FTP, 0, $Callback)

$Ftpc = _FTP_Close($Open)

Func FTPStatusCallbackHandler($hInternet, $dwContent, $dwInternetStatus, $lpvStatusInformation, $dwStatusInformationLength)
	If $dwInternetStatus = $INTERNET_STATUS_REQUEST_SENT  Or $dwInternetStatus = $INTERNET_STATUS_RESPONSE_RECEIVED Then
		Local $Size, $iBytesRead
		$Size = DllStructCreate('dword')
		_WinAPI_ReadProcessMemory(_WinAPI_GetCurrentProcess(), $lpvStatusInformation, DllStructGetPtr($Size), $dwStatusInformationLength, $iBytesRead)
		_DebugOut(_FTP_DecodeInternetStatus($dwInternetStatus) & ' | Size = ' & DllStructGetData($Size, 1) & ' Bytes    Bytes read = ' & $iBytesRead  )
	Else
		_DebugOut(_FTP_DecodeInternetStatus($dwInternetStatus) )
	EndIf
EndFunc   ;==>_InternetStatusCallback
