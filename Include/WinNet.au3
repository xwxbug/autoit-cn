#include-once
#include <WinAPI.au3>
#include <StructureConstants.au3>

; #INDEX# =======================================================================================================================
; Title .........: Windows Networking
; AutoIt Version: 3.2.3++
; Language:       English
; Description ...: The Windows Networking (WNet) functions allow you to implement networking  capabilities  in  your  application
;                  without making allowances for a particular network  provider  or  physical  network  implementation.  This  is
;                  because the WNet functions are network independent.
; Author ........: Paul Campbell (PaulIA)
; ===============================================================================================================================

; #CONSTANTS# ===================================================================================================================
Global Const $CONNDLG_RO_PATH = 0x00000001
Global Const $CONNDLG_CONN_POINT = 0x00000002
Global Const $CONNDLG_USE_MRU = 0x00000004
Global Const $CONNDLG_HIDE_BOX = 0x00000008
Global Const $CONNDLG_PERSIST = 0x00000010
Global Const $CONNDLG_NOT_PERSIST = 0x00000020

Global Const $CONNECT_UPDATE_PROFILE = 0x00000001
Global Const $CONNECT_UPDATE_RECENT = 0x00000002
Global Const $CONNECT_TEMPORARY = 0x00000004
Global Const $CONNECT_INTERACTIVE = 0x00000008
Global Const $CONNECT_PROMPT = 0x00000010
Global Const $CONNECT_NEED_DRIVE = 0x00000020
Global Const $CONNECT_REFCOUNT = 0x00000040
Global Const $CONNECT_REDIRECT = 0x00000080
Global Const $CONNECT_LOCALDRIVE = 0x00000100
Global Const $CONNECT_CURRENT_MEDIA = 0x00000200
Global Const $CONNECT_DEFERRED = 0x00000400
Global Const $CONNECT_COMMANDLINE = 0x00000800
Global Const $CONNECT_CMD_SAVECRED = 0x00001000
Global Const $CONNECT_RESERVED = 0xFF000000

Global Const $DISC_UPDATE_PROFILE = 0x00000001
Global Const $DISC_NO_FORCE = 0x00000040

Global Const $RESOURCE_CONNECTED = 0x00000001
Global Const $RESOURCE_GLOBALNET = 0x00000002
Global Const $RESOURCE_REMEMBERED = 0x00000003
Global Const $RESOURCE_RECENT = 0x00000004
Global Const $RESOURCE_CONTEXT = 0x00000005

Global Const $RESOURCETYPE_ANY = 0x00000000
Global Const $RESOURCETYPE_DISK = 0x00000001
Global Const $RESOURCETYPE_PRINT = 0x00000002
Global Const $RESOURCETYPE_RESERVED = 0x00000008
Global Const $RESOURCETYPE_UNKNOWN = 0xFFFFFFFF

Global Const $RESOURCEUSAGE_CONNECTABLE = 0x00000001
Global Const $RESOURCEUSAGE_CONTAINER = 0x00000002
Global Const $RESOURCEUSAGE_NOLOCALDEVICE = 0x00000004
Global Const $RESOURCEUSAGE_SIBLING = 0x00000008
Global Const $RESOURCEUSAGE_ATTACHED = 0x00000010
Global Const $RESOURCEUSAGE_RESERVED = 0x80000000

Global Const $WNNC_NET_MSNET = 0x00010000
Global Const $WNNC_NET_LANMAN = 0x00020000
Global Const $WNNC_NET_NETWARE = 0x00030000
Global Const $WNNC_NET_VINES = 0x00040000
Global Const $WNNC_NET_10NET = 0x00050000
Global Const $WNNC_NET_LOCUS = 0x00060000
Global Const $WNNC_NET_SUN_PC_NFS = 0x00070000
Global Const $WNNC_NET_LANSTEP = 0x00080000
Global Const $WNNC_NET_9TILES = 0x00090000
Global Const $WNNC_NET_LANTASTIC = 0x000A0000
Global Const $WNNC_NET_AS400 = 0x000B0000
Global Const $WNNC_NET_FTP_NFS = 0x000C0000
Global Const $WNNC_NET_PATHWORKS = 0x000D0000
Global Const $WNNC_NET_LIFENET = 0x000E0000
Global Const $WNNC_NET_POWERLAN = 0x000F0000
Global Const $WNNC_NET_BWNFS = 0x00100000
Global Const $WNNC_NET_COGENT = 0x00110000
Global Const $WNNC_NET_FARALLON = 0x00120000
Global Const $WNNC_NET_APPLETALK = 0x00130000
Global Const $WNNC_NET_INTERGRAPH = 0x00140000
Global Const $WNNC_NET_SYMFONET = 0x00150000
Global Const $WNNC_NET_CLEARCASE = 0x00160000
Global Const $WNNC_NET_FRONTIER = 0x00170000
Global Const $WNNC_NET_BMC = 0x00180000
Global Const $WNNC_NET_DCE = 0x00190000
Global Const $WNNC_NET_AVID = 0x001A0000
Global Const $WNNC_NET_DOCUSPACE = 0x001B0000
Global Const $WNNC_NET_MANGOSOFT = 0x001C0000
Global Const $WNNC_NET_SERNET = 0x001D0000
Global Const $WNNC_NET_RIVERFRONT1 = 0x001E0000
Global Const $WNNC_NET_RIVERFRONT2 = 0x001F0000
Global Const $WNNC_NET_DECORB = 0x00200000
Global Const $WNNC_NET_PROTSTOR = 0x00210000
Global Const $WNNC_NET_FJ_REDIR = 0x00220000
Global Const $WNNC_NET_DISTINCT = 0x00230000
Global Const $WNNC_NET_TWINS = 0x00240000
Global Const $WNNC_NET_RDR2SAMPLE = 0x00250000
Global Const $WNNC_NET_CSC = 0x00260000
Global Const $WNNC_NET_3IN1 = 0x00270000
Global Const $WNNC_NET_EXTENDNET = 0x00290000
Global Const $WNNC_NET_STAC = 0x002A0000
Global Const $WNNC_NET_FOXBAT = 0x002B0000
Global Const $WNNC_NET_YAHOO = 0x002C0000
Global Const $WNNC_NET_EXIFS = 0x002D0000
Global Const $WNNC_NET_DAV = 0x002E0000
Global Const $WNNC_NET_KNOWARE = 0x002F0000
Global Const $WNNC_NET_OBJECT_DIRE = 0x00300000
Global Const $WNNC_NET_MASFAX = 0x00310000
Global Const $WNNC_NET_HOB_NFS = 0x00320000
Global Const $WNNC_NET_SHIVA = 0x00330000
Global Const $WNNC_NET_IBMAL = 0x00340000
Global Const $WNNC_NET_LOCK = 0x00350000
Global Const $WNNC_NET_TERMSRV = 0x00360000
Global Const $WNNC_NET_SRT = 0x00370000
Global Const $WNNC_NET_QUINCY = 0x00380000
Global Const $WNNC_CRED_MANAGER = 0xFFFF0000
; ===============================================================================================================================

;==============================================================================================================================
; #CURRENT# =====================================================================================================================
;_WinNet_AddConnection
;_WinNet_AddConnection2
;_WinNet_AddConnection3
;_WinNet_CancelConnection
;_WinNet_CancelConnection2
;_WinNet_CloseEnum
;_WinNet_ConnectionDialog
;_WinNet_ConnectionDialog1
;_WinNet_DisconnectDialog
;_WinNet_DisconnectDialog1
;_WinNet_EnumResource
;_WinNet_GetConnection
;_WinNet_GetConnectionPerformance
;_WinNet_GetLastError
;_WinNet_GetNetworkInformation
;_WinNet_GetProviderName
;_WinNet_GetResourceInformation
;_WinNet_GetResourceParent
;_WinNet_GetUniversalName
;_WinNet_GetUser
;_WinNet_OpenEnum
;_WinNet_RestoreConnection
;_WinNet_UseConnection
; ===============================================================================================================================

