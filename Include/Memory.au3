#include-once
#include <WinAPI.au3>
#include <MemoryConstants.au3>
#include <StructureConstants.au3>

; #INDEX# =======================================================================================================================
; Title .........: Memory
; Description ...: The memory manager implements virtual memory, provides a core set of services such  as  memory  mapped  files,
;                  copy-on-write memory, large memory support, and underlying support for the cache manager.
; Author ........: Paul Campbell (PaulIA)
; ===============================================================================================================================

; ===============================================================================================================================
; OpenProcess Constants
; ===============================================================================================================================

; #VARIABLES# ===================================================================================================================
Global Const $__MEMORYCONSTANT_PROCESS_VM_OPERATION = 0x00000008
Global Const $__MEMORYCONSTANT_PROCESS_VM_READ = 0x00000010
Global Const $__MEMORYCONSTANT_PROCESS_VM_WRITE = 0x00000020

;==============================================================================================================================
; #CURRENT# =====================================================================================================================
;_MemGlobalAlloc
;_MemGlobalFree
;_MemGlobalLock
;_MemGlobalSize
;_MemGlobalUnlock
;_MemMsgBox
;_MemMoveMemory
;_MemShowError
;_MemVirtualAlloc
;_MemVirtualAllocEx
;_MemVirtualFree
;_MemVirtualFreeEx
; ===============================================================================================================================

; #INTERNAL_USE_ONLY#============================================================================================================
;_MemFree
;_MemInit
;_MemRead
;_MemWrite
;==============================================================================================================================

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _MemFree
; Description ...: Releases a memory map structure for a control
; Syntax.........: _MemFree(ByRef $tMemMap)
; Parameters ....: $tMemMap     - tagMEMMAP structure
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: This function is used internally by Auto3Lib and should not normally be called
; Related .......: _MemInit
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _MemFree(ByRef $tMemMap)
	Local $hProcess, $pMemory, $bResult

	$pMemory = DllStructGetData($tMemMap, "Mem")
	$hProcess = DllStructGetData($tMemMap, "hProc")
	; Thanks to jpm for his tip on using @OSType instead of @OSVersion
	If @OSTYPE = "WIN32_WINDOWS"  Then
		$bResult = _MemVirtualFree($pMemory, 0, $MEM_RELEASE)
	Else
		$bResult = _MemVirtualFreeEx($hProcess, $pMemory, 0, $MEM_RELEASE)
	EndIf
	_WinAPI_CloseHandle($hProcess)
	Return $bResult
EndFunc   ;==>_MemFree

; #FUNCTION# ====================================================================================================================
; Name...........: _MemGlobalAlloc
; Description ...: Allocates the specified number of bytes from the heap
; Syntax.........: _MemGlobalAlloc($iBytes[, $iFlags = 0])
; Parameters ....: $iBytes      - The number of bytes to allocate. If this parameter is zero and the $iFlags parameter  specifies
;                  +$GMEM_MOVEABLE, the function returns a handle to a memory object that is marked as discarded.
;                  $iFlags      - The memory allocation attributes:
;                  |$GMEM_FIXED    - Allocates fixed memory. The return value is a pointer.
;                  |$GMEM_MOVEABLE - Allocates movable memory.  Memory blocks are never moved in physical memory, but
;                  +they can be moved within the default heap.  The return value is a handle to the memory object.
;                  +To translate  the  handle into a pointer, use the _MemGlobalLock function. This value cannot be
;                  +combined with $GMEM_FIXED.
;                  |$GMEM_ZEROINIT - Initializes memory contents to zero
;                  |$GHND          - Combines $GMEM_MOVEABLE and $GMEM_ZEROINIT
;                  |$GPTR          - Combines $GMEM_FIXED and $GMEM_ZEROINIT
; Return values .: Success      - Handle to the newly allocated memory object
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: Windows memory management does not provide a separate local heap and global heap.  If this function  succeeds,
;                  it allocates at least the amount of memory requested.  If the actual amount  allocated  is  greater  than  the
;                  amount requested, the process can use the entire amount.  To determine the actual number of  bytes  allocated,
;                  use the _MemGlobalSize function.  If the heap does not contain sufficient free space to satisfy the  request,
;                  this function returns NULL.  Memory allocated with this function is guaranteed to be  aligned  on  an  8  byte
;                  boundary. To execute dynamically generated code, use the _MemVirtualAlloc function to allocate memory and the
;                  _Mem_VirtualProtect function to grant $PAGE_EXECUTE access.  To  free  the  memory,  use  the  _MemGlobalFree
;                  function. It is not safe to free memory allocated with _MemGlobalAlloc using _Mem_LocalFree.
; Related .......: _MemGlobalLock, _MemGlobalSize, _MemVirtualAlloc
; Link ..........; @@MsdnLink@@ GlobalAlloc
; Example .......;
; ===============================================================================================================================
Func _MemGlobalAlloc($iBytes, $iFlags = 0)
	Local $aResult

	$aResult = DllCall("Kernel32.dll", "hwnd", "GlobalAlloc", "int", $iFlags, "int", $iBytes)
	Return $aResult[0]
