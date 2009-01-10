#include-once
#include <WinAPI.au3>
#include <StructureConstants.au3>

; #INDEX# =======================================================================================================================
; Title .........: Network Share
; AutoIt Version: 3.2.3++
; Language:       English
; Description ...: The network share functions control shared resources.  A shared resource is a local resource on a server  (for
;                  example, a disk directory, print device, or named pipe) that can be accessed by users and applications on  the
;                  network.
; Author ........: Paul Campbell (PaulIA)
; ===============================================================================================================================

; #CONSTANTS# ===================================================================================================================
Global Const $STYPE_DISKTREE = 0x00000000
Global Const $STYPE_PRINTQ = 0x00000001
Global Const $STYPE_DEVICE = 0x00000002
Global Const $STYPE_IPC = 0x00000003
Global Const $STYPE_TEMPORARY = 0x40000000
Global Const $STYPE_SPECIAL = 0x80000000
; ===============================================================================================================================

;==============================================================================================================================
; #CURRENT# =====================================================================================================================
;_Net_Share_ConnectionEnum
;_Net_Share_FileClose
;_Net_Share_FileEnum
;_Net_Share_FileGetInfo
;_Net_Share_PermStr
;_Net_Share_ResourceStr
;_Net_Share_SessionDel
;_Net_Share_SessionEnum
;_Net_Share_SessionGetInfo
;_Net_Share_ShareAdd
;_Net_Share_ShareCheck
;_Net_Share_ShareDel
;_Net_Share_ShareEnum
;_Net_Share_ShareGetInfo
;_Net_Share_ShareSetInfo
;_Net_Share_StatisticsGetSvr
;_Net_Share_StatisticsGetWrk
; ===============================================================================================================================

; #INTERNAL_USE_ONLY#============================================================================================================
;_Net_Share_APIBufferFree
;_Str_Set_Char
;==============================================================================================================================

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _Net_Share_APIBufferFree
; Description ...: Frees the memory that network management functions return
; Syntax.........: _Net_Share_APIBufferFree($pBuffer)
; Parameters ....: $pBuffer     - Pointer to a buffer returned by another network management function
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: This function is used internally by the NetShare module to free network management buffers
; Related .......:
; Link ..........; @@MsdnLink@@ NetApiBufferFree
; Example .......;
; ===============================================================================================================================
Func _Net_Share_APIBufferFree($pBuffer)
	Local $aResult

	$aResult = DllCall("NetAPI32.dll", "int", "NetApiBufferFree", "ptr", $pBuffer)
	Return $aResult[0] = 0
EndFunc   ;==>_Net_Share_APIBufferFree

; #FUNCTION# ====================================================================================================================
; Name...........: _Net_Share_ConnectionEnum
; Description ...: Lists all connections made to a shared resource
; Syntax.........: _Net_Share_ConnectionEnum($sServer, $sQualifier)
; Parameters ....: $sServer     - String that specifies the DNS or NetBIOS name of the remote server on which the function is  to
;                  +execute. If this parameter is blank the local computer is  used.
;                  $sQualifier  - Specifies a share name or computer name of interest.  If it is a share name, then  all  of  the
;                  +connections made to that share name are listed.  If it is a computer name, the function lists all connections
;                  +made from that computer to the server specified.
; Return values .: Success      - Array with the following format:
;                  |[0][0] - Number of entries in array
;                  |[1][0] - Connection identification number
;                  |[1][1] - Type of connection. Can be combination of:
;                  | $STYPE_DISKTREE  - Print queue
;                  | $STYPE_PRINTQ    - Disk drive
;                  | $STYPE_DEVICE    - Communication device
;                  | $STYPE_IPC       - IPC
;                  | $STYPE_SPECIAL   - Special share reserved for IPC$ or remote administration of the server
;                  | $STYPE_TEMPORARY - A temporary share
;                  |[1][2] - Number of files currently open as a result of the connection
;                  |[1][3] - Number of users on the connection
;                  |[1][4] - Number of seconds that the connection has been established
;                  |[1][5] - If the server sharing the resource is  running  with  user  level  security,  this  member describes
;                  +which user made the connection.  If the server is running with share level  security,  this  member describes
;                  +which computer made the connection.
;                  |[1][6] - Specifies either the share name of the server's shared resource or the computername of the client
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: Administrator, Server or Print Operator or Power User group membership is required to execute this function
; Related .......: _Net_Share_FileEnum, _Net_Share_SessionEnum, _Net_Share_ShareEnum
; Link ..........; @@MsdnLink@@ NetConnectionEnum
; Example .......; Yes
; ===============================================================================================================================
Func _Net_Share_ConnectionEnum($sServer, $sQualifier)
	Local $iI, $pInfo, $tInfo, $iCount, $aResult

	If $sServer = "" Then $sServer = "127.0.0.1"
	If StringLeft($sServer, 2) <> "\\"  Then $sServer = "\\" & $sServer

	$aResult = DllCall("NetAPI32.dll", "int", "NetConnectionEnum", "wstr", $sServer, "wstr", $sQualifier, "int", 1, _
			"int*", 0, "int", -1, "int*", 0, "int*", 0, "ptr", 0)

	$pInfo = $aResult[4]
	$iCount = $aResult[6]
	Local $aInfo[$iCount + 1][7]
	$aInfo[0][0] = $iCount
	For $iI = 1 To $iCount
		$tInfo = DllStructCreate($tagCONNECTION_INFO_1, $pInfo)
		$aInfo[$iI][0] = DllStructGetData($tInfo, "ID")
		$aInfo[$iI][1] = DllStructGetData($tInfo, "Type")
		$aInfo[$iI][2] = DllStructGetData($tInfo, "Opens")
		$aInfo[$iI][3] = DllStructGetData($tInfo, "Users")
		$aInfo[$iI][4] = DllStructGetData($tInfo, "Time")
		$aInfo[$iI][5] = _WinAPI_WideCharToMultiByte(DllStructGetData($tInfo, "UserName"))
		$aInfo[$iI][6] = _WinAPI_WideCharToMultiByte(DllStructGetData($tInfo, "NetName"))
		$pInfo += DllStructGetSize($tInfo)
	Next

	_Net_Share_APIBufferFree($aResult[4])
	Return SetError($aResult[0], 0, $aInfo)
EndFunc   ;==>_Net_Share_ConnectionEnum

