$p	= DllStructCreate("dword dwOSVersionInfoSize;dword dwMajorVersion;dword dwMinorVersion;dword dwBuildNumber;dword dwPlatformId;char szCSDVersion[128]")

;请想象为这样(C++样式): p->dwOSVersionInfoSize = sizeof(OSVERSIONINFO)
DllStructSetData($p, "dwOSVersionInfoSize", DllStructGetSize($p))

;构成 DllCall
$ret = DllCall("kernel32.dll","int","GetVersionEx","ptr",DllStructGetPtr($p))

if Not $ret[0] Then
	MsgBox(0,"DllCall 错误","DllCall 失败")
	exit
EndIf

;获取返回值
$major		= DllStructGetData($p,"dwMajorVersion")
$minor		= DllStructGetData($p,"dwMinorVersion")
$build		= DllStructGetData($p,"dwBuildNumber")
$platform	= DllStructGetData($p,"dwPlatformId")
$version	= DllStructGetData($p,"szCSDVersion")

;释放数据结构所占内存
$p =0

msgbox(0,"","Major: " & $major & @CRLF & _
			"Minor: " & $minor & @CRLF & _
			"Build: " & $build & @CRLF & _
			"Platform ID: " & $platform & @CRLF & _
			"Version: " & $version)

