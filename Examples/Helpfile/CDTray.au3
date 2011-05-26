;示例 1 弹出光盘驱动器 E: 盘的光驱托盘
CDTray("E:", "open")

;示例 2 弹出全部光盘驱动器的光驱托盘
$var = DriveGetDrive( "CDROM" )
If NOT @error Then
    For $i = 1 to $var[0]
		CDTray($var[$i], "open")
    Next
EndIf