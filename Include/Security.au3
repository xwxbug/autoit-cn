#include-once

#include <SecurityConstants.au3>
#include <WinAPI.au3>
#include <StructureConstants.au3>

; #INDEX# =======================================================================================================================
; Title .........: Security
; Description ...: Functions that assist with Security management.
; Author(s) .....: Paul Campbell (PaulIA)
; Dll(s) ........: Advapi32.dll
; ===============================================================================================================================

; #CONSTANTS# ===================================================================================================================
Global Const $__SECURITYCONTANT_FORMAT_MESSAGE_FROM_SYSTEM = 0x1000
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
;_Security__AdjustTokenPrivileges
;_Security__GetAccountSid
;_Security__GetLengthSid
;_Security__GetTokenInformation
;_Security__ImpersonateSelf
;_Security__IsValidSid
;_Security__LookupAccountName
;_Security__LookupAccountSid
;_Security__LookupPrivilegeValue
;_Security__OpenProcessToken
;_Security__OpenThreadToken
;_Security__OpenThreadTokenEx
;_Security__SetPrivilege
;_Security__SidToStringSid
;_Security__SidTypeStr
;_Security__StringSidToSid
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name...........: _Security__AdjustTokenPrivileges
; Description ...: Enables or disables privileges in the specified access token
; Syntax.........: _Security__AdjustTokenPrivileges($hToken, $fDisableAll, $pNewState, $iBufferLen[, $pPrevState = 0[, $pRequired = 0]])
; Parameters ....: $hToken      - Handle to the access token that contains privileges to be modified
;                  $fDisableAll - If True, the function disables all privileges and ignores the NewState parameter. If False, the
;                  +function modifies privileges based on the information pointed to by the $pNewState parameter.
;                  $pNewState   - Pointer to a $tagTOKEN_PRIVILEGES structure that contains the privilege and it's attributes
;                  $iBufferLen  - Size, in bytes, of the buffer pointed to by $pNewState
;                  $pPrevState  - Pointer to a $tagTOKEN_PRIVILEGES structure that specifies the previous state of  the  privilege
;                  +that the function modified. This can be 0
;                  $pRequired   - Pointer to a variable that receives the required size, in bytes, of the buffer  pointed  to  by
;                  +$pPrevState. This parameter can be 0 if $pPrevState is 0.
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: This function cannot add new privileges to an access token. It can only enable or disable the token's existing
;                  privileges.
; Related .......: $tagTOKEN_PRIVILEGES
; Link ..........: @@MsdnLink@@ AdjustTokenPrivileges
; Example .......:
; ===============================================================================================================================
Func _Security__AdjustTokenPrivileges($hToken, $fDisableAll, $pNewState, $iBufferLen, $pPrevState = 0, $pRequired = 0)
	Local $aResult

	$aResult = DllCall("Advapi32.dll", "int", "AdjustTokenPrivileges", "hwnd", $hToken, "int", $fDisableAll, "ptr", $pNewState, _
			"int", $iBufferLen, "ptr", $pPrevState, "ptr", $pRequired)
	Return SetError($aResult[0] = 0, 0, $aResult[0] <> 0)
EndFunc   ;==>_Security__AdjustTokenPrivileges

; #FUNCTION# ====================================================================================================================
; Name...........: _Security__GetAccountSid
; Description ...: Retrieves the security identifier (SID) for an account
; Syntax.........: _Security__GetAccountSid($sAccount[, $sSystem = ""])
; Parameters ....: $sAccount    - Specifies the account name. Use a fully qualified string in the domain_name\user_name format to
;                  +ensure that the function finds the account in the desired domain.
;                  $sSystem     - Name of the system. This string can be the name of a remote computer. If this string is  blank,
;                  +the account name translation begins on the local system.  If the name cannot be resolved on the local system,
;                  +this function will try to resolve the name using domain controllers trusted by the local system.
; Return values .: Success      - Returns a binary SID in a byte strucutre
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Security__LookupAccountSid
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _Security__GetAccountSid($sAccount, $sSystem = "")
	Local $aAcct

	$aAcct = _Security__LookupAccountName($sAccount, $sSystem)
	If @error Then Return SetError(@error, 0, 0)

	Return _Security__StringSidToSid($aAcct[0])
EndFunc   ;==>_Security__GetAccountSid

