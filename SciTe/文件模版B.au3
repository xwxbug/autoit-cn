#Region AutoIt3Wrapper 预编译参数(完整参数)
;** 这个列表中中的编译器定义是为 AutoIt3Wrapper.exe 使用的，同时也兼容ACN论坛的ACNWrapper.exe.
;** 注释行不需要您删除，这是一些描述信息，不会到最终的EXE中.
;===============================================================================================================
;** AUTOIT3 设置
#AutoIt3Wrapper_UseX64=                         ;(Y/N) 使用 X64 版本的 AutoIt3_x64/AUT2EXE_x64. 默认=N
#AutoIt3Wrapper_Run_Debug_Mode=                 ;(Y/N) 运行脚本于控制图调试. 默认=N
#AutoIt3Wrapper_Run_SciTE_Minimized=            ;(Y/N) Minimize SciTE while script is running. Default=n
#AutoIt3Wrapper_Run_SciTE_OutputPane_Minimized= ;(Y/N) Toggle SciTE output pane at run time so its not shown. Default=n
;===============================================================================================================
;** AUT2EXE 设置
#AutoIt3Wrapper_Icon=                           ;需要使用的图标(路径)名称,支持EXE,DLL,ICO
#AutoIt3Wrapper_OutFile=                        ;目标 exe/a3x 文件名.
#AutoIt3Wrapper_OutFile_Type=exe                ;a3x=小型 AutoIt3 文件; exe=标准可执行文件(默认)
#AutoIt3Wrapper_Compression=                    ;压缩参数 0-4 ?=低 2=中 4=高 默认=2
#AutoIt3Wrapper_UseUpx=                         ;(Y/N) 压缩输出的程序.  默认=Y
#AutoIt3Wrapper_UPX_Parameters=                 ;Override the default setting for UPX.
#AutoIt3Wrapper_Change2CUI=                     ;(Y/N) 修改输出的程序为CUI(控制台程序). 默认=N
;===============================================================================================================
;** 目标程序资源信息
#AutoIt3Wrapper_Res_Comment=                    ;注释
#AutoIt3Wrapper_Res_Description=                ;详细信息
#AutoIt3Wrapper_Res_Fileversion=                ;文件版本
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=  ;(Y/N/P)自动更新版本  . 默认=N P=提示
#AutoIt3Wrapper_Res_ProductVersion=             ;Product Version. Default is the AutoIt3 version used.
#AutoIt3Wrapper_Res_Language=                   ;资源语言代码. 官方默认 2057=英语 (英国),ACN版本默认 2052=简体中文(中国)
#AutoIt3Wrapper_Res_LegalCopyright=             ;版权
#AutoIt3Wrapper_res_requestedExecutionLevel=    ;None, asInvoker, highestAvailable or requireAdministrator   (默认=None)
#AutoIt3Wrapper_res_Compatibility=    		;Vista,Windows7 . Both alloweed seperated by a comma     (default=None)
#AutoIt3Wrapper_Res_SaveSource=                 ;(Y/N) 保持源代码备份到EXE资源中. 默认=N
; If _Res_SaveSource=Y the content of Scriptsource depends on the _Run_Obfuscator and #obfuscator_parameters directives:
;
;	 If _Run_Obfuscator=Y then
;	    If #obfuscator_parameters=/STRIPONLY then Scriptsource is stripped script & stripped includes
;	    If #obfuscator_parameters=/STRIPONLYINCLUDES then Scriptsource is original script & stripped includes
;	    With any other parameters, the SaveSource directive is ignored as obfuscation is intended to protect the source
; 	 If _Run_Obfuscator=N or is not set then
;    	Scriptsource is original script only
; Autoit3Wrapper indicates the SaveSource action taken in the SciTE console during compilation
; See SciTE4AutoIt3 Helpfile for more detail on Obfuscator parameters
;
;
; free form resource fields ... max 15
;     you can use the following variables:
;     %AutoItVer% which will be replaced with the version of AutoIt3
;     %date% = PC date in short date format
;     %longdate% = PC date in long date format
;     %time% = PC timeformat
;  eg: #AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Res_Field=                      ;Free format fieldname|fieldvalue
#AutoIt3Wrapper_Res_Field=                      ;Free format fieldname|fieldvalue
#AutoIt3Wrapper_Res_Field=                      ;Free format fieldname|fieldvalue
; Add extra ICO files to the resources which can be used with TraySetIcon(@ScriptFullPath, 5) etc
; list of filename of the Ico files to be added, First one will have number 5, then 6 ..etc
#AutoIt3Wrapper_Res_Icon_Add=                   ; Filename[,LanguageCode] of ICO to be added.
#AutoIt3Wrapper_Res_Icon_Add=                   ; Filename[,LanguageCode] of ICO to be added.
; Add extra files to the resources
#AutoIt3Wrapper_Res_File_Add=                   ; Filename[,Section [,ResName[,LanguageCode]]] to be added.
#AutoIt3Wrapper_Res_File_Add=                   ; Filename[,Section [,ResName[,LanguageCode]]] to be added.
;===============================================================================================================
; Tidy Settings
#AutoIt3Wrapper_Run_Tidy=                       ;(Y/N) Run Tidy before compilation. default=N
#AutoIt3Wrapper_Tidy_Stop_OnError=              ;(Y/N) Continue when only Warnings. default=Y
#Tidy_Parameters=                               ;Tidy Parameters...see SciTE4AutoIt3 Helpfile for options
;===============================================================================================================
; Obfuscator
#AutoIt3Wrapper_Run_Obfuscator=                 ;(Y/N) Run Obfuscator before compilation. default=N
#obfuscator_parameters=
;===============================================================================================================
; AU3Check settings
#AutoIt3Wrapper_Run_AU3Check=                   ;(Y/N) Run au3check before compilation. Default=Y
#AutoIt3Wrapper_AU3Check_Parameters=            ;Au3Check parameters
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=        ;(Y/N) N=Continue on Warnings.(Default) Y=Always stop on Warnings
#AutoIt3Wrapper_PlugIn_Funcs=                   ;Define PlugIn function names separated by a Comma to avoid AU3Check errors
;===============================================================================================================
; cvsWrapper settings
#AutoIt3Wrapper_Run_cvsWrapper=                 ;(Y/N/V) Run cvsWrapper to update the script source. default=N
;                                                 V=only when version is increased by #AutoIt3Wrapper_Res_FileVersion_AutoIncrement.
#AutoIt3Wrapper_cvsWrapper_Parameters=          ; /NoPrompt  : Will skip the cvsComments prompt
;                                                 /Comments  : Text to added in the cvsComments. It can also contain the below variables.
;===============================================================================================================
; RUN BEFORE AND AFTER definitions
; The following directives can contain: these variables
;   %in% , %out%, %icon% which will be replaced by the fullpath\filename.
;   %scriptdir% same as @ScriptDir and %scriptfile% = filename without extension.
;   %fileversion% is the information from the #AutoIt3Wrapper_Res_Fileversion directive
;   %scitedir% will be replaced by the SciTE program directory
;   %autoitdir% will be replaced by the AutoIt3 program directory
#AutoIt3Wrapper_Run_Before=                     ;process to run before compilation - you can have multiple records that will be processed in sequence
#AutoIt3Wrapper_Run_After=                      ;process to run After compilation - you can have multiple records that will be processed in sequence
;===============================================================================================================
; RUN BEFORE AND AFTER definitions
#AutoIt3Wrapper_Add_Constants=                  ;Add the needed standard constant include files. Will only run one time.
#EndRegion

#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿

 AU3 版本: 
 脚本作者: 
	Email: 
	QQ/TM: 
 脚本版本: 
 脚本功能: 

#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿

