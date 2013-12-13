#include <Array.au3>
#include <Inet.au3>
#include <MsgBoxConstants.au3>

Global $aResult, $sResult, $sIP

TCPStartup()
$sIP = _GetIP()
$aResult = _TCPIpToName($sIP, 1)
If @error Then
	MsgBox($MB_SYSTEMMODAL, "_TCPIpToName()", "@error = " & @error & @CRLF & "@extended = " & @extended)
Else
	_ArrayDisplay($aResult, "Local Hostname(s)")
EndIf