EndFunc   ;==>_MemGlobalAlloc

; #FUNCTION# ====================================================================================================================
; Name...........: _MemGlobalFree
; Description ...: Frees the specified global memory object and invalidates its handle
; Syntax.........: _MemGlobalFree($hMem)
; Parameters ....: $hMem        - Handle to the global memory object
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _MemGlobalAlloc
; Link ..........; @@MsdnLink@@ GlobalFree
; Example .......;
; ===============================================================================================================================
Func _MemGlobalFree($hMem)
	Local $aResult

	$aResult = DllCall("Kernel32.dll", "int", "GlobalFree", "hwnd", $hMem)
	Return $aResult[0] = 0
EndFunc   ;==>_MemGlobalFree

; #FUNCTION# ====================================================================================================================
; Name...........: _MemGlobalLock
; Description ...: Locks a global memory object and returns a pointer to the first byte of the object's memory block
; Syntax.........: _MemGlobalLock($hMem)
; Parameters ....: $hMem        - Handle to the global memory object
; Return values .: Success      - Pointer to the first byte of the memory block
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _MemGlobalUnlock
; Link ..........; @@MsdnLink@@ GlobalLock
; Example .......;
; ===============================================================================================================================
Func _MemGlobalLock($hMem)
	Local $aResult

	$aResult = DllCall("Kernel32.dll", "ptr", "GlobalLock", "hwnd", $hMem)
	Return $aResult[0]
EndFunc   ;==>_MemGlobalLock

; #FUNCTION# ====================================================================================================================
; Name...........: _MemGlobalSize
; Description ...: Retrieves the current size of the specified global memory object
; Syntax.........: _MemGlobalSize($hMem)
; Parameters ....: $hMem        - Handle to the global memory object
; Return values .: Success      - size of the specified global memory object, in bytes
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _MemGlobalAlloc
; Link ..........; @@MsdnLink@@ GlobalSize
; Example .......;
; ===============================================================================================================================
Func _MemGlobalSize($hMem)
	Local $aResult

	$aResult = DllCall("Kernel32.dll", "int", "GlobalSize", "hwnd", $hMem)
	Return $aResult[0]
EndFunc   ;==>_MemGlobalSize

; #FUNCTION# ====================================================================================================================
; Name...........: _MemGlobalUnlock
; Description ...: Decrements the lock count associated with a memory object that was allocated with GMEM_MOVEABLE
; Syntax.........: _MemGlobalUnlock($hMem)
; Parameters ....: $hMem        - Handle to the global memory object
; Return values .:
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _MemGlobalLock
; Link ..........; @@MsdnLink@@ GlobalUnlock
; Example .......;
; ===============================================================================================================================
Func _MemGlobalUnlock($hMem)
	Local $aResult

	$aResult = DllCall("Kernel32.dll", "int", "GlobalUnlock", "hwnd", $hMem)
	Return $aResult[0]