; #FUNCTION# ====================================================================================================================
; Name...........: _Security__GetLengthSid
; Description ...: Returns the length, in bytes, of a valid SID
; Syntax.........: _Security__GetLengthSid($pSID)
; Parameters ....: $pSID        - Pointer to a SID
; Return values .: Success      - Length of SID
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Security__IsValidSid
; Link ..........: @@MsdnLink@@ GetLengthSid
; Example .......:
; ===============================================================================================================================
Func _Security__GetLengthSid($pSID)
	Local $aResult

	If Not _Security__IsValidSid($pSID) Then Return SetError(-1, 0, 0)
	$aResult = DllCall("AdvAPI32.dll", "int", "GetLengthSid", "ptr", $pSID)
	Return $aResult[0]
EndFunc   ;==>_Security__GetLengthSid

; #FUNCTION# ====================================================================================================================
; Name...........: _Security__GetTokenInformation
; Description ...: Retrieves a specified type of information about an access token
; Syntax.........: _Security__GetTokenInformation($hToken, $iClass)
; Parameters ....: $hToken      - A handle to an  access  token  from  which  information  is  retrieved.  If  $iClass  specifies
;                  +$sTokenSource, the handle must have $TOKEN_QUERY_SOURCE access. For all other $iClass values, the handle must
;                  +have $TOKEN_QUERY access.
;                  $iClass      - Specifies a value to identify the type of information the function retrieves
; Return values .: Success      - A byte structure filled with the requested information
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........: @@MsdnLink@@ GetTokenInformation
; Example .......:
; ===============================================================================================================================
Func _Security__GetTokenInformation($hToken, $iClass)
	Local $pBuffer, $tBuffer, $aResult

	$aResult = DllCall("Advapi32.dll", "int", "GetTokenInformation", "hwnd", $hToken, "int", $iClass, "ptr", 0, "int", 0, "int*", 0)
	$tBuffer = DllStructCreate("byte[" & $aResult[5] & "]")
	$pBuffer = DllStructGetPtr($tBuffer)
	$aResult = DllCall("Advapi32.dll", "int", "GetTokenInformation", "hwnd", $hToken, "int", $iClass, "ptr", $pBuffer, _
			"int", $aResult[5], "int*", 0)
	If $aResult[0] = 0 Then Return SetError(-1, 0, 0)
	Return SetError(0, 0, $tBuffer)
EndFunc   ;==>_Security__GetTokenInformation

; #FUNCTION# ====================================================================================================================
; Name...........: _Security__ImpersonateSelf
; Description ...: Obtains an access token that impersonates the calling process security context
; Syntax.........: _Security__ImpersonateSelf([$iLevel = 2])
; Parameters ....: $iLevel      - Impersonation level of the new token:
;                  |0 - Anonymous.  The server process cannot obtain identification information about the client, and  it  cannot
;                  +impersonate the client.
;                  |1 - Identification.  The server process can obtain information about the client, such as security identifiers
;                  +and privileges, but it cannot impersonate the client.
;                  |2 - Impersonation. The server process can impersonate the clients security context on its local  system.  The
;                  +server cannot impersonate the client on remote systems.
;                  |3 - Delegation.  The server process can impersonate the client's security context on remote systems.
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Security__OpenThreadTokenEx
; Link ..........: @@MsdnLink@@ ImpersonateSelf
; Example .......:
; ===============================================================================================================================
Func _Security__ImpersonateSelf($iLevel = 2)
	Local $aResult

	$aResult = DllCall("Advapi32.dll", "int", "ImpersonateSelf", "int", $iLevel)
	Return SetError($aResult[0] = 0, 0, $aResult[0] <> 0)
EndFunc   ;==>_Security__ImpersonateSelf

; #FUNCTION# ====================================================================================================================
; Name...........: _Security__IsValidSid
; Description ...: Validates a SID
; Syntax.........: _Security__IsValidSid($pSID)
; Parameters ....: $pSID        - Pointer to a SID
; Return values .: True         - SID is valid
;                  False        - SID is not valid
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Security__GetLengthSid
; Link ..........: @@MsdnLink@@ IsValidSid
; Example .......:
; ===============================================================================================================================
Func _Security__IsValidSid($pSID)
	Local $aResult

	$aResult = DllCall("AdvAPI32.dll", "int", "IsValidSid", "ptr", $pSID)
	Return $aResult[0] <> 0
EndFunc   ;==>_Security__IsValidSid

