#Include  <Misc.au3>
#Include  <WinAPIEx.au3>

Global $hProgressRoutine = DllCallbackRegister('_Progress ', 'int ', 'uint64;uint64;uint64;uint64;dword;dword;ptr;ptr;ptr')
_WinAPI_CopyFileEx('D:\.tmp ', 'C:\.tmp ', DllCallBackGetPtr($hProgressRoutine), $COPY_FILE_FAIL_IF_EXISTS)
_WinAPI_ShowLastError()
DllCallbackFree($hProgressRoutine)

Func _Progress($iTotalFileSize, $iTotalBytesTransferred, $iStreamSize, $iStreamBytesTransferred, $iStreamNumber, $iCallbackReason, $hSourceFile, $hDestinationFile, $iData)
	MsgBox('', '', Round($iTotalBytesTransferred / $iTotalFileSize * 100, 1) & ' %' & @CR)
	If _IsPressed('1B') Then
		Return $PROGRESS_CANCEL
	Else
		Return $PROGRESS_COMTINUE
	EndIf
endfunc   ;==>_Progress

