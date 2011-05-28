; ----------------------------------------------------------------------------
;
; AutoIt Version: 3.1.1 Beta
; Author:         Tuape
;
; Script Function:
;	Systray UDF - Functions for reading icon info from system tray / removing
;	any icon.
;
; Last Update: 7/14/05
; Requirements: AutoIt3 Beta - tested on WindowsXP, might also work in win2000
;
; Functions:
; _SysTrayIconCount() - Get count of all systray icons
; _SysTrayIconTitles() - Get titles of all programs that have icon on systray
; _SysTrayIconProcesses() - Get list of all process names that have icon in systray (hidden or visible)
; _SysTrayIconPids() - Get list of all parent process id's that own an icon in systray (hidden or visible)
; _SysTrayIconRemove($index) - Remove icon (removes completely, not just hide)
; _SysTrayIconIndex($wintitle or $process) - Get icon index based on process name or wintitle
; _SysTrayIconTooltip($index) - Get tooltip text of an icon based on index
;
; Notes:
; Some systray icons are actually hidden, so _SysTrayIconCount will probably return more than you see on systray.
; Some icons don't have window title on them. However, _SysTrayIconPids() & _SysTrayIconProcesses
; do return correct (parent) pid or process name
; ----------------------------------------------------------------------------
#NoTrayIcon

Const $TB_DELETEBUTTON = 1046
Const $TB_GETBUTTON = 1047
Const $TB_BUTTONCOUNT = 1048
Const $TB_GETBUTTONTEXT = 1099
Const $TB_GETBUTTONINFO = 1089
Const $TB_HIDEBUTTON = 1028 ; WM_USER +4
Const $TB_GETITEMRECT = 1053
Const $TB_MOVEBUTTON = 1106 ; WM_USER +82
Const $WM_GETTEXT = 13
Const $PROCESS_ALL_ACCESS = 2035711
Const $NO_TITLE = "---No title---" ; text that is used when icon window has no title




;===============================================================================
;
; Function Name:    _SysTrayIconTitles()
; Description:      Get list of all window titles that have systray icon
; Parameter(s):     None
; Requirement(s):   AutoIt3 Beta
; Return Value(s):  On Success - Returns an array with all window titles
;                   On Failure - TO BE DONE
; Author(s):        Tuape
;
;===============================================================================

Func _SysTrayIconTitles()
	Local $i
	Local $j
	Local $max = _SysTrayIconCount()
	Local $info[$max]
	Local $titles[$max]
	Local $var

	; Get info (hwnd) of all icons
	For $i = 0 To $max - 1
		$info[$i] = _SysTrayIconHandle($i)
	Next

	; Get window title text
	$var = WinList()
	For $i = 0 To $max - 1
		For $j = 1 To $var[0][0]
			;If $info[$i] = Dec($var[$j][1]) Then
			If $info[$i] = HWnd($var[$j][1]) Then
				If $var[$j][0] <> "" Then
					$titles[$i] = $var[$j][0]
				Else
					$titles[$i] = $NO_TITLE
				EndIf

				ExitLoop

			EndIf
		Next
	Next
	Return $titles
EndFunc   ;==>_SysTrayIconTitles

;===============================================================================
;
; Function Name:    _SysTrayIconProcesses()
; Description:      Get list of all processes that have systray icon
; Parameter(s):     None
; Requirement(s):   AutoIt3 Beta
; Return Value(s):  On Success - Returns an array with all process names
;                   On Failure - TO BE DONE
; Author(s):        Tuape
;
;===============================================================================
Func _SysTrayIconProcesses()
	Local $i
	Local $j
	Local $pids = _SysTrayIconPids()
	Local $processes[UBound($pids)]
	Local $list
	; List all processes
	$list = ProcessList()
	For $i = 0 To UBound($pids) - 1
		For $j = 1 To $list[0][0]
			If $pids[$i] = $list[$j][1] Then
				$processes[$i] = $list[$j][0]
				ExitLoop
			EndIf
		Next
	Next
	Return $processes
EndFunc   ;==>_SysTrayIconProcesses


