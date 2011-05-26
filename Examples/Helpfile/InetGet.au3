InetGet("http://www.mozilla.org", @TempDir & "\mozilla.html")
InetGet("http://www.autoitscript.com", @TempDir & "autoitscript.html", 1)
InetGet("ftp://ftp.mozilla.org/pub/mozilla.org/README", @TempDir & "\Mozilla-README.txt", 1)

; 高级例子 - 使用后台下载
Local $hDownload = InetGet("http://www.autoitscript.com/autoit3/files/beta/update.dat", @TempDir & "\update.dat", 1, 1)
Do
	Sleep(250)
Until InetGetInfo($hDownload, 2)	; 检查下载是否完成.
Local $nBytes = InetGetInfo($hDownload, 0)
InetClose($hDownload)	; 关闭句柄,释放资源.
MsgBox(0, "", "字节读取: " & $nBytes)
