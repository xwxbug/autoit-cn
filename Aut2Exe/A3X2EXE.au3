#cs ----------------------------------------------------------------------------

 AutoIt 版本: 3.2.5.1(第一版)
 脚本作者: 
	Email: 
	QQ/TM: 
 脚本版本: 
 脚本功能: 

#ce ----------------------------------------------------------------------------


#Region AutoIt3Wrapper 编译参数
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Icon= 						
#AutoIt3Wrapper_OutFile=..\autoit3\Aut2Exe\A3X2EXE.exe					
#AutoIt3Wrapper_OutFile_Type=exe				
#AutoIt3Wrapper_Compression=4				
#AutoIt3Wrapper_UseUpx=n			
#AutoIt3Wrapper_Res_Comment=编译A3X到EXE	 					
#AutoIt3Wrapper_Res_Description=编译A3X到EXE				
#AutoIt3Wrapper_Res_Fileversion=3.2.11.1
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=p                                               
#AutoIt3Wrapper_Res_LegalCopyright=thesnow 		
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Res_Field=thesnow|rundll32@126.com
#AutoIt3Wrapper_Run_Tidy=                   
#AutoIt3Wrapper_Run_AU3Check= 				
#AutoIt3Wrapper_Run_Before= 	
#EndRegion AutoIt3Wrapper 编译参数设置完成
#NoTrayIcon
; 脚本开始 - 在这后面添加您的代码.
#include <Process.au3>
$AutoItASC=@ScriptDir & "\AutoItSC.bin"
MsgBox(32,"说明:","这个工具可以将A3X脚本转换为EXE文件." & @CRLF & "公式:A3X=编译(脚本)	EXE=AutoItSC.bin+A3X+(UPX)")
$file=FileOpenDialog("选择您的A3X脚本文件","","A3X 文件(*.A3X)")
if @error = 1 then Exit
if FileExists($file) Then _RunDOS("copy /b " & $AutoItASC & "+" & $file & " " & $file & ".exe")
$YN=MsgBox(36,"恭喜!成功完成!","恭喜已经转换A3X到EXE,是否需要进行UPX压缩?")
If $YN=6 Then Run("cmd /k " & @ScriptDir & "\upx.exe " & $file & ".exe" )