;===============================================================================
;
; Function Name:    _SysTrayIconPids()
; Description:      Get list of all processes id's that have systray icon
; Parameter(s):     None
; Requirement(s):   AutoIt3 Beta
; Return Value(s):  On Success - Returns an array with all process id's
;                   On Failure - TO BE DONE
; Author(s):        Tuape
;
;===============================================================================
Func _SysTrayIconPids()
	Local $i
	Local $titles = _SysTrayIconTitles()
	Local $processes[UBound($titles)]
	Local $ret

	For $i = 0 To UBound($titles) - 1
		If $titles[$i] <> $NO_TITLE Then
			$processes[$i] = WinGetProcess($titles[$i])
		Else
			; Workaround for systray icons that have no title
			$ret = DllCall("user32.dll", "int", "GetWindowThreadProcessId", "int", _SysTrayIconHandle($i), "int_ptr", -1)
			If Not @error Then
				$processes[$i] = $ret[2]

			EndIf


		EndIf
	Next

	Return $processes
EndFunc   ;==>_SysTrayIconPids


;===============================================================================
;
; Function Name:    _SysTrayIconIndex($name, $mode=0)
; Description:      Get list of all processes id's that have systray icon
; Parameter(s):     $name = process name / window title text
;					$mode 0 = get index by process name (default)
;						  1 = get index by window title
;						  2 = get index by icon's tooltip text
; Requirement(s):   AutoIt3 Beta
; Return Value(s):  On Success - Returns index of found icon
;                   On Failure - Returns -1 if icon for given process/wintitle
;								 was not found.
;							   - Sets error to 1 and returns -1 in case of bad
;								 arguments
; Author(s):        Tuape
;
;===============================================================================
Func _SysTrayIconIndex($name, $mode = 0)
	Local $index = -1
	Local $process
	Local $i
	If $mode < 0 Or $mode > 2 Or Not IsInt($mode) Then
		SetError(1)
		Return -1
	EndIf

	If $mode = 0 Then
		$process = _SysTrayIconProcesses()

	Else
		$process = _SysTrayIconTitles()
	EndIf

	For $i = 0 To UBound($process) - 1
		If $process[$i] = $name Then
			$index = $i
		EndIf
	Next

	Return $index

EndFunc   ;==>_SysTrayIconIndex