; #FUNCTION# ====================================================================================================================
; Name...........: _Net_Share_FileClose
; Description ...: Forces a resource to close
; Syntax.........: _Net_Share_FileClose($sServer, $iFileID)
; Parameters ....: $sServer - Specifies the DNS or NetBIOS name of the remote server on which the function is to execute.  If
;                  +this parameter is blank, the local computer is used.
;                  $iFileID     - Specifies the file identifier of the opened resource instance to close
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: Only members of the Administrators or Server Operators local group can execute this function
; Related .......:
; Link ..........; @@MsdnLink@@ NetFileClose
; Example .......; Yes
; ===============================================================================================================================
Func _Net_Share_FileClose($sServer, $iFileID)
	Local $aResult

	If $sServer = "" Then $sServer = "127.0.0.1"
	If StringLeft($sServer, 2) <> "\\"  Then $sServer = "\\" & $sServer

	$aResult = DllCall("NetAPI32.dll", "int", "NetFileClose", "wstr", $sServer, "int", $iFileID)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_Net_Share_FileClose

; #FUNCTION# ====================================================================================================================
; Name...........: _Net_Share_FileEnum
; Description ...: Returns information about open files on a server
; Syntax.........: _Net_Share_FileEnum([$sServer = ""[, $sBaseName = ""[, $sUserName = ""]]])
; Parameters ....: $sServer - String that contains the name of the server on which  the  function  is  to  execute.  A  blank
;                  +specifies the local computer.
;                  $sBaseName   - String containing a qualifier for the returned information.  If blank all  open  resources  are
;                  +enumerated. If not blank, the function enumerates only resources that have $sBaseName as a prefix.
;                  $sUserName   - String that specifies the name of the user.  If not blank $sUserName serves as a  qualifier  to
;                  +the enumeration.
; Return values .: Success      - Array with the following format:
;                  |[0][0] - Number of entries in the array (n)
;                  |[1][0] - ID number assigned to the resource when it is opened
;                  |[1][1] - Access permissions associated with the opening application:
;                  |  1 - Permission to read a resource and execute the resource
;                  |  2 - Permission to write to a resource.
;                  |  4 - Permission to create a resource
;                  |  8 - Execute permission
;                  | 16 - Delete permission
;                  | 32 - Change attribute permission
;                  | 64 - Change ACL permission
;                  |[1][2] - Contains the number of file locks on the resource
;                  |[1][3] - Specifies the path of the opened resource
;                  |[1][4] - Specifies which user or which computer opened the resource
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: Only members of the Administrators or Server Operators local group can execute this function
; Related .......: _Net_Share_ConnectionEnum, _Net_Share_SessionEnum, _Net_Share_ShareEnum
; Link ..........; @@MsdnLink@@ NetFileEnum
; Example .......; Yes
; ===============================================================================================================================
Func _Net_Share_FileEnum($sServer = "", $sBaseName = "", $sUserName = "")
	Local $iI, $iCount, $pInfo, $tInfo, $aResult

	If $sServer = "" Then $sServer = "127.0.0.1"
	If StringLeft($sServer, 2) <> "\\"  Then $sServer = "\\" & $sServer

	$aResult = DllCall("NetAPI32.dll", "int", "NetFileEnum", "wstr", $sServer, "wstr", $sBaseName, "wstr", $sUserName, "int", 3, _
			"int*", 0, "int", -1, "int*", 0, "int*", 0, "ptr", 0)

	$pInfo = $aResult[5]
	$iCount = $aResult[7]
	Local $aInfo[$iCount + 1][5]
	$aInfo[0][0] = $iCount
	For $iI = 1 To $iCount
		$tInfo = DllStructCreate($tagFILE_INFO_3, $pInfo)
		$aInfo[$iI][0] = DllStructGetData($tInfo, "ID")
		$aInfo[$iI][1] = DllStructGetData($tInfo, "Permissions")
		$aInfo[$iI][2] = DllStructGetData($tInfo, "Locks")
		$aInfo[$iI][3] = _WinAPI_WideCharToMultiByte(DllStructGetData($tInfo, "PathName"))
		$aInfo[$iI][4] = _WinAPI_WideCharToMultiByte(DllStructGetData($tInfo, "UserName"))
		$pInfo += DllStructGetSize($tInfo)
	Next

	_Net_Share_APIBufferFree($aResult[5])
	Return SetError($aResult[0], 0, $aInfo)
EndFunc   ;==>_Net_Share_FileEnum

; #FUNCTION# ====================================================================================================================
; Name...........: _Net_Share_FileGetInfo
; Description ...: Retrieves information about a particular opening of a server resource
; Syntax.........: _Net_Share_FileGetInfo($sServer, $iFileID)
; Parameters ....: $sServer - Specifies the DNS or NetBIOS name of the remote server on which the function is to execute.  If
;                  +this parameter is blank, the local computer is used.
;                  $iFileID     - File identifier of the resource for which to return information.  The value of  this  parameter
;                  +must have been returned in a previous enumeration call.
; Return values .: Success      - Array with the following format:
;                  |[0] - ID number assigned to the resource when it is opened
;                  |[1] - Access permissions associated with the opening application:
;                  |  1 - Permission to read a resource and execute the resource
;                  |  2 - Permission to write to a resource.
;                  |  4 - Permission to create a resource
;                  |  8 - Execute permission
;                  | 16 - Delete permission
;                  | 32 - Change attribute permission
;                  | 64 - Change ACL permission
;                  |[2] - Contains the number of file locks on the resource
;                  |[3] - Specifies the path of the opened resource
;                  |[4] - Specifies which user or which computer opened the resource
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: Administrator, Server or Print Operator or Power User group membership is required to execute this function
; Related .......: _Net_Share_SessionGetInfo, _Net_Share_ShareGetInfo
; Link ..........; @@MsdnLink@@ NetFileGetInfo
; Example .......; Yes
; ===============================================================================================================================
Func _Net_Share_FileGetInfo($sServer, $iFileID)
	Local $tInfo, $aInfo[5], $aResult

	If $sServer = "" Then $sServer = "127.0.0.1"
	If StringLeft($sServer, 2) <> "\\"  Then $sServer = "\\" & $sServer

	$aResult = DllCall("NetAPI32.dll", "int", "NetFileGetInfo", "wstr", $sServer, "int", $iFileID, "int", 3, "int*", 0)

	If $aResult[4] <> 0 Then
		$tInfo = DllStructCreate($tagFILE_INFO_3, $aResult[4])
		$aInfo[0] = DllStructGetData($tInfo, "ID")
		$aInfo[1] = DllStructGetData($tInfo, "Permissions")
		$aInfo[2] = DllStructGetData($tInfo, "Locks")
		$aInfo[3] = _WinAPI_WideCharToMultiByte(DllStructGetData($tInfo, "PathName"))
		$aInfo[4] = _WinAPI_WideCharToMultiByte(DllStructGetData($tInfo, "UserName"))
		_Net_Share_APIBufferFree($aResult[4])
	EndIf

	Return SetError($aResult[0], 0, $aInfo)
EndFunc   ;==>_Net_Share_FileGetInfo

; #FUNCTION# ====================================================================================================================
; Name...........: _Net_Share_PermStr
; Description ...: Returns the string representation of a resource's permissions
; Syntax.........: _Net_Share_PermStr($iPerm)
; Parameters ....: $iPerm       - The resource's permissions:
;                  | 1 - Permission to read data from a resource and to execute
;                  | 2 - Permission to write data to the resource
;                  | 4 - Permission to create an instance of the resource
;                  | 8 - Permission to execute the resource
;                  |16 - Permission to delete the resource
;                  |32 - Permission to modify the resource's attributes
;                  |64 - Permission to modify the permissions assigned to a resource
; Return values .: Success      - Permissions string
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Gary Frost
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Net_Share_PermStr($iPerm)
	Local $sType

	$sType = "-------"
	If BitAND($iPerm, 1) Then _Str_Set_Char($sType, 1, "R")
	If BitAND($iPerm, 2) Then _Str_Set_Char($sType, 2, "W")
	If BitAND($iPerm, 4) Then _Str_Set_Char($sType, 3, "C")
	If BitAND($iPerm, 8) Then _Str_Set_Char($sType, 4, "E")
	If BitAND($iPerm, 16) Then _Str_Set_Char($sType, 5, "D")
	If BitAND($iPerm, 32) Then _Str_Set_Char($sType, 6, "A")
	If BitAND($iPerm, 64) Then _Str_Set_Char($sType, 7, "P")
	Return $sType
EndFunc   ;==>_Net_Share_PermStr

; #FUNCTION# ====================================================================================================================
; Name...........: _Net_Share_ResourceStr
; Description ...: Returns the string representation of a resource
; Syntax.........: _Net_Share_ResourceStr($iResource)
; Parameters ....: $iResource   - Resource type. Can be a combination of:
;                  |$STYPE_DISKTREE  - Print queue
;                  |$STYPE_PRINTQ    - Disk drive
;                  |$STYPE_DEVICE    - Communication device
;                  |$STYPE_IPC       - IPC
;                  |$STYPE_SPECIAL   - Special share reserved for IPC$ or remote administration of the server
;                  |$STYPE_TEMPORARY - A temporary share
; Return values .: Success      - Resource type string
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _Net_Share_ResourceStr($iResource)
	Local $sResource = "Unknown"

	Switch BitAND($iResource, BitOR($STYPE_DISKTREE, $STYPE_PRINTQ, $STYPE_DEVICE, $STYPE_IPC))
		Case $STYPE_DISKTREE
			$sResource = "Disk drive"
		Case $STYPE_PRINTQ
			$sResource = "Print queue"
		Case $STYPE_DEVICE
			$sResource = "Communication"
		Case $STYPE_IPC
			$sResource = "IPC"
	EndSwitch

	Switch BitAND($iResource, BitOR($STYPE_TEMPORARY, $STYPE_SPECIAL))
		Case $STYPE_TEMPORARY
			$sResource &= " (Temporary)"
		Case $STYPE_SPECIAL
			$sResource &= " (Special)"
	EndSwitch
	Return $sResource
EndFunc   ;==>_Net_Share_ResourceStr

; #FUNCTION# ====================================================================================================================
; Name...........: _Net_Share_SessionDel
; Description ...: Ends a network session between a server and a workstation
; Syntax.........: _Net_Share_SessionDel([$sServer = ""[, $sClientName = ""[, $sUserName = ""]]])
; Parameters ....: $sServer - Specifies the DNS or NetBIOS name of the remote server on which the function is to execute.  If
;                  +this parameter is blank, the local computer is used.
;                  $sClientName - Specifies the computer name of the client to disconnect. If blank, then all the sessions of the
;                  +user identified by the username parameter will be deleted on the server specified by $sServer.
;                  $sUserName   - Specifies the name of the user whose session is to be terminated.  If this parameter is  blank,
;                  +all user sessions from the client specified by the $sClientName parameter are to be terminated.
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: Only members of the Administrators or Server Operators local group can execute this function.  You  must  pass
;                  either $sClientName or $sUserName (or both) for this function to work.
; Related .......: _Net_Share_ShareDel
; Link ..........; @@MsdnLink@@ NetSessionDel
; Example .......; Yes
; ===============================================================================================================================
Func _Net_Share_SessionDel($sServer = "", $sClientName = "", $sUserName = "")
	Local $aResult

	If $sServer = "" Then $sServer = "127.0.0.1"
	If StringLeft($sServer, 2) <> "\\"  Then $sServer = "\\" & $sServer
	If ($sClientName <> "") And (StringLeft($sClientName, 2) <> "\\") Then $sClientName = "\\" & $sClientName

	$aResult = DllCall("NetAPI32.dll", "int", "NetSessionDel", "wstr", $sServer, "wstr", $sClientName, "wstr", $sUserName)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_Net_Share_SessionDel

