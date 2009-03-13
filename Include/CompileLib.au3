#include-once

; Pid = Run() seems to need admin rights under vista 64
#requireadmin


#Region Members Exported
#cs

#ce
#EndRegion Members Exported

#Region Includes
#include "OutputLib.au3"
#EndRegion Includes

#Region Global Variables
Global Const $PLATFORM_WIN32 = "win32"
Global Const $PLATFORM_X64 = "x64"
Global Const $PLATFORM_EMPTY = ""
Global Const $CONFIGURATION_RELEASE = "Release"
Global Const $CONFIGURATION_DEBUG = "Debug"
Global Const $CONFIGURATION_EMPTY = ""
Global Const $COMPILER_VC8 = "VC8"
Global Const $COMPILER_VC7 = "VC7"
Global Const $COMPILER_VC6 = "VC6"
Global Const $COMPILER_VCEXPRESS = "VCExpress"
Global Const $COMPILER_EMPTY = ""
Global Const $COMPILER_DEFAULT = $COMPILER_VC8
Global Const $g_sIni = @ScriptDir & "\config.ini"
Global Const $g_sSection = "Build"
Global Const $PROCESS_QUERY_INFORMATION = 0x0400
Global Const $ARCHIVE_ALLOW = 1
Global Const $ARCHIVE_DISALLOW = 0

; Settings Constants
Global Const $SETTING_BUILDDIR = "BuildDir"
Global Const $SETTING_COMPILER = "Compiler"
Global Const $SETTING_SIGN = "Sign"
Global Const $SETTING_BETA = "Beta"
Global Const $SETTING_RUNTEST = "RunTest"
Global Const $SETTING_RUNPERFORMANCE = "RunPerf"
Global Const $SETTING_STOPTEST = "StopTest"
Global Const $SETTING_ARCHIVE = "Archive"
Global Const $SETTING_PLATFORM = "Platform"
Global Const $SETTING_CONFIGURATION = "Configuration"
Global Const $SETTING_X64 = "X64Allowed"

#EndRegion Global Variables

#Region Script Entry Points

