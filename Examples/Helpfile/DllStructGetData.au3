Local $p = DllStructCreate("dword dwOSVersionInfoSize;dword dwMajorVersion;dword dwMinorVersion;dword dwBuildNumber;dword dwPlatformId;char szCSDVersion[128]")

;请想象为这样(C++样式): p->dwOSVersionInfoSize = sizeof(OSVERSIONINFO)
DllStructSetData($p, "dwOSVersionInfoSize", DllStructGetSize($p))

;构成 DllCall
Local $ret = DllCall("kernel32.dll", "int", "GetVersionEx", "ptr", DllStructGetPtr($p))

If Not $ret[0] Then
	MsgBox(0,"DllCall 错误","DllCall 失败")
	Exit
EndIf

;获取返回值
Local $major = DllStructGetData($p, "dwMajorVersion")
Local $minor = DllStructGetData($p, "dwMinorVersion")
Local $build = DllStructGetData($p, "dwBuildNumber")
Local $platform = DllStructGetData($p, "dwPlatformId")
Local $version = DllStructGetData($p, "szCSDVersion")

;释放数据结构所占内存
$p = 0

MsgBox(0, "", "Major: " & $major & @CRLF & _
		"Minor: " & $minor & @CRLF & _
		"Build: " & $build & @CRLF & _
		"Platform ID: " & $platform & @CRLF & _
		"Version: " & $version)

