/*
Registry Jump
Version: 1.2
Author: mozers™
------------------------------------------------
Открывает выделенную ветвь в редакторе реестра
Понимает записи вида:
  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control
  HKLM\SYSTEM\CurrentControlSet\Control
  HKLM\\SYSTEM\\CurrentControlSet\\Control
Подключение:
command.name.78.*=Registry Jump
command.78.*=wscript "$(SciteDefaultHome)\tools\RegJump.js"
command.input.78.*=$(CurrentSelection)
command.mode.78.*=subsystem:windows,replaceselection:no,savebefore:no,quiet:yes
command.shortcut.78.*=Ctrl+Alt+J
*/

function TaskKill (process_name){
	var objWMIService = GetObject("winmgmts:\\\\.\\root\\CIMV2");
	var colProcessList = objWMIService.ExecQuery ('SELECT * FROM Win32_Process WHERE NAME = "' + process_name + '"');
	var enumItems = new Enumerator(colProcessList);
	for (; !enumItems.atEnd(); enumItems.moveNext()){
		enumItems.item().Terminate();
	}
}

var key = WScript.StdIn.ReadAll();
if (key === "") {
	WScript.Quit();
}

key = key.replace(/^HKLM\\/,'HKEY_LOCAL_MACHINE\\');
key = key.replace(/^HKCR\\/,'HKEY_CLASSES_ROOT\\');
key = key.replace(/^HKCU\\/,'HKEY_CURRENT_USER\\');
key = key.replace(/\\\\/g,'\\');
key = "My Computer\\" + key;

TaskKill ("regedit.exe");

var WshShell = new ActiveXObject("WScript.Shell");
WshShell.RegWrite ('HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Applets\\Regedit\\Lastkey',key,'REG_SZ');
WshShell.Run('regedit', 1, false);
WScript.Quit();