; #FUNCTION# ====================================================================================================================
; Name...........: _Net_Share_SessionEnum
; Description ...: Provides information about sessions established on a server
; Syntax.........: _Net_Share_SessionEnum([$sServer = ""[, $sClientName = ""[, $sUserName = ""]]])
; Parameters ....: $sServer - String that specifies the DNS or NetBIOS name of the remote server on which the function is  to
;                  +execute. If this parameter is blank the local computer is  used.
;                  $sClientName - Specifies the name of the computer session for which information is to  be  returned.  If  this
;                  +parameter is blank, the function returns information for all computer sessions on the server.
;                  $sUserName   - Specifies the name of the user for which information is to be returned.  If this  parameter  is
;                  +blank, the function returns information for all users.
; Return values .: Success      - Array with the following format
;                  |[0][0] - Number of entries in array
;                  |[1][0] - Name of the computer that established the session
;                  |[1][1] - Name of the user who established the session
;                  |[1][2] - Number of files, devices, and pipes opened during the session
;                  |[1][3] - Number of seconds the session has been active
;                  |[1][4] - Number of seconds the session has been idle
;                  |[1][5] - Specifies how the user established the session:
;                  | 1 - User established session using a guest account
;                  | 2 - User established session without using password encryption
;                  |[1][6] - Specifies the type of client that established the session
;                  |[1][7] - Name of the transport that the client is using
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: Only members of the Administrators or Server Operators local group can execute this function
; Related .......: _Net_Share_ConnectionEnum, _Net_Share_FileEnum, _Net_Share_ShareEnum
; Link ..........; @@MsdnLink@@ NetSessionEnum
; Example .......; Yes
; ===============================================================================================================================
Func _Net_Share_SessionEnum($sServer = "", $sClientName = "", $sUserName = "")
	Local $iI, $iCount, $pInfo, $tInfo, $aResult

	If $sServer = "" Then $sServer = "127.0.0.1"
	If StringLeft($sServer, 2) <> "\\"  Then $sServer = "\\" & $sServer
	If ($sClientName <> "") And StringLeft($sClientName, 2) <> "\\"  Then $sClientName = "\\" & $sClientName

	$aResult = DllCall("NetAPI32.dll", "int", "NetSessionEnum", "wstr", $sServer, "wstr", $sClientName, "wstr", $sUserName, _
			"int", 502, "int*", 0, "int", -1, "int*", 0, "int*", 0, "ptr", 0)

	$pInfo = $aResult[5]
	$iCount = $aResult[7]
	Local $aInfo[$iCount + 1][8]
	$aInfo[0][0] = $iCount
	For $iI = 1 To $iCount
		$tInfo = DllStructCreate($tagSESSION_INFO_502, $pInfo)
		$aInfo[$iI][0] = _WinAPI_WideCharToMultiByte(DllStructGetData($tInfo, "CName"))
		$aInfo[$iI][1] = _WinAPI_WideCharToMultiByte(DllStructGetData($tInfo, "UserName"))
		$aInfo[$iI][2] = DllStructGetData($tInfo, "Opens")
		$aInfo[$iI][3] = DllStructGetData($tInfo, "Time")
		$aInfo[$iI][4] = DllStructGetData($tInfo, "Idle")
		$aInfo[$iI][5] = DllStructGetData($tInfo, "Flags")
		$aInfo[$iI][6] = _WinAPI_WideCharToMultiByte(DllStructGetData($tInfo, "TypeName"))
		$aInfo[$iI][7] = _WinAPI_WideCharToMultiByte(DllStructGetData($tInfo, "Transport"))
		$pInfo += DllStructGetSize($tInfo)
	Next

	_Net_Share_APIBufferFree($aResult[5])
	Return SetError($aResult[0], 0, $aInfo)
EndFunc   ;==>_Net_Share_SessionEnum

; #FUNCTION# ====================================================================================================================
; Name...........: _Net_Share_SessionGetInfo
; Description ...: Retrieves information about a session established between a server and workstation
; Syntax.........: _Net_Share_SessionGetInfo($sServer, $sClientName, $sUserName)
; Parameters ....: $sServer - String that specifies the DNS or NetBIOS name of the remote server on which the function is  to
;                  +execute. If this parameter is blank the local computer is used.
;                  $sClientName - Specifies the name of the computer session for  which  information  is  to  be  returned.  This
;                  +parameter cannot be blank.
;                  $sUserName   - String that specifies the name of the user whose session information is to  be  returned.  This
;                  +parameter cannot be blank.
; Return values .: Success      - Array with the following format:
;                  |[0] - Name of the computer that established the session
;                  |[1] - Name of the user who established the session
;                  |[2] - Number of files, devices, and pipes opened during the session
;                  |[3] - Number of seconds the session has been active
;                  |[4] - Number of seconds the session has been idle
;                  |[5] - Specifies how the user established the session:
;                  | 1 - User established session using a guest account
;                  | 2 - User established session without using password encryption
;                  |[6] - Specifies the type of client that established the session
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: Only members of the Administrators or Server Operators local group can execute this function
; Related .......: _Net_Share_FileGetInfo, _Net_Share_ShareGetInfo
; Link ..........; @@MsdnLink@@ NetSessionGetInfo
; Example .......; Yes
; ===============================================================================================================================
Func _Net_Share_SessionGetInfo($sServer, $sClientName, $sUserName)
	Local $aInfo[8], $tInfo, $aResult

	If $sServer = "" Then $sServer = "127.0.0.1"
	If StringLeft($sServer, 2) <> "\\"  Then $sServer = "\\" & $sServer
	If StringLeft($sClientName, 2) <> "\\"  Then $sClientName = "\\" & $sClientName

	$aResult = DllCall("NetAPI32.dll", "int", "NetSessionGetInfo", "wstr", $sServer, "wstr", $sClientName, "wstr", $sUserName, _
			"int", 2, "int*", 0)

	If $aResult[5] <> 0 Then
		$tInfo = DllStructCreate($tagSESSION_INFO_2, $aResult[5])
		$aInfo[0] = _WinAPI_WideCharToMultiByte(DllStructGetData($tInfo, "CName"))
		$aInfo[1] = _WinAPI_WideCharToMultiByte(DllStructGetData($tInfo, "UserName"))
		$aInfo[2] = DllStructGetData($tInfo, "Opens")
		$aInfo[3] = DllStructGetData($tInfo, "Time")
		$aInfo[4] = DllStructGetData($tInfo, "Idle")
		$aInfo[5] = DllStructGetData($tInfo, "Flags")
		$aInfo[6] = _WinAPI_WideCharToMultiByte(DllStructGetData($tInfo, "TypeName"))
		_Net_Share_APIBufferFree($aResult[5])
	EndIf

	Return SetError($aResult[0], 0, $aInfo)
EndFunc   ;==>_Net_Share_SessionGetInfo

