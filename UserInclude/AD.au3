#include-once
#include <Array.au3>
#include <Date.au3>
#include <Constants.au3>
#Tidy_Parameters= /gd 1  /gds 1 /nsdp
#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; #INDEX# =======================================================================================================================
; Title .........: Active Directory Function Library
; AutoIt Version : 3.3.6.0 (because of _Date_Time_SystemTimeToDateTimeStr)
; UDF Version ...: 0.42
; Language ......: English
; Description ...: A collection of functions for accessing and manipulating Microsoft Active Directory
;
; General functions:
; ==================
; _AD_Open
; _AD_Close

; User related functions (see object related functions as well):
; ==============================================================
; _AD_CreateUser
; _AD_GetUserGroups
; _AD_GetUserPrimaryGroup
; _AD_SetUserPrimaryGroup
; _AD_GetManager
; _AD_IsMemberOf
; _AD_AddUserToGroup
; _AD_RemoveUserFromGroup
; _AD_HasFullRights
; _AD_HasUnlockResetRights
; _AD_HasRequiredRights
; _AD_HasGroupUpdateRights
; _AD_GetLastLoginDate
; _AD_IsPasswordExpired
; _AD_GetPasswordExpired
; _AD_GetPasswordDontExpire
; _AD_SetPassword
; _AD_GetPasswordInfo
; _AD_DisablePasswordExpire
; _AD_EnablePasswordExpire
; _AD_EnablePasswordChange
; _AD_DisablePasswordChange
; _AD_SetAccountExpire
; _AD_AddEmailAddress
; _AD_SetPasswordExpire
; _AD_CreateMailbox
; _AD_DeleteMailbox
;
; Group related functions (see object related functions as well):
; ===============================================================
; _AD_CreateGroup
; _AD_GroupAssignManager
; _AD_GroupRemoveManager
; _AD_GetGroupAdmins
; _AD_GroupManagerCanModify
; _AD_GetManagedBy
; _AD_SetGroupManagerCanModify
; _AD_GetGroupMembers
; _AD_GetGroupMemberOf
; _AD_MailEnableGroup
;
; OU related functions (see object related functions as well):
; ============================================================
; _AD_GetObjectsInOU
; _AD_GetAllOUs
; _AD_CreateOU
;
; Computer related functions (see object related functions as well):
; ==================================================================
; _AD_CreateComputer
; _AD_JoinDomain
; _AD_UnjoinDomain
;
; Object (user, group, computer, OU) related functions:
; =====================================================
; _AD_RenameObject
; _AD_MoveObject
; _AD_DeleteObject
; _AD_UnlockObject
; _AD_DisableObject
; _AD_EnableObject
; _AD_GetObjectClass
; _AD_SamAccountNameToFQDN
; _AD_FQDNToSamAccountName
; _AD_FQDNToDisplayname
; _AD_ObjectExists
; _AD_GetObjectAttribute
; _AD_IsObjectDisabled
; _AD_IsObjectLocked
; _AD_GetObjectsDisabled
; _AD_GetObjectsLocked
; _AD_ModifyAttribute
; _AD_GetObjectProperties
; _AD_RecursiveGetMemberOf
; _AD_IsAccountExpired
; _AD_GetAccountsExpired
;
; Mail related functions (see user/group related functions as well):
; ==================================================================
; _AD_ListExchangeServers
; _AD_ListExchangeMailboxStores
; _AD_CreateMailbox
; _AD_DeleteMailbox
; _AD_MailEnableGroup
;
; Other functions:
; ================
; _AD_ListDomainControllers
; _AD_ListRootDSEAttributes
; _AD_ListRoleOwners
; _AD_GetSystemInfo
; _AD_ListPrintQueues
; _AD_ListSchemaVersions
; _AD_ObjectExistsInSchema
; _AD_GetLastADSIError
;
; Author ........: Jonathan Clelland
; Email .........: jclelland@statestreet.com
; Modified.......: water
; Contributors ..: feeks, KenE, Sundance, supersonic, Talder
; Ressources ....: http://www.wisesoft.co.uk/scripts
;                  http://gallery.technet.microsoft.com/ScriptCenter/en-us
;                  http://www.rlmueller.net/
;                  http://www.activxperts.com/activmonitor/windowsmanagement/scripts/activedirectory/
;
;                  Well known SIDs: http://technet.microsoft.com/en-us/library/cc978401.aspx
;                  AD Schema: http://msdn.microsoft.com/en-us/library/ms675085(VS.85).aspx
;				   Win32 error codes: http://msdn.microsoft.com/en-us/library/ms681381(v=VS.85).aspx
;                  ADSI: http://msdn.microsoft.com/en-us/library/aa772170(v=VS.85).aspx
;                  LDAP: http://msdn.microsoft.com/en-us/library/aa367008(v=VS.85).aspx
;                        http://www.petri.co.il/ldap_search_samples_for_windows_2003_and_exchange.htm
; ===============================================================================================================================

; #VARIABLES# ===================================================================================================================
Global $iAD_Debug = 0 ; Debug level. 0 = no debug information, 1 = Debug info to console, 2 = Debug info to MsgBox, 3 = Debug Info to File .\AD_Debug.txt
Global $oAD_MyError ; COM Error handler
Global $iAD_COMError = 0
Global $iAD_COMErrorDec = 0
Global $oAD_Connection
Global $sAD_DNSDomain
Global $sAD_HostServer
Global $sAD_Configuration
Global $oAD_OpenDS
Global $oAD_RootDSE
Global $oAD_Bind ; Reference to hold the bind cache
Global $bAD_BindFlags ; Bind flags
Global $sAD_UserId = ""
Global $sAD_Password = ""
; ===============================================================================================================================