; #INTERNAL_USE_ONLY#============================================================================================================
;_WinNet_NETRESOURCEToArray
;==============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name...........: _WinNet_AddConnection
; Description ...: Connects a local device to a network resource
; Syntax.........: _WinNet_AddConnection($sLocalName, $sRemoteName[, $sPassword = 0])
; Parameters ....: $sLocalName  - Name of a local device to be redirected, such as "F:" or "LPT1".  The string is  treated  in  a
;                  +case-insensitive manner.  If 0, a connection to the network resource is made without  redirecting  the  local
;                  +device.
;                  $sRemoteName - Name of the network resource to connect to
;                  $sPassword   - Password to be used to make a connection.  This parameter is usually  the  password  associated
;                  +with the current user. If 0, the default password is used. If the string is empty, no password is used.
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: This function is provided only for compatibility with 16-bit versions of Windows. Applications should call the
;                  WNet_AddConnection2 or the WNet_AddConnection3 function.  A successful connection is persistent  meaning  that
;                  the system automatically restores the connection during subsequent logon operations.
; Related .......: _WinNet_AddConnection2, _WinNet_AddConnection3
; Link ..........; @@MsdnLink@@ WNetAddConnectionA
; Example .......;
; ===============================================================================================================================
Func _WinNet_AddConnection($sLocalName, $sRemoteName, $sPassword = 0)
	Local $pPassWord, $tPassword, $aResult

	If IsString($sPassword) Then
		$tPassword = DllStructCreate("char Text[4096]")
		$pPassWord = DllStructGetPtr($tPassword)
		DllStructSetData($tPassword, "Text", $sPassword)
	EndIf

	$aResult = DllCall("Mpr.dll", "dword", "WNetAddConnectionA", "str", $sRemoteName, "ptr", $pPassWord, "str", $sLocalName)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_WinNet_AddConnection

; #FUNCTION# ====================================================================================================================
; Name...........: _WinNet_AddConnection2
; Description ...: Connects a local device to a network resource
; Syntax.........: _WinNet_AddConnection2($sLocalName, $sRemoteName[, $sUserName = 0[, $sPassword = 0[, $iType = 1[, $iOptions = 1]]]])
; Parameters ....: $sLocalName  - Name of a local device to be redirected, such as "F:" or "LPT1".  The string is  treated  in  a
;                  +case-insensitive manner.  If 0, a connection to the network resource is made without  redirecting  the  local
;                  +device.
;                  $sRemoteName - Name of the network resource to connect to
;                  $sUsername   - User name for making the connection. If 0, the function uses the default user name.
;                  $sPassword   - Password to be used to make a connection. If 0, the default password is used.  If the string is
;                  +empty, no password is used.
;                  $iType       - Specifies the type of network resource to connect to:
;                  |0 - Any (only if $sLocalName is 0)
;                  |1 - Disk
;                  |2 - Print
;                  $iOptions    - Connection options. Can be one or more of the following:
;                  | 1 - The network resource connection should be remembered
;                  | 2 - The operating system may interact with the user for authentication purposes
;                  | 4 - The system not to use any default setting for user names or passwords  without  offering  the  user  the
;                  +opportunity to supply an alternative. This flag is ignored unless bit 2 (interactive) is also set.
;                  | 8 - Forces the redirection of a local device when making the connection
;                  |16 - The operating system prompts the user for authentication using the command line instead of a  GUI.  This
;                  +flag is ignored unless bit 2 (interactive) is also set.
;                  |32 - If this bit is set, and the operating system prompts for a credential, the credential is  saved  by  the
;                  +credential manager.  If the credential manager is disabled for the caller's logon session, or if the  network
;                  +provider does not support saving credentials, this flag is ignored.  This flag is also ignored unless you set
;                  +bit 5 (command line instead of GUI).
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _WinNet_AddConnection, _WinNet_AddConnection3
; Link ..........; @@MsdnLink@@ WNetAddConnection2A
; Example .......;
; ===============================================================================================================================
Func _WinNet_AddConnection2($sLocalName, $sRemoteName, $sUserName = 0, $sPassword = 0, $iType = 1, $iOptions = 1)
	Local $pLocalName, $tLocalName, $pRemoteName, $tRemoteName, $pUserName, $tUserName
	Local $pPassWord, $tPassword, $pResource, $tResource, $iFlags, $aResult

	$tLocalName = DllStructCreate("char Text[1024]")
	$pLocalName = DllStructGetPtr($tLocalName)
	DllStructSetData($tLocalName, "Text", $sLocalName)

	$tRemoteName = DllStructCreate("char Text[1024]")
	$pRemoteName = DllStructGetPtr($tRemoteName)
	DllStructSetData($tRemoteName, "Text", $sRemoteName)

	If IsString($sUserName) Then
		$tUserName = DllStructCreate("char Text[1024]")
		$pUserName = DllStructGetPtr($tUserName)
		DllStructSetData($tUserName, "Text", $sUserName)
	EndIf

	If IsString($sPassword) Then
		$tPassword = DllStructCreate("char Text[1024]")
		$pPassWord = DllStructGetPtr($tPassword)
		DllStructSetData($tPassword, "Text", $sPassword)
	EndIf

	If BitAND($iOptions, 1) <> 0 Then $iFlags = BitOR($iFlags, $CONNECT_UPDATE_PROFILE)
	If BitAND($iOptions, 2) <> 0 Then $iFlags = BitOR($iFlags, $CONNECT_INTERACTIVE)
	If BitAND($iOptions, 4) <> 0 Then $iFlags = BitOR($iFlags, $CONNECT_PROMPT)
	If BitAND($iOptions, 8) <> 0 Then $iFlags = BitOR($iFlags, $CONNECT_REDIRECT)
	If BitAND($iOptions, 16) <> 0 Then $iFlags = BitOR($iFlags, $CONNECT_COMMANDLINE)
	If BitAND($iOptions, 32) <> 0 Then $iFlags = BitOR($iFlags, $CONNECT_CMD_SAVECRED)

	$tResource = DllStructCreate($tagNETRESOURCE)
	$pResource = DllStructGetPtr($tResource)
	DllStructSetData($tResource, "Type", $iType)
	DllStructSetData($tResource, "LocalName", $pLocalName)
	DllStructSetData($tResource, "RemoteName", $pRemoteName)

	$aResult = DllCall("Mpr.dll", "dword", "WNetAddConnection2A", "ptr", $pResource, "ptr", $pPassWord, "ptr", $pUserName, "dword", $iFlags)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_WinNet_AddConnection2

