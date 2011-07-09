#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=c:\windows\notepad.exe|0
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Comment=Configure SciTE settings For AutoIt3
#AutoIt3Wrapper_Res_Description=Configure SciTE settings For AutoIt3
#AutoIt3Wrapper_Res_Fileversion=1.6.8.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=p
#AutoIt3Wrapper_Res_LegalCopyright=Copyright © 2011 Jos van der Zande
#AutoIt3Wrapper_Res_Field=Made By|Jos van der Zande
#AutoIt3Wrapper_Res_Field=Email|jdeb at autoitscript dot com
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Res_Field=Compile Date|%date% %time%
;~ #AutoIt3Wrapper_run_after=copy "%out%" "C:\Program Files\AutoIt3\SciTE\SciTEConfig\*.*"
;~ #AutoIt3Wrapper_run_after=copy "%in%" "C:\Program Files\AutoIt3\SciTE\SciTEConfig\*.*"
;~ #AutoIt3Wrapper_run_cvswrapper=v
;~ #AutoIt3Wrapper_run_obfuscator=y
#Obfuscator_Parameters=/cs=0 /cn=0 /cf=0 /cv=0 /sf=1
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <TreeViewConstants.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>
#include <Date.au3>
#include <file.au3>
#Include <Color.au3>

;
Global $AutoIT3_Dir = ""
#Region Commandline lexing
; retrieve commandline parameters
;-------------------------------------------------------------------------------------------
For $x = 1 To $CMDLINE[0]
	$T_Var = StringLower($CMDLINE[$x])
	Select
		Case $T_Var = "/Autoit3Dir"
			$x = $x + 1
			If FileExists($CMDLINE[$x]) Then $AutoIT3_Dir = $CMDLINE[$x]
	EndSelect
Next
#EndRegion Commandline lexing
;
; determine the SciTE and AutoIt3 Directories
;
;	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $AutoIT3_Dir = ' & $AutoIT3_Dir & @crlf & '>Error code: ' & @error & @crlf) ;### Debug Console
If $AutoIT3_Dir = "" or Not FileExists($AutoIT3_Dir) then
	; save current dir
	$S_CurDir = @WorkingDir
	; set directory to obfuscator directory
	FileChangeDir(@ScriptDir)
	If FileExists(@ScriptDir & "\Autoit3.exe") then
		$AutoIT3_Dir = @ScriptDir
	Else
		FileChangeDir("..")
		If FileExists("Autoit3.exe") then
			$AutoIT3_Dir = @WorkingDir
		Else
			FileChangeDir("..")
			If FileExists("Autoit3.exe") then
				$AutoIT3_Dir = @WorkingDir
			Else
				$AutoIT3_Dir = RegRead("HKLM\Software\AutoIt v3\Autoit", 'InstallDir')
			EndIf
		EndIf
	EndIf
	; Restore saved current directory
	FileChangeDir($S_CurDir)
EndIf
;
;
; Find SciTE Directory
Global $SciTE_Dir = ""
If FileExists(@ScriptDir & "\SciTE.exe") Then
	$SciTE_Dir = @ScriptDir