;===============================================================================
;
; Function Name:    _SysTrayIconPos($iIndex=0)
; Description:      Gets x & y position of systray icon
; Parameter(s):     $iIndex = icon index (Note: starting from 0)
;
; Requirement(s):   AutoIt3 Beta
; Return Value(s):  On Success - Returns x [0] and y [1] position of icon
;                   On Failure - Returns -1 if icon is hidden (Autohide on XP etc.)
;								 Sets error to 1 if some internal error happens
;
; Author(s):        Tuape
;
;===============================================================================
Func _SysTrayIconPos($iIndex = 0)
	;=========================================================
	;   Create the struct _TBBUTTON
	;   struct {
	;	int         iBitmap;
	;    int         idCommand;
	;    BYTE     fsState;
	;    BYTE     fsStyle;
	;
	;	#ifdef _WIN64
	;    BYTE     bReserved[6]     // padding for alignment
	;	#elif defined(_WIN32)
	;    BYTE     bReserved[2]     // padding for alignment
	;	#endif
	;    DWORD_PTR   dwData;
	;    INT_PTR          iString;

	;   }
	;=========================================================
	Local $str = "int;int;byte;byte;byte[2];dword;int"
	Dim $TBBUTTON = DllStructCreate($str)
	Dim $TBBUTTON2 = DllStructCreate($str)
	Dim $ExtraData = DllStructCreate("dword[2]")
	Dim $lpData
	Dim $RECT


	Local $pId
	Local $text
	Local $procHandle
	Local $index = $iIndex
	Local $bytesRead
	Local $info
	Local $pos[2]
	Local $hidden = 0
	Local $trayHwnd
	Local $ret

	$trayHwnd = _FindTrayToolbarWindow()
	If $trayHwnd = -1 Then
		$TBBUTTON = 0
		$TBBUTTON2 = 0
		$ExtraData = 0
		SetError(1)
		Return -1
	EndIf

	$ret = DllCall("user32.dll", "int", "GetWindowThreadProcessId", "hwnd", $trayHwnd, "int_ptr", -1)
	If Not @error Then
		$pId = $ret[2]
	Else
		ConsoleWrite("Error: Could not find toolbar process id, " & @error & @LF)
		$TBBUTTON = 0
		$TBBUTTON2 = 0
		$ExtraData = 0
		SetError(1)
		Return -1
	EndIf
	$procHandle = DllCall("kernel32.dll", 'int', 'OpenProcess', 'int', $PROCESS_ALL_ACCESS, 'int', False, 'int', $pId)
	If @error Then
		ConsoleWrite("Error: Could not read toolbar process memory, " & @error & @LF)
		$TBBUTTON = 0
		$TBBUTTON2 = 0
		$ExtraData = 0
		SetError(1)
		Return -1
	EndIf

	$lpData = DllCall("kernel32.dll", "ptr", "VirtualAllocEx", "int", $procHandle[0], "int", 0, "int", DllStructGetSize($TBBUTTON), "int", 0x1000, "int", 0x04)
	If @error Then
		ConsoleWrite(@CRLF & "VirtualAllocEx Error" & @LF)
		$TBBUTTON = 0
		$TBBUTTON2 = 0
		$ExtraData = 0
		SetError(1)
		Return -1
	Else
		DllCall("user32.dll", "int", "SendMessage", "hwnd", $trayHwnd, "int", $TB_GETBUTTON, "int", $index, "ptr", $lpData[0])
		DllCall('kernel32.dll', 'int', 'ReadProcessMemory', 'int', $procHandle[0], 'int', $lpData[0], 'ptr', DllStructGetPtr($TBBUTTON2), 'int', DllStructGetSize($TBBUTTON), 'int', $bytesRead)
		DllCall('kernel32.dll', 'int', 'ReadProcessMemory', 'int', $procHandle[0], 'int', DllStructGetData($TBBUTTON2, 6), 'int', DllStructGetPtr($ExtraData), 'int', DllStructGetSize($ExtraData), 'int', $bytesRead)

		$info = DllStructGetData($ExtraData, 1, 1)
		If Not BitAND(DllStructGetData($TBBUTTON2, 3), 8) Then ; 8 = TBHIDDEN

			$str = "int;int;int;int"
			$RECT = DllStructCreate($str)

			DllCall("user32.dll", "int", "SendMessage", "hwnd", $trayHwnd, "int", $TB_GETITEMRECT, "int", $index, "ptr", $lpData[0])
			DllCall('kernel32.dll', 'int', 'ReadProcessMemory', 'int', $procHandle[0], 'int', $lpData[0], 'ptr', DllStructGetPtr($RECT), 'int', DllStructGetSize($RECT), 'int', $bytesRead)

			$ret = DllCall("user32.dll", "int", "MapWindowPoints", "hwnd", $trayHwnd, "int", 0, 'ptr', DllStructGetPtr($RECT), "int", 2)
			ConsoleWrite("Info: " & $info & "RECT[0](left): " & DllStructGetData($RECT, 1) & "RECT[1](top): " & DllStructGetData($RECT, 2) & "RECT[2](right): " & DllStructGetData($RECT, 3) & "RECT[3](bottom): " & DllStructGetData($RECT, 4) & @LF)

			;MouseMove(DllStructGetData($RECT,1),DllStructGetData($RECT,2))
			;Sleep(1000)
			;MouseClick("left")
			$pos[0] = DllStructGetData($RECT, 1)
			$pos[1] = DllStructGetData($RECT, 2)
			$RECT = 0
		Else
			$hidden = 1
		EndIf

		DllCall("kernel32.dll", "int", "VirtualFreeEx", "int", $procHandle[0], "ptr", $lpData[0], "int", DllStructGetSize($TBBUTTON), "int", 0x8000)
	EndIf

	DllCall('kernel32.dll', 'int', 'CloseHandle', 'int', $procHandle[0])
	$TBBUTTON = 0
	$TBBUTTON2 = 0
	$ExtraData = 0
	If $hidden <> 1 Then
		Return $pos
	Else
		Return -1
	EndIf
EndFunc   ;==>_SysTrayIconPos