#Region Compile_Main()
; ===================================================================
; Compile_Main($sProject, Const ByRef $aBuildFiles, Const ByRef $aInstallFiles, $sBuildSuccessCallback = "", $sProjectDir = "", $bLast = True)
;
; The main function responsible for building a project.
; Parameters:
;	$sProject - IN - The name of the project.  This is the name of the Visual Studio project and the
; 		name of the directory where the project lives.
;   $vPlatform - IN - The platform or "" to use default (win32)
;	$aBuildFiles - IN - An array of files that are the build output.
;	$aInstallFiles - IN - An array of files that are part of the install.
;	$sBuildSuccessCallback - IN/OPTIONAL - On a successful build, this function will be Call()'ed for
;		any project-specific actions.
;	$sProjectDir - IN/OPTIONAL - The project directory if different than $sProject.
;	$bLast - IN/OPTIONAL - use False if more than one Compile_Main() is used in the same script.
; Returns:
;	0 on success, non-zero on failure.
; ===================================================================
Func Compile_Main($sProject, $vPlatform, $bArchive, Const ByRef $aBuildFiles, Const ByRef $aInstallFiles, $sBuildSuccessCallback = "", $sProjectDir = "", $bLast = True)
	AutoItSetOption("TrayIconDebug", 1)
	Local $nReturnCode = 0

	; define default project dir
	If $sProjectDir = "" Then $sProjectDir = $sProject

	; Loads the compiler settings.
	Local $vCompiler = _SettingGet($SETTING_COMPILER)
	Local $vConfiguration = _SettingGet($SETTING_CONFIGURATION)

	; Create the output window 
	_OutputWindowCreate()

	; If this is x x64 compile request then only proceed if X64=1 in the settings file
	If $vPlatform = $PLATFORM_X64 And _SettingGet($SETTING_X64, 0, True) = 0 Then
		_OutputProgressWrite("Skipping project as x64 support not enabled in config.ini." & @CRLF)
		_OutputProgressWrite("Finished." & @CRLF & @CRLF)	; Two CRLF's in case of chained output.
		If $bLast  Then _OutputWaitClosed()
		Return $nReturnCode
	EndIf

	; Initial output message
	_OutputProgressWrite("==== Output for " & StringTrimRight(@ScriptName, 4) & " (" & $sProject & ") ====" & @CRLF)


	; Set the build directory based on the rules and the INI file value.
	_BuildDirSet()

	; Get solutionPath - try VC8 as default if unsuccessfull
	Local $sSolutionPath = _SolutionPath($vCompiler, $sProjectDir & "\build", $sProject)
	If $sSolutionPath = "" Then
		$vCompiler = $COMPILER_VC8
		$sSolutionPath = _SolutionPath($vCompiler, $sProjectDir & "\build", $sProject)
	EndIf
	
	If $sSolutionPath Then
		; Before making any changes, make sure the compiler isn't running.
		If Not _CompilerIsRunning($vCompiler) Then
			; Delete files in the install dir that we are about to change
			_CleanInstallOutput($aInstallFiles)

			; Compile
			Local $bCompile = _Compile($sSolutionPath, $vCompiler, $vPlatform, $vConfiguration)
			_BuildOutputResult($bCompile, @error, @extended)

			$nReturnCode = ($bCompile = False)
			If $bCompile Then
				; Invoke the build success callback.
				If $sBuildSuccessCallback Then Call($sBuildSuccessCallback)

				; Copy newly compiled files to install
				_CopyBuildOutput($aBuildFiles, $aInstallFiles, $sProjectDir)

				; If the flag is set AND the function call allows it, then archive the source.
				; Function param added so that we don't archive twice when doing a x86 then x64 build
				If _SettingGet($SETTING_ARCHIVE, 0, True) Then
					; Clean all the common build directories and files for this project.
					_CleanOutputDirs($sProjectDir)
					_CleanFiles($sProjectDir)
					_CleanBuildOutput($aBuildFiles, $sProjectDir)
					
					If $bArchive = $ARCHIVE_ALLOW Then
						Local $sFileVersion = FileGetVersion("install\" & $aInstallFiles[0])
						If $sFileVersion = "0.0.0.0" Then $sFileVersion = FileGetVersion("install\AutoIt3.exe")

						Local $sArchiveName = $sProject & "-src-v" & $sFileVersion & ".exe"
						FileDelete($sArchiveName)
						_OutputProgressWrite("Archiving source to " & $sArchiveName)
						; WinRAR returns 0 on success
						If Not _WinRAR('a -ibck -m5 -s -sfx -ed -x*\.svn\* -x*\build\VC7.1\*.suo -x*\build\VC8.0\*.suo -x*\build\VC8.0\*.user -x*\bin\*.pdb  -x*\bin\Include\* ' & $sArchiveName & ' ' & $sProjectDir) Then
							_OutputProgressWrite(" succeeded." & @CRLF)
						Else
							_OutputProgressWrite(" failed." & @CRLF)
						EndIf
					EndIf
				EndIf
			EndIf
		Else
			_OutputProgressWrite("Build failed: Compiler already running." & @CRLF)
			$nReturnCode = 2
		EndIf
	Else
		_OutputProgressWrite("Solution not found for: " & __CompilerFullName($vCompiler) & @CRLF)
		$nReturnCode = 3
	EndIf

	; Write closing message and wait for close (if applicable).
	_OutputProgressWrite("Finished." & @CRLF & @CRLF)	; Two CRLF's in case of chained output.
	If $bLast Then _OutputWaitClosed()
	Return $nReturnCode
EndFunc	; Compile_Main()
#EndRegion Compile_Main()

#Region Batch_Main()
; ===================================================================
; Batch_Main(Const ByRef $aScripts)
;
; The main function responsible for running the scripts.
; Parameters:
;	$aScripts - IN - An array of scripts to run.
; Returns:
;	0 on success, non-zero on failure.
; ===================================================================
Func Batch_Main($sProject, Const ByRef $aScripts)
	AutoItSetOption("TrayIconDebug", 1)

	; Create the output window so all output will go into one window.
	_OutputWindowCreate()
	_OutputProgressWrite("==== Starting " & StringTrimRight(@ScriptName, 4) & " (" & $sProject & ") ====" & @CRLF)

	Local $nReturn
	; Run all the scripts
	Local $nSuccess = 0
	For $i = 0 To UBound($aScripts) - 1
		If $aScripts[$i] Then
			_OutputProgressWrite("Running " & $aScripts[$i] & " (" & $i + 1 & "/" & UBound($aScripts) & ")..." & @CRLF)
			$nReturn = _RunWaitScript(@ScriptDir & "\" & $aScripts[$i], "", @ScriptDir)
			If $nReturn Then	; An error occured.
				_OutputProgressWrite($aScripts[$i] & " did not complete successfully... ")
				Switch MsgBox(2 + 8192 + 48, "Warning", $aScripts[$i] & " did not complete successfully.", 300)
					Case -1, 3	; Abort, assume abort on timeout.
						_OutputProgressWrite("Aborting." & @CRLF)
						$nReturn = 1
						ExitLoop
					Case 4	; Retry
						_OutputProgressWrite("Retrying." & @CRLF)
						$i -= 1	; We have to decrement because the For loop will increment
					Case 5	; Ignore
						_OutputProgressWrite("Ignoring." & @CRLF)
						$nReturn = 0
				EndSwitch
			Else
				$nSuccess += 1
			EndIf
		EndIf
	Next

	; Wait for close (if applicable).
	_OutputProgressWrite("==== " & StringTrimRight(@ScriptName, 4) & " Finished: " & _
		$nSuccess & "/" & UBound($aScripts) & " Completed ====" & @CRLF & @CRLF)
	_OutputWaitClosed()

	Return $nReturn
EndFunc	; Batch_Main()
#EndRegion Batch_Main()

#EndRegion Script Entry Points

#Region Public Members

#Region _CompilerIsRunning()
; ===================================================================
; _CompilerIsRunning($vCompiler)
;
; Checks to see if the development environment is running and prompts the user to close it if it is.
; Parameters:
;	$vCompiler - IN - The compiler to check for.
; Returns:
;	True if the compiler is running, False otherwise.
; ===================================================================
Func _CompilerIsRunning($vCompiler)
	Local $sExe = __CompilerProcess($vCompiler)
	Local $bExists
	Do
		$bExists = ProcessExists($sExe)
		If $bExists Then
			Switch MsgBox(2 + 8192 + 48, "Warning", "Your development environment is running, for safest operation, please close it.", 30)
				Case -1, 3	; Abort, assume abort on timeout.
					$bExists = True
					ExitLoop
				Case 4	; Retry
					$bExists = True
				Case 5	; Ignore
					$bExists = False
			EndSwitch
		EndIf
	Until Not $bExists
	Return $bExists
EndFunc	; _CompilerIsRunning()
#EndRegion _CompilerIsRunning()

#Region _Compile()
; ===================================================================
; _Compile($sSolutionPath, $vCompiler = "", $vPlatform = "", $vConfiguration = "")
;
; Performs compilation of the specified solution.
; Parameters:
;	$sSolutionPath - IN - The solution to compile.
;	$vCompiler - IN/OPTIONAL - The compiler to use.  Defaults to $COMPILER_DEFAULT.
;	$vPlatform - IN/OPTIONAL - The platform to use.  Defaults to $PLATFORM_WIN32
;	$vConfiguration - IN/OPTIONAL - The configuration to use.  Defaults to $CONFIGURATION_RELEASE
; Returns:
;	Non-zero on success, 0 on failure.
; ===================================================================
Func _Compile($sSolutionPath, $vCompiler = "", $vPlatform = "", $vConfiguration = "")
	; Ensure we specify a valid platform.
	If $vCompiler = $COMPILER_EMPTY Then $vCompiler = $COMPILER_DEFAULT
	If $vPlatform = $PLATFORM_EMPTY Then $vPlatform = $PLATFORM_WIN32
	If $vConfiguration = $CONFIGURATION_EMPTY Then $vConfiguration = $CONFIGURATION_RELEASE

	; Get the path to the compiler.
	Local $sCompilerPath
	Switch $vCompiler
		Case $COMPILER_VC6
			$sCompilerPath = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msdev.exe","")
		Case $COMPILER_VC7
			$sCompilerPath = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\VisualStudio\7.1", "InstallDir")
			If $sCompilerPath Then $sCompilerPath &= __CompilerProcess($vCompiler)
		Case $COMPILER_VC8
			$sCompilerPath = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\VisualStudio\8.0", "InstallDir")
			If $sCompilerPath Then $sCompilerPath &= __CompilerProcess($vCompiler)
		Case $COMPILER_VCEXPRESS
			$sCompilerPath = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\VCExpress\8.0", "InstallDir")
			If $sCompilerPath Then $sCompilerPath &= __CompilerProcess($vCompiler)
		Case Else	; No valid compiler specified
			Return SetError(1, 0, False)
	EndSwitch

	; Ensure the compiler exists.
	If Not FileExists($sCompilerPath) Then Return SetError(2, 0, False)

	; Compile
	Local Const $sOutputFile = @ScriptDir & "\Build.log"
	Local $sCmd
	Switch $vCompiler
		Case $COMPILER_VC6
			; rebuild the project name
			Local $aTemp = StringSplit($sSolutionPath,"\")
			Local $sProject = StringTrimRight($aTemp[$aTemp[0]], 4)
			$sCmd = '"' & $sCompilerPath & '" "' & $sSolutionPath & '" /make "' & $sProject & ' - ' & __ConfigurationName($vConfiguration) & '" /rebuild /out "' & $sOutputFile & '"'
		Case $COMPILER_VC7
			$sCmd = '"' & $sCompilerPath & '" "' & $sSolutionPath & '" /rebuild "' & __ConfigurationName($vConfiguration) & '" /out "' & $sOutputFile & '"'
		Case Else
			$sCmd = '"' & $sCompilerPath & '" "' & $sSolutionPath & '" /rebuild "' & __ConfigurationName($vConfiguration) & '|' & __PlatformName($vPlatform) & '" /out "' & $sOutputFile & '"'
	EndSwitch
	Local $nReturn = __RunWaitOutputBuildWrite($sOutputFile, $sCmd)
	FileDelete($sOutputFile)
	; Visual Studio returns 0 on success but we return a boolean.
	Return $nReturn = 0
EndFunc	; _Compile()
#EndRegion _Compile()

#Region _SolutionPath()
; ===================================================================
; _SolutionPath($vCompiler, $sBuildRoot, $sName)
;
; Returns the path to an existing solution for the specified compiler.
; Parameters:
;	$vCompiler - IN - The compiler to use.
;	$sBuildRoot - IN - The root directory to search in.  A compiler specific directory will be appended to
;		this path.
;	$sName - IN - The name of the project.  A compiler specific suffix and extension will be appended
;		to this name.
; Returns:
;	If the specified solution exists, the full path to it, otherwise an empty string.
; ===================================================================
Func _SolutionPath($vCompiler, $sBuildRoot, $sName)
	Local $sSolutionPath
	Switch $vCompiler
		Case $COMPILER_VC6
			$sSolutionPath = $sBuildRoot & '\VC6\' & $sName & "_VC6.dsp"
		Case $COMPILER_VC7
			$sSolutionPath = $sBuildRoot & "\VC7.1\" & $sName & "_VC7.sln"
		Case $COMPILER_VC8, $COMPILER_VCEXPRESS
			$sSolutionPath = $sBuildRoot & "\VC8.0\" & $sName & "_VC8.sln"
		Case Else	; No valid compiler specified
			Return ""
	EndSwitch
	If FileExists($sSolutionPath) Then Return $sSolutionPath
	Return ""
EndFunc	; _SolutionPath()
#EndRegion _SolutionPath()

#Region _CleanOutputDirs()
; ===================================================================
; _CleanOutputDirs($sRoot)
;
; Cleans common output sub-directories found in the root directory.
; Parameters:
;	$sRoot - IN - The root directory containing sub-directories to be cleaned.
; Returns:
;	None.
; ===================================================================
Func _CleanOutputDirs($sRoot)
	Local Const $aSubDirs[16] = [ _
		"debug", _
		"debug-win32", _
		"debugA-win32", _
		"debug-x64", _
		"debug_sc", _
		"debug_sc-win32", _
		"debugA_sc-win32", _
		"debug_sc-x64", _
		"release", _
		"release-win32", _
		"releaseA-win32", _
		"release-x64", _
		"release_sc", _
		"release_sc-win32", _
		"releaseA_sc-win32", _
		"release_sc-x64" _
	]

	For $i = 0 To UBound($aSubDirs) - 1
		DirRemove($sRoot & "\" & $aSubDirs[$i], 1)
	Next
EndFunc	; _CleanOutputDirs()
#EndRegion _CleanOutputDirs()

#Region _CleanFiles()
; ===================================================================
; _CleanFiles($sRoot)
;
; Cleans common build output files found in the root directory.
; Parameters:
;	$sRoot - IN - The root directory containing files to be cleaned.
; Returns:
;	None.
; ===================================================================
Func _CleanFiles($sRoot)
	Local $aFiles[9] = [ _
		"bin\*.pdb", _
		"bin\*.ilk", _
		"build\VC8.0\*.ncb", _
		"build\VC8.0\*.plg", _
		"build\VC7.1\*.ncb", _
		"build\VC7.1\*.plg", _
		"build\VC6\*.ncb", _
		"build\VC6\*.plg", _
		"src\resources\*.aps" _
	]

	For $i = 0 To UBound($aFiles) - 1
		If $aFiles[$i] Then FileDelete($sRoot & "\" & $aFiles[$i])
	Next
EndFunc	; _CleanFiles()
#EndRegion _CleanFiles()

#Region _CleanInstallOutput()
; ===================================================================
; _CleanInstallOutput(Const ByRef $aInstallFiles, $sRoot = @WorkingDir)
;
; Cleans a list of files in the installation directory.
; Parameters:
;	$aInstallFiles - IN - The list of files to clean.
;	$sRoot - IN/OPTIONAL - The root directory which contains the "install" directory.
; Returns:
;	None.
; ===================================================================
Func _CleanInstallOutput(Const ByRef $aInstallFiles, $sRoot = @WorkingDir)
	For $i = 0 To UBound($aInstallFiles) - 1
		; the checking is needed for project that don't store their results under install\... as vc8_stub
		If $aInstallFiles[$i] Then FileDelete($sRoot & "\install\" & $aInstallFiles[$i])
	Next
EndFunc	; _CleanInstallOutput()
#EndRegion _CleanInstallOutput()

#Region _CleanBuildOutput()
; ===================================================================
; _CleanBuildOutput(Const ByRef $aData, $sProject, $sRoot = @WorkingDir)
;
; Cleans the build output files.
; Parameters:
;	$aData - IN - The list of files to clean.
;	$sProject - IN - The name of the of project.
;	$sRoot - IN/OPTIONAL - The root directory containing the $sProject directory.
; Returns:
;	None.
; ===================================================================
Func _CleanBuildOutput(Const ByRef $aData, $sProject, $sRoot = @WorkingDir)
	For $i = 0 To UBound($aData) - 1
		If $aData[$i] Then FileDelete($sRoot & "\" & $sProject & "\bin\"  & $aData[$i])
	Next
EndFunc	; _CleanBuildOutput()
#EndRegion _CleanBuildOutput()

#Region _CopyBuildOutput()
; ===================================================================
; _CopyBuildOutput(Const ByRef $aBuildOutput, Const ByRef $aInstallFiles, $sProject, $sRoot = @WorkingDir)
;
; Copies build output to the installation directory.
; Parameters:
;	$aBuildOutput - IN - The list of build output files.
;	$aInstallFiles - IN - The list of destination installation files.
;	$sProject - IN - The name of the of project.
;	$sRoot - IN/OPTIONAL - The root directory containing the $sProject and "install" directories.
; Returns:
;	True if files were copied, false if the source and destination arrays are different sizes.
; ===================================================================
Func _CopyBuildOutput(Const ByRef $aBuildOutput, Const ByRef $aInstallFiles, $sProject, $sRoot = @WorkingDir)
	If UBound($aBuildOutput) <> UBound($aInstallFiles) Then Return False
	For $i = 0 To UBound($aBuildOutput) - 1
		; the checking is needed for project that don't store their results under install\... as vc8_stub
		If $aInstallFiles[$i] Then FileCopy($sRoot & "\" & $sProject & "\bin\"  & $aBuildOutput[$i], $sRoot & "\install\" & $aInstallFiles[$i], 1)
	Next
	Return True
EndFunc	; _CopyBuildOutput()
#EndRegion _CopyBuildOutput()

#Region _WinRAR()
; ===================================================================
; _WinRAR($sCmd)
;
; Runs WinRAR with the specified command.
; Parameters:
;	$sCmd - IN - The command to execute.
; Returns:
;	Exit code from WinRAR.
; ===================================================================
Func _WinRAR($sCmd)
	; First we try the logical location.
	Local $sWinRAR = @ProgramFilesDir & "\WinRAR\winrar.exe"
	; If we don't find it in the logical location, look in App Paths.
	If Not FileExists($sWinRAR) Then
		$sWinRAR = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\WinRAR.exe", "")
	EndIf
	; If we can't find it in App Paths, look for the uninstall key and build the path from that.
	If Not FileExists($sWinRAR) Then
		$sWinRAR = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\WinRAR archiver", "UninstallString")
		$sWinRAR = StringReplace($sWinRAR, "\uninstall.exe", "\winrar.exe")
	EndIf
	; If it's still not found, give up.
	If Not FileExists($sWinRAR) Then Return SetError(1, 0, -1)
	Return RunWait('"' & $sWinRAR & '" ' & $sCmd)
EndFunc	; _WinRAR
#EndRegion _WinRAR()

#Region _BuildOutputResult()
; ===================================================================
; _BuildOutputResult($nReturn, $nError, $nExtended)
;
; Outputs a description of a build error.
; Parameters:
;	$nReturn - IN - The return code from _Compile().
;	$nError - IN - The @error value after _Compile() has been called.
;	$nExtended - IN - The @extended value after _Compile() has been called.
; Returns:
;	None.
; ===================================================================
Func _BuildOutputResult($nReturn, $nError, $nExtended)
	#ForceRef $nExtended
	If $nReturn Then
		_OutputProgressWrite("Build succeeded.")
	Else
		Switch $nError
			Case 0	; Build error
				_OutputProgressWrite("Build failed: Compilation error, see Build Ouput for details.")
			Case 1 ; Invalid Compiler
				_OutputProgressWrite("Build failed: Invalid compiler specified.")
			Case 2	; Compiler doesn't exist
				_OutputProgressWrite("Build failed: Unable to locate compiler.")
		EndSwitch
	EndIf
	; Add the trailing CRLF
	_OutputProgressWrite(@CRLF)
EndFunc	; _BuildOutputResult()
#EndRegion _BuildOutputResult()

#Region _BuildDirSet()
; ===================================================================
; _BuildDirSet()
;
; Changes the working directory to the root build directory.
; Parameters:
;	None.
; Returns:
;	None.
; ===================================================================
Func _BuildDirSet()
	FileChangeDir(@ScriptDir)
	FileChangeDir(_SettingGet($SETTING_BUILDDIR))
	Return @WorkingDir
EndFunc	; _BuildDirSet()
#EndRegion _BuildDirSet()

#Region _RunWaitScript()
; ===================================================================
; _RunWaitScript($sScript, $sParams = "", $sWorkingDir = "", $nFlag = @SW_SHOWNORMAL)
;
; Runs a script using the currently executing interpreter.
; Parameters:
;	$sScript - IN - The path to the script to invoke.
;	$sParams - IN/OPTIONAL - Parameters to pass to the script.
;	$sWorkingDir - IN/OPTIONAL - The working directory for the script.
;	$nFlag - IN/OPTIONAL - An @SW_ flag controlling the script's visibility.
; Returns:
;	Exit code from the script.
; ===================================================================
Func _RunWaitScript($sScript, $sParams = "", $sWorkingDir = "", $nFlag = @SW_SHOWNORMAL)
	Return RunWait('"' & @AutoItExe & '" "' & $sScript & '" ' & $sParams, $sWorkingDir, $nFlag)
EndFunc	; _RunWaitScript()
#EndRegion _RunWaitScript()

#Region _SettingGet()
; ===================================================================
; _SettingGet($vSetting, $vDefault = "", $bNumber = False)
;
; Retrieves a setting.
; Parameters:
;	$vSetting - IN - The name of the setting to obtain.
;	$vDefault - IN/OPTIONAL - The default value to return if the setting can't be found.
;	$bNumber - IN/OPTIONAL - If true, cast the result to a number.
; Returns:
;	Success: The setting optionally cast to a number.
;	Failure: The default value.
; ===================================================================
Func _SettingGet($vSetting, $vDefault = "", $bNumber = False)
	Local $vResult = IniRead($g_sIni, $g_sSection, $vSetting, $vDefault)
	If $bNumber Then Return Number($vResult)
	Return $vResult
EndFunc	; _SettingGet()
#EndRegion _SettingGet()

#Region _SettingSet()
; ===================================================================
; _SettingSet($vSetting, $vValue)
;
; Sets a setting.
; Parameters:
;	$vSetting - IN - The name of the setting to set.
;	$vValue - IN - The data to set.
; Returns:
;	None.
; ===================================================================
Func _SettingSet($vSetting, $vValue)
	IniWrite($g_sIni, $g_sSection, $vSetting, $vValue)
EndFunc	; _SettingSet()
#EndRegion _SettingSet()

#EndRegion Public Members

#Region Private Members

#Region __CompilerProcess()
; ===================================================================
; __CompilerProcess($vCompiler)
;
; Returns the name of the process for the specified compiler.
; Parameters:
;	$vCompiler - IN - One of the $COMPILER_* flags.
; Returns:
;	The process name of the specified compiler.
; ===================================================================
Func __CompilerProcess($vCompiler)
	Switch $vCompiler
		Case $COMPILER_VC6
			Return "msdev.exe"
		Case $COMPILER_VC7, $COMPILER_VC8
			Return "devenv.exe"
		Case $COMPILER_VCEXPRESS
			Return "VCExpress.exe"
	EndSwitch
	Return ""
EndFunc	; __CompilerProcess()
#EndRegion __CompilerProcess()

#Region __CompilerFullName()
; ===================================================================
; __CompilerFullName($vCompiler)
;
; Returns the name of a string in a human recognizable form.
; Parameters:
;	$vCompiler - IN - The compiler to get the name of.
; Returns:
;	The name of the specified compiler.
; ===================================================================
Func __CompilerFullName($vCompiler)
	Switch $vCompiler
		Case $COMPILER_VC6
			Return "Visual Studio 6.0"
		Case $COMPILER_VC7
			Return "Visual Studio 7"
		Case $COMPILER_VC8
			Return "Visual Studio 8.0"
		Case $COMPILER_VCEXPRESS
			Return "Visual C++ Express"
	EndSwitch
	Return ""
EndFunc	; __CompilerFullName()
#EndRegion __CompilerFullName()

#Region __PlatformName()
; ===================================================================
; __PlatformName($vPlatform)
;
; Returns the name of the specified platform.
; Parameters:
;	$vPlatform - IN - One of the $PLATFORM_* flags.
; Returns:
;	The name of the platform.
; ===================================================================
Func __PlatformName($vPlatform)
	Return $vPlatform
EndFunc	; __PlatformName()
#EndRegion __PlatformName()

#Region __ConfigurationName()
; ===================================================================
; __ConfigurationName($vConfiguration)
;
; Returns the name of the specified configuration.
; Parameters:
;	$vConfiguration - IN - One of the $CONFIGURATION_* flags.
; Returns:
;	The name of the configuration.
; ===================================================================
Func __ConfigurationName($vConfiguration)
	Return $vConfiguration
EndFunc	; __ConfigurationName()
#EndRegion __ConfigurationName()

#Region __RunWaitOutputBuildWrite()
; ===================================================================
; __RunWaitOutputBuildWrite($sFile, $sCmd, $sWorkingDir = "", $nShow = @SW_SHOWNORMAL)
;
; Runs the specified program, reads output from the specified file and outputs it to the output window.
; Parameters:
;	$sFile - IN - The path to the file to read.
;	$sCmd - IN - The command to execute.
;	$sWorkingDir - IN/OPTIONAL - The working directory to use.
;	$nShow - IN/OPTIONAL - The visibility sate of the program.
; Returns:
;	Exit code of the process.
; ===================================================================
Func __RunWaitOutputBuildWrite($sFile, $sCmd, $sWorkingDir = "", $nShow = @SW_SHOWNORMAL)
	Local $pid = Run($sCmd, $sWorkingDir, $nShow)
	Local $hProcess = _OpenProcess($PROCESS_QUERY_INFORMATION, $pid)
	Local $hFile = -1, $nError = 0, $sLine
	; Try to open the file while the process still exists.
	While ProcessExists($pid) And $hFile = -1
		$hFile = FileOpen($sFile, 0)
		Sleep(25)
	WEnd

	; Loop while the process exists and we are still reading.
	Do
		$sLine = FileReadLine($hFile)
		$nError = @error
		If $sLine Then _OutputBuildWrite($sLine & @CRLF)
		Sleep(25)
	Until $nError And Not ProcessExists($pid)

	; This is a safety loop to make sure we get all output.
	; The process will be closed but we keep looping anyway
	; so we make sure to get any data we might have missed
	; due to race conditions.
	Do
		$sLine = FileReadLine($hFile)
		$nError = @error
		If $sLine Then _OutputBuildWrite($sLine & @CRLF)
		Sleep(25)
	Until $nError

	If $hFile <> - 1 Then FileClose($hFile)
	Local $nReturn = _GetExitCodeProcess($hProcess)
	_CloseHandle($hProcess)
	Return $nReturn
EndFunc	; __RunWaitOutputBuildWrite()
#EndRegion __RunWaitOutputBuildWrite()

#Region _OpenProcess()
; ===================================================================
; _OpenProcess($nFlags, $pid, $bInherit = False)
;
; Open a handle to the specified process.
; Parameters:
;	$nFlags - IN - The access rights to open the process with.
;	$pid - IN - The PID of the process to open.
;	$bInherit - IN/OPTIONAL - True if the handle can be inherited.
; Returns:
;	Success - Returns a handle to the open process.
;	Failure - Returns 0 and sets @error (DllCall failed)
; ===================================================================
Func _OpenProcess($nFlags, $pid, $bInherit = False)
	Local $aRet = DllCall("kernel32.dll", "ptr", "OpenProcess", "dword", $nFlags, "int", $bInherit, "dword", $pid)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aRet[0]
EndFunc	; _OpenProcess()
#EndRegion _OpenProcess()

#Region _CloseHandle()
; ===================================================================
; _CloseHandle($handle)
;
; Closes a handle.
; Parameters:
;	$handle - IN - The handle to close.
; Returns:
;	Success - True if the handle was close, false otherwise.
;	Failure - Returns false and sets @error (DllCall failed)
; ===================================================================
Func _CloseHandle($handle)
	Local $aRet = DllCall("kernel32.dll", "int", "CloseHandle", "ptr", $handle)
	If @error Then Return SetError(@error, @extended, False)
	Return $aRet[0]
EndFunc	; _CloseHandle()
#EndRegion _CloseHandle()

#Region _GetExitCodeProcess()
; ===================================================================
; _GetExitCodeProcess($hProcess)
;
; Gets the exit code of the process associated with the handle.
; Parameters:
;	$hProcess - IN - A handle to the process (As created by OpenProcess).
; Returns:
;	Success - The return value will be the exit code.  If this value is equal to $STILL_ACTIVE then the
;		process is still running.  It is possible for a program to return $STILL_ACTIVE as a valid return
;		code.  The value in @extended determines if this function suceeded or not.
;	Failure - 0x7FFFFFFF is returned and @extended will be 0.
; ===================================================================
Func _GetExitCodeProcess($hProcess)
	Local $aRet = DllCall("kernel32.dll", "int", "GetExitCodeProcess", "ptr", $hProcess, "dword*", 0)
	If @error Then Return SetError(@error, @extended, 0x7FFFFFFF)
	Return SetError(0, $aRet[0], $aRet[2])
EndFunc	; _GetExitCodeProcess()
#EndRegion _GetExitCodeProcess()

#Region _WaitForInputIdleByPID()
; ===================================================================
; _WaitForInputIdleByPID($pid, $nTimeout)
;
; Waits for an application to load and the input queue to be empty or until the timeout.
; Parameters:
;	$pid - IN - PID of the process to monitor.
;	$nTimeout - IN - Time to wait before giving up.
; Returns:
;	Success - 0 - The wait was satisfied.
;		$WAIT_TIMEOUT - The timeout period elapsed before the process responded.
;		$WAIT_FAILED - An error occured (GetLastError may be set)
;	Failure - $WAIT_FAILED = 0xFFFFFFFF and @error set (DllCall failed)
; ===================================================================
Func _WaitForInputIdleByPID($pid, $nTimeout)
	Local $hProcess = _OpenProcess($PROCESS_QUERY_INFORMATION, $pid)
	Local $aRet = DllCall("user32.dll", "int", "WaitForInputIdle", "ptr", $hProcess, "int", $nTimeout)
	Local $nError = @error, $nExtended = @extended
	_CloseHandle($hProcess)
	If $nError Then Return SetError($nError, $nExtended, 0xFFFFFFFF)
	Return $aRet[0]
EndFunc	; _WaitForInputIdleByPID()
#EndRegion _WaitForInputIdleByPID()

#EndRegion Private Members