; #FUNCTION# ====================================================================================================================
; Name...........: _WinNet_AddConnection3
; Description ...: Connects a local device to a network resource
; Syntax.........: _WinNet_AddConnection3($hWnd, $sLocalName, $sRemoteName[, $sUserName = 0[, $sPassword = 0[, $iType = 1[, $iOptions = 1]]]])
; Parameters ....: $hWnd        - Handle to a window that the provider of network resources  can  use  as  an  owner  window  for
;                  +dialogs. Use this parameter if you set bit 2 (interactive) in the Options parameter. This parameter can be 0.
;                  $sLocalName  - Name of a local device to be redirected, such as "F:" or "LPT1".  The string is  treated  in  a
;                  +case-insensitive manner.  If 0, a connection to the network resource is made without  redirecting  the  local
;                  +device.
;                  $sRemoteName - Name of the network resource to connect to
;                  $sUsername   - User name for making the connection.  If 0, the function uses the default user name.
;                  $sPassword   - Password to be used to make a connection.  If 0, the default password is used. If the string is
;                  +empty, no password is used.
;                  $iType       - Specifies the type of network resource to connect to:
;                  |0 - Any (only if $sLocalName is 0)
;                  |1 - Disk
;                  |2 - Print
;                  $iOptions    - Connection options. Can be one or more of the following:
;                  | 1 - The network resource connection should be remembered
;                  | 2 - The operating system may interact with the user for authentication purposes
;                  | 4 - The system not to use any default setting for user names or passwords  without  offering  the  user  the
;                  +opportunity to supply an alternative.  This flag is ignored unless bit 2 (interactive) is also set.
;                  | 8 - Forces the redirection of a local device when making the connection
;                  |16 - The operating system prompts the user for authentication using the command line instead of a  GUI.  This
;                  +flag is ignored unless bit 2 (interactive) is also set.
;                  |32 - If this bit is set, and the operating system prompts for a credential, the credential is  saved  by  the
;                  +credential manager.  If the credential manager is disabled for the caller's logon session, or if the  network
;                  +provider does not support saving credentials, this flag is ignored.  This flag is also ignored unless you set
;                  +bit 5 (command line instead of GUI).
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _WinNet_AddConnection, _WinNet_AddConnection2
; Link ..........; @@MsdnLink@@ WNetAddConnection3A
; Example .......;
; ===============================================================================================================================
Func _WinNet_AddConnection3($hWnd, $sLocalName, $sRemoteName, $sUserName = 0, $sPassword = 0, $iType = 1, $iOptions = 1)
	Local $pLocalName, $tLocalName, $pRemoteName, $tRemoteName, $pUserName, $tUserName
	Local $pPassWord, $tPassword, $pResource, $tResource, $iFlags, $aResult

	$tLocalName = DllStructCreate("char Text[1024]")
	$pLocalName = DllStructGetPtr($tLocalName)
	DllStructSetData($tLocalName, "Text", $sLocalName)

	$tRemoteName = DllStructCreate("char Text[1024]")
	$pRemoteName = DllStructGetPtr($tRemoteName)
	DllStructSetData($tRemoteName, "Text", $sRemoteName)

	If IsString($sUserName) Then
		$tUserName = DllStructCreate("char Text[1024]")
		$pUserName = DllStructGetPtr($tUserName)
		DllStructSetData($tUserName, "Text", $sUserName)
	EndIf

	If IsString($sPassword) Then
		$tPassword = DllStructCreate("char Text[1024]")
		$pPassWord = DllStructGetPtr($tPassword)
		DllStructSetData($tPassword, "Text", $sPassword)
	EndIf

	If BitAND($iOptions, 1) <> 0 Then $iFlags = BitOR($iFlags, $CONNECT_UPDATE_PROFILE)
	If BitAND($iOptions, 2) <> 0 Then $iFlags = BitOR($iFlags, $CONNECT_INTERACTIVE)
	If BitAND($iOptions, 4) <> 0 Then $iFlags = BitOR($iFlags, $CONNECT_PROMPT)
	If BitAND($iOptions, 8) <> 0 Then $iFlags = BitOR($iFlags, $CONNECT_REDIRECT)
	If BitAND($iOptions, 16) <> 0 Then $iFlags = BitOR($iFlags, $CONNECT_COMMANDLINE)
	If BitAND($iOptions, 32) <> 0 Then $iFlags = BitOR($iFlags, $CONNECT_CMD_SAVECRED)

	$tResource = DllStructCreate($tagNETRESOURCE)
	$pResource = DllStructGetPtr($tResource)
	DllStructSetData($tResource, "Type", $iType)
	DllStructSetData($tResource, "LocalName", $pLocalName)
	DllStructSetData($tResource, "RemoteName", $pRemoteName)

	$aResult = DllCall("Mpr.dll", "dword", "WNetAddConnection3A", "hwnd", $hWnd, "ptr", $pResource, "ptr", $pPassWord, "ptr", $pUserName, "dword", $iFlags)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_WinNet_AddConnection3

; #FUNCTION# ====================================================================================================================
; Name...........: _WinNet_CancelConnection
; Description ...: Cancels an existing network connection
; Syntax.........: _WinNet_CancelConnection($sName[, $fForce = True])
; Parameters ....: $sName       - Name of either the redirected local device or the remote network resource to  disconnect  from.
;                  +When this parameter specifies a redirected local device, the  function  cancels  only  the  specified  device
;                  +redirection.  If the parameter specifies a remote network resource, only the connections to  remote  networks
;                  +without devices are canceled.
;                  $fForce      - Specifies whether or not the disconnection should occur if there are open files or jobs on  the
;                  +connection.  If this parameter is False, the function fails if there are open files or jobs.
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: This function is provided for compatibility with 16-bit versions of  Windows. Other Windows-based applications
;                  should call the WNet_CancelConnection2 function.
; Related .......: _WinNet_CancelConnection2
; Link ..........; @@MsdnLink@@ WNetCancelConnectionA
; Example .......;
; ===============================================================================================================================
Func _WinNet_CancelConnection($sName, $fForce = True)
	Local $aResult

	$aResult = DllCall("Mpr.dll", "dword", "WNetCancelConnectionA", "str", $sName, "int", $fForce)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_WinNet_CancelConnection

; #FUNCTION# ====================================================================================================================
; Name...........: _WinNet_CancelConnection2
; Description ...: Cancels an existing network connection
; Syntax.........: _WinNet_CancelConnection2($sName[, $fUpdate = True[, $fForce = True]])
; Parameters ....: $sName       - Name of either the redirected local device or the remote network resource to  disconnect  from.
;                  +When this parameter specifies a redirected local device, the  function  cancels  only  the  specified  device
;                  +redirection.  If the parameter specifies a remote network resource, only the connections to  remote  networks
;                  +without devices are canceled.
;                  $fUpdate     - If True, the users profile is updated with the information that the connection is no  longer  a
;                  +persistent one.
;                  $fForce      - Specifies whether or not the disconnection should occur if there are open files or jobs on  the
;                  +connection.  If this parameter is False, the function fails if there are open files or jobs.
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _WinNet_CancelConnection
; Link ..........; @@MsdnLink@@ WNetCancelConnection2A
; Example .......;
; ===============================================================================================================================
Func _WinNet_CancelConnection2($sName, $fUpdate = True, $fForce = True)
	Local $aResult

	$aResult = DllCall("Mpr.dll", "dword", "WNetCancelConnection2A", "str", $sName, "int", $fUpdate, "int", $fForce)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_WinNet_CancelConnection2

; #FUNCTION# ====================================================================================================================
; Name...........: _WinNet_CloseEnum
; Description ...: Ends a network resource enumeration started by a call to WNetOpenEnum
; Syntax.........: _WinNet_CloseEnum($hEnum)
; Parameters ....: $hEnum       - Handle that identifies an enumeration instance.  The handle is returned  by  the  WNet_OpenEnum
;                  +function
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _WinNet_OpenEnum
; Link ..........; @@MsdnLink@@ WNetCloseEnum
; Example .......;
; ===============================================================================================================================
Func _WinNet_CloseEnum($hEnum)
	Local $aResult

	$aResult = DllCall("Mpr.dll", "dword", "WNetCloseEnum", "hwnd", $hEnum)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_WinNet_CloseEnum

; #FUNCTION# ====================================================================================================================
; Name...........: _WinNet_ConnectionDialog
; Description ...: Starts a general browsing dialog box for connecting to network resources
; Syntax.........: _WinNet_ConnectionDialog($hWnd)
; Parameters ....: $hWnd        - Handle to the owner window for the dialog box
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _WinNet_ConnectionDialog1
; Link ..........; @@MsdnLink@@ WNetConnectionDialog
; Example .......;
; ===============================================================================================================================
Func _WinNet_ConnectionDialog($hWnd)
	Local $aResult

	$aResult = DllCall("Mpr.dll", "dword", "WNetConnectionDialog", "hwnd", $hWnd, "dword", $RESOURCETYPE_DISK)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_WinNet_ConnectionDialog

; #FUNCTION# ====================================================================================================================
; Name...........: _WinNet_ConnectionDialog1
; Description ...: Starts a general browsing dialog box for connecting to network resources
; Syntax.........: _WinNet_ConnectionDialog1($hWnd[, $sRemoteName = ""[, $iFlags = 2]])
; Parameters ....: $hWnd        - Handle to the owner window for the dialog box
;                  $RemoteName  - Name of the network resource to connect to
;                  $iFlags      - Dialog box options. Can be one or more of the following:
;                  | 1 - Display a read-only path instead of allowing the user to type in a path
;                  | 2 - Enter the most recently used paths into the combination box
;                  | 4 - Do not show the restore the connection at logon checkbox
;                  | 8 - Restore the connection at logon
;                  |16 - Do not restore the connection at logon
; Return values .: Success      - The number of the connected device.  The value is 1 for A:, 2 for B:, 3 for C: and  so  on.  If
;                  +the user made a deviceless connection, the value is –1.
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _WinNet_ConnectionDialog
; Link ..........; @@MsdnLink@@ WNetConnectionDialog1
; Example .......;
; ===============================================================================================================================
Func _WinNet_ConnectionDialog1($hWnd, $sRemoteName = "", $iFlags = 2)
	Local $pConnect, $tConnect, $pRemoteName, $tRemoteName, $pResource, $tResource, $iDialog, $aResult

	$tRemoteName = DllStructCreate("char Text[1024]")
	$pRemoteName = DllStructGetPtr($tRemoteName)
	DllStructSetData($tRemoteName, "Text", $sRemoteName)

	$tResource = DllStructCreate($tagNETRESOURCE)
	$pResource = DllStructGetPtr($tResource)
	DllStructSetData($tResource, "Type", $RESOURCETYPE_DISK)
	DllStructSetData($tResource, "RemoteName", $pRemoteName)

	If BitAND($iFlags, 1) <> 0 Then $iDialog = BitOR($iDialog, $CONNDLG_RO_PATH)
	If BitAND($iFlags, 2) <> 0 Then $iDialog = BitOR($iDialog, $CONNDLG_USE_MRU)
	If BitAND($iFlags, 4) <> 0 Then $iDialog = BitOR($iDialog, $CONNDLG_HIDE_BOX)
	If BitAND($iFlags, 8) <> 0 Then $iDialog = BitOR($iDialog, $CONNDLG_PERSIST)
	If BitAND($iFlags, 16) <> 0 Then $iDialog = BitOR($iDialog, $CONNDLG_NOT_PERSIST)

	$tConnect = DllStructCreate($tagCONNECTDLGSTRUCT)
	$pConnect = DllStructGetPtr($tConnect)
	DllStructSetData($tConnect, "Size", DllStructGetSize($tConnect))
	DllStructSetData($tConnect, "hWnd", $hWnd)
	DllStructSetData($tConnect, "Resource", $pResource)
	DllStructSetData($tConnect, "Flags", $iDialog)

	$aResult = DllCall("Mpr.dll", "dword", "WNetConnectionDialog1", "ptr", $pConnect)
	Return SetError($aResult[0], 0, DllStructGetData($tConnect, "DevNum"))