;===============================================================================
;
; Function Name:    _SysTrayIconHandle($iIndex=0)
; Description:      Utility function. Gets hwnd of window associated with
;					systray icon of given index
; Parameter(s):     $iIndex = icon index (Note: starting from 0)
;
; Requirement(s):   AutoIt3 Beta
; Return Value(s):  On Success - Returns hwnd of found icon
;                   On Failure - Returns -1 in error situations
;
; Author(s):        Tuape
;
;===============================================================================
Func _SysTrayIconHandle($iIndex = 0)
	;=========================================================
	;   Create the struct _TBBUTTON
	;   struct {
	;	int         iBitmap;
	;    int         idCommand;
	;    BYTE     fsState;
	;    BYTE     fsStyle;
	;
	;	#ifdef _WIN64
	;    BYTE     bReserved[6]     // padding for alignment
	;	#elif defined(_WIN32)
	;    BYTE     bReserved[2]     // padding for alignment
	;	#endif
	;    DWORD_PTR   dwData;
	;    INT_PTR          iString;

	;   }
	;=========================================================
	Local $str = "int;int;byte;byte;byte[2];dword;int";char[128]"
	Dim $TBBUTTON = DllStructCreate($str)
	Dim $TBBUTTON2 = DllStructCreate($str)
	Dim $ExtraData = DllStructCreate("dword[2]")


	Local $pId
	Local $text
	Local $procHandle
	Local $index = $iIndex
	Local $bytesRead
	Local $info
	Local $lpData

	Local $ret = DllCall("user32.dll", "int", "GetWindowThreadProcessId", "hwnd", _FindTrayToolbarWindow(), "int_ptr", -1)
	If Not @error Then
		$pId = $ret[2]
	Else
		ConsoleWrite("Error: Could not find toolbar process id, " & @error & @LF)
		$TBBUTTON = 0
		$TBBUTTON2 = 0
		$ExtraData = 0
		Return -1
	EndIf
	$procHandle = DllCall("kernel32.dll", 'int', 'OpenProcess', 'int', $PROCESS_ALL_ACCESS, 'int', False, 'int', $pId)
	If @error Then
		ConsoleWrite("Error: Could not read toolbar process memory, " & @error & @LF)
		$TBBUTTON = 0
		$TBBUTTON2 = 0
		$ExtraData = 0
		Return -1
	EndIf

	$lpData = DllCall("kernel32.dll", "ptr", "VirtualAllocEx", "int", $procHandle[0], "int", 0, "int", DllStructGetSize($TBBUTTON), "int", 0x1000, "int", 0x04)
	If @error Then
		ConsoleWrite("VirtualAllocEx Error" & @LF)
		$TBBUTTON = 0
		$TBBUTTON2 = 0
		$ExtraData = 0
		Return -1
	Else
		DllCall("user32.dll", "int", "SendMessage", "hwnd", _FindTrayToolbarWindow(), "int", $TB_GETBUTTON, "int", $index, "ptr", $lpData[0]);e(hwnd, TB_GETBUTTON, index, (LPARAM)lpData);
		DllCall('kernel32.dll', 'int', 'ReadProcessMemory', 'int', $procHandle[0], 'int', $lpData[0], 'ptr', DllStructGetPtr($TBBUTTON2), 'int', DllStructGetSize($TBBUTTON), 'int', $bytesRead)
		DllCall('kernel32.dll', 'int', 'ReadProcessMemory', 'int', $procHandle[0], 'int', DllStructGetData($TBBUTTON2, 6), 'int', DllStructGetPtr($ExtraData), 'int', DllStructGetSize($ExtraData), 'int', $bytesRead);_MemRead($procHandle, $lpData[0], DllStructGetSize( $TBBUTTON))

		$info = DllStructGetData($ExtraData, 1)
		DllCall("kernel32.dll", "int", "VirtualFreeEx", "int", $procHandle[0], "ptr", $lpData[0], "int", DllStructGetSize($TBBUTTON), "int", 0x8000)
	EndIf

	DllCall('kernel32.dll', 'int', 'CloseHandle', 'int', $procHandle[0])
	$TBBUTTON = 0
	$TBBUTTON2 = 0
	$ExtraData = 0
	Return $info
EndFunc   ;==>_SysTrayIconHandle