; #CONSTANTS# ===================================================================================================================
; ADS_RIGHTS_ENUM Enumeration. See: http://msdn.microsoft.com/en-us/library/aa772285(VS.85).aspx
Global Const $ADS_FULL_RIGHTS = 0xF01FF
Global Const $ADS_USER_UNLOCKRESETACCOUNT = 0x100
Global Const $ADS_OBJECT_READWRITE_ALL = 0x30
; ADS_AUTHENTICATION_ENUM Enumeration. See: http://msdn.microsoft.com/en-us/library/aa772247(VS.85).aspx
Global Const $ADS_SECURE_AUTH = 0x1
Global Const $ADS_USE_ENCRYPTION = 0x2
Global Const $ADS_SERVER_BIND = 0x200
; ADS_USER_FLAG_ENUM Enumeration. See: http://msdn.microsoft.com/en-us/library/aa772300(VS.85).aspx
Global Const $ADS_UF_ACCOUNTDISABLE = 0x2
Global Const $ADS_UF_PASSWD_NOTREQD = 0x20
Global Const $ADS_UF_WORKSTATION_TRUST_ACCOUNT = 0x1000
Global Const $ADS_UF_DONT_EXPIRE_PASSWD = 0x10000
; ADS_GROUP_TYPE_ENUM Enumeration. See: http://msdn.microsoft.com/en-us/library/aa772263(VS.85).aspx
Global Const $ADS_GROUP_TYPE_GLOBAL_GROUP = 0x2
Global Const $ADS_GROUP_TYPE_UNIVERSAL_GROUP = 0x8
Global Const $ADS_GROUP_TYPE_SECURITY_ENABLED = 0x80000000
Global Const $ADS_GROUP_TYPE_GLOBAL_SECURITY = BitOR($ADS_GROUP_TYPE_GLOBAL_GROUP, $ADS_GROUP_TYPE_SECURITY_ENABLED)
Global Const $ADS_GROUP_TYPE_UNIVERSAL_SECURITY = BitOR($ADS_GROUP_TYPE_UNIVERSAL_GROUP, $ADS_GROUP_TYPE_SECURITY_ENABLED)
; ADS_ACETYPE_ENUM Enumeration. See: http://msdn.microsoft.com/en-us/library/aa772244(VS.85).aspx
Global Const $ADS_ACETYPE_ACCESS_ALLOWED = 0
Global Const $ADS_ACETYPE_ACCESS_DENIED = 0x1
Global Const $ADS_ACETYPE_ACCESS_ALLOWED_OBJECT = 0x5
Global Const $ADS_ACETYPE_ACCESS_DENIED_OBJECT = 0x6
; ADS_ACEFLAG_ENUM Enumeration. See: http://msdn.microsoft.com/en-us/library/aa772242(VS.85).aspx
Global Const $ADS_ACEFLAG_INHERITED_ACE = 0x10
; Global Const $ADS_FLAGTYPE_ENUM Enumeration. See: http://msdn.microsoft.com/en-us/library/aa772259(VS.85).aspx
Global Const $ADS_FLAG_OBJECT_TYPE_PRESENT = 0x1
; ADS_RIGHTS_ENUM Enumeration. See: http://msdn.microsoft.com/en-us/library/aa772285(VS.85).aspx
Global Const $ADS_RIGHT_DS_SELF = 0x8
Global Const $ADS_RIGHT_DS_WRITE_PROP = 0x20
Global Const $ADS_RIGHT_DS_CONTROL_ACCESS = 0x100
Global Const $ADS_RIGHT_GENERIC_READ = 0x80000000
; GUIDs - LOWER CASE!
Global Const $USER_CHANGE_PASSWORD = "{ab721a53-1e2f-11d0-9819-00aa0040529b}" ; See: http://msdn.microsoft.com/en-us/library/cc223637(PROT.13).aspx
Global Const $SELF_MEMBERSHIP = "{bf9679c0-0de6-11d0-a285-00aa003049e2}" ; See: http://msdn.microsoft.com/en-us/library/cc223513(PROT.10).aspx
Global Const $ALLOWED_TO_AUTHENTICATE = "{68B1D179-0D15-4d4f-AB71-46152E79A7BC}" ; See: http://msdn.microsoft.com/en-us/library/ms684300(VS.85).aspx
Global Const $RECEIVE_AS = "{AB721A56-1E2f-11D0-9819-00AA0040529B}" ; See: http://msdn.microsoft.com/en-us/library/ms684402(VS.85).aspx
Global Const $SEND_AS = "{AB721A54-1E2f-11D0-9819-00AA0040529B}" ; See: http://msdn.microsoft.com/en-us/library/ms684406(VS.85).aspx
Global Const $USER_FORCE_CHANGE_PASSWORD = "{00299570-246D-11D0-A768-00AA006E0529}" ; See: http://msdn.microsoft.com/en-us/library/ms684414(VS.85).aspx
Global Const $USER_ACCOUNT_RESTRICTIONS = "{4C164200-20C0-11D0-A768-00AA006E0529}" ; See: http://msdn.microsoft.com/en-us/library/ms684412(VS.85).aspx
Global Const $VALIDATED_DNS_HOST_NAME = "{72E39547-7B18-11D1-ADEF-00C04FD8D5CD}" ; See: http://msdn.microsoft.com/en-us/library/ms684331(VS.85).aspx
Global Const $VALIDATED_SPN = "{F3A64788-5306-11D1-A9C5-0000F80367C1}" ; See: http://msdn.microsoft.com/en-us/library/ms684417(VS.85).aspx
; ===============================================================================================================================
; #CURRENT# =====================================================================================================================
;_AD_Open
;_AD_Close
;_AD_SamAccountNameToFQDN
;_AD_FQDNToSamAccountName
;_AD_FQDNToDisplayname
;_AD_ObjectExists
;_AD_GetObjectAttribute
;_AD_IsMemberOf
;_AD_HasFullRights
;_AD_HasUnlockResetRights
;_AD_HasRequiredRights
;_AD_HasGroupUpdateRights
;_AD_GetObjectClass
;_AD_GetUserGroups
;_AD_GetUserPrimaryGroup
;_AD_SetUserPrimaryGroup
;_AD_RecursiveGetMemberOf
;_AD_GetGroupMembers
;_AD_GetGroupMemberOf
;_AD_GetObjectsInOU
;_AD_GetAllOUs
;_AD_ListDomainControllers
;_AD_ListRootDSEAttributes
;_AD_ListRoleOwners
;_AD_GetLastLoginDate
;_AD_IsObjectDisabled
;_AD_IsObjectLocked
;_AD_IsPasswordExpired
;_AD_GetObjectsDisabled
;_AD_GetObjectsLocked
;_AD_GetPasswordExpired
;_AD_GetPasswordDontExpire
;_AD_GetObjectProperties
;_AD_CreateOU
;_AD_CreateUser
;_AD_SetPassword
;_AD_CreateGroup
;_AD_AddUserToGroup
;_AD_RemoveUserFromGroup
;_AD_CreateComputer
;_AD_ModifyAttribute
;_AD_RenameObject
;_AD_MoveObject
;_AD_DeleteObject
;_AD_SetAccountExpire
;_AD_DisablePasswordExpire
;_AD_EnablePasswordExpire
;_AD_EnablePasswordChange
;_AD_DisablePasswordChange
;_AD_UnlockObject
;_AD_DisableObject
;_AD_EnableObject
;_AD_GetPasswordInfo
;_AD_ListExchangeServers
;_AD_ListExchangeMailboxStores
;_AD_GetSystemInfo
;_AD_GetManagedBy
;_AD_GetManager
;_AD_GetGroupAdmins
;_AD_GroupManagerCanModify
;_AD_ListPrintQueues
;_AD_SetGroupManagerCanModify
;_AD_GroupAssignManager
;_AD_GroupRemoveManager
;_AD_AddEmailAddress
;_AD_JoinDomain
;_AD_UnjoinDomain
;_AD_SetPasswordExpire
;_AD_CreateMailbox
;_AD_DeleteMailbox
;_AD_MailEnableGroup
;_AD_IsAccountExpired
;_AD_GetAccountsExpired
;_AD_ListSchemaVersions
;_AD_ObjectExistsInSchema
;_AD_GetLastADSIError
; ===============================================================================================================================
; #INTERNAL_USE_ONLY#============================================================================================================
;_AD_Int8ToSec
;_AD_LargeInt2Double
;_AD_ObjGet
;_AD_ErrorHandler
;_AD_FixSpecialChars
;_AD_ReorderACE
;_AD_GetLastLDAPError
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_Open
; Description ...: Opens a connection to Active Directory.
; Syntax.........: _AD_Open([$sAD_UserIdParam = "", $sAD_PasswordParam = ""[, $sAD_DNSDomainParam = "", $sAD_HostServerParam = "", $sAD_ConfigurationParam = ""]])
; Parameters ....: $sAD_UserIdParam - Optional: UserId credential for authentication. This has to be a valid domain user
;                  $sAD_PasswordParam - Optional: Password for authentication
;                  $sAD_DNSDomainParam - Optional: Active Directory domain name if you want to connect to an alternate domain
;                  $sAD_HostServerParam - Optional: Name of Domain Controller if you want to connect to a different domain
;                  $sAD_ConfigurationParam - Optional: Configuration naming context if you want to connect to a different domain
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - Installation of the custom error handler failed. @extended returns error code from ObjEvent
;                  |2 - Creation of the COM object to the AD failed. @extended returns error code from ObjCreate
;                  |3 - Open the connection to AD failed. @extended returns error code of the COM error handler.
;                  |    Generated if the User doesn't have query / modify access
;                  |4 - Creation of the RootDSE object failed. @extended returns the error code received by the COM error handler.
;                  |    Generated when connection to the domain isn't successful. @extended returns -2147023541 (0x8007054B)
;                  |5 - Creation of the DS object failed. @extended returns the error code received by the COM error handler
;                  |6 - Parameter $sAD_HostServerParam and $sAD_ConfigurationParam are required when $sAD_DNSDomainParam is specified
;                  |7 - Parameter $sAD_PasswordParam is required when $sAD_UserIdParam is specified
;                  |8 - OpenDSObject method failed. @extended set to error code received by the COM error handler (decimal).
;                  |    On Windows XP or lower this shows that $sAD_UserIdParam and/or $sAD_PasswordParam are invalid
;                  |x - For Windows Vista and later: Win32 error code (decimal). To get detailed error information call function _AD_GetLastADSIError
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: To close the connection to the Active Directory, use the _AD_Close function.
;+
;                  _AD_Open will use the alternative credentials $sAD_UserIdParam and $sAD_PasswordParam if passed as parameters.
;                  $sAD_UserIdParam has to be in one of the following forms (assume the samAccountName = DJ)
;                  * Windows Login Name   e.g. "DJ"
;                  * NetBIOS Login Name   e.g. "<DOMAIN>\DJ"
;                  * User Principal Name  e.g. "DJ@domain.com"
;                  All other name formats have NOT been successfully tested (see section "Link").
;+
;                  Connection to an alternate domain (not the domain your computer is a member of) or your computer is not a domain member
;                  requires $sAD_DNSDomainParam, $sAD_HostServerParam and $sAD_ConfigurationParam as FQDN as well as $sAD_UserIdParam and $sAD_PasswordParam.
;                  Example:
;                  $sAD_DNSDomainParam = "DC=subdomain,DC=example,DC=com"
;                  $sAD_HostServerParam = "servername.subdomain.example.com"
;                  $sAD_ConfigurationParam = "CN=Configuration,DC=subdomain,DC=example,DC=com"
;+
;                  The COM error handler will be initialised if no error handler exists.
;                  Be aware that some functions will not work correctly because they handle error codes ($iAD_COMError) that are set by the error handler.
;+
;                  If you specify $sAD_UserIdParam as NetBIOS Login Name or User Principal Name and the OS is Windows Vista or later then _AD_Open will try to
;                  verify the userid/password.
;                  @error will be set to the Win32 error code (decimal). To get detailed error information please call _AD_GetlastADSIError.
;                  For all other OS or if userid is specified as Windows Login Name @error=8.
;                  This is OS dependant because Windows XP doesn't return useful error information.
;                  For Windows Login Name all OS return success even when an error occures. This seems to be caused by secure authentification.
; Related .......: _AD_Close
; Link ..........: http://msdn.microsoft.com/en-us/library/cc223499(PROT.10).aspx (Simple Authentication), http://msdn.microsoft.com/en-us/library/aa746471(VS.85).aspx (ADO)
; Example .......: Yes
; ===============================================================================================================================
Func _AD_Open($sAD_UserIdParam = "", $sAD_PasswordParam = "", $sAD_DNSDomainParam = "", $sAD_HostServerParam = "", $sAD_ConfigurationParam = "")

	; A COM error handler will be initialised only if one does not exist.
	If ObjEvent("AutoIt.Error") = "" Then
		$oAD_MyError = ObjEvent("AutoIt.Error", "_AD_ErrorHandler") ; Creates a custom error handler
		If @error <> 0 Then Return SetError(1, @error, 0)
	EndIf
	$iAD_COMError = 0
	$oAD_Connection = ObjCreate("ADODB.Connection") ; Creates a COM object to AD
	If Not IsObj($oAD_Connection) Or @error <> 0 Then Return SetError(2, @error, 0)
	; ConnectionString Property (ADO): http://msdn.microsoft.com/en-us/library/ms675810.aspx
	$oAD_Connection.ConnectionString = "Provider=ADsDSOObject" ; Sets Service providertype
	If $sAD_UserIdParam <> "" Then
		If $sAD_PasswordParam = "" Then Return SetError(7, 0, 0)
		$oAD_Connection.Properties("User ID") = $sAD_UserIdParam ; Authenticate User
		$oAD_Connection.Properties("Password") = $sAD_PasswordParam ; Authenticate User
		$oAD_Connection.Properties("Encrypt Password") = True ; Encrypts userid and password
		; If userid is the Windows login name then set the flag for secure authentification
		If StringInStr($sAD_UserIdParam, "\") = 0 And StringInStr($sAD_UserIdParam, "@") = 0 Then
			$bAD_BindFlags = BitOR($ADS_SECURE_AUTH, $ADS_SERVER_BIND, $ADS_USE_ENCRYPTION)
			$oAD_Connection.Properties("ADSI Flag") = $bAD_BindFlags
		Else
			$bAD_BindFlags = BitOR($ADS_SERVER_BIND, $ADS_USE_ENCRYPTION)
			$oAD_Connection.Properties("ADSI Flag") = $bAD_BindFlags
		EndIf
		$sAD_UserId = $sAD_UserIdParam
		$sAD_Password = $sAD_PasswordParam
	EndIf
	; ADO Open Method: http://msdn.microsoft.com/en-us/library/ms676505.aspx
	$oAD_Connection.Open() ; Open connection to AD
	If @error <> 0 Then Return SetError(3, @error, 0)
	; Connect to another Domain if the Domain parameter is provided
	If $sAD_DNSDomainParam <> "" Then
		If $sAD_HostServerParam = "" Or $sAD_ConfigurationParam = "" Then Return SetError(6, 0, 0)
		$oAD_RootDSE = ObjGet("LDAP://" & $sAD_HostServerParam & "/RootDSE")
		If Not IsObj($oAD_RootDSE) Or @error <> 0 Then Return SetError(4, @error, 0)
		$sAD_DNSDomain = $sAD_DNSDomainParam
		$sAD_HostServer = $sAD_HostServerParam
		$sAD_Configuration = $sAD_ConfigurationParam
	Else
		$oAD_RootDSE = ObjGet("LDAP://RootDSE")
		If Not IsObj($oAD_RootDSE) Or @error <> 0 Then Return SetError(4, @error, 0)
		$sAD_DNSDomain = $oAD_RootDSE.Get("defaultNamingContext") ; Retrieve the current AD domain name
		$sAD_HostServer = $oAD_RootDSE.Get("dnsHostName") ; Retrieve the name of the connected DC
		$sAD_Configuration = $oAD_RootDSE.Get("ConfigurationNamingContext") ; Retrieve the Configuration naming context
		$oAD_RootDSE = ObjGet("LDAP://" & $sAD_HostServer & "/RootDSE") ; To guarantee a persistant binding
	EndIf
	; Check userid/password if provided
	If $sAD_UserIdParam <> "" Then
		$oAD_OpenDS = ObjGet("LDAP:")
		If Not IsObj($oAD_OpenDS) Or @error <> 0 Then Return SetError(5, @error, 0)
		$oAD_Bind = $oAD_OpenDS.OpenDSObject("LDAP://" & $sAD_HostServer, $sAD_UserIdParam, $sAD_PasswordParam, $bAD_BindFlags)
		If Not IsObj($oAD_Bind) Or @error <> 0 Then ; login error occurred - get extended information
			Local $sAD_Hive = "HKLM"
			If @OSArch = "IA64" Or @OSArch = "X64" Then $sAD_Hive = "HKLM64"
			Local $sAD_OSVersion = RegRead($sAD_Hive & "\SOFTWARE\Microsoft\Windows NT\CurrentVersion", "CurrentVersion")
			$sAD_OSVersion = StringSplit($sAD_OSVersion, ".")
			If Int($sAD_OSVersion[1]) >= 6 Then ; Delivers detailed error information for Windows Vista and later if debugging is activated
				Local $aAD_Errors = _AD_GetLastADSIError()
				If $aAD_Errors[4] <> 0 Then
					If $iAD_Debug = 1 Then ConsoleWrite("_AD_Open: " & _ArrayToString($aAD_Errors, @CRLF, 1) & @CRLF)
					If $iAD_Debug = 2 Then MsgBox(64, "Active Directory Functions - Debug Info - _AD_Open", _ArrayToString($aAD_Errors, @CRLF, 1))
					If $iAD_Debug = 3 Then FileWrite("AD_Debug.txt", @YEAR & "." & @MON & "." & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC & " " & @CRLF & _
							"-------------------" & @CRLF & "_AD_Open: " & _ArrayToString($aAD_Errors, @CRLF, 1) & @CRLF & _
							"========================================================" & @CRLF)
					Return SetError(Dec($aAD_Errors[4]), 0, 0)
				EndIf
				Return SetError(8, $iAD_COMErrorDec, 0)
			Else
				Return SetError(8, $iAD_COMErrorDec, 0)
			EndIf
		EndIf
	EndIf
	Return 1

EndFunc   ;==>_AD_Open

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_Close
; Description ...: Closes the connection established to Active Directory by _AD_Open.
; Syntax.........: _AD_Close()
; Parameters ....: None
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - Closing the connection to the AD failed. @extended returns the error code received by the COM error handler
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......:
; Related .......: _AD_Open
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_Close()

	$oAD_Connection.Close() ; Close Connection
	; Reset all Global Variables
	$iAD_Debug = 0
	$oAD_MyError = 0
	$iAD_COMError = 0
	$iAD_COMErrorDec = 0
	$oAD_Connection = 0
	$sAD_DNSDomain = ""
	$sAD_HostServer = ""
	$sAD_Configuration = ""
	$oAD_OpenDS = 0
	$oAD_RootDSE = 0
	$sAD_UserId = ""
	$sAD_Password = ""
	If @error <> 0 Then Return SetError(1, @error, 0) ; Error returned by connection close
	Return 1

EndFunc   ;==>_AD_Close

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_SamAccountNameToFQDN
; Description ...: Returns a Fully Qualified Domain Name (FQDN) from a SamAccountName.
; Syntax.........: _AD_SamAccountNameToFQDN([$sAD_SamAccountName = @UserName])
; Parameters ....: $sAD_SamAccountName - Optional: Security Accounts Manager (SAM) account name (default = @UserName)
; Return values .: Success - Fully Qualified Domain Name (FQDN)
;                  Failure - "", sets @error to:
;                  |1 - No record returned from Active Directory. $sAD_SamAccountName not found
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: A $ sign must be appended to the computer name to generate the FQDN for a sAMAccountName e.g. @ComputerName & "$".
;                  The function escapes the following special characters (# and /). Commas in CN= or OU= have to be escaped by you.
; Related .......: _AD_FQDNToSamAccountName
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_SamAccountNameToFQDN($sAD_SamAccountName = @UserName)

	Local $sAD_FQDN
	Local $sAD_Query = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(sAMAccountName=" & $sAD_SamAccountName & ");distinguishedName;subtree"
	Local $oAD_RecordSet = $oAD_Connection.Execute($sAD_Query)
	If Not IsObj($oAD_RecordSet) Or $oAD_RecordSet.RecordCount = 0 Then Return SetError(1, 0, "")
	$sAD_FQDN = $oAD_RecordSet.fields(0).value
	Return _AD_FixSpecialChars($sAD_FQDN, 0, "/#")

EndFunc   ;==>_AD_SamAccountNameToFQDN

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_FQDNToSamAccountName
; Description ...: Returns the SamAccountName of a Fully Qualified Domain Name (FQDN).
; Syntax.........: _AD_FQDNToSamAccountName($sAD_FQDN)
; Parameters ....: $sAD_FQDN - Fully Qualified Domain Name (FQDN)
; Return values .: Success - SamAccountName
;                  Failure - "", sets @error to:
;                  |1 - No record returned from Active Directory. $sAD_FQDN not found
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: You have to escape commas in $sAD_FQDN with a backslash. E.g. "CN=Lastname\, Firstname,OU=..."
;                  All other special characters (# and /) are escaped by the function.
; Related .......: _AD_SamAccountNameToFQDN, _AD_FQDNToDisplayname
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_FQDNToSamAccountName($sAD_FQDN)

	$sAD_FQDN = _AD_FixSpecialChars($sAD_FQDN, 0, "/#") ; Escape special characters in the FQDN
	Local $oAD_Object = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_FQDN)
	If Not IsObj($oAD_Object) Or $oAD_Object = 0 Then Return SetError(1, 0, "")
	Local $sAD_Result = $oAD_Object.sAMAccountName
	Return $sAD_Result

EndFunc   ;==>_AD_FQDNToSamAccountName

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_FQDNToDisplayname
; Description ...: Returns the Display Name of a Fully Qualified Domain Name (FQDN) object.
; Syntax.........: _AD_FQDNToDisplayname($sAD_FQDN)
; Parameters ....: $sAD_FQDN - Fully Qualified Domain Name (FQDN)
; Return values .: Success - Display Name
;                  Failure - "", sets @error to:
;                  |1 - No object returned from Active Directory. $sAD_FQDN not found
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: You must escape commas in $sAD_FQDN with a backslash. E.g. "CN=Lastname\, Firstname,OU=..."
;                  All other special characters (# and /) are escaped by the function.
;                  The function removes all escape characters (\) from the returned value.
; Related .......: _AD_FQDNToSamAccountName
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_FQDNToDisplayname($sAD_FQDN)

	$sAD_FQDN = _AD_FixSpecialChars($sAD_FQDN, 0, "/#") ; Escape special characters in the FQDN
	Local $oAD_Item = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_FQDN)
	If IsObj($oAD_Item) Then
		Local $sAD_Name = $oAD_Item.name
		Return _AD_FixSpecialChars(StringTrimLeft($sAD_Name, 3), 1)
	Else
		Return SetError(1, 0, "")
	EndIf

EndFunc   ;==>_AD_FQDNToDisplayname

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_ObjectExists
; Description ...: Returns 1 if exactly one object exists for the given property in the local Active Directory Tree.
; Syntax.........: _AD_ObjectExists([$sAD_Object = @UserName[, $sAD_Property = ""]])
; Parameters ....: $sAD_Object   - Optional: Object (user, computer, group, OU) to check (default = @UserName)
;                  $sAD_Property - Optional: Property to check. If omitted the function tries to determine whether to use sAMAccountname or FQDN
; Return values .: Success - 1, Exactly one object exists for the given property in the local Active Directory Tree
;                  Failure - 0, sets @error to:
;                  |1 - No object found for the specified property
;                  |x - More than one object found for the specified property. x is the number of objects found
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: Checking on a computer account requires a "$" (dollar) appended to the sAMAccountName.
;                  To check the existence of an OU use the FQDN of the OU as first parameter because an OU has no SamAccountName.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_ObjectExists($sAD_Object = @UserName, $sAD_Property = "")

	If $sAD_Property = "" Then
		$sAD_Property = "samAccountName"
		If StringMid($sAD_Object, 3, 1) = "=" Then $sAD_Property = "distinguishedName"
	EndIf
	Local $sAD_Query = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(" & $sAD_Property & "=" & $sAD_Object & ");ADsPath;subtree"
	Local $oAD_RecordSet = $oAD_Connection.Execute($sAD_Query) ; Retrieve the ADsPath for the object, if it exists
	If IsObj($oAD_RecordSet) Then
		If $oAD_RecordSet.RecordCount = 1 Then
			Return 1
		ElseIf $oAD_RecordSet.RecordCount > 1 Then
			Return SetError($oAD_RecordSet.RecordCount, 0, 0)
		Else
			Return SetError(1, 0, 0)
		EndIf
	Else
		Return SetError(1, 0, 0)
	EndIf

EndFunc   ;==>_AD_ObjectExists

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_GetObjectAttribute
; Description ...: Returns the specified attribute for the named object.
; Syntax.........: _AD_GetObjectAttribute($sAD_Object, $sAD_Attribute)
; Parameters ....: $sAD_Object - sAMAccountName or FQDN of the object the attribute should be retrieved from
;                  $sAD_Attribute - Attribute to be retrieved
; Return values .: Success - Value for the given attribute
;                  Failure - "", sets @error to:
;                  |1 - $sAD_Object does not exist
;                  |2 - $sAD_Attribute does not exist for $sAD_Object
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: If the attribute is a single-value the function returns a string otherwise it returns an array.
;                  To get decrypted attributes (GUID, SID, dates etc.) please see _AD_GetObjectProperties.
; Related .......: _AD_ModifyAttribute, _AD_GetObjectProperties
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_GetObjectAttribute($sAD_Object, $sAD_Attribute)

	Local $sAD_Property = "sAMAccountName"
	If StringMid($sAD_Object, 3, 1) = "=" Then $sAD_Property = "distinguishedName" ; FQDN provided
	If _AD_ObjectExists($sAD_Object, $sAD_Property) = 0 Then Return SetError(1, 0, "")
	Local $sAD_Query = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(" & $sAD_Property & "=" & $sAD_Object & ");ADsPath;subtree"
	Local $oAD_RecordSet = $oAD_Connection.Execute($sAD_Query) ; Retrieve the ADsPath for the object
	If Not IsObj($oAD_RecordSet) Or $oAD_RecordSet.RecordCount = 0 Then Return SetError(2, 0, "")
	Local $sAD_LDAPEntry = $oAD_RecordSet.fields(0).value
	Local $oAD_Object = _AD_ObjGet($sAD_LDAPEntry) ; Retrieve the COM Object for the object
	Local $sAD_Result = $oAD_Object.Get($sAD_Attribute)
	$oAD_Object.PurgePropertyList
	If $iAD_COMError = 3 Then
		$iAD_COMError = 0
		Return SetError(2, 0, "")
	EndIf
	If IsArray($sAD_Result) Then _ArrayInsert($sAD_Result, 0, UBound($sAD_Result, 1))
	Return $sAD_Result

EndFunc   ;==>_AD_GetObjectAttribute

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_IsMemberOf
; Description ...: Returns 1 if the object (user, group, computer) is an immediate member of the group.
; Syntax.........: _AD_IsMemberOf($sAD_Group[, $sAD_Object = @Username[, $fAD_IncludePrimaryGroup = 0]])
; Parameters ....: $sAD_Group - Group to be checked for membership. Can be specified as sAMAccountName or Fully Qualified Domain Name (FQDN)
;                  $sAD_Object - Optional: Object type (user, group, computer) to check for membership of $sAD_Group. Can be specified as sAMAccountName or Fully Qualified Domain Name (FQDN) (default = @UserName)
;                  $fAD_IncludePrimaryGroup - Optional: Additionally checks the primary group for object membership (default = 0)
; Return values .: Success - 1, Specified object (user, group, computer) is a member of the specified group
;                  Failure - 0, @error set
;                  |0 - $sAD_Object is not a member of $sAD_Group
;                  |1 - $sAD_Group does not exist
;                  |2 - $sAD_Object does not exist
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: Determines if the object is an immediate member of the group. This function does not verify membership in any nested groups.
; Related .......: _AD_GetUserGroups, _AD_GetUserPrimaryGroup, _AD_RecursiveGetMemberOf
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_IsMemberOf($sAD_Group, $sAD_Object = @UserName, $fAD_IncludePrimaryGroup = False)

	If _AD_ObjectExists($sAD_Group) = 0 Then Return SetError(1, 0, 0)
	If _AD_ObjectExists($sAD_Object) = 0 Then Return SetError(2, 0, 0)
	If StringMid($sAD_Object, 3, 1) <> "=" Then $sAD_Object = _AD_SamAccountNameToFQDN($sAD_Object) ; sAMAccountName provided
	If StringMid($sAD_Group, 3, 1) <> "=" Then $sAD_Group = _AD_SamAccountNameToFQDN($sAD_Group) ; sAMAccountName provided
	Local $oAD_Group = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_Group)
	Local $iAD_Result = $oAD_Group.IsMember("LDAP://" & $sAD_HostServer & "/" & $sAD_Object)
	; Check Primary Group if $sAD_Oject isn't a member of the specified group and the flag is set
	If $iAD_Result = 0 And $fAD_IncludePrimaryGroup Then $iAD_Result = (_AD_GetUserPrimaryGroup($sAD_Object) = $sAD_Group)
	; Abs is necessary to make it work for AutoIt versions < 3.3.2.0 with bug #1068
	Return Abs($iAD_Result)

EndFunc   ;==>_AD_IsMemberOf

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_HasFullRights
; Description ...: Returns 1 if the given user has full rights over the given group or user.
; Syntax.........: _AD_HasFullRights($sAD_Object[, $sAD_User = @UserName])
; Parameters ....: $sAD_Object - Group or User to be checked. Can be specified as Fully Qualified Domain Name (FQDN) or sAMAccountName
;                  $sAD_User - Optional: User to be checked. Can be specified as Fully Qualified Domain Name (FQDN) or SamAccountName (default = @UserName)
; Return values .: Success - 1, Specified user has full rights over the given group or user
;                  Failure - 0, @error set
;                  |0 - $sAD_User does not have full rights over $sAD_Object
;                  |1 - $sAD_User does not exist
;                  |2 - $sAD_Object does not exist
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......:
; Related .......: _AD_HasUnlockResetRights, _AD_HasRequiredRights, _AD_HasGroupUpdateRights
; Link ..........: http://msdn.microsoft.com/en-us/library/aa772285(VS.85).aspx (ADS_RIGHTS_ENUM Enumeration)
; Example .......: Yes
; ===============================================================================================================================
Func _AD_HasFullRights($sAD_Object, $sAD_User = @UserName)

	If _AD_ObjectExists($sAD_User) = 0 Then Return SetError(1, 0, 0)
	If _AD_ObjectExists($sAD_Object) = 0 Then Return SetError(2, 0, 0)
	If StringMid($sAD_Object, 3, 1) <> "=" Then $sAD_Object = _AD_SamAccountNameToFQDN($sAD_Object) ; sAMAccountName provided
	Local $aAD_MemberOf, $aAD_TrusteeArray, $sAD_TrusteeGroup
	$aAD_MemberOf = _AD_GetUserGroups($sAD_User, 1)
	Local $oAD_Object = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_Object)
	If IsObj($oAD_Object) Then
		Local $oAD_Security = $oAD_Object.Get("ntSecurityDescriptor")
		Local $oAD_DACL = $oAD_Security.DiscretionaryAcl
		For $oAD_ACE In $oAD_DACL
			$aAD_TrusteeArray = StringSplit($oAD_ACE.Trustee, "\")
			$sAD_TrusteeGroup = $aAD_TrusteeArray[$aAD_TrusteeArray[0]]
			For $iCount1 = 0 To UBound($aAD_MemberOf) - 1
				If StringInStr($aAD_MemberOf[$iCount1], "CN=" & $sAD_TrusteeGroup & ",") And _
						$oAD_ACE.AccessMask = $ADS_FULL_RIGHTS Then Return 1
			Next
		Next
	EndIf
	Return 0

EndFunc   ;==>_AD_HasFullRights

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_HasUnlockResetRights
; Description ...: Returns 1 if the given user has unlock and password reset rights on the object.
; Syntax.........: _AD_HasUnlockResetRights($sAD_Object[, $sAD_User = @UserName])
; Parameters ....: $sAD_Object - Group or User to be checked. Can be specified as Fully Qualified Domain Name (FQDN) or sAMAccountName
;                  $sAD_User - Optional: User to be checked. Can be specified as Fully Qualified Domain Name (FQDN) or SamAccountName (default = @UserName)
; Return values .: Success - 1, Specified user has unlock and password reset rights over the given group or user
;                  Failure - 0, @error set
;                  |0 - $sAD_User does not have unlock and password reset rights over $sAD_Object
;                  |1 - $sAD_User does not exist
;                  |2 - $sAD_Object does not exist
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......:
; Related .......: _AD_HasFullRights, _AD_HasRequiredRights, _AD_HasGroupUpdateRights
; Link ..........: http://msdn.microsoft.com/en-us/library/aa772285(VS.85).aspx (ADS_RIGHTS_ENUM Enumeration)
; Example .......: Yes
; ===============================================================================================================================
Func _AD_HasUnlockResetRights($sAD_Object, $sAD_User = @UserName)

	If _AD_ObjectExists($sAD_User) = 0 Then Return SetError(1, 0, 0)
	If _AD_ObjectExists($sAD_Object) = 0 Then Return SetError(2, 0, 0)
	If StringMid($sAD_Object, 3, 1) <> "=" Then $sAD_Object = _AD_SamAccountNameToFQDN($sAD_Object) ; sAMAccountName provided
	Local $aAD_MemberOf, $aAD_TrusteeArray, $sAD_TrusteeGroup
	$aAD_MemberOf = _AD_GetUserGroups($sAD_User, 1)
	Local $oAD_Object = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_Object)
	If IsObj($oAD_Object) Then
		Local $oAD_Security = $oAD_Object.Get("ntSecurityDescriptor")
		Local $oAD_DACL = $oAD_Security.DiscretionaryAcl
		For $oAD_ACE In $oAD_DACL
			$aAD_TrusteeArray = StringSplit($oAD_ACE.Trustee, "\")
			$sAD_TrusteeGroup = $aAD_TrusteeArray[$aAD_TrusteeArray[0]]
			For $iCount1 = 0 To UBound($aAD_MemberOf) - 1
				If StringInStr($aAD_MemberOf[$iCount1], "CN=" & $sAD_TrusteeGroup & ",") And _
						BitAND($oAD_ACE.AccessMask, $ADS_USER_UNLOCKRESETACCOUNT) = $ADS_USER_UNLOCKRESETACCOUNT Then Return 1
			Next
		Next
	EndIf
	Return 0

EndFunc   ;==>_AD_HasUnlockResetRights

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_HasRequiredRights
; Description ...: Returns 1 if the given user has the required rights on the object.
; Syntax.........: _AD_HasRequiredRights($sAD_Object[, $iAD_Right = 983551[, $sAD_User = @UserName]])
; Parameters ....: $sAD_Object - Group or User to be checked. Can be specified as Fully Qualified Domain Name (FQDN) or sAMAccountName
;                  $sAD_Right - Optional: Access mask constant to be checked (default = 983551 (Full rights)).
;                  |Full rights is the combination of the following rights:
;                  |ADS_RIGHT_DELETE                   = 0x10000
;                  |ADS_RIGHT_READ_CONTROL             = 0x20000
;                  |ADS_RIGHT_WRITE_DAC                = 0x40000
;                  |ADS_RIGHT_WRITE_OWNER              = 0x80000
;                  |ADS_RIGHT_DS_CREATE_CHILD          = 0x1
;                  |ADS_RIGHT_DS_DELETE_CHILD          = 0x2
;                  |ADS_RIGHT_ACTRL_DS_LIST            = 0x4
;                  |ADS_RIGHT_DS_SELF                  = 0x8
;                  |ADS_RIGHT_DS_READ_PROP             = 0x10
;                  |ADS_RIGHT_DS_WRITE_PROP            = 0x20
;                  |ADS_RIGHT_DS_DELETE_TREE           = 0x40
;                  |ADS_RIGHT_DS_LIST_OBJECT           = 0x80
;                  |ADS_RIGHT_DS_CONTROL_ACCESS        = 0x100
;                  $sAD_User - Optional: User to be checked. Can be specified as Fully Qualified Domain Name (FQDN) or SamAccountName (default = @UserName)
; Return values .: Success - 1, Specified user has the required rights over the given group or user
;                  Failure - 0, @error set
;                  |0 - $sAD_User does not have the required rights over $sAD_Object
;                  |1 - $sAD_User does not exist
;                  |2 - $sAD_Object does not exist
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......:
; Related .......: _AD_HasFullRights, _AD_HasUnlockResetRights, _AD_HasGroupUpdateRights
; Link ..........: http://msdn.microsoft.com/en-us/library/aa772285(VS.85).aspx (ADS_RIGHTS_ENUM Enumeration)
; Example .......: Yes
; ===============================================================================================================================
Func _AD_HasRequiredRights($sAD_Object, $iAD_Right = 983551, $sAD_User = @UserName)

	If _AD_ObjectExists($sAD_User) = 0 Then Return SetError(1, 0, 0)
	If _AD_ObjectExists($sAD_Object) = 0 Then Return SetError(2, 0, 0)
	If StringMid($sAD_Object, 3, 1) <> "=" Then $sAD_Object = _AD_SamAccountNameToFQDN($sAD_Object) ; sAMAccountName provided
	Local $aAD_MemberOf, $aAD_TrusteeArray, $sAD_TrusteeGroup
	$aAD_MemberOf = _AD_GetUserGroups($sAD_User, 1)
	Local $oAD_Object = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_Object)
	If IsObj($oAD_Object) Then
		Local $oAD_Security = $oAD_Object.Get("ntSecurityDescriptor")
		Local $oAD_DACL = $oAD_Security.DiscretionaryAcl
		For $oAD_ACE In $oAD_DACL
			$aAD_TrusteeArray = StringSplit($oAD_ACE.Trustee, "\")
			$sAD_TrusteeGroup = $aAD_TrusteeArray[$aAD_TrusteeArray[0]]
			For $iCount1 = 0 To UBound($aAD_MemberOf) - 1
				If StringInStr($aAD_MemberOf[$iCount1], "CN=" & $sAD_TrusteeGroup & ",") And _
						BitAND($oAD_ACE.AccessMask, $iAD_Right) = $iAD_Right Then Return 1
			Next
		Next
	EndIf
	Return 0

EndFunc   ;==>_AD_HasRequiredRights

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_HasGroupUpdateRights
; Description ...: Returns 1 if the given user has rights to update the group membership of the object.
; Syntax.........: _AD_HasGroupUpdateRights($sAD_Object[, $sAD_User = @UserName])
; Parameters ....: $sAD_Object - Group to be checked. Can be specified as Fully Qualified Domain Name (FQDN) or sAMAccountName
;                  $sAD_User - Optional: User to be checked. Can be specified as Fully Qualified Domain Name (FQDN) or SamAccountName (default = @UserName)
; Return values .: Success - 1, Specified user has the rights to update the group membership on the given group
;                  Failure - 0, @error set
;                  |0 - $sAD_User does not have the rights to update the group membership on $sAD_Object
;                  |1 - $sAD_User does not exist
;                  |2 - $sAD_Object does not exist
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......:
; Related .......: _AD_HasFullRights, _AD_HasUnlockResetRights, _AD_HasRequiredRights
; Link ..........: http://msdn.microsoft.com/en-us/library/aa772285(VS.85).aspx (ADS_RIGHTS_ENUM Enumeration)
; Example .......: Yes
; ===============================================================================================================================
Func _AD_HasGroupUpdateRights($sAD_Object, $sAD_User = @UserName)

	If _AD_ObjectExists($sAD_User) = 0 Then Return SetError(1, 0, 0)
	If _AD_ObjectExists($sAD_Object) = 0 Then Return SetError(2, 0, 0)
	If StringMid($sAD_Object, 3, 1) <> "=" Then $sAD_Object = _AD_SamAccountNameToFQDN($sAD_Object) ; sAMAccountName provided
	Local $aAD_MemberOf, $aAD_TrusteeArray, $sAD_TrusteeGroup
	$aAD_MemberOf = _AD_GetUserGroups($sAD_User, 1)
	Local $oAD_Object = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_Object)
	If IsObj($oAD_Object) Then
		Local $oAD_Security = $oAD_Object.Get("ntSecurityDescriptor")
		Local $oAD_DACL = $oAD_Security.DiscretionaryAcl
		For $oAD_ACE In $oAD_DACL
			$aAD_TrusteeArray = StringSplit($oAD_ACE.Trustee, "\")
			$sAD_TrusteeGroup = $aAD_TrusteeArray[$aAD_TrusteeArray[0]]
			For $iCount1 = 0 To UBound($aAD_MemberOf) - 1
				If StringInStr($aAD_MemberOf[$iCount1], "CN=" & $sAD_TrusteeGroup & ",") And _
						BitAND($oAD_ACE.AccessMask, $ADS_OBJECT_READWRITE_ALL) = $ADS_OBJECT_READWRITE_ALL Then Return 1
			Next
		Next
	EndIf
	Return 0

EndFunc   ;==>_AD_HasGroupUpdateRights

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_GetObjectClass
; Description ...: Returns the main class (also called structural class) of an object ("user", "group" etc.).
; Syntax.........: _AD_GetObjectClass($sAD_Object[, $fAD_All = 0])
; Parameters ....: $sAD_Object - Object for which the main class should be returned. Can be specified as Fully Qualified Domain Name (FQDN) or sAMAccountName
;                  $fAD_All - Optional: Returns the main class plus the superior classes from which the main class is deduced hierarchically (default = 0)
; Return values .: Success - Main class of the specified object if $fAD_All = 0 or an zero-based array of the main plus the superior classes if $fAD_All = 1
;                  Failure - "", sets @error to:
;                  |1 - Specified object does not exist
;                  |2 - The LDAP query returned no record
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_GetObjectClass($sAD_Object, $fAD_All = 0)

	If _AD_ObjectExists($sAD_Object) = 0 Then Return SetError(1, 0, "")
	Local $sAD_Property = "sAMAccountName"
	If StringMid($sAD_Object, 3, 1) = "=" Then $sAD_Property = "distinguishedName" ; FQDN provided
	Local $sAD_Query = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(" & $sAD_Property & "=" & $sAD_Object & ");ADsPath;subtree"
	Local $oAD_RecordSet = $oAD_Connection.Execute($sAD_Query) ; Retrieve the ADsPath for the object
	If Not IsObj($oAD_RecordSet) Then Return SetError(2, 0, "")
	Local $sAD_LDAPEntry = $oAD_RecordSet.fields(0).value
	Local $oAD_Object = _AD_ObjGet($sAD_LDAPEntry) ; Retrieve the COM Object for the object
	If $fAD_All Then Return $oAD_Object.ObjectClass
	Return $oAD_Object.Class

EndFunc   ;==>_AD_GetObjectClass

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_GetUserGroups
; Description ...: Returns an array of group names that the user is immediately a member of.
; Syntax.........: _AD_GetUserGroups([$sAD_User = @UserName[, $fAD_IncludePrimaryGroup = 0]])
; Parameters ....: $sAD_User - Optional: User for which the group membership is to be returned (default = @Username). Can be specified as Fully Qualified Domain Name (FQDN) or sAMAccountName
;                  $fAD_IncludePrimaryGroup - Optional: include the primary group to the return list (default = 0)
; Return values .: Success - One-based one dimensional array of group names (FQDN) the user is a member of
;                  Failure - "", sets @error to:
;                  |1 - Specified user does not exist
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: Works for computers or groups as well.
; Related .......: _AD_IsMemberOf, _AD_GetUserPrimaryGroup, _AD_RecursiveGetMemberOf
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_GetUserGroups($sAD_User = @UserName, $fAD_IncludePrimaryGroup = 0)

	If _AD_ObjectExists($sAD_User) = 0 Then Return SetError(1, 0, "")
	Local $sAD_Property = "sAMAccountName"
	If StringMid($sAD_User, 3, 1) = "=" Then $sAD_Property = "distinguishedName" ; FQDN provided
	Local $sAD_Query = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(" & $sAD_Property & "=" & $sAD_User & ");ADsPath;subtree"
	Local $oAD_RecordSet = $oAD_Connection.Execute($sAD_Query) ; Retrieve the FQDN for the logged on user
	Local $sAD_LDAPEntry = $oAD_RecordSet.fields(0).value
	Local $oAD_Object = _AD_ObjGet($sAD_LDAPEntry) ; Retrieve the COM Object for the logged on user
	Local $aAD_Groups = $oAD_Object.GetEx("memberof")
	If $fAD_IncludePrimaryGroup Then _ArrayAdd($aAD_Groups, _AD_GetUserPrimaryGroup($sAD_User))
	_ArrayInsert($aAD_Groups, 0, UBound($aAD_Groups))
	Return $aAD_Groups

EndFunc   ;==>_AD_GetUserGroups

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_GetUserPrimaryGroup
; Description ...: Returns the primary group the user is assigned to.
; Syntax.........: _AD_GetUserPrimaryGroup([$sAD_User = @UserName])
; Parameters ....: $sAD_User - Optional: User for which the primary group is to be returned (default = @Username). Can be specified as Fully Qualified Domain Name (FQDN) or sAMAccountName
; Return values .: Success - Primary group (FQDN) the user is assigned to.
;                  Failure - "", sets @error to:
;                  |1 - Specified user does not exist
;                  |2 - A primary group couldn't be found for the specified user
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......:
; Related .......: _AD_IsMemberOf, _AD_GetUserGroups, _AD_RecursiveGetMemberOf, _AD_SetUserPrimaryGroup
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_GetUserPrimaryGroup($sAD_User = @UserName)

	If _AD_ObjectExists($sAD_User) = 0 Then Return SetError(1, 0, "")
	Local $sAD_Property = "samAccountName"
	If StringMid($sAD_User, 3, 1) = "=" Then $sAD_Property = "distinguishedName"
	Local $sAD_Query = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(" & $sAD_Property & "=" & $sAD_User & ");ADsPath;subtree"
	Local $oAD_RecordSet = $oAD_Connection.Execute($sAD_Query) ; Retrieve the FQDN for the logged on user
	Local $sAD_LDAPEntry = $oAD_RecordSet.fields(0).value
	Local $oAD_Object = _AD_ObjGet($sAD_LDAPEntry) ; Retrieve the COM Object for the logged on user
	Local $oAD_Command = ObjCreate("ADODB.Command")
	$oAD_Command.ActiveConnection = $oAD_Connection
	$oAD_Command.Properties("Page Size") = 1000
	$oAD_Command.CommandText = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(objectCategory=group);cn,primaryGroupToken,DistinguishedName;subtree"
	$oAD_RecordSet = $oAD_Command.Execute
	While Not $oAD_RecordSet.EOF
		If $oAD_RecordSet.Fields("primaryGroupToken" ).Value = $oAD_Object.primaryGroupID Then _
				Return $oAD_RecordSet.Fields("DistinguishedName" ).Value
		$oAD_RecordSet.MoveNext
	WEnd
	Return SetError(2, 0, "")

EndFunc   ;==>_AD_GetUserPrimaryGroup

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_SetUserPrimaryGroup
; Description ...: Sets the users primary group.
; Syntax.........: _AD_SetUserPrimaryGroup($sAD_User, $sAD_Group)
; Parameters ....: $sAD_User - User for which the primary group is to be set. Can be specified as Fully Qualified Domain Name (FQDN) or sAMAccountName
;                  $sAD_Group - Group to be set as the primary group for the specified user. Can be specified as Fully Qualified Domain Name (FQDN) or sAMAccountName
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_User does not exist
;                  |2 - $sAD_Group does not exist
;                  |3 - $sAD_User must be a member of $sAD_Group
;                  |x - Error returned by SetInfo function (Missing permission etc.)
; Author ........: Tim Alderweireldt
; Modified.......:
; Remarks .......:
; Related .......: _AD_AddUserToGroup, _AD_GetUserPrimaryGroup
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_SetUserPrimaryGroup($sAD_User, $sAD_Group)

	If Not _AD_ObjectExists($sAD_User) Then Return SetError(1, 0, 0)
	If Not _AD_ObjectExists($sAD_Group) Then Return SetError(2, 0, 0)
	If Not _AD_IsMemberOf($sAD_Group, $sAD_User) Then Return SetError(3, 0, 0)
	If StringMid($sAD_Group, 3, 1) <> "=" Then $sAD_Group = _AD_SamAccountNameToFQDN($sAD_Group) ; sAMACccountName provided
	If StringMid($sAD_User, 3, 1) <> "=" Then $sAD_User = _AD_SamAccountNameToFQDN($sAD_User) ; sAMACccountName provided
	Local $oAD_User = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_User) ; Retrieve the COM Object for the user
	Local $oAD_Group = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_Group) ; Retrieve the COM Object for the group
	$oAD_Group.GetInfoEx(_ArrayCreate("primaryGroupToken"), 0)
	$oAD_User.primaryGroupID = $oAD_Group.primaryGroupToken
	$oAD_User.SetInfo()
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_SetUserPrimaryGroup

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_RecursiveGetMemberOf
; Description ...: Takes a group, user or computer and recursively returns a list of groups the object is a member of.
; Syntax.........: _AD_RecursiveGetMemberOf($sAD_Object[, $iAD_Depth = 10[, $fAD_ListInherited = TRUE[, $fAD_FQDN = TRUE]]])
; Parameters ....: $sAD_Object - User, group or computer for which the group membership is to be returned. Can be specified as Fully Qualified Domain Name (FQDN) or sAMAccountName
;                  $iAD_Depth - Optional: Maximum depth of recursion (default = 10)
;                  $fAD_ListInherited - Optional: Defines if the function returns the group(s) it was inherited from (default = TRUE)
;                  $fAD_FQDN - Optional: Specifies the attribute to be returned. TRUE = distinguishedName (FQDN), FALSE = SamAccountName (default = TRUE)
; Return values .: Success - One-based one dimensional array of group names (FQDN or sAMAccountName) the user or group is a member of
;                  Failure - "", sets @error to:
;                  |1 - Specified user, group or computer does not exist
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: This function traverses the groups that the object is immediately a member of while also checking its group membership.
;                  For groups that are inherited, the return is the FQDN or sAMAccountname of the group, user or computer, and the FQDN(s) or sAMAccountname(s) of the group(s) it
;                  was inherited from, seperated by '|'(s) if flag $fAD_ListInherited is set to TRUE.
;+
;                  If flag $fAD_ListInherited is set to FALSE then the group names are sorted and only unique groups are returned.
; Related .......: _AD_IsMemberOf, _AD_GetUserGroups, _AD_GetUserPrimaryGroup
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_RecursiveGetMemberOf($sAD_Object, $iAD_Depth = 10, $fAD_ListInherited = True, $fAD_FQDN = True)

	If _AD_ObjectExists($sAD_Object) = 0 Then Return SetError(1, 0, "")
	If StringMid($sAD_Object, 3, 1) <> "=" Then $sAD_Object = _AD_SamAccountNameToFQDN($sAD_Object) ; sAMAccountName provided
	Local $iCount1, $iCount2
	Local $sAD_Field = "distinguishedName"
	If Not $fAD_FQDN Then $sAD_Field = "samaccountname"
	Local $oAD_Command = ObjCreate("ADODB.Command")
	$oAD_Command.ActiveConnection = $oAD_Connection
	$oAD_Command.Properties("Page Size") = 1000
	$oAD_Command.Properties("Searchscope") = 2
	$oAD_Command.CommandText = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(member=" & $sAD_Object & ");" & $sAD_Field & ";subtree"
	Local $oAD_RecordSet = $oAD_Command.Execute
	Local $aAD_Groups[$oAD_RecordSet.RecordCount + 1] = [0]
	If $oAD_RecordSet.RecordCount = 0 Then Return $aAD_Groups
	$oAD_RecordSet.MoveFirst
	$iCount1 = 1
	Local $aAD_TempMemberOf[1]
	Do
		$aAD_Groups[$iCount1] = $oAD_RecordSet.Fields(0).Value
		$aAD_TempMemberOf = _AD_RecursiveGetMemberOf($aAD_Groups[$iCount1], $iAD_Depth - 1, $fAD_ListInherited, $fAD_FQDN)
		If $fAD_ListInherited Then
			For $iCount2 = 1 To $aAD_TempMemberOf[0]
				$aAD_TempMemberOf[$iCount2] &= "|" & $aAD_Groups[$iCount1]
			Next
		EndIf
		_ArrayDelete($aAD_TempMemberOf, 0)
		_ArrayConcatenate($aAD_Groups, $aAD_TempMemberOf)
		$iCount1 += 1
		$oAD_RecordSet.MoveNext
	Until $oAD_RecordSet.EOF
	$oAD_RecordSet.Close
	If $fAD_ListInherited = False Then
		_ArraySort($aAD_Groups, 0, 1)
		$aAD_Groups = _ArrayUnique($aAD_Groups, 1, 1)
	EndIf
	$aAD_Groups[0] = UBound($aAD_Groups) - 1
	Return $aAD_Groups

EndFunc   ;==>_AD_RecursiveGetMemberOf

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_GetGroupMembers
; Description ...: Returns an array of group members.
; Syntax.........: _AD_GetGroupMembers($sAD_FQDN)
; Parameters ....: $sAD_Group - Group to retrieve members from. Can be specified as Fully Qualified Domain Name (FQDN) or sAMAccountName
; Return values .: Success - One-based one dimensional array of names (FQDN) that are members of the specified group
;                  Failure - "", sets @error to:
;                  |1 - Specified group does not exist
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: If the group has no members, _AD_GetGroupMembers returns an array with one element (row count) set to 0
; Related .......: _AD_GetGroupMemberOf
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_GetGroupMembers($sAD_Group)

	If _AD_ObjectExists($sAD_Group) = 0 Then Return SetError(1, 0, "")
	If StringMid($sAD_Group, 3, 1) <> "=" Then $sAD_Group = _AD_SamAccountNameToFQDN($sAD_Group) ; sAMAccountName provided
	Local $sAD_Range, $iAD_RangeModifier, $oAD_RecordSet
	Local $oAD_Command = ObjCreate("ADODB.Command")
	$oAD_Command.ActiveConnection = $oAD_Connection
	$oAD_Command.Properties("Page Size") = 1000
	$oAD_Command.Properties("Searchscope") = 2
	Local $aAD_Members[1]
	Local $iCount1 = 0
	Local $aAD_Membersadd
	While 1
		$iAD_RangeModifier = $iCount1 * 1000
		$sAD_Range = "Range=" & $iAD_RangeModifier & "-" & $iAD_RangeModifier + 999
		$oAD_Command.CommandText = "<LDAP://" & $sAD_HostServer & "/" & $sAD_Group & ">;;member;" & $sAD_Range & ";base"
		$oAD_RecordSet = $oAD_Command.Execute
		$aAD_Membersadd = $oAD_RecordSet.fields(0).Value
		If $aAD_Membersadd = 0 Then ExitLoop
		ReDim $aAD_Members[UBound($aAD_Members) + 1000]
		For $iCount2 = $iAD_RangeModifier + 1 To $iAD_RangeModifier + 1000
			$aAD_Members[$iCount2] = $aAD_Membersadd[$iCount2 - $iAD_RangeModifier - 1]
		Next
		$iCount1 += 1
		$oAD_RecordSet.Close
		$oAD_RecordSet = 0
	WEnd
	$iAD_RangeModifier = $iCount1 * 1000
	$sAD_Range = "Range=" & $iAD_RangeModifier & "-*"
	$oAD_Command.CommandText = "<LDAP://" & $sAD_HostServer & "/" & $sAD_Group & ">;;member;" & $sAD_Range & ";base"
	$oAD_RecordSet = $oAD_Command.Execute
	$aAD_Membersadd = $oAD_RecordSet.fields(0).Value
	ReDim $aAD_Members[UBound($aAD_Members) + UBound($aAD_Membersadd)]
	For $iCount2 = $iAD_RangeModifier + 1 To $iAD_RangeModifier + UBound($aAD_Membersadd)
		$aAD_Members[$iCount2] = $aAD_Membersadd[$iCount2 - $iAD_RangeModifier - 1]
	Next
	$oAD_RecordSet.Close
	$aAD_Members[0] = UBound($aAD_Members) - 1
	Return $aAD_Members