; #FUNCTION# ====================================================================================================================
; Name...........: _Net_Share_ShareAdd
; Description ...: Shares a server resource
; Syntax.........: _Net_Share_ShareAdd($sServer, $sShare, $iType, $sPath[, $sComment = ""[, $iMaxUses = -1]])
; Parameters ....: $sServer - Specifies the DNS or NetBIOS name of the remote server on which the function is to execute.  If
;                  +this parameter is blank, the local computer is used.
;                  $sShare  - Share name of a resource
;                  $iType       - Contains the type of the shared resource. Can be a combination of:
;                  |$STYPE_DISKTREE  - Disk drive
;                  |$STYPE_PRINTQ    - Print queue
;                  |$STYPE_DEVICE    - Communication device
;                  |$STYPE_IPC       - IPC
;                  |$STYPE_SPECIAL   - Special share reserved for IPC$ or remote administration of the server
;                  |$STYPE_TEMPORARY - A temporary share
;                  $sComment    - String that contains an optional comment about the shared resource
;                  $sPath       - Local path for the shared resource. For disks, this is the path being shared. For print queues,
;                  +this is the name of the print queue being shared.
;                  $iMaxUses    - The maximum number of concurrent connections that the  shared  resource  can  accommodate.  The
;                  +number of connections is unlimited if the value specified is –1.
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: Only members of the Administrators, System Operators, or Power Users local group can add file  shares  with  a
;                  call to this function. The Print Operator can add printer shares.
; Related .......: _Net_Share_ShareCheck, _Net_Share_ShareDel
; Link ..........; @@MsdnLink@@ NetApiBufferFree
; Example .......; Yes
; ===============================================================================================================================
Func _Net_Share_ShareAdd($sServer, $sShare, $iType, $sPath, $sComment = "", $iMaxUses = -1)
	Local $tData, $tInfo, $pShare, $pPath, $pComment, $aResult

	$tData = DllStructCreate("char Share[512];char Path[512];char Comment[512]")
	$pShare = DllStructGetPtr($tData, "Share")
	$pPath = DllStructGetPtr($tData, "Path")

	If $sServer = "" Then $sServer = "127.0.0.1"
	If StringLeft($sServer, 2) <> "\\"  Then $sServer = "\\" & $sServer
	_WinAPI_MultiByteToWideCharEx($sShare, DllStructGetPtr($tData, "Share"))
	_WinAPI_MultiByteToWideCharEx($sPath, DllStructGetPtr($tData, "Path"))
	If $sComment <> "" Then
		_WinAPI_MultiByteToWideCharEx($sComment, DllStructGetPtr($tData, "Comment"))
		$pComment = DllStructGetPtr($tData, "Comment")
	EndIf

	$tInfo = DllStructCreate($tagSHARE_INFO_2)
	DllStructSetData($tInfo, "NetName", $pShare)
	DllStructSetData($tInfo, "Type", $iType)
	DllStructSetData($tInfo, "Remark", $pComment)
	DllStructSetData($tInfo, "Path", $pPath)
	DllStructSetData($tInfo, "MaxUses", $iMaxUses)

	$aResult = DllCall("NetAPI32.dll", "int", "NetShareAdd", "wstr", $sServer, "int", 2, "ptr", DllStructGetPtr($tInfo), "ptr", 0)

	Return SetError($aResult[0], $aResult[0], $aResult[0] = 0)
EndFunc   ;==>_Net_Share_ShareAdd

; #FUNCTION# ====================================================================================================================
; Name...........: _Net_Share_ShareCheck
; Description ...: Checks whether or not a server is sharing a device
; Syntax.........: _Net_Share_ShareCheck($sServer, $sShare)
; Parameters ....: $sServer - Specifies the DNS or NetBIOS name of the remote server on which the function is to execute.  If
;                  +this parameter is blank, the local computer is  used.
;                  $sShare  - Specifies the name of the device to check for shared access
; Return values .: Success      - Type of the shared device. Can be a combination of:
;                  |-1               - Share does not exist
;                  |$STYPE_DISKTREE  - Print queue
;                  |$STYPE_PRINTQ    - Disk drive
;                  |$STYPE_DEVICE    - Communication device
;                  |$STYPE_IPC       - IPC
;                  |$STYPE_SPECIAL   - Special share reserved for IPC$ or remote administration of the server
;                  |$STYPE_TEMPORARY - A temporary share
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: No special group membership is required to successfully execute this function
; Related .......: _Net_Share_ShareAdd, _Net_Share_ShareDel
; Link ..........; @@MsdnLink@@ NetShareCheck
; Example .......; Yes
; ===============================================================================================================================
Func _Net_Share_ShareCheck($sServer, $sShare)
	Local $aResult

	If $sServer = "" Then $sServer = "127.0.0.1"
	If StringLeft($sServer, 2) <> "\\"  Then $sServer = "\\" & $sServer

	$aResult = DllCall("NetAPI32.dll", "int", "NetShareCheck", "wstr", $sServer, "wstr", $sShare, "int*", 0)
	If $aResult[0] Then Return SetError($aResult[0], 0, -1)
	Return SetError($aResult[0], 0, $aResult[3])
EndFunc   ;==>_Net_Share_ShareCheck

; #FUNCTION# ====================================================================================================================
; Name...........: _Net_Share_ShareDel
; Description ...: Deletes a share name from a server's list of shared resources
; Syntax.........: _Net_Share_ShareDel($sServer, $sShare)
; Parameters ....: $sServer - Specifies the DNS or NetBIOS name of the remote server on which the function is to execute.  If
;                  +this parameter is blank, the local computer is  used.
;                  $sShare  - Specifies the name of the share to delete
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: Only members of the Administrators, Server Operators, or  Power  Users  local  group,  or  those  with  Server
;                  Operator group membership, can successfully delete file shares with this  function.  The  Print  Operator  can
;                  delete printer shares.
; Related .......: _Net_Share_ShareAdd, _Net_Share_ShareCheck
; Link ..........; @@MsdnLink@@ NetShareDel
; Example .......; Yes
; ===============================================================================================================================
Func _Net_Share_ShareDel($sServer, $sShare)
	Local $aResult

	If $sServer = "" Then $sServer = "127.0.0.1"
	If StringLeft($sServer, 2) <> "\\"  Then $sServer = "\\" & $sServer

	$aResult = DllCall("NetAPI32.dll", "int", "NetShareDel", "wstr", $sServer, "wstr", $sShare, "int", 0)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_Net_Share_ShareDel

