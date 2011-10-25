#include  <Process.au3>

Run(" notepad.exe ")
WinWaitActive(" [CLASS:Notepad] ", "")
$pid = WinGetProcess(" [CLASS:Notepad] ", "")
$name = _ProcessGetName($pid)

msgbox(0, "Notepad -" & $pid, $name)