EndFunc   ;==>_WinNet_ConnectionDialog1

; #FUNCTION# ====================================================================================================================
; Name...........: _WinNet_DisconnectDialog
; Description ...: Starts a general browsing dialog box for disconnecting from network resources
; Syntax.........: _WinNet_DisconnectDialog($hWnd)
; Parameters ....: $hWnd        - Handle to the owner window for the dialog box
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _WinNet_DisconnectDialog1
; Link ..........; @@MsdnLink@@ WNetDisconnectDialog
; Example .......;
; ===============================================================================================================================
Func _WinNet_DisconnectDialog($hWnd)
	Local $aResult

	$aResult = DllCall("Mpr.dll", "dword", "WNetDisconnectDialog", "hwnd", $hWnd, "dword", $RESOURCETYPE_DISK)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_WinNet_DisconnectDialog

; #FUNCTION# ====================================================================================================================
; Name...........: _WinNet_DisconnectDialog1
; Description ...: Starts a general browsing dialog box for disconnecting from network resources
; Syntax.........: _WinNet_DisconnectDialog1($hWnd, $sLocalName[, $sRemoteName = ""[, $iFlags = 1]])
; Parameters ....: $hWnd        - Handle to the owner window for the dialog box
;                  $sLocalName  - Name of a local device, such as "F:" or "LPT1"
;                  $RemoteName  - Name of the network resource to disconnect.  This member can be 0 if $LocalName  is  specified.
;                  +When sLocalName is  specified,  the  connection  to  the  network  resource  redirected  from  sLocalName  is
;                  +disconnected.
;                  $iFlags      - Flags describing the connection. Can be a combination of:
;                  |1 - If this value is set, the specified connection is no longer a persistent one.  This flag is valid only if
;                  +sLocalName specifies a local device.
;                  |2 - If this value is NOT set, the system applies force when disconnecting
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _WinNet_DisconnectDialog
; Link ..........; @@MsdnLink@@ WNetDisconnectDialog1
; Example .......;
; ===============================================================================================================================
Func _WinNet_DisconnectDialog1($hWnd, $sLocalName, $sRemoteName = "", $iFlags = 1)
	Local $pLocalName, $tLocalName, $pRemoteName, $tRemoteName, $tDialog, $iOptions, $aResult

	$tLocalName = DllStructCreate("char Text[1024]")
	$pLocalName = DllStructGetPtr($tLocalName)
	DllStructSetData($tLocalName, "Text", $sLocalName)

	If $sRemoteName <> "" Then
		$tRemoteName = DllStructCreate("char Text[1024]")
		$pRemoteName = DllStructGetPtr($tRemoteName)
		DllStructSetData($tRemoteName, "Text", $sRemoteName)
	EndIf

	If BitAND($iFlags, 1) <> 0 Then $iOptions = BitOR($iOptions, $DISC_UPDATE_PROFILE)
	If BitAND($iFlags, 2) <> 0 Then $iOptions = BitOR($iOptions, $DISC_NO_FORCE)

	$tDialog = DllStructCreate($tagDISCDLGSTRUCT)
	DllStructSetData($tDialog, "Size", DllStructGetSize($tDialog))
	DllStructSetData($tDialog, "hWnd", $hWnd)
	DllStructSetData($tDialog, "LocalName", $pLocalName)
	DllStructSetData($tDialog, "RemoteName", $pRemoteName)
	DllStructSetData($tDialog, "Flags", $iOptions)

	$aResult = DllCall("Mpr.dll", "dword", "WNetDisconnectDialog1", "ptr", DllStructGetPtr($tDialog))
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_WinNet_DisconnectDialog1

; #FUNCTION# ====================================================================================================================
; Name...........: _WinNet_EnumResource
; Description ...: Continues an enumeration of network resources
; Syntax.........: _WinNet_EnumResource($hEnum, ByRef $iCount, $pBuffer, ByRef $iBufSize)
; Parameters ....: $hEnum       - Handle that identifies an enumeration instance.  The handle is returned by  the  _WinNet_OpenEnum
;                  +function.
;                  $iCount      - Number of entries requested.  If the number requested is  –1,  the  function  returns  as  many
;                  +entries as possible. If the function succeeds, on return the variable contains the number of entries actually
;                  +read
;                  $pBuffer     - Pointer to the buffer that receives the enumeration results.  The results are  returned  as  an
;                  +array of $tagNETRESOURCE structures.  The buffer must be large enough to hold the structures plus the  strings
;                  +to which their members point.  The buffer is valid until the next call using the handle specified  by  hEnum.
;                  +The order of $tagNETRESOURCE structures in the array is not predictable.
;                  $iBufSize    - The size of the buffer, in bytes.  If the buffer is too small to receive even one  entry,  this
;                  +parameter receives the required size of the buffer.
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _WinNet_OpenEnum, $tagNETRESOURCE
; Link ..........; @@MsdnLink@@ WNetEnumResourceA
; Example .......;
; ===============================================================================================================================
Func _WinNet_EnumResource($hEnum, ByRef $iCount, $pBuffer, ByRef $iBufSize)
	Local $tData, $pCount, $pBufSize, $aResult

	$tData = DllStructCreate("int Count; int BufSize")
	$pCount = DllStructGetPtr($tData, "Count")
	$pBufSize = DllStructGetPtr($tData, "BufSize")
	DllStructSetData($tData, "Count", $iCount)
	DllStructSetData($tData, "BufSize", $iBufSize)
	$aResult = DllCall("Mpr.dll", "dword", "WNetEnumResourceA", "hwnd", $hEnum, "ptr", $pCount, "ptr", $pBuffer, "ptr", $pBufSize)
	$iCount = DllStructGetData($tData, "Count")
	$iBufSize = DllStructGetData($tData, "BufSize")
	Return SetError($aResult[0], 0, $aResult = 0)
EndFunc   ;==>_WinNet_EnumResource

; #FUNCTION# ====================================================================================================================
; Name...........: _WinNet_GetConnection
; Description ...: Retrieves the name of the network resource associated with a local device
; Syntax.........: _WinNet_GetConnection($sLocalName)
; Parameters ....: $sLocalName  - The name of the local device to get the network name for
; Return values .: Success      - The remote name used to make the connection
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ WNetGetConnectionA
; Example .......;
; ===============================================================================================================================
Func _WinNet_GetConnection($sLocalName)
	Local $pBuffer, $tBuffer, $pBufSize, $tBufSize, $aResult

	$tBuffer = DllStructCreate("char Text[4096]")
	$pBuffer = DllStructGetPtr($tBuffer)
	$tBufSize = DllStructCreate("int BufSize")
	$pBufSize = DllStructGetPtr($tBufSize)
	DllStructSetData($tBufSize, "BufSize", 4096)

	$aResult = DllCall("Mpr.dll", "dword", "WNetGetConnectionA", "str", $sLocalName, "ptr", $pBuffer, "ptr", $pBufSize)
	Return SetError($aResult[0], 0, DllStructGetData($tBuffer, "Text"))
