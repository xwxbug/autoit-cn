#region - Program_name install script - (UserScript)

Opt('TrayIconDebug', 1)

; Installer.
$executable = 'filename.ext'

#endregion

Exit

; This is a template reserved for the user.
; To add to the contextmenu use the CMenu Editor to:
; Add a New Item and select from Custom Command
; Then in the window, set this parameters:
;   Caption: AutoIt User Script
;   Command: C:\Program Files\CMenu\CMenu.exe
;   Commandline: userscript
;   Icon:
;   Description: user script
;   Options:
; Then check Append file option
;
; The above entries are as follows:
; Caption is the item displayed the contextmenu.
; Command is set to the fullpath to where cmenu.exe resides.
; Commandline must be as stated above.
; Description is just a comment of the meaning of the editor entry.

; You can customize this script to your needs.
; Reserved words are Program_name and filename.ext,
; which are replaced with the filename and filename with extension.
