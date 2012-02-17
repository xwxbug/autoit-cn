#include <Inet.au3>

Local $PublicIP = _GetIP()
MsgBox(4096, "IP 地址", "您的 IP 地址为: " & $PublicIP)