EndFunc   ;==>_WinNet_GetConnection

; #FUNCTION# ====================================================================================================================
; Name...........: _WinNet_GetConnectionPerformance
; Description ...: Returns information about the performance of a network connection resource
; Syntax.........: _WinNet_GetConnectionPerformance($sLocalName, $sRemoteName)
; Parameters ....: $sLocalName  - Name of a local device, such as "F:" or "LPT1", that is redirected to a network resource to  be
;                  +queried.  If blank, the network resource is specified in sRemoteName.  If this parameter  specifies  a  local
;                  +device sRemoteName is ignored.
;                  $sRemoteName - Name of the network resource  to  query.  The  resource  must  currently  have  an  established
;                  +connection.  For example, if the resource is a file on a file server, then having the file open  will  ensure
;                  +the connection.
; Return values .: Success      - Array with the following format:
;                  |$aInfo[0] - Connection description. Can be one of more of the following:
;                  | 1 - The information returned applies to the performance of the network card
;                  | 2 - The connection is not being routed
;                  | 4 - The connection is over a medium that is typically slow
;                  | 8 - Some of the information returned is calculated dynamically
;                  |$aInfo[1] - Speed of the media to the network resource, in 100 bps
;                  |$aInfo[2] - One-way delay time introduced when sending information
;                  |$aInfo[3] - Size of data that an application should use when making a single request to the resource
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ MultinetGetConnectionPerformanceA
; Example .......;
; ===============================================================================================================================
Func _WinNet_GetConnectionPerformance($sLocalName, $sRemoteName)
	Local $tLocalName, $tRemoteName, $pResource, $tResource, $tInfo, $aInfo[4], $aResult

	$tLocalName = DllStructCreate("char Text[4096]")
	DllStructSetData($tLocalName, "Text", $sLocalName)

	$tRemoteName = DllStructCreate("char Text[4096]")
	DllStructSetData($tRemoteName, "Text", $sRemoteName)

	$tResource = DllStructCreate($tagNETRESOURCE)
	$pResource = DllStructGetPtr($tResource)
	DllStructSetData($tResource, "LocalName", DllStructGetPtr($tLocalName))
	DllStructSetData($tResource, "RemoteName", DllStructGetPtr($tRemoteName))

	$tInfo = DllStructCreate($tagNETCONNECTINFOSTRUCT)
	DllStructSetData($tInfo, "Size", DllStructGetSize($tInfo))

	$aResult = DllCall("Mpr.dll", "dword", "MultinetGetConnectionPerformanceA", "ptr", $pResource, "ptr", DllStructGetPtr($tInfo))

	$aInfo[0] = DllStructGetData($tInfo, "Flags")
	$aInfo[1] = DllStructGetData($tInfo, "Speed")
	$aInfo[2] = DllStructGetData($tInfo, "Delay")
	$aInfo[3] = DllStructGetData($tInfo, "OptDataSize")
	Return SetError($aResult[0], 0, $aInfo)
EndFunc   ;==>_WinNet_GetConnectionPerformance

; #FUNCTION# ====================================================================================================================
; Name...........: _WinNet_GetLastError
; Description ...: Retrieves the most recent extended error
; Syntax.........: _WinNet_GetLastError(ByRef $iError, ByRef $sError, ByRef $sName)
; Parameters ....: $iError      - On return, contains the most recent extended error code
;                  $sError      - On return, contains the most recent extended error code message
;                  $sName       - On return, the network provider that raised the error
; Return values .: Success      - The most recent error message
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ WNetGetLastErrorA
; Example .......;
; ===============================================================================================================================
Func _WinNet_GetLastError(ByRef $iError, ByRef $sError, ByRef $sName)
	Local $pError, $tError, $pErrorBuf, $tErrorBuf, $pNameBuf, $tNameBuf, $aResult

	$tError = DllStructCreate("int Data")
	$pError = DllStructGetPtr($tError)
	$tErrorBuf = DllStructCreate("char Text[4096]")
	$pErrorBuf = DllStructGetPtr($tErrorBuf)
	$tNameBuf = DllStructCreate("char Text[4096]")
	$pNameBuf = DllStructGetPtr($tNameBuf)

	$aResult = DllCall("Mpr.dll", "dword", "WNetGetLastErrorA", "ptr", $pError, "ptr", $pErrorBuf, "int", 1024, "ptr", $pNameBuf, "int", 1024)

	$iError = DllStructGetData($tError, "Data")
	$sError = DllStructGetData($tErrorBuf, "Text")
	$sName = DllStructGetData($tNameBuf, "Text")
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_WinNet_GetLastError

; #FUNCTION# ====================================================================================================================
; Name...........: _WinNet_GetNetworkInformation
; Description ...: Returns extended information about a specific network provider
; Syntax.........: _WinNet_GetNetworkInformation($sName)
; Parameters ....: $sName       - The network provider for which information is required
; Return values .: Success      - Array with the following format:
;                  |$aInfo[0] - Version number of the network provider software
;                  |$aInfo[1] - Current status of the network provider software:
;                  | 0 - The network is running
;                  | 1 - The network is unavailable
;                  | 2 - The network is not currently able to service requests
;                  |$aInfo[2] - Instance handle for the network provider
;                  |$aInfo[3] - High word of the network type unique to the running network
;                  |$aInfo[4] - Set of bit flags indicating the valid print numbers for redirecting local printer  devices,  with
;                  +the low-order bit corresponding to LPT1.
;                  |$aInfo[5] - Set of bit flags indicating the valid local disk devices that can be used  for  redirecting  disk
;                  +drives, with the low-order bit corresponding to A:.
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ WNetGetNetworkInformationA
; Example .......;
; ===============================================================================================================================
Func _WinNet_GetNetworkInformation($sName)
	Local $pInfo, $tInfo, $aInfo[6], $aResult

	$tInfo = DllStructCreate($tagNETINFOSTRUCT)
	$pInfo = DllStructGetPtr($tInfo)
	DllStructSetData($tInfo, "Size", DllStructGetSize($tInfo))

	$aResult = DllCall("Mpr.dll", "dword", "WNetGetNetworkInformationA", "str", $sName, "ptr", $pInfo)

	$aInfo[0] = DllStructGetData($tInfo, "Version")
	$aInfo[1] = DllStructGetData($tInfo, "Status")
	$aInfo[2] = DllStructGetData($tInfo, "Handle")
	$aInfo[3] = DllStructGetData($tInfo, "NetType")
	$aInfo[4] = DllStructGetData($tInfo, "Printers")
	$aInfo[5] = DllStructGetData($tInfo, "Drives")
	Return SetError($aResult[0], 0, $aInfo)
EndFunc   ;==>_WinNet_GetNetworkInformation

; #FUNCTION# ====================================================================================================================
; Name...........: _WinNet_GetProviderName
; Description ...: Obtains the provider name for a specific type of network
; Syntax.........: _WinNet_GetProviderName($iType)
; Parameters ....: $iType       - Network type that is unique to the network
; Return values .: Success      - Network provider name
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ WNetGetProviderNameA
; Example .......;
; ===============================================================================================================================
Func _WinNet_GetProviderName($iType)
	Local $pBuffer, $tBuffer, $pSize, $tSize, $aResult

	$tBuffer = DllStructCreate("char Text[4096]")
	$pBuffer = DllStructGetPtr($tBuffer)
	$tSize = DllStructCreate("int Data")
	$pSize = DllStructGetPtr($tSize)
	DllStructSetData($tSize, "Data", 4096)

	$aResult = DllCall("Mpr.dll", "dword", "WNetGetProviderNameA", "dword", $iType, "ptr", $pBuffer, "ptr", $pSize)

	Return SetError($aResult[0], 0, DllStructGetData($tBuffer, "Text"))
EndFunc   ;==>_WinNet_GetProviderName