; #FUNCTION# ====================================================================================================================
; Name...........: _Net_Share_ShareEnum
; Description ...: Retrieves information about each shared resource on a server
; Syntax.........: _Net_Share_ShareEnum([$sServer = ""])
; Parameters ....: $sServer - String that specifies the DNS or NetBIOS name of the remote server on which the function is  to
;                  +execute. If this parameter is blank the local computer is  used.
; Return values .: Success      - Array with the following format:
;                  |[0][0] - Number of entries in array
;                  |[1][0] - Share name of a resource
;                  |[1][1] - Type of the shared resource. Can be a combination of:
;                  | $STYPE_DISKTREE  - Print queue
;                  | $STYPE_PRINTQ    - Disk drive
;                  | $STYPE_DEVICE    - Communication device
;                  | $STYPE_IPC       - IPC
;                  | $STYPE_SPECIAL   - Special share reserved for IPC$ or remote administration of the server
;                  | $STYPE_TEMPORARY - A temporary share
;                  |[1][2] - Contains an optional comment about the shared resource
;                  |[1][3] - Indicates the shared resource's permissions:
;                  |  1 - Permission to read data from a resource and to execute
;                  |  2 - Permission to write data to the resource
;                  |  4 - Permission to create an instance of the resource
;                  |  8 - Permission to execute the resource
;                  | 16 - Permission to delete the resource
;                  | 32 - Permission to modify the resource's attributes
;                  | 64 - Permission to modify the permissions assigned to a resource
;                  |[1][4] - Maximum number of concurrent connections for the resource
;                  |[1][5] - Indicates the number of current connections to the resource
;                  |[1][6] - Specifies the local path for the shared resource
;                  |[1][7] - Specifies the share's password
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: Administrator, Power User, Print Operator, or Server Operator group membership is  required  to  execute  this
;                  function.
; Related .......: _Net_Share_FileEnum, _Net_Share_SessionEnum
; Link ..........; @@MsdnLink@@ NetShareEnum
; Example .......; Yes
; ===============================================================================================================================
Func _Net_Share_ShareEnum($sServer = "")
	Local $iI, $iCount, $pInfo, $tInfo, $aResult

	If $sServer = "" Then $sServer = "127.0.0.1"
	If StringLeft($sServer, 2) <> "\\"  Then $sServer = "\\" & $sServer

	$aResult = DllCall("NetAPI32.dll", "int", "NetShareEnum", "wstr", $sServer, "int", 2, "int*", 0, "int", -1, _
			"int*", 0, "int*", 0, "ptr", 0)

	$pInfo = $aResult[3]
	$iCount = $aResult[5]
	Local $aInfo[$iCount + 1][8]
	$aInfo[0][0] = $iCount
	For $iI = 1 To $iCount
		$tInfo = DllStructCreate($tagSHARE_INFO_2, $pInfo)
		$aInfo[$iI][0] = _WinAPI_WideCharToMultiByte(DllStructGetData($tInfo, "NetName"))
		$aInfo[$iI][1] = DllStructGetData($tInfo, "Type")
		$aInfo[$iI][2] = _WinAPI_WideCharToMultiByte(DllStructGetData($tInfo, "Remark"))
		$aInfo[$iI][3] = DllStructGetData($tInfo, "Permissions")
		$aInfo[$iI][4] = DllStructGetData($tInfo, "MaxUses")
		$aInfo[$iI][5] = DllStructGetData($tInfo, "CurrentUses")
		$aInfo[$iI][6] = _WinAPI_WideCharToMultiByte(DllStructGetData($tInfo, "Path"))
		$aInfo[$iI][7] = _WinAPI_WideCharToMultiByte(DllStructGetData($tInfo, "Password"))
		$pInfo += DllStructGetSize($tInfo)
	Next

	_Net_Share_APIBufferFree($aResult[3])
	Return $aInfo
EndFunc   ;==>_Net_Share_ShareEnum

; #FUNCTION# ====================================================================================================================
; Name...........: _Net_Share_ShareGetInfo
; Description ...: Retrieves information about a particular shared resource on a server
; Syntax.........: _Net_Share_ShareGetInfo($sServer, $sShare)
; Parameters ....: $sServer - String that specifies the DNS or NetBIOS name of the remote server on which the function is  to
;                  +execute. If this parameter is blank the local computer is used.
;                  $sShare  - Name of the share for which to return information
; Return values .: Success      - Array with the following format:
;                  |[0] - Share name of a resource
;                  |[1] - Type of the shared resource. Can be a combination of:
;                  | $STYPE_DISKTREE  - Print queue
;                  | $STYPE_PRINTQ    - Disk drive
;                  | $STYPE_DEVICE    - Communication device
;                  | $STYPE_IPC       - IPC
;                  | $STYPE_SPECIAL   - Special share reserved for IPC$ or remote administration of the server
;                  | $STYPE_TEMPORARY - A temporary share
;                  |[2] - Contains an optional comment about the shared resource
;                  |[3] - Indicates the shared resource's permissions:
;                  |  1 - Permission to read data from a resource and to execute
;                  |  2 - Permission to write data to the resource
;                  |  4 - Permission to create an instance of the resource
;                  |  8 - Permission to execute the resource
;                  | 16 - Permission to delete the resource
;                  | 32 - Permission to modify the resource's attributes
;                  | 64 - Permission to modify the permissions assigned to a resource
;                  |[4] - Indicates the maximum number of connections that the resource can have
;                  |[5] - Indicates the number of current connections to the resource
;                  |[6] - Specifies the local path for the shared resource
;                  |[7] - Specifies the share's password
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: Only members of the Administrators, Server Operators, or Power Users local  group,  or  those  with  Print  or
;                  Server Operator group membership, can successfully execute this function.
; Related .......: _Net_Share_FileGetInfo, _Net_Share_SessionGetInfo, _Net_Share_ShareSetInfo
; Link ..........; @@MsdnLink@@ NetShareGetInfo
; Example .......; Yes
; ===============================================================================================================================
Func _Net_Share_ShareGetInfo($sServer, $sShare)
	Local $aInfo[8], $tInfo, $aResult

	If $sServer = "" Then $sServer = "127.0.0.1"
	If StringLeft($sServer, 2) <> "\\"  Then $sServer = "\\" & $sServer

	$aResult = DllCall("NetAPI32.dll", "int", "NetShareGetInfo", "wstr", $sServer, "wstr", $sShare, "int", 2, "int*", 0)

	If $aResult[4] <> 0 Then
		$tInfo = DllStructCreate($tagSHARE_INFO_2, $aResult[4])
		$aInfo[0] = _WinAPI_WideCharToMultiByte(DllStructGetData($tInfo, "NetName"))
		$aInfo[1] = DllStructGetData($tInfo, "Type")
		$aInfo[2] = _WinAPI_WideCharToMultiByte(DllStructGetData($tInfo, "Remark"))
		$aInfo[3] = DllStructGetData($tInfo, "Permissions")
		$aInfo[4] = DllStructGetData($tInfo, "MaxUses")
		$aInfo[5] = DllStructGetData($tInfo, "CurrentUses")
		$aInfo[6] = _WinAPI_WideCharToMultiByte(DllStructGetData($tInfo, "Path"))
		$aInfo[7] = _WinAPI_WideCharToMultiByte(DllStructGetData($tInfo, "Password"))
		_Net_Share_APIBufferFree($aResult[4])
	EndIf
	Return SetError($aResult[0], 0, $aInfo)
EndFunc   ;==>_Net_Share_ShareGetInfo

