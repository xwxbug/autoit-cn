Local $hDownload = InetGet("http://www.autoitscript.com/autoit3/files/beta/update.dat", @TempDir & "\update.dat", 1, 1)
Do
	Sleep(250)
Until InetGetInfo($hDownload, 2);检查下载是否完成.
Local $nBytes = InetGetInfo($hDownload, 0)
InetClose($hDownload);关闭句柄, 释放资源.
MsgBox(4096, "", "Bytes read: " & $nBytes)