;===============================================================================
;
; Function Name:    _SysTrayIconTooltip($iIndex=0)
; Description:      Utility function. Gets the tooltip text of
;					systray icon of given index
; Parameter(s):     $iIndex = icon index (Note: starting from 0)
;
; Requirement(s):   AutoIt3 Beta
; Return Value(s):  On Success - Returns tooltip text of icon
;                   On Failure - Returns -1 in error situations
;
; Author(s):        Tuape
;
;===============================================================================
Func _SysTrayIconTooltip($iIndex = 0)
	;=========================================================
	;   Create the struct _TBBUTTON
	;   struct {
	;	int         iBitmap;
	;    int         idCommand;
	;    BYTE     fsState;
	;    BYTE     fsStyle;
	;
	;	#ifdef _WIN64
	;    BYTE     bReserved[6]     // padding for alignment
	;	#elif defined(_WIN32)
	;    BYTE     bReserved[2]     // padding for alignment
	;	#endif
	;    DWORD_PTR   dwData;
	;    INT_PTR          iString;

	;   }
	;=========================================================
	Local $str = "int;int;byte;byte;byte[2];dword;int"
	Dim $TBBUTTON = DllStructCreate($str)
	Dim $TBBUTTON2 = DllStructCreate($str)
	Dim $ExtraData = DllStructCreate("dword[2]")
	Dim $intTip = DllStructCreate("short[1024]")


	Local $pId
	Local $text
	Local $procHandle
	Local $index = $iIndex
	Local $bytesRead
	Local $info
	Local $lpData

	Local $ret = DllCall("user32.dll", "int", "GetWindowThreadProcessId", "hwnd", _FindTrayToolbarWindow(), "int_ptr", -1)
	If Not @error Then
		$pId = $ret[2]
	Else
		ConsoleWrite("Error: Could not find toolbar process id, " & @error & @LF)
		$TBBUTTON = 0
		$TBBUTTON2 = 0
		$ExtraData = 0
		Return -1
	EndIf
	$procHandle = DllCall("kernel32.dll", 'int', 'OpenProcess', 'int', $PROCESS_ALL_ACCESS, 'int', False, 'int', $pId)
	If @error Then
		ConsoleWrite("Error: Could not read toolbar process memory, " & @error & @LF)
		$TBBUTTON = 0
		$TBBUTTON2 = 0
		$ExtraData = 0
		Return -1
	EndIf

	$lpData = DllCall("kernel32.dll", "ptr", "VirtualAllocEx", "int", $procHandle[0], "int", 0, "int", DllStructGetSize($TBBUTTON), "int", 0x1000, "int", 0x04)
	If @error Then
		ConsoleWrite("VirtualAllocEx Error" & @LF)
		$TBBUTTON = 0
		$TBBUTTON2 = 0
		$ExtraData = 0
		Return -1
	Else
		DllCall("user32.dll", "int", "SendMessage", "hwnd", _FindTrayToolbarWindow(), "int", $TB_GETBUTTON, "int", $index, "ptr", $lpData[0]);e(hwnd, TB_GETBUTTON, index, (LPARAM)lpData);
		DllCall('kernel32.dll', 'int', 'ReadProcessMemory', 'int', $procHandle[0], 'int', $lpData[0], 'ptr', DllStructGetPtr($TBBUTTON2), 'int', DllStructGetSize($TBBUTTON), 'int', $bytesRead)
		DllCall('kernel32.dll', 'int', 'ReadProcessMemory', 'int', $procHandle[0], 'int', DllStructGetData($TBBUTTON2, 7), 'int', DllStructGetPtr($intTip), 'int', DllStructGetSize($intTip), 'int', 0);_MemRead($procHandle, $lpData[0], DllStructGetSize( $TBBUTTON))

		; go through every character
		Local $i = 1
		Local $tipChar
		While $i < 1024
			$tipChar = ""

			#cs
				BOOL ReadProcessMemory(
				HANDLE hProcess,
				LPCVOID lpBaseAddress,
				LPVOID lpBuffer,
				SIZE_T nSize,
				SIZE_T* lpNumberOfBytesRead
				);
			#ce


			$tipChar = Chr(DllStructGetData($intTip, 1, $i))

			If $tipChar = "" Then
				ExitLoop
			EndIf
			ConsoleWrite(@CRLF & $i & " Char: " & $tipChar & @LF)
			$info = $info & $tipChar

			$i = $i + 1
		WEnd

		If $info = "" Then
			$info = "No tooltip text"
		EndIf

		DllCall("kernel32.dll", "int", "VirtualFreeEx", "int", $procHandle[0], "ptr", $lpData[0], "int", DllStructGetSize($TBBUTTON), "int", 0x8000)
	EndIf

	DllCall('kernel32.dll', 'int', 'CloseHandle', 'int', $procHandle[0])
	$TBBUTTON = 0
	$TBBUTTON2 = 0
	$ExtraData = 0
	$intTip = 0
	Return $info
