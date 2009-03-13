Global Const $FO_COPY = 0x0002 ; Copies the files specified in pFrom to the location specified in pTo
Global Const $FO_DELETE = 0x0003 ; Deletes the files specified in pFrom (pTo is ignored)
Global Const $FO_MOVE = 0x0001 ; Moves the files specified in pFrom to the location specified in pTo
Global Const $FO_RENAME = 0x0004 ; Renames the files specified in pFrom

Global Const $FOF_ALLOWUNDO = 0x0040 ; Preserve Undo information, if possible
Global Const $FOF_CONFIRMMOUSE = 0x0002 ; Not currently implemented
Global Const $FOF_FILESONLY = 0x0080 ; Perform the operation on files only if a wildcard file name (*.*) is specified.
Global Const $FOF_MULTIDESTFILES = 0x0001 ; The pTo member specifies multiple destination files (one for each sourcr file)
; rather than one directory where all source files are to be deposited.
Global Const $FOF_NOCONFIRMATION = 0x0010 ; Respond with "Yes to All" for any dialog box that is displayed.
Global Const $FOF_NOCONFIRMMKDIR = 0x0200 ; Does not confirm the creation of a new directory if the operation requires one to be created.
Global Const $FOF_NOCOPYSECURITYATTRIBS = 0x0800 ; Do not copy NT file Security Attributes
Global Const $FOF_NOERRORUI = 0x0400 ; No user interface will be displayed if an error occurs
Global Const $FOF_NORECURSION = 0x1000 ; Do not recurse directories (i.e. no recursion into subdirectories)
Global Const $FOF_RENAMEONCOLLISION = 0x0008 ; Give the file being operated on a new name in a move, copy, or rename operation if a file with the target name already exisits.
Global Const $FOF_SILENT = 0x0004 ; Does not display a progress dialog box
Global Const $FOF_SIMPLEPROGRESS = 0x0100 ; Displays a progress box but does not show the file names
Global Const $FOF_WANTMAPPINGHANDLE = 0x0020 ; If $FOF_RENAMEONCOLLISION is specified, the hNameMappings member will be filled in if any files were renamed

; These two apply in Internet Explorer 5 Environments
Global Const $FOF_NO_CONNECTED_ELEMENTS = 0x2000 ; Do not operate on connected elements
Global Const $FOF_WANTNUKEWARNING = 0x4000 ; During delete operations, warn if permanent deleting instead of placing in recycle bin (partially overrides $FOF_NOCONFIRMATION)

; ????
Global Const $FOF_NORECURSEREPARSE = 0x8000 ;

;$n = _ExplorerCopy("C:\Documents and Settings\All Users\Documents\shared\04.jpg" @LF & "C:\Documents and Settings\All Users\Documents\shared\11.jpg", "C:\Documents and Settings\Livewire\Desktop")
;MsgBox(0,"Testing","Success = " & $n)

Func _ExplorerCopy($source, $dest, $Options = 0)
	Local $SHFILEOPSTRUCT, $source_struct, $dest_struct
	Local $i, $aDllRet

	Local Enum $hwnd = 1, $wFunc, $pFrom, $pTo, $fFlags, $fAnyOperationsAborted, $hNameMappings, $lpszProgressTitle
	$SHFILEOPSTRUCT = DllStructCreate("int;uint;ptr;ptr;uint;int;ptr;ptr")
	If @error Then
		MsgBox(4096, "ERROR", "Error creating SHFILEOPSTRUCT structure")
		Return False
	EndIf

	$source_struct = DllStructCreate("char[" & StringLen($source) + 2 & "]")
	DllStructSetData($source_struct, 1, $source)
	For $i = 1 To StringLen($source) + 2
		If DllStructGetData($source_struct, 1, $i) = 10 Then DllStructSetData($source_struct, 1, 0, $i)
	Next
	DllStructSetData($source_struct, 1, 0, StringLen($source) + 2)

	$dest_struct = DllStructCreate("char[" & StringLen($dest) + 2 & "]")
	DllStructSetData($dest_struct, 1, $dest)
	DllStructSetData($dest_struct, 1, 0, StringLen($dest) + 2)

	DllStructSetData($SHFILEOPSTRUCT, $hwnd, 0)
	DllStructSetData($SHFILEOPSTRUCT, $wFunc, $FO_COPY)
	DllStructSetData($SHFILEOPSTRUCT, $pFrom, DllStructGetPtr($source_struct))
	DllStructSetData($SHFILEOPSTRUCT, $pTo, DllStructGetPtr($dest_struct))
	DllStructSetData($SHFILEOPSTRUCT, $fFlags, $Options)
	DllStructSetData($SHFILEOPSTRUCT, $fAnyOperationsAborted, 0)
	DllStructSetData($SHFILEOPSTRUCT, $hNameMappings, 0)
	DllStructSetData($SHFILEOPSTRUCT, $lpszProgressTitle, 0)

	If _SHFileOperation($SHFILEOPSTRUCT) Then
		$aDllRet = DllCall("kernel32.dll", "long", "GetLastError")
		If @error Then MsgBox(4096, "Error", "Error calling GetLastError")
		SetError($aDllRet[0])
		Return False
	ElseIf DllStructGetData($SHFILEOPSTRUCT, $fAnyOperationsAborted) Then
		MsgBox(0, "Testing", "Operation aborted")
		Return False
	EndIf
	Return True
