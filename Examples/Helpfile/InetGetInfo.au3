#Alternate
Local $hDownload = InetGet("http://www.autoitscript.com/autoit3/files/beta/update.dat", @TempDir & "\update.dat", 1, 1)
Do
	Sleep(250)
Until InetGetInfo($hDownload, 2);检查下载是否完成.
Local $aData = InetGetInfo($hDownload);获取所有信息.
InetClose($hDownload);关闭句柄, 释放资源.
MsgBox(0, "", "Bytes read: " & $aData[0] & @CRLF & _
	"Size: " & $aData[1] & @CRLF & _
	"Complete?: " & $aData[2] & @CRLF & _
	"Successful?: " & $aData[3] & @CRLF & _
	"@error: " & $aData[4] & @CRLF & _
	"@extended: " & $aData[5] & @CRLF)
