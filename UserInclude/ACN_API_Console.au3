#include-once
;~ The following functions are used to access a console.

;~ Function						Description 
;~ AddConsoleAlias				Defines a console alias for the specified executable. 
;~ AllocConsole					Allocates a new console for the calling process. 
;~ AttachConsole				Attaches the calling process to the console of the specified process. 
;~ CreateConsoleScreenBuffer	Creates a console screen buffer. 
;~ FillConsoleOutputAttribute	Sets the text and background color attributes for a specified number of character cells. 
;~ FillConsoleOutputCharacter	Writes a character to the console screen buffer a specified number of times. 
;~ FlushConsoleInputBuffer		Flushes the console input buffer. 
;~ FreeConsole					Detaches the calling process from its console. 
;~ GenerateConsoleCtrlEvent		Sends a specified signal to a console process group that shares the console associated with the calling process. 
;~ GetConsoleAlias				Retrieves the specified alias for the specified executable. 
;~ GetConsoleAliases			Retrieves all defined console aliases for the specified executable.  
;~ GetConsoleAliasesLength		Returns the size, in bytes, of the buffer needed to store all of the console aliases for the specified executable.  
;~ GetConsoleAliasExes			Retrieves the names of all executables with console aliases defined. 
;~ GetConsoleAliasExesLength	Returns the size, in bytes, of the buffer needed to store the names of all executables that have console aliases defined. 
;~ GetConsoleCP					Retrieves the input code page used by the console associated with the calling process. 
;~ GetConsoleCursorInfo			Retrieves information about the size and visibility of the cursor for the specified console screen buffer. 
;~ GetConsoleDisplayMode		Retrieves the display mode of the current console. 
;~ GetConsoleFontSize			Retrieves the size of the font used by the specified console screen buffer. 
;~ GetConsoleHistoryInfo		Retrieves the history settings for the calling process's console. 
;~ GetConsoleMode				Retrieves the current input mode of a console's input buffer or the current output mode of a console screen buffer. 
;~ GetConsoleOriginalTitle		Retrieves the original title for the current console window. 
;~ GetConsoleOutputCP			Retrieves the output code page used by the console associated with the calling process. 
;~ GetConsoleProcessList		Retrieves a list of the processes attached to the current console. 
;~ GetConsoleScreenBufferInfo	Retrieves information about the specified console screen buffer. 
;~ GetConsoleScreenBufferInfoEx	Retrieves extended information about the specified console screen buffer. 
;~ GetConsoleSelectionInfo		Retrieves information about the current console selection. 
;~ GetConsoleTitle				Retrieves the title for the current console window. 
;~ GetConsoleWindow				Retrieves the window handle used by the console associated with the calling process. 
;~ GetCurrentConsoleFont		Retrieves information about the current console font. 
;~ GetCurrentConsoleFontEx		Retrieves extended information about the current console font. 
;~ GetLargestConsoleWindowSize	Retrieves the size of the largest possible console window. 
;~ GetNumberOfConsoleInputEvents	Retrieves the number of unread input records in the console's input buffer. 
;~ GetNumberOfConsoleMouseButtons	Retrieves the number of buttons on the mouse used by the current console. 
;~ GetStdHandle					Retrieves a handle for the standard input, standard output, or standard error device. 
;~ HandlerRoutine				An application-defined function used with the SetConsoleCtrlHandler function. 
;~ PeekConsoleInput				Reads data from the specified console input buffer without removing it from the buffer. 
;~ ReadConsole Reads			character input from the console input buffer and removes it from the buffer. 
;~ ReadConsoleInput				Reads data from a console input buffer and removes it from the buffer. 
;~ ReadConsoleOutput			Reads character and color attribute data from a rectangular block of character cells in a console screen buffer. 
;~ ReadConsoleOutputAttribute	Copies a specified number of foreground and background color attributes from consecutive cells of a console screen buffer. 
;~ ReadConsoleOutputCharacter	Copies a number of characters from consecutive cells of a console screen buffer. 
;~ ScrollConsoleScreenBuffer	Moves a block of data in a screen buffer. 
;~ SetConsoleActiveScreenBuffer	Sets the specified screen buffer to be the currently displayed console screen buffer. 
;~ SetConsoleCP					Sets the input code page used by the console associated with the calling process. 
;~ SetConsoleCtrlHandler		Adds or removes an application-defined HandlerRoutine from the list of handler functions for the calling process. 
;~ SetConsoleCursorInfo			Sets the size and visibility of the cursor for the specified console screen buffer. 
;~ SetConsoleCursorPosition		Sets the cursor position in the specified console screen buffer. 
;~ SetConsoleDisplayMode		Sets the display mode of the specified console screen buffer. 
;~ SetConsoleHistoryInfo		Sets the history settings for the calling process's console. 
;~ SetConsoleMode				Sets the input mode of a console's input buffer or the output mode of a console screen buffer. 
;~ SetConsoleOutputCP			Sets the output code page used by the console associated with the calling process. 
;~ SetConsoleScreenBufferInfoEx	Sets extended information about the specified console screen buffer. 
;~ SetConsoleScreenBufferSize	Changes the size of the specified console screen buffer. 
;~ SetConsoleTextAttribute		Sets the foreground (text) and background color attributes of characters written to the console screen buffer. 
;~ SetConsoleTitle				Sets the title for the current console window. 
;~ SetConsoleWindowInfo			Sets the current size and position of a console screen buffer's window. 
;~ SetCurrentConsoleFontEx		Sets extended information about the current console font. 
;~ SetStdHandle					Sets the handle for the standard input, standard output, or standard error device. 
;~ WriteConsole					Writes a character string to a console screen buffer beginning at the current cursor location. 
;~ WriteConsoleInput			Writes data directly to the console input buffer. 
;~ WriteConsoleOutput			Writes character and color attribute data to a specified rectangular block of character cells in a console screen buffer. 
;~ WriteConsoleOutputAttribute	Copies a number of foreground and background color attributes to consecutive cells of a console screen buffer. 
;~ WriteConsoleOutputCharacter	Copies a number of characters to consecutive cells of a console screen buffer. 
;===========================================================================================================
;~ BOOL WINAPI AddConsoleAlias(
;~   __in  LPCTSTR Source,
;~   __in  LPCTSTR Target,
;~   __in  LPCTSTR ExeName
;~ );
;~ Source [in] 
;~ The console alias to be mapped to the text specified by Target.