; #FUNCTION# ====================================================================================================================
; Name...........: _Net_Share_ShareSetInfo
; Description ...: Shares a server resource
; Syntax.........: _Net_Share_ShareSetInfo($sServer, $sShare, $sComment, $iMaxUses)
; Parameters ....: $sServer  - Specifies the DNS or NetBIOS name of the remote server on which the function  is  to  execute.  If
;                  +this parameter is blank, the local computer is used.
;                  $sShare   - Specifies the name of the share to set information on
;                  $sComment - String that contains an optional comment about the shared resource
;                  $iMaxUses - Indicates the maximum number of connections that the  resource  can  accommodate.  The  number  of
;                  +connections is unlimited if this value is –1.
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: Only members of the Administrators or Power Users local group or those with Print  or  Server  Operator  group
;                  membership, can successfully execute this function.  The Print Operator can set information only about Printer
;                  shares.
; Related .......: _Net_Share_ShareGetInfo
; Link ..........; @@MsdnLink@@ NetShareSetInfo
; Example .......; Yes
; ===============================================================================================================================
Func _Net_Share_ShareSetInfo($sServer, $sShare, $sComment, $iMaxUses)
	Local $tData, $pInfo, $tInfo, $pComment, $aResult

	$tData = DllStructCreate("char Comment[512]")
	$pComment = DllStructGetPtr($tData, "Comment")

	If $sServer = "" Then $sServer = "127.0.0.1"
	If StringLeft($sServer, 2) <> "\\"  Then $sServer = "\\" & $sServer
	_WinAPI_MultiByteToWideCharEx($sComment, DllStructGetPtr($tData, "Comment"))

	$tInfo = DllStructCreate($tagSHARE_INFO_2)
	$pInfo = DllStructGetPtr($tInfo)
	DllStructSetData($tInfo, "Remark", $pComment)
	DllStructSetData($tInfo, "MaxUses", $iMaxUses)

	$aResult = DllCall("NetAPI32.dll", "int", "NetShareSetInfo", "wstr", $sServer, "wstr", $sShare, "int", 2, "ptr", $pInfo, "ptr", 0)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_Net_Share_ShareSetInfo

; #FUNCTION# ====================================================================================================================
; Name...........: _Net_Share_StatisticsGetSvr
; Description ...: Retrieves operating statistics for a server
; Syntax.........: _Net_Share_StatisticsGetSvr([$sServer = ""])
; Parameters ....: $sServer - Specifies the DNS or NetBIOS name of the remote server on which the  function  is  to  execute.  If
;                  +this parameter is blank, the local computer is used.
; Return values .: Success      - Array with the following format:
;                  |[ 0] - Indicates the time when statistics collection started.  The value is stored as the number  of  seconds
;                  +that have elapsed since 00:00:00, January 1, 1970, GMT.
;                  |[ 1] - Indicates the number of times a file is opened on a server
;                  |[ 2] - Indicates the number of times a server device is opened
;                  |[ 3] - Indicates the number of server print jobs spooled
;                  |[ 4] - Indicates the number of times the server session started
;                  |[ 5] - Indicates the number of times the server session disconnected
;                  |[ 6] - Indicates the number of times the server sessions failed with error
;                  |[ 7] - Indicates the number of server password violations
;                  |[ 8] - Indicates the number of server access permission errors
;                  |[ 9] - Indicates the number of server system errors
;                  |[10] - Number of server bytes sent to the network
;                  |[11] - Number of server bytes received from the network
;                  |[12] - Indicates the average server response time (in milliseconds)
;                  |[13] - Indicates the number of times the server required a request buffer but failed to allocate one
;                  |[14] - Indicates the number of times the server required a big buffer but failed to allocate one
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: No special group membership is required to obtain workstation statistics.  Only members of the  Administrators
;                  or Server Operators local group can successfully execute this function on a remote server.
; Related .......: _Net_Share_StatisticsGetWrk
; Link ..........; @@MsdnLink@@ NetStatisticsGet
; Example .......; Yes
; ===============================================================================================================================
Func _Net_Share_StatisticsGetSvr($sServer = "")
	Local $pService, $tService, $tStatInfo, $aResult, $aStats[15]

	$tService = _WinAPI_MultiByteToWideChar("LanmanServer")
	$pService = DllStructGetPtr($tService)

	$aResult = DllCall("NetAPI32.dll", "int", "NetStatisticsGet", "wstr", $sServer, "wstr", $pService, "int", 0, "int", 0, "int*", 0)
	If $aResult[0] <> 0 Then Return SetError($aResult[0], $aResult[0], $aStats)

	$tStatInfo = DllStructCreate($tagSTAT_SERVER_0, $aResult[5])
	$aStats[ 0] = DllStructGetData($tStatInfo, "Start")
	$aStats[ 1] = DllStructGetData($tStatInfo, "FOpens")
	$aStats[ 2] = DllStructGetData($tStatInfo, "DevOpens")
	$aStats[ 3] = DllStructGetData($tStatInfo, "JobsQueued")
	$aStats[ 4] = DllStructGetData($tStatInfo, "SOpens")
	$aStats[ 5] = DllStructGetData($tStatInfo, "STimedOut")
	$aStats[ 6] = DllStructGetData($tStatInfo, "SErrorOut")
	$aStats[ 7] = DllStructGetData($tStatInfo, "PWErrors")
	$aStats[ 8] = DllStructGetData($tStatInfo, "PermErrors")
	$aStats[ 9] = DllStructGetData($tStatInfo, "SysErrors")
	$aStats[10] = DllStructGetData($tStatInfo, "ByteSent")
	$aStats[11] = DllStructGetData($tStatInfo, "ByteRecv")
	$aStats[12] = DllStructGetData($tStatInfo, "AvResponse")
	$aStats[13] = DllStructGetData($tStatInfo, "ReqBufNeed")
	$aStats[14] = DllStructGetData($tStatInfo, "BigBufNeed")

	_Net_Share_APIBufferFree($aResult[5])
	Return $aStats
EndFunc   ;==>_Net_Share_StatisticsGetSvr

