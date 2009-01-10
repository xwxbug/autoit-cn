#Region AutoIt3Wrapper directives section
;** This is a list of compiler directives used by AutoIt3Wrapper.exe.
;** comment the lines you don't need or else it will override the default settings
;===============================================================================================================
;** AUTOIT3 settings
#AutoIt3Wrapper_UseAnsi=                        ;(Y/N) Use Ansi versions for AutoIt3a or AUT2EXEa. Default=N
#AutoIt3Wrapper_UseX64=                         ;(Y/N) Use X64 versions for AutoIt3_x64 or AUT2EXE_x64. Default=N
#AutoIt3Wrapper_Version=                        ;(B/P) Use Beta or Production for AutoIt3 and AUT2EXE. Default is P
#AutoIt3Wrapper_Run_Debug_Mode=                 ;(Y/N)Run Script with console debugging. Default=N
;===============================================================================================================
;** AUT2EXE settings
#AutoIt3Wrapper_Icon=                           ;Filename of the Ico file to use
#AutoIt3Wrapper_OutFile=                        ;Target exe/a3x filename.
#AutoIt3Wrapper_OutFile_Type=                   ;a3x=small AutoIt3 file;  exe=Standalone executable (Default)
#AutoIt3Wrapper_Compression=                    ;Compression parameter 0-4  0=Low 2=normal 4=High. Default=2
#AutoIt3Wrapper_UseUpx=                         ;(Y/N) Compress output program.  Default=Y
#AutoIt3Wrapper_Change2CUI=                     ;(Y/N) Change output program to CUI in stead of GUI. Default=N
;===============================================================================================================
;** Target program Resource info
#AutoIt3Wrapper_Res_Comment=                    ;Comment field
#AutoIt3Wrapper_Res_Description=                ;Description field
#AutoIt3Wrapper_Res_Fileversion=                ;File Version
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=  ;(Y/N/P)AutoIncrement FileVersion After Aut2EXE is finished. default=N
;                                                 P=Prompt, Will ask at Compilation time if you want to increase the versionnumber
#AutoIt3Wrapper_Res_Language=                   ;Resource Language code . default 2057=English (United Kingdom)
#AutoIt3Wrapper_Res_LegalCopyright=             ;Copyright field
#AutoIt3Wrapper_res_requestedExecutionLevel=    ;None, asInvoker, highestAvailable or requireAdministrator   (default=None)
#AutoIt3Wrapper_Res_SaveSource=                 ;(Y/N) Save a copy of the Scriptsource in the EXE resources. default=N
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
; Add extra ICO files to the resources which can be used with TraySetIcon(@ScriptFullPath, 3) etc
; list of filename of the Ico files to be added, First one will have number 3, then 4 ..etc
#AutoIt3Wrapper_Res_Icon_Add=                   ; Filename of ICO to be added.
#AutoIt3Wrapper_Res_Icon_Add=                   ; Filename of ICO to be added.
; Add extra files to the resources
#AutoIt3Wrapper_Res_File_Add=                   ; Filename[,Section [,ResName]] to be added.
#AutoIt3Wrapper_Res_File_Add=                   ; Filename[,Section [,ResName]] to be added.
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