EndFunc   ;==>_SysTrayIconTooltip

;===============================================================================
;
; Function Name:    _SysTrayIconCount
; Description:      Utility function. Returns number of icons on systray
;					Note: Hidden icons are also reported
; Parameter(s):     None
;
; Requirement(s):   AutoIt3 Beta
; Return Value(s):  On Success - Returns number of icons found
;                   On Failure - TO BE DONE
;
; Author(s):        Tuape
;
;===============================================================================
Func _SysTrayIconCount()
	Local $hWnd = _FindTrayToolbarWindow()
	Local $count = 0
	$count = DllCall("user32.dll", "int", "SendMessage", "hwnd", $hWnd, "int", $TB_BUTTONCOUNT, "int", 0, "int", 0)
	Return $count[0]
EndFunc   ;==>_SysTrayIconCount

;===============================================================================
;
; Function Name:    _SysTrayIconVisible($flag, $index)
; Description:      Hides / unhides any icon on systray
;
; Parameter(s):     $flag = hide (1) or show (0) icon
;					$index = icon index. Can be queried with _SysTrayIconIndex()
;
; Requirement(s):   AutoIt3 Beta
; Return Value(s):  On Success - Returns 1 if operation was successfull / 0 if
;					icon was already hidden/unhidden
;                   On Failure - If invalid parameters, returns -1 and sets error
;					to 1
;
; Author(s):        Tuape
;
;===============================================================================
Func _SysTrayIconVisible($flag, $index)
	If $flag < 0 Or $flag > 1 Or Not IsInt($flag) Then
		SetError(1)
		Return -1
	EndIf

	Local $hWnd = _FindTrayToolbarWindow()
	Local $return

	Local $str = "int;int;byte;byte;byte[2];dword;int";char[128]"
	Dim $TBBUTTON = DllStructCreate($str)
	Dim $TBBUTTON2 = DllStructCreate($str)



	Local $pId
	Local $text
	Local $procHandle
	Local $bytesRead
	Local $info
	Local $lpData

	Local $ret = DllCall("user32.dll", "int", "GetWindowThreadProcessId", "hwnd", $hWnd, "int_ptr", -1)
	If Not @error Then
		$pId = $ret[2]
	Else
		ConsoleWrite("Error: Could not find toolbar process id, " & @error & @LF)
		$TBBUTTON = 0
		$TBBUTTON2 = 0
		Return -1
	EndIf
	$procHandle = DllCall("kernel32.dll", 'int', 'OpenProcess', 'int', $PROCESS_ALL_ACCESS, 'int', False, 'int', $pId)
	If @error Then
		ConsoleWrite("Error: Could not read toolbar process memory, " & @error & @LF)
		$TBBUTTON = 0
		$TBBUTTON2 = 0
		Return -1
	EndIf

	$lpData = DllCall("kernel32.dll", "ptr", "VirtualAllocEx", "int", $procHandle[0], "int", 0, "int", DllStructGetSize($TBBUTTON), "int", 0x1000, "int", 0x04)
	If @error Then
		ConsoleWrite("VirtualAllocEx Error" & @LF)
		$TBBUTTON = 0
		$TBBUTTON2 = 0
		Return -1
	Else
		DllCall("user32.dll", "int", "SendMessage", "hwnd", $hWnd, "int", $TB_GETBUTTON, "int", $index, "ptr", $lpData[0]);e(hwnd, TB_GETBUTTON, index, (LPARAM)lpData);
		DllCall('kernel32.dll', 'int', 'ReadProcessMemory', 'int', $procHandle[0], 'int', $lpData[0], 'ptr', DllStructGetPtr($TBBUTTON2), 'int', DllStructGetSize($TBBUTTON), 'int', $bytesRead)

		$return = DllCall("user32.dll", "int", "SendMessage", "hwnd", $hWnd, "int", $TB_HIDEBUTTON, "int", DllStructGetData($TBBUTTON2, 2), "long", $flag)
		;ConsoleWrite(@CRLF & "Return: " & $return[0])

		DllCall("kernel32.dll", "int", "VirtualFreeEx", "int", $procHandle[0], "ptr", $lpData[0], "int", DllStructGetSize($TBBUTTON), "int", 0x8000)


		DllCall('kernel32.dll', 'int', 'CloseHandle', 'int', $procHandle[0])

	EndIf


	$TBBUTTON = 0
	$TBBUTTON2 = 0

	Return $return[0]