; #FUNCTION# ====================================================================================================================
; Name...........: _Security__LookupAccountName
; Description ...: Retrieves a security identifier (SID) for the account and the name of the domain
; Syntax.........: _Security__LookupAccountName($sAccount[, $sSystem = ""])
; Parameters ....: $sAccount    - Specifies the account name. Use a fully qualified string in the domain_name\user_name format to
;                  +ensure that the function finds the account in the desired domain.
;                  $sSystem     - Name of the system. This string can be the name of a remote computer.  If this string is blank,
;                  +the account name translation begins on the local system.  If the name cannot be resolved on the local system,
;                  +this function will try to resolve the name using domain controllers trusted by the local system.
; Return values .: Success      - Array with the following format:
;                  |$aAcct[0] - SID String
;                  |$aAcct[1] - Domain name
;                  |$aAcct[2] - SID type, which can be one of the following values:
;                  | 1 - Indicates a user SID
;                  | 2 - Indicates a group SID
;                  | 3 - Indicates a domain SID
;                  | 4 - Indicates an alias SID
;                  | 5 - Indicates a SID for a well-known group
;                  | 6 - Indicates a SID for a deleted account
;                  | 7 - Indicates an invalid SID
;                  | 8 - Indicates an unknown SID type
;                  | 9 - Indicates a SID for a computer
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Security__LookupAccountSid
; Link ..........: @@MsdnLink@@ LookupAccountName
; Example .......:
; ===============================================================================================================================
Func _Security__LookupAccountName($sAccount, $sSystem = "")
	Local $tData, $pDomain, $pSID, $pSize1, $pSize2, $pSNU, $aResult, $aAcct[3]

	$tData = DllStructCreate("byte SID[256];char Domain[256];int SNU;int Size1;int Size2")
	$pSID = DllStructGetPtr($tData, "SID")
	$pDomain = DllStructGetPtr($tData, "Domain")
	$pSNU = DllStructGetPtr($tData, "SNU")
	$pSize1 = DllStructGetPtr($tData, "Size1")
	$pSize2 = DllStructGetPtr($tData, "Size2")
	DllStructSetData($tData, "Size1", 256)
	DllStructSetData($tData, "Size2", 256)
	$aResult = DllCall("AdvAPI32.dll", "int", "LookupAccountName", "str", $sSystem, "str", $sAccount, "ptr", $pSID, "ptr", $pSize1, _
			"ptr", $pDomain, "ptr", $pSize2, "ptr", $pSNU)
	If $aResult[0] <> 0 Then
		$aAcct[0] = _Security__SidToStringSid($pSID)
		$aAcct[1] = DllStructGetData($tData, "Domain")
		$aAcct[2] = DllStructGetData($tData, "SNU")
	EndIf
	Return SetError($aResult[0] = 0, 0, $aAcct)
EndFunc   ;==>_Security__LookupAccountName

; #FUNCTION# ====================================================================================================================
; Name...........: _Security__LookupAccountSid
; Description ...: Retrieves the name of the account for a SID
; Syntax.........: _Security__LookupAccountSid($vSID)
; Parameters ....: $vSID        - Either a binary SID or a string SID
; Return values .: Success      - Array with the following format:
;                  |$aAcct[0] - Account name
;                  |$aAcct[1] - Domain name
;                  |$aAcct[2] - SID type, which can be one of the following values:
;                  | 1 - Indicates a user SID
;                  | 2 - Indicates a group SID
;                  | 3 - Indicates a domain SID
;                  | 4 - Indicates an alias SID
;                  | 5 - Indicates a SID for a well-known group
;                  | 6 - Indicates a SID for a deleted account
;                  | 7 - Indicates an invalid SID
;                  | 8 - Indicates an unknown SID type
;                  | 9 - Indicates a SID for a computer
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Security__LookupAccountName, _Security__GetAccountSid
; Link ..........: @@MsdnLink@@ LookupAccountSid
; Example .......:
; ===============================================================================================================================
Func _Security__LookupAccountSid($vSID)
	Local $tData, $pDomain, $pName, $pSID, $tSID, $pSize1, $pSize2, $pSNU, $aResult, $aAcct[3]

	If IsString($vSID) Then
		$tSID = _Security__StringSidToSid($vSID)
		$pSID = DllStructGetPtr($tSID)
	Else
		$pSID = $vSID
	EndIf
	If Not _Security__IsValidSid($pSID) Then Return SetError(-1, 0, 0)

	$tData = DllStructCreate("char Name[256];char Domain[256];int SNU;int Size1;int Size2")
	$pName = DllStructGetPtr($tData, "Name")
	$pDomain = DllStructGetPtr($tData, "Domain")
	$pSNU = DllStructGetPtr($tData, "SNU")
	$pSize1 = DllStructGetPtr($tData, "Size1")
	$pSize2 = DllStructGetPtr($tData, "Size2")
	DllStructSetData($tData, "Size1", 256)
	DllStructSetData($tData, "Size2", 256)
	$aResult = DllCall("AdvAPI32.dll", "int", "LookupAccountSid", "int", 0, "ptr", $pSID, "ptr", $pName, "ptr", $pSize1, _
			"ptr", $pDomain, "ptr", $pSize2, "ptr", $pSNU)
	$aAcct[0] = DllStructGetData($tData, "Name")
	$aAcct[1] = DllStructGetData($tData, "Domain")
	$aAcct[2] = DllStructGetData($tData, "SNU")
	Return SetError($aResult[0] = 0, 0, $aAcct)
