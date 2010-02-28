#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=FindStr.ico
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Comment=Dos findstr replacement based on a script created by Martin of the AutoIt3 forum and modified by Jos.
#AutoIt3Wrapper_Res_Description=Dos findstr replacement based on a script created by Martin of the AutoIt3 forum and modified by Jos.
#AutoIt3Wrapper_Res_Fileversion=1.0.0.2
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=p
#AutoIt3Wrapper_Res_LegalCopyright=Copyright © 2009 Jos van der Zande
#AutoIt3Wrapper_Res_Field=Made By|Martin & Jos van der Zande
#AutoIt3Wrapper_Res_Field=Email|jdeb at autoitscript dot com
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Res_Field=Compile Date|%date% %time%
#AutoIt3Wrapper_Au3Check_Parameters=-q -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
;~ #AutoIt3Wrapper_Run_After=copy "%in%" "c:\program files\autoit3\SciTE"
#AutoIt3Wrapper_Run_After=copy "%out%" "c:\program files (x86)\autoit3\SciTE\findstr.exe"
#AutoIt3Wrapper_Run_Obfuscator=y
#AutoIt3Wrapper_Add_Constants=n
#Obfuscator_Parameters=/striponly
#Tidy_Parameters=/rel 1
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;this is meant to overcome problem with findstr not recognising CR as eol
;only a problem when you have files which use @CR as EOL and in these cases the whole file is
; just one line as far as findstr ins concerned
#include <File.au3>
#include <string.au3>
#include <GUIConstantsEx.au3>
Global $debugging = False
Global $tofind ;the string to search for
Global $FileTypes ;the filetypes to search
Global $SearchFolder ;the folder to search in
Global $subFolders ;true if we should search subfolders
Global $CaseSensitive;true if we care about the case
Global $IniFile = @ScriptDir & "\findinfiles.ini"
Global $LastFiles = IniRead($IniFile, "Files", "lasttypes", "")
Global $LastStrings = IniRead($IniFile, "Strings", "laststrings", "")
Global $LastFolders = IniRead($IniFile, "Folders", "lastfolders", "")
If $CmdLine[0] >= 5 Then ; we have been run from SciTE? find.command=findstr /n /s /I $(find.what) $(find.files)
	$tofind = $CmdLine[4]
	$FileTypes = $CmdLine[5]
	$subFolders = $CmdLine[2] = "/s"
	$CaseSensitive = $CmdLine[3] <> "/I"
	$SearchFolder = @WorkingDir
	If $debugging Then
		MsgBox(262144, "Commands", "raw = " & $cmdlineraw & @CR & _
				"working dir is" & $SearchFolder & @CR & _
				"Look for " & $tofind & @CR & _
				"File types = " & $FileTypes & @CR & _
				"Search subfolders = " & $subFolders & @CR & _
				"Case sensitive = " & $CaseSensitive)
	EndIf
	If $tofind = '' Or $FileTypes = '' Or $SearchFolder = '' Then DataFromGui()
Else
	DataFromGui()
EndIf
If $tofind = '' Or $FileTypes = '' Or $SearchFolder = '' Then Exit
If $subFolders Then
	$subFolders = "/s"
Else
	$subFolders = ''
EndIf
;~ ProgressOn("Search in " & $SearchFolder, "for files containg " & $tofind)
; Set traymenu
Opt("TrayOnEventMode", 1)
Opt("TrayMenuMode", 1) ; Default tray menu items (Script Paused/Exit) will not be shown.
Global $KillSearch = TrayCreateItem("StopSearch")
TrayItemSetOnEvent(-1, "ExitScript")
TraySetState()
HotKeySet("{END}","ExitScript")
;use the command findstr to search without case sensitivity (/i) in sub folder (/s) and only return the file names (/m)
Global $alltypes = StringSplit($FileTypes, ';')
For $typenumber = 1 To $alltypes[0]
	Global $Thistype = $alltypes[$typenumber]
	ConsoleWrite(">>>Search files of type " & $Thistype & " in " & $SearchFolder)
	If $subFolders Then
		ConsoleWrite(" : Search Subfolders :")
	Else
		ConsoleWrite(": Subfolders not searched :")
	EndIf
	If $CaseSensitive Then
		ConsoleWrite(": Case sensitive :")
	Else
		ConsoleWrite(": Not Case Sensitive :")
	EndIf
	ConsoleWrite(@CRLF)
	Global $instr = 'findstr /i /m ' & $subFolders & ' "' & $tofind & '" "' & $SearchFolder & "\" & $Thistype & '"'
	If $debugging Then MsgBox(262144, "instr = ", $instr)
	;run command in systemdir so it will find windows findstr.exe first and not this script
	Global $foo = Run(@ComSpec & " /c " & $instr, @SystemDir, @SW_HIDE, 8);$STDIN_CHILD + $STDOUT_CHILD)cmd.exe
	; Read from child's STDOUT
	Global $stdouttxt, $filecount = 0
	While True
		TraySetToolTip("Searching for files, found " & $filecount & "({END}=Stop searching)")
		$stdouttxt &= StdoutRead($foo)
		If @error Then ExitLoop
		ScanFile($stdouttxt, $filecount, $tofind)
	WEnd
	ScanFile($stdouttxt, $filecount, $tofind)
	;read all the files which contain the string
	If Not $filecount Then
		ConsoleWrite('no files found with "' & $tofind & '"' & @CRLF)
	EndIf
Next
;~ ProgressOff()
UpdateLast()
;Exit
;
Func ExitScript()
	Exit