;~ Target [in] 
;~ The text to be substituted for Source. If this parameter is NULL, then the console alias is removed.

;~ ExeName [in] 
;~ The name of the executable file for which the console alias is to be defined.

;~ Return Value
;~ If the function succeeds, the return value is TRUE.

;~ If the function fails, the return value is FALSE. To get extended error information, call GetLastError.
;=============================================================================================================
Func _AddConsoleAlias($Source,$Target,$ExeName)
	Local $rt=DllCall("Kernel32.dll","bool","AddConsoleAlias","wstr",$Source,"wstr",$Target,"wstr",$ExeName)
	return $rt[0]
EndFunc

;=============================================================================================================
;~ BOOL WINAPI AllocConsole(void);
;~ Parameters
;~ This function has no parameters. 
;~ Return Value
;~ If the function succeeds, the return value is nonzero.

;~ If the function fails, the return value is zero. To get extended error information, call GetLastError.
;=============================================================================================================
Func _AllocConsole()
	Local $rt=DllCall('Kernel32.dll',"bool",'AllocConsole')
	return $rt[0]
EndFunc
;=============================================================================================================
;~ BOOL WINAPI AttachConsole(
;~   __in  DWORD dwProcessId
;~ );
;~ Parameters
;~ dwProcessId [in] 
;~ The identifier of the process whose console is to be used. This parameter can be one of the following values.

;~ Value					Meaning 
;~ pid						Use the console of the specified process.
;~  
;~ ATTACH_PARENT_PROCESS	
;~ (DWORD)-1 				Use the console of the parent of the current process.
;~  
;~ Return Value
;~ If the function succeeds, the return value is nonzero.

;~ If the function fails, the return value is zero. To get extended error information, call GetLastError.

;~ Remarks
;~ A process can be attached to at most one console. If the calling process is already attached to a console, the error code returned is ERROR_ACCESS_DENIED (5). If the specified process does not have a console, the error code returned is ERROR_INVALID_HANDLE (6). If the specified process does not exist, the error code returned is ERROR_GEN_FAILURE (31).

;~ A process can use the FreeConsole function to detach itself from its console. If other processes share the console, the console is not destroyed, but the process that called FreeConsole cannot refer to it. A console is closed when the last process attached to it terminates or calls FreeConsole. After a process calls FreeConsole, it can call the AllocConsole function to create a new console or AttachConsole to attach to another console.

;=============================================================================================================

Func _AttachConsole($n_pid)
	Local $rt=DllCall('Kernel32.dll',"bool",'AttachConsole',"dword",$n_pid)
	return $rt[0]
EndFunc
;=============================================================================================================

;=============================================================================================================