EndFunc   ;==>_Security__LookupAccountSid

; #FUNCTION# ====================================================================================================================
; Name...........: _Security__LookupPrivilegeValue
; Description ...: Retrieves the locally unique identifier (LUID) for a privilege value
; Syntax.........: _Security__LookupPrivilegeValue($sSystem, $sName)
; Parameters ....: $sSystem     - Specifies the name of the system on which the  privilege  name  is  retrieved.  If  blank,  the
;                  +function attempts to find the privilege name on the local system.
;                  $sName       - Specifies the name of the privilege
; Return values .: Success      - LUID by which the privilege is known
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........: @@MsdnLink@@ LookupPrivilegeValue
; Example .......:
; ===============================================================================================================================
Func _Security__LookupPrivilegeValue($sSystem, $sName)
	Local $tData, $aResult

	$tData = DllStructCreate("int64 LUID")
	$aResult = DllCall("Advapi32.dll", "int", "LookupPrivilegeValue", "str", $sSystem, "str", $sName, "ptr", DllStructGetPtr($tData))
	Return SetError($aResult[0] = 0, 0, DllStructGetData($tData, "LUID"))
EndFunc   ;==>_Security__LookupPrivilegeValue

; #FUNCTION# ====================================================================================================================
; Name...........: _Security__OpenProcessToken
; Description ...: Returns the process handle of the calling process
; Syntax.........: _Security__OpenProcessToken($hProcess, $iAccess)
; Parameters ....: $hProcess    - A handle to the process whose access token is opened.  The process must  have  been  given  the
;                  +$PROCESS_QUERY_INFORMATION access permission.
;                  $iAccess     - Specifies an access mask that specifies the requested types of access to the access token.
; Return values .: Success      - A pointer to a handle that identifies the newly opened access token when the function returns.
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: Close the access token handle returned by calling _WinAPI_CloseHandle
; Related .......: _Security__OpenThreadToken
; Link ..........: @@MsdnLink@@ OpenProcessToken
; Example .......:
; ===============================================================================================================================
Func _Security__OpenProcessToken($hProcess, $iAccess)
	Local $aResult

	$aResult = DllCall("Advapi32.dll", "int", "OpenProcessToken", "hwnd", $hProcess, "dword", $iAccess, "int*", 0)
	Return SetError($aResult[0], 0, $aResult[3])
EndFunc   ;==>_Security__OpenProcessToken

; #FUNCTION# ====================================================================================================================
; Name...........: _Security__OpenThreadToken
; Description ...: Opens the access token associated with a thread
; Syntax.........: _Security__OpenThreadToken($iAccess[, $hThread = 0[, $fOpenAsSelf = False]])
; Parameters ....: $iAccess     - Access mask that specifies the requested types of access to the access token.  These  requested
;                  +access types are reconciled against the token's discretionary access control list (DACL) to  determine  which
;                  +accesses are granted or denied.
;                  $hThread     - Handle to the thread whose access token is opened
;                  $fOpenAsSelf - Indicates whether the access check is to be made against the security  context  of  the  thread
;                  +calling the OpenThreadToken function or against the security context of the process for the  calling  thread.
;                  +If this parameter is False, the access check is performed using the security context for the calling  thread.
;                  +If the thread is impersonating a client, this security context can be that  of  a  client  process.  If  this
;                  +parameter is True, the access check is made using the security context of the process for the calling thread.
; Return values .: Success      - Handle to the newly opened access token
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Security__OpenThreadTokenEx, _Security__OpenProcessToken
; Link ..........: @@MsdnLink@@ OpenThreadToken
; Example .......:
; ===============================================================================================================================
Func _Security__OpenThreadToken($iAccess, $hThread = 0, $fOpenAsSelf = False)
	Local $tData, $pToken, $aResult

	If $hThread = 0 Then $hThread = _WinAPI_GetCurrentThread()
	$tData = DllStructCreate("int Token")
	$pToken = DllStructGetPtr($tData, "Token")
	$aResult = DllCall("Advapi32.dll", "int", "OpenThreadToken", "int", $hThread, "int", $iAccess, "int", $fOpenAsSelf, "ptr", $pToken)
	Return SetError($aResult[0] = 0, 0, DllStructGetData($tData, "Token"))