EndFunc   ;==>_SysTrayIconVisible

;===============================================================================
;
; Function Name:    _SysTrayIconMove($curPos, $newPos)
; Description:      Moves systray icon
;
; Parameter(s):     $curPos = icon's current index (0 based)
;					$newPos = icon's new position
;					----> ($curPos+1 = one step to right, $curPos-1 = one step to left)
;
; Requirement(s):   AutoIt3 Beta
; Return Value(s):  On Success - Returns 1 if operation was successfull
;                   On Failure - If invalid parameters, returns -1 and sets error
;					to 1
;
; Author(s):        Tuape
;
;===============================================================================
Func _SysTrayIconMove($curPos, $newPos)

	Local $iconCount = _SysTrayIconCount()
	If $curPos < 0 Or $newPos < 0 Or $curPos > $iconCount - 1 Or $newPos > $iconCount - 1 Or Not IsInt($curPos) Or Not IsInt($newPos) Then
		SetError(1)
		Return -1
	EndIf

	Local $hWnd = _FindTrayToolbarWindow()
	Local $return

	Local $return = DllCall("user32.dll", "int", "SendMessage", "hwnd", $hWnd, "int", $TB_MOVEBUTTON, "int", $curPos, "int", $newPos)
	Return $return[0]
EndFunc   ;==>_SysTrayIconMove

;===============================================================================
;
; Function Name:    _SysTrayIconRemove($index=0
; Description:      Removes systray icon completely.
;
; Parameter(s):     index = icon index. Can be queried with _SysTrayIconIndex()
;					Default = 0
;
; Requirement(s):   AutoIt3 Beta
; Return Value(s):  On Success - Returns 1 if icon successfully removed
;                   On Failure - Sets error to 1 and returns -1
;
; Author(s):        Tuape
;
;===============================================================================
Func _SysTrayIconRemove($index = 0)
	If $index < 0 Or $index > _SysTrayIconCount() - 1 Then
		SetError(1)
		Return -1
	EndIf

	Local $hWnd = _FindTrayToolbarWindow()
	DllCall("user32.dll", "int", "SendMessage", "hwnd", $hWnd, "int", $TB_DELETEBUTTON, "int", $index, "int", 0)
	If Not @error Then
		Return 1
	Else
		SetError(2)
		Return -1
	EndIf
EndFunc   ;==>_SysTrayIconRemove


;===============================================================================
;
; Function Name:    _FindTrayToolbarWindow
; Description:      Utility function for finding Toolbar window hwnd
; Parameter(s):     None
;
; Requirement(s):   AutoIt3 Beta
; Return Value(s):  On Success - Returns Toolbar window hwnd
;                   On Failure - returns -1
;
; Author(s):        Tuape
;
;===============================================================================
Func _FindTrayToolbarWindow()
	Local $hWnd = DllCall("user32.dll", "hwnd", "FindWindow", "str", "Shell_TrayWnd", "int", 0)

	If @error Then Return -1
	$hWnd = DllCall("user32.dll", "hwnd", "FindWindowEx", "hwnd", $hWnd[0], "int", 0, "str", "TrayNotifyWnd", "int", 0);FindWindowEx(hWnd,NULL,_T("TrayNotifyWnd"), NULL);
	If @error Then Return -1
	If @OSVersion <> "WIN_2000" Then
		$hWnd = DllCall("user32.dll", "hwnd", "FindWindowEx", "hwnd", $hWnd[0], "int", 0, "str", "SysPager", "int", 0);FindWindowEx(hWnd,NULL,_T("TrayNotifyWnd"), NULL);
		If @error Then Return -1
	EndIf
	$hWnd = DllCall("user32.dll", "hwnd", "FindWindowEx", "hwnd", $hWnd[0], "int", 0, "str", "ToolbarWindow32", "int", 0);FindWindowEx(hWnd,NULL,_T("TrayNotifyWnd"), NULL);
	If @error Then Return -1

	Return $hWnd[0]

EndFunc   ;==>_FindTrayToolbarWindow