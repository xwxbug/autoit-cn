InetGet("http://www.mozilla.org", "C:\foo.html")
InetGet("http://www.autoitscript.com", "C:\mydownload.htm", 1)
InetGet("ftp://ftp.mozilla.org/pub/mozilla.org/README", "README.txt", 1)


; Advanced example - downloading in the background
InetGet("http://www.nowhere.com/somelargefile.exe", "test.exe", 1, 1)

While @InetGetActive
  TrayTip("Downloading", "Bytes = " & @InetGetBytesRead, 10, 16)
  Sleep(250)
Wend

MsgBox(0, "Bytes read", @InetGetBytesRead)
