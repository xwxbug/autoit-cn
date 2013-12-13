#include <FTPEx.au3>
#include <Misc.au3>
#include <ProgressConstants.au3>
#include <GUIConstantsEx.au3>

Global $sRemoteFile = "/pub/software/databases/rt/SRPMS/ucs-local-modperl-2.0.3-1.src.rpm"
Global $sLocalFile = @TempDir & "\temp.tmp"
FileDelete($sLocalFile)

Local $sServer = 'ftp.csx.cam.ac.uk'
Local $sUsername = ''
Local $sPass = ''

Local $hInternetSession = _FTP_Open('MyFTP Control')
; passive allows most protected FTPs to answer
Local $hFTPSession = _FTP_Connect($hInternetSession, $sServer, $sUsername, $sPass, 1)

Example()

_FTP_Close($hInternetSession)

Func Example()
	Local $sFunctionToCall = "_UpdateProgress"
	ProgressOn("Download Progress", $sRemoteFile)
	_FTP_ProgressDownload($hFTPSession, $sLocalFile, $sRemoteFile, $sFunctionToCall)
	ProgressOff()
EndFunc   ;==>Example

Func _UpdateProgress($iPercent)
	ProgressSet($iPercent, Int($iPercent) & "%")
	If _IsPressed("77") Then Return 0 ; Abort on F8
	Return 1 ; 1 to continue Download
EndFunc   ;==>_UpdateProgress