; #FUNCTION# ====================================================================================================================
; Name...........: _Net_Share_StatisticsGetWrk
; Description ...: Retrieves operating statistics for a workstation
; Syntax.........: _Net_Share_StatisticsGetWrk([$sWorkStation = ""])
; Parameters ....: $sWorkStation - Specifies the DNS or NetBIOS name of the remote server on which the function is to execute. If
;                  +this parameter is blank, the local computer is used.
; Return values .: Success      - Array with the following format:
;                  |[ 0] - Statistics collection start time. The value is stored as the number of seconds elapsed since 00:00:00,
;                  +January 1, 1970.
;                  |[ 1] - Bytes received by the workstation
;                  |[ 2] - Server message blocks (SMBs) received by the workstation
;                  |[ 3] - Bytes that have been read by paging I/O requests
;                  |[ 4] - Bytes that have been read by non-paging I/O requests
;                  |[ 5] - Bytes that have been read by cache I/O requests
;                  |[ 6] - Bytes that have been read by disk I/O requests
;                  |[ 7] - Bytes transmitted by the workstation
;                  |[ 8] - SMBs transmitted by the workstation
;                  |[ 9] - Bytes that have been written by paging I/O requests
;                  |[10] - Bytes that have been written by non-paging I/O requests
;                  |[11] - Bytes that have been written by cache I/O requests
;                  |[12] - Bytes that have been written by disk I/O requests
;                  |[13] - Network operations that failed to begin
;                  |[14] - Network operations that failed to complete
;                  |[15] - Read operations initiated by the workstation
;                  |[16] - Random access reads initiated by the workstation
;                  |[17] - Read requests the workstation has sent to servers
;                  |[18] - Read requests the workstation has sent to servers that are greater than twice the size of the server's
;                  +negotiated buffer size.
;                  |[19] - Read requests the workstation has sent to servers that are less than 1/4 of the size  of  the server's
;                  +negotiated buffer size.
;                  |[20] - Write operations initiated by the workstation
;                  |[21] - Random access writes initiated by the workstation
;                  |[22] - Write requests the workstation has sent to servers
;                  |[23] - Write requests the workstation has sent to servers that are greater than twice the size of the server's
;                  +negotiated buffer size.
;                  |[24] - Write requests the workstation has sent to servers that are less than 1/4 of the size of  the server's
;                  +negotiated buffer size.
;                  |[25] - Raw read requests made by the workstation that have been denied
;                  |[26] - Raw write requests made by the workstation that have been denied
;                  |[27] - Network errors received by the workstation
;                  |[28] - Workstation sessions that were established
;                  |[29] - Imes the workstation attempted to create a session but failed
;                  |[30] - Connections that have failed
;                  |[31] - PCNET connections that have succeeded
;                  |[32] - LanManager 20 connections that have succeeded
;                  |[33] - LanManager 21 connections that have succeeded
;                  |[34] - Windows NT connections that have succeeded
;                  |[35] - Times the workstation was disconnected by a network server
;                  |[36] - Sessions that have expired on the workstation
;                  |[37] - Network connections established by the workstation
;                  |[38] - Failed network connections for the workstation
;                  |[39] - Current requests that have not been completed
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: No special group membership is required to obtain workstation statistics.  Only members of the  Administrators
;                  or Server Operators local group can successfully execute this function on a remote server.
; Related .......: _Net_Share_StatisticsGetSvr
; Link ..........; @@MsdnLink@@ NetStatisticsGet
; Example .......; Yes
; ===============================================================================================================================
Func _Net_Share_StatisticsGetWrk($sWorkStation = "")
	Local $pService, $tService, $tStatInfo, $aResult, $aStats[40]

	$tService = _WinAPI_MultiByteToWideChar("LanmanWorkstation")
	$pService = DllStructGetPtr($tService)

	$aResult = DllCall("NetAPI32.dll", "int", "NetStatisticsGet", "wstr", $sWorkStation, "ptr", $pService, "int", 0, "int", 0, "int*", 0)
	If $aResult[0] <> 0 Then Return SetError($aResult[0], $aResult[0], $aResult[0])

	$tStatInfo = DllStructCreate($tagSTAT_WORKSTATION_0, $aResult[5])
	$aStats[ 0] = DllStructGetData($tStatInfo, "StartTime")
	$aStats[ 1] = DllStructGetData($tStatInfo, "BytesRecv")
	$aStats[ 2] = DllStructGetData($tStatInfo, "SMBSRecv")
	$aStats[ 3] = DllStructGetData($tStatInfo, "PageRead")
	$aStats[ 4] = DllStructGetData($tStatInfo, "NonPageRead")
	$aStats[ 5] = DllStructGetData($tStatInfo, "CacheRead")
	$aStats[ 6] = DllStructGetData($tStatInfo, "NetRead")
	$aStats[ 7] = DllStructGetData($tStatInfo, "BytesTran")
	$aStats[ 8] = DllStructGetData($tStatInfo, "SMBSTran")
	$aStats[ 9] = DllStructGetData($tStatInfo, "PageWrite")
	$aStats[10] = DllStructGetData($tStatInfo, "NonPageWrite")
	$aStats[11] = DllStructGetData($tStatInfo, "CacheWrite")
	$aStats[12] = DllStructGetData($tStatInfo, "NetWrite")
	$aStats[13] = DllStructGetData($tStatInfo, "InitFailed")
	$aStats[14] = DllStructGetData($tStatInfo, "FailedComp")
	$aStats[15] = DllStructGetData($tStatInfo, "ReadOp")
	$aStats[16] = DllStructGetData($tStatInfo, "RandomReadOp")
	$aStats[17] = DllStructGetData($tStatInfo, "ReadSMBS")
	$aStats[18] = DllStructGetData($tStatInfo, "LargeReadSMBS")
	$aStats[19] = DllStructGetData($tStatInfo, "SmallReadSMBS")
	$aStats[20] = DllStructGetData($tStatInfo, "WriteOp")
	$aStats[21] = DllStructGetData($tStatInfo, "RandomWriteOp")
	$aStats[22] = DllStructGetData($tStatInfo, "WriteSMBS")
	$aStats[23] = DllStructGetData($tStatInfo, "LargeWriteSMBS")
	$aStats[24] = DllStructGetData($tStatInfo, "SmallWriteSMBS")
	$aStats[25] = DllStructGetData($tStatInfo, "RawReadsDenied")
	$aStats[26] = DllStructGetData($tStatInfo, "RawWritesDenied")
	$aStats[27] = DllStructGetData($tStatInfo, "NetworkErrors")
	$aStats[28] = DllStructGetData($tStatInfo, "Sessions")
	$aStats[29] = DllStructGetData($tStatInfo, "FailedSessions")
	$aStats[30] = DllStructGetData($tStatInfo, "Reconnects")
	$aStats[31] = DllStructGetData($tStatInfo, "CoreConnects")
	$aStats[32] = DllStructGetData($tStatInfo, "LM20Connects")
	$aStats[33] = DllStructGetData($tStatInfo, "LM21Connects")
	$aStats[34] = DllStructGetData($tStatInfo, "LMNTConnects")
	$aStats[35] = DllStructGetData($tStatInfo, "ServerDisconnects")
	$aStats[36] = DllStructGetData($tStatInfo, "HungSessions")
	$aStats[37] = DllStructGetData($tStatInfo, "UseCount")
	$aStats[38] = DllStructGetData($tStatInfo, "FailedUseCount")
	$aStats[39] = DllStructGetData($tStatInfo, "CurrentCommands")

	_Net_Share_APIBufferFree($aResult[5])
	Return $aStats
EndFunc   ;==>_Net_Share_StatisticsGetWrk

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _Str_Set_Char
; Description ...: Sets a specified character in a string
; Syntax.........: _Str_Set_Char(ByRef $sText, $iIndex, $sChar)
; Parameters ....: $sText       - Text to be changed
;                  $iIndex      - Character position in string
;                  $sChar       - Character to replace
; Return values .:
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _Str_Set_Char(ByRef $sText, $iIndex, $sChar)
	$sText = StringLeft($sText, $iIndex - 1) & $sChar & StringMid($sText, $iIndex + StringLen($sChar))
EndFunc   ;==>_Str_Set_Char