EndFunc   ;==>_Security__OpenThreadToken

; #FUNCTION# ====================================================================================================================
; Name...........: _Security__OpenThreadTokenEx
; Description ...: Opens the access token associated with a thread, impersonating the client's security context if required
; Syntax.........: _Security__OpenThreadTokenEx($iAccess[, $hThread = 0[, $fOpenAsSelf = False]])
; Parameters ....: $iAccess     - Access mask that specifies the requested types of access to the access token.  These  requested
;                  +access types are reconciled against the token's discretionary access control list (DACL) to  determine  which
;                  +accesses are granted or denied.
;                  $hThread     - Handle to the thread whose access token is opened
;                  $fOpenAsSelf - Indicates whether the access check is to be made against the security  context  of  the  thread
;                  +calling the OpenThreadToken function or against the security context of the process for the  calling  thread.
;                  +If this parameter is False, the access check is performed using the security context for the calling  thread.
;                  +If the thread is impersonating a client, this security context can be that  of  a  client  process.  If  this
;                  +parameter is True, the access check is made using the security context of the process for the calling thread.
; Return values .: Success      - Handle to the newly opened access token
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Security__OpenThreadToken, _Security__ImpersonateSelf
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _Security__OpenThreadTokenEx($iAccess, $hThread = 0, $fOpenAsSelf = False)
	Local $hToken

	$hToken = _Security__OpenThreadToken($iAccess, $hThread, $fOpenAsSelf)
	If $hToken = 0 Then
		If _WinAPI_GetLastError() = $ERROR_NO_TOKEN Then
			If Not _Security__ImpersonateSelf() Then Return SetError(-1, _WinAPI_GetLastError(), 0)
			$hToken = _Security__OpenThreadToken($iAccess, $hThread, $fOpenAsSelf)
			If $hToken = 0 Then Return SetError(-2, _WinAPI_GetLastError(), 0)
		Else
			Return SetError(-3, _WinAPI_GetLastError(), 0)
		EndIf
	EndIf
	Return SetError(0, 0, $hToken)
EndFunc   ;==>_Security__OpenThreadTokenEx

; #FUNCTION# ====================================================================================================================
; Name...........: _Security__SetPrivilege
; Description ...: Enables or disables a local token privilege
; Syntax.........: _Security__SetPrivilege($hToken, $sPrivilege, $fEnable)
; Parameters ....: $hToken      - Handle to a token
;                  $sPrivilege  - Privilege name
;                  $fEnable     - Privilege setting:
;                  | True - Enable privilege
;                  |False - Disable privilege
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _Security__SetPrivilege($hToken, $sPrivilege, $fEnable)
	Local $pRequired, $tRequired, $iLUID, $iAttributes, $iCurrState, $pCurrState, $tCurrState, $iPrevState, $pPrevState, $tPrevState

	$iLUID = _Security__LookupPrivilegeValue("", $sPrivilege)
	If $iLUID = 0 Then Return SetError(-1, 0, False)

	$tCurrState = DllStructCreate($tagTOKEN_PRIVILEGES)
	$pCurrState = DllStructGetPtr($tCurrState)
	$iCurrState = DllStructGetSize($tCurrState)
	$tPrevState = DllStructCreate($tagTOKEN_PRIVILEGES)
	$pPrevState = DllStructGetPtr($tPrevState)
	$iPrevState = DllStructGetSize($tPrevState)
	$tRequired = DllStructCreate("int Data")
	$pRequired = DllStructGetPtr($tRequired)
	; Get current privilege setting
	DllStructSetData($tCurrState, "Count", 1)
	DllStructSetData($tCurrState, "LUID", $iLUID)
	If Not _Security__AdjustTokenPrivileges($hToken, False, $pCurrState, $iCurrState, $pPrevState, $pRequired) Then
		Return SetError(-2, @error, False)
	EndIf
	; Set privilege based on prior setting
	DllStructSetData($tPrevState, "Count", 1)
	DllStructSetData($tPrevState, "LUID", $iLUID)
	$iAttributes = DllStructGetData($tPrevState, "Attributes")
	If $fEnable Then
		$iAttributes = BitOR($iAttributes, $SE_PRIVILEGE_ENABLED)
	Else
		$iAttributes = BitAND($iAttributes, BitNOT($SE_PRIVILEGE_ENABLED))
	EndIf
	DllStructSetData($tPrevState, "Attributes", $iAttributes)
	If Not _Security__AdjustTokenPrivileges($hToken, False, $pPrevState, $iPrevState, $pCurrState, $pRequired) Then
		Return SetError(-3, @error, False)
	EndIf
	Return SetError(0, 0, True)