EndFunc   ;==>_AD_GetGroupMembers

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_GetGroupMemberOf
; Description ...: Returns an array of group membership.
; Syntax.........: _AD_GetGroupMemberOf($sAD_Group)
; Parameters ....: $sAD_Group - Group for which membership in other groups is to be retrieved. Can be specified as Fully Qualified Domain Name (FQDN) or sAMAccountName
; Return values .: Success - One-based one dimensional array of group names (FQDN) that the specified group is a member of
;                  Failure - "", sets @error to:
;                  |1 - Specified group does not exist
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......:
; Related .......: _AD_GetGroupMembers
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_GetGroupMemberOf($sAD_Group)

	If _AD_ObjectExists($sAD_Group) = 0 Then Return SetError(1, 0, "")
	If StringMid($sAD_Group, 3, 1) <> "=" Then $sAD_Group = _AD_SamAccountNameToFQDN($sAD_Group) ; sAMAccountName provided
	Local $iAD_RangeModifier, $sAD_Range, $oAD_RecordSet, $aAD_Membersadd
	Local $oAD_Command = ObjCreate("ADODB.Command")
	$oAD_Command.ActiveConnection = $oAD_Connection
	$oAD_Command.Properties("Searchscope") = 2
	Local $aAD_MemberOf[1]
	Local $iCount1 = 0
	While 1
		$iAD_RangeModifier = $iCount1 * 1000
		$sAD_Range = "Range=" & $iAD_RangeModifier & "-" & $iAD_RangeModifier + 999
		$oAD_Command.CommandText = "<LDAP://" & $sAD_HostServer & "/" & $sAD_Group & ">;;memberof;" & $sAD_Range & ";base"
		$oAD_RecordSet = $oAD_Command.Execute
		$aAD_Membersadd = $oAD_RecordSet.fields(0).Value
		If $aAD_Membersadd = 0 Then ExitLoop
		ReDim $aAD_MemberOf[UBound($aAD_MemberOf) + 1000]
		For $iCount2 = $iAD_RangeModifier + 1 To $iAD_RangeModifier + 1000
			$aAD_MemberOf[$iCount2] = $aAD_Membersadd[$iCount2 - $iAD_RangeModifier - 1]
		Next
		$iCount1 += 1
		$oAD_RecordSet.Close
	WEnd
	$iAD_RangeModifier = $iCount1 * 1000
	$sAD_Range = "Range=" & $iAD_RangeModifier & "-*"
	$oAD_Command.CommandText = "<LDAP://" & $sAD_HostServer & "/" & $sAD_Group & ">;;memberof;" & $sAD_Range & ";base"
	$oAD_RecordSet = $oAD_Command.Execute
	$aAD_Membersadd = $oAD_RecordSet.fields(0).Value
	ReDim $aAD_MemberOf[UBound($aAD_MemberOf) + UBound($aAD_Membersadd)]
	For $iCount2 = $iAD_RangeModifier + 1 To $iAD_RangeModifier + UBound($aAD_Membersadd)
		$aAD_MemberOf[$iCount2] = $aAD_Membersadd[$iCount2 - $iAD_RangeModifier - 1]
	Next
	$oAD_RecordSet.Close
	$aAD_MemberOf[0] = UBound($aAD_MemberOf) - 1
	Return $aAD_MemberOf

EndFunc   ;==>_AD_GetGroupMemberOf

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_GetObjectsInOU
; Description ...: Returns a filtered array of objects and attributes for a given OU.
; Syntax.........: _AD_GetObjectsInOU($sAD_OU[, $sAD_Filter = "(name=*)"[, $iAD_SearchScope = 2[, $sAD_DataToRetrieve =  "sAMAccountName"[, $sAD_SortBy = "sAMAccountName"]]]])
; Parameters ....: $sAD_OU - The OU to retrieve from (FQDN) (default = "", equals "search the whole AD tree")
;                  $sAD_Filter - Optional: An additional LDAP filter if required (default = "(name=*)").
;                  $iAD_SearchScope - Optional: 0 = base, 1 = one-level, 2 = sub-tree (default).
;                  $sAD_DataToRetrieve - Optional: A comma-seperated list of attributes to retrieve (default = "sAMAccountName").
;                  |More than one attribute will create a 2-dimensional array.
;                  $sAD_SortBy - Optional: name of the attribute the resulting array will be sorted upon (default = "sAMAccountName").
; Return values .: Success - One or two dimensional array of objects and attributes in the given OU. First entry is for the given OU itself.
;                  Failure - "", sets @error to:
;                  |1 - Specified OU does not exist
;                  |2 - No records returned from Active Directory. $sAD_DataToRetrieve is invalid (attribute may not exist)
;                  |3 - No records returned from Active Directory. $sAD_Filter didn't return a record
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: Multi-value attributes are returned as string with the pipe character (|) as separator.
;+
;                  The default filter returns an array including one record for the OU itself. To exclude the OU use a different filter that doesn't include the OU
;                  e.g. "(&(objectcategory=person)(objectclass=user)(name=*))"
;+
;                  To make sure that all properties you specify in $sAD_DataToRetrieve exist in the AD you can use _AD_ObjectExistsInSchema.
;+
;                  The following examples illustrate the use of the escaping mechanism in the LDAP filter:
;                    (o=Parens R Us \28for all your parenthetical needs\29)
;                    (cn=*\2A*)
;                    (filename=C:\5cMyFile)
;                    (bin=\00\00\00\04)
;                    (sn=Lu\c4\8di\c4\87)
;                  The first example shows the use of the escaping mechanism to represent parenthesis characters.
;                  The second shows how to represent a "*" in a value, preventing it from being interpreted as a substring indicator.
;                  The third illustrates the escaping of the backslash character.
;                  The fourth example shows a filter searching for the four-byte value 0x00000004, illustrating the use of the escaping mechanism to
;                  represent arbitrary data, including NUL characters.
;                  The final example illustrates the use of the escaping mechanism to represent various non-ASCII UTF-8 characters.
; Related .......: _AD_GetAllOUs
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_GetObjectsInOU($sAD_OU = "", $sAD_Filter = "(name=*)", $iAD_SearchScope = 2, $sAD_DataToRetrieve = "sAMAccountName", $sAD_SortBy = "sAMAccountName")

	If $sAD_OU = "" Then
		$sAD_OU = $sAD_DNSDomain
	Else
		If _AD_ObjectExists($sAD_OU, "distinguishedName") = 0 Then Return SetError(1, 0, "")
	EndIf

	Local $iCount2, $aAD_DataToRetrieve, $aTemp
	Local $oAD_Command = ObjCreate("ADODB.Command")
	$sAD_DataToRetrieve = StringStripWS($sAD_DataToRetrieve, 8)
	$oAD_Command.ActiveConnection = $oAD_Connection
	$oAD_Command.Properties("Page Size") = 256
	$oAD_Command.Properties("Searchscope") = $iAD_SearchScope
	$oAD_Command.Properties("TimeOut") = 20
	$oAD_Command.CommandText = "<LDAP://" & $sAD_HostServer & "/" & $sAD_OU & ">;" & $sAD_Filter & ";" & $sAD_DataToRetrieve
	$oAD_Command.Properties("Sort On") = $sAD_SortBy
	Local $oAD_RecordSet = $oAD_Command.Execute
	If Not IsObj($oAD_RecordSet) Then Return SetError(2, 0, "")
	Local $iCount1 = $oAD_RecordSet.RecordCount
	If $iCount1 = 0 Then Return SetError(3, 0, "")
	If StringInStr($sAD_DataToRetrieve, ",") Then
		$aAD_DataToRetrieve = StringSplit($sAD_DataToRetrieve, ",")
		Local $aAD_Objects[$iCount1 + 1][$aAD_DataToRetrieve[0]]
		$aAD_Objects[0][0] = $iCount1
		$aAD_Objects[0][1] = $aAD_DataToRetrieve[0]
		$iCount2 = 1
		$oAD_RecordSet.MoveFirst
		Do
			For $iCount1 = 1 To $aAD_DataToRetrieve[0]
				If IsArray($oAD_RecordSet.Fields($aAD_DataToRetrieve[$iCount1] ).Value) Then
					$aTemp = $oAD_RecordSet.Fields($aAD_DataToRetrieve[$iCount1] ).Value
					$aAD_Objects[$iCount2][$iCount1 - 1] = _ArrayToString($aTemp)
				Else
					$aAD_Objects[$iCount2][$iCount1 - 1] = $oAD_RecordSet.Fields($aAD_DataToRetrieve[$iCount1] ).Value
				EndIf
			Next
			$oAD_RecordSet.MoveNext
			$iCount2 += 1
		Until $oAD_RecordSet.EOF
	Else
		Local $aAD_Objects[$iCount1 + 1]
		$aAD_Objects[0] = UBound($aAD_Objects) - 1
		$iCount2 = 1
		$oAD_RecordSet.MoveFirst
		Do
			If IsArray($oAD_RecordSet.Fields($sAD_DataToRetrieve).Value) Then
				$aTemp = $oAD_RecordSet.Fields($sAD_DataToRetrieve).Value
				$aAD_Objects[$iCount2] = _ArrayToString($aTemp)
			Else
				$aAD_Objects[$iCount2] = $oAD_RecordSet.Fields($sAD_DataToRetrieve).Value
			EndIf
			$oAD_RecordSet.MoveNext
			$iCount2 += 1
		Until $oAD_RecordSet.EOF
	EndIf
	Return $aAD_Objects