EndFunc   ;==>_MemGlobalUnlock

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _MemInit
; Description ...: Initializes a tagMEMMAP structure for a control
; Syntax.........: _MemInit($hWnd, $iSize, ByRef $tMemMap)
; Parameters ....: $hWnd        - Window handle of the process where memory will be mapped
;                  $iSize       - Size, in bytes, of memory space to map
;                  $tMemMap     - tagMEMMAP structure that will be initialized
; Return values .: Success      - Pointer to reserved memory block
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: This function is used internally by Auto3Lib and should not normally be called
; Related .......: _MemFree
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _MemInit($hWnd, $iSize, ByRef $tMemMap)
	Local $iAccess, $iAlloc, $pMemory, $hProcess, $iProcessID

	_WinAPI_GetWindowThreadProcessId($hWnd, $iProcessID)
	If $iProcessID = 0 Then _MemShowError("_MemInit: Invalid window handle [0x" & Hex($hWnd) & "]")

	$iAccess = BitOR($__MEMORYCONSTANT_PROCESS_VM_OPERATION, $__MEMORYCONSTANT_PROCESS_VM_READ, $__MEMORYCONSTANT_PROCESS_VM_WRITE)
	$hProcess = _WinAPI_OpenProcess($iAccess, False, $iProcessID, True)
	; Thanks to jpm for his tip on using @OSType instead of @OSVersion
	If @OSTYPE = "WIN32_WINDOWS"  Then
		$iAlloc = BitOR($MEM_RESERVE, $MEM_COMMIT, $MEM_SHARED)
		$pMemory = _MemVirtualAlloc(0, $iSize, $iAlloc, $PAGE_READWRITE)
	Else
		$iAlloc = BitOR($MEM_RESERVE, $MEM_COMMIT)
		$pMemory = _MemVirtualAllocEx($hProcess, 0, $iSize, $iAlloc, $PAGE_READWRITE)
	EndIf

	If $pMemory = 0 Then _MemShowError("_MemInit: Unable to allocate memory")
	$tMemMap = DllStructCreate($tagMEMMAP)
	DllStructSetData($tMemMap, "hProc", $hProcess)
	DllStructSetData($tMemMap, "Size", $iSize)
	DllStructSetData($tMemMap, "Mem", $pMemory)
	Return $pMemory
EndFunc   ;==>_MemInit

; #FUNCTION# ====================================================================================================================
; Name...........: _MemMsgBox
; Description ...: Displays a message box with wider margin than original
; Syntax.........: _MemMsgBox($iFlags, $sTitle, $sText)
; Parameters ....: $iFlags      - Flags to use during window creation
;                  $sTitle      - Window title
;                  $sText       - Window text
; Return values .:
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: This function produces (IMO) a better looking message box.  It also makes sure that BlockInput is  turned  off
;                  so the user can move the mouse.
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _MemMsgBox($iFlags, $sTitle, $sText)
	BlockInput(0)
	MsgBox($iFlags, $sTitle, $sText & "      ")
EndFunc   ;==>_MemMsgBox

; #FUNCTION# ====================================================================================================================
; Name...........: _MemMoveMemory
; Description ...: Moves memory either forward or backward, aligned or unaligned
; Syntax.........: _MemMoveMemory($pSource, $pDest, $iLength)
; Parameters ....: $pSource     - Pointer to the source of the move
;                  $pDest       - Pointer to the destination of the move
;                  $iLength     - Specifies the number of bytes to be copied
; Return values .:
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ RtlMoveMemory
; Example .......;
; ===============================================================================================================================
Func _MemMoveMemory($pSource, $pDest, $iLength)
	DllCall("Kernel32.dll", "none", "RtlMoveMemory", "ptr", $pDest, "ptr", $pSource, "dword", $iLength)
EndFunc   ;==>_MemMoveMemory

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _MemRead
; Description ...: Transfer memory from external address space to internal address space
; Syntax.........: _MemRead(ByRef $tMemMap, $pSrce, $pDest, $iSize)
; Parameters ....: $tMemMap     - tagMEMMAP structure
;                  $pSrce       - Pointer to external memory
;                  $pDest       - Pointer to internal memory
;                  $iSize       - Size in bytes of memory to read
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: This function is used internally by Auto3Lib and should not normally be called
; Related .......: _MemWrite
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _MemRead(ByRef $tMemMap, $pSrce, $pDest, $iSize)
	Local $iRead

	Return _WinAPI_ReadProcessMemory(DllStructGetData($tMemMap, "hProc"), $pSrce, $pDest, $iSize, $iRead)
EndFunc   ;==>_MemRead

