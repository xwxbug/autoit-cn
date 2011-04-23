#NoTrayIcon
#include <ACN_BlockInputEx.au3>

Opt("WinWaitDelay", 1)

$sTaskMgr_Title = "[CLASS:#32770;REGEXPTITLE:(Диспетчер задач|Task Manager)]"

;Disable Task Manager
RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System", "DisableTaskMgr", "REG_DWORD", "1")

;Block keyboard and wait 10 seconds
_BlockInputEx(3)
Sleep(10000)

;Enable Task Manager back
RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System", "DisableTaskMgr", "REG_DWORD", "0")

_BlockInputEx(0)