EndFunc

Func _ExplorerMove($source, $dest, $Options = 0)
	Local $SHFILEOPSTRUCT, $source_struct, $dest_struct
	Local $i, $aDllRet

	Local Enum $hwnd = 1, $wFunc, $pFrom, $pTo, $fFlags, $fAnyOperationsAborted, $hNameMappings, $lpszProgressTitle
	$SHFILEOPSTRUCT = DllStructCreate("int;uint;ptr;ptr;uint;int;ptr;ptr")
	If @error Then
		MsgBox(4096, "ERROR", "Error creating SHFILEOPSTRUCT structure")
		Return False
	EndIf

	$source_struct = DllStructCreate("char[" & StringLen($source) + 2 & "]")
	DllStructSetData($source_struct, 1, $source)
	For $i = 1 To StringLen($source) + 2
		If DllStructGetData($source_struct, 1, $i) = 10 Then DllStructSetData($source_struct, 1, 0, $i)
	Next
	DllStructSetData($source_struct, 1, 0, StringLen($source) + 2)

	$dest_struct = DllStructCreate("char[" & StringLen($dest) + 2 & "]")
	DllStructSetData($dest_struct, 1, $dest)
	DllStructSetData($dest_struct, 1, 0, StringLen($dest) + 2)

	DllStructSetData($SHFILEOPSTRUCT, $hwnd, 0)
	DllStructSetData($SHFILEOPSTRUCT, $wFunc, $FO_MOVE)
	DllStructSetData($SHFILEOPSTRUCT, $pFrom, DllStructGetPtr($source_struct))
	DllStructSetData($SHFILEOPSTRUCT, $pTo, DllStructGetPtr($dest_struct))
	DllStructSetData($SHFILEOPSTRUCT, $fFlags, $Options)
	DllStructSetData($SHFILEOPSTRUCT, $fAnyOperationsAborted, 0)
	DllStructSetData($SHFILEOPSTRUCT, $hNameMappings, 0)
	DllStructSetData($SHFILEOPSTRUCT, $lpszProgressTitle, 0)

	If _SHFileOperation($SHFILEOPSTRUCT) Then
		$aDllRet = DllCall("kernel32.dll", "long", "GetLastError")
		If @error Then MsgBox(4096, "Error", "Error calling GetLastError")
		SetError($aDllRet[0])
		Return False
	ElseIf DllStructGetData($SHFILEOPSTRUCT, $fAnyOperationsAborted) Then
		MsgBox(0, "Testing", "Operation aborted")
		Return False
	EndIf
	Return True
EndFunc

