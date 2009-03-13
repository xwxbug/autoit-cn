#cs ----------------------------------------------------------------------------
	
	AutoIt 版本: 3.2.8.1(第一版)
	脚本作者:
	Email:
	QQ/TM:
	脚本版本:
	脚本功能:
	
#ce ----------------------------------------------------------------------------


#Region AutoIt3Wrapper 编译参数
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Icon= TC.ico
#AutoIt3Wrapper_OutFile= 
#AutoIt3Wrapper_OutFile_Type=exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Comment= 任意文件转换为脚本(非FileInstall)主要用于UDF中包含文件。
#AutoIt3Wrapper_Res_Description= thesnow
#AutoIt3Wrapper_Res_Fileversion=3.2.11.1
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=p
#AutoIt3Wrapper_Res_LegalCopyright= thesnow
#AutoIt3Wrapper_Run_Tidy=
#AutoIt3Wrapper_Run_Obfuscator=
#AutoIt3Wrapper_Run_AU3Check=
#AutoIt3Wrapper_Run_Before=
#AutoIt3Wrapper_Run_After=
#EndRegion AutoIt3Wrapper 编译参数设置完成

; 脚本开始 - 在这后面添加您的代码.
#NoTrayIcon
MsgBox(32,"此程序存在的必要","在AUTOIT中,INCLUDE目录放的UDF如果需要包含文件,只能是二进制写入(把文件放到INCLUDE目录编译时无法找到文件).本程序可以转换.")


$OpenFilename = FileOpenDialog("选择您要转换的文件", -1, "所有文件(*.*)")
If $OpenFilename = "" Then Exit
if FileGetSize($OpenFilename) > (5 * 1024^2) Then
	MsgBox(32,"注意!","这个程序不是用来写入大文件的,因为文件大于5M,程序将退出!")
	Exit
EndIf
$SaveFilename = FileSaveDialog("选择您要保存的文件", -1, "脚本文件(*.au3)")
If $SaveFilename = "" Then Exit
if StringRight($SaveFilename,3) <> "au3" then $SaveFilename &= ".au3"
$fileopen = FileOpen($OpenFilename, 16)
$time=TimerInit()
ToolTip("开始转换,根据您文件的大小不同而花的时间不同." & @CRLF & "当前进度0%",0,0)
$FuncName=StringReplace($OpenFilename,"/","\")
$FuncName=StringReplace($OpenFilename,".","_")
$FuncName=StringSplit($FuncName,"\")
FileWriteLine($SaveFilename, 'Func ' & $FuncName[$FuncName[0]] & '()')
FileWriteLine($SaveFilename, 'Local $FileBin=""')
$size=FileGetSize($OpenFilename)
For $i = 1 To $size Step 100
	ToolTip("开始转换,根据您文件的大小不同而花的时间不同." & @CRLF & "当前进度" & Round(($i/$size),3) * 100 & "%",0,0)
	$file = FileRead($fileopen, 100)
	FileWriteLine($SaveFilename, '$FileBin &="' & StringReplace($file, "0x", "") & '"')
Next
FileWriteLine($SaveFilename, 'Return Binary("0x" & $FileBin)')
FileWriteLine($SaveFilename, 'EndFunc')
FileWriteLine($SaveFilename & ".调用.au3", '#include <' & $SaveFilename & '>')
FileWriteLine($SaveFilename & ".调用.au3", 'FileWrite("' & $OpenFilename & '",' & $FuncName[$FuncName[0]] & '())')
ToolTip("")
MsgBox(32, "", "已经转换完成！耗时 " & TimerDiff($time)/1000 & "秒")