; #FUNCTION# ====================================================================================================================
; Name...........: _MemShowError
; Description ...: Displays an error message box with an optional exit
; Syntax.........: _MemShowError($sText[, $fExit = True])
; Parameters ....: $sText       - Error text to display
;                  $fExit       - Specifies whether to exit after the display:
;                  | True - Exit program after display
;                  |False - Return normally after display
; Return values .:
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _MemShowError($sText, $fExit = True)
	_MemMsgBox(16 + 4096, "Error", $sText)
	If $fExit Then Exit
EndFunc   ;==>_MemShowError

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _MemWrite
; Description ...: Transfer memory to external address space from internal address space
; Syntax.........: _MemWrite(ByRef $tMemMap, $pSrce[, $pDest = 0[, $iSize = 0[, $sSrce = "ptr"]]])
; Parameters ....: $tMemMap     - tagMEMMAP structure
;                  $pSrce       - Pointer to internal memory
;                  $pDest       - Pointer to external memory
;                  $iSize       - Size in bytes of memory to write
;                  $sSrce       - Contains the data type for $pSrce
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: This function is used internally by Auto3Lib and should not normally be called
; Related .......: _MemRead
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _MemWrite(ByRef $tMemMap, $pSrce, $pDest = 0, $iSize = 0, $sSrce = "ptr")
	Local $iWritten

	If $pDest = 0 Then $pDest = DllStructGetData($tMemMap, "Mem")
	If $iSize = 0 Then $iSize = DllStructGetData($tMemMap, "Size")
	Return _WinAPI_WriteProcessMemory(DllStructGetData($tMemMap, "hProc"), $pDest, $pSrce, $iSize, $iWritten, $sSrce)
EndFunc   ;==>_MemWrite

; #FUNCTION# ====================================================================================================================
; Name...........: _MemVirtualAlloc
; Description ...: Reserves or commits a region of pages in the virtual address space of the calling process
; Syntax.........: _MemVirtualAlloc($pAddress, $iSize, $iAllocation, $iProtect)
; Parameters ....: $pAddress    - Specifies the desired starting address of the region to allocate
;                  $iSize       - Specifies the size, in bytes, of th  region
;                  $iAllocation - Specifies the type of allocation:
;                  |$MEM_COMMIT   - Allocates physical storage in memory or in the paging file on disk for the  specified  region
;                  +of pages.
;                  |$MEM_RESERVE  - Reserves a range of the process's virtual  address  space  without  allocating  any  physical
;                  +storage.
;                  |$MEM_TOP_DOWN - Allocates memory at the highest possible address
;                  $iProtect    - Type of access protection:
;                  |$PAGE_READONLY          - Enables read access to the committed region of pages
;                  |$PAGE_READWRITE         - Enables read and write access to the committed region
;                  |$PAGE_EXECUTE           - Enables execute access to the committed region
;                  |$PAGE_EXECUTE_READ      - Enables execute and read access to the committed region
;                  |$PAGE_EXECUTE_READWRITE - Enables execute, read, and write access to the committed region of pages
;                  |$PAGE_GUARD             - Pages in the region become guard pages
;                  |$PAGE_NOACCESS          - Disables all access to the committed region of pages
;                  |$PAGE_NOCACHE           - Allows no caching of the committed regions of pages
; Return values .: Success      - Memory address pointer
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _MemVirtualFree
; Link ..........; @@MsdnLink@@ VirtualAlloc
; Example .......;
; ===============================================================================================================================
Func _MemVirtualAlloc($pAddress, $iSize, $iAllocation, $iProtect)
	Local $aResult

	$aResult = DllCall("Kernel32.dll", "ptr", "VirtualAlloc", "ptr", $pAddress, "int", $iSize, "int", $iAllocation, "int", $iProtect)
	Return SetError($aResult[0] = 0, 0, $aResult[0])
EndFunc   ;==>_MemVirtualAlloc