Func _ExplorerDelete($path, $Options = 0)
	Local $SHFILEOPSTRUCT, $path_struct
	Local $nError = 0
	Local $i

	Local Enum $hwnd = 1, $wFunc, $pFrom, $pTo, $fFlags, $fAnyOperationsAborted, $hNameMappings, $lpszProgressTitle
	$SHFILEOPSTRUCT = DllStructCreate("int;uint;ptr;ptr;uint;int;ptr;ptr")
	If @error Then
		MsgBox(4096, "ERROR", "Error creating SHFILEOPSTRUCT structure")
		Return False
	EndIf

	$path_struct = DllStructCreate("char[" & StringLen($path) + 2 & "]")
	DllStructSetData($path_struct, 1, $path)
	For $i = 1 To StringLen($path) + 2
		If DllStructGetData($path_struct, 1, $i) = 10 Then DllStructSetData($path_struct, 1, 0, $i)
	Next
	DllStructSetData($path_struct, 1, 0, StringLen($path) + 2)

	DllStructSetData($SHFILEOPSTRUCT, $hwnd, 0)
	DllStructSetData($SHFILEOPSTRUCT, $wFunc, $FO_DELETE)
	DllStructSetData($SHFILEOPSTRUCT, $pFrom, DllStructGetPtr($path_struct))
	DllStructSetData($SHFILEOPSTRUCT, $pTo, 0)
	DllStructSetData($SHFILEOPSTRUCT, $fFlags, $Options)
	DllStructSetData($SHFILEOPSTRUCT, $fAnyOperationsAborted, 0)
	DllStructSetData($SHFILEOPSTRUCT, $hNameMappings, 0)
	DllStructSetData($SHFILEOPSTRUCT, $lpszProgressTitle, 0)

	If _SHFileOperation($SHFILEOPSTRUCT) Then
		$aDllRet = DllCall("kernel32.dll", "long", "GetLastError")
		If @error Then MsgBox(4096, "Error", "Error calling GetLastError")
		SetError($aDllRet[0])
		Return False
	ElseIf DllStructGetData($SHFILEOPSTRUCT, $fAnyOperationsAborted) Then
		MsgBox(0, "Testing", "Operation aborted")
		Return False
	EndIf
	Return True
EndFunc

Func _ExplorerRename($old_name, $new_name, $Options = 0)
	Local $SHFILEOPSTRUCT, $old_name_struct, $new_name_struct
	Local $nError = 0
	Local $i

	Local Enum $hwnd = 1, $wFunc, $pFrom, $pTo, $fFlags, $fAnyOperationsAborted, $hNameMappings, $lpszProgressTitle
	$SHFILEOPSTRUCT = DllStructCreate("int;uint;ptr;ptr;uint;int;ptr;ptr")
	If @error Then
		MsgBox(4096, "ERROR", "Error creating SHFILEOPSTRUCT structure")
		Return False
	EndIf

	$old_name_struct = DllStructCreate("char[" & StringLen($old_name) + 2 & "]")
	DllStructSetData($old_name_struct, 1, $old_name)
	For $i = 1 To StringLen($old_name) + 2
		If DllStructGetData($old_name_struct, 1, $i) = 10 Then DllStructSetData($old_name_struct, 1, 0, $i)
	Next
	DllStructSetData($old_name_struct, 1, 0, StringLen($old_name) + 2)

	$new_name_struct = DllStructCreate("char[" & StringLen($new_name) + 2 & "]")
	DllStructSetData($new_name_struct, 1, $new_name)
	DllStructSetData($new_name_struct, 1, 0, StringLen($new_name) + 2)

	DllStructSetData($SHFILEOPSTRUCT, $hwnd, 0)
	DllStructSetData($SHFILEOPSTRUCT, $wFunc, $FO_RENAME)
	DllStructSetData($SHFILEOPSTRUCT, $pFrom, DllStructGetPtr($old_name_struct))
	DllStructSetData($SHFILEOPSTRUCT, $pTo, DllStructGetPtr($new_name_struct))
	DllStructSetData($SHFILEOPSTRUCT, $fFlags, $Options)
	DllStructSetData($SHFILEOPSTRUCT, $fAnyOperationsAborted, 0)
	DllStructSetData($SHFILEOPSTRUCT, $hNameMappings, 0)
	DllStructSetData($SHFILEOPSTRUCT, $lpszProgressTitle, 0)

	If _SHFileOperation($SHFILEOPSTRUCT) Then
		$aDllRet = DllCall("kernel32.dll", "long", "GetLastError")
		If @error Then MsgBox(4096, "Error", "Error calling GetLastError")
		SetError($aDllRet[0])
		Return False
	ElseIf DllStructGetData($SHFILEOPSTRUCT, $fAnyOperationsAborted) Then
		MsgBox(0, "Testing", "Operation aborted")
		Return False
	EndIf
	Return True
EndFunc

Func _SHFileOperation(ByRef $lpFileOp)
	Local $aDllRet
	$aDllRet = DllCall("shell32.dll", "int", "SHFileOperation", "ptr", DllStructGetPtr($lpFileOp))
	If Not @error Then Return $aDllRet[0]
EndFunc