; #FUNCTION# ====================================================================================================================
; Name...........: _WinNet_GetResourceInformation
; Description ...: Identifies the network provider that owns the resource
; Syntax.........: _WinNet_GetResourceInformation($sRemoteName[, $sProvider = ""[, $iType = 0]])
; Parameters ....: $sRemoteName - The remote path name of the resource
;                  $sProvider   - The name of the provider that owns the resource.  This member can be blank if the provider name
;                  +is unknown.
;                  $iType       - Type of resource. This member can be 0 if it is not known.
; Return values .: Success      - Array with the following format:
;                  |$aResource[0] - Scope of enumeration:
;                  | 0 - Connected
;                  | 1 - All resources
;                  | 2 - Remembered
;                  |$aResource[1] - Type of resource:
;                  | 0 - Disk
;                  | 1 - Print
;                  | 2 - Unknown
;                  |$aResource[2] - Display option:
;                  | 0 - Generic
;                  | 1 - Domain
;                  | 2 - Server
;                  | 3 - Share
;                  | 4 - File
;                  | 5 - Group
;                  | 6 - Network
;                  | 7 - Root
;                  | 8 - Admin Share
;                  | 9 - Directory
;                  |10 - Tree
;                  |11 - NDS Container
;                  |$aResource[3] - Resource usage. Can be one or more of the following:
;                  | 1 - The resource is a connectable resource
;                  | 2 - The resource is a container resource
;                  | 4 - The resource is attached
;                  | 8 - Thre resource is reserved
;                  |$aResource[4] - Local name
;                  |$aResource[5] - Remote name
;                  |$aResource[6] - Comment supplied by the network provider
;                  |$aResource[7] - The name of the provider that owns the resource
;                  |$aResource[8] - The part of the resource that is accessed through system functions
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ WNetGetResourceInformationA
; Example .......;
; ===============================================================================================================================
Func _WinNet_GetResourceInformation($sRemoteName, $sProvider = "", $iType = 0)
	Local $iBuffer, $pBuffer, $tBuffer, $iRemote, $pRemote, $tRemote, $aResource, $pResource, $tResource
	Local $iProvider, $pProvider, $tProvider, $tData, $pBufSize, $pSystem, $tSystem, $aResult

	$tResource = DllStructCreate($tagNETRESOURCE)
	$pResource = DllStructGetPtr($tResource)

	$iRemote = StringLen($sRemoteName) + 1
	$tRemote = DllStructCreate("char Text[" & $iRemote & "]")
	$pRemote = DllStructGetPtr($tRemote)
	DllStructSetData($tRemote, "Text", $sRemoteName)

	If $sProvider <> "" Then
		$iProvider = StringLen($sProvider) + 1
		$tProvider = DllStructCreate("char Text[" & $iProvider & "]")
		$pProvider = DllStructGetPtr($tProvider)
		DllStructSetData($tProvider, "Text", $sProvider)
	EndIf

	$iBuffer = 16384
	$tBuffer = DllStructCreate("char Text[16384]")
	$pBuffer = DllStructGetPtr($tBuffer)

	$tData = DllStructCreate("int Size;int System")
	$pBufSize = DllStructGetPtr($tData, "Size")
	$pSystem = DllStructGetPtr($tData, "System")

	DllStructSetData($tResource, "RemoteName", $pRemote)
	DllStructSetData($tResource, "Type", $iType)
	DllStructSetData($tResource, "Provider", $pProvider)
	DllStructSetData($tData, "Text", $iBuffer)

	$aResult = DllCall("Mpr.dll", "dword", "WNetGetResourceInformationA", "ptr", $pResource, "ptr", $pBuffer, "ptr", $pBufSize, "ptr", $pSystem)

	$aResource = _WinNet_NETRESOURCEToArray($pBuffer)
	$pSystem = DllStructGetData($tData, "System")
	$tSystem = DllStructCreate("char Text[4096]", $pSystem)
	$aResource[8] = DllStructGetData($tSystem, "Size")
	Return SetError($aResult[0], 0, $aResource)
EndFunc   ;==>_WinNet_GetResourceInformation

; #FUNCTION# ====================================================================================================================
; Name...........: _WinNet_GetResourceParent
; Description ...: Returns the parent of a network resource in the network browse hierarchy
; Syntax.........: _WinNet_GetResourceParent($sRemoteName, $sProvider[, $iType = 0])
; Parameters ....: $sRemoteName - The remote path name of the resource
;                  $sProvider   - The name of the provider that owns the resource
;                  $iType       - Type of resource. This member can be 0 if it is not known.
; Return values .: Success      - Array with the following format:
;                  |$aResource[0] - Scope of enumeration:
;                  | 0 - Connected
;                  | 1 - All resources
;                  | 2 - Remembered
;                  |$aResource[1] - Type of resource:
;                  | 0 - Disk
;                  | 1 - Print
;                  | 2 - Unknown
;                  |$aResource[2] - Display option:
;                  | 0 - Generic
;                  | 1 - Domain
;                  | 2 - Server
;                  | 3 - Share
;                  | 4 - File
;                  | 5 - Group
;                  | 6 - Network
;                  | 7 - Root
;                  | 8 - Admin Share
;                  | 9 - Directory
;                  |10 - Tree
;                  |11 - NDS Container
;                  |$aResource[3] - Resource usage. Can be one or more of the following:
;                  | 1 - The resource is a connectable resource
;                  | 2 - The resource is a container resource
;                  | 4 - The resource is attached
;                  | 8 - Thre resource is reserved
;                  |$aResource[4] - Local name
;                  |$aResource[5] - Remote name
;                  |$aResource[6] - Comment supplied by the network provider
;                  |$aResource[7] - The name of the provider that owns the resource
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ WNetGetResourceParentA
; Example .......;
; ===============================================================================================================================
Func _WinNet_GetResourceParent($sRemoteName, $sProvider, $iType = 0)
	Local $iBuffer, $pBuffer, $tBuffer, $iRemote, $pRemote, $tRemote, $pResource, $tResource
	Local $iProvider, $pProvider, $tProvider, $tData, $pBufSize, $aResult

	$tResource = DllStructCreate($tagNETRESOURCE)
	$pResource = DllStructGetPtr($tResource)

	$iRemote = StringLen($sRemoteName) + 1
	$tRemote = DllStructCreate("char Text[" & $iRemote & "]")
	$pRemote = DllStructGetPtr($tRemote)
	DllStructSetData($tRemote, "Text", $sRemoteName)

	$iProvider = StringLen($sProvider) + 1
	$tProvider = DllStructCreate("char Text[" & $iProvider & "]")
	$pProvider = DllStructGetPtr($tProvider)
	DllStructSetData($tProvider, "Text", $sProvider)

	$iBuffer = 16384
	$tBuffer = DllStructCreate("byte[16384]")
	$pBuffer = DllStructGetPtr($tBuffer)

	$tData = DllStructCreate("int Size")
	$pBufSize = DllStructGetPtr($tData, "Size")

	DllStructSetData($tResource, "RemoteName", $pRemote)
	DllStructSetData($tResource, "Type", $iType)
	DllStructSetData($tResource, "Provider", $pProvider)
	DllStructSetData($tData, "Text", $iBuffer)

	$aResult = DllCall("Mpr.dll", "dword", "WNetGetResourceParentA", "ptr", $pResource, "ptr", $pBuffer, "ptr", $pBufSize)

	Return SetError($aResult[0], 0, _WinNet_NETRESOURCEToArray($pBuffer))
EndFunc   ;==>_WinNet_GetResourceParent

; #FUNCTION# ====================================================================================================================
; Name...........: _WinNet_GetUniversalName
; Description ...: Converts drived based path to universal form
; Syntax.........: _WinNet_GetUniversalName($sLocalPath)
; Parameters ....: $sLocalPath  - Drive based path for a network resource
; Return values .: Success      - Array with the following format:
;                  |$aPath[0] - UNC name string that identifies a network resource
;                  |$aPath[1] - Name of the network connection
;                  |$aPath[2] - Remaining path string
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ WNetGetUniversalNameA
; Example .......;
; ===============================================================================================================================
Func _WinNet_GetUniversalName($sLocalPath)
	Local $iLocal, $pLocal, $tLocal, $iBuffer, $pBuffer, $tBuffer, $tRemote, $pText, $tText
	Local $tData, $pBufSize, $aPath[3], $aResult


	$iLocal = StringLen($sLocalPath) + 1
	$tLocal = DllStructCreate("char Text[" & $iLocal & "]")
	$pLocal = DllStructGetPtr($tLocal)
	DllStructSetData($tLocal, "Text", $sLocalPath)

	$iBuffer = 16384
	$tBuffer = DllStructCreate("byte[16384]")
	$pBuffer = DllStructGetPtr($tBuffer)

	$tData = DllStructCreate("int Size")
	$pBufSize = DllStructGetPtr($tData, "Size")
	DllStructSetData($tData, "Size", $iBuffer)

	$aResult = DllCall("Mpr.dll", "dword", "WNetGetUniversalNameA", "ptr", $pLocal, "dword", 2, "ptr", $pBuffer, "ptr", $pBufSize)

	$tRemote = DllStructCreate($tagREMOTENAMEINFO, $pBuffer)
	$pText = DllStructGetData($tRemote, "Universal")
	$tText = DllStructCreate("char Text[4096]", $pText)
	$aPath[0] = DllStructGetData($tText, "Text")
	$pText = DllStructGetData($tRemote, "Connection")
	$tText = DllStructCreate("char Text[4096]", $pText)
	$aPath[1] = DllStructGetData($tText, "Text")
	$pText = DllStructGetData($tRemote, "Remaining")
	$tText = DllStructCreate("char Text[4096]", $pText)
	$aPath[2] = DllStructGetData($tText, "Text")

	Return SetError($aResult[0], 0, $aPath)
EndFunc   ;==>_WinNet_GetUniversalName

; #FUNCTION# ====================================================================================================================
; Name...........: _WinNet_GetUser
; Description ...: Retrieves the default user name, or the user name used to establish a connection
; Syntax.........: _WinNet_GetUser($sName)
; Parameters ....: $sName       - Either the name of a local device that has been redirected to a network resource, or the remote
;                  +name of a network resource to which a connection has been made without redirecting a local device.  If blank,
;                  +the system returns the name of the current user for the process.
; Return values .: Success      - User name
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ WNetGetUserA
; Example .......;
; ===============================================================================================================================
Func _WinNet_GetUser($sName)
	Local $iBuffer, $pBuffer, $tBuffer, $tData, $pBufSize, $aResult

	$iBuffer = 4096
	$tBuffer = DllStructCreate("char Text[4096]")
	$pBuffer = DllStructGetPtr($tBuffer)

	$tData = DllStructCreate("int Size")
	$pBufSize = DllStructGetPtr($tData, "Size")
	DllStructSetData($tData, "Size", $iBuffer)

	$aResult = DllCall("Mpr.dll", "dword", "WNetGetUserA", "str", $sName, "ptr", $pBuffer, "ptr", $pBufSize)

	Return SetError($aResult[0], 0, DllStructGetData($tBuffer, "Text"))
EndFunc   ;==>_WinNet_GetUser

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _WinNet_NETRESOURCEToArray
; Description ...: Returns an array from a $tagNETRESOURCE structure
; Syntax.........: _WinNet_NETRESOURCEToArray($pResource)
; Parameters ....: $pResource   - Pointer to a $tagNETRESOURCE structure
; Return values .: Success      - Array with the following format:
;                  |$aResource[0] - Scope of enumeration:
;                  | 0 - Connected
;                  | 1 - All resources
;                  | 2 - Remembered
;                  |$aResource[1] - Type of resource:
;                  | 0 - Disk
;                  | 1 - Print
;                  | 2 - Unknown
;                  |$aResource[2] - Display option:
;                  | 0 - Generic
;                  | 1 - Domain
;                  | 2 - Server
;                  | 3 - Share
;                  | 4 - File
;                  | 5 - Group
;                  | 6 - Network
;                  | 7 - Root
;                  | 8 - Admin Share
;                  | 9 - Directory
;                  |10 - Tree
;                  |11 - NDS Container
;                  |$aResource[3] - Resource usage. Can be one or more of the following:
;                  | 1 - The resource is a connectable resource
;                  | 2 - The resource is a container resource
;                  | 4 - The resource is attached
;                  | 8 - Thre resource is reserved
;                  |$aResource[4] - Local name
;                  |$aResource[5] - Remote name
;                  |$aResource[6] - Comment supplied by the network provider
;                  |$aResource[7] - The name of the provider that owns the resource
;                  |$aResource[8] - The part of the resource that is accessed through system functions
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......: This function is used internally and should not normally be called by the end user
; Related .......: $tagNETRESOURCE
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _WinNet_NETRESOURCEToArray($pResource)
	Local $iFlag, $iResult, $pText, $tText, $tResource, $aResource[9]

	$tResource = DllStructCreate($tagNETRESOURCE, $pResource)
	Switch DllStructGetData($tResource, "Scope")
		Case $RESOURCE_CONNECTED
			$aResource[0] = 0
		Case $RESOURCE_GLOBALNET
			$aResource[0] = 1
		Case $RESOURCE_REMEMBERED
			$aResource[0] = 2
		Case Else
			$aResource[0] = $iFlag
	EndSwitch
	$aResource[1] = DllStructGetData($tResource, "Type")
	$aResource[2] = DllStructGetData($tResource, "DisplayType")
	$iResult = 0
	$iFlag = DllStructGetData($tResource, "Usage")
	If BitAND($iFlag, $RESOURCEUSAGE_CONNECTABLE) <> 0 Then $iResult = BitOR($iResult, 1)
	If BitAND($iFlag, $RESOURCEUSAGE_CONTAINER) <> 0 Then $iResult = BitOR($iResult, 2)
	If BitAND($iFlag, $RESOURCEUSAGE_ATTACHED) <> 0 Then $iResult = BitOR($iResult, 4)
	If BitAND($iFlag, $RESOURCEUSAGE_RESERVED) <> 0 Then $iResult = BitOR($iResult, 8)
	$aResource[3] = $iResult
	$pText = DllStructGetData($tResource, "LocalName")
	If $pText <> 0 Then
		$tText = DllStructCreate("char Text[4096]", $pText)
		$aResource[4] = DllStructGetData($tText, "Text")
	EndIf
	$pText = DllStructGetData($tResource, "RemoteName")
	If $pText <> 0 Then
		$tText = DllStructCreate("char Text[4096]", $pText)
		$aResource[5] = DllStructGetData($tText, "Text")
	EndIf
	$pText = DllStructGetData($tResource, "Comment")
	If $pText <> 0 Then
		$tText = DllStructCreate("char Text[4096]", $pText)
		$aResource[6] = DllStructGetData($tText, "Text")
	EndIf
	$pText = DllStructGetData($tResource, "Provider")
	If $pText <> 0 Then
		$tText = DllStructCreate("char Text[4096]", $pText)
		$aResource[7] = DllStructGetData($tText, "Text")
	EndIf
	Return $aResource
EndFunc   ;==>_WinNet_NETRESOURCEToArray

; #FUNCTION# ====================================================================================================================
; Name...........: _WinNet_OpenEnum
; Description ...: Starts an enumeration of network resources or existing connections
; Syntax.........: _WinNet_OpenEnum($iScope, $iType, $iUsage, $pResource, ByRef $hEnum)
; Parameters ....: $iScope      - Scope of the enumeration:
;                  |0 - Enumerate all currently connected resources
;                  |1 - Enumerate all resources on the network
;                  |2 - Enumerate all remembered (persistent) connections
;                  |3 - Enumerate only resources in the network context of the caller
;                  $iType       - Resource types:
;                  |0 - All resources
;                  |1 - Disk resources
;                  |2 - Print resources
;                  $iUsage      - Resource usage types:
;                  |0 - All resources
;                  |1 - All connectable resources
;                  |2 - All container resources
;                  |4 - Forces the function to fail if the user is not authenticated
;                  $pResource   - Pointer to a $tagNETRESOURCE structure that specifies the container to enumerate.  If iScope  is
;                  +not 1, this must be 0. If 0, the root of the network is assumed.
;                  $hEnum       - On return, a handle that can be used in calls to WNet_EnumResource
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......: _WinNet_EnumResource, $tagNETRESOURCE
; Link ..........; @@MsdnLink@@ WNetOpenEnum
; Example .......;
; ===============================================================================================================================
Func _WinNet_OpenEnum($iScope, $iType, $iUsage, $pResource, ByRef $hEnum)
	Local $iFlags, $pEnum, $tEnum, $aResult

	Switch $iScope
		Case 1
			$iScope = $RESOURCE_GLOBALNET
		Case 2
			$iScope = $RESOURCE_REMEMBERED
		Case 3
			$iScope = $RESOURCE_CONTEXT
		Case Else
			$iScope = $RESOURCE_CONNECTED
	EndSwitch

	If BitAND($iUsage, 1) <> 0 Then $iFlags = BitOR($iFlags, $RESOURCEUSAGE_CONNECTABLE)
	If BitAND($iUsage, 2) <> 0 Then $iFlags = BitOR($iFlags, $RESOURCEUSAGE_CONTAINER)
	If BitAND($iUsage, 4) <> 0 Then $iFlags = BitOR($iFlags, $RESOURCEUSAGE_ATTACHED)

	$tEnum = DllStructCreate("int Enum")
	$pEnum = DllStructGetPtr($tEnum)

	$aResult = DllCall("Mpr.dll", "dword", "WNetOpenEnum", "dword", $iScope, "dword", $iType, "dword", $iFlags, "ptr", $pResource, "ptr", $pEnum)

	$hEnum = DllStructGetData($tEnum, "Enum")
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_WinNet_OpenEnum

; #FUNCTION# ====================================================================================================================
; Name...........: _WinNet_RestoreConnection
; Description ...: Restores the connection to a network resource
; Syntax.........: _WinNet_RestoreConnection([$sDevice = ""[, $hWnd = 0[, $fUseUI = True]]])
; Parameters ....: $sDevice     - The local name of the drive to connect to, such as "Z:".  If blank, the function reconnects all
;                  +persistent drives stored in the registry for the current user.
;                  $hWnd        - Handle to the parent window that the function uses to display the user interface  that  prompts
;                  +the user for a name and password when making the network connection. If 0, there is no owner window.
;                  $fUseUI      - If True, display a username/password prompt to the caller
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ WNetRestoreConnectionW
; Example .......;
; ===============================================================================================================================
Func _WinNet_RestoreConnection($sDevice = "", $hWnd = 0, $fUseUI = True)
	Local $pDevice, $tDevice, $aResult

	If $sDevice <> "" Then
		$tDevice = _WinAPI_MultiByteToWideChar($sDevice)
		$pDevice = DllStructGetPtr($tDevice)
	EndIf

	$aResult = DllCall("Mpr.dll", "dword", "WNetRestoreConnectionW", "hwnd", $hWnd, "ptr", $pDevice, "int", $fUseUI)

	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_WinNet_RestoreConnection

; #FUNCTION# ====================================================================================================================
; Name...........: _WinNet_UseConnection
; Description ...: Connects a local device to a network resource
; Syntax.........: _WinNet_UseConnection($hWnd, $sLocalName, $sRemoteName[, $sUserName = 0[, $sPassword = 0[, $iType = 1[, $iOptions = 1]]]])
; Parameters ....: $hWnd        - Handle to a window that the provider of network resources  can  use  as  an  owner  window  for
;                  +dialogs. Use this parameter if you set bit 2 (interactive) in the Options parameter. This parameter can be 0.
;                  $sLocalName  - Name of a local device to be redirected, such as "F:" or "LPT1".  The string is  treated  in  a
;                  +case-insensitive manner.  If 0, a connection to the network resource is made without  redirecting  the  local
;                  +device.
;                  $sRemoteName - Name of the network resource to connect to
;                  $sUsername   - User name for making the connection.  If 0, the  function uses the default user name.
;                  $sPassword   - Password to be used to make a connection. If 0, the default password is used.  If the string is
;                  +empty, no password is used.
;                  $iType       - Specifies the type of network resource to connect to:
;                  |0 - Any (only if $sLocalName is blank)
;                  |1 - Disk
;                  |2 - Print
;                  $iOptions    - Connection options. Can be one or more of the following:
;                  | 1 - The network resource connection should be remembered
;                  | 2 - The operating system may interact with the user for authentication purposes
;                  | 4 - The system does not use any default setting for user names or passwords without offering  the  user  the
;                  +opportunity to supply an alternative.  This flag is ignored unless bit 2 (interactive) is also set.
;                  | 8 - Forces the redirection of a local device when making the connection
;                  |16 - The operating system prompts the user for authentication using the command line instead of a  GUI.  This
;                  +flag is ignored unless bit 2 (interactive) is also set.
;                  |32 - If this bit is set, and the operating system prompts for a credential, the credential is  saved  by  the
;                  +credential manager.  If the credential manager is disabled for the caller's logon session, or if the  network
;                  +provider does not support saving credentials, this flag is ignored.  This flag is also ignored unless you set
;                  +bit 5 (command line instead of GUI).
; Return values .: Success      - Array with the following format:
;                  |$aInfo[0] - If True, the connection was made using a local device redirection
;                  |$aInfo[1] - If sLocalName specifies a local device, this is the local device name.  If  sLocalName  does  not
;                  +specify a device and the network requires a local device redirection, or if bit 4 (force redirection) is set,
;                  +this buffer receives the name of the redirected local device.  Otherwise, the name copied into the buffer  is
;                  +that of a remote resource.
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ WNetUseConnectionA
; Example .......;
; ===============================================================================================================================
Func _WinNet_UseConnection($hWnd, $sLocalName, $sRemoteName, $sUserName = 0, $sPassword = 0, $iType = 1, $iOptions = 1)
	Local $iLocalName, $pLocalName, $tLocalName, $iRemoteName, $pRemoteName, $tRemoteName, $iFlags
	Local $iUserName, $pUserName, $tUserName, $iPassword, $pPassWord, $tPassword, $aInfo[2]
	Local $pResource, $tResource, $pAccess, $tAccess, $tData, $pBufSize, $aResult, $pResult

	$iLocalName = StringLen($sLocalName) + 1
	$tLocalName = DllStructCreate("char Text[" & $iLocalName & "]")
	$pLocalName = DllStructGetPtr($tLocalName)

	$iRemoteName = StringLen($sRemoteName) + 1
	$tRemoteName = DllStructCreate("char Text[" & $iRemoteName & "]")
	$pRemoteName = DllStructGetPtr($tRemoteName)

	$tAccess = DllStructCreate("char Text[4096]")
	$pAccess = DllStructGetPtr($tAccess)

	$tData = DllStructCreate("int Size;int Result")
	$pBufSize = DllStructGetPtr($tData, "Size")
	$pResult = DllStructGetPtr($tData, "Result")

	$tResource = DllStructCreate($tagNETRESOURCE)
	$pResource = DllStructGetPtr($tResource)

	If IsString($sUserName) Then
		$iUserName = StringLen($sUserName) + 1
		$tUserName = DllStructCreate("char Text[" & $iUserName & "]")
		$pUserName = DllStructGetPtr($tUserName)
		DllStructSetData($tUserName, "Text", $sUserName)
	EndIf

	If IsString($sPassword) Then
		$iPassword = StringLen($sPassword) + 1
		$tPassword = DllStructCreate("char Text[" & $iPassword & "]")
		$pPassWord = DllStructGetPtr($tPassword)
		DllStructSetData($tPassword, "Text", $sPassword)
	EndIf

	If BitAND($iOptions, 1) <> 0 Then $iFlags = BitOR($iFlags, $CONNECT_UPDATE_PROFILE)
	If BitAND($iOptions, 2) <> 0 Then $iFlags = BitOR($iFlags, $CONNECT_INTERACTIVE)
	If BitAND($iOptions, 4) <> 0 Then $iFlags = BitOR($iFlags, $CONNECT_PROMPT)
	If BitAND($iOptions, 8) <> 0 Then $iFlags = BitOR($iFlags, $CONNECT_REDIRECT)
	If BitAND($iOptions, 16) <> 0 Then $iFlags = BitOR($iFlags, $CONNECT_COMMANDLINE)
	If BitAND($iOptions, 32) <> 0 Then $iFlags = BitOR($iFlags, $CONNECT_CMD_SAVECRED)

	DllStructSetData($tData, "Size", 4096)
	DllStructSetData($tLocalName, "Text", $sLocalName)
	DllStructSetData($tRemoteName, "Text", $sRemoteName)
	DllStructSetData($tResource, "Type", $iType)
	DllStructSetData($tResource, "LocalName", $pLocalName)
	DllStructSetData($tResource, "RemoteName", $pRemoteName)

	$aResult = DllCall("Mpr.dll", "dword", "WNetUseConnectionA", "hwnd", $hWnd, "ptr", $pResource, "ptr", $pPassWord, "ptr", $pUserName, _
			"dword", $iFlags, "ptr", $pAccess, "ptr", $pBufSize, "ptr", $pResult)

	$aInfo[0] = BitAND(DllStructGetData($tData, "Size"), $CONNECT_LOCALDRIVE) <> 0
	$aInfo[1] = DllStructGetData($tAccess, "Text")
	Return SetError($aResult[0], 0, $aInfo)
EndFunc   ;==>_WinNet_UseConnection