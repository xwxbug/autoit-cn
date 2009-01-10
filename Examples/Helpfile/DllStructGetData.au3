$p	= DllStructCreate("dword dwOSVersionInfoSize;dword dwMajorVersion;dword dwMinorVersion;dword dwBuildNumber;dword dwPlatformId;char szCSDVersion[128]")

;think of this as p->dwOSVersionInfoSize = sizeof(OSVERSIONINFO)
DllStructSetData($p, "dwOSVersionInfoSize", DllStructGetSize($p))

;make the DllCall
$ret = DllCall("kernel32.dll","int","GetVersionEx","ptr",DllStructGetPtr($p))

if Not $ret[0] Then
	MsgBox(0,"DllCall Error","DllCall Failed")
	exit
EndIf

;get the returned values
$major		= DllStructGetData($p,"dwMajorVersion")
$minor		= DllStructGetData($p,"dwMinorVersion")
$build		= DllStructGetData($p,"dwBuildNumber")
$platform	= DllStructGetData($p,"dwPlatformId")
$version	= DllStructGetData($p,"szCSDVersion")

;free the struct
$p =0

msgbox(0,"","Major: " & $major & @CRLF & _
			"Minor: " & $minor & @CRLF & _
			"Build: " & $build & @CRLF & _
			"Platform ID: " & $platform & @CRLF & _
			"Version: " & $version)