EndFunc   ;==>_Security__SetPrivilege

; #FUNCTION# ====================================================================================================================
; Name...........: _Security__SidToStringSid
; Description ...: Converts a binary SID to a string
; Syntax.........: _Security__SidToStringSid($pSID)
; Parameters ....: $pSID        - Pointer to a binary SID to be converted
; Return values .: Success      - SID in string form
;                  Failure      - Empty string
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Security__StringSidToSid
; Link ..........: @@MsdnLink@@ ConvertSidToStringSid
; Example .......:
; ===============================================================================================================================
Func _Security__SidToStringSid($pSID)
	Local $tPtr, $tBuffer, $sSID, $aResult

	If Not _Security__IsValidSid($pSID) Then Return SetError(-1, 0, "")

	$tPtr = DllStructCreate("ptr Buffer")
	$aResult = DllCall("AdvAPI32.dll", "int", "ConvertSidToStringSid", "ptr", $pSID, "ptr", DllStructGetPtr($tPtr))
	If $aResult[0] = 0 Then Return SetError(-2, 0, "")

	$tBuffer = DllStructCreate("char Text[256]", DllStructGetData($tPtr, "Buffer"))
	$sSID = DllStructGetData($tBuffer, "Text")
	_WinAPI_LocalFree(DllStructGetData($tPtr, "Buffer"))
	Return $sSID
EndFunc   ;==>_Security__SidToStringSid

; #FUNCTION# ====================================================================================================================
; Name...........: _Security__SidTypeStr
; Description ...: Converts a Sid type to string form
; Syntax.........: _Security__SidTypeStr($iType)
; Parameters ....: $iType       - Sid type
; Return values .: Success      - Sid type in string form
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _Security__SidTypeStr($iType)
	Switch $iType
		Case 1
			Return "User"
		Case 2
			Return "Group"
		Case 3
			Return "Domain"
		Case 4
			Return "Alias"
		Case 5
			Return "Well Known Group"
		Case 6
			Return "Deleted Account"
		Case 7
			Return "Invalid"
		Case 8
			Return "Invalid"
		Case 9
			Return "Computer"
		Case Else
			Return "Unknown SID Type"
	EndSwitch
EndFunc   ;==>_Security__SidTypeStr

; #FUNCTION# ====================================================================================================================
; Name...........: _Security__StringSidToSid
; Description ...: Converts a String SID to a binary SID
; Syntax.........: _Security__StringSidToSid($sSID)
; Parameters ....: $sSID        - String SID to be converted
; Return values .: Success      - SID in a byte structure
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _Security__SidToStringSid
; Link ..........: @@MsdnLink@@ ConvertStringSidToSid
; Example .......:
; ===============================================================================================================================
Func _Security__StringSidToSid($sSID)
	Local $tPtr, $iSize, $tBuffer, $tSID, $aResult

	$tPtr = DllStructCreate("ptr Buffer")
	$aResult = DllCall("AdvAPI32.dll", "int", "ConvertStringSidToSid", "str", $sSID, "ptr", DllStructGetPtr($tPtr))
	If $aResult = 0 Then Return SetError(-1, 0, 0)

	$iSize = _Security__GetLengthSid(DllStructGetData($tPtr, "Buffer"))
	$tBuffer = DllStructCreate("byte Data[" & $iSize & "]", DllStructGetData($tPtr, "Buffer"))
	$tSID = DllStructCreate("byte Data[" & $iSize & "]")
	DllStructSetData($tSID, "Data", DllStructGetData($tBuffer, "Data"))
	_WinAPI_LocalFree(DllStructGetData($tPtr, "Buffer"))
	Return $tSID
EndFunc   ;==>_Security__StringSidToSid