Else
	; save current dir
	$S_CurDir = @WorkingDir
	FileChangeDir(@ScriptDir & "\..")
	If FileExists("SciTE.exe") then
		$SciTE_Dir = @WorkingDir
	Else
		$SciTE_Dir = RegRead('HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\App Paths\SciTE.exe', '')
		$SciTE_Dir = StringLeft($SciTE_Dir, StringInStr($SciTE_Dir, "\", '', -1) - 1)
	EndIf
	; Restore saved current directory
	FileChangeDir($S_CurDir)
EndIf
;
If Not FileExists($SciTE_Dir) Then
	MsgBox(0 + 16 + 262144, "SciTEConfig", "没有找到 SciTE.exe ,程序停止. ")
	Exit
EndIf
;
;	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $AutoIT3_Dir = ' & $AutoIT3_Dir & @crlf & '>Error code: ' & @error & @crlf) ;### Debug Console
;	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $SciTE_Dir = ' & $SciTE_Dir & @crlf & '>Error code: ' & @error & @crlf) ;### Debug Console
;
;

Global $VERSION = FileGetVersion(@ScriptFullPath)
$VERSION = StringLeft($VERSION, StringInStr($VERSION, ".", 0, -1) - 1)
;$VERSION = "1.3.0"
; Check if updates are available...
If StringInStr($cmdlineraw, "/CheckUpdates") Then
;~ 	CheckForUpdates(1)
	Exit
EndIf
;
; Get SciTE DirectorHandle
Opt("WinSearchChildren", 1)
;Global $WM_COPYDATA = 74
Global $SciTECmd
Global $SciTE_hwnd = WinGetHandle("DirectorExtension")
If @error Then
	MsgBox(0 + 16 + 262144, "SciTEConfig", "SciTE 未运行,程序退出.")
	Exit ;exit when Scite isn't running
EndIf
; Get My GUI Handle numeric
Global $My_Hwnd = GUICreate("SciTE interface", 300, 620, Default, Default, Default, $WS_EX_TOPMOST)
$list = GUICtrlCreateEdit("", 1, 1, 290, 590)
$My_Dec_Hwnd = Dec(StringTrimLeft($My_Hwnd, 2))
;Register COPYDATA message.
GUIRegisterMsg($WM_COPYDATA, "MY_WM_COPYDATA")
;
FileChangeDir($AutoIT3_Dir)
;
AutoItWinSetTitle("SciTE_Config_Window")
$Ahnd = WinGetHandle(AutoItWinGetTitle())
;WinShow(AutoItWinGetTitle(),"",@SW_RESTORE)
; ----------------------------------------------------------------------------
; Script Start
; ----------------------------------------------------------------------------
$FontType = '"Courier New"'
$FontSize = "10"
Opt("GUICoordMode", 1)
$hMain_GUI = GUICreate("SciTE Config for AutoIt3. ver:" & $VERSION, 410, 500, Default, Default, Default, $WS_EX_TOPMOST)
Global $Background_Color = ""
Global $CaretLine_Color = ""
Global $Selection_Color = ""
Global $Selection_BkColor = ""
Global $Selection_Alpha = 0
Global $Backups = 0
Global $ProperCase = 1
Global $CheckuUpdatesSciTE4AutoIt3 = 0
Global $Use_Tabs = 1
Global $Tab_Size = 4
Global $Syn_Label[18]
Global $Syn_bColor[18]
Global $Syn_bColor_Default[18]
Global $Syn_fColor[18]
Global $Syn_Bold[18]
Global $Syn_Italic[18]
Global $Syn_Underline[18]
Global $H_ProperCase
Global $H_CheckUpdatesSciTE4AutoIt3
Global $H_Use_Tabs
Global $H_Tab_Size
Global $H_Syn_Label[18]
Global $H_Syn_bColor[18]
Global $H_Syn_bColor_Standard[18]
Global $H_Syn_fColor[18]
Global $H_Syn_Bold[18]
Global $H_Syn_Italic[18]
Global $H_Syn_Underline[18]
Dim $x
;
$BaseX = 30
$BaseY = 40
$h_tab = GUICtrlCreateTab(10, 10, 390, 450)
$h_tab0 = GUICtrlCreateTabItem("常规设置")
;~ GUICtrlCreateGroup("Explorer AU3 File setting.", $BaseX, $BaseY, 340, 55)
;~ GUICtrlCreateLabel('Choose Default action for Au3 files:', $BaseX + 10, $BaseY + 15)
;~ $h_Edit = GUICtrlCreateRadio('Edit', $BaseX + 190, $BaseY + 15, 50, 15)
;~ $h_Run = GUICtrlCreateRadio('Run', $BaseX + 190, $BaseY + 35, 50, 15)
;~ $read = RegRead('HKEY_CLASSES_ROOT\AutoIt3Script\Shell', '')
;~ If $read = 'Edit' Or $read = 'Open' Then
;~ 	GUICtrlSetState($h_Edit, $GUI_CHECKED)
;~ Else
;~ 	GUICtrlSetState($h_Run, $GUI_CHECKED)
;~ EndIf
$SYN_Font_Mono_ON = 1
$SYN_Font_Mono_Size = 8
$SYN_Font_Mono_Type = "Courier New"
$SYN_Font_Prop_Size = 8
$SYN_Font_Prop_Type = "Arial"
Get_Current_config()
;
$BaseY = 105
GUICtrlCreateGroup("常规设置", $BaseX, $BaseY, 340, 80)
GUICtrlCreateLabel("保存编辑的文件备份数量(0=无):", $BaseX + 10, $BaseY + 15, 230, 20)
$h_Backups = GUICtrlCreateInput($Backups, $BaseX + 245, $BaseY + 12, 25, 20)
$H_ProperCase = GUICtrlCreateCheckbox("自动区分函数与关键字的大小写.", $BaseX + 10, $BaseY + 30)
$H_CheckUpdatesSciTE4AutoIt3 = GUICtrlCreateCheckbox("检查 SciTE4AutoIT3 更新.", $BaseX + 10, $BaseY + 50)
;
$BaseY = 195
GUICtrlCreateGroup("载入的 AutoIt3 定义:", $BaseX, $BaseY, 340, 60)
$Pver = IniRead($SciTE_Dir & "\defs\versioninfo.ini", "Version", "Production", "?")
$h_PLoaded = GUICtrlCreateRadio('Production: ' & $Pver & "", $BaseX + 10, $BaseY + 15, 250, 15)
$Bver = IniRead($SciTE_Dir & "\defs\versioninfo.ini", "Version", "Beta", "?")
$h_BLoaded = GUICtrlCreateRadio('BETA: ' & $Bver & "", $BaseX + 10, $BaseY + 35, 250, 15)
If FileGetSize($SciTE_Dir & "\properties\au3.keywords.properties") = FileGetSize($SciTE_Dir & "\Defs\Production\au3.keywords.properties") Then
	GUICtrlSetState($h_PLoaded, $GUI_CHECKED)
Else
	GUICtrlSetState($h_BLoaded, $GUI_CHECKED)
EndIf
;
$BaseY = 265
GUICtrlCreateGroup("AutoIt3 目录设置:", $BaseX, $BaseY, 340, 80)
GUICtrlCreateLabel("AutoIt3Dir=" & $AutoIT3_Dir, $BaseX + 10, $BaseY + 18, 300, 20)
$UserIncludeDirectory = RegRead("HKEY_CURRENT_USER\SOFTWARE\AutoIt v3\AutoIt", "Include")
If $UserIncludeDirectory = "" Then $UserIncludeDirectory = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt", "Include")
GUICtrlCreateLabel("用户 Include 目录:", $BaseX + 10, $BaseY + 35, 110, 20)
$h_UserIncludeDirectory = GUICtrlCreateInput($UserIncludeDirectory, $BaseX + 10, $BaseY + 50, 300, 20)
$h_UserIncludeDirectory_Button = GUICtrlCreateButton("...", $BaseX + 315, $BaseY + 50, 20, 20)
;
$BaseY = 350
GUICtrlCreateGroup("AU3 字体设置", $BaseX, $BaseY, 340, 100)
$H_Syn_Mono_Change = GUICtrlCreateButton("修改", $BaseX + 10, $BaseY + 15, 50, 20)
$H_Syn_Mono = GUICtrlCreateCheckbox("等宽字体:" & $SYN_Font_Mono_Type, $BaseX + 70, $BaseY + 15, 220, 20)
$H_Syn_Mono_Size = GUICtrlCreateLabel("大小:" & $SYN_Font_Mono_Size, $BaseX + 290, $BaseY + 17, 40, 20)
$H_Syn_Prop_Change = GUICtrlCreateButton("修改", $BaseX + 10, $BaseY + 45, 50, 20)
$H_Syn_Prop = GUICtrlCreateCheckbox("比例字体:" & $SYN_Font_Prop_Type, $BaseX + 70, $BaseY + 45, 220, 20)
$H_Syn_Prop_Size = GUICtrlCreateLabel("大小:" & $SYN_Font_Prop_Size, $BaseX + 290, $BaseY + 47, 40, 20)
If $SYN_Font_Mono_ON = 1 Then
	GUICtrlSetState($H_Syn_Mono, 1)
	GUICtrlSetState($H_Syn_Prop, 4)
	$SYN_Font_Type = $SYN_Font_Mono_Type
	$SYN_Font_Size = $SYN_Font_Mono_Size
Else
	GUICtrlSetState($H_Syn_Mono, 4)
	GUICtrlSetState($H_Syn_Prop, 1)
	$SYN_Font_Type = $SYN_Font_Prop_Type
	$SYN_Font_Size = $SYN_Font_Prop_Size
EndIf
;
$H_Use_Tabs = GUICtrlCreateCheckbox("使用制表符(Tabs)", $BaseX + 10, $BaseY + 70)
GUICtrlCreateLabel("制表符大小:", $BaseX + 140, $BaseY + 73, 80, 20)
$H_Tab_Size = GUICtrlCreateInput($Tab_Size, $BaseX + 205, $BaseY + 73, 25, 20)
;
; Color Tab
$h_tab1 = GUICtrlCreateTabItem("颜色设置")
$BaseY = 60
;determine current loaded definition files for SciTE
;$BaseY = 148
$H_Background_Label = GUICtrlCreateLabel("背景色:" & StringLower($Background_Color), $BaseX + 5, $BaseY, 150, 20)
$H_CaretLine_Label = GUICtrlCreateLabel("插入行颜色:" & StringLower($CaretLine_Color), $BaseX + 5, $BaseY + 20, 150, 20)
$H_Selection_Label = GUICtrlCreateLabel("Selected Color", $BaseX + 5, $BaseY + 20, 150, 20)
$H_Alpha_Label = GUICtrlCreateLabel("Alpha", $BaseX + 170 + 84 + 55, $BaseY + 22, 100, 20)
$H_Background_Color = GUICtrlCreateButton("背景", $BaseX + 170, $BaseY, 80, 20)
$H_CaretLine_Color = GUICtrlCreateButton("插入行", $BaseX + 170, $BaseY + 20, 80, 20)
$H_Selection_Color = GUICtrlCreateButton("Fore", $BaseX + 170, $BaseY + 20, 40, 20)
$H_Selection_BkColor = GUICtrlCreateButton("Back", $BaseX + 170 + 40, $BaseY + 20, 40, 20)
$H_Selection_Alpha = GUICtrlCreateInput($Selection_Alpha, $BaseX + 170 + 84, $BaseY + 20, 50, 20)
GUICtrlCreateUpdown(-1, 0x0005) ; $UDS_ALIGNRIGHT, $UDS_WRAP
GUICtrlSetLimit(-1, 255, 0)

$BaseY = $BaseY + 50
GUICtrlCreateLabel("B", $BaseX + 170, $BaseY, 20, 20)
GUICtrlSetFont(-1, $SYN_Font_Size, 900, 0, $SYN_Font_Type)
GUICtrlCreateLabel("I", $BaseX + 195, $BaseY, 20, 20)
GUICtrlSetFont(-1, $SYN_Font_Size, 400, 2, $SYN_Font_Type)
GUICtrlCreateLabel("U", $BaseX + 220, $BaseY, 20, 20)
GUICtrlSetFont(-1, $SYN_Font_Size, 400, 4, $SYN_Font_Type)
GUICtrlCreateLabel("默认背景色", $BaseX + 280, $BaseY - 10, 50, 30)
For $x = 1 To 16
	$H_Syn_Label[$x] = GUICtrlCreateLabel($Syn_Label[$x], $BaseX + 5, $BaseY + 20 * $x, 150, 20)
	$H_Syn_Bold[$x] = GUICtrlCreateCheckbox("", $BaseX + 170, $BaseY + 20 * $x, 20, 20)
	$H_Syn_Italic[$x] = GUICtrlCreateCheckbox("", $BaseX + 195, $BaseY + 20 * $x, 20, 20)
	$H_Syn_Underline[$x] = GUICtrlCreateCheckbox("", $BaseX + 220, $BaseY + 20 * $x, 20, 20)
	$H_Syn_fColor[$x] = GUICtrlCreateButton("前景", $BaseX + 245, $BaseY + 20 * $x, 40, 20)
	$H_Syn_bColor_Standard[$x] = GUICtrlCreateCheckbox("", $BaseX + 295, $BaseY + 20 * $x, 20, 20)
	$H_Syn_bColor[$x] = GUICtrlCreateButton("背景", $BaseX + 320, $BaseY + 20 * $x, 40, 20)
Next
Update_Window()
;~ $H_Update = GUICtrlCreateButton("Update", 60, 442, 70)
;~ GUICtrlSetTip(-1, "Save all Color changes made to SciTEUser.properties")
;~ $H_Cancel = GUICtrlCreateButton("Cancel", 150, 415)
;~ GUICtrlSetTip(-1, "Exit and ignore all Color changes made")
$H_Reset = 0
;$H_Reset = GUICtrlCreateButton("Reset", 160, 520, 70)
;GUICtrlSetTip(-1, "Revert to last saved Color configuration.")
;~ $H_NewScheme = GUICtrlCreateButton("Remove", 260, 442, 70)
;~ GUICtrlSetTip(-1, "Remove personal Color settings from SciTEUser.properties")
;
#region - Tools
; Need these variables declared for the message loop
Global $file_au3properties, $h_treeview
If FileExists($AutoIT3_Dir & '\SciTE\Properties\au3.properties') Then
	Global $file_au3properties = $AutoIT3_Dir & '\SciTE\Properties\au3.properties'
	Global $comment = '#~ '
	$split = SciteToolsFileRead($file_au3properties)
	If @error Then
		ConsoleWrite('Error: FileRead ' & $file_au3properties & @CRLF)
	Else
		Global $checkbox[$split[0] + 1]
		; Create the Tools selection Tab
		$h_tab2 = GUICtrlCreateTabItem("工具选择")
		GUICtrlCreateLabel("选择要禁用启用的工具项目", 40, 50, 330)
		GUICtrlSetFont(Default, 9)
		$h_treeview = GUICtrlCreateTreeView(16, 80, 375, 370, BitOR($TVS_CHECKBOXES, $TVS_DISABLEDRAGDROP, $TVS_LINESATROOT), $WS_EX_CLIENTEDGE)
		; Create the TreeView Checkboxes
		For $i = 1 To $split[0]
			$checkbox_ini_data = IniRead(@ScriptDir & '\SciteTools.ini', 'Tools Selection Tab', $i, '')
			If $checkbox_ini_data <> '' Then
				If StringLeft($checkbox_ini_data, 4) = '#~ #' Then
					$checkbox_text = StringTrimLeft($split[$i], 5)
					$checkbox[$i] = GUICtrlCreateTreeViewItem($checkbox_text, $h_treeview)
					GUICtrlSetState($checkbox[$i], $GUI_UNCHECKED)
				Else
					$checkbox_text = StringTrimLeft($split[$i], 2)
					$checkbox[$i] = GUICtrlCreateTreeViewItem($checkbox_text, $h_treeview)
					GUICtrlSetState($checkbox[$i], $GUI_CHECKED)
				EndIf
				ContinueLoop
			EndIf
			If StringLeft($split[$i], 3) = $comment Then
				$checkbox_text = StringTrimLeft($split[$i], 5)
				$checkbox[$i] = GUICtrlCreateTreeViewItem($checkbox_text, $h_treeview)
				GUICtrlSetState($checkbox[$i], $GUI_UNCHECKED)
			Else
				$checkbox_text = StringTrimLeft($split[$i], 2)
				$checkbox[$i] = GUICtrlCreateTreeViewItem($checkbox_text, $h_treeview)
				GUICtrlSetState($checkbox[$i], $GUI_CHECKED)
			EndIf
		Next
	EndIf
EndIf
#endregion - Tools
GUICtrlCreateTabItem("") ; end tabitem definition
$H_Update = GUICtrlCreateButton("更新", 10, 470, 70)
GUICtrlSetTip(-1, "Show changes in SciTE and save to SciTEUser.properties")
$H_NewScheme = GUICtrlCreateButton("新主题", 90, 470, 70)
GUICtrlSetTip(-1, "选择新颜色/字体主题.")
GUICtrlSetState($H_NewScheme, $GUI_HIDE)
$H_Exit = GUICtrlCreateButton("退出", 170, 470, 50)
$H_SciTE4AutoIT3Updates = GUICtrlCreateButton("检查 SciTE4Autoit3 更新", 230, 470, 170)
GUICtrlSetTip(-1, "Check for avaliable update for SciTE4AutoIT3")

GUISetState(@SW_SHOW)
; Process GUI Input
;-------------------------------------------------------------------------------------------
While 1
	$rc = GUIGetMsg()
	;Sleep(10)
	If $rc = $H_Exit Or $rc = -3 Then Exit
	If $rc <= 0 Then ContinueLoop
	; Cancel clicked
	Select
		Case $rc = $h_tab
			If GUICtrlRead($h_tab) = 1 Then
				GUICtrlSetState($H_NewScheme, $GUI_SHOW)
			Else
				GUICtrlSetState($H_NewScheme, $GUI_HIDE)
			EndIf
		Case $rc = $H_Update
			SciteToolsFileWrite($file_au3properties)
			Update_SciTE_User(1)
			Reload_Config()
			MsgBox(262144+48,"SciTE config","Updated Configuration")
		    ;
		Case $rc = $H_Reset
			If 6 = MsgBox(4 + 262144, 'SciTE Config', 'Reset to last saved setting?') Then
				Get_Current_config()
				Update_Window()
				MsgBox(4096, "reload done", "All settings are reloaded")
			EndIf
			ContinueLoop
			;
		Case $rc = $H_NewScheme
			SelectNewScheme()
			;Update_SciTE_User(0)
			Reload_Config()
			Get_Current_config()
			Update_Window()
			ContinueLoop
			;
;~ 		Case $rc = $h_Edit
;~ 			RunReqAdmin("RegWrite('HKEY_CLASSES_ROOT\AutoIt3Script\Shell', '', 'REG_SZ', 'Open')")
;~ 			RegWrite('HKEY_CLASSES_ROOT\AutoIt3Script\Shell', '', 'REG_SZ', 'Open')
;~ 			;
;~ 		Case $rc = $h_Run
;~ 			RunReqAdmin("RegWrite('HKEY_CLASSES_ROOT\AutoIt3Script\Shell', '', 'REG_SZ', 'Run')")
;~ 			RegWrite('HKEY_CLASSES_ROOT\AutoIt3Script\Shell', '', 'REG_SZ', 'Run')
;~ 			;
		Case $rc = $H_ProperCase
			Update_SciTE_User(1)
			;
		Case $rc = $H_CheckUpdatesSciTE4AutoIt3
			Update_SciTE_User(1)
			;
		Case $rc = $h_Backups
			Update_SciTE_User(1)
			;
		Case $rc = $h_UserIncludeDirectory
			RegWrite("HKEY_CURRENT_USER\SOFTWARE\AutoIt v3\AutoIt", "Include", "REG_SZ", GUICtrlRead($h_UserIncludeDirectory))
			If RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt", "Include") <> "" Then
;~ 				RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt", "Include", "REG_SZ", GUICtrlRead($h_UserIncludeDirectory))
				Local $T_Commands = "RegWrite('HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt', 'Include', 'REG_SZ'," & GUICtrlRead($h_UserIncludeDirectory) & ")"
				RunReqAdmin($T_Commands)
			EndIf
		Case $rc = $h_UserIncludeDirectory_Button
			GUISetState(@SW_HIDE)
			$NewDir = FileSelectFolder("Select the User Include directory:", "", 4, GUICtrlRead($h_UserIncludeDirectory))
			If @error = 0 Then
				GUICtrlSetData($h_UserIncludeDirectory, $NewDir)
				RegWrite("HKEY_CURRENT_USER\SOFTWARE\AutoIt v3\AutoIt", "Include", "REG_SZ", $NewDir)
				If RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt", "Include") <> "" Then
					RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt", "Include", "REG_SZ", $NewDir)
				EndIf
			EndIf
			GUISetState(@SW_SHOW)
			;
		Case $rc = $h_PLoaded
			If GUICtrlRead($h_PLoaded) = $GUI_CHECKED Then
				RunReqAdmin('RunWait("' & FileGetShortName($SciTE_Dir & "\defs\UpdateDefs.exe") & ' prod")')
;~ 				RunWait(FileGetShortName($SciTE_Dir & "\defs\UpdateDefs.exe") & " prod")
			EndIf
			If FileGetSize($SciTE_Dir & "\properties\au3.keywords.properties") = FileGetSize($SciTE_Dir & "\Defs\Production\au3.keywords.properties") Then
				GUICtrlSetState($h_PLoaded, $GUI_CHECKED)
			Else
				GUICtrlSetState($h_BLoaded, $GUI_CHECKED)
			EndIf
			Reload_Config()
			;
		Case $rc = $h_BLoaded
			If GUICtrlRead($h_BLoaded) = $GUI_CHECKED Then
				RunReqAdmin('RunWait("' & FileGetShortName($SciTE_Dir & "\defs\UpdateDefs.exe") & ' beta")')
;~ 				RunWait(FileGetShortName($SciTE_Dir & "\defs\UpdateDefs.exe") & " beta")
			EndIf
			If FileGetSize($SciTE_Dir & "\au3.keywords.properties") = FileGetSize($SciTE_Dir & "\Defs\Production\au3.keywords.properties") Then
				GUICtrlSetState($h_PLoaded, $GUI_CHECKED)
			Else
				GUICtrlSetState($h_BLoaded, $GUI_CHECKED)
			EndIf
			;
		Case $rc = $H_Use_Tabs
			$Use_Tabs = Not $Use_Tabs
			;
		Case $rc = $H_Syn_Mono Or $rc = $H_Syn_Prop
			$SYN_Font_Mono_ON = Not $SYN_Font_Mono_ON
			Update_Window()
			;
		Case $rc = $H_Syn_Mono_Change
			$Return = Select_Font($SYN_Font_Mono_Type, $SYN_Font_Mono_Size)
			Update_Window()
			;
		Case $rc = $H_Syn_Prop_Change
			$Return = Select_Font($SYN_Font_Prop_Type, $SYN_Font_Prop_Size)
			Update_Window()
			;
		Case $rc = $H_Background_Color
			$tempcolor = SelectColor($Background_Color, $Background_Color)
			If $tempcolor <> 0 Then $Background_Color = $tempcolor
			Update_Window()
			;GUICtrlSetBkColor($H_Background_Label, $Background_Color)
			;GUICtrlSetData($H_Background_Label, "Background Color:" & StringLower($Background_Color))
			;
		Case $rc = $H_CaretLine_Color
			$tempcolor = SelectColor($CaretLine_Color, $CaretLine_Color)
			If $tempcolor <> 0 Then $CaretLine_Color = $tempcolor
			GUICtrlSetBkColor($H_CaretLine_Label, $CaretLine_Color)
			GUICtrlSetData($H_CaretLine_Label, "Caret line Color:" & StringLower($CaretLine_Color))

		Case $rc = $H_Selection_Color
			$tempcolor = SelectColor($Selection_Color, $Selection_Color)
			If $tempcolor <> 0 Then $Selection_Color = $tempcolor
			GUICtrlSetColor($H_Selection_Label, $Selection_Color)

		Case $rc = $H_Selection_BkColor
			$tempcolor = SelectColor($Selection_BkColor, $Selection_BkColor)
			If $tempcolor <> 0 Then $Selection_BkColor = $tempcolor
			GUICtrlSetBkColor($H_Selection_Label, _AlphaFactor($Selection_BkColor))

		Case $rc = $H_SciTE4AutoIT3Updates
			CheckForUpdates(0)
	EndSelect
	; Check if one of the checkboxes is clicked
	For $x = 1 To 16
		If $rc = $H_Syn_bColor_Standard[$x] Then
			$Syn_bColor_Default[$x] = GUICtrlRead($H_Syn_bColor_Standard[$x])
			If GUICtrlRead($H_Syn_bColor_Standard[$x]) = $GUI_CHECKED Then
				GUICtrlSetState($H_Syn_bColor[$x], $GUI_DISABLE)
				$Syn_bColor[$x] = $Background_Color
				GUICtrlSetBkColor($H_Syn_Label[$x], $Syn_bColor[$x])
			Else
				GUICtrlSetState($H_Syn_bColor[$x], $GUI_ENABLE)
			EndIf
		EndIf
		If $rc = $H_Syn_Bold[$x] Then $Syn_Bold[$x] = Not $Syn_Bold[$x]
		If $rc = $H_Syn_Italic[$x] Then $Syn_Italic[$x] = Not $Syn_Italic[$x]
		If $rc = $H_Syn_Underline[$x] Then $Syn_Underline[$x] = Not $Syn_Underline[$x]
		If $rc = $H_Syn_fColor[$x] Then
			$tempcolor = SelectColor($Syn_Label[$x], $Syn_fColor[$x])
			$Syn_fColor[$x] = $tempcolor
			GUICtrlSetColor($H_Syn_Label[$x], $Syn_fColor[$x])
		EndIf
		If $rc = $H_Syn_bColor[$x] Then
			$tempcolor = SelectColor($Syn_Label[$x], $Syn_bColor[$x])
			$Syn_bColor[$x] = $tempcolor
			GUICtrlSetBkColor($H_Syn_Label[$x], $Syn_bColor[$x])
		EndIf
		If $rc = $H_Syn_Bold[$x] Or $rc = $H_Syn_Italic[$x] Or $rc = $H_Syn_Underline[$x] _
				Or $rc = $H_Syn_fColor[$x] Or $rc = $H_Syn_bColor[$x] Then
			GUICtrlSetFont($H_Syn_Label[$x], $SYN_Font_Size, 400 + $Syn_Bold[$x] * 200, $Syn_Italic[$x] * 2 + $Syn_Underline[$x] * 4, $SYN_Font_Type)
		EndIf
	Next

	; I would normally look for EN_CHANGE but thought this was less complicated
	If GUICtrlRead($H_Selection_Alpha) <> $Selection_Alpha Then
		$Selection_Alpha = GUICtrlRead($H_Selection_Alpha)
		GUICtrlSetBkColor($H_Selection_Label, _AlphaFactor($Selection_BkColor))
	EndIf
WEnd
Exit
;
;*****************************************************************************
; Update Window info
;*****************************************************************************
Func Update_Window()
	Local $x
	GUICtrlSetData($H_Syn_Mono, "等宽字体:" & $SYN_Font_Mono_Type)
	GUICtrlSetData($H_Syn_Prop, "比例字体:" & $SYN_Font_Prop_Type)
	GUICtrlSetData($H_Syn_Mono_Size, "大小:" & $SYN_Font_Mono_Size)
	GUICtrlSetData($H_Syn_Prop_Size, "大小:" & $SYN_Font_Prop_Size)
	If $ProperCase = 1 Then
		GUICtrlSetState($H_ProperCase, 1)
	Else
		GUICtrlSetState($H_ProperCase, 4)
	EndIf
	If $CheckuUpdatesSciTE4AutoIt3 = 1 Then
		GUICtrlSetState($H_CheckUpdatesSciTE4AutoIt3, 1)
	Else
		GUICtrlSetState($H_CheckUpdatesSciTE4AutoIt3, 4)
	EndIf
	If $SYN_Font_Mono_ON = 1 Then
		GUICtrlSetState($H_Syn_Mono, 1)
		GUICtrlSetState($H_Syn_Prop, 4)
		$SYN_Font_Type = $SYN_Font_Mono_Type
		$SYN_Font_Size = $SYN_Font_Mono_Size
	Else
		GUICtrlSetState($H_Syn_Mono, 4)
		GUICtrlSetState($H_Syn_Prop, 1)
		$SYN_Font_Type = $SYN_Font_Prop_Type
		$SYN_Font_Size = $SYN_Font_Prop_Size
	EndIf
	If $Use_Tabs = 1 Then
		GUICtrlSetState($H_Use_Tabs, 1)
	Else
		GUICtrlSetState($H_Use_Tabs, 4)
	EndIf
	GUICtrlSetBkColor($H_Background_Label, $Background_Color)
	GUICtrlSetBkColor($H_CaretLine_Label, $CaretLine_Color)
	GUICtrlSetColor($H_Selection_Label, $Selection_Color)
	GUICtrlSetBkColor($H_Selection_Label, _AlphaFactor($Selection_BkColor))
	For $x = 1 To 16
		GUICtrlSetColor($H_Syn_Label[$x], $Syn_fColor[$x])
		If $Syn_bColor_Default[$x] = $GUI_CHECKED Then
			$Syn_bColor[$x] = $Background_Color
			GUICtrlSetState($H_Syn_bColor_Standard[$x], $GUI_CHECKED)
			GUICtrlSetState($H_Syn_bColor[$x], $GUI_DISABLE)
		Else
			GUICtrlSetState($H_Syn_bColor[$x], $GUI_UNCHECKED)
			GUICtrlSetState($H_Syn_bColor[$x], $GUI_ENABLE)
		EndIf
		GUICtrlSetBkColor($H_Syn_Label[$x], $Syn_bColor[$x])
		GUICtrlSetFont($H_Syn_Label[$x], $SYN_Font_Size, 400 + $Syn_Bold[$x] * 200, $Syn_Italic[$x] * 2 + $Syn_Underline[$x] * 4, $SYN_Font_Type)
		;GUICtrlSetFont($H_Syn_Label[$x], $SYN_Font_Size, 400 + $Syn_Bold[$x] * 200, $Syn_Italic[$x] * 2 + $Syn_Underline[$x] * 4, $SYN_Font_Type)
		If $Syn_Bold[$x] Then
			GUICtrlSetState($H_Syn_Bold[$x], 1)
		Else
			GUICtrlSetState($H_Syn_Bold[$x], 4)
		EndIf
		If $Syn_Italic[$x] Then
			GUICtrlSetState($H_Syn_Italic[$x], 1)
		Else
			GUICtrlSetState($H_Syn_Italic[$x], 4)
		EndIf
		If $Syn_Underline[$x] Then
			GUICtrlSetState($H_Syn_Underline[$x], 1)
		Else
			GUICtrlSetState($H_Syn_Underline[$x], 4)
		EndIf
	Next
EndFunc   ;==>Update_Window
;
Func Get_Current_config()
	Local $z, $y, $x
	; Init background colors
	$Background_Color = "0xffffff"
	$CaretLine_Color = "0xFF0000"
	$Selection_Color = ""
	$Selection_BkColor = ""
	$Selection_Alpha = 50
	; init array
	For $z = 1 To 16
		$Syn_fColor[$z] = "0x000000"
		$Syn_bColor[$z] = ""
		$Syn_Bold[$z] = 0
		$Syn_Italic[$z] = 0
		$Syn_Underline[$z] = 0
	Next
	;
	$Backups = Number(SendSciTE_GetInfo($My_Hwnd, $SciTE_hwnd, "askproperty:backup.files"))
	$ProperCase = Number(SendSciTE_GetInfo($My_Hwnd, $SciTE_hwnd, "askproperty:proper.case"))
	$CheckuUpdatesSciTE4AutoIt3 = Number(SendSciTE_GetInfo($My_Hwnd, $SciTE_hwnd, "askproperty:check.updates.scite4autoit3"))
	$Use_Tabs = Number(SendSciTE_GetInfo($My_Hwnd, $SciTE_hwnd, "askproperty:use.tabs"))
	$Tab_Size = Number(SendSciTE_GetInfo($My_Hwnd, $SciTE_hwnd, "askproperty:tabsize"))
	;
	$rest = SendSciTE_GetInfo($My_Hwnd, $SciTE_hwnd, "askproperty:style.au3.32")
	If StringInStr($rest, "back:") Then
		$Background_Color = StringTrimLeft($rest, StringInStr($rest, "back:") + 4)
		$Background_Color = StringReplace($Background_Color, "#", "0X")
	EndIf
	If $Background_Color = "" Then
		$rest = SendSciTE_GetInfo($My_Hwnd, $SciTE_hwnd, "askproperty:style.*.32")
		If StringInStr($rest, "back:") Then
			$Background_Color = StringTrimLeft($rest, StringInStr($rest, "back:") + 4)
			$Background_Color = StringReplace($Background_Color, "#", "0X")
		EndIf
	EndIf
	If $Selection_Color = "" Then
		$Selection_Color = SendSciTE_GetInfo($My_Hwnd, $SciTE_hwnd, "askproperty:selection.fore")
		$Selection_Color = StringReplace($Selection_Color, "#", "0X")
	EndIf
	If  $Selection_BkColor = "" Then
		$Selection_BkColor = SendSciTE_GetInfo($My_Hwnd, $SciTE_hwnd, "askproperty:selection.back")
		$Selection_BkColor = StringReplace($Selection_BkColor, "#", "0X")
	EndIf
	If $Selection_Alpha <> 50 Then
		$Selection_Alpha = SendSciTE_GetInfo($My_Hwnd, $SciTE_hwnd, "askproperty:selection.alpha")
		$Selection_Alpha = Number($Selection_Alpha)
	EndIf
	$CaretLine_Color = SendSciTE_GetInfo($My_Hwnd, $SciTE_hwnd, "askproperty:caret.line.back")
	$CaretLine_Color = StringReplace($CaretLine_Color, "#", "0X")
	For $StyleNbr = 1 To 16
		$rest = SendSciTE_GetInfo($My_Hwnd, $SciTE_hwnd, "askproperty:style.au3." & $StyleNbr - 1)
		$Style = StringSplit(StringTrimLeft($rest, StringInStr($rest, "=")), ",")
		$Syn_Italic[$StyleNbr] = 0
		$Syn_Bold[$StyleNbr] = 0
		$Syn_Underline[$StyleNbr] = 0
		For $y = 1 To $Style[0]
			If $Style[$y] = "italics" Then $Syn_Italic[$StyleNbr] = 1
			If $Style[$y] = "bold" Then $Syn_Bold[$StyleNbr] = 1
			If $Style[$y] = "underlined" Then $Syn_Underline[$StyleNbr] = 1
			If StringLeft($Style[$y], 5) = "fore:" Then $Syn_fColor[$StyleNbr] = StringReplace(StringMid($Style[$y], 6), "#", "0X")
			If StringLeft($Style[$y], 5) = "back:" Then $Syn_bColor[$StyleNbr] = StringReplace(StringMid($Style[$y], 6), "#", "0X")
		Next
	Next
	; get the windows font section
	;font.base=font:Verdana,size:10,$(font.override)
	$rest = SendSciTE_GetInfo($My_Hwnd, $SciTE_hwnd, "askproperty:font.base")
	$param = StringSplit($rest, "=,")
	For $y = 1 To $param[0]
		If StringLeft($param[$y], 5) = "font:" Then $SYN_Font_Prop_Type = StringMid($param[$y], 6)
		If StringLeft($param[$y], 5) = "size:" Then $SYN_Font_Prop_Size = StringMid($param[$y], 6)
	Next
	;font.monospace=font:Courier New,size:10
	$rest = SendSciTE_GetInfo($My_Hwnd, $SciTE_hwnd, "askproperty:font.monospace")
	$param = StringSplit($rest, "=,")
	For $y = 1 To $param[0]
		If StringLeft($param[$y], 5) = "font:" Then $SYN_Font_Mono_Type = StringMid($param[$y], 6)
		If StringLeft($param[$y], 5) = "size:" Then $SYN_Font_Mono_Size = StringMid($param[$y], 6)
	Next
	;font.override=$(font.monospace)
	;font.base=font:Verdana,size:10,$(font.override)

	$rest = SendSciTE_GetInfo($My_Hwnd, $SciTE_hwnd, "askproperty:font.base")
	If StringInStr($rest,"$(font.override)") Then
		$SYN_Font_Mono_ON = 1
	Else
		$SYN_Font_Mono_ON = 0
	EndIf
	;******************************************************************************************************
	$Syn_Label[1] = "White space"
	$Syn_Label[2] = "Comment line"
	$Syn_Label[3] = "Comment block"
	$Syn_Label[4] = "Number"
	$Syn_Label[5] = "Function"
	$Syn_Label[6] = "Keyword"
	$Syn_Label[7] = "Macro"
	$Syn_Label[8] = "String"
	$Syn_Label[9] = "Operator"
	$Syn_Label[10] = "Variable"
	$Syn_Label[11] = "Sent keys"
	$Syn_Label[12] = "Pre-Processor"
	$Syn_Label[13] = "Special"
	$Syn_Label[14] = "Abbrev-Expand"
	$Syn_Label[15] = "Com Objects"
	$Syn_Label[16] = "Standard UDF's"
	; set the default background
	For $x = 1 To 16
		If $Syn_bColor[$x] = "" Or $Syn_bColor[$x] = $Background_Color Then
			$Syn_bColor[$x] = $Background_Color
			$Syn_bColor_Default[$x] = $GUI_CHECKED
		EndIf
	Next
EndFunc   ;==>Get_Current_config
;*****************************************************************************
; Font Selection part
;*****************************************************************************
Func Select_Font(ByRef $FontType, ByRef $FontSize)
	Local $a_font
	GUISetState(@SW_HIDE)
	$a_font = _ChooseFont($FontType, $FontSize)
	Local $rc = @error
	GUISetState(@SW_SHOW)
	If ($rc) Then Return 0
	$FontType = $a_font[2]
	$FontSize = $a_font[3]
	Return 1
EndFunc   ;==>Select_Font
;*****************************************************************************
; Color Selection Part
;*****************************************************************************
Func SelectColor($Type, $CurColor)
	Local $color
	GUISetState(@SW_HIDE)
	$color = _ChooseColor(2, $CurColor, 2)
	Local $rc = @error
	GUISetState(@SW_SHOW)
	If ($rc) Then Return $CurColor
	Return $color
EndFunc   ;==>SelectColor
;*****************************************************************************
; Save info to SciTEUser
;*****************************************************************************
Func Update_SciTE_User($Task)
	; Task=0 Remove settings In SciTEUser.properties
	; Task=1 Add/Update settings In SciTEUser.properties
	Local $x, $y
	$UserDir = @UserProfileDir
	If @OSTYPE = "WIN32_WINDOWS" Then $UserDir = $SciTE_Dir
	$au3Prop = $UserDir & "\SciTEUser.properties"
	$H_au3Prop = FileOpen($au3Prop, 0)
	$H_au3PropNew = FileOpen($au3Prop & ".New", 2)
	;
	$SciTEConfigSec = 0
	; copy all SciTEUser info To new SciTEuser.properties except old Settings...
	If $H_au3Prop <> -1 Then
		While 1
			$Irec = FileReadLine($H_au3Prop)
			If @error = -1 Then ExitLoop
			;
			If $Irec = "# DO NOT CHANGE ANYTHING BETWEEN THESE LINES #-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#" _
					Or $Irec = "#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#" Then
				$SciTEConfigSec = Not $SciTEConfigSec
				ContinueLoop
			EndIf
			If StringInStr($Irec, "style.au3") = 0 And StringInStr($Irec, "Font.") = 0 And $SciTEConfigSec = 0 Then
				FileWriteLine($H_au3PropNew, $Irec)
				ContinueLoop
			EndIf
		WEnd
	EndIf
	If $Task = 1 Then
		FileWriteLine($H_au3PropNew, "#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#")
		FileWriteLine($H_au3PropNew, "# START: DO NOT CHANGE ANYTHING AFTER THIS LINE     #-#-#-#-#")
		FileWriteLine($H_au3PropNew, "# Created by SciTEConfig")
		FileWriteLine($H_au3PropNew, "#------------------------------------------------------------")
		If $SYN_Font_Mono_ON = 1 Then
			FileWriteLine($H_au3PropNew, "font.base=font:" & $SYN_Font_Prop_Type & ",size:" & $SYN_Font_Prop_Size & ",$(font.override)")
		Else
			FileWriteLine($H_au3PropNew, "font.base=font:" & $SYN_Font_Prop_Type & ",size:" & $SYN_Font_Prop_Size)
		EndIf
		FileWriteLine($H_au3PropNew, "font.monospace=font:" & $SYN_Font_Mono_Type & ",size:" & $SYN_Font_Mono_Size)
		;Backup Info
		If GUICtrlRead($h_Backups) > 0 Then
			FileWriteLine($H_au3PropNew, "backup.files=" & GUICtrlRead($h_Backups))
		EndIf
		;propercase info
		If GUICtrlRead($H_ProperCase) = 1 Then
			FileWriteLine($H_au3PropNew, "proper.case=1")
		Else
			FileWriteLine($H_au3PropNew, "proper.case=0")
		EndIf
		;Check for updates
		If GUICtrlRead($H_CheckUpdatesSciTE4AutoIt3) = 1 Then
			FileWriteLine($H_au3PropNew, "check.updates.scite4autoit3=1")
		Else
			FileWriteLine($H_au3PropNew, "check.updates.scite4autoit3=0")
		EndIf
		;Tabs info
		If $Use_Tabs = 1 Then
			FileWriteLine($H_au3PropNew, "use.tabs=1")
		Else
			FileWriteLine($H_au3PropNew, "use.tabs=0")
		EndIf
		$Tab_Size = GUICtrlRead($H_Tab_Size)
		If Number($Tab_Size) > 0 Then
			FileWriteLine($H_au3PropNew, "indent.size=" & $Tab_Size)
			FileWriteLine($H_au3PropNew, "indent.size.*.au3=" & $Tab_Size)
			FileWriteLine($H_au3PropNew, "tabsize=" & $Tab_Size)
		EndIf
		; BackGround color
		FileWriteLine($H_au3PropNew, "#Background")
		$Orec = "style.au3.32=style.*.32=$(font.base)"
		If $Background_Color <> "" And $Background_Color <> "0XFFFFFF" Then $Orec = $Orec & ",back:#" & StringTrimLeft($Background_Color, 2)
		FileWriteLine($H_au3PropNew, $Orec)
		; caretline color
		If $CaretLine_Color <> "" And $CaretLine_Color <> "0XFFFFFF" Then
			FileWriteLine($H_au3PropNew, "#CaretLineBackground")
			FileWriteLine($H_au3PropNew, "caret.line.back=#" & StringTrimLeft($CaretLine_Color, 2))
		EndIf

		; Selection color
		FileWriteLine($H_au3PropNew, "#Selection Foreground/background and Alpha")
		FileWriteLine($H_au3PropNew, "selection.fore=#" & StringTrimLeft($Selection_Color, 2))
		FileWriteLine($H_au3PropNew, "selection.alpha=" & $Selection_Alpha)
		FileWriteLine($H_au3PropNew, "selection.back=#" & StringTrimLeft($Selection_BkColor, 2))

		;Write bracket color
;~ #
		FileWriteLine($H_au3PropNew, "# Brace highlight")
		$y = 6
		$Orec = "style.au3.34=fore:#" & StringTrimLeft($Syn_fColor[$y], 2)
		If $Syn_Italic[$y] Then $Orec = $Orec & ",italics"
		If $Syn_Bold[$y] Then $Orec = $Orec & ",bold"
		If $Syn_Underline[$y] Then $Orec = $Orec & ",underlined"
		If $Syn_bColor[$y] <> "" And $Syn_bColor[$y] <> "0XFFFFFF" Then $Orec = $Orec & ",back:#" & StringTrimLeft($Syn_bColor[$y], 2)
		FileWriteLine($H_au3PropNew, $Orec)
		FileWriteLine($H_au3PropNew, "# Brace incomplete highlight")
		$y = 2
		$Orec = "style.au3.35=fore:#" & StringTrimLeft($Syn_fColor[$y], 2)
		If $Syn_Italic[$y] Then $Orec = $Orec & ",italics"
		If $Syn_Bold[$y] Then $Orec = $Orec & ",bold"
		If $Syn_Underline[$y] Then $Orec = $Orec & ",underlined"
		If $Syn_bColor[$y] <> "" And $Syn_bColor[$y] <> "0XFFFFFF" Then $Orec = $Orec & ",back:#" & StringTrimLeft($Syn_bColor[$y], 2)
		FileWriteLine($H_au3PropNew, $Orec)
		For $y = 1 To 16
			;# Comment block
			;style.au3.2=fore:#669900,italics
			FileWriteLine($H_au3PropNew, "#" & $Syn_Label[$y])
			$Orec = "style.au3." & $y - 1 & "=fore:#" & StringTrimLeft($Syn_fColor[$y], 2)
			If $Syn_Italic[$y] Then $Orec = $Orec & ",italics"
			If $Syn_Bold[$y] Then $Orec = $Orec & ",bold"
			If $Syn_Underline[$y] Then $Orec = $Orec & ",underlined"
			;If $Syn_bColor[$y] <> $Background_Color And $Syn_bColor[$y] <> "0XFFFFFF" Then $Orec = $Orec & ",back:#" & StringTrimLeft($Syn_bColor[$y], 2)
			$Orec = $Orec & ",back:#" & StringTrimLeft($Syn_bColor[$y], 2)
			FileWriteLine($H_au3PropNew, $Orec)
		Next
		FileWriteLine($H_au3PropNew, "# END => DO NOT CHANGE ANYTHING BEFORE THIS LINE  #-#-#-#-#-#")
		FileWriteLine($H_au3PropNew, "#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#")
	EndIf
	If $H_au3Prop <> -1 Then
		FileClose($H_au3Prop)
		FileMove($UserDir & "\SciTEUser.properties", $UserDir & "\SciTEUser.properties.old", 1)
	EndIf
	FileClose($H_au3PropNew)
	FileMove($UserDir & "\SciTEUser.properties.new", $UserDir & "\SciTEUser.properties", 1)
	Reload_Config()
EndFunc   ;==>Update_SciTE_User
;
Func Reload_Config()
	Opt("WinSearchChildren", 1)
	;Send SciTE Director my GUI handle so it will report info back from SciTE
	SendSciTE_Command(0, $SciTE_hwnd, "reloadproperties:")
EndFunc   ;==>Reload_Config
;
Func Update_User_Properties($Property, $value)
	Opt("WinSearchChildren", 1)
	; Get SciTE DirectorHandle
	$SciTE_hwnd = WinGetHandle("DirectorExtension")
	;Send SciTE Director my GUI handle so it will report info back from SciTE
	SendSciTE_Command(0, $SciTE_hwnd, "property:user:style.au3." & $Property & "=" & $value)
EndFunc   ;==>Update_User_Properties
;
;
Func SendSciTE_GetInfo($My_Hwnd, $SciTE_hwnd, $sCmd)
	$My_Dec_Hwnd = Dec(StringTrimLeft($My_Hwnd, 2))
	$sCmd = ":" & $My_Dec_Hwnd & ":" & $sCmd
	$SciTECmd = ""
	SendSciTE_Command($My_Hwnd, $SciTE_hwnd, $sCmd)
	For $x = 1 To 10
		If $SciTECmd <> "" Then ExitLoop
		Sleep(20)
	Next
	$SciTECmd = StringTrimLeft($SciTECmd, StringLen(":" & $My_Dec_Hwnd & ":"))
	$SciTECmd = StringReplace($SciTECmd, "macro:stringinfo:", "")
	Return $SciTECmd
EndFunc   ;==>SendSciTE_GetInfo
;
Func SciTE_Update_Property($My_Hwnd, $SciTE_hwnd, $key, $value)
	$My_Dec_Hwnd = Dec(StringTrimLeft($My_Hwnd, 2))
	Local $sCmd = ":" & $My_Dec_Hwnd & ":" & "property:" & $key & "=" & $value
	SendSciTE_Command($My_Hwnd, $SciTE_hwnd, $sCmd)
EndFunc   ;==>SciTE_Update_Property
;
Func SendSciTE_Command($My_Hwnd, $SciTE_hwnd, $sCmd)
	Local $WM_COPYDATA = 74
	Local $CmdStruct = DllStructCreate('Char[' & StringLen($sCmd) + 1 & ']')
	;ConsoleWrite('-->' & $sCmd & @lf )
	DllStructSetData($CmdStruct, 1, $sCmd)
	Local $COPYDATA = DllStructCreate('Ptr;DWord;Ptr')
	DllStructSetData($COPYDATA, 1, 1)
	DllStructSetData($COPYDATA, 2, StringLen($sCmd) + 1)
	DllStructSetData($COPYDATA, 3, DllStructGetPtr($CmdStruct))
	DllCall('User32.dll', 'None', 'SendMessage', 'HWnd', $SciTE_hwnd, _
			'Int', $WM_COPYDATA, 'HWnd', $My_Hwnd, _
			'Ptr', DllStructGetPtr($COPYDATA))
EndFunc   ;==>SendSciTE_Command
; Received Data from SciTE
Func MY_WM_COPYDATA($hWnd, $msg, $wParam, $lParam)
	Local $COPYDATA = DllStructCreate('Ptr;DWord;Ptr', $lParam)
	$SciTECmdLen = DllStructGetData($COPYDATA, 2)
	Local $CmdStruct = DllStructCreate('Char[255]', DllStructGetData($COPYDATA, 3))
	$SciTECmd = StringLeft(DllStructGetData($CmdStruct, 1), $SciTECmdLen)
	;ConsoleWrite('<--' & $SciTECmd & @lf )
	;GUICtrlSetData($list,GUICtrlRead($list) & '<--' & $SciTECmd & @CRLF )
EndFunc   ;==>MY_WM_COPYDATA
; Check for the availablility of New installers for SciTE4AutoIT3
Func CheckForUpdates($Silent = 1)
	$rc = InetGet('http://www.autoitscript.com/autoit3/scite/download/scite4autoit3version.ini', $SciTE_Dir & "\scite4autoit3versionWeb.ini", 1)
	If $rc Then
		$SciTE4AutoIt3WebDate = IniRead($SciTE_Dir & "\scite4autoit3versionWeb.ini", 'SciTE4AutoIt3', 'Date', '')
		$SciTE4Au3UpdWebDate = IniRead($SciTE_Dir & "\scite4autoit3versionWeb.ini", 'SciTE4Au3Upd', 'Date', '')
		$SciTE4AutoIt3RegDate = RegRead("HKLM\Software\Microsoft\Windows\Currentversion\Uninstall\SciTE4AutoIt3", 'DisplayVersion')
		$SciTE4AutoIt3Date = IniRead($SciTE_Dir & "\SciTEVersion.ini", 'SciTE4AutoIt3', 'Date', '')
		$SciTE4Au3UpdDate = IniRead($SciTE_Dir & "\SciTEVersion.ini", 'SciTE4Au3Upd', 'Date', '')
		; If the INI date is blank then use the registry Date
		If $SciTE4AutoIt3Date = "" Then
			; If registry date is empty then assume the installer is never used and thus exit.
			If $SciTE4AutoIt3RegDate = "" Then
				If $Silent = 0 Then MsgBox(0 + 262144, "SciTE4AutoIt3", "No updates available.")
				Exit
			EndIf
			$SciTE4AutoIt3Date = $SciTE4AutoIt3RegDate
			IniWrite($SciTE_Dir & "\SciTEConfig.ini", 'SciTE4AutoIt3', 'Date', $SciTE4AutoIt3Date)
		EndIf
		; Check for updated SciTE4AutoIt3 Installer
		If $SciTE4AutoIt3WebDate <> $SciTE4AutoIt3Date Then
			$msg = "Your SciTE4AutoIt3 version is " & $SciTE4AutoIt3Date & @LF & @LF & _
					"The latest SciTE4AutoIt3 version is " & $SciTE4AutoIt3WebDate & @LF & @LF & _
					"Do you want to go to the SciTE4AutoIt3 Download page?"
			If MsgBox(4 + 262144, "New SciTE4AutoIt3 installer available", $msg) = 6 Then
				Run(@ComSpec & " /c start http://www.autoitscript.com/autoit3/scite/downloads.shtml", '', @SW_HIDE)
			EndIf
		Else
			; Check for Patch updates
			If $SciTE4Au3UpdWebDate <> "" And $SciTE4Au3UpdWebDate <> $SciTE4Au3UpdDate Then
				$msg = "There is a SciTE4Au3Upd installer available dated: " & $SciTE4Au3UpdWebDate & @LF & _
						"Do you want to go to the SciTE4AutoIt3 Download page?"
				If MsgBox(4 + 262144, "New SciTE4Au3Upd installer available", $msg) = 6 Then
					Run(@ComSpec & " /c start http://www.autoitscript.com/autoit3/scite/downloads.shtml", '', @SW_HIDE)
				EndIf
			Else
				If $Silent = 0 Then MsgBox(262144, "SciTE4AutoIt3", "No updates available.")
			EndIf
		EndIf
	Else
		If $Silent = 0 Then MsgBox(262144, "SciTE4AutoIt3", "Not able to connect to WebSite.")
	EndIf
EndFunc   ;==>CheckForUpdates
; Tools Selection Tab related
Func SciteToolsFileRead($file_au3properties)
	Local $comment = '#~ ', $handle_read, $line, $split, $total
	; Open Au3.properties for Read
	$handle_read = FileOpen($file_au3properties, 0)
	If $handle_read = -1 Then
		ConsoleWrite('Unable to open for read ' & $file_au3properties & @CRLF)
		Return SetError(1, 0, '')
	EndIf
	; Read Tools headers from Au3.properties
	While True
		$line = FileReadLine($handle_read)
		If @error Then ExitLoop
		$line = StringStripWS($line, 3)
		If Not $line Then
			ContinueLoop
		ElseIf StringRegExp($line, $comment & '# [0-9]{1,2}') Or StringRegExp($line, '# [0-9]{1,2}') Then
			$total &= $line & '|'
		EndIf
	WEnd
	FileClose($handle_read)
	; Remove last pipe char
	If StringRight($total, 1) = '|' Then
		$total = StringTrimRight($total, 1)
	EndIf
	; Split Tools headers into an Array
	$split = StringSplit($total, '|')
	Return SetError(@error, @extended, $split)
EndFunc   ;==>SciteToolsFileRead
;
Func SciteToolsFileWrite($file_au3properties)
	; Process Au3.properties with selections made
	Local $check, $comment = '#~ ', $debug
	Local $done, $file_temp, $handle_read, $handle_write, $i
	Local $line, $checkbox_state, $checkbox_text
	Dim $checkbox
	If Not FileExists($file_au3properties) Then Return
	$file_temp = _TempFile()
	$handle_read = FileOpen($file_au3properties, 0)
	If $handle_read = -1 Then
		ConsoleWrite('Unable to open for read ' & $file_au3properties & @LF)
		Return
	EndIf
	$handle_write = FileOpen($file_temp, 2)
	If $handle_read = -1 Then
		ConsoleWrite('Unable to open for write ' & $file_temp & @LF)
		FileClose($handle_read)
		Return
	EndIf
	;
	While True
		$line = FileReadLine($handle_read)
		If @error Then ExitLoop
		$tline = StringStripWS($line, 3)
		Switch $tline
			Case '', '#', '##'
				; Write line then loop again
				FileWriteLine($handle_write, $line)
				ContinueLoop
			Case '# Standard LUA Functions', 'extension.$(file.patterns.au3)=$(SciteDefaultHome)\AutoIt3.lua'
				; Write line then loop again
				FileWriteLine($handle_write, $line)
				ContinueLoop
			Case '# Commands to for Help F1'
				; After help line shows, then just write the rest of the file
				FileWriteLine($handle_write, $line)
				While 1
					$line = FileReadLine($handle_read)
					If @error Then ExitLoop 2
					FileWriteLine($handle_write, $line)
				WEnd
				ExitLoop
            Case 'if BETA_AUTOIT' ; Skip Beta Tools
                $done = False
                FileWriteLine($handle_write, $line)
                ContinueLoop
		EndSwitch
		Switch StringRegExp($tline, '##? [0-9]{1,2}')
			Case True
				; Found a Tools line so enable or disable it
				$done = True
				For $i = 1 To UBound($checkbox) - 1 ;$split[0]
					$checkbox_state = GUICtrlRead($checkbox[$i])
					$checkbox_text = GUICtrlRead($checkbox[$i], 1)
					; Match the the line to a TreeView item
					If StringInStr($line, $checkbox_text) Then
						; Reset line status
						$check = 0
						If StringLeft($line, 3) = $comment Then
							If BitAND($checkbox_state, $GUI_CHECKED) = $GUI_CHECKED Then; is commented
								; UnComment line
								While StringLeft($line, 3) = $comment
									$line = StringTrimLeft($line, 3)
								WEnd
								$check = -1
							EndIf
						ElseIf BitAND($checkbox_state, $GUI_UNCHECKED) = $GUI_UNCHECKED Then; is not commented
							; Comment line
							While Not (StringLeft($line, 3) = $comment)
								$line = $comment & $line
							WEnd
							$check = 1
						EndIf
						IniWrite(@ScriptDir & '\SciteTools.ini', 'Tools Selection Tab', $i, $line)
						If $debug Then
							If $check = 1 Then
								$debug_1 = 'Disabled '
							ElseIf $check = -1 Then
								$debug_1 = 'Enabled  '
							Else
								ExitLoop
							EndIf
							ConsoleWrite($debug_1 & ' ' & StringTrimLeft($checkbox_text, 3) & @LF)
						EndIf
						ExitLoop
					EndIf
				Next
			Case Else
				; Command lines for Tools which are enabled or disabled
				If $done Then
					If $check = -1 Then
						; Trim comment
						While StringLeft($line, 3) = $comment
							$line = StringTrimLeft($line, 3)
						WEnd
					ElseIf $check = 1 Then
						; Add comment
						While Not (StringLeft($line, 3) = $comment)
							$line = $comment & $line
						WEnd
					EndIf
				EndIf
		EndSwitch
		FileWriteLine($handle_write, $line)
	WEnd
	;
	FileClose($handle_read)
	FileClose($handle_write)
	Sleep(50)
;~ 	If Not FileWrite($file_au3properties, " ") Then
;~ 		Local $temp_Script = _TempFile(@TempDir, "~", ".au3")
;~ 		MsgBox(262144, "Need Admin mode", "Admin mode is needed to update au3.properties. Answer the following prompts to allow the update.")
;~ 		FileWriteLine($temp_Script, '#RequireAdmin')
;~ 		FileWriteLine($temp_Script, "FileCopy('" & $file_au3properties & "','" & $file_au3properties & "_old" & "', 1)")
;~ 		FileWriteLine($temp_Script, "FileDelete('" & $file_au3properties & "')")
;~ 		FileWriteLine($temp_Script, "FileCopy('" & $file_temp & "','" & $file_au3properties & "', 1)")
;~ 		FileWriteLine($temp_Script, "FileDelete('" & $file_temp & "')")
;~ 		RunWait('"' & @ScriptFullPath & '" /AutoIt3ExecuteScript "' & $temp_Script & '"')
;~ 		While FileExists($file_temp)
;~ 			Sleep(50)
;~ 		WEnd
;~ 		FileDelete($temp_Script)
	Local $T_Commands
	$T_Commands &= "FileCopy('" & $file_au3properties & "','" & $file_au3properties & "_old" & "', 1)" & @CRLF
	$T_Commands &= "FileDelete('" & $file_au3properties & "')" & @CRLF
	$T_Commands &= "FileCopy('" & $file_temp & "','" & $file_au3properties & "', 1)" & @CRLF
	$T_Commands &= "FileDelete('" & $file_temp & "')"
	RunReqAdmin($T_Commands)
;~ 	Else
;~ 		FileMove($file_au3properties, $file_au3properties & "_old")
;~ 		FileMove($file_temp, $file_au3properties, 1)
;~ 		FileDelete($file_temp)
;~ 	EndIf
EndFunc   ;==>SciteToolsFileWrite

Func SelectNewScheme()
	; Task=0 Remove settings In SciTEUser.properties
	; Task=1 Add/Update settings In SciTEUser.properties
	; Find all default scheme's
	Local $Schemes = " [NoChange]"
	Local $s_name
	Local $search = FileFindFirstFile(@ScriptDir & "\*.SciTEConfig")
	Local $SaveUserSettings = ""
	; Check if the search was successful
	If $search = -1 Then
		; No default schema's found so just remove the personal settings and revert to the au3.properties.
		If 6 = MsgBox(4 + 262144, 'SciTE Config', 'There are no *.SciTEConfig files available, do you want to Remove the user settings and revert to the standard SciTE4AutoIt3 setting?') Then
			Update_SciTE_User(0)
		EndIf
		Return
	EndIf
	;
	While 1
		$file = FileFindNextFile($search)
		If @error Then ExitLoop
		$s_name = StringMid(FileReadLine(@ScriptDir & "\" & $file, 3), 3)
		If StringLeft($file, 2) = "[L" Then
			$Schemes &= "| " & StringReplace($file, ".SciteConfig", "") & " ==> Last modified User Settings"
		Else
			$Schemes &= "|" & StringReplace($file, ".SciteConfig", "") & " ==> " & $s_name
		EndIf
	WEnd
	;
	FileClose($search)
	;
	$gui2 = GUICreate("Select new default Color/Font Scheme", 500, 100, -1, -1, $WS_CAPTION, $WS_EX_TOPMOST)
	GUICtrlCreateLabel("Select new default Color/Font Scheme.", 30, 10)
	$h_Scheme = GUICtrlCreateCombo("", 30, 35, 460, 80, $CBS_DROPDOWN + $CBS_AUTOHSCROLL + $WS_VSCROLL + $CBS_SORT)
	GUICtrlSetData(-1, $Schemes, " [NoChange]")
	Local $h_Ok = GUICtrlCreateButton("确定", 155, 60, 80, 33, 0)
	GUICtrlSetState(-1, $GUI_DEFBUTTON)
	Local $h_Cancel = GUICtrlCreateButton("取消", 265, 60, 80, 33, 0)
	GUISetState(@SW_SHOW, $gui2)
	Local $rc
	While 1
		$nMsg = GUIGetMsg()
		Select
			Case $nMsg = $GUI_EVENT_CLOSE Or $nMsg = $h_Cancel
				$rc = 9
				ExitLoop
			Case $nMsg = $h_Ok
				$rc = 1
				ExitLoop
		EndSelect
	WEnd
	Local $SchemeFile = GUICtrlRead($h_Scheme)
	GUIDelete($gui2)
	;
	If $rc = 9 Then Return
	;
	If StringInStr($SchemeFile, " ==> ") Then $SchemeFile = StringLeft($SchemeFile, StringInStr($SchemeFile, " ==> ") - 1) & ".SciteConfig"
	If $SchemeFile = " [NoChange]" Then Return
	;
	Local $x, $y
	$UserDir = @UserProfileDir
	If @OSTYPE = "WIN32_WINDOWS" Then $UserDir = @ScriptDir
	$au3Prop = $UserDir & "\SciTEUser.properties"
	$H_au3Prop = FileOpen($au3Prop, 0)
	$H_au3PropNew = FileOpen($au3Prop & ".New", 2)
	;
	$SchemeFile = StringStripWS($SchemeFile, 3)
	$H_au3PropScheme = FileOpen(@ScriptDir & "\" & $SchemeFile, 0)
	;
	$SciTEConfigSec = 0
	; copy all SciTEUser info To new SciTEuser.properties except old Settings...
	If $H_au3Prop <> -1 Then
		While 1
			$Irec = FileReadLine($H_au3Prop)
			If @error = -1 Then ExitLoop
			;
			If $Irec = "# DO NOT CHANGE ANYTHING BETWEEN THESE LINES #-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#" _
					Or $Irec = "#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#" Then
				$SciTEConfigSec = Not $SciTEConfigSec
				If $SchemeFile <> "[Last_User_setting].SciTEConfig" Then $SaveUserSettings &= $Irec & @CRLF
				ContinueLoop
			EndIf
			If Not $SciTEConfigSec And StringInStr($Irec, "style.au3") = 0 And StringInStr($Irec, "Font.") = 0 Then
				FileWriteLine($H_au3PropNew, $Irec)
				ContinueLoop
			Else
				If $SchemeFile <> "[Last_User_setting].SciTEConfig" Then $SaveUserSettings &= $Irec & @CRLF
			EndIf
		WEnd
	EndIf
	If $H_au3PropScheme <> -1 Then
		While 1
			$Irec = FileReadLine($H_au3PropScheme)
			If @error = -1 Then ExitLoop
			FileWriteLine($H_au3PropNew, $Irec)
		WEnd
	EndIf
	;
	If $H_au3Prop <> -1 Then
		FileClose($H_au3Prop)
		FileMove($UserDir & "\SciTEUser.properties", $UserDir & "\SciTEUser.properties.old", 1)
	EndIf
	FileClose($H_au3PropNew)
	If $SchemeFile <> "[Last_User_setting].SciTEConfig" Then
		If StringInStr($SaveUserSettings, "# Created by SciTEConfig") Then
			$H_au3PropScheme_User = FileOpen(@ScriptDir & "\[Last_User_setting].SciTEConfig", 2)
			FileWrite($H_au3PropScheme_User, $SaveUserSettings)
			FileClose($H_au3PropScheme_User)
		EndIf
	EndIf
	FileMove($UserDir & "\SciTEUser.properties.new", $UserDir & "\SciTEUser.properties", 1)
EndFunc   ;==>SelectNewScheme
;
Func RunReqAdmin($Autoit3Commands, $prompt = 1)
	Local $temp_Script = _TempFile(@TempDir, "~", ".au3")
	Local $temp_check = _TempFile(@TempDir, "~", ".chk")
	FileWriteLine($temp_check, 'TempFile')
	FileWriteLine($temp_Script, '#NoTrayIcon')
	If Not IsAdmin() Then
		FileWriteLine($temp_Script, '#RequireAdmin')
		If $prompt = 1 Then MsgBox(262144, "Need Admin mode", "Admin mode is needed for this update. Answer the following prompts to allow the update.")
	EndIf
	FileWriteLine($temp_Script, $Autoit3Commands)
	FileWriteLine($temp_Script, "FileDelete('" & $temp_check & "')")
	RunWait('"' & @ScriptFullPath & '" /AutoIt3ExecuteScript "' & $temp_Script & '"')
	While FileExists($temp_check)
		Sleep(50)
	WEnd
	FileDelete($temp_Script)
EndFunc   ;==>RunReqAdmin

; This was my best attempt at getting the alpha value to correctly affect the background colour as is does in SciTE
Func _AlphaFactor($Colour)
	Local $iFactor = .8 * (255 - $Selection_Alpha) / 255 ; The .8 is a fudge to make the colour look right - probably a monitor thing
	Local $aColours[3]
	Local $Comp = _ColorGetRed($Colour)
	Local $Inc = (0xFF - $Comp) * $iFactor
	$aColours[0] = $Comp + $Inc
	$Comp = _ColorGetGreen($Colour)
	$Inc = (0xFF - $Comp) * $iFactor
	$aColours[1] = $Comp + $Inc
	$Comp = _ColorGetBlue($Colour)
	$Inc = (0xFF - $Comp) * $iFactor
	$aColours[2] = $Comp + $Inc
	Return _ColorSetRGB($aColours)
EndFunc