EndFunc
;
Func ScanFile(ByRef $stdouttxt, ByRef $filecount, $tofind)
	Local $text, $File, $filelines
	$stdouttxt = StringReplace($stdouttxt, @CRLF, @CR)
	$stdouttxt = StringReplace($stdouttxt, @LF, @CR)
	While StringInStr($stdouttxt, @CR)
		;in the same way split the file text into an array of lines
		$File = StringLeft($stdouttxt, StringInStr($stdouttxt, @CR) - 1)
;~ 			ConsoleWrite('!' & $file & @crlf)
		$stdouttxt = StringMid($stdouttxt, StringInStr($stdouttxt, @CR) + 1)
		$filecount += 1
		$text = FileRead($File);
		$text = StringReplace($text, @CRLF, @CR)
		$text = StringReplace($text, @LF, @CR)
		$filelines = StringSplit($text, @CR)
		TraySetToolTip($file)
		For $lines = 1 To $filelines[0]
			; only check every 100 lines to see if SearchCancel was clicked in the trayiconmenu
			If StringInStr($filelines[$lines], $tofind) Then
				ConsoleWrite($File & ":" & $lines & ":" & $filelines[$lines] & @CR)
			EndIf
		Next
	WEnd
EndFunc   ;==>ScanFile
;
Func DataFromGui()
	#Region ### START Koda GUI section ###
	GUICreate("Find in Files", 384, 224, 303, 219)
	GUICtrlCreateLabel("String to find", 16, 10, 84, 19)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	Local $CmboString = GUICtrlCreateCombo("", 16, 30, 337, 25)
	GUICtrlCreateLabel("Files to search. Separate types with ';' (semicolon)", 16, 68, 315, 17)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	Local $CmboFiles = GUICtrlCreateCombo("", 16, 88, 337, 25)
	GUICtrlCreateLabel("Folder to search", 16, 133, 101, 18)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	Local $ChkSubFolders = GUICtrlCreateCheckbox("Include subfolders", 142, 132, 129, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
	Local $CmboFolders = GUICtrlCreateCombo("", 16, 152, 273, 25)
	Local $BtnSearch = GUICtrlCreateButton("Search", 40, 192, 75, 25, 0)
	Local $BtnCancel = GUICtrlCreateButton("Cancel", 232, 192, 75, 25, 0)
	Local $BtnBrowse = GUICtrlCreateButton("Browse", 296, 151, 75, 23, 0)
	Local $ChkCase = GUICtrlCreateCheckbox("Case Dependant", 142, 10, 97, 17)
	GUISetState(@SW_SHOW)
	#EndRegion ### END Koda GUI section ###
	GUICtrlSetData($CmboFiles, $LastFiles)
	GUICtrlSetData($CmboString, $LastStrings)
	GUICtrlSetData($CmboFolders, $LastFolders)
	Local $nMsg, $temp
	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE, $BtnCancel
				Exit
			Case $BtnSearch
				ExitLoop
			Case $BtnBrowse
				$temp = FileSelectFolder("folder to search", "", 6, @ScriptDir)
				If $temp <> '' Then GUICtrlSetData($CmboFolders, $temp, $temp)
		EndSwitch
	WEnd
	$subFolders = BitAND(GUICtrlRead($ChkSubFolders), $GUI_CHECKED) = $GUI_CHECKED
	$tofind = GUICtrlRead($CmboString)
	$SearchFolder = GUICtrlRead($CmboFolders)
	$FileTypes = GUICtrlRead($CmboFiles)
	iF GUICtrlRead($ChkCase) = $GUI_CHECKED THEN $CaseSensitive = 1
EndFunc   ;==>DataFromGui
;
Func UpdateLast()
	;save strings searched for
	If Not StringInStr('|' & $LastStrings, '|' & $tofind & '|') Then
		$LastStrings = $tofind & '|' & $LastStrings
	EndIf
	While StringInStr($LastStrings, '|', 0, 10)
		$LastStrings = StringLeft($LastStrings, StringInStr($LastStrings, '|', 0, -1) - 1)
	WEnd
	IniWrite($IniFile, "Strings", "laststrings", $LastStrings)
	;save folders searched
	If Not StringInStr('|' & $LastFolders, '|' & $SearchFolder & '|') Then
		$LastStrings = $SearchFolder & '|' & $LastFolders
	EndIf
	While StringInStr($LastFolders, '|', 0, 10)
		$LastFolders = StringLeft($LastFolders, StringInStr($LastFolders, '|', 0, -1) - 1)
	WEnd
	IniWrite($IniFile, "Folders", "lastfolders", $LastFolders)
	;save filetypes
	If Not StringInStr('|' & $LastFiles, '|' & $FileTypes & '|') Then
		$LastFiles = $FileTypes & '|' & $LastFiles
	EndIf
	While StringInStr($LastFiles, '|', 0, 10)
		$LastFiles = StringLeft($LastFiles, StringInStr($LastFiles, '|', 0, -1) - 1)
	WEnd
	IniWrite($IniFile, "Files", "lasttypes", $LastFiles)
EndFunc   ;==>UpdateLast
;
Func OnAutoItExit()
	ProgressOff()
	If @exitMethod Then
		ConsoleWrite(@CRLF & "! Search cancelled." & @CRLF)
		Local $aP = ProcessList("findstr.exe")
		; Kill all FindStr.exe that are not this programs PID
		For $i = 1 To $aP[0][0]
			If $aP[$i][1] <> @AutoItPID Then ProcessClose($aP[$i][1])
		Next
	EndIf
	FileDelete(@ScriptDir & "findstrtmp.txt");remove temp file
EndFunc   ;==>OnAutoItExit