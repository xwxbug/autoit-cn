#include <Process.au3>

Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]", "")
$pid = WinGetProcess("[CLASS:Notepad]", "")
$name = _ProcessGetName($pid)

MsgBox(0, "Notepad - " & $pid, $name)