#include <WinAPIFiles.au3>
#include <APIFilesConstants.au3>
#include <WinAPIDiag.au3>
#include <Misc.au3>

Opt('TrayAutoPause', 0)

Local $hProgressProc = DllCallbackRegister('_ProgressProc', 'dword', 'uint64;uint64;uint64;uint64;dword;dword;ptr;ptr;long_ptr')

FileDelete(@TempDir & '\Test*.tmp')

Local $sFile = @TempDir & '\Test.tmp'
Local $hFile = FileOpen($sFile, 2)
For $i = 1 To 1000000
	FileWriteLine($hFile, "                                                     ")
Next
FileClose($hFile)

ProgressOn('_WinAPI_MoveFileEx', 'Moving...', '', -1, -1, 2)

If Not _WinAPI_MoveFileEx($sFile, @TempDir & '\Test1.tmp', $MOVE_FILE_COPY_ALLOWED, DllCallbackGetPtr($hProgressProc)) Then
	_WinAPI_ShowLastError()
EndIf

DllCallbackFree($hProgressProc)

ProgressOff()

FileDelete(@TempDir & '\Test*.tmp')

Func _ProgressProc($iTotalFileSize, $iTotalBytesTransferred, $iStreamSize, $iStreamBytesTransferred, $iStreamNumber, $iCallbackReason, $hSourceFile, $hDestinationFile, $iData)
	#forceref $iStreamSize, $iStreamBytesTransferred, $iStreamNumber, $iCallbackReason, $hSourceFile, $hDestinationFile, $iData

	Local $Percent = Round($iTotalBytesTransferred / $iTotalFileSize * 100)
	If $Percent = 100 Then
		ProgressSet($Percent, '', 'Complete')
	Else
		ProgressSet($Percent)
	EndIf
	If _IsPressed('1B') Then
		Return $PROGRESS_CANCEL
	Else
		Return $PROGRESS_CONTINUE
	EndIf
EndFunc   ;==>_ProgressProc
