
; Ê¾Àý 1
#include  <inet.au3>
Dim $sResult, $sIp
TCPStartup()
$sIp = TCPNameToIP("hiddensoft.com")
$sResult = _TCPIpToName($sIp)
If @error Then
	msgbox(0, "_TCPIpToName()", "@error =" & @error & @LF & "@extended =" & @extended)
Else
	msgbox(0, "hiddensoft.com realy
	is:" ,  $sResult )
EndIf

; Ê¾Àý 2
#include  <array.au3>
#include  <inet.au3>
Dim $aResult, $sIp
TCPStartup()
$sIp = _GetIP()
$aResult = _TCPIpToName($sIp, 1)
If @error Then
	msgbox(0, "_TCPIpToName()", "@error =" & @error & @LF & "@extended =" & @extended)
Else
	_ArrayDisplay($aResult, "Local Hostname(s)")
EndIf