EndFunc   ;==>_AD_GetObjectsInOU

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_GetAllOUs
; Description ...: Retrieves an array of OUs. The paths are separated by the '\' character.
; Syntax.........: _AD_GetAllOUs([$sAD_Root = ""[, $sAD_Separator = "\"]])
; Parameters ....: $sAD_Root - Optional: OU (FQDN) where to start in the AD tree (default = "", equals "start at the AD root")
;                  $sAD_Separator - Optional: Single character to separate the OU names (default = "\")
; Return values .: Success - One-based two dimensional array of OUs starting with the given OU. The paths are separated by "\"
;                  |1 - ... \name of grandfather OU\name of father OU\name of son OU
;                  |2 - Distinguished Name (FQDN) of the son OU
;                  Failure - "", sets @error to:
;                  |1 - No OUs found
;                  |2 - Specified $sAD_Root does not exist
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......:
; Related .......: _AD_GetObjectsInOU
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_GetAllOUs($sAD_Root = "", $sAD_Separator = "\")

	If $sAD_Root = "" Then
		$sAD_Root = $sAD_DNSDomain
	Else
		If _AD_ObjectExists($sAD_Root, "distinguishedName") = 0 Then Return SetError(2, 0, "")
	EndIf
	If $sAD_Separator <= " " Or StringLen($sAD_Separator) > 1 Then $sAD_Separator = "\"
	Local $oAD_Command = ObjCreate("ADODB.Command")
	$oAD_Command.ActiveConnection = $oAD_Connection
	$oAD_Command.Properties("Page Size") = 256
	$oAD_Command.Properties("Searchscope") = 2
	$oAD_Command.Properties("TimeOut") = 20
	$oAD_Command.CommandText = "<LDAP://" & $sAD_HostServer & "/" & $sAD_Root & ">;" & "(objectCategory=organizationalUnit)" & ";distinguishedName;subtree"
	Local $oAD_RecordSet = $oAD_Command.Execute
	Local $iCount1 = $oAD_RecordSet.RecordCount
	If $iCount1 = 0 Then Return SetError(1, 0, "")
	Local $aAD_OUs[$iCount1 + 1][2]
	Local $iCount2 = 1, $aAD_TempOU
	$oAD_RecordSet.MoveFirst
	Do
		$aAD_OUs[$iCount2][1] = $oAD_RecordSet.Fields("distinguishedName" ).Value
		$aAD_OUs[$iCount2][0] = "," & StringTrimRight($aAD_OUs[$iCount2][1], StringLen($sAD_DNSDomain) + 1)
		$aAD_TempOU = StringSplit($aAD_OUs[$iCount2][0], ",OU=", 1)
		_ArrayReverse($aAD_TempOU)
		$aAD_OUs[$iCount2][0] = StringTrimRight(_ArrayToString($aAD_TempOU, $sAD_Separator), 3)
		$iCount2 += 1
		$oAD_RecordSet.MoveNext
	Until $oAD_RecordSet.EOF
	_ArraySort($aAD_OUs)
	$aAD_OUs[0][0] = UBound($aAD_OUs, 1) - 1
	$aAD_OUs[0][1] = 2
	Return $aAD_OUs

EndFunc   ;==>_AD_GetAllOUs

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_ListDomainControllers
; Description ...: Enumerates all Domain Controllers, their distinguished name, their DNS host name, and the name of the site they reside in.
; Syntax.........: _AD_ListDomainControllers([$fAD_ListRO = FALSE])
; Parameters ....: $fAD_ListRO - Optional: If set to TRUE only returns RODC (read only domain controllers). Default = FALSE
; Return values .: Success - One-based two dimensional array with the following information:
;                  |1 - Domain Controller: Name
;                  |2 - Domain Controller: Distinguished Name (FQDN)
;                  |3 - Domain Controller: DNS host name
;                  |4 - Site: Name
;                  |5 - Site: Distinguished Name (FQDN)
;                  |6 - Site: List of subnets that can connect to the site using this DC in the format x.x.x.x/mask - multiple subnets are separated by comma
;                  Failure - "", sets @error to:
;                  |1 - No Domain Controllers found
; Author ........: Richard L. Mueller
; Modified.......: water
; Remarks .......: This function only lists writeable DCs (default). To list RODC (read only DCs) use parameter $fAD_ListRO
; Related .......:
; Link ..........: http://www.rlmueller.net/Enumerate%20DCs.htm
; Example .......: Yes
; ===============================================================================================================================
Func _AD_ListDomainControllers($fAD_ListRO = False)

	Local $oAD_DC, $oAD_Site, $oAD_Result
	Local $sAD_Query = "<LDAP://" & $sAD_Configuration & ">;(objectClass=nTDSDSA);ADsPath;subtree"
	If $fAD_ListRO Then $sAD_Query = "<LDAP://" & $sAD_Configuration & ">;(objectClass=nTDSDSARO);ADsPath;subtree"
	Local $oAD_RecordSet = $oAD_Connection.Execute($sAD_Query)
	If Not IsObj($oAD_RecordSet) Or $oAD_RecordSet.RecordCount = 0 Then Return SetError(1, 0, "")
	; The parent object of each object with objectClass=nTDSDSA is a Domain
	; Controller. The parent of each Domain Controller is a "Servers"
	; container, and the parent of this container is the "Site" container.
	$oAD_RecordSet.MoveFirst
	Local $aAD_Result[1][6], $iCount1 = 1, $aAD_SubNet, $aAD_Temp, $sAD_Temp
	Do
		ReDim $aAD_Result[$iCount1 + 1][6]
		$oAD_Result = _AD_ObjGet($oAD_RecordSet.Fields("AdsPath" ).Value)
		$oAD_DC = _AD_ObjGet($oAD_Result.Parent)
		$aAD_Result[$iCount1][0] = $oAD_DC.Get("Name")
		$aAD_Result[$iCount1][1] = $oAD_DC.serverReference
		$aAD_Result[$iCount1][2] = $oAD_DC.DNSHostName
		$oAD_Result = _AD_ObjGet($oAD_DC.Parent)
		$oAD_Site = _AD_ObjGet($oAD_Result.Parent)
		$aAD_Result[$iCount1][3] = StringMid($oAD_Site.Name, 4)
		$aAD_Result[$iCount1][4] = $oAD_Site.distinguishedName
		$aAD_SubNet = $oAD_Site.GetEx("siteObjectBL")
		For $iCount2 = 0 To UBound($aAD_SubNet) - 1
			$aAD_Temp = StringSplit($aAD_SubNet[$iCount2], ",")
			$sAD_Temp = StringMid($aAD_Temp[1], 4)
			If $iCount2 = 0 Then
				$aAD_Result[$iCount1][5] = $sAD_Temp
			Else
				$aAD_Result[$iCount1][5] = $aAD_Result[$iCount1][5] & "," & $sAD_Temp
			EndIf
		Next
		$oAD_RecordSet.MoveNext
		$iCount1 += 1
	Until $oAD_RecordSet.EOF
	$oAD_RecordSet.Close
	$aAD_Result[0][0] = UBound($aAD_Result, 1) - 1
	$aAD_Result[0][1] = UBound($aAD_Result, 2)
	Return $aAD_Result

EndFunc   ;==>_AD_ListDomainControllers

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_ListRootDSEAttributes
; Description ...: Returns a one-based array of the RootDSE Atributes.
; Syntax.........: _AD_ListRootDSEAttributes()
; Parameters ....:
; Return values .: Success - One dimensional array of the following RootDSE attributes. Multi-valued attributes are as multiple lines.
;                  |1 - configurationNamingContext: Specifies the distinguished name for the configuration container.
;                  |2 - currentTime: Specifies the current time set on this directory server in Coordinated Universal Time format.
;                  |3 - defaultNamingContext: Specifies the distinguished name of the domain that this directory server is a member.
;                  |4 - dnsHostName: Specifies the DNS address for this directory server.
;                  |5 - domainControllerFunctionality: Specifies the functional level of this domain controller. Values can be:
;                       0 - Windows 2000 Mode
;                       2 - Windows Server 2003 Mode
;                       3 - Windows Server 2008 Mode
;                       4 - Windows Server 2008 R2 Mode
;                  |6 - domainFunctionality: Specifies the functional level of the domain. Values can be:
;                       0 - Windows 2000 Domain Mode
;                       1 - Windows Server 2003 Interim Domain Mode
;                       2 - Windows Server 2003 Domain Mode
;                       3 - Windows Server 2008 Domain Mode
;                       4 - Windows Server 2008 R2 Domain Mode
;                  |7 - dsServiceName: Specifies the distinguished name of the NTDS settings object for this directory server.
;                  |8 - forestFunctionality: Specifies the functional level of the forest. Values can be:
;                       0 - Windows 2000 Forest Mode
;                       1 - Windows Server 2003 Interim Forest Mode
;                       2 - Windows Server 2003 Forest Mode
;                       3 - Windows Server 2008 Forest Mode
;                       4 - Windows Server 2008 R2 Forest Mode
;                  |9 - highestCommittedUSN: Specifies the highest update sequence number (USN) on this directory server. Used by directory replication.
;                  |10 - isGlobalCatalogReady: Specifies Global Catalog operational status. Values can be either "TRUE" or "FALSE".
;                  |11 - isSynchronized: Specifies directory server synchronisation status. Values can be either "TRUE" or "FALSE".
;                  |12 - LDAPServiceName: Specifies the Service Principal Name (SPN) for the LDAP server. Used for mutual authentication.
;                  |13 - namingContexts: A multi-valued attribute that specifies the distinguished names for all naming contexts stored on this directory server.
;                  +By default, a Windows 2000 domain controller has at least three naming contexts: Schema, Configuration, and the domain which the server is a member of.
;                  |14 - rootDomainNamingContext: Specifies the distinguished name for the first domain in the forest that this directory server is a member of.
;                  |15 - schemaNamingContext: Specifies the distinguished name for the schema container.
;                  |16 - serverName: Specifies the distinguished name of the server object for this directory server in the configuration container.
;                  |17 - subschemaSubentry: Specifies the distinguished name for the subSchema object. The subSchema object specifies properties that expose the supported attributes
;                  +(in the attributeTypes property) and classes (in the objectClasses property).
;                  |18 - supportedCapabilities: multi-valued attribute that specifies the capabilities supported by this directory server.
;                  |19 - supportedControl: A multi-valued attribute that specifies the extension control OIDs supported by this directory server.
;                  |20 - supportedLDAPPolicies: A multi-valued attribute that specifies the names of the supported LDAP management policies.
;                  |21 - supportedLDAPVersion: A multi-valued attribute that specifies the LDAP versions (specified by major version number) supported by this directory server.
;                  |22 - supportedSASLMechanisms: Specifies the security mechanisms supported for SASL negotiation (see LDAP RFCs). By default, GSSAPI is supported.
; Author ........: water
; Modified.......:
; Remarks .......: In LDAP 3.0, rootDSE is defined as the root of the directory data tree on a directory server.
;                  The rootDSE is not part of any namespace. The purpose of the rootDSE is to provide data about the directory server.
; Related .......:
; Link ..........: http://msdn.microsoft.com/en-us/library/cc223254(v=PROT.13).aspx
; Example .......: Yes
; ===============================================================================================================================
Func _AD_ListRootDSEAttributes()

	Return _AD_GetObjectProperties($oAD_RootDSE)

EndFunc   ;==>_AD_ListRootDSEAttributes

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_ListRoleOwners
; Description ...: Returns a one-based array of FSMO (Flexible Single Master Operation) Role Owners.
; Syntax.........: _AD_ListRoleOwners()
; Parameters ....:
; Return values .: Success - One dimensional array of FSMO Role Owners. The array contains:
;                  |1 - Domain PDC FSMO
;                  |2 - Domain Rid FSMO
;                  |3 - Domain Infrastructure FSMO
;                  |4 - Forest-wide Schema FSMO
;                  |5 - Forest-wide Domain naming FSMO
; Author ........: water
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........: http://www.tools4net.de/doc/ad2.htm
; Example .......: Yes
; ===============================================================================================================================
Func _AD_ListRoleOwners()

	Local $aAD_Roles[6]

	; PDC FSMO
	Local $sAD_Query = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(&(objectClass=domainDNS)(fSMORoleOwner=*));adsPath;subtree"
	Local $oAD_RecordSet = $oAD_Connection.Execute($sAD_Query)
	Local $oAD_FSM = ObjGet($oAD_RecordSet.fields(0).value)
	Local $oAD_CompNTDS = ObjGet("LDAP://" & $sAD_HostServer & "/" & $oAD_FSM.FSMORoleOwner)
	Local $oAD_Comp = ObjGet($oAD_CompNTDS.Parent)
	$aAD_Roles[1] = $oAD_Comp.dnsHostname

	; Rid FSMO
	$sAD_Query = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(&(objectClass=rIDManager) (fSMORoleOwner=*));adsPath;subtree"
	$oAD_RecordSet = $oAD_Connection.Execute($sAD_Query)
	$oAD_FSM = ObjGet($oAD_RecordSet.fields(0).value)
	$oAD_CompNTDS = ObjGet("LDAP://" & $sAD_HostServer & "/" & $oAD_FSM.FSMORoleOwner)
	$oAD_Comp = ObjGet($oAD_CompNTDS.Parent)
	$aAD_Roles[2] = $oAD_Comp.dnsHostname

	; Infrastructure FSMO
	$sAD_Query = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(&(objectClass=infrastructureUpdate) (fSMORoleOwner=*));adsPath;subtree"
	$oAD_RecordSet = $oAD_Connection.Execute($sAD_Query)
	$oAD_FSM = ObjGet($oAD_RecordSet.fields(0).value)
	$oAD_CompNTDS = ObjGet("LDAP://" & $sAD_HostServer & "/" & $oAD_FSM.FSMORoleOwner)
	$oAD_Comp = ObjGet($oAD_CompNTDS.Parent)
	$aAD_Roles[3] = $oAD_Comp.dnsHostname

	; Schema FSMO
	$sAD_Query = "<LDAP://" & $sAD_HostServer & "/" & $oAD_RootDSE.Get("schemaNamingContext") & ">;(&(objectClass=dMD) (fSMORoleOwner=*));adsPath;subtree"
	$oAD_RecordSet = $oAD_Connection.Execute($sAD_Query)
	$oAD_FSM = ObjGet($oAD_RecordSet.fields(0).value)
	$oAD_CompNTDS = ObjGet("LDAP://" & $sAD_HostServer & "/" & $oAD_FSM.FSMORoleOwner)
	$oAD_Comp = ObjGet($oAD_CompNTDS.Parent)
	$aAD_Roles[4] = $oAD_Comp.dnsHostname

	; Domain Naming FSMO
	$sAD_Query = "<LDAP://" & $sAD_HostServer & "/" & $oAD_RootDSE.Get("configurationNamingContext") & ">;(&(objectClass=crossRefContainer)(fSMORoleOwner=*));adsPath;subtree"
	$oAD_RecordSet = $oAD_Connection.Execute($sAD_Query)
	$oAD_FSM = ObjGet($oAD_RecordSet.fields(0).value)
	$oAD_CompNTDS = ObjGet("LDAP://" & $sAD_HostServer & "/" & $oAD_FSM.FSMORoleOwner)
	$oAD_Comp = ObjGet($oAD_CompNTDS.Parent)
	$aAD_Roles[5] = $oAD_Comp.dnsHostname

	$aAD_Roles[0] = 5
	Return $aAD_Roles

EndFunc   ;==>_AD_ListRoleOwners

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_GetLastLoginDate
; Description ...: Returns the lastlogin information from all DCs using the SamAccountName.
; Syntax.........: _AD_GetLastLoginDate([$sAD_User = @Username[, $sAD_Site]])
; Parameters ....: $sAD_User - Optional: SamAccountName of a user account to get the last login date (default = @Username).
;                  $sAD_Site - Optional: Only query DCs that belong to this site (default = all sites).
; Return values .: Success - Last login date returned as YYYYMMDDHHMMSS. @extended is set to the total number of Domain Controllers.
;                  +@error could be > 0 and contains the number of DCs that could not be reached or returns no data
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_User could not be found. @extended = 0
;                  |2 - $sAD_User has never logged in to the domain. @extended = 0
;                  Warning - Last login date returned as YYYYMMDDHHMMSS (see Success), sets @error and @extended to:
;                  |x - Number of DCs which could not be reached. Result is returned from all available DCs. @extended is set to the total number of Domain Controllers
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: If it takes (too) long to get a result either some DCs are down or you have too many DCs in your AD.
;                  +Case one: Please check @error and @extended as described above
;                  +Case two: Specify parameter $sAD_Site to reduce the number of DCs to query
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_GetLastLoginDate($sAD_User = @UserName, $sAD_Site = "")

	If _AD_ObjectExists($sAD_User) = 0 Then Return SetError(1, 0, 0)
	Local $aAD_DCList = _AD_ListDomainControllers()
	; Delete all DCs not belonging to the specified site
	If $sAD_Site <> "" Then
		For $iAD_Count1 = $aAD_DCList[0][0] To 1 Step -1
			If $aAD_DCList[$iAD_Count1][3] <> $sAD_Site Then _ArrayDelete($aAD_DCList, $iAD_Count1)
		Next
		$aAD_DCList[0][0] = UBound($aAD_DCList, 1) - 1
	EndIf
	; Get LastLogin from all DCs
	Local $aAD_Result[$aAD_DCList[0][0] + 1]
	Local $sAD_Command, $sAD_LDAPEntry, $oAD_Object, $oAD_RecordSet
	Local $iAD_Error1 = 0, $iAD_Error2 = 0
	For $iCount1 = 1 To $aAD_DCList[0][0]
		If Ping($aAD_DCList[$iCount1][2]) = 0 Then
			$iAD_Error1 += 1
			ContinueLoop
		EndIf
		$sAD_Command = "<LDAP://" & $aAD_DCList[$iCount1][2] & "/" & $sAD_DNSDomain & ">;(sAMAccountName=" & $sAD_User & ");ADsPath;subtree"
		$oAD_RecordSet = $oAD_Connection.Execute($sAD_Command) ; Retrieve the ADsPath for the object
		; -2147352567 or 0x80020009 is returned when the service is not operational
		If @error = -2147352567 Or $oAD_RecordSet.RecordCount = 0 Then
			$iAD_Error1 += 1
		Else
			$sAD_LDAPEntry = $oAD_RecordSet.fields(0).value
			$oAD_Object = _AD_ObjGet($sAD_LDAPEntry) ; Retrieve the COM Object for the object
			$aAD_Result[$iCount1] = $oAD_Object.LastLogin
			; -2147352567 or 0x80020009 is returned when the attribute "LastLogin" isn't defined on this DC
			If @error = -2147352567 Then $iAD_Error2 += 1
			$oAD_Object.PurgePropertyList
		EndIf
	Next
	_ArraySort($aAD_Result, 1, 1)
	; If error count equals the number of DCs then the user has never logged in
	If $iAD_Error2 = $aAD_DCList[0][0] Then Return SetError(2, 0, 0)
	Return SetError($iAD_Error1, $aAD_DCList[0][0], $aAD_Result[1])

EndFunc   ;==>_AD_GetLastLoginDate

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_IsObjectDisabled
; Description ...: Returns 1 if the object (user account, computer account) is disabled.
; Syntax.........: _AD_IsObjectDisabled([$sAD_Object = @Username])
; Parameters ....: $sAD_Object - Optional: Object to check (default = @Username). Can be specified as Fully Qualified Domain Name (FQDN) or sAMAccountName
; Return values .: Success - 1, Specified object is disabled
;                  Failure - 0, sets @error to:
;                  |0 - $sAD_Object is not disabled
;                  |1 - $sAD_Object could not be found
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: A $ sign must be appended to the computer name to create a correct sAMAccountName e.g. @ComputerName & "$"
; Related .......: _AD_DisableObject, _AD_EnableObject, _AD_GetObjectsDisabled
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_IsObjectDisabled($sAD_Object = @UserName)

	If _AD_ObjectExists($sAD_Object) = 0 Then Return SetError(1, 0, 0)
	Local $iAD_UAC = _AD_GetObjectAttribute($sAD_Object, "userAccountControl")
	If BitAND($iAD_UAC, $ADS_UF_ACCOUNTDISABLE) = $ADS_UF_ACCOUNTDISABLE Then Return 1
	Return 0

EndFunc   ;==>_AD_IsObjectDisabled

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_IsObjectLocked
; Description ...: Returns 1 if the object (user account, computer account) is locked.
; Syntax.........: _AD_IsObjectLocked([$sAD_Object = @Username])
; Parameters ....: $sAD_Object - Optional: Object to check (default = @Username). Can be specified as Fully Qualified Domain Name (FQDN) or sAMAccountName
; Return values .: Success - 1, Specified object is locked, sets @error to:
;                  |x - number of minutes till the account is unlocked
;                  Failure - 0, sets @error to:
;                  |0 - $sAD_Object is not locked
;                  |1 - $sAD_Object could not be found
; Author ........: water
; Modified.......:
; Remarks .......: A $ sign must be appended to the computer name to create a correct sAMAccountName e.g. @ComputerName & "$"
;                  LockoutTime contains the timestamp when the object was locked. This value is not reset until the user/computer logs on again.
;                  LockoutTime could be > 0 even when the lockout already has expried.
; Related .......: _AD_GetObjectsLocked, _AD_UnlockObject
; Link ..........: http://www.pcreview.co.uk/forums/thread-1350048.php, http://www.rlmueller.net/IsUserLocked.htm, http://technet.microsoft.com/en-us/library/cc780271%28WS.10%29.aspx
; Example .......: Yes
; ===============================================================================================================================
Func _AD_IsObjectLocked($sAD_Object = @UserName)

	;-------------------------------------------------------------
	; HINT: To enhance performance this can also be written as:
	; 	$oUser = ObjGet("WinNT://<Domain>/<User>")
	;	ConsoleWrite("Locked: " & $oUser.IsAccountLocked & @CRLF)
	;-------------------------------------------------------------
	If Not _AD_ObjectExists($sAD_Object) Then Return SetError(1, 0, 0)
	Local $sAD_Property = "sAMAccountName"
	If StringMid($sAD_Object, 3, 1) = "=" Then $sAD_Property = "distinguishedName"; FQDN provided
	Local $sAD_Query = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(" & $sAD_Property & "=" & $sAD_Object & ");ADsPath;subtree"
	Local $oAD_RecordSet = $oAD_Connection.Execute($sAD_Query) ; Retrieve the ADsPath for the object
	Local $sAD_LDAPEntry = $oAD_RecordSet.fields(0).value
	Local $oAD_Object = _AD_ObjGet($sAD_LDAPEntry) ; Retrieve the COM Object for the object
	Local $oAD_LockoutTime = $oAD_Object.LockoutTime
	; Object is not locked out
	If Not IsObj($oAD_LockoutTime) Then Return
	; Calculate lockout time (UTC)
	Local $sAD_LockoutTime = _DateAdd("s", Int(_AD_LargeInt2Double($oAD_LockoutTime.LowPart, $oAD_LockoutTime.HighPart) / (10000000)), "1601/01/01 00:00:00")
	; Object is not locked out
	If $sAD_LockoutTime = "1601/01/01 00:00:00" Then Return
	; Get password info - Account Lockout Duration
	Local $aAD_Temp = _AD_GetPasswordInfo($sAD_Object)
	; Calculate when the lockout will be reset
	Local $sAD_ResetLockoutTime = _DateAdd("n", $aAD_Temp[5], $sAD_LockoutTime)
	; Compare to current date/time (UTC)
	Local $sAD_Now = _Date_Time_GetSystemTime()
	$sAD_Now = _Date_Time_SystemTimeToDateTimeStr($sAD_Now, 1)
	If $sAD_ResetLockoutTime >= $sAD_Now Then Return SetError(_DateDiff("n", $sAD_Now, $sAD_ResetLockoutTime), 0, 1)
	Return

EndFunc   ;==>_AD_IsObjectLocked

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_IsPasswordExpired
; Description ...: Returns 1 if the users password has expired.
; Syntax.........: _AD_IsPasswordExpired([$sAD_User = @Username])
; Parameters ....: $sAD_User - Optional: Object to check (default = @Username). Can be specified as Fully Qualified Domain Name (FQDN) or sAMAccountName
; Return values .: Success - 1, The password of the specified user has expired
;                  Failure - 0, sets @error to:
;                  |0 - Password for $sAD_User has not expired
;                  |1 - $sAD_User could not be found
;                  |x - Error as returned by function _AD_GetPasswordInfo
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......:
; Related .......: _AD_GetPasswordExpired, _AD_GetPasswordDontExpire, _AD_SetPassword, _AD_DisablePasswordExpire, _AD_EnablePasswordExpire, _AD_EnablePasswordChange,  _AD_DisablePasswordChange, _AD_GetPasswordInfo
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_IsPasswordExpired($sAD_User = @UserName)

	If Not _AD_ObjectExists($sAD_User) Then Return SetError(1, 0, 0)
	Local $aAD_Temp = _AD_GetPasswordInfo($sAD_User)
	If @error <> 0 Then SetError(@error, 0, 0)
	If $aAD_Temp[11] <= _NowCalc() Then Return 1
	Return

EndFunc   ;==>_AD_IsPasswordExpired

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_GetObjectsDisabled
; Description ...: Returns an array with FQDNs of disabled objects (user accounts, computer accounts).
; Syntax.........: _AD_GetObjectsDisabled([$sAD_Class = "user"])
; Parameters ....: $sAD_Class - Optional: Specifies if disabled user accounts or computer accounts should be returned (default = "user").
;                  "user" - Returns objects of category "user"
;                  "computer" - Returns objects of category "computer"
; Return values .: Success - array of user or computer account FQDNs
;                  Failure - "", sets @error to:
;                  |1 - $sAD_Class is invalid. Values can be "computer" or "user"
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......:
; Related .......: _AD_IsObjectDisabled, _AD_DisableObject, _AD_EnableObject
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_GetObjectsDisabled($sAD_Class = "user")

	If $sAD_Class <> "user" And $sAD_Class <> "computer" Then Return SetError(1, 0, "")
	Local $oAD_Command = ObjCreate("ADODB.Command")
	$oAD_Command.ActiveConnection = $oAD_Connection
	$oAD_Command.Properties("Page Size") = 1000
	$oAD_Command.CommandText = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(&(objectcategory=" & $sAD_Class & ")(userAccountControl:1.2.840.113556.1.4.803:=" & _
			$ADS_UF_ACCOUNTDISABLE & "));distinguishedName,objectcategory;subtree"
	Local $oAD_RecordSet = $oAD_Command.Execute
	Local $aAD_FQDN[$oAD_RecordSet.RecordCount + 1]
	$aAD_FQDN[0] = $oAD_RecordSet.RecordCount
	Local $iCount1 = 1
	While Not $oAD_RecordSet.EOF
		$aAD_FQDN[$iCount1] = $oAD_RecordSet.Fields(0).Value
		$iCount1 += 1
		$oAD_RecordSet.MoveNext
	WEnd
	Return $aAD_FQDN

EndFunc   ;==>_AD_GetObjectsDisabled

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_GetObjectsLocked
; Description ...: Returns an array of FQDNs of locked (user and/or, computer accounts), lockout time and minutes remaining in locked state.
; Syntax.........: _AD_GetObjectsLocked([$sAD_Class = "user"])
; Parameters ....: $sAD_Class - Optional: Specifies if locked user accounts or computer accounts should be returned (default = "user").
;                  "user" - Returns objects of category "user"
;                  "computer" - Returns objects of category "computer"
; Return values .: Success - Returns a one-based two dimensional array with the following information:
;                  |1 - FQDN of the locked object
;                  |2 - lockout time YYYY/MM/DD HH:MM:SS in local time of the calling user
;                  |3 - Minutes until the object will be unlocked
;                  Failure - "", sets @error to:
;                  |1 - $sAD_Class is invalid. Should be "computer" or "user"
;                  |2 - No locked objects found
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: LockoutTime contains the timestamp when the object was locked. This value is not reset until the user/computer logs on again.
;                  LockoutTime could be > 0 even when the lockout has already expired.
; Related .......: _AD_IsObjectLocked, _AD_UnlockObject
; Link ..........: http://technet.microsoft.com/en-us/library/cc780271%28WS.10%29.aspx
; Example .......: Yes
; ===============================================================================================================================
Func _AD_GetObjectsLocked($sAD_Class = "user")

	If $sAD_Class <> "user" And $sAD_Class <> "computer" Then Return SetError(1, 0, "")
	; Get all objects with lockouttime>=1
	Local $oAD_Command = ObjCreate("ADODB.Command")
	$oAD_Command.ActiveConnection = $oAD_Connection
	$oAD_Command.Properties("Page Size") = 1000
	$oAD_Command.CommandText = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(&(objectcategory=" & $sAD_Class & ")(lockouttime>=1));distinguishedName;subtree"
	Local $oAD_RecordSet = $oAD_Command.Execute
	If Not IsObj($oAD_RecordSet) Or $oAD_RecordSet.RecordCount = 0 Then Return SetError(2, 0, "")
	Local $aAD_FQDN[$oAD_RecordSet.RecordCount + 1][3] = [[$oAD_RecordSet.RecordCount, 3]]
	Local $iCount1 = 1
	Local $aAD_Result
	While Not $oAD_RecordSet.EOF
		$aAD_FQDN[$iCount1][0] = $oAD_RecordSet.Fields(0).Value
		$iCount1 += 1
		$oAD_RecordSet.MoveNext
	WEnd
	; check if lockouttime has expired. If yes, delete from table
	For $iCount1 = $aAD_FQDN[0][0] To 1 Step -1
		If Not _AD_IsObjectLocked($aAD_FQDN[$iCount1][0]) Then
			_ArrayDelete($aAD_FQDN, $iCount1)
		Else
			$aAD_FQDN[$iCount1][2] = @error
			$aAD_Result = _AD_GetObjectProperties($aAD_FQDN[$iCount1][0], "lockouttime")
			$aAD_FQDN[$iCount1][1] = $aAD_Result[1][1]
		EndIf
	Next
	$aAD_FQDN[0][0] = UBound($aAD_FQDN) - 1
	If $aAD_FQDN[0][0] = 0 Then Return SetError(2, 0, "")
	Return $aAD_FQDN

EndFunc   ;==>_AD_GetObjectsLocked

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_GetPasswordExpired
; Description ...: Returns an array of FQDNs of user account with expired passwords.
; Syntax.........: _AD_GetPasswordExpired()
; Parameters ....: None
; Return values .: Success - One-based two dimensional array of FQDNs of user accounts with expired passwords
;                  |1 - FQDNs of user accounts with expired password
;                  |2 - password last set YYYY/MM/DD HH:NMM:SS UTC
;                  |3 - password last set YYYY/MM/DD HH:NMM:SS local time of calling user
;                  Failure - "", sets @error to:
;                  |1 - No expired passwords found
; Author ........: water
; Modified.......:
; Remarks .......:
; Related .......: _AD_IsPasswordExpired, _AD_GetPasswordDontExpire, _AD_SetPassword, _AD_DisablePasswordExpire, _AD_EnablePasswordExpire, _AD_EnablePasswordChange,  _AD_DisablePasswordChange, _AD_GetPasswordInfo
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_GetPasswordExpired()

	Local $aAD_Temp = _AD_GetPasswordInfo()
	Local $sAD_DTExpire = _Date_Time_GetSystemTime() ; Get current date/time
	$sAD_DTExpire = _Date_Time_SystemTimeToDateTimeStr($sAD_DTExpire, 1) ; convert to system time
	$sAD_DTExpire = _DateAdd("D", $aAD_Temp[1] * - 1, $sAD_DTExpire) ; substract maximum password age
	Local $iAD_DTExpire = _DateDiff("s", "1601/01/01 00:00:00", $sAD_DTExpire) * 10000000 ; convert to Integer8
	Local $sAD_DTStruct = DllStructCreate("dword low;dword high")
	Local $sAD_Temp, $iAD_Temp
	Local $oAD_Command = ObjCreate("ADODB.Command")
	$oAD_Command.ActiveConnection = $oAD_Connection
	$oAD_Command.Properties("Page Size") = 1000
	$oAD_Command.CommandText = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(&(objectCategory=person)(objectClass=user)" & _
			"(pwdLastSet<=" & Int($iAD_DTExpire) & ")(pwdLastSet>=110133216000000001" & "));distinguishedName,pwdlastset,useraccountcontrol;subtree"
	Local $oAD_RecordSet = $oAD_Command.Execute
	If Not IsObj($oAD_RecordSet) Or $oAD_RecordSet.RecordCount = 0 Then Return SetError(1, 0, "")
	Local $aAD_FQDN[$oAD_RecordSet.RecordCount + 1][3]
	$aAD_FQDN[0][0] = $oAD_RecordSet.RecordCount
	Local $iAD_Count = 1
	While Not $oAD_RecordSet.EOF
		$aAD_FQDN[$iAD_Count][0] = $oAD_RecordSet.Fields(0).Value
		$iAD_Temp = $oAD_RecordSet.Fields(1).Value
		If BitAND($oAD_RecordSet.Fields(2).Value, $ADS_UF_DONT_EXPIRE_PASSWD) <> $ADS_UF_DONT_EXPIRE_PASSWD Then
			DllStructSetData($sAD_DTStruct, "Low", $iAD_Temp.LowPart)
			DllStructSetData($sAD_DTStruct, "High", $iAD_Temp.HighPart)
			$sAD_Temp = _Date_Time_FileTimeToSystemTime(DllStructGetPtr($sAD_DTStruct))
			$aAD_FQDN[$iAD_Count][1] = _Date_Time_SystemTimeToDateTimeStr($sAD_Temp, 1)
			$sAD_Temp = _Date_Time_SystemTimeToTzSpecificLocalTime(DllStructGetPtr($sAD_Temp))
			$aAD_FQDN[$iAD_Count][2] = _Date_Time_SystemTimeToDateTimeStr($sAD_Temp, 1)
		EndIf
		$iAD_Count += 1
		$oAD_RecordSet.MoveNext
	WEnd
	; Delete records with UAC set to password not expire
	$aAD_FQDN[0][0] = UBound($aAD_FQDN) - 1
	For $iAD_Count = $aAD_FQDN[0][0] To 1 Step -1
		If $aAD_FQDN[$iAD_Count][1] = "" Then _ArrayDelete($aAD_FQDN, $iAD_Count)
	Next
	$aAD_FQDN[0][0] = UBound($aAD_FQDN) - 1
	Return $aAD_FQDN

EndFunc   ;==>_AD_GetPasswordExpired

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_GetPasswordDontExpire
; Description ...: Returns an array of user account FQDNs where the password does not expire.
; Syntax.........: _AD_GetPasswordDontExpire()
; Parameters ....: None
; Return values .: Success - Array with FQDNs of user accounts for which the password does not expire
;                  Failure - "", sets @error to:
;                  |1 - No user accounts for which the password does not expire
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......:
; Related .......: _AD_IsPasswordExpired, _AD_GetPasswordExpired, _AD_SetPassword, _AD_DisablePasswordExpire, _AD_EnablePasswordExpire, _AD_EnablePasswordChange,  _AD_DisablePasswordChange, _AD_GetPasswordInfo
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_GetPasswordDontExpire()

	Local $oAD_Command = ObjCreate("ADODB.Command")
	$oAD_Command.ActiveConnection = $oAD_Connection
	$oAD_Command.Properties("Page Size") = 1000
	$oAD_Command.CommandText = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(&(objectcategory=user)(userAccountControl:1.2.840.113556.1.4.803:=" & _
			$ADS_UF_DONT_EXPIRE_PASSWD & "));distinguishedName;subtree"
	Local $oAD_RecordSet = $oAD_Command.Execute
	If Not IsObj($oAD_RecordSet) Or $oAD_RecordSet.RecordCount = 0 Then Return SetError(1, 0, "")
	Local $aAD_FQDN[$oAD_RecordSet.RecordCount + 1]
	$aAD_FQDN[0] = $oAD_RecordSet.RecordCount
	Local $iCount1 = 1
	While Not $oAD_RecordSet.EOF
		$aAD_FQDN[$iCount1] = $oAD_RecordSet.Fields(0).Value
		$iCount1 += 1
		$oAD_RecordSet.MoveNext
	WEnd
	Return $aAD_FQDN

EndFunc   ;==>_AD_GetPasswordDontExpire

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_GetObjectProperties
; Description ...: Returns a two-dimensional array of all or selected properties and their values of an object in readable form.
; Syntax.........: _AD_GetObjectProperties([$sAD_Object = @UserName[, $sAD_Properties = ""]])
; Parameters ....: $sAD_Object - Optional: SamAccountName or FQDN of the object properties from (e.g. computer, user, group ...) (default = @Username)
;                  |Can be of type object as well. Useful to get properties for a schema or configuration object (see _AD_ListRootDSEAttributes)
;                  $sAD_Properties - Optional: Comma separated list of properties to return (default = "" = return all properties)
; Return values .: Success - Returns a two-dimensional array with all properties and their values of an object in readable form
;                  Failure - "" or property name, sets @error to:
;                  |1 - $sAD_Object could not be found
;                  |2 - No values for the specified property. The property in error is returned as the function result
; Author ........: Sundance
; Modified.......: water
; Remarks .......: Dates are returned in format: YYYY/MM/DD HH:MM:SS local time of the calling user (AD stores all dates in UTC - Universal Time Coordinated)
;                  Exception: AD internal dates like "whenCreated", "whenChanged" and "dSCorePropagationData". They are returned as UTC
;                  NT Security Descriptors are returned as: Control:nn, Group:Domain\Group, Owner:Domain\Group, Revision:nn
;                  No error is returned if there are properties in $sAD_Properties that are not available for the selected object
; Related .......:
; Link ..........: http://www.autoitscript.com/forum/index.php?showtopic=49627&view=findpost&p=422402, http://msdn.microsoft.com/en-us/library/ms675090(VS.85).aspx
; Example .......: Yes
; ===============================================================================================================================
Func _AD_GetObjectProperties($sAD_Object = @UserName, $sAD_Properties = "")

	Local $aAD_ObjectProperties[1][2], $oAD_Object
	Local $sAD_Query, $oAD_Item, $oAD_PropertyEntry, $oAD_Value, $iCount3, $xAD_Dummy
	; Data Type Mapping between Active Directory and LDAP
	; http://msdn.microsoft.com/en-us/library/aa772375(VS.85).aspx
	Local Const $ADSTYPE_DN_STRING = 1
	Local Const $ADSTYPE_CASE_IGNORE_STRING = 3
	Local Const $ADSTYPE_BOOLEAN = 6
	Local Const $ADSTYPE_INTEGER = 7
	Local Const $ADSTYPE_OCTET_STRING = 8
	Local Const $ADSTYPE_UTC_TIME = 9
	Local Const $ADSTYPE_LARGE_INTEGER = 10
	Local Const $ADSTYPE_NT_SECURITY_DESCRIPTOR = 25
	Local Const $ADSTYPE_UNKNOWN = 26
	Local $aAD_SAMAccountType[12][2] = [["DOMAIN_OBJECT", 0x0],["GROUP_OBJECT", 0x10000000],["NON_SECURITY_GROUP_OBJECT", 0x10000001], _
			["ALIAS_OBJECT", 0x20000000],["NON_SECURITY_ALIAS_OBJECT", 0x20000001],["USER_OBJECT", 0x30000000],["NORMAL_USER_ACCOUNT", 0x30000000], _
			["MACHINE_ACCOUNT", 0x30000001],["TRUST_ACCOUNT", 0x30000002],["APP_BASIC_GROUP", 0x40000000],["APP_QUERY_GROUP", 0x40000001], _
			["ACCOUNT_TYPE_MAX", 0x7fffffff]]
	Local $aAD_UAC[21][2] = [[0x00000001, "SCRIPT"],[0x00000002, "ACCOUNTDISABLE"],[0x00000008, "HOMEDIR_REQUIRED"],[0x00000010, "LOCKOUT"],[0x00000020, "PASSWD_NOTREQD"], _
			[0x00000040, "PASSWD_CANT_CHANGE"],[0x00000080, "ENCRYPTED_TEXT_PASSWORD_ALLOWED"],[0x00000100, "TEMP_DUPLICATE_ACCOUNT"],[0x00000200, "NORMAL_ACCOUNT"], _
			[0x00000800, "INTERDOMAIN_TRUST_ACCOUNT"],[0x00001000, "WORKSTATION_TRUST_ACCOUNT"],[0x00002000, "SERVER_TRUST_ACCOUNT"],[0x00010000, "DONT_EXPIRE_PASSWD"], _
			[0x00020000, "MNS_LOGON_ACCOUNT"],[0x00040000, "SMARTCARD_REQUIRED"],[0x00080000, "TRUSTED_FOR_DELEGATION"],[0x00100000, "NOT_DELEGATED"], _
			[0x00200000, "USE_DES_KEY_ONLY"],[0x00400000, "DONT_REQUIRE_PREAUTH"],[0x00800000, "PASSWORD_EXPIRED"],[0x01000000, "TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION"]]

	$sAD_Properties = "," & StringReplace($sAD_Properties, " ", "") & ","
	If Not IsObj($sAD_Object) Then
		If _AD_ObjectExists($sAD_Object) = 0 Then Return SetError(1, 0, "")
		Local $sAD_Property = "sAMAccountName"
		If StringMid($sAD_Object, 3, 1) = "=" Then $sAD_Property = "distinguishedName"; FQDN provided
		$sAD_Query = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(" & $sAD_Property & "=" & $sAD_Object & ");ADsPath;subtree"
		Local $oAD_RecordSet = $oAD_Connection.Execute($sAD_Query) ; Retrieve the ADsPath for the object
		Local $sAD_LDAPEntry = $oAD_RecordSet.fields(0).value
		$oAD_Object = _AD_ObjGet($sAD_LDAPEntry) ; Retrieve the COM Object
	Else
		$oAD_Object = $sAD_Object
	EndIf
	$oAD_Object.GetInfo()
	Local $iCount1 = $oAD_Object.PropertyCount()
	For $iCount2 = 0 To $iCount1 - 1
		$oAD_Item = $oAD_Object.Item($iCount2)
		If Not ($sAD_Properties = ",," Or StringInStr($sAD_Properties, "," & $oAD_Item.Name & ",") > 0) Then ContinueLoop
		$oAD_PropertyEntry = $oAD_Object.GetPropertyItem($oAD_Item.Name, $ADSTYPE_UNKNOWN)
		If IsObj($oAD_PropertyEntry) = 0 Then
			Return SetError(2, 0, $oAD_Item.Name)
		Else
			For $vAD_PropertyValue In $oAD_PropertyEntry.Values
				ReDim $aAD_ObjectProperties[UBound($aAD_ObjectProperties, 1) + 1][2]
				$iCount3 = UBound($aAD_ObjectProperties, 1) - 1
				$aAD_ObjectProperties[$iCount3][0] = $oAD_Item.Name
				If $oAD_Item.ADsType = $ADSTYPE_CASE_IGNORE_STRING Then
					$aAD_ObjectProperties[$iCount3][1] = $vAD_PropertyValue.CaseIgnoreString
				ElseIf $oAD_Item.ADsType = $ADSTYPE_INTEGER Then
					If $oAD_Item.Name = "sAMAccountType" Then
						For $iCount4 = 0 To 11
							If $vAD_PropertyValue.Integer = $aAD_SAMAccountType[$iCount4][1] Then
								$aAD_ObjectProperties[$iCount3][1] = $aAD_SAMAccountType[$iCount4][0]
								ExitLoop
							EndIf
						Next
					ElseIf $oAD_Item.Name = "userAccountControl" Then
						$aAD_ObjectProperties[$iCount3][1] = $vAD_PropertyValue.Integer & " = "
						For $iCount4 = 0 To 20
							If BitAND($vAD_PropertyValue.Integer, $aAD_UAC[$iCount4][0]) = $aAD_UAC[$iCount4][0] Then
								$aAD_ObjectProperties[$iCount3][1] &= $aAD_UAC[$iCount4][1] & " - "
							EndIf
						Next
						If StringRight($aAD_ObjectProperties[$iCount3][1], 3) = " - " Then $aAD_ObjectProperties[$iCount3][1] = StringTrimRight($aAD_ObjectProperties[$iCount3][1], 3)
					Else
						$aAD_ObjectProperties[$iCount3][1] = $vAD_PropertyValue.Integer
					EndIf
				ElseIf $oAD_Item.ADsType = $ADSTYPE_LARGE_INTEGER Then
					If $oAD_Item.Name = "pwdLastSet" Or $oAD_Item.Name = "accountExpires" Or $oAD_Item.Name = "lastLogonTimestamp" Or $oAD_Item.Name = "badPasswordTime" Or $oAD_Item.Name = "lastLogon" Or $oAD_Item.Name = "lockoutTime" Then
						If $vAD_PropertyValue.LargeInteger.LowPart = 0 And $vAD_PropertyValue.LargeInteger.HighPart = 0 Then
							$aAD_ObjectProperties[$iCount3][1] = "1601/01/01 00:00:00"
						Else
							Local $sAD_Temp = DllStructCreate("dword low;dword high")
							DllStructSetData($sAD_Temp, "Low", $vAD_PropertyValue.LargeInteger.LowPart)
							DllStructSetData($sAD_Temp, "High", $vAD_PropertyValue.LargeInteger.HighPart)
							Local $sAD_Temp2 = _Date_Time_FileTimeToSystemTime(DllStructGetPtr($sAD_Temp))
							Local $sAD_Temp3 = _Date_Time_SystemTimeToTzSpecificLocalTime(DllStructGetPtr($sAD_Temp2))
							$aAD_ObjectProperties[$iCount3][1] = _Date_Time_SystemTimeToDateTimeStr($sAD_Temp3, 1)
						EndIf
					Else
						$aAD_ObjectProperties[$iCount3][1] = _AD_LargeInt2Double($vAD_PropertyValue.LargeInteger.LowPart, $vAD_PropertyValue.LargeInteger.HighPart)
					EndIf
				ElseIf $oAD_Item.ADsType = $ADSTYPE_OCTET_STRING Then
					$xAD_Dummy = DllStructCreate("byte[56]")
					DllStructSetData($xAD_Dummy, 1, $vAD_PropertyValue.OctetString)
					; objectSID etc. See: http://msdn.microsoft.com/en-us/library/aa379597(VS.85).aspx
					; objectGUID etc. See: http://www.autoitscript.com/forum/index.php?showtopic=106163&view=findpost&p=767558
					If _Security__IsValidSid(DllStructGetPtr($xAD_Dummy)) Then
						$aAD_ObjectProperties[$iCount3][1] = _Security__SidToStringSid(DllStructGetPtr($xAD_Dummy)) ; SID
					Else
						$aAD_ObjectProperties[$iCount3][1] = _WinAPI_StringFromGUID(DllStructGetPtr($xAD_Dummy)) ; GUID
					EndIf
				ElseIf $oAD_Item.ADsType = $ADSTYPE_DN_STRING Then
					$aAD_ObjectProperties[$iCount3][1] = $vAD_PropertyValue.DNString
				ElseIf $oAD_Item.ADsType = $ADSTYPE_UTC_TIME Then
					Local $iAD_DateTime = $vAD_PropertyValue.UTCTime
					$aAD_ObjectProperties[$iCount3][1] = StringLeft($iAD_DateTime, 4) & "/" & StringMid($iAD_DateTime, 5, 2) & "/" & StringMid($iAD_DateTime, 7, 2) & _
							" " & StringMid($iAD_DateTime, 9, 2) & ":" & StringMid($iAD_DateTime, 11, 2) & ":" & StringMid($iAD_DateTime, 13, 2)
				ElseIf $oAD_Item.ADsType = $ADSTYPE_BOOLEAN Then
					If $vAD_PropertyValue.Boolean = 0 Then
						$aAD_ObjectProperties[$iCount3][1] = "False"
					Else
						$aAD_ObjectProperties[$iCount3][1] = "True"
					EndIf
				ElseIf $oAD_Item.ADsType = $ADSTYPE_NT_SECURITY_DESCRIPTOR Then
					$oAD_Value = $vAD_PropertyValue.SecurityDescriptor
					$aAD_ObjectProperties[$iCount3][1] = "Control:" & $oAD_Value.Control & ", " & _
							"Group:" & $oAD_Value.Group & ", " & _
							"Owner:" & $oAD_Value.Owner & ", " & _
							"Revision:" & $oAD_Value.Revision
				Else
					$aAD_ObjectProperties[$iCount3][1] = "Has the unknown ADsType: " & $oAD_Item.ADsType
				EndIf
			Next
		EndIf
	Next
	$aAD_ObjectProperties[0][0] = UBound($aAD_ObjectProperties, 1) - 1
	_ArraySort($aAD_ObjectProperties, 0, 1)
	Return $aAD_ObjectProperties

EndFunc   ;==>_AD_GetObjectProperties

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_CreateOU
; Description ...: Creates a child OU in the specified parent OU.
; Syntax.........: _AD_CreateOU($sAD_ParentOU, $sAD_OU)
; Parameters ....: $sAD_ParentOU - Parent OU where the new OU will be created (FQDN)
;                  $sAD_OU - OU to create in the the parent OU (Name without leading "OU=")
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_ParentOU does not exist
;                  |2 - $sAD_OU in $sAD_ParentOU already exists
;                  |3 - $sAD_OU is missing
;                  |x - Error returned by SetInfo function (Missing permission etc.)
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: This does not create any attributes for the OU. Use function _AD_ModifyAttribute.
; Related .......: _AD_CreateUser, _AD_CreateGroup, _AD_AddUserToGroup, _AD_RemoveUserFromGroup
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_CreateOU($sAD_ParentOU, $sAD_OU)

	If Not _AD_ObjectExists($sAD_ParentOU, "distinguishedName") Then Return SetError(1, 0, 0)
	If _AD_ObjectExists("OU=" & $sAD_OU & "," & $sAD_ParentOU, "distinguishedName") Then Return SetError(2, 0, 0)
	If $sAD_OU = "" Then Return SetError(3, 0, 0)

	Local $oAD_ParentOU = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_ParentOU)
	Local $oAD_OU = $oAD_ParentOU.Create("organizationalUnit", "OU=" & $sAD_OU)
	$oAD_OU.SetInfo
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_CreateOU

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_CreateUser
; Description ...: Creates and activates a user in the specified OU.
; Syntax.........: _AD_CreateUser($sAD_OU, $sAD_User, $sAD_CN)
; Parameters ....: $sAD_OU - OU to create the user in. Form is "OU=sampleou,OU=sampleparent,DC=sampledomain1,DC=sampledomain2"
;                  $sAD_User - Username, form is SamAccountName without leading 'CN='
;                  $sAD_CN - Common Name (without CN=) or RDN (Relative Distinguished Name) like "Lastname Firstname"
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_User already exists
;                  |2 - $sAD_OU does not exist
;                  |3 - $sAD_CN is missing
;                  |4 - $sAD_User is missing
;                  |x - Error returned by SetInfo function (Missing permission etc.)
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: This function only sets sAMAccountName (= $sAD_User) and userPrincipalName (e.g. $sAD_User@microsoft.com).
;                  All other attributes have to be set using function _AD_ModifyAttribute
; Related .......: _AD_CreateOU, _AD_CreateGroup, _AD_AddUserToGroup, _AD_RemoveUserFromGroup
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_CreateUser($sAD_OU, $sAD_User, $sAD_CN)

	If _AD_ObjectExists($sAD_User) Then Return SetError(1, 0, 0)
	If Not _AD_ObjectExists($sAD_OU, "distinguishedName") Then Return SetError(2, 0, 0)
	If $sAD_CN = "" Then Return SetError(3, 0, 0)
	If $sAD_User = "" Then Return SetError(4, 0, 0)

	Local $oAD_OU = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_OU)
	Local $oAD_User = $oAD_OU.Create("User", "CN=" & $sAD_CN)
	$oAD_User.sAMAccountName = $sAD_User
	$oAD_User.userPrincipalName = $sAD_User & "@" & StringTrimLeft(StringReplace($sAD_DNSDomain, ",DC=", "."), 3)
	$oAD_User.pwdLastSet = -1
	$oAD_User.SetInfo
	If @error <> 0 Then Return SetError(@error, 0, 0)
	$oAD_User.AccountDisabled = False ; Activate User
	$oAD_User.SetInfo
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_CreateUser

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_SetPassword
; Description ...: Sets a user's password, or clears it if no password is passed to the function.
; Syntax.........: _AD_SetPassword($sAD_User[, $sAD_Password=""[, $iAD_Expired = 0]])
; Parameters ....: $sAD_User - User for which to set the password (FQDN or sAMAccountName)
;                  $sAD_Password - Optional: Password to be set for $sAD_User. If $sAD_Password is "" then the password will be cleared (default)
;                  $iAD_Expired - Optional: 1 = the password has to be changed at next logon (Default = 0)
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_User does not exist
;                  |x - Error returned by SetInfo function (Missing permission etc.)
; Author ........: KenE
; Modified.......: water
; Remarks .......:
; Related .......: _AD_IsPasswordExpired, _AD_GetPasswordExpired, _AD_GetPasswordDontExpire, _AD_DisablePasswordExpire, _AD_EnablePasswordExpire, _AD_EnablePasswordChange,  _AD_DisablePasswordChange, _AD_GetPasswordInfo
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_SetPassword($sAD_User, $sAD_Password = "", $iAD_Expired = 0)

	If Not _AD_ObjectExists($sAD_User) Then Return SetError(1, 0, 0)
	If StringMid($sAD_User, 3, 1) <> "=" Then $sAD_User = _AD_SamAccountNameToFQDN($sAD_User) ; sAMACccountName provided
	Local $oAD_User = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_User)
	$oAD_User.SetPassword($sAD_Password)
	If $iAD_Expired Then $oAD_User.Put("pwdLastSet", 0)
	$oAD_User.SetInfo()
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_SetPassword

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_CreateGroup
; Description ...: Creates a group in the specified OU.
; Syntax.........: _AD_CreateGroup($sAD_OU, $sAD_Group[, $iAD_Type = $ADS_GROUP_TYPE_GLOBAL_SECURITY])
; Parameters ....: $sAD_OU - OU to create the group in. Form is "OU=sampleou,OU=sampleparent,DC=sampledomain1,DC=sampledomain2" (FQDN)
;                  $sAD_Group - Groupname, form is SamAccountName without leading 'CN='
;                  $iAD_Type - Optional: Group type (default = $ADS_GROUP_TYPE_GLOBAL_SECURITY). NOTE: Global security must be 'BitOr'ed with a scope.
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_Group already exists
;                  |2 - $sAD_OU does not exist
;                  |x - Error returned by SetInfo function (Missing permission etc.)
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: This function only sets sAMAccountName and grouptype. All other attributes have to be set using
;                  function _AD_ModifyAttribute
; Related .......: _AD_CreateOU, _AD_CreateUser, _AD_AddUserToGroup, _AD_RemoveUserFromGroup
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_CreateGroup($sAD_OU, $sAD_Group, $iAD_Type = $ADS_GROUP_TYPE_GLOBAL_SECURITY)

	If _AD_ObjectExists($sAD_Group) Then Return SetError(1, 0, 0)
	If Not _AD_ObjectExists($sAD_OU, "distinguishedName") Then Return SetError(2, 0, 0)

	Local $sAD_CN = "CN=" & $sAD_Group
	$sAD_CN = _AD_FixSpecialChars($sAD_CN)
	Local $oAD_OU = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_OU)
	Local $oAD_Group = $oAD_OU.Create("Group", $sAD_CN)
	Local $sAD_SamAccountName = StringReplace($sAD_Group, ",", "")
	$sAD_SamAccountName = StringReplace($sAD_SamAccountName, "#", "")
	$sAD_SamAccountName = StringReplace($sAD_SamAccountName, "/", "")
	$oAD_Group.sAMAccountName = $sAD_SamAccountName
	$oAD_Group.grouptype = $iAD_Type
	$oAD_Group.SetInfo
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_CreateGroup

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_AddUserToGroup
; Description ...: Adds the user to the specified group.
; Syntax.........: _AD_AddUserToGroup($sAD_Group, $sAD_User)
; Parameters ....: $sAD_Group - Groupname (FQDN or sAMAccountName)
;                  $sAD_User - Username (FQDN or sAMAccountName)
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_Group does not exist
;                  |2 - $sAD_User does not exist
;                  |3 - $sAD_User is already a member of $sAD_Group
;                  |x - Error returned by SetInfo function (Missing permission etc.)
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: Works for both computers and groups. The sAMAccountname of a computer requires a trailing "$" before converting it to a FQDN.
; Related .......: _AD_CreateOU, _AD_CreateUser, _AD_CreateGroup, _AD_RemoveUserFromGroup
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_AddUserToGroup($sAD_Group, $sAD_User)

	If Not _AD_ObjectExists($sAD_Group) Then Return SetError(1, 0, 0)
	If Not _AD_ObjectExists($sAD_User) Then Return SetError(2, 0, 0)
	If _AD_IsMemberOf($sAD_Group, $sAD_User) Then Return SetError(3, 0, 0)
	If StringMid($sAD_Group, 3, 1) <> "=" Then $sAD_Group = _AD_SamAccountNameToFQDN($sAD_Group) ; sAMACccountName provided
	If StringMid($sAD_User, 3, 1) <> "=" Then $sAD_User = _AD_SamAccountNameToFQDN($sAD_User) ; sAMACccountName provided
	Local $oAD_User = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_User) ; Retrieve the COM Object for the user
	Local $oAD_Group = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_Group) ; Retrieve the COM Object for the group
	$oAD_Group.Add($oAD_User.AdsPath)
	$oAD_Group.SetInfo
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_AddUserToGroup

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_RemoveUserFromGroup
; Description ...: Removes the user from the specified group.
; Syntax.........: _AD_RemoveUserFromGroup($sAD_Group, $sAD_User)
; Parameters ....: $sAD_Group - Groupname (FQDN or sAMAccountName)
;                  $sAD_User - Username (FQDN or sAMAccountName)
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_Group does not exist
;                  |2 - $sAD_User does not exist
;                  |3 - $sAD_User is not a member of $sAD_Group
;                  |x - Error returned by SetInfo Function(Missing permission etc.)
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: Works for computer objects as well. Remember that the sAMAccountname of a computer needs a trailing "$" before converting it to a FQDN.
; Related .......: _AD_CreateOU, _AD_CreateUser, _AD_CreateGroup, _AD_AddUserToGroup
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_RemoveUserFromGroup($sAD_Group, $sAD_User)

	If Not _AD_ObjectExists($sAD_Group) Then Return SetError(1, 0, 0)
	If Not _AD_ObjectExists($sAD_User) Then Return SetError(2, 0, 0)
	If Not _AD_IsMemberOf($sAD_Group, $sAD_User) Then Return SetError(3, 0, 0)
	If StringMid($sAD_Group, 3, 1) <> "=" Then $sAD_Group = _AD_SamAccountNameToFQDN($sAD_Group) ; sAMACccountName provided
	If StringMid($sAD_User, 3, 1) <> "=" Then $sAD_User = _AD_SamAccountNameToFQDN($sAD_User) ; sAMACccountName provided
	Local $oAD_User = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_User) ; Retrieve the COM Object for the user
	Local $oAD_Group = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_Group) ; Retrieve the COM Object for the group
	$oAD_Group.Remove($oAD_User.AdsPath)
	$oAD_Group.SetInfo
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_RemoveUserFromGroup

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_CreateComputer
; Description ...: Creates and enables a computer account. A specific, authenticated user/group can then use this account to add his or her workstation to the domain.
; Syntax.........: _AD_CreateComputer($sAD_OU, $sAD_Computer, $sAD_User)
; Parameters ....: $sAD_OU - OU to create the computer in. Form is "OU=sampleou,OU=sampleparent,DC=sampledomain1,DC=sampledomain2" (FQDN)
;                  $sAD_Computer - Computername, form is SamAccountName without trailing "$"
;                  $sAD_User - User or group that will be allowed to add the computer to the domain (SamAccountName)
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_OU does not exist
;                  |2 - $sAD_Computer already defined in $sAD_OU
;                  |3 - $sAD_User does not exist
;                  |x - Error returned by SetInfo Function(Missing permission etc.)
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: By default, any authenticated user can create up to 10 computer accounts in the domain.
;                  (see: http://technet.microsoft.com/en-us/library/cc780195(WS.10).aspx)
;                  To create the Access Control List you need further rights. If this right is missing you might be able to add the
;                  computer to the domain but the function will exit with failure and the ACL is not set.
;                  The specified user/group has the following rights on the defined computer:
; Related .......: _AD_CreateOU, _AD_JoinDomain
; Link ..........: http://www.wisesoft.co.uk/scripts/vbscript_create_a_computer_account_for_a_specific_user.aspx
; Example .......: Yes
; ===============================================================================================================================
Func _AD_CreateComputer($sAD_OU, $sAD_Computer, $sAD_User)

	If Not _AD_ObjectExists($sAD_OU) Then Return SetError(1, 0, 0)
	If _AD_ObjectExists("CN=" & $sAD_Computer & "," & $sAD_OU) Then Return SetError(2, 0, 0)
	If Not _AD_ObjectExists($sAD_User) Then Return SetError(3, 0, 0)
	If StringMid($sAD_OU, 3, 1) <> "=" Then $sAD_OU = _AD_SamAccountNameToFQDN($sAD_OU) ; sAMACccountName provided
	If StringMid($sAD_User, 3, 1) = "=" Then $sAD_User = _AD_FQDNToSamAccountName($sAD_User) ; FQDN provided
	Local $oAD_Container = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_OU)
	Local $oAD_Computer = $oAD_Container.Create("Computer", "cn=" & $sAD_Computer)
	$oAD_Computer.Put("sAMAccountName", $sAD_Computer & "$")
	$oAD_Computer.Put("userAccountControl", BitOR($ADS_UF_PASSWD_NOTREQD, $ADS_UF_WORKSTATION_TRUST_ACCOUNT))
	$oAD_Computer.SetInfo
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Local $oAD_SD = $oAD_Computer.Get("ntSecurityDescriptor")
	Local $oAD_DACL = $oAD_SD.DiscretionaryAcl
	Local $oAD_ACE1 = ObjCreate("AccessControlEntry")
	$oAD_ACE1.Trustee = $sAD_User
	$oAD_ACE1.AccessMask = $ADS_RIGHT_GENERIC_READ
	$oAD_ACE1.AceFlags = 0
	$oAD_ACE1.AceType = $ADS_ACETYPE_ACCESS_ALLOWED
	Local $oAD_ACE2 = ObjCreate("AccessControlEntry")
	$oAD_ACE2.Trustee = $sAD_User
	$oAD_ACE2.AccessMask = $ADS_RIGHT_DS_CONTROL_ACCESS
	$oAD_ACE2.AceFlags = 0
	$oAD_ACE2.AceType = $ADS_ACETYPE_ACCESS_ALLOWED_OBJECT
	$oAD_ACE2.Flags = $ADS_FLAG_OBJECT_TYPE_PRESENT
	$oAD_ACE2.ObjectType = $ALLOWED_TO_AUTHENTICATE
	Local $oAD_ACE3 = ObjCreate("AccessControlEntry")
	$oAD_ACE3.Trustee = $sAD_User
	$oAD_ACE3.AccessMask = $ADS_RIGHT_DS_CONTROL_ACCESS
	$oAD_ACE3.AceFlags = 0
	$oAD_ACE3.AceType = $ADS_ACETYPE_ACCESS_ALLOWED_OBJECT
	$oAD_ACE3.Flags = $ADS_FLAG_OBJECT_TYPE_PRESENT
	$oAD_ACE3.ObjectType = $RECEIVE_AS
	Local $oAD_ACE4 = ObjCreate("AccessControlEntry")
	$oAD_ACE4.Trustee = $sAD_User
	$oAD_ACE4.AccessMask = $ADS_RIGHT_DS_CONTROL_ACCESS
	$oAD_ACE4.AceFlags = 0
	$oAD_ACE4.AceType = $ADS_ACETYPE_ACCESS_ALLOWED_OBJECT
	$oAD_ACE4.Flags = $ADS_FLAG_OBJECT_TYPE_PRESENT
	$oAD_ACE4.ObjectType = $SEND_AS
	Local $oAD_ACE5 = ObjCreate("AccessControlEntry")
	$oAD_ACE5.Trustee = $sAD_User
	$oAD_ACE5.AccessMask = $ADS_RIGHT_DS_CONTROL_ACCESS
	$oAD_ACE5.AceFlags = 0
	$oAD_ACE5.AceType = $ADS_ACETYPE_ACCESS_ALLOWED_OBJECT
	$oAD_ACE5.Flags = $ADS_FLAG_OBJECT_TYPE_PRESENT
	$oAD_ACE5.ObjectType = $USER_CHANGE_PASSWORD
	Local $oAD_ACE6 = ObjCreate("AccessControlEntry")
	$oAD_ACE6.Trustee = $sAD_User
	$oAD_ACE6.AccessMask = $ADS_RIGHT_DS_CONTROL_ACCESS
	$oAD_ACE6.AceFlags = 0
	$oAD_ACE6.AceType = $ADS_ACETYPE_ACCESS_ALLOWED_OBJECT
	$oAD_ACE6.Flags = $ADS_FLAG_OBJECT_TYPE_PRESENT
	$oAD_ACE6.ObjectType = $USER_FORCE_CHANGE_PASSWORD
	Local $oAD_ACE7 = ObjCreate("AccessControlEntry")
	$oAD_ACE7.Trustee = $sAD_User
	$oAD_ACE7.AccessMask = $ADS_RIGHT_DS_WRITE_PROP
	$oAD_ACE7.AceFlags = 0
	$oAD_ACE7.AceType = $ADS_ACETYPE_ACCESS_ALLOWED_OBJECT
	$oAD_ACE7.Flags = $ADS_FLAG_OBJECT_TYPE_PRESENT
	$oAD_ACE7.ObjectType = $USER_ACCOUNT_RESTRICTIONS
	Local $oAD_ACE8 = ObjCreate("AccessControlEntry")
	$oAD_ACE8.Trustee = $sAD_User
	$oAD_ACE8.AccessMask = $ADS_RIGHT_DS_SELF
	$oAD_ACE8.AceFlags = 0
	$oAD_ACE8.AceType = $ADS_ACETYPE_ACCESS_ALLOWED_OBJECT
	$oAD_ACE8.Flags = $ADS_FLAG_OBJECT_TYPE_PRESENT
	$oAD_ACE8.ObjectType = $VALIDATED_DNS_HOST_NAME
	Local $oAD_ACE9 = ObjCreate("AccessControlEntry")
	$oAD_ACE9.Trustee = $sAD_User
	$oAD_ACE9.AccessMask = $ADS_RIGHT_DS_SELF
	$oAD_ACE9.AceFlags = 0
	$oAD_ACE9.AceType = $ADS_ACETYPE_ACCESS_ALLOWED_OBJECT
	$oAD_ACE9.Flags = $ADS_FLAG_OBJECT_TYPE_PRESENT
	$oAD_ACE9.ObjectType = $VALIDATED_SPN
	$oAD_DACL.AddAce($oAD_ACE1)
	$oAD_DACL.AddAce($oAD_ACE2)
	$oAD_DACL.AddAce($oAD_ACE3)
	$oAD_DACL.AddAce($oAD_ACE4)
	$oAD_DACL.AddAce($oAD_ACE5)
	$oAD_DACL.AddAce($oAD_ACE6)
	$oAD_DACL.AddAce($oAD_ACE7)
	$oAD_DACL.AddAce($oAD_ACE8)
	$oAD_DACL.AddAce($oAD_ACE9)
	$oAD_SD.DiscretionaryAcl = $oAD_DACL
	$oAD_Computer.Put("ntSecurityDescriptor", $oAD_SD)
	$oAD_Computer.SetInfo
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_CreateComputer

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_ModifyAttribute
; Description ...: Modifies an attribute of the given object to the value specified.
; Syntax.........: _AD_ModifyAttribute($sAD_Object, $sAD_Attribute[, $sAD_Value = ""[, $iAD_Option = 1]])
; Parameters ....: $sAD_Object - Object (user, group) to add/delete/modify an attribute (sAMAccountName or FQDN)
;                  $sAD_Attribute - Attribute to add/delete/modify
;                  $sAD_Value - Optional: Value to modify the attribute to. Use a blank string ("") to delete the attribute (default).
;                  +$sAD_Value can be a single value (as a string) or a multi-value (as a one-dimensional array)
;                  $iAD_Option - Optional: Indicates the mode of modification: Append, Replace, Remove, and Delete
;                  |1 - CLEAR: remove all the property value(s) from the object (default)
;                  |2 - UPDATE: replace the current value(s) with the specified value(s)
;                  |3 - APPEND: append the specified value(s) to the existing values(s)
;                  |4 - DELETE: delete the specified value(s) from the object
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_Object does not exist
;                  |x - Error returned by SetInfo function (Missing permission etc.)
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......:
; Related .......: _AD_GetObjectAttribute, _AD_GetObjectProperties
; Link ..........: http://msdn.microsoft.com/en-us/library/aa746353(VS.85).aspx (ADS_PROPERTY_OPERATION_ENUM Enumeration)
; Example .......: Yes
; ===============================================================================================================================
Func _AD_ModifyAttribute($sAD_Object, $sAD_Attribute, $sAD_Value = "", $iAD_Option = 1)

	If Not _AD_ObjectExists($sAD_Object) Then Return SetError(1, 0, 0)
	Local $sAD_Property = "sAMAccountName"
	If StringMid($sAD_Object, 3, 1) = "=" Then $sAD_Property = "distinguishedName"; FQDN provided
	Local $sAD_Query = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(" & $sAD_Property & "=" & $sAD_Object & ");ADsPath;subtree"
	Local $oAD_RecordSet = $oAD_Connection.Execute($sAD_Query) ; Retrieve the ADsPath for the object
	Local $sAD_LDAPEntry = $oAD_RecordSet.fields(0).value
	Local $oAD_Object = _AD_ObjGet($sAD_LDAPEntry) ; Retrieve the COM Object for the object
	$oAD_Object.GetInfo
	If $sAD_Value = "" Then
		$oAD_Object.PutEx(1, $sAD_Attribute, 0) ; CLEAR: remove all the property value(s) from the object
	ElseIf $iAD_Option = 3 Then
		$oAD_Object.PutEx(3, $sAD_Attribute, $sAD_Value) ; APPEND: append the specified value(s) to the existing values(s)
	ElseIf IsArray($sAD_Value) Then
		$oAD_Object.PutEx(2, $sAD_Attribute, $sAD_Value) ; UPDATE: replace the current value(s) with the specified value(s)
	Else
		$oAD_Object.Put($sAD_Attribute, $sAD_Value) ; sets the value(s) of an attribute
	EndIf
	$oAD_Object.SetInfo
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_ModifyAttribute

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_RenameObject
; Description ...: Renames an object within an OU.
; Syntax.........: _AD_RenameObject($sAD_Object, $sAD_DisplayName)
; Parameters ....: $sAD_Object - Object (user, group, computer) to rename (FQDN or sAMAccountName)
;                  $sAD_DisplayName - New Name (DisplayName) of the object in the current OU without CN=.
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_Object does not exist
;                  |x - Error returned by MoveHere function (Missing permission etc.)
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: Renames an object within the same OU. You can not move objects to another OU with this function.
; Related .......: _AD_MoveObject, _AD_DeleteObject
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_RenameObject($sAD_Object, $sAD_DisplayName)

	If Not _AD_ObjectExists($sAD_Object) Then Return SetError(1, 0, 0)
	If StringMid($sAD_Object, 3, 1) <> "=" Then $sAD_Object = _AD_SamAccountNameToFQDN($sAD_Object) ; sAMAccountName provided
	Local $sAD_OU = StringTrimLeft($sAD_Object, StringInStr($sAD_Object, "OU=") - 1)
	Local $oAD_OU = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_OU) ; Pointer to the destination container
	$sAD_DisplayName = _AD_FixSpecialChars($sAD_DisplayName)
	$oAD_OU.MoveHere("LDAP://" & $sAD_HostServer & "/" & $sAD_Object, "CN=" & $sAD_DisplayName)
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_RenameObject

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_MoveObject
; Description ...: Moves an object to another OU.
; Syntax.........: _AD_MoveObject($sAD_OU, $sAD_Object[, $sAD_DisplayName = ""])
; Parameters ....: $sAD_OU - Target OU for the object move (FQDN)
;                  $sAD_Object - Object (user, group, computer) to move (FQDN or sAMAccountName)
;                  $sAD_CN - Optional: New Name of the object in the target OU. Common Name or RDN (Relative Distinguished Name) like "Lastname Firstname" without leading "CN="
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_OU does not exist
;                  |2 - $sAD_Object does not exist
;                  |3 - Object already exists in the target OU
;                  |x - Error returned by MoveHere function (Missing permission etc.)
; Author ........: water
; Modified.......:
; Remarks .......: You must escape commas in $sAD_Object with a backslash. E.g. "CN=Lastname\, Firstname,OU=..."
; Related .......: _AD_RenameObject, _AD_DeleteObject
; Link ..........: http://msdn.microsoft.com/en-us/library/aa705991(v=VS.85).aspx
; Example .......: Yes
; ===============================================================================================================================
Func _AD_MoveObject($sAD_OU, $sAD_Object, $sAD_CN = "")

	If Not _AD_ObjectExists($sAD_OU, "distinguishedName") Then Return SetError(1, 0, 0)
	If Not _AD_ObjectExists($sAD_Object) Then Return SetError(2, 0, 0)
	If StringMid($sAD_Object, 3, 1) <> "=" Then $sAD_Object = _AD_SamAccountNameToFQDN($sAD_Object) ; sAMAccountName provided
	If $sAD_CN = "" Then
		$sAD_CN = "CN=" & _AD_GetObjectAttribute($sAD_Object, "cn")
	Else
		$sAD_CN = "CN=" & $sAD_CN
	EndIf
	$sAD_CN = _AD_FixSpecialChars($sAD_CN) ; escape all special characters
	If _AD_ObjectExists($sAD_CN & "," & $sAD_OU, "distinguishedName") Then Return SetError(3, 0, 0)
	Local $oAD_OU = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_OU) ; Pointer to the destination container
	$oAD_OU.MoveHere("LDAP://" & $sAD_HostServer & "/" & $sAD_Object, $sAD_CN)
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_MoveObject

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_DeleteObject
; Description ...: Deletes the specified object.
; Syntax.........: _AD_DeleteObject($sAD_Object, $sAD_Class)
; Parameters ....: $sAD_Object - Object (user, group, computer) to delete (FQDN or sAMAccountName)
;                  $sAD_Class - The schema class object to delete ("user", "computer", "group", "contact" etc). Can be derived using _AD_GetObjectClass().
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_Object does not exist
;                  |x - Error returned by Delete function (Missing permission etc.)
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......:
; Related .......: _AD_RenameObject, _AD_MoveObject
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_DeleteObject($sAD_Object, $sAD_Class)

	If Not _AD_ObjectExists($sAD_Object) Then Return SetError(1, 0, 0)
	If StringMid($sAD_Object, 3, 1) <> "=" Then $sAD_Object = _AD_SamAccountNameToFQDN($sAD_Object) ; sAMAccountName provided
	Local $iAD_Index = StringInStr($sAD_Object, "OU=")
	Local $sAD_OU = StringTrimLeft($sAD_Object, $iAD_Index - 1) ; Strip OU from FQDN
	Local $sAD_DisplayName = StringLeft($sAD_Object, $iAD_Index - 2) ; Strip DisplayName from FQDN
	$sAD_DisplayName = _AD_FixSpecialChars($sAD_DisplayName)
	Local $oAD_OU = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_OU)
	$oAD_OU.Delete($sAD_Class, $sAD_DisplayName)
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_DeleteObject

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_SetAccountExpire
; Description ...: Modifies the specified user or computer account expiration date/time or sets the account to never expire.
; Syntax.........: _AD_SetAccountExpire($sAD_Object, $sAD_DateTime)
; Parameters ....: $sAD_Object - User or computer account to set expiration date/time (sAMAccountName or FQDN)
;                  $sAD_DateTime - Expiration date/time in format: yyyy-mm-dd hh:mm:ss (local time) or "01/01/1970" to never expire
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_Object does not exist
;                  |x - Error returned by SetInfo function (Missing permission etc.)
; Author ........: KenE
; Modified.......: water
; Remarks .......: Use the following syntax for the date/time:
;                  01/01/1970 = never expire
;                  yyyy-mm-dd hh:mm:ss= "international format" - always works
;                  xx/xx/xx <time> = "localized format" - the format depends on the local date/time settings
; Related .......:
; Link ..........: http://www.rlmueller.net/AccountExpires.htm
; Example .......: Yes
; ===============================================================================================================================
Func _AD_SetAccountExpire($sAD_Object, $sAD_DateTime)

	If Not _AD_ObjectExists($sAD_Object) Then Return SetError(1, 0, 0)
	If StringMid($sAD_Object, 3, 1) <> "=" Then $sAD_Object = _AD_SamAccountNameToFQDN($sAD_Object) ; sAMAccountName provided
	Local $oAD_Object = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_Object)
	$oAD_Object.AccountExpirationDate = $sAD_DateTime
	$oAD_Object.SetInfo
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_SetAccountExpire

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_DisablePasswordExpire
; Description ...: Modifies specified users password to not expire.
; Syntax.........: _AD_DisablePasswordExpire($sAD_Object)
; Parameters ....: $sAD_Object - User account to disable password expiration (sAMAccountName or FQDN)
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_Object does not exist
;                  |x - Error returned by SetInfo function (Missing permission etc.)
; Author ........: KenE
; Modified.......: water
; Remarks .......:
; Related .......: _AD_IsPasswordExpired, _AD_GetPasswordExpired, _AD_GetPasswordDontExpire, _AD_SetPassword, _AD_EnablePasswordChange,  _AD_DisablePasswordChange, _AD_GetPasswordInfo, _AD_EnablePasswordExpire
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_DisablePasswordExpire($sAD_Object)

	If Not _AD_ObjectExists($sAD_Object) Then Return SetError(1, 0, 0)
	If StringMid($sAD_Object, 3, 1) <> "=" Then $sAD_Object = _AD_SamAccountNameToFQDN($sAD_Object) ; sAMAccountName provided
	Local $oAD_Object = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_Object)
	Local $iAD_UAC = $oAD_Object.Get("userAccountControl")
	$oAD_Object.Put("userAccountControl", BitOR($iAD_UAC, $ADS_UF_DONT_EXPIRE_PASSWD))
	$oAD_Object.SetInfo
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_DisablePasswordExpire

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_EnablePasswordExpire
; Description ...: Sets users password to expire.
; Syntax.........: _AD_EnablePasswordExpire($sAD_Object)
; Parameters ....: $sAD_Object - User account to enable password expiration (sAMAccountName or FQDN)
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_Object does not exist
;                  |x - Error returned by SetInfo function (Missing permission etc.)
; Author ........: Joe2010
; Modified.......: water
; Remarks .......:
; Related .......: _AD_IsPasswordExpired, _AD_GetPasswordExpired, _AD_GetPasswordDontExpire, _AD_SetPassword, _AD_EnablePasswordChange,  _AD_DisablePasswordChange, _AD_GetPasswordInfo, _AD_DisablePasswordExpire
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_EnablePasswordExpire($sAD_Object)

	If Not _AD_ObjectExists($sAD_Object) Then Return SetError(1, 0, 0)
	If StringMid($sAD_Object, 3, 1) <> "=" Then $sAD_Object = _AD_SamAccountNameToFQDN($sAD_Object) ; sAMAccountName provided
	Local $oAD_Object = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_Object)
	Local $iAD_UAC = $oAD_Object.Get("userAccountControl")
	$oAD_Object.Put("userAccountControl", BitAND($iAD_UAC, BitNOT($ADS_UF_DONT_EXPIRE_PASSWD)))
	$oAD_Object.SetInfo
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_EnablePasswordExpire

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_EnablePasswordChange
; Description ...: Disables the 'User Cannot Change Password' option, allowing the user to change their password.
; Syntax.........: _AD_EnablePasswordChange($sAD_Object)
; Parameters ....: $sAD_Object - User account to enable changing the password (sAMAccountName or FQDN)
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_Object does not exist
;                  |x - Error returned by SetInfo function (Missing permission etc.)
; Author ........: KenE
; Modified.......: water
; Remarks .......:
; Related .......: _AD_IsPasswordExpired, _AD_GetPasswordExpired, _AD_GetPasswordDontExpire, _AD_SetPassword, _AD_DisablePasswordExpire, _AD_EnablePasswordExpire, _AD_DisablePasswordChange, _AD_GetPasswordInfo
; Link ..........: Example VBS see: http://gallery.technet.microsoft.com/ScriptCenter/en-us/ced14c6c-d16a-4cd8-b7d1-90d716c0445f or How to use Visual Basic and ADsSecurity.dll to properly order ACEs in an ACL. See: http://support.microsoft.com/kb/269159/en-us -
; Example .......: Yes
; ===============================================================================================================================
Func _AD_EnablePasswordChange($sAD_Object)

	If Not _AD_ObjectExists($sAD_Object) Then Return SetError(1, 0, 0)
	If StringMid($sAD_Object, 3, 1) <> "=" Then $sAD_Object = _AD_SamAccountNameToFQDN($sAD_Object) ; sAMAccountName provided
	Local $fAD_Self, $fAD_Everyone, $fAD_Modified
	Local $oAD_Object = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_Object)
	Local $oAD_SD = $oAD_Object.Get("nTSecurityDescriptor")
	Local $oAD_DACL = $oAD_SD.DiscretionaryAcl
	; Search for ACE's for Change Password and modify
	$fAD_Self = False
	$fAD_Everyone = False
	$fAD_Modified = False
	For $oAD_ACE In $oAD_DACL
		If StringUpper($oAD_ACE.objectType) = StringUpper($USER_CHANGE_PASSWORD) Then
			If StringUpper($oAD_ACE.Trustee) = "NT AUTHORITY\SELF" Then
				If $oAD_ACE.AceType = $ADS_ACETYPE_ACCESS_DENIED_OBJECT Then
					$oAD_ACE.AceType = $ADS_ACETYPE_ACCESS_ALLOWED_OBJECT
					$fAD_Modified = True
				EndIf
				$fAD_Self = True
			EndIf
			If StringUpper($oAD_ACE.Trustee) = "EVERYONE" Then
				If $oAD_ACE.AceType = $ADS_ACETYPE_ACCESS_DENIED_OBJECT Then
					$oAD_ACE.AceType = $ADS_ACETYPE_ACCESS_ALLOWED_OBJECT
					$fAD_Modified = True
				EndIf
				$fAD_Everyone = True
			EndIf
		EndIf
	Next
	; If ACE's found and modified, save changes and return
	If $fAD_Self And $fAD_Everyone Then
		If $fAD_Modified Then
			$oAD_SD.discretionaryACL = _AD_ReorderACE($oAD_DACL)
			$oAD_Object.Put("ntSecurityDescriptor", $oAD_SD)
			$oAD_Object.SetInfo
		EndIf
	Else
		; If ACE's not found, add to DACL
		If $fAD_Self = False Then
			; Create the ACE for Self
			Local $oAD_ACESelf = ObjCreate("AccessControlEntry")
			$oAD_ACESelf.Trustee = "NT AUTHORITY\SELF"
			$oAD_ACESelf.AceFlags = 0
			$oAD_ACESelf.AceType = $ADS_ACETYPE_ACCESS_ALLOWED_OBJECT
			$oAD_ACESelf.Flags = $ADS_FLAG_OBJECT_TYPE_PRESENT
			$oAD_ACESelf.objectType = $USER_CHANGE_PASSWORD
			$oAD_ACESelf.AccessMask = $ADS_RIGHT_DS_CONTROL_ACCESS
			$oAD_DACL.AddAce($oAD_ACESelf)
		EndIf
		If $fAD_Everyone = False Then
			; Create the ACE for Everyone
			Local $oAD_ACEEveryone = ObjCreate("AccessControlEntry")
			$oAD_ACEEveryone.Trustee = "Everyone"
			$oAD_ACEEveryone.AceFlags = 0
			$oAD_ACEEveryone.AceType = $ADS_ACETYPE_ACCESS_ALLOWED_OBJECT
			$oAD_ACEEveryone.Flags = $ADS_FLAG_OBJECT_TYPE_PRESENT
			$oAD_ACEEveryone.objectType = $USER_CHANGE_PASSWORD
			$oAD_ACEEveryone.AccessMask = $ADS_RIGHT_DS_CONTROL_ACCESS
			$oAD_DACL.AddAce($oAD_ACEEveryone)
		EndIf
		$oAD_SD.discretionaryACL = _AD_ReorderACE($oAD_DACL)
		; Update the user object
		$oAD_Object.Put("ntSecurityDescriptor", $oAD_SD)
		$oAD_Object.SetInfo
	EndIf
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_EnablePasswordChange

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_DisablePasswordChange
; Description ...: Enables the 'User Cannot Change Password' option, preventing the user from changing their password.
; Syntax.........: _AD_DisablePasswordChange($sAD_Object)
; Parameters ....: $sAD_Object - User account to disallow changing his password (SAMAccountNmae or FQDN)
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_Object does not exist
;                  |x - Error returned by SetInfo function (Missing permission etc.)
; Author ........: KenE
; Modified.......: water
; Remarks .......:
; Related .......: _AD_IsPasswordExpired, _AD_GetPasswordExpired, _AD_GetPasswordDontExpire, _AD_SetPassword, _AD_DisablePasswordExpire, _AD_EnablePasswordExpire, _AD_EnablePasswordChange, _AD_GetPasswordInfo
; Link ..........: How to set the "User Cannot Change Password" option by using a program. See: http://support.microsoft.com/kb/301287/en-us -
; Example .......: Yes
; ===============================================================================================================================
Func _AD_DisablePasswordChange($sAD_Object)

	If Not _AD_ObjectExists($sAD_Object) Then Return SetError(1, 0, 0)
	If StringMid($sAD_Object, 3, 1) <> "=" Then $sAD_Object = _AD_SamAccountNameToFQDN($sAD_Object) ; sAMAccountName provided
	Local $fAD_Self, $fAD_Everyone, $fAD_Modified
	Local $oAD_Object = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_Object)
	Local $oAD_SD = $oAD_Object.Get("nTSecurityDescriptor")
	Local $oAD_DACL = $oAD_SD.DiscretionaryAcl
	; Search for ACE's for Change Password and modify
	$fAD_Self = False
	$fAD_Everyone = False
	$fAD_Modified = False
	For $oAD_ACE In $oAD_DACL
		If StringUpper($oAD_ACE.objectType) = StringUpper($USER_CHANGE_PASSWORD) Then
			If StringUpper($oAD_ACE.Trustee) = "NT AUTHORITY\SELF" Then
				If $oAD_ACE.AceType = $ADS_ACETYPE_ACCESS_ALLOWED_OBJECT Then
					$oAD_ACE.AceType = $ADS_ACETYPE_ACCESS_DENIED_OBJECT
					$fAD_Modified = True
				EndIf
				$fAD_Self = True
			EndIf
			If StringUpper($oAD_ACE.Trustee) = "EVERYONE" Then
				If $oAD_ACE.AceType = $ADS_ACETYPE_ACCESS_ALLOWED_OBJECT Then
					$oAD_ACE.AceType = $ADS_ACETYPE_ACCESS_DENIED_OBJECT
					$fAD_Modified = True
				EndIf
				$fAD_Everyone = True
			EndIf
		EndIf
	Next
	; If ACE's found and modified, save changes and return
	If $fAD_Self And $fAD_Everyone Then
		If $fAD_Modified Then
			$oAD_SD.discretionaryACL = _AD_ReorderACE($oAD_DACL)
			$oAD_Object.Put("ntSecurityDescriptor", $oAD_SD)
			$oAD_Object.SetInfo
		EndIf
	Else
		; If ACE's not found, add to DACL
		If $fAD_Self = False Then
			; Create the ACE for Self
			Local $oAD_ACESelf = ObjCreate("AccessControlEntry")
			$oAD_ACESelf.Trustee = "NT AUTHORITY\SELF"
			$oAD_ACESelf.AceFlags = 0
			$oAD_ACESelf.AceType = $ADS_ACETYPE_ACCESS_DENIED_OBJECT
			$oAD_ACESelf.Flags = $ADS_FLAG_OBJECT_TYPE_PRESENT
			$oAD_ACESelf.objectType = $USER_CHANGE_PASSWORD
			$oAD_ACESelf.AccessMask = $ADS_RIGHT_DS_CONTROL_ACCESS
			$oAD_DACL.AddAce($oAD_ACESelf)
		EndIf
		If $fAD_Everyone = False Then
			; Create the ACE for Everyone
			Local $oAD_ACEEveryone = ObjCreate("AccessControlEntry")
			$oAD_ACEEveryone.Trustee = "Everyone"
			$oAD_ACEEveryone.AceFlags = 0
			$oAD_ACEEveryone.AceType = $ADS_ACETYPE_ACCESS_DENIED_OBJECT
			$oAD_ACEEveryone.Flags = $ADS_FLAG_OBJECT_TYPE_PRESENT
			$oAD_ACEEveryone.objectType = $USER_CHANGE_PASSWORD
			$oAD_ACEEveryone.AccessMask = $ADS_RIGHT_DS_CONTROL_ACCESS
			$oAD_DACL.AddAce($oAD_ACEEveryone)
		EndIf
		$oAD_SD.discretionaryACL = _AD_ReorderACE($oAD_DACL)
		; Update the user object
		$oAD_Object.Put("ntSecurityDescriptor", $oAD_SD)
		$oAD_Object.SetInfo
	EndIf
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_DisablePasswordChange

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_UnlockObject
; Description ...: Unlocks an AD object (user account, computer account).
; Syntax.........: _AD_UnlockObject($sAD_Object)
; Parameters ....: $sAD_Object - User account or computer account to unlock (sAMAccountName or FQDN)
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_Object does not exist
;                  |x - Error returned by SetInfo function (Missing permission etc.)
; Author ........: water
; Modified.......:
; Remarks .......:
; Related .......: _AD_IsObjectLocked, _AD_LockObject, _AD_GetObjectsLocked
; Link ..........: http://www.rlmueller.net/Programs/IsUserLocked.txt
; Example .......: Yes
; ===============================================================================================================================
Func _AD_UnlockObject($sAD_Object)

	If Not _AD_ObjectExists($sAD_Object) Then Return SetError(1, 0, 0)
	If StringMid($sAD_Object, 3, 1) <> "=" Then $sAD_Object = _AD_SamAccountNameToFQDN($sAD_Object) ; sAMAccountName provided
	Local $oAD_Object = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_Object)
	$oAD_Object.IsAccountLocked = False
	$oAD_Object.SetInfo
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_UnlockObject

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_DisableObject
; Description ...: Disables an AD object (user account, computer account).
; Syntax.........: _AD_DisableObject($sAD_Object)
; Parameters ....: $sAD_Object - User account or computer account to disable (sAMAccountName or FQDN)
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_Object does not exist
;                  |x - Error returned by SetInfo function (Missing permission etc.)
; Author ........: water
; Modified.......:
; Remarks .......:
; Related .......: _AD_IsObjectDisabled, _AD_EnableObject, _AD_GetObjectsDisabled
; Link ..........: http://www.wisesoft.co.uk/scripts/vbscript_enable-disable_user_account_1.aspx
; Example .......: Yes
; ===============================================================================================================================
Func _AD_DisableObject($sAD_Object)

	If Not _AD_ObjectExists($sAD_Object) Then Return SetError(1, 0, 0)
	If StringMid($sAD_Object, 3, 1) <> "=" Then $sAD_Object = _AD_SamAccountNameToFQDN($sAD_Object) ; sAMAccountName provided
	Local $oAD_Object = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_Object)
	Local $iAD_UAC = $oAD_Object.Get("userAccountControl")
	$oAD_Object.Put("userAccountControl", BitOR($iAD_UAC, $ADS_UF_ACCOUNTDISABLE))
	$oAD_Object.SetInfo
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_DisableObject

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_EnableObject
; Description ...: Enables an AD object (user account, computer account).
; Syntax.........: _AD_EnableObject($sAD_Object)
; Parameters ....: $sAD_Object - User account or computer account to enable (sAMAccountName or FQDN)
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_Object does not exist
;                  |x - Error returned by SetInfo function (Missing permission etc.)
; Author ........: water
; Modified.......:
; Remarks .......:
; Related .......: _AD_IsObjectDisabled, _AD_DisableObject, _AD_GetObjectsDisabled
; Link ..........: http://www.wisesoft.co.uk/scripts/vbscript_enable-disable_user_account_1.aspx
; Example .......: Yes
; ===============================================================================================================================
Func _AD_EnableObject($sAD_Object)

	If Not _AD_ObjectExists($sAD_Object) Then Return SetError(1, 0, 0)
	If StringMid($sAD_Object, 3, 1) <> "=" Then $sAD_Object = _AD_SamAccountNameToFQDN($sAD_Object) ; sAMAccountName provided
	Local $oAD_Object = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_Object)
	Local $iAD_UAC = $oAD_Object.Get("userAccountControl")
	$oAD_Object.Put("userAccountControl", BitAND($iAD_UAC, BitNOT($ADS_UF_ACCOUNTDISABLE)))
	$oAD_Object.SetInfo
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_EnableObject

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_GetPasswordInfo
; Description ...: Returns password information from the domain policy and the user account.
; Syntax.........: _AD_GetPasswordInfo([$sAD_SamAccountName = @UserName])
; Parameters ....: $sAD_Object - Optional: User account to get password info for (default = @UserName). Format is sAMAccountName or FQDN
; Return values .: Success - Returns a one-based array with the following information:
;                  |1 - Maximum Password Age (days)
;                  |2 - Minimum Password Age (days)
;                  |3 - Enforce Password History (# of passwords remembered)
;                  |4 - Minimum Password Length
;                  |5 - Account Lockout Duration (minutes)
;                  |6 - Account Lockout Threshold (invalid logon attempts)
;                  |7 - Reset account lockout counter after (minutes)
;                  |8 - Password last changed (YYYY/MM/DD HH:MM:SS in local time of the calling user) or "1601/01/01 00:00:00" (means "Password has never been set")
;                  |9 - Password expires (YYYY/MM/DD HH:MM:SS in local time of the calling user) or empty when password has not been set before or never expires
;                  |10 - Password last changed (YYYY/MM/DD HH:MM:SS in UTC) or "1601/01/01 00:00:00" (means "Password has never been set")
;                  |11 - Password expires (YYYY/MM/DD HH:MM:SS in UTC) or empty when password has not been set before or never expires
;                  Failure - "", sets @error to:
;                  |1 - $sAD_Object not found
;                  Warning - Returns a one-based array (see Success), sets @error to:
;                  |2 - Password does not expire (User Access Control - UAC - is set)
;                  |3 - Password has never been set
;                  |4 - The Maximum Password Age is set to 0 in the domain. Therefore, the password does not expire
;                  |The @error value can be a combination of the above values e.g. 5 = 2 (Password does not expire) + 3 (Password has never been set)
; Author ........: water
; Modified.......:
; Remarks .......:
; Related .......: _AD_IsPasswordExpired, _AD_GetPasswordExpired, _AD_GetPasswordDontExpire, _AD_SetPassword, _AD_DisablePasswordExpire, _AD_EnablePasswordExpire, _AD_EnablePasswordChange,  _AD_DisablePasswordChange
; Link ..........: http://www.autoitscript.com/forum/index.php?showtopic=86247&view=findpost&p=619073, http://windowsitpro.com/article/articleid/81412/jsi-tip-8294-how-can-i-return-the-domain-password-policy-attributes.html
; Example .......: Yes
; ===============================================================================================================================
Func _AD_GetPasswordInfo($sAD_Object = @UserName)

	If _AD_ObjectExists($sAD_Object) = 0 Then Return SetError(1, 0, "")
	If StringMid($sAD_Object, 3, 1) <> "=" Then $sAD_Object = _AD_SamAccountNameToFQDN($sAD_Object) ; sAMAccountName provided
	Local $iAD_Error = 0
	Local $aAD_PwdInfo[12] = [11]
	Local $oAD_Object = ObjGet("LDAP://" & $sAD_DNSDomain)
	$aAD_PwdInfo[1] = Int(_AD_Int8ToSec($oAD_Object.Get("maxPwdAge"))) / 86400 ; Convert to Days
	$aAD_PwdInfo[2] = _AD_Int8ToSec($oAD_Object.Get("minPwdAge")) / 86400 ; Convert to Days
	$aAD_PwdInfo[3] = $oAD_Object.Get("pwdHistoryLength")
	$aAD_PwdInfo[4] = $oAD_Object.Get("minPwdLength")
	$aAD_PwdInfo[5] = _AD_Int8ToSec($oAD_Object.Get("lockoutDuration")) / 60 ; Convert to Minutes
	$aAD_PwdInfo[6] = $oAD_Object.Get("lockoutThreshold")
	$aAD_PwdInfo[7] = _AD_Int8ToSec($oAD_Object.Get("lockoutObservationWindow")) / 60 ; Convert to Minutes
	Local $oAD_User = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_Object)
	Local $sAD_PwdLastChanged = $oAD_User.Get("PwdLastSet")
	Local $iAD_UAC = $oAD_User.userAccountControl
	; Has user account password been changed before?
	If $sAD_PwdLastChanged.LowPart = 0 And $sAD_PwdLastChanged.HighPart = 0 Then
		$iAD_Error = +3
		$aAD_PwdInfo[8] = "1601/01/01 00:00:00"
		$aAD_PwdInfo[10] = "1601/01/01 00:00:00"
	Else
		; Is user account password set to expire?
		If BitAND($iAD_UAC, $ADS_UF_DONT_EXPIRE_PASSWD) = $ADS_UF_DONT_EXPIRE_PASSWD Or $aAD_PwdInfo[1] = 0 Then
			If BitAND($iAD_UAC, $ADS_UF_DONT_EXPIRE_PASSWD) = $ADS_UF_DONT_EXPIRE_PASSWD Then $iAD_Error += 2
			If $aAD_PwdInfo[1] = 0 Then $iAD_Error += 4 ; The Maximum Password Age is set to 0 in the domain. Therefore, the password does not expire
		Else
			Local $sAD_Temp = DllStructCreate("dword low;dword high")
			DllStructSetData($sAD_Temp, "Low", $sAD_PwdLastChanged.LowPart)
			DllStructSetData($sAD_Temp, "High", $sAD_PwdLastChanged.HighPart)
			; Have to convert to SystemTime because _Date_Time_FileTimeToStr has a bug (#1638)
			Local $sAD_Temp2 = _Date_Time_FileTimeToSystemTime(DllStructGetPtr($sAD_Temp))
			$aAD_PwdInfo[10] = _Date_Time_SystemTimeToDateTimeStr($sAD_Temp2, 1)
			$aAD_PwdInfo[11] = _DateAdd("d", $aAD_PwdInfo[1], $aAD_PwdInfo[10])
			; Convert PwdlastSet and PasswordExpires from UTC to Local Time
			$sAD_Temp2 = _Date_Time_SystemTimeToTzSpecificLocalTime(DllStructGetPtr($sAD_Temp2))
			$aAD_PwdInfo[8] = _Date_Time_SystemTimeToDateTimeStr($sAD_Temp2, 1)
			$sAD_Temp2 = _Date_Time_EncodeSystemTime(StringMid($aAD_PwdInfo[11], 6, 2), StringMid($aAD_PwdInfo[11], 9, 2), StringMid($aAD_PwdInfo[11], 1, 4), StringMid($aAD_PwdInfo[11], 12, 2), StringMid($aAD_PwdInfo[11], 15, 2), StringMid($aAD_PwdInfo[11], 18, 2))
			$sAD_Temp2 = _Date_Time_SystemTimeToTzSpecificLocalTime(DllStructGetPtr($sAD_Temp2))
			$aAD_PwdInfo[9] = _Date_Time_SystemTimeToDateTimeStr($sAD_Temp2, 1)
		EndIf
	EndIf
	Return SetError($iAD_Error, 0, $aAD_PwdInfo)

EndFunc   ;==>_AD_GetPasswordInfo

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_ListExchangeServers
; Description ...: Enumerates all Exchange Servers in the Forest.
; Syntax.........: _AD_ListExchangeServers()
; Parameters ....:
; Return values .: Success - One-based one dimensional array with the names of the Exchange Servers
;                  Failure - "", sets @error to:
;                  |1 - No Exchange Servers found
; Author ........: water
; Modified.......:
; Remarks .......:
; Related .......: _AD_ListExchangeMailboxStores
; Link ..........: http://www.wisesoft.co.uk/scripts/vbscript_list_exchange_servers.aspx
; Example .......: Yes
; ===============================================================================================================================
Func _AD_ListExchangeServers()

	Local $sAD_Query = "<LDAP://" & $sAD_Configuration & ">;(objectCategory=msExchExchangeServer);name;subtree"
	Local $oAD_RecordSet = $oAD_Connection.Execute($sAD_Query)
	If Not IsObj($oAD_RecordSet) Or $oAD_RecordSet.RecordCount = 0 Then Return SetError(1, 0, "")
	$oAD_RecordSet.MoveFirst
	Local $aAD_Result[1]
	Local $iCount1 = 1
	Do
		ReDim $aAD_Result[$iCount1 + 1]
		$aAD_Result[$iCount1] = $oAD_RecordSet.Fields("name" ).Value
		$oAD_RecordSet.MoveNext
		$iCount1 += 1
	Until $oAD_RecordSet.EOF
	$oAD_RecordSet.Close
	$aAD_Result[0] = UBound($aAD_Result, 1) - 1
	Return $aAD_Result

EndFunc   ;==>_AD_ListExchangeServers

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_ListExchangeMailboxStores
; Description ...: Enumerates all Exchange Mailbox Stores in the Forest.
; Syntax.........: _AD_ListExchangeMailboxStores()
; Parameters ....:
; Return values .: Success - Returns a one-based two dimensional array with the following information:
;                  |1 - name
;                  |2 - cn
;                  |3 - distinguishedName
;                  Failure - "", sets @error to:
;                  |1 - No Exchange Mailbox Stores found
; Author ........: water
; Modified.......:
; Remarks .......:
; Related .......: _AD_ListExchangeServers
; Link ..........: http://www.wisesoft.co.uk/scripts/vbscript_list_exchange_mailbox_stores.aspx
; Example .......: Yes
; ===============================================================================================================================
Func _AD_ListExchangeMailboxStores()

	Local $sAD_Query = "<LDAP://" & $sAD_Configuration & ">;(objectCategory=msExchPrivateMDB);name,cn,distinguishedName;subtree"
	Local $oAD_RecordSet = $oAD_Connection.Execute($sAD_Query)
	If Not IsObj($oAD_RecordSet) Or $oAD_RecordSet.RecordCount = 0 Then Return SetError(1, 0, "")
	$oAD_RecordSet.MoveFirst
	Local $aAD_Result[1][3]
	Local $iCount1 = 1
	Do
		ReDim $aAD_Result[$iCount1 + 1][3]
		$aAD_Result[$iCount1][0] = $oAD_RecordSet.Fields("name" ).Value
		$aAD_Result[$iCount1][1] = $oAD_RecordSet.Fields("cn" ).Value
		$aAD_Result[$iCount1][2] = $oAD_RecordSet.Fields("distinguishedName" ).Value
		$oAD_RecordSet.MoveNext
		$iCount1 += 1
	Until $oAD_RecordSet.EOF
	$oAD_RecordSet.Close
	$aAD_Result[0][0] = UBound($aAD_Result, 1) - 1
	$aAD_Result[0][1] = UBound($aAD_Result, 2)
	Return $aAD_Result

EndFunc   ;==>_AD_ListExchangeMailboxStores

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_GetSystemInfo
; Description ...: Retrieves data describing the local computer if it is a member of a (at least) Windows 2000 domain.
; Syntax.........: _AD_GetSystemInfo()
; Parameters ....:
; Return values .: Success - Returns a one-based one dimensional array with the following information:
;                  |1 - distinguished name of the local computer
;                  |2 - DNS name of the local computer domain
;                  |3 - short name of the local computer domain
;                  |4 - DNS name of the local computer forest
;                  |5 - Local computer domain status: native mode (TRUE) or mixed mode (FALSE)
;                  |6 - distinguished name of the NTDS-DSA object for the DC that owns the primary domain controller role in the local computer domain
;                  |7 - distinguished name of the NTDS-DSA object for the DC that owns the schema role in the local computer forest
;                  |8 - site name of the local computer
;                  |9 - distinguished name of the current user
;                  Failure - "", sets @error to:
;                  |1 - Creation of object "ADSystemInfo" returned an error. See @extended
; Author ........: water
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........: http://msdn.microsoft.com/en-us/library/aa705962(VS.85).aspx
; Example .......: Yes
; ===============================================================================================================================
Func _AD_GetSystemInfo()

	Local $aAD_Result[10]
	Local $oAD_SystemInfo = ObjCreate("ADSystemInfo")
	If Not IsObj($oAD_SystemInfo) Then Return SetError(1, @error, "")
	$aAD_Result[1] = $oAD_SystemInfo.ComputerName
	$aAD_Result[2] = $oAD_SystemInfo.DomainDNSName
	$aAD_Result[3] = $oAD_SystemInfo.DomainShortName
	$aAD_Result[4] = $oAD_SystemInfo.ForestDNSName
	$aAD_Result[5] = $oAD_SystemInfo.IsNativeMode
	$aAD_Result[6] = $oAD_SystemInfo.PDCRoleOwner
	$aAD_Result[7] = $oAD_SystemInfo.SchemaRoleOwner
	$aAD_Result[8] = $oAD_SystemInfo.SiteName
	$aAD_Result[9] = $oAD_SystemInfo.UserName
	$aAD_Result[0] = 9
	Return $aAD_Result

EndFunc   ;==>_AD_GetSystemInfo

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_GetManagedBy
; Description ...: Retrieves all groups that are managed by any or the specified user.
; Syntax.........: _AD_GetManagedBy([$sAD_ManagedBy = "*"])
; Parameters ....: $sAD_ManagedBy - Optional: Manager to filter the list of groups (default = *). Can be a SAMAccountname or a FQDN
; Return values .: Success - Returns a one-based two dimensional array with the following information:
;                  |1 - distinguished name of the group
;                  |2 - distinguished name of the manager for this group
;                  Failure - "", sets @error to:
;                  |1 - $sAD_ManagedBy is unknown
;                  |2 - No groups found
; Author ........: water
; Modified.......:
; Remarks .......: This query returns all groups that have the attribute "managedBy" set or set to the specified manager.
;+
;                  To get a list of all groups that manager x manages (by querying just the user object) use:
;                    $Result = _AD_GetObjectAttribute("samAccountName of the manager","managedObjects")
;                    _ArrayDisplay($Result)
;+
;                  To return managers for OUs change "objectCategory=group" to "objectClass=organizationalUnit".
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_GetManagedBy($sAD_ManagedBy = "*")

	If $sAD_ManagedBy <> "*" Then
		If _AD_ObjectExists($sAD_ManagedBy) = 0 Then Return SetError(1, 0, "")
		If StringMid($sAD_ManagedBy, 3, 1) <> "=" Then $sAD_ManagedBy = _AD_SamAccountNameToFQDN($sAD_ManagedBy) ; sAMAccountName provided
	EndIf
	Local $oAD_Command = ObjCreate("ADODB.Command")
	$oAD_Command.ActiveConnection = $oAD_Connection
	$oAD_Command.Properties("Page Size") = 1000
	$oAD_Command.CommandText = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(&(objectCategory=group)(managedby=" & $sAD_ManagedBy & "))" & ";distinguishedName,managedby;subtree"
	Local $oAD_RecordSet = $oAD_Command.Execute
	If Not IsObj($oAD_RecordSet) Or $oAD_RecordSet.RecordCount = 0 Then Return SetError(2, 0, "")
	$oAD_RecordSet.MoveFirst
	Local $aAD_Result[1][2], $iCount1 = 1
	Do
		ReDim $aAD_Result[$iCount1 + 1][2]
		$aAD_Result[$iCount1][0] = $oAD_RecordSet.Fields("distinguishedName" ).Value
		$aAD_Result[$iCount1][1] = $oAD_RecordSet.Fields("managedBy" ).Value
		$oAD_RecordSet.MoveNext
		$iCount1 += 1
	Until $oAD_RecordSet.EOF
	$oAD_RecordSet.Close
	$aAD_Result[0][0] = UBound($aAD_Result, 1) - 1
	$aAD_Result[0][1] = UBound($aAD_Result, 2)
	Return $aAD_Result

EndFunc   ;==>_AD_GetManagedBy

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_GetManager
; Description ...: Retrieves all users that are managed by any or the specified user.
; Syntax.........: _AD_GetManager([$sAD_Manager = "*"])
; Parameters ....: $sAD_Manager - Optional: Manager to filter the list of users (default = *). Can be sAMAccountName or FQDN
; Return values .: Success - Returns a one-based two dimensional array with the following information:
;                  |1 - distinguished name of the user
;                  |2 - distinguished name of the manager for this user
;                  Failure - "", sets @error to:
;                  |1 - $sAD_Manager is unknown
;                  |2 - No users found
; Author ........: water
; Modified.......:
; Remarks .......: This query returns all users that have the attribute "Manager" set or set to the specified manager.
;+
;                  To get a list of all users that manager x manages (by querying just the user object) use:
;                    $Result = _AD_GetObjectAttribute("samAccountName of the manager","directReports")
;                    _ArrayDisplay($Result)
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_GetManager($sAD_Manager = "*")

	If $sAD_Manager <> "*" Then
		If _AD_ObjectExists($sAD_Manager) = 0 Then Return SetError(1, 0, "")
		If StringMid($sAD_Manager, 3, 1) <> "=" Then $sAD_Manager = _AD_SamAccountNameToFQDN($sAD_Manager) ; sAMAccountName provided
	EndIf
	Local $oAD_Command = ObjCreate("ADODB.Command")
	$oAD_Command.ActiveConnection = $oAD_Connection
	$oAD_Command.Properties("Page Size") = 1000
	$oAD_Command.CommandText = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(&(objectCategory=user)(manager=" & $sAD_Manager & "))" & ";distinguishedName,Manager;subtree"
	Local $oAD_RecordSet = $oAD_Command.Execute
	If Not IsObj($oAD_RecordSet) Or $oAD_RecordSet.RecordCount = 0 Then Return SetError(2, 0, "")
	$oAD_RecordSet.MoveFirst
	Local $aAD_Result[1][2], $iCount1 = 1
	Do
		ReDim $aAD_Result[$iCount1 + 1][2]
		$aAD_Result[$iCount1][0] = $oAD_RecordSet.Fields("distinguishedName" ).Value
		$aAD_Result[$iCount1][1] = $oAD_RecordSet.Fields("Manager" ).Value
		$oAD_RecordSet.MoveNext
		$iCount1 += 1
	Until $oAD_RecordSet.EOF
	$oAD_RecordSet.Close
	$aAD_Result[0][0] = UBound($aAD_Result, 1) - 1
	$aAD_Result[0][1] = UBound($aAD_Result, 2)
	Return $aAD_Result

EndFunc   ;==>_AD_GetManager

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_GetGroupAdmins
; Description ...: Returns an array of the administrator sAMAccountNames for the specified group (not including the group owner/manager).
; Syntax.........: _AD_GetGroupAdmins($sAD_Object)
; Parameters ....: $sAD_Object - group name. Can be SAMaccountName or FQDN
; Return values .: Success - Returns a one-based one dimensional array with the sAMAccountNames of the administrators for the specified group
;                  +(not including the group owner/manager)
;                  Failure - "", sets @error to:
;                  |1 - Group could not be found
;                  |2 - No administrators found
; Author ........: John Clelland
; Modified.......: water
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_GetGroupAdmins($sAD_Object)

	If _AD_ObjectExists($sAD_Object) = 0 Then Return SetError(1, 0, "")
	If StringMid($sAD_Object, 3, 1) <> "=" Then $sAD_Object = _AD_SamAccountNameToFQDN($sAD_Object) ; sAMAccountName provided
	Local $oAD_Group = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_Object)
	Local $sAD_ManagedBy = $oAD_Group.Get("managedBy")
	Local $oAD_SD = $oAD_Group.Get("ntSecurityDescriptor")
	Local $oAD_DACL = $oAD_SD.DiscretionaryAcl
	Local $aAD_Admins[1] = [0], $sAD_samID, $sAD_ManagedBy_samID
	For $oAD_ACE In $oAD_DACL
		If $oAD_ACE.ObjectType = $SELF_MEMBERSHIP And $oAD_ACE.AceType = $ADS_ACETYPE_ACCESS_ALLOWED_OBJECT And _
				BitAND($oAD_ACE.AccessMask, $ADS_RIGHT_DS_WRITE_PROP) = $ADS_RIGHT_DS_WRITE_PROP Then
			$sAD_samID = StringTrimLeft($oAD_ACE.Trustee, StringInStr($oAD_ACE.Trustee, "\"))
			; S-1-5-21: SECURITY_NT_NON_UNIQUE - See: http://msdn.microsoft.com/en-us/library/aa379649(VS.85).aspx
			If Not StringInStr($sAD_samID, "S-1-5-21") And Not StringInStr($sAD_samID, "Account Operator") Then _ArrayAdd($aAD_Admins, $sAD_samID)
		EndIf
	Next
	If $sAD_ManagedBy <> "" Then
		$sAD_ManagedBy_samID = _AD_FQDNToSamAccountName($sAD_ManagedBy)
		Local $iCount1
		Local $iAD_Owner = -1
		For $iCount1 = 1 To UBound($aAD_Admins) - 1
			If $aAD_Admins[$iCount1] = $sAD_ManagedBy_samID Then $iAD_Owner = $iCount1
		Next
		If $iAD_Owner <> -1 Then
			_ArrayDelete($aAD_Admins, $iAD_Owner)
		EndIf
	EndIf
	$aAD_Admins[0] = UBound($aAD_Admins) - 1
	If $aAD_Admins[0] = 0 Then Return SetError(2, 0, "")
	Return $aAD_Admins

EndFunc   ;==>_AD_GetGroupAdmins

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_GroupManagerCanModify
; Description ...: Returns 1 if the manager of the group can modify the member list.
; Syntax.........: _AD_GroupManagerCanModify($sAD_Object)
; Parameters ....: $sAD_Object - FQDN of the group
; Return values .: Success - 1, Specified user can modify the member list
;                  Failure - 0, @error set
;                  |1 - Group does not exist
;                  |2 - The group manager can not modify the member list
;                  |3 - There is no manager assigned to the group
; Author ........: John Clelland
; Modified.......: water
; Remarks .......:
; Related .......: _AD_GroupAssignManager, _AD_GroupRemoveManager, _AD_SetGroupManagerCanModify
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_GroupManagerCanModify($sAD_Object)

	If _AD_ObjectExists($sAD_Object) = 0 Then Return SetError(1, 0, 0)
	If StringMid($sAD_Object, 3, 1) <> "=" Then $sAD_Object = _AD_SamAccountNameToFQDN($sAD_Object) ; sAMAccountName provided
	Local $oAD_Group = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_Object)
	Local $sAD_ManagedBy = $oAD_Group.Get("managedBy")
	If $sAD_ManagedBy = "" Then Return SetError(3, 0, 0)
	Local $oAD_User = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_ManagedBy)
	Local $aAD_UserFQDN = StringSplit($sAD_ManagedBy, "DC=", 1)
	Local $sAD_Domain = StringTrimRight($aAD_UserFQDN[2], 1)
	Local $sAD_SamAccountName = $oAD_User.Get("sAMAccountName")
	Local $oAD_SD = $oAD_Group.Get("ntSecurityDescriptor")
	Local $oAD_DACL = $oAD_SD.DiscretionaryAcl
	Local $fAD_Match = False
	For $oAD_ACE In $oAD_DACL
		If StringLower($oAD_ACE.Trustee) = StringLower($sAD_Domain & "\" & $sAD_SamAccountName) And _
				$oAD_ACE.ObjectType = $SELF_MEMBERSHIP And _
				$oAD_ACE.AceType = $ADS_ACETYPE_ACCESS_ALLOWED_OBJECT And _
				BitAND($oAD_ACE.AccessMask, $ADS_RIGHT_DS_WRITE_PROP) = $ADS_RIGHT_DS_WRITE_PROP Then $fAD_Match = True
	Next
	If $fAD_Match Then
		Return 1
	Else
		Return SetError(2, 0, 0)
	EndIf

EndFunc   ;==>_AD_GroupManagerCanModify

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_ListPrintQueues
; Description ...: Enumerates all PrintQueues in the AD tree or for the specified spool server.
; Syntax.........: _AD_ListPrintQueues([$sAD_Servername=*])
; Parameters ....: $sAD_Servername - Optional: Short name of the spool server to process
; Return values .: Success - One-based two dimensional array with the following information:
;                  |1 - PrinterName: Short name of the PrintQueue
;                  |2 - ServerName: SpoolServerName.Domain
;                  |3 - DistinguishedName: FQDN of the PrintQueue
;                  Failure - "", @error set
;                  |1 - There is no PrintQueue available
; Author ........: water
; Modified.......:
; Remarks .......: To get more (including multi-valued) attributes of a printqueue use _AD_GetObjectProperties
; Related .......:
; Link ..........: http://msdn.microsoft.com/en-us/library/aa706091(VS.85).aspx, http://www.activxperts.com/activmonitor/windowsmanagement/scripts/printing/printerport/#LAPP.htm
; Example .......: Yes
; ===============================================================================================================================
Func _AD_ListPrintQueues($sAD_Servername = "*")

	Local $oAD_Command = ObjCreate("ADODB.Command")
	$oAD_Command.ActiveConnection = $oAD_Connection
	$oAD_Command.Properties("Page Size") = 1000
	$oAD_Command.Properties("Searchscope") = 2
	$oAD_Command.CommandText = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(&(objectclass=printQueue)(shortservername=" & $sAD_Servername & "));distinguishedName,PrinterName,ServerName;subtree"
	Local $oAD_RecordSet = $oAD_Command.Execute
	If Not IsObj($oAD_RecordSet) Or $oAD_RecordSet.RecordCount = 0 Then Return SetError(1, 0, "")
	Local $aAD_PrinterList[$oAD_RecordSet.RecordCount + 1][3] = [[0, 3]]
	$oAD_RecordSet.MoveFirst
	Do
		$aAD_PrinterList[0][0] += 1
		$aAD_PrinterList[$aAD_PrinterList[0][0]][0] = $oAD_RecordSet.Fields("printerName" ).Value
		$aAD_PrinterList[$aAD_PrinterList[0][0]][1] = $oAD_RecordSet.Fields("serverName" ).Value
		$aAD_PrinterList[$aAD_PrinterList[0][0]][2] = $oAD_RecordSet.Fields("distinguishedName" ).Value
		$oAD_RecordSet.MoveNext
	Until $oAD_RecordSet.EOF
	$oAD_RecordSet.Close
	Return $aAD_PrinterList

EndFunc   ;==>_AD_ListPrintQueues

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_SetGroupManagerCanModify
; Description ...: Sets the Group manager to be able to modify the member list.
; Syntax.........: _AD_SetGroupManagerCanModify($sAD_Group)
; Parameters ....: $sAD_Group - Groupname (sAMAccountName or FQDN)
; Return values .: Success - 1
;                  Failure - 0, @error set
;                  |1 - $sAD_Group does not exist
;                  |2 - Group manager can already modify the member list
;                  |3 - $sAD_Group has no manager assigned
;                  |x - Error returned by SetInfo function (Missing permission etc.)
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......:
; Related .......: _AD_GroupAssignManager, _AD_GroupManagerCanModify, _AD_GroupRemoveManager
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_SetGroupManagerCanModify($sAD_Group)

	If _AD_ObjectExists($sAD_Group) = 0 Then Return SetError(1, 0, 0)
	If StringMid($sAD_Group, 3, 1) <> "=" Then $sAD_Group = _AD_SamAccountNameToFQDN($sAD_Group) ; sAMAccountName provided
	If _AD_GroupManagerCanModify($sAD_Group) = 1 Then Return SetError(2, 0, 0)
	Local $oAD_Group = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_Group)
	Local $sAD_ManagedBy = $oAD_Group.Get("managedBy")
	If $sAD_ManagedBy = "" Then Return SetError(3, 0, 0)
	Local $oAD_User = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_ManagedBy)
	Local $aAD_UserFQDN = StringSplit($sAD_ManagedBy, "DC=", 1)
	Local $sAD_Domain = StringTrimRight($aAD_UserFQDN[2], 1)
	Local $sAD_SamAccountName = $oAD_User.Get("sAMAccountName")
	Local $oAD_SD = $oAD_Group.Get("ntSecurityDescriptor")
	$oAD_SD.Owner = $sAD_Domain & "\" & @UserName
	Local $oAD_DACL = $oAD_SD.DiscretionaryAcl
	Local $oAD_ACE = ObjCreate("AccessControlEntry")
	$oAD_ACE.Trustee = $sAD_Domain & "\" & $sAD_SamAccountName
	$oAD_ACE.AccessMask = $ADS_RIGHT_DS_WRITE_PROP
	$oAD_ACE.AceFlags = 0
	$oAD_ACE.AceType = $ADS_ACETYPE_ACCESS_ALLOWED_OBJECT
	$oAD_ACE.Flags = $ADS_FLAG_OBJECT_TYPE_PRESENT
	$oAD_ACE.ObjectType = $SELF_MEMBERSHIP
	$oAD_DACL.AddAce($oAD_ACE)
	$oAD_SD.DiscretionaryAcl = _AD_ReorderACE($oAD_DACL)
	$oAD_Group.Put("ntSecurityDescriptor", $oAD_SD)
	$oAD_Group.SetInfo
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_SetGroupManagerCanModify

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_GroupAssignManager
; Description ...: Assigns the user as group manager.
; Syntax.........: _AD_GroupAssignManager($sAD_Group, $sAD_User)
; Parameters ....: $sAD_Group - Groupname (sAMAccountName or FQDN)
;                  $sAD_User - User to assign as manager (sAMAccountName or FQDN)
; Return values .: Success - 1
;                  Failure - 0, @error set
;                  |1 - $sAD_Group does not exist
;                  |2 - $sAD_User does not exist
;                  |x - Error returned by SetInfo function (Missing permission etc.)
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......:
; Related .......: _AD_SetGroupManagerCanModify, _AD_GroupManagerCanModify, _AD_GroupRemoveManager
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_GroupAssignManager($sAD_Group, $sAD_User)

	If _AD_ObjectExists($sAD_Group) = 0 Then Return SetError(1, 0, 0)
	If _AD_ObjectExists($sAD_User) = 0 Then Return SetError(2, 0, 0)
	If StringMid($sAD_Group, 3, 1) <> "=" Then $sAD_Group = _AD_SamAccountNameToFQDN($sAD_Group) ; sAMAccountName provided
	If StringMid($sAD_User, 3, 1) <> "=" Then $sAD_User = _AD_SamAccountNameToFQDN($sAD_User) ; sAMAccountName provided
	Local $oAD_Group = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_Group)
	$oAD_Group.Put("managedBy", $sAD_User)
	$oAD_Group.SetInfo
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_GroupAssignManager

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_GroupRemoveManager
; Description ...: Remove the group manager from a group or only remove the manager's modify permission.
; Syntax.........: _AD_GroupRemoveManager($sAD_Group[, $fAD_Flag = FALSE])
; Parameters ....: $sAD_Group - Groupname (sAMAccountName or FQDN)
;                  $fAD_Flag - Optional: if TRUE the function only removes the manager's modify permission
; Return values .: Success - 1
;                  Failure - 0, @error set
;                  |1 - $sAD_Group does not exist
;                  |2 - $sAD_Group does not have a manager assigned
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......:
; Related .......: _AD_SetGroupManagerCanModify, _AD_GroupManagerCanModify, _AD_GroupAssignManager
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_GroupRemoveManager($sAD_Group, $fAD_Flag = 0)

	If _AD_ObjectExists($sAD_Group) = 0 Then Return SetError(1, 0, 0)
	If StringMid($sAD_Group, 3, 1) <> "=" Then $sAD_Group = _AD_SamAccountNameToFQDN($sAD_Group) ; sAMAccountName provided
	Local $oAD_Group = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_Group)
	Local $sAD_ManagedBy = $oAD_Group.Get("managedBy")
	If $sAD_ManagedBy = "" Then Return SetError(2, 0, 0)
	Local $oAD_User = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_ManagedBy)
	Local $aAD_UserFQDN = StringSplit($sAD_ManagedBy, "DC=", 1)
	Local $sAD_Domain = StringTrimRight($aAD_UserFQDN[2], 1)
	Local $sAD_SamAccountName = $oAD_User.Get("sAMAccountName")
	Local $oAD_SD = $oAD_Group.Get("ntSecurityDescriptor")
	$oAD_SD.Owner = $sAD_Domain & "\" & @UserName
	Local $oAD_DACL = $oAD_SD.DiscretionaryAcl
	For $oAD_ACE In $oAD_DACL
		If StringLower($oAD_ACE.Trustee) = StringLower($sAD_Domain & "\" & $sAD_SamAccountName) And _
				$oAD_ACE.ObjectType = $SELF_MEMBERSHIP And _
				$oAD_ACE.AceType = $ADS_ACETYPE_ACCESS_ALLOWED_OBJECT And _
				$oAD_ACE.AccessMask = $ADS_RIGHT_DS_WRITE_PROP Then _
				$oAD_DACL.RemoveAce($oAD_ACE)
	Next
	$oAD_SD.DiscretionaryAcl = $oAD_DACL
	$oAD_Group.Put("ntSecurityDescriptor", $oAD_SD)
	If Not $fAD_Flag Then $oAD_Group.PutEx(1, "managedBy", 0)
	$oAD_Group.SetInfo
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_GroupRemoveManager

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_AddEmailAddress
; Description ...: Appends an SMTP email address to the 'Email Addresses' tab of an Exchange-enabled AD account.
; Syntax.........: _AD_AddEmailAddress($sAD_User, $sAD_NewEmail[, $fAD_Primary = False])
; Parameters ....: $sAD_User - User account (sAMAccountName or FQDN)
;                  $sAD_NewEmail - Email address to add to the account
;                  $fAD_Primary - Optional: if TRUE the new email address will be set as primary address
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_User does not exist
;                  |2 - Could not connect to $sAD_User
;                  |x - Error returned by GetEx or SetInfo function (Missing permission etc.)
; Author ........: Jonathan Clelland
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_AddEmailAddress($sAD_User, $sAD_NewEmail, $fAD_Primary = False)

	If _AD_ObjectExists($sAD_User) = 0 Then Return SetError(1, 0, 0)
	If StringMid($sAD_User, 3, 1) <> "=" Then $sAD_User = _AD_SamAccountNameToFQDN($sAD_User) ; sAMAccountName provided
	Local $oAD_User = _AD_ObjGet("LDAP://" & $sAD_HostServer & "/" & $sAD_User)
	If Not IsObj($oAD_User) Then Return SetError(2, 0, 0)
	Local $aAD_ProxyAddresses = $oAD_User.GetEx("proxyaddresses")
	If @error <> 0 Then Return SetError(@error, 0, 0)
	If $fAD_Primary Then
		For $iCount1 = 0 To UBound($aAD_ProxyAddresses) - 1
			If StringInStr($aAD_ProxyAddresses[$iCount1], "SMTP:", 1) Then
				$aAD_ProxyAddresses[$iCount1] = StringReplace($aAD_ProxyAddresses[$iCount1], "SMTP:", "smtp:", 0, 1)
			EndIf
		Next
		_ArrayAdd($aAD_ProxyAddresses, "SMTP:" & $sAD_NewEmail)
		$oAD_User.Put("mail", $sAD_NewEmail)
	Else
		_ArrayAdd($aAD_ProxyAddresses, "smtp:" & $sAD_NewEmail)
	EndIf
	$oAD_User.PutEx(2, "proxyaddresses", $aAD_ProxyAddresses)
	$oAD_User.SetInfo
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_AddEmailAddress

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_JoinDomain
; Description ...: Joins the computer to an already created computer account in a domain.
; Syntax.........: _AD_JoinDomain($sAD_Computer[, $sAD_UserParam, $sAD_PasswordParam])
; Parameters ....: $sAD_Computer - Computername to join to the domain
;                  $sAD_UserParam - Optional: User with admin rights to join the computer to the domain (NetBIOSName)
;                  +(Default = credentials under which the script is run or from _AD_Open are used)
;                  $sAD_PasswordParam - Optional: Password for $sAD_UserParam. (Default = credentials under which the script is run are used)
; Return values .: Success - 1
;                  Failure - 0, @error set
;                  |1 - $sAD_Computer account does not exist in the domain
;                  |2 - $sAD_UserParam does not exist in the domain
;                  |3 - WMI object could not be created. See @extended for error code. See remarks for further information
;                  |4 - The computer is already a member of the domain
;                  |5 - Joining the domain was not successful. @extended holds the Win32 error code (see: http://msdn.microsoft.com/en-us/library/ms681381(v=VS.85).aspx)
; Author ........: water
; Modified.......:
; Remarks .......: The domain to which the computer is joined to is the domain the user logged on to using AD_Open.
;                  If no credentials are passed to this function but have been used with _AD_Open() then the _AD_Open credentials will be used for this function.
;                  You have to reboot the computer after a successful join to the domain.
;                  The JoinDomainOrWorkgroup method is available only on Windows XP computer and Windows Server 2003 or later.
; Related .......: _AD_CreateComputer
; Link ..........: http://technet.microsoft.com/en-us/library/ee692588.aspx, http://msdn.microsoft.com/en-us/library/aa392154(VS.85).aspx
; Example .......: Yes
; ===============================================================================================================================
Func _AD_JoinDomain($sAD_Computer, $sAD_UserParam = "", $sAD_PasswordParam = "")

	If _AD_ObjectExists($sAD_Computer & "$") = 0 Then Return SetError(1, 0, 0)
	If $sAD_UserParam <> "" And _AD_ObjectExists($sAD_UserParam) = 0 Then Return SetError(2, 0, 0)
	Local $iAD_Result
	Local $sAD_DomainName = StringReplace(StringReplace($sAD_DNSDomain, "DC=", ""), ",", ".")
	; Create WMI object
	Local $oAD_Computer = ObjGet("winmgmts:{impersonationLevel=Impersonate}!\\" & $sAD_Computer & "\root\cimv2:Win32_ComputerSystem.Name='" & $sAD_Computer & "'")
	If Not IsObj($oAD_Computer) Or @error <> 0 Then Return SetError(3, @error, 0)
	If $oAD_Computer.Domain = $sAD_DomainName Then Return SetError(4, 0, 0)
	; Join domain. Use credentials passed as parameters to this function or those used at _AD_Open, if any
	If $sAD_UserParam <> "" Then
		$iAD_Result = $oAD_Computer.JoinDomainOrWorkGroup($sAD_DomainName, $sAD_PasswordParam, $sAD_DomainName & "\" & $sAD_UserParam, Default, 1)
	ElseIf $sAD_UserId <> "" Then
		; Domain NetBIOS name and user account (domain\user) or user principal name (user@domain) is supported
		Local $sAD_Temp = $sAD_UserId
		If StringInStr($sAD_UserId, "\") = 0 And StringInStr($sAD_UserId, "@") = 0 Then $sAD_Temp = $sAD_DomainName & "\" & $sAD_UserId
		$iAD_Result = $oAD_Computer.JoinDomainOrWorkGroup($sAD_DomainName, $sAD_Password, $sAD_DomainName & "\" & $sAD_Temp, Default, 1)
	Else
		$iAD_Result = $oAD_Computer.JoinDomainOrWorkGroup($sAD_DomainName, Default, Default, Default, 1)
	EndIf
	If $iAD_Result <> 0 Then Return SetError(5, $iAD_Result, 0)
	Return 1

EndFunc   ;==>_AD_JoinDomain

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_UnJoinDomain
; Description ...: Unjoins the computer from its current domain and disables the computer account.
; Syntax.........: _AD_UnJoinDomain($sAD_Computer[, $sAD_Workgroup [,$sAD_UserParam, $sAD_PasswordParam]])
; Parameters ....: $sAD_Computer - Computername to unjoin from the domain
;                  $sAD_Workgroup - Optional: Workgroup the unjoined computer is assigned to (Default = Domain the computer was unjoined from)
;                  $sAD_UserParam - Optional: User with admin rights to unjoin the computer from the domain (NetBIOSName)
;                  +(Default = credentials under which the script is run or from _AD_Open are used)
;                  $sAD_PasswordParam - Optional: Password for $sAD_UserParam. (Default = credentials under which the script is run are used)
; Return values .: Success - 1
;                  Failure - 0, @error set
;                  |1 - $sAD_Computer account does not exist in the domain
;                  |2 - $sAD_UserParam does not exist in the domain
;                  |3 - WMI object could not be created. See @extended for error code. See remarks for further information
;                  |4 - The computer is a member of another or no domain
;                  |5 - Unjoining the domain was not successful. See @extended for error code. See remarks for further information
;                  |6 - Joining the Computer to the specified workgroup was not successful. See @extended for error code
; Author ........: water
; Modified.......:
; Remarks .......: The domain from which the computer is unjoined from has to be the domain the user logged on to using AD_Open.
;                  If no credentials are passed to this function but have been used with _AD_Open() then the _AD_Open credentials will be used for this function.
;                  If no workgroup is specified then the computer is assigned to a workgroup named like the domain the computer was unjoined from.
;                  You have to reboot the computer after a successful unjoin from the domain.
;                  The UnjoinDomainOrWorkgroup method is available only on Windows XP computer and Windows Server 2003 or later.
; Related .......:
; Link ..........: http://gallery.technet.microsoft.com/ScriptCenter/en-us/c2025ace-cb51-4136-9de9-db8871f79f62, http://technet.microsoft.com/en-us/library/ee692588.aspx, http://msdn.microsoft.com/en-us/library/aa393942(VS.85).aspx
; Example .......: Yes
; ===============================================================================================================================
Func _AD_UnJoinDomain($sAD_Computer, $sAD_Workgroup = "", $sAD_UserParam = "", $sAD_PasswordParam = "")

	Local $NETSETUP_ACCT_DELETE = 4 ; According to MS it should be 2 but only 4 works
	If _AD_ObjectExists($sAD_Computer & "$") = 0 Then Return SetError(1, 0, 0)
	If $sAD_UserParam <> "" And _AD_ObjectExists($sAD_UserParam) = 0 Then Return SetError(2, 0, 0)
	Local $iAD_Result
	Local $sAD_DomainName = StringReplace(StringReplace($sAD_DNSDomain, "DC=", ""), ",", ".")
	; Create WMI object
	Local $oAD_Computer = ObjGet("winmgmts:{impersonationLevel=Impersonate}!\\" & $sAD_Computer & "\root\cimv2:Win32_ComputerSystem.Name='" & $sAD_Computer & "'")
	If Not IsObj($oAD_Computer) Or @error <> 0 Then Return SetError(3, @error, 0)
	If $oAD_Computer.Domain <> $sAD_DomainName Then Return SetError(4, 0, 0)
	; UnJoin domain. Use credentials passed as parameters to this function or those used at _AD_Open, if any
	If $sAD_UserParam <> "" Then
		$iAD_Result = $oAD_Computer.UnjoinDomainOrWorkGroup($sAD_PasswordParam, $sAD_DomainName & "\" & $sAD_UserParam, $NETSETUP_ACCT_DELETE)
	ElseIf $sAD_UserId <> "" Then
		; Domain NetBIOS name and user account (domain\user) or user principal name (user@domain) is supported
		Local $sAD_Temp = $sAD_UserId
		If StringInStr($sAD_UserId, "\") = 0 And StringInStr($sAD_UserId, "@") = 0 Then $sAD_Temp = $sAD_DomainName & "\" & $sAD_UserId
		$iAD_Result = $oAD_Computer.UnjoinDomainOrWorkGroup($sAD_Password, $sAD_Temp, $NETSETUP_ACCT_DELETE)
	Else
		$iAD_Result = $oAD_Computer.UnjoinDomainOrWorkGroup(Default, Default, $NETSETUP_ACCT_DELETE)
	EndIf
	If $iAD_Result <> 0 Then Return SetError(5, $iAD_Result, 0)
	; Move unjoined computer to another workgroup
	If $sAD_Workgroup <> "" Then
		$iAD_Result = $oAD_Computer.JoinDomainOrWorkGroup($sAD_Workgroup, Default, Default, Default, Default)
		If $iAD_Result <> 0 Then Return SetError(6, $iAD_Result, 0)
	EndIf
	Return 1

EndFunc   ;==>_AD_UnJoinDomain

; #FUNCTION#====================================================================================================================
; Name...........: _AD_SetPasswordExpire
; Description ...: Sets user's password as expired or not expired.
; Syntax.........: _AD_SetPasswordExpire($sAD_User[, $iAD_Flag = 0])
; Parameters ....: $sAD_User - User account (sAMAccountName or FQDN)
;                  $iAD_Flag - Optional: Sets the user's password as expired ($iAD_Flag = 0) or as not expired ($iAD_Flag = -1) (Default = 0)
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_User does not exist
;                  |2 - $iAD_Flag has an invalid value
;                  |x - Error returned by SetInfo function (Missing permission etc.)
; Author ........: Ethan Turk
; Modified.......:
; Remarks .......: When the user's password is set to expired he has to change the password at next logon
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_SetPasswordExpire($sAD_User, $iAD_Flag = 0)

	If Not _AD_ObjectExists($sAD_User) Then Return SetError(1, 0, 0)
	If $iAD_Flag <> 0 And $iAD_Flag <> -1 Then Return SetError(2, 0, 0)
	Local $sAD_Property = "sAMAccountName"
	If StringMid($sAD_User, 3, 1) = "=" Then $sAD_Property = "distinguishedName"; FQDN provided
	Local $sAD_Query = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(" & $sAD_Property & "=" & $sAD_User & ");ADsPath;subtree"
	Local $oAD_RecordSet = $oAD_Connection.Execute($sAD_Query) ; Retrieve the ADsPath for the object
	Local $sAD_LDAPEntry = $oAD_RecordSet.fields(0).value
	Local $oAD_Object = _AD_ObjGet($sAD_LDAPEntry) ; Retrieve the COM Object for the object
	$oAD_Object.Put("pwdLastSet", $iAD_Flag)
	$oAD_Object.SetInfo()
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_SetPasswordExpire

; #FUNCTION#====================================================================================================================
; Name...........: _AD_CreateMailbox
; Description ...: Creates a mailbox for a user.
; Syntax.........: _AD_CreateMailbox($sAD_User, $sAD_StoreName[, $sAD_Store[, $sAD_EMailServer[, $sAD_AdminGroup[, $sAD_EmailDomain]]]])
; Parameters ....: $sAD_User - User account (sAMAccountName or FQDN) to add mailbox to
;                  $sAD_StoreName - Mailbox storename
;                  $sAD_Store - Optional: Information store (Default = "First Storage Group")
;                  $sAD_EmailServer - Optional: Email server (Default = First server returned by _AD_ListExchangeServers())
;                  $sAD_AdminGroup - Optional: Administrative group in Exchange (Default= "First Administrative Group")
;                  $sAD_EmailDomain - Optional: Exchange Server Group name e.g. "My Company" (Default = Text after first DC= in $sAD_DNSDomain)
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_User does not exist
;                  |2 - $sAD_User already has a mailbox
;                  |3 - _AD_ListExchangeServers() returned an error. Please see @extended for _AD_ListExchangeServers() return code
;                  |x - Error returned by SetInfo function (Missing permission etc.)
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: The mailbox is created using CDOEXM. For this function to work the Exchange administration tools have to be installed on the
;                  computer running the script.
;                  To set rights on the mailbox you have to run at least Exchange 2000 SP2.
;+
;                  If the Exchange administration tools are not installed on the PC running the script you could use an ADSI only solution.
;                  Set the mailNickname and displayName properties of the user and at least one of this: homeMTA, homeMDB or msExchHomeServerName and
;                  the RUS (Recipient Update Service) of Exchange 2000/2003 will create the mailbox for you.
;                  Be aware that this no longer works for Exchange 2007 and later.
; Related .......:
; Link ..........: http://www.msxfaq.de/code/makeuser.htm
; Example .......: Yes
; ===============================================================================================================================
Func _AD_CreateMailbox($sAD_User, $sAD_StoreName, $sAD_Store = "First Storage Group", $sAD_EMailServer = "", $sAD_AdminGroup = "First Administrative Group", $sAD_EmailDomain = "")

	If Not _AD_ObjectExists($sAD_User) Then Return SetError(1, 0, 0)
	Local $sAD_Property = "sAMAccountName"
	If StringMid($sAD_User, 3, 1) = "=" Then $sAD_Property = "distinguishedName"; FQDN provided
	Local $sAD_Query = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(" & $sAD_Property & "=" & $sAD_User & ");ADsPath;subtree"
	Local $oAD_RecordSet = $oAD_Connection.Execute($sAD_Query) ; Retrieve the ADsPath for the object
	Local $sAD_LDAPEntry = $oAD_RecordSet.fields(0).value
	Local $oAD_User = _AD_ObjGet($sAD_LDAPEntry) ; Retrieve the COM Object for the object
	If $oAD_User.HomeMDB <> "" Then Return SetError(2, 0, 0)
	Local $aAD_Temp
	If $sAD_EmailDomain = "" Then
		$aAD_Temp = StringSplit($sAD_DNSDomain, ",")
		$sAD_EmailDomain = StringMid($aAD_Temp[1], 4)
	EndIf
	If $sAD_EMailServer = "" Then
		$aAD_Temp = _AD_ListExchangeServers()
		If @error <> 0 Then Return SetError(3, @error, 0)
		$sAD_EMailServer = $aAD_Temp[1]
	EndIf
	Local $sAD_Mailboxpath = "LDAP://CN="
	$sAD_Mailboxpath &= $sAD_StoreName
	$sAD_Mailboxpath &= ",CN="
	$sAD_Mailboxpath &= $sAD_Store
	$sAD_Mailboxpath &= ",CN=InformationStore"
	$sAD_Mailboxpath &= ",CN="
	$sAD_Mailboxpath &= $sAD_EMailServer
	$sAD_Mailboxpath &= ",CN=Servers,CN="
	$sAD_Mailboxpath &= $sAD_AdminGroup
	$sAD_Mailboxpath &= ",CN=Administrative Groups,CN=" & $sAD_EmailDomain & ",CN=Microsoft Exchange,CN=Services,CN=Configuration,"
	$sAD_Mailboxpath &= $sAD_DNSDomain
	$oAD_User.CreateMailbox($sAD_Mailboxpath)
	$oAD_User.SetInfo
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_CreateMailbox

; #FUNCTION#====================================================================================================================
; Name...........: _AD_DeleteMailbox
; Description ...: Deletes a users mailbox.
; Syntax.........: _AD_DeleteMailbox($sAD_User)
; Parameters ....: $sAD_User - User account (sAMAccountName or FQDN) to delete mailbox from
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_User does not exist
;                  |2 - $sAD_User doesn't have a mailbox
;                  |x - Error returned by SetInfo function (Missing permission etc.)
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_DeleteMailbox($sAD_User)

	Local $sAD_Property = "sAMAccountName"
	If StringMid($sAD_User, 3, 1) = "=" Then $sAD_Property = "distinguishedName"; FQDN provided
	Local $sAD_Query = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(" & $sAD_Property & "=" & $sAD_User & ");ADsPath;subtree"
	Local $oAD_RecordSet = $oAD_Connection.Execute($sAD_Query) ; Retrieve the ADsPath for the object
	Local $sAD_LDAPEntry = $oAD_RecordSet.fields(0).value
	Local $oAD_User = _AD_ObjGet($sAD_LDAPEntry) ; Retrieve the COM Object for the object
	If $oAD_User.HomeMDB = "" Then Return SetError(2, 0, 0)
	$oAD_User.DeleteMailbox
	$oAD_User.SetInfo
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_DeleteMailbox

; #FUNCTION#====================================================================================================================
; Name...........: _AD_MailEnableGroup
; Description ...: Mail-enables a Group.
; Syntax.........: _AD_MailEnableGroup($sAD_Group)
; Parameters ....: $sAD_Group - Groupname (sAMAccountName or FQDN)
; Return values .: Success - 1
;                  Failure - 0, sets @error to:
;                  |1 - $sAD_Group does not exist
;                  |x - Error returned by SetInfo function (Missing permission etc.)
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_MailEnableGroup($sAD_Group)

	If Not _AD_ObjectExists($sAD_Group) Then Return SetError(1, 0, 0)
	Local $sAD_Property = "sAMAccountName"
	If StringMid($sAD_Group, 3, 1) = "=" Then $sAD_Property = "distinguishedName"; FQDN provided
	Local $sAD_Query = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(" & $sAD_Property & "=" & $sAD_Group & ");ADsPath;subtree"
	Local $oAD_RecordSet = $oAD_Connection.Execute($sAD_Query) ; Retrieve the ADsPath for the object
	Local $sAD_LDAPEntry = $oAD_RecordSet.fields(0).value
	Local $oAD_Group = _AD_ObjGet($sAD_LDAPEntry) ; Retrieve the COM Object for the object
	$oAD_Group.MailEnable
	$oAD_Group.Put("grouptype", $ADS_GROUP_TYPE_UNIVERSAL_SECURITY)
	$oAD_Group.SetInfo
	If @error <> 0 Then Return SetError(@error, 0, 0)
	Return 1

EndFunc   ;==>_AD_MailEnableGroup

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_IsAccountExpired
; Description ...: Returns 1 if the account (user, computer) has expired.
; Syntax.........: _AD_IsAccountExpired([$sAD_Object = @Username])
; Parameters ....: $sAD_Object - Optional: Account (User, computer) to check (default = @Username). Can be specified as Fully Qualified Domain Name (FQDN) or sAMAccountName
; Return values .: Success - 1, The specified account has expired
;                  Failure - 0, sets @error to:
;                  |0 - Account has not expired
;                  |1 - $sAD_Object could not be found
; Author ........: water
; Modified.......:
; Remarks .......:
; Related .......: _AD_GetAccountsExpired, _AD_SetAccountExpire
; Link ..........: http://www.rlmueller.net/AccountExpires.htm
; Example .......: Yes
; ===============================================================================================================================
Func _AD_IsAccountExpired($sAD_Object = @UserName)

	Local $sAD_Property = "sAMAccountName"
	If StringMid($sAD_Object, 3, 1) = "=" Then $sAD_Property = "distinguishedName" ; FQDN provided
	If _AD_ObjectExists($sAD_Object, $sAD_Property) = 0 Then Return SetError(1, 0, 0)
	Local $sAD_Query = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(" & $sAD_Property & "=" & $sAD_Object & ");ADsPath;subtree"
	Local $oAD_RecordSet = $oAD_Connection.Execute($sAD_Query) ; Retrieve the ADsPath for the object
	Local $sAD_LDAPEntry = $oAD_RecordSet.fields(0).value
	Local $oAD_Object = _AD_ObjGet($sAD_LDAPEntry) ; Retrieve the COM Object for the object
	Local $sAD_AccountExpires = $oAD_Object.AccountExpirationDate
	If $sAD_AccountExpires <> "19700101000000" And StringLeft($sAD_AccountExpires, 8) <> "16010101" And $sAD_AccountExpires < @YEAR & @MON & @MDAY & @HOUR & @MIN & @SEC Then Return 1
	Return

EndFunc   ;==>_AD_IsAccountExpired

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_GetAccountsExpired
; Description ...: Returns an array with FQDNs of expired accounts (user, computer).
; Syntax.........: _AD_GetAccountsExpired([$sAD_Class = "user"[ ,$sAD_DTEExpire = ""[ ,$sAD_DTSExpire = ""]]])
; Parameters ....: $sAD_Class - Optional: Specifies if expired user accounts or computer accounts should be returned (default = "user").
;                  |"user" - Returns objects of category "user"
;                  |"computer" - Returns objects of category "computer"
;                  $sAD_DTEExpire - YYYY/MM/DD HH:MM:SS (local time) returns all accounts that expire between $sAD_DTSExpire and the specified date/time (default = "" = Now)
;                  $sAD_DTSExpire - YYYY/MM/DD HH:MM:SS (local time) returns all accounts that expire between the specified date/time and $sAD_DTEExpire (default = "1601/01/01 00:00:00)
; Return values .: Success - One-based two dimensional array of FQDNs of expired accounts
;                  |1 - FQDNs of expired accounts
;                  |2 - account expired YYYY/MM/DD HH:NMM:SS UTC
;                  |3 - account expired YYYY/MM/DD HH:NMM:SS local time of calling user
;                  Failure - "", sets @error to:
;                  |1 - No expired accounts found
;                  |2 - Specified date/time is invalid
;                  |3 - Invalid value for $sAD_Class. Has to be "user" or "computer"
; Author ........: water
; Modified.......:
; Remarks .......:
; Related .......: _AD_IsAccountExpired, _AD_SetAccountExpire
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_GetAccountsExpired($sAD_Class = "user", $sAD_DTEExpire = "", $sAD_DTSExpire = "")

	If $sAD_Class <> "user" And $sAD_Class <> "computer" Then Return SetError(3, 0, 0)
	; process end date/time
	If $sAD_DTEExpire = "" Then
		$sAD_DTEExpire = _Date_Time_GetSystemTime() ; Get current date/time (UTC)
		$sAD_DTEExpire = _Date_Time_SystemTimeToDateTimeStr($sAD_DTEExpire, 1) ; convert to format yyyy/mm/dd hh:mm:ss
	ElseIf Not _DateIsValid($sAD_DTEExpire) Then
		Return SetError(2, 0, 0)
	Else
		$sAD_DTEExpire = _Date_Time_EncodeSystemTime(StringMid($sAD_DTEExpire, 6, 2), StringMid($sAD_DTEExpire, 9, 2), StringLeft($sAD_DTEExpire, 4), _ ; encode input
				StringMid($sAD_DTEExpire, 12, 2), StringMid($sAD_DTEExpire, 15, 2), StringMid($sAD_DTEExpire, 18, 2))
		Local $sAD_DTEExpireUTC = _Date_Time_TzSpecificLocalTimeToSystemTime(DllStructGetPtr($sAD_DTEExpire)) ; convert local time to UTC
		$sAD_DTEExpire = _Date_Time_SystemTimeToDateTimeStr($sAD_DTEExpireUTC, 1) ; convert to format yyyy/mm/dd hh:mm:ss
	EndIf
	; process start date/time
	If $sAD_DTSExpire = "" Then $sAD_DTSExpire = "1600/01/01 00:00:00"
	If Not _DateIsValid($sAD_DTSExpire) Then
		Return SetError(2, 0, 0)
	Else
		$sAD_DTSExpire = _Date_Time_EncodeSystemTime(StringMid($sAD_DTSExpire, 6, 2), StringMid($sAD_DTSExpire, 9, 2), StringLeft($sAD_DTSExpire, 4), _ ; encode input
				StringMid($sAD_DTSExpire, 12, 2), StringMid($sAD_DTSExpire, 15, 2), StringMid($sAD_DTSExpire, 18, 2))
		Local $sAD_DTSExpireUTC = _Date_Time_TzSpecificLocalTimeToSystemTime(DllStructGetPtr($sAD_DTSExpire)) ; convert local time to UTC
		$sAD_DTSExpire = _Date_Time_SystemTimeToDateTimeStr($sAD_DTSExpireUTC, 1) ; convert to format yyyy/mm/dd hh:mm:ss
	EndIf
	Local $iAD_DTEExpire = _DateDiff("s", "1601/01/01 00:00:00", $sAD_DTEExpire) * 10000000 ; convert end date/time to Integer8
	Local $iAD_DTSExpire = _DateDiff("s", "1601/01/01 00:00:00", $sAD_DTSExpire) * 10000000 ; convert start date/time to Integer8
	Local $iAD_Temp, $sAD_Temp
	Local $sAD_DTStruct = DllStructCreate("dword low;dword high")
	Local $oAD_Command = ObjCreate("ADODB.Command")
	$oAD_Command.ActiveConnection = $oAD_Connection
	$oAD_Command.Properties("Page Size") = 1000
	; -1 to remove rounding errors
	$oAD_Command.CommandText = "<LDAP://" & $sAD_HostServer & "/" & $sAD_DNSDomain & ">;(&(objectCategory=person)(objectClass=" & $sAD_Class & ")" & _
			"(!accountExpires=0)(accountExpires<=" & Int($iAD_DTEExpire) - 1 & ")(accountExpires>=" & Int($iAD_DTSExpire) - 1 & "));distinguishedName,accountExpires;subtree"
	Local $oAD_RecordSet = $oAD_Command.Execute
	If Not IsObj($oAD_RecordSet) Or $oAD_RecordSet.RecordCount = 0 Then Return SetError(1, 0, "")
	Local $aAD_FQDN[$oAD_RecordSet.RecordCount + 1][3]
	$aAD_FQDN[0][0] = $oAD_RecordSet.RecordCount
	Local $iAD_Count = 1
	While Not $oAD_RecordSet.EOF
		$aAD_FQDN[$iAD_Count][0] = $oAD_RecordSet.Fields(0).Value ; distinguishedName
		$iAD_Temp = $oAD_RecordSet.Fields(1).Value ; accountExpires
		DllStructSetData($sAD_DTStruct, "Low", $iAD_Temp.LowPart)
		DllStructSetData($sAD_DTStruct, "High", $iAD_Temp.HighPart)
		$sAD_Temp = _Date_Time_FileTimeToSystemTime(DllStructGetPtr($sAD_DTStruct))
		$aAD_FQDN[$iAD_Count][1] = _Date_Time_SystemTimeToDateTimeStr($sAD_Temp, 1) ; accountExpires as UTC
		$sAD_Temp = _Date_Time_SystemTimeToTzSpecificLocalTime(DllStructGetPtr($sAD_Temp))
		$aAD_FQDN[$iAD_Count][2] = _Date_Time_SystemTimeToDateTimeStr($sAD_Temp, 1) ; accountExpires as local time
		$iAD_Count += 1
		$oAD_RecordSet.MoveNext
	WEnd
	$aAD_FQDN[0][0] = UBound($aAD_FQDN) - 1
	Return $aAD_FQDN

EndFunc   ;==>_AD_GetAccountsExpired

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_ListSchemaVersions
; Description ...: Returns information about the AD Schema versions.
; Syntax.........: _AD_ListSchemaVersions()
; Parameters ....: None
; Return values .: Success - One dimensional array of the following Schema versions.
;                  |1 - Active Directory Schema version. This can be one of the following values:
;                       13 - Windows 2000 Server
;                       30 - Windows Server 2003 RTM / Service Pack 1 / Service Pack 2
;                       31 - Windows Server 2003 R2
;                       44 - Windows Server 2008 RTM
;                  |2 - Exchange Schema version. This can be one of the following values:
;                       4397 - Exchange Server 2000 RTM
;                       4406 - Exchange Server 2000 With Service Pack 3
;                       6870 - Exchange Server 2003 RTM
;                       6936 - Exchange Server 2003 With Service Pack 3
;                       10628 - Exchange Server 2007
;                       11116 - Exchange 2007 With Service Pack 1
;                       14622 - Exchange 2007 With Service Pack 2, Exchange 2010 RTM
;                  |3 - Exchange 2000 Active Directory Connector version. This can be one of the following values:
;                       4197 - Exchange Server 2000 RTM
;                  |4 - Office Communications Server Schema version. This can be one of the following values:
;                       1006 - LCS 2005 SP1
;                       1007 - OCS 2007
;                       1008 - OCS 2007 R2
; Author ........: water
; Modified.......:
; Remarks .......: RTM stands for "Release to Manufacturing"
; Related .......:
; Link ..........: http://support.microsoft.com/kb/556086, http://www.msxfaq.de/admin/build.htm
; Example .......: Yes
; ===============================================================================================================================
Func _AD_ListSchemaVersions()

	Local $aAD_Result[5] = [4]
	Local $sAD_LDAPEntry
	; Active Directory Schema Version
	Local $sAD_SchemaNamingContext = $oAD_RootDSE.Get("SchemaNamingContext")
	Local $oAD_Object = _AD_ObjGet("LDAP://" & $sAD_SchemaNamingContext) ; Retrieve the COM Object for the object
	$aAD_Result[1] = $oAD_Object.Get("objectVersion")
	; Exchange Schema version
	Local $sAD_Query = "<LDAP://" & $sAD_HostServer & "/" & $sAD_SchemaNamingContext & ">;(name=ms-Exch-Schema-Version-Pt);ADsPath;subtree"
	Local $oAD_RecordSet = $oAD_Connection.Execute($sAD_Query) ; Retrieve the ADsPath for the object
	If IsObj($oAD_RecordSet) And $oAD_RecordSet.RecordCount > 0 Then
		$sAD_LDAPEntry = $oAD_RecordSet.fields(0).value
		$oAD_Object = ObjGet($sAD_LDAPEntry) ; Retrieve the COM Object for the object
		$aAD_Result[2] = $oAD_Object.Get("rangeUpper")
	EndIf
	; Exchange 2000 Active Directory Connector version
	$sAD_Query = "<LDAP://" & $sAD_HostServer & "/" & $sAD_SchemaNamingContext & ">;(name=ms-Exch-Schema-Version-Adc);ADsPath;subtree"
	$oAD_RecordSet = $oAD_Connection.Execute($sAD_Query) ; Retrieve the ADsPath for the object
	If IsObj($oAD_RecordSet) And $oAD_RecordSet.RecordCount > 0 Then
		$sAD_LDAPEntry = $oAD_RecordSet.fields(0).value
		$oAD_Object = ObjGet($sAD_LDAPEntry) ; Retrieve the COM Object for the object
		$aAD_Result[3] = $oAD_Object.Get("rangeUpper")
	EndIf
	; Office Communications Server Schema version
	$sAD_Query = "<LDAP://" & $sAD_HostServer & "/" & $sAD_SchemaNamingContext & ">;(name=ms-RTC-SIP-SchemaVersion);ADsPath;subtree"
	$oAD_RecordSet = $oAD_Connection.Execute($sAD_Query) ; Retrieve the ADsPath for the object
	If IsObj($oAD_RecordSet) And $oAD_RecordSet.RecordCount > 0 Then
		$sAD_LDAPEntry = $oAD_RecordSet.fields(0).value
		$oAD_Object = ObjGet($sAD_LDAPEntry) ; Retrieve the COM Object for the object
		$aAD_Result[4] = $oAD_Object.Get("rangeUpper")
	EndIf

	Return $aAD_Result

EndFunc   ;==>_AD_ListSchemaVersions

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_ObjectExistsInSchema
; Description ...: Returns 1 if exactly one object exists for the given property in the Active Directory Schema.
; Syntax.........: _AD_ObjectExistsInSchema($sAD_Object [, $sAD_Property = "LDAPDisplayName"])
; Parameters ....: $sAD_Object   - Optional: Object to check
;                  $sAD_Property - Optional: Property to check (default = LDAPDisplayName)
; Return values .: Success - 1, Exactly one object exists for the given property in the Active Directory Schema
;                  Failure - 0, sets @error to:
;                  |1 - No object found for the specified property
;                  |x - More than one object found for the specified property. x is the number of objects found
; Author ........: water
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AD_ObjectExistsInSchema($sAD_Object, $sAD_Property = "LDAPDisplayName")

	Local $sAD_SchemaNamingContext = $oAD_RootDSE.Get("SchemaNamingContext")
	Local $sAD_Query = "<LDAP://" & $sAD_HostServer & "/" & $sAD_SchemaNamingContext & ">;(" & $sAD_Property & "=" & $sAD_Object & ");ADsPath;subtree"
	Local $oAD_RecordSet = $oAD_Connection.Execute($sAD_Query) ; Retrieve the ADsPath for the object, if it exists
	If IsObj($oAD_RecordSet) Then
		If $oAD_RecordSet.RecordCount = 1 Then
			Return 1
		ElseIf $oAD_RecordSet.RecordCount > 1 Then
			Return SetError($oAD_RecordSet.RecordCount, 0, 0)
		Else
			Return SetError(1, 0, 0)
		EndIf
	Else
		Return SetError(1, 0, 0)
	EndIf

EndFunc   ;==>_AD_ObjectExistsInSchema

; #FUNCTION# ====================================================================================================================
; Name...........: _AD_GetLastADSIError
; Description ...: Retrieve the calling thread's last ADSI error code value.
; Syntax.........: _AD_GetLastADSIError()
; Parameters ....: None
; Return values .: Success - A one-based array containing the following values:
;                  |1 - ADSI error code (decimal)
;                  |2 - Unicode string that describes the error
;                  |3 - name of the provider that raised the error
;                  |4 - Win32 error code extracted from element[2]
;                  |5 - description of the Win32 error code as returned by _WinAPI_FormatMessage
;                  Failure - "", sets @error to the return value of DLLCall
; Author ........: water
; Modified.......:
; Remarks .......: This and more errors will be handled (error codes are in hex):
;                  525 - user not found
;                  52e - invalid credentials
;                  530 - not permitted to logon at this time
;                  532 - password expired
;                  533 - account disabled
;                  701 - account expired
;                  773 - user must reset password
; Related .......:
; Link ..........: http://msdn.microsoft.com/en-us/library/cc231199(PROT.10).aspx (Win32 Error Codes), http://forums.sun.com/thread.jspa?threadID=703398
; Example .......:
; ===============================================================================================================================
Func _AD_GetLastADSIError()

	Local $aAD_LastError[6] = [5]
	Local $EC = DllStructCreate("DWord")
	Local $ED = DllStructCreate("wchar[256]")
	Local $PN = DllStructCreate("wchar[256]")
	; ADsGetLastError: http://msdn.microsoft.com/en-us/library/aa772183(VS.85).aspx
	DllCall("Activeds.dll", "DWORD", "ADsGetLastError", "ptr", DllStructGetPtr($EC), "ptr", DllStructGetPtr($ED), "DWORD", 256, "ptr", DllStructGetPtr($PN), "DWORD", 256)
	If @error <> 0 Then Return SetError(@error, @extended, "")
	$aAD_LastError[1] = DllStructGetData($EC, 1) ; error code (decimal)
	$aAD_LastError[2] = DllStructGetData($ED, 1) ; Unicode string that describes the error
	$aAD_LastError[3] = DllStructGetData($PN, 1) ; name of the provider that raised the error
	Local $sAD_Error = StringTrimLeft($aAD_LastError[2], StringInStr($aAD_LastError[2], "AcceptSecurityContext", 2))
	$sAD_Error = StringTrimLeft($sAD_Error, StringInStr($sAD_Error, " data", 2) + 5)
	$aAD_LastError[4] = StringTrimRight($sAD_Error, StringLen($sAD_Error) - StringInStr($sAD_Error, ", vece", 2) + 1)
	_WinAPI_FormatMessage($__WINAPICONSTANT_FORMAT_MESSAGE_FROM_SYSTEM, 0, Dec($aAD_LastError[4]), 0, $aAD_LastError[5], 4096, 0)
	Return $aAD_LastError

EndFunc   ;==>_AD_GetLastADSIError

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _AD_Int8ToSec
; Description ...: Function to convert Integer8 attributes from 64-bit numbers to seconds.
; Syntax.........: _AD_Int8ToSec($iAD_Low, $iAD_High)
; Parameters ....: $iAD_Low - Lower Part of the Large Integer
;                  $iAD_High - Higher Part of the Large Integer
; Return values .: Integer (Double Word) value
; Author ........: Jerold Schulman
; Modified.......: water
; Remarks .......: This function is used internally
;                  Many attributes in Active Directory have a data type (syntax) called Integer8.
;                  These 64-bit numbers (8 bytes) often represent time in 100-nanosecond intervals. If the Integer8 attribute is a date,
;                  the value represents the number of 100-nanosecond intervals since 12:00 AM January 1, 1601.
; Related .......:
; Link ..........: http://www.rlmueller.net/Integer8Attributes.htm
; Example .......:
; ===============================================================================================================================
Func _AD_Int8ToSec($oAD_Int8)

	Local $lngHigh, $lngLow
	$lngHigh = $oAD_Int8.HighPart
	$lngLow = $oAD_Int8.LowPart
	If $lngLow < 0 Then
		$lngHigh = $lngHigh + 1
	EndIf
	Return -($lngHigh * (2 ^ 32) + $lngLow) / (10000000)

EndFunc   ;==>_AD_Int8ToSec

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _AD_LargeInt2Double
; Description ...: Converts a large Integer value to an Integer (Double Word) value.
; Syntax.........: _AD_LargeInt2Double($iAD_Low, $iAD_High)
; Parameters ....: $iAD_Low - Lower Part of the Large Integer
;                  $iAD_High - Higher Part of the Large Integer
; Return values .: Integer (Double Word) value
; Author ........: Sundance
; Modified.......: water
; Remarks .......: This function is used internally
; Related .......:
; Link ..........: http://www.autoitscript.com/forum/index.php?showtopic=49627&view=findpost&p=422402
; Example .......:
; ===============================================================================================================================
Func _AD_LargeInt2Double($iAD_Low, $iAD_High)

	Local $iAD_ResultLow, $iAD_ResultHigh
	If $iAD_Low < 0 Then
		$iAD_ResultLow = 2 ^ 32 + $iAD_Low
	Else
		$iAD_ResultLow = $iAD_Low
	EndIf
	If $iAD_High < 0 Then
		$iAD_ResultHigh = 2 ^ 32 + $iAD_High
	Else
		$iAD_ResultHigh = $iAD_High
	EndIf
	Return $iAD_ResultLow + $iAD_ResultHigh * 2 ^ 32

EndFunc   ;==>_AD_LargeInt2Double

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _AD_ObjGet
; Description ...: Returns an LDAP object from a FQDN.
;                  Will use the alternative credentials $sAD_UserId/$sAD_Password if they are set.
; Syntax.........: _AD_ObjGet($sAD_FQDN)
; Parameters ....: $sAD_FQDN - Fully Qualified Domain name of the object for which the LDAP object will be returned.
; Return values .: LDAP object
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: This function is used internally
; Related .......:
; Link ..........: http://msdn.microsoft.com/en-us/library/aa772247(VS.85).aspx (ADS_AUTHENTICATION_ENUM Enumeration)
; Example .......:
; ===============================================================================================================================
Func _AD_ObjGet($sAD_FQDN)

	If $sAD_UserId = "" Then
		Return ObjGet($sAD_FQDN)
	Else
		Return $oAD_OpenDS.OpenDSObject($sAD_FQDN, $sAD_UserId, $sAD_Password, $bAD_BindFlags)
	EndIf

EndFunc   ;==>_AD_ObjGet

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _AD_ErrorHandler
; Description ...: Internal Error event handler for COM errors.
; Syntax.........: _AD_ErrorHandler()
; Parameters ....: None
; Return values .: Sets the global variable $iAD_COMError to the following values:
;                  |1 - All other COM errors
;                  |2 - The specified domain either does not exist or could not be contacted
;                  |3 - Object does not exist in AD
;                  |4 - The server is not operational
;                  |5 - An invalid ADSI path name was passed
;                  |6 - The RPC-Server is not available. A WMI-call to a remote computer failed
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: This function is used internally
;                  0x80005xxx - ADSI error codes
;                  0x80007xxx - LDAP error codes for ADSI
;
;                  ADSI Error Codes:
;                  Code        Symbol                        Description
;                  -----------------------------------------------------
;                  0x80005000  E_ADS_BAD_PATHNAME            An invalid ADSI path name was passed
;                  0x80005001  E_ADS_INVALID_DOMAIN_OBJECT   An unknown ADSI domain object was requested
;                  0x80005002  E_ADS_INVALID_USER_OBJECT     An unknown ADSI user object was requested
;                  0x80005003  E_ADS_INVALID_COMPUTER_OBJECT An unknown ADSI computer object was requested
;                  0x80005004  E_ADS_UNKNOWN_OBJECT          An unknown ADSI object was requested
;                  0x80005005  E_ADS_PROPERTY_NOT_SET        The specified ADSI property was not set
;                  0x80005006  E_ADS_PROPERTY_NOT_SUPPORTED  The specified ADSI property is not supported
;                  0x80005007  E_ADS_PROPERTY_INVALID        The specified ADSI property is invalid
;                  0x80005008  E_ADS_BAD_PARAMETER           One or more input parameters are invalid
;                  0x80005009  E_ADS_OBJECT_UNBOUND          The specified ADSI object is not bound to a remote resource
;                  0x8000500A  E_ADS_PROPERTY_NOT_MODIFIED   The specified ADSI object has not been modified
;                  0x8000500B  E_ADS_PROPERTY_MODIFIED       The specified ADSI object has been modified
;                  0x8000500C  E_ADS_CANT_CONVERT_DATATYPE   The ADSI data type cannot be converted to/from a native DS data type
;                  0x8000500D  E_ADS_PROPERTY_NOT_FOUND      The ADSI property cannot be found in the cache
;                  0x8000500E  E_ADS_OBJECT_EXISTS           The ADSI object exists
;                  0x8000500F  E_ADS_SCHEMA_VIOLATION        The attempted action violates the directory service schema rules
;                  0x80005010  E_ADS_COLUMN_NOT_SET          The specified column in the ADSI was not set
;                  0x00005011  S_ADS_ERRORSOCCURRED          One or more errors occurred
;                  0x00005012  S_ADS_NOMORE_ROWS             The search operation has reached the last row
;                  0x00005013  S_ADS_NOMORE_COLUMNS          The search operation has reached the last column for the current row
;                  0x80005014  E_ADS_INVALID_FILTER          The specified search filter is invalid
; Related .......:
; Link ..........: http://msdn.microsoft.com/en-us/library/aa772195(VS.85).aspx (Active Directory Services Interface Error Codes)
;                  http://msdn.microsoft.com/en-us/library/cc704587(PROT.10).aspx (HRESULT Values)
; Example .......:
; ===============================================================================================================================
Func _AD_ErrorHandler()

	Local $bAD_HexNumber = Hex($oAD_MyError.number, 8)
	Local $sAD_Error = "COM Error Encountered in " & @ScriptName & @CRLF & _
			"Scriptline = " & $oAD_MyError.scriptline & @CRLF & _
			"NumberHex = " & $bAD_HexNumber & @CRLF & _
			"Number = " & $oAD_MyError.number & @CRLF & _
			"WinDescription = " & StringStripWS($oAD_MyError.WinDescription, 2) & @CRLF & _
			"Description = " & StringStripWS($oAD_MyError.description, 2) & @CRLF & _
			"Source = " & $oAD_MyError.Source & @CRLF & _
			"HelpFile = " & $oAD_MyError.HelpFile & @CRLF & _
			"HelpContext = " & $oAD_MyError.HelpContext & @CRLF & _
			"LastDllError = " & $oAD_MyError.LastDllError
	If $iAD_Debug > 0 Then
		If $iAD_Debug = 1 Then ConsoleWrite($sAD_Error & @CRLF & "========================================================" & @CRLF)
		If $iAD_Debug = 2 Then MsgBox(64, "Active Directory Functions - Debug Info", $sAD_Error)
		If $iAD_Debug = 3 Then FileWrite("AD_Debug.txt", @YEAR & "." & @MON & "." & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC & " " & @CRLF & _
				"-------------------" & @CRLF & $sAD_Error & @CRLF & "========================================================" & @CRLF)
	EndIf
	$iAD_COMErrorDec = $oAD_MyError.number
	Switch $bAD_HexNumber
		; 8007054B: ERROR_NO_SUCH_DOMAIN - The specified domain either does not exist or could not be contacted
		Case "8007054B"
			$iAD_COMError = 2
			; 80020009: DISP_E_EXCEPTION - Unanticipated error occurred
			; 80072030: LDAP_NO_SUCH_OBJECT - Object does not exist
		Case "80020009", "80072030"
			$iAD_COMError = 3
			; 8007203A: LDAP_SERVER_DOWN - The server is not operational. Can be caused by hitting a domain controller too hard
		Case "8007203A"
			$iAD_COMError = 4
			; 80005000: E_ADS_BAD_PATHNAME - An invalid ADSI path name was passed
		Case "80005000"
			$iAD_COMError = 5
			; 800706BA: RPC_S_SERVICE_UNAVAILABLE - The RPC-Server is not available
		Case "800706BA"
			$iAD_COMError = 6
		Case Else
			MsgBox(262144, "Active Directory Functions", $sAD_Error)
			$iAD_COMError = 1
	EndSwitch

EndFunc   ;==>_AD_ErrorHandler

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _AD_FixSpecialChars
; Description ...: Returns either corrected (with 'escaped' chars) or uncorrected (removes 'escapes' for chars) text.
; Syntax.........: _AD_FixSpecialChars($sAD_Text[, $iAD_Option = 0[, $sAD_EscapeChar = "/#,"]])
; Parameters ....: $sAD_Text - Text to add / remove escape characters
;                  $iAD_Option - Optional: Defines whether to insert the escape character (Default) or remove them.
;                                0 = Insert the escape characters (default)
;                                1 = Remove the escape characters
;                  $sAD_EscapeChar - Optional: List of characters to escape or unescape (default = "/#,")
; Return values .: $sAD_Text with inserted or removed escape characters
; Author ........: Jonathan Clelland
; Modified.......: water
; Remarks .......: This function is used internally
; Related .......:
; Link ..........: http://www.rlmueller.net/CharactersEscaped.htm
; Example .......:
; ===============================================================================================================================
Func _AD_FixSpecialChars($sAD_Text, $iAD_Option = 0, $sAD_EscapeChar = "/#,")

	If $iAD_Option = 0 Then
		; "?<!" means: Lookbehind assertion (negative) - see: http://www.autoitscript.com/forum/index.php?showtopic=112674&view=findpost&p=789310
		$sAD_Text = StringRegExpReplace($sAD_Text, "(?<!\\)([" & $sAD_EscapeChar & "])", "\\$1")
	Else
		If StringInStr($sAD_EscapeChar, "#") Then $sAD_Text = StringReplace($sAD_Text, "\#", "#")
		If StringInStr($sAD_EscapeChar, ",") Then $sAD_Text = StringReplace($sAD_Text, "\,", ",")
		If StringInStr($sAD_EscapeChar, "/") Then $sAD_Text = StringReplace($sAD_Text, "\/", "/")
	EndIf
	Return $sAD_Text

EndFunc   ;==>_AD_FixSpecialChars

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _AD_ReorderACE
; Description ...: Reorders the ACEs in a DACL to meet MS recommandations.
; Syntax.........: _AD_ReorderACE($oAD_DACL)
; Parameters ....: $oAD_DACL - Discretionary Access Control List
; Return values .: A reordered DACL according to MS recommandation
; Author ........: Richard L. Mueller
; Modified.......: water
; Remarks .......: This function is used internally
;+
;                  The Active Directory Service Interfaces (ADSI) property cache on Microsoft Windows Server 2003 and on Microsoft Windows XP
;                  will correctly order the DACL before writing it back to the object. Reordering is only required on Microsoft Windows 2000.
;                  The proper order of ACEs in an ACL is as follows:
;                    Access-denied ACEs that apply to the object itself
;                    Access-denied ACEs that apply to a child of the object, such as a property set or property
;                    Access-allowed ACEs that apply to the object itself
;                    Access-allowed ACEs that apply to a child of the object, such as a property set or property
;                    All inherited ACEs
; Related .......:
; Link ..........: http://support.microsoft.com/kb/269159/en-us
; Example .......:
; ===============================================================================================================================
Func _AD_ReorderACE($oAD_DACL)

	; Reorder ACE's in DACL
	Local $oAD_NewDACL, $oAD_InheritedDACL, $oAD_AllowDACL, $oAD_DenyDACL, $oAD_AllowObjectDACL, $oAD_DenyObjectDACL, $oAD_ACE

	$oAD_NewDACL = ObjCreate("AccessControlList")
	$oAD_InheritedDACL = ObjCreate("AccessControlList")
	$oAD_AllowDACL = ObjCreate("AccessControlList")
	$oAD_DenyDACL = ObjCreate("AccessControlList")
	$oAD_AllowObjectDACL = ObjCreate("AccessControlList")
	$oAD_DenyObjectDACL = ObjCreate("AccessControlList")

	For $oAD_ACE In $oAD_DACL
		If ($oAD_ACE.AceFlags And $ADS_ACEFLAG_INHERITED_ACE) = $ADS_ACEFLAG_INHERITED_ACE Then
			$oAD_InheritedDACL.AddAce($oAD_ACE)
		Else
			Switch $oAD_ACE.AceType
				Case $ADS_ACETYPE_ACCESS_ALLOWED
					$oAD_AllowDACL.AddAce($oAD_ACE)
				Case $ADS_ACETYPE_ACCESS_DENIED
					$oAD_DenyDACL.AddAce($oAD_ACE)
				Case $ADS_ACETYPE_ACCESS_ALLOWED_OBJECT
					$oAD_AllowObjectDACL.AddAce($oAD_ACE)
				Case $ADS_ACETYPE_ACCESS_DENIED_OBJECT
					$oAD_DenyObjectDACL.AddAce($oAD_ACE)
				Case Else
					; $fAD_ACL = False
			EndSwitch
		EndIf
	Next
	For $oAD_ACE In $oAD_DenyDACL
		$oAD_NewDACL.AddAce($oAD_ACE)
	Next
	For $oAD_ACE In $oAD_DenyObjectDACL
		$oAD_NewDACL.AddAce($oAD_ACE)
	Next
	For $oAD_ACE In $oAD_AllowDACL
		$oAD_NewDACL.AddAce($oAD_ACE)
	Next
	For $oAD_ACE In $oAD_AllowObjectDACL
		$oAD_NewDACL.AddAce($oAD_ACE)
	Next
	For $oAD_ACE In $oAD_InheritedDACL
		$oAD_NewDACL.AddAce($oAD_ACE)
	Next
	$oAD_NewDACL.ACLRevision = $oAD_DACL.ACLRevision
	Return $oAD_NewDACL

EndFunc   ;==>_AD_ReorderACE

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _AD_GetLastLDAPError
; Description ...: Retrieve the calling thread's last LDAP error code value.
; Syntax.........: _AD_GetLastLDAPError()
; Parameters ....: None
; Return values .: Success - An array containing the following values:
;                  |1 - LDAP error code (decimal)
;                  Failure - "", sets @error to the return value of DLLCall
; Author ........: water
; Modified.......:
; Remarks .......: This function is used internally
; Related .......:
; Link ..........: http://msdn.microsoft.com/en-us/library/aa366119(VS.85).aspx
; Example .......:
; ===============================================================================================================================
Func _AD_GetLastLDAPError()

	Local $iAD_Error = DllCall("WLDAP32.dll", "ULONG", "LdapGetLastError")
	If IsArray($iAD_Error) Then
		Local $R = _ArrayToString($iAD_Error)
		ConsoleWrite("IsArray: " & $R & @CRLF)
		For $I = 0 To UBound($iAD_Error) - 1
			ConsoleWrite($I & ": " & $iAD_Error[$I] & " - " & Hex($iAD_Error[$I], 8) & " - " & Dec(Hex($iAD_Error[$I], 8)) & " " & DllStructGetData($iAD_Error, $I) & @CRLF)
		Next
	Else
		ConsoleWrite(DllStructGetData($iAD_Error, 1) & " - " & Hex(DllStructGetData($iAD_Error, 1), 8) & " " & DllStructGetData($iAD_Error, 2) & " - " & Hex(DllStructGetData($iAD_Error, 2), 8) & @CRLF)
	EndIf


	; http://msdn.microsoft.com/en-us/library/aa366570(v=VS.85).aspx
	; ldap_err2string

EndFunc   ;==>_AD_GetLastLDAPError