; #FUNCTION# ====================================================================================================================
; Name...........: _MemVirtualAllocEx
; Description ...: Reserves a region of memory within the virtual address space of a specified process
; Syntax.........: _MemVirtualAllocEx($hProcess, $pAddress, $iSize, $iAllocation, $iProtect)
; Parameters ....: $pAddress    - Specifies the desired starting address of the region to allocate
;                  $iSize       - Specifies the size, in bytes, of th  region
;                  $iAllocation - Specifies the type of allocation:
;                  |$MEM_COMMIT   - Allocates physical storage in memory or in the paging file on disk for the  specified  region
;                  +of pages.
;                  |$MEM_RESERVE  - Reserves a range of the process's virtual  address  space  without  allocating  any  physical
;                  +storage.
;                  |$MEM_TOP_DOWN - Allocates memory at the highest possible address
;                  $iProtect    - Type of access protection:
;                  |$PAGE_READONLY          - Enables read access to the committed region of pages
;                  |$PAGE_READWRITE         - Enables read and write access to the committed region
;                  |$PAGE_EXECUTE           - Enables execute access to the committed region
;                  |$PAGE_EXECUTE_READ      - Enables execute and read access to the committed region
;                  |$PAGE_EXECUTE_READWRITE - Enables execute, read, and write access to the committed region of pages
;                  |$PAGE_GUARD             - Pages in the region become guard pages
;                  |$PAGE_NOACCESS          - Disables all access to the committed region of pages
;                  |$PAGE_NOCACHE           - Allows no caching of the committed regions of pages
; Return values .: Success      - Memory address pointer
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _MemVirtualFreeEx
; Link ..........; @@MsdnLink@@ VirtualAllocEx
; Example .......;
; ===============================================================================================================================
Func _MemVirtualAllocEx($hProcess, $pAddress, $iSize, $iAllocation, $iProtect)
	Local $aResult

	$aResult = DllCall("Kernel32.dll", "ptr", "VirtualAllocEx", "int", $hProcess, "ptr", $pAddress, "int", $iSize, "int", $iAllocation, "int", $iProtect)
	Return SetError($aResult[0] = 0, 0, $aResult[0])
EndFunc   ;==>_MemVirtualAllocEx

; #FUNCTION# ====================================================================================================================
; Name...........: _MemVirtualFree
; Description ...: Releases a region of pages within the virtual address space of a process
; Syntax.........: _MemVirtualFree($pAddress, $iSize, $iFreeType)
; Parameters ....: $pAddress    - Points to the base address of the region of pages to be freed
;                  $iSize       - Specifies the size, in bytes, of the region to be freed
;                  $iFreeType   - Specifies the type of free operation:
;                  |$MEM_DECOMMIT - Decommits the specified region of committed pages
;                  |$MEM_RELEASE  - Releases the specified region of reserved pages
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _MemVirtualAlloc
; Link ..........; @@MsdnLink@@ VirtualFree
; Example .......;
; ===============================================================================================================================
Func _MemVirtualFree($pAddress, $iSize, $iFreeType)
	Local $aResult

	$aResult = DllCall("Kernel32.dll", "ptr", "VirtualFree", "ptr", $pAddress, "int", $iSize, "int", $iFreeType)
	Return $aResult[0]
EndFunc   ;==>_MemVirtualFree

; #FUNCTION# ====================================================================================================================
; Name...........: _MemVirtualFreeEx
; Description ...: Releases a region of pages within the virtual address space of a process
; Syntax.........: _MemVirtualFreeEx($hProcess, $pAddress, $iSize, $iFreeType)
; Parameters ....: $hProcess     - Handle to a process
;                  $pAddress     - A pointer to the starting address of the region of memory to be freed
;                  $iSize        - The size of the region of memory to free, in bytes
;                  $iFreeType   - Specifies the type of free operation:
;                  |$MEM_DECOMMIT - Decommits the specified region of committed pages
;                  |$MEM_RELEASE  - Releases the specified region of reserved pages
; Return values .: Success       - True
;                  Failure       - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _MemVirtualAllocEx
; Link ..........; @@MsdnLink@@ VirtualFreeEx
; Example .......;
; ===============================================================================================================================
Func _MemVirtualFreeEx($hProcess, $pAddress, $iSize, $iFreeType)
	Local $aResult

	$aResult = DllCall("Kernel32.dll", "ptr", "VirtualFreeEx", "hwnd", $hProcess, "ptr", $pAddress, "int", $iSize, "int", $iFreeType)
	Return $aResult[0]
EndFunc   ;==>_MemVirtualFreeEx