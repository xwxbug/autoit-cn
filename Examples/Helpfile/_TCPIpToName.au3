; Example 1
#include <inet.au3>
Dim $sResult, $sIp
TCPStartup()
$sIp = TCPNameToIP("hiddensoft.com")
$sResult = _TCPIpToName ($sIp)
If @error Then
	MsgBox(0, "_TCPIpToName()", "@error = " & @error & @LF & "@extended = " & @extended)
Else
	MsgBox(0, "hiddensoft.com realy is:", $sResult)
EndIf

; Example 2
#include <array.au3>
#include <inet.au3>
Dim $aResult, $sIp
TCPStartup()
$sIp = _GetIP()
$aResult = _TCPIpToName ($sIp, 1)
If @error Then
	MsgBox(0, "_TCPIpToName()", "@error = " & @error & @LF & "@extended = " & @extended)
Else
	_ArrayDisplay($aResult, "Local Hostname(s)")
EndIf