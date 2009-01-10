#include-once

; ------------------------------------------------------------------------------
;
; AutoIt Version: 3.2
; Description:    Security Constants.
; Author ........: Paul Campbell (PaulIA)
; ------------------------------------------------------------------------------

; #CONSTANTS# ===================================================================================================================
Global Const $ERROR_NO_TOKEN = 1008

Global Const $SE_ASSIGNPRIMARYTOKEN_NAME = "SeAssignPrimaryTokenPrivilege"
Global Const $SE_AUDIT_NAME = "SeAuditPrivilege"
Global Const $SE_BACKUP_NAME = "SeBackupPrivilege"
Global Const $SE_CHANGE_NOTIFY_NAME = "SeChangeNotifyPrivilege"
Global Const $SE_CREATE_GLOBAL_NAME = "SeCreateGlobalPrivilege"
Global Const $SE_CREATE_PAGEFILE_NAME = "SeCreatePagefilePrivilege"
Global Const $SE_CREATE_PERMANENT_NAME = "SeCreatePermanentPrivilege"
Global Const $SE_CREATE_TOKEN_NAME = "SeCreateTokenPrivilege"
Global Const $SE_DEBUG_NAME = "SeDebugPrivilege"
Global Const $SE_ENABLE_DELEGATION_NAME = "SeEnableDelegationPrivilege"
Global Const $SE_IMPERSONATE_NAME = "SeImpersonatePrivilege"
Global Const $SE_INC_BASE_PRIORITY_NAME = "SeIncreaseBasePriorityPrivilege"
Global Const $SE_INCREASE_QUOTA_NAME = "SeIncreaseQuotaPrivilege"
Global Const $SE_LOAD_DRIVER_NAME = "SeLoadDriverPrivilege"
Global Const $SE_LOCK_MEMORY_NAME = "SeLockMemoryPrivilege"
Global Const $SE_MACHINE_ACCOUNT_NAME = "SeMachineAccountPrivilege"
Global Const $SE_MANAGE_VOLUME_NAME = "SeManageVolumePrivilege"
Global Const $SE_PROF_SINGLE_PROCESS_NAME = "SeProfileSingleProcessPrivilege"
Global Const $SE_REMOTE_SHUTDOWN_NAME = "SeRemoteShutdownPrivilege"
Global Const $SE_RESTORE_NAME = "SeRestorePrivilege"
Global Const $SE_SECURITY_NAME = "SeSecurityPrivilege"
Global Const $SE_SHUTDOWN_NAME = "SeShutdownPrivilege"
Global Const $SE_SYNC_AGENT_NAME = "SeSyncAgentPrivilege"
Global Const $SE_SYSTEM_ENVIRONMENT_NAME = "SeSystemEnvironmentPrivilege"
Global Const $SE_SYSTEM_PROFILE_NAME = "SeSystemProfilePrivilege"
Global Const $SE_SYSTEMTIME_NAME = "SeSystemtimePrivilege"
Global Const $SE_TAKE_OWNERSHIP_NAME = "SeTakeOwnershipPrivilege"
Global Const $SE_TCB_NAME = "SeTcbPrivilege"
Global Const $SE_UNSOLICITED_INPUT_NAME = "SeUnsolicitedInputPrivilege"
Global Const $SE_UNDOCK_NAME = "SeUndockPrivilege"

Global Const $SE_PRIVILEGE_ENABLED_BY_DEFAULT = 0x00000001
Global Const $SE_PRIVILEGE_ENABLED = 0x00000002
Global Const $SE_PRIVILEGE_REMOVED = 0x00000004
Global Const $SE_PRIVILEGE_USED_FOR_ACCESS = 0x80000000

Global Const $TOKENUSER = 1
Global Const $TOKENGROUPS = 2
Global Const $TOKENPRIVILEGES = 3
Global Const $TOKENOWNER = 4
Global Const $TOKENPRIMARYGROUP = 5
Global Const $TOKENDEFAULTDACL = 6
Global Const $TOKENSOURCE = 7
Global Const $TOKENTYPE = 8
Global Const $TOKENIMPERSONATIONLEVEL = 9
Global Const $TOKENSTATISTICS = 10
Global Const $TOKENRESTRICTEDSIDS = 11
Global Const $TOKENSESSIONID = 12
Global Const $TOKENGROUPSANDPRIVILEGES = 13
Global Const $TOKENSESSIONREFERENCE = 14
Global Const $TOKENSANDBOXINERT = 15
Global Const $TOKENAUDITPOLICY = 16
Global Const $TOKENORIGIN = 17
Global Const $TOKENELEVATIONTYPE = 18
Global Const $TOKENLINKEDTOKEN = 19
Global Const $TOKENELEVATION = 20
Global Const $TOKENHASRESTRICTIONS = 21
Global Const $TOKENACCESSINFORMATION = 22
Global Const $TOKENVIRTUALIZATIONALLOWED = 23
Global Const $TOKENVIRTUALIZATIONENABLED = 24
Global Const $TOKENINTEGRITYLEVEL = 25
Global Const $TOKENUIACCESS = 26
Global Const $TOKENMANDATORYPOLICY = 27
Global Const $TOKENLOGONSID = 28