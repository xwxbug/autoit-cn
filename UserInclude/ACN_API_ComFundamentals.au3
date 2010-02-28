#include-once
Global Const $S_OK =0
Global Const $S_FALSE =1
Global Const $SELFREG_E_TYPELIB = -2147220992
Global Const $SELFREG_E_CLASS = -2147220991
Global Const $SELFREG_E_FALSE = -2147221008
; #FUNCTION# ====================================================================================================================
; Name...........: _API_CoInitialize
; Description ...: Initializes the COM library on the current thread and identifies the concurrency model as single-thread apartment (STA).
; Syntax.........: _API_CoInitialize()
; Parameters ....: 
; Return values .: This function can return the standard return values E_OUTOFMEMORY and E_UNEXPECTED, as well as the following values.
;                  Const $S_OK =0		The registry entries were created successfully.
;                  Const $SELFREG_E_TYPELIB = -2147220992	The server was unable to complete the registration of all the type libraries used by its classes.
;                  RPC_E_CHANGED_MODE	A previous call to CoInitializeEx specified the concurrency model for this thread as multithread apartment (MTA). This could also indicate that a change from neutral-threaded apartment to single-threaded apartment has occurred.
;                  -1					特殊,无法加载DLL,也许并不是DLL文件.
; Author ........: thesnoW(rundll32@126.com)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; http://msdn.microsoft.com/en-us/library/ms678543(VS.85).aspx
; Example .......; Yes
; ===============================================================================================================================
Func _API_CoInitialize()
	Local $dll=DllOpen("Ole32.dll")
	If $dll = -1 Then Return -1
	Local $ret=DllCall($dll,"int","CoInitialize","ptr","")
	DllClose($dll)
	Return $ret[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _API_DllRegisterServer
; Description ...: 注册DLL文件
; Syntax.........: _API_DllRegisterServer($file)
; Parameters ....: $File:		  - DLL文件名
; Return values .: This function can return the standard return values E_OUTOFMEMORY and E_UNEXPECTED, as well as the following values.
;                  Const $S_OK =0		The registry entries were created successfully.
;                  Const $SELFREG_E_TYPELIB = -2147220992	The server was unable to complete the registration of all the type libraries used by its classes.
;                  Const $SELFREG_E_CLASS = -2147220991		The server was unable to complete the registration of all the object classes. 
;                  Const $SELFREG_E_FALSE = -2147221008		CoInitialize has not been called
;                  -1					特殊,无法加载DLL,也许并不是DLL文件.
; Author ........: thesnoW(rundll32@126.com)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; http://msdn.microsoft.com/en-us/library/ms682162(VS.85).aspx
; Example .......; Yes
; ===============================================================================================================================
Func _API_DllRegisterServer($file)
	Local $dll=DllOpen($file)
	If $dll = -1 Then Return -1
	Local $ret=DllCall($dll,"int","DllRegisterServer")
	DllClose($dll)
	Return $ret[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _API_DllUnregisterServer
; Description ...: 卸载DLL文件
; Syntax.........: _API_DllUnregisterServer($file)
; Parameters ....: $File:		  - DLL文件名
; Return values .: This function can return the standard return values E_OUTOFMEMORY and E_UNEXPECTED, as well as the following values.
;                  Const $S_OK =0		The registry entries were deleted successfully.
;                  Const $S_FALSE =1	Unregistration of this server's known entries was successful, but other entries still exist for this server's classes.
;                  Const $SELFREG_E_TYPELIB = -2147220992	The server was unable to remove the entries of all the type libraries used by its classes.
;                  Const $SELFREG_E_CLASS = -2147220991		The server was unable to remove the entries of all the object classes.
;                  Const $SELFREG_E_FALSE = -2147221008		CoInitialize has not been called
;                  -1					特殊,无法加载DLL,也许并不是DLL文件.
; Author ........: thesnoW(rundll32@126.com)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; http://msdn.microsoft.com/en-us/library/ms691457(VS.85).aspx
; Example .......; Yes
; ===============================================================================================================================
Func _API_DllUnregisterServer($file)
	Local $dll=DllOpen($file)
	If $dll = -1 Then Return -1
	Local $ret=DllCall($dll,"int","DllUnregisterServer")
	DllClose($dll)
	Return $ret[0]
EndFunc