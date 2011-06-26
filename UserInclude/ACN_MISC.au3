#include-once
; _EnumScreenRes() 函数需要
#include <array.au3>
;======================================================
;
; 函数名称:		_Refreshicon
; 详细信息:		刷新关联图标.
; 返回值 :		无论是否成功均返回1
; 作者:			三狠居士,MOD by thesnow(rundll32@126.com)
;
;======================================================
Func _Refreshicon()
	FileWriteLine(@TempDir & "\Refreshicon.inf","[version]" & @CRLF & "signature=$chicago$")
	RunWait ('Rundll32.exe setupapi,InstallHinfSection DefaultInstall 132 '& @TempDir & "\Refreshicon.inf",@TempDir,@SW_HIDE)
	FileDelete (@TempDir & "\Refreshicon.inf")
	Return 1
EndFunc ;=>刷新系统图标

;======================================================
;
; 函数名称:		_RefreshIconMSG
; 详细信息:		刷新关联图标.
; 返回值 :		无论是否成功均返回1
; 作者:			thesnow(rundll32@126.com)
;
;======================================================
Func _RefreshIconMSG()
	DllCall("shell32.dll", "none", "SHChangeNotify", _
			"long", 0x8000000, _
			"uint", BitOR(0x0, 0x1000), _
			"ptr", 0, _
			"ptr", 0 _
			)
	Return 1
EndFunc ;=>刷新系统图标

;===============================================================================
;
; 函数名称:		_ChangeScreenRes()
; 详细信息:		修改 屏幕分辨率,刷新率.
; 版本:			1.0.0.1
; 参数:     	$i_Width - 屏幕宽度(如1024X768 中的 1024)
; 				$i_Height - 屏幕高度(如1024X768 中的 768)
; 				$i_BitsPP -桌面颜色深度(如 32BIT,32位)
; 				$i_RefreshRate - 屏幕刷新率(如 75 MHZ).
; 需求     		AutoIt 测试版 > 3.1 以上
; 返回值:		成功,屏幕更新,@ERROR = 0
; 				失败,屏幕不更新, @ERROR = 1
; 论坛:			http://www.autoitscript.com/forum/index.php?showtopic=20121
; 作者:			Original code - psandu.ro
;               Modifications - PartyPooper
; 翻译:			thesnow
;
;===============================================================================
Func _ChangeScreenRes($i_Width = @DesktopWidth, $i_Height = @DesktopHeight, $i_BitsPP = @DesktopDepth, $i_RefreshRate = @DesktopRefresh)
	Local Const $DM_PELSWIDTH = 0x00080000
	Local Const $DM_PELSHEIGHT = 0x00100000
	Local Const $DM_BITSPERPEL = 0x00040000
	Local Const $DM_DISPLAYFREQUENCY = 0x00400000
	Local Const $CDS_TEST = 0x00000002
	Local Const $CDS_UPDATEREGISTRY = 0x00000001
	Local Const $DISP_CHANGE_RESTART = 1
	Local Const $DISP_CHANGE_SUCCESSFUL = 0
	Local Const $HWND_BROADCAST = 0xffff
	Local Const $WM_DISPLAYCHANGE = 0x007E
	If $i_Width = "" Or $i_Width = -1 Then $i_Width = @DesktopWidth ; default to current setting
	If $i_Height = "" Or $i_Height = -1 Then $i_Height = @DesktopHeight ; default to current setting
	If $i_BitsPP = "" Or $i_BitsPP = -1 Then $i_BitsPP = @DesktopDepth ; default to current setting
	If $i_RefreshRate = "" Or $i_RefreshRate = -1 Then $i_RefreshRate = @DesktopRefresh ; default to current setting
	Local $DEVMODE = DllStructCreate("byte[32];int[10];byte[32];int[6]")
	Local $B = DllCall("user32.dll", "int", "EnumDisplaySettings", "ptr", 0, "long", 0, "ptr", DllStructGetPtr($DEVMODE))
	If @error Then
		$B = 0
		SetError(1)
		Return $B
	Else
		$B = $B[0]
	EndIf
	If $B <> 0 Then
		DllStructSetData($DEVMODE, 2, BitOR($DM_PELSWIDTH, $DM_PELSHEIGHT, $DM_BITSPERPEL, $DM_DISPLAYFREQUENCY), 5)
		DllStructSetData($DEVMODE, 4, $i_Width, 2)
		DllStructSetData($DEVMODE, 4, $i_Height, 3)
		DllStructSetData($DEVMODE, 4, $i_BitsPP, 1)
		DllStructSetData($DEVMODE, 4, $i_RefreshRate, 5)
		$B = DllCall("user32.dll", "int", "ChangeDisplaySettings", "ptr", DllStructGetPtr($DEVMODE), "int", $CDS_TEST)
		If @error Then
			$B = -1
		Else
			$B = $B[0]
		EndIf
		Select
			Case $B = $DISP_CHANGE_RESTART
				$DEVMODE = ""
				Return 2
			Case $B = $DISP_CHANGE_SUCCESSFUL
				DllCall("user32.dll", "int", "ChangeDisplaySettings", "ptr", DllStructGetPtr($DEVMODE), "int", $CDS_UPDATEREGISTRY)
				DllCall("user32.dll", "int", "SendMessage", "hwnd", $HWND_BROADCAST, "int", $WM_DISPLAYCHANGE, _
				"int", $i_BitsPP, "int", $i_Height * 2 ^ 16 + $i_Width)
				$DEVMODE = ""
				Return 1
			Case Else
				$DEVMODE = ""
				SetError(1)
				Return $B
		EndSelect
	EndIf
EndFunc ;==>_ChangeScreenRes

;===============================================================================
;
; 函数名称:		_EnumScreenRes()
; 详细信息:		枚举本机支持的屏幕分辨率刷新率.
; 版本:			1.0.0.1
; 参数:     	
; 需求     		AutoIt 测试版 > 3.3.5.0 以上
; 返回值:		返回一个数组,数组元素0为返回的元素数量.
; 论坛:			
; 作者:			thesnoW
;
;===============================================================================
Func _EnumScreenRes()
	Local $aRet[1]
	Local $iModeNum=0
	While 1
		Local $DEVMODE = DllStructCreate("byte[32];int[10];byte[32];int[6]")
		Local $B = DllCall("user32.dll", "int", "EnumDisplaySettings", "ptr", 0, "long", $iModeNum, "ptr", DllStructGetPtr($DEVMODE))
		If @error Then
			$B = 0
			ExitLoop
		EndIf
		If $B[0] <> 0 Then
			_ArrayAdd($aRet,DllStructGetData($DEVMODE,4,2) & "X" &DllStructGetData($DEVMODE,4,3) & "X" &DllStructGetData($DEVMODE,4,1) & "@"&DllStructGetData($DEVMODE,4,5))
		Else
			ExitLoop
		EndIf
		$iModeNum+=1
	WEnd
	$aRet[0]=UBound($aRet)-1
	Return $aRet
EndFunc

#include-once

; #FUNCTION# ====================================================================================================================
;
; Name...........:        _SetDriverSigning
; Description ...:        Sets driver signing policy on Microsoft Windows operating systems
; Syntax.........:        _SetDriverSigning([$iLM, $iCU, $sComputer])
; Parameters ....:        $iLM - [Optional] Set at the machine level
;                           0 - Ignore
;                           1 - Warn
;                           2 - Block
;                           3 - Ignore only for current user
;                           Default is Ignore
;                   $iCU - [Optional] Set at the user level
;                           0 - $iLM setting takes precedence
;                           1 - Warn only for current user if greater than $iLM setting
;                           2 - Block only for current user if greater than $iLM setting
;                                        $sComputer - [Optional] Computer name
;                                                                The local computer is default
; Return values .:        Success - Returns 1
;                                        Failure - Returns 0 and sets @error to:
;                           -1 - Failure to read the registry
;                           -2 - Failure to compute the cryptographic hash
;                           -3 - Failure to write to the registry
; Author ........:        engine
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
;
; ===============================================================================================================================

Func _SetDriverSigning($iLM = 0, $iCU = 0, $sComputer = @ComputerName)
        Local Const $PROV_RSA_FULL = 0x00000001
        Local Const $CRYPT_VERIFYCONTEXT = 0xf0000000
        Local Const $ALG_CLASS_HASH = 0x00008000
        Local Const $ALG_TYPE_ANY = 0x00000000
        Local Const $ALG_SID_MD5 = 0x00000003
        Local Const $CALG_MD5 = BitOR($ALG_CLASS_HASH, $ALG_TYPE_ANY, $ALG_SID_MD5)
        Local Const $HP_HASHVAL = 0x00000002
        
        Local $iSeed = RegRead("\\" & $sComputer & "\HKLM\SYSTEM\WPA\PnP", "seed")
        If @error Then Return SetError(-1, 0, 0)
        
        Local $hAdvapi32 = DllOpen("Advapi32.dll")
        
        ; Acquire the CSP
        Local $avProv = DllCall( $hAdvapi32, "int", "CryptAcquireContext", _
                "hwnd*", 0, _
                "ptr", 0, _
                "ptr", 0, _
                "dword", $PROV_RSA_FULL, _
                "dword", $CRYPT_VERIFYCONTEXT )
        
        ; Create a hash object
        Local $avHash = DllCall( $hAdvapi32, "int", "CryptCreateHash", _
                "hwnd", $avProv[1], _
                "dword", $CALG_MD5, _
                "hwnd", 0, _
                "dword", 0, _
                "hwnd*", 0 )
        
        ; Compute the cryptographic hash on the data
        Local $tIMPUT = DllStructCreate("char[4]")
        DllStructSetData($tIMPUT, 1, $iLM, 2)
        DllCall( $hAdvapi32, "int", "CryptHashData", _
                "hwnd", $avHash[5], _
                "ptr", DllStructGetPtr($tIMPUT), _
                "dword", DllStructGetSize($tIMPUT), _
                "dword", 0 )
        DllCall( $hAdvapi32, "int", "CryptHashData", _
                "hwnd", $avHash[5], _
                "dword*", $iSEED, _
                "dword", 4, _
                "dword", 0 )
        Local $tDATA = DllStructCreate("byte[16]")
        DllCall( $hAdvapi32, "int", "CryptGetHashParam", _
                "hwnd", $avHash[5], _
                "dword", $HP_HASHVAL, _
                "ptr", DllStructGetPtr($tDATA), _
                "dword*", DllStructGetSize($tDATA), _
                "dword", 0 )
        
        ; Destroy the hash object
        DllCall( $hAdvapi32, "int", "CryptDestroyHash", _
                "hwnd", $avHash[5] )
        
        ; Release the CSP
        DllCall( $hAdvapi32, "int", "CryptReleaseContext", _
                "hwnd", $avProv[1], _
                "dword", 0 )
        
        DllClose($hAdvapi32)
        
        ; Get last error
        Local $aiGLE = DllCall("Kernel32.dll", "dword", "GetLastError")
        If $aiGLE[0] <> 0 Then Return SetError(-2, 0, 0)
        
        If Not RegWrite( "\\" & $sComputer & "\HKLM\Software\Microsoft\Windows\CurrentVersion\Setup", "PrivateHash", "REG_BINARY", DllStructGetData($tDATA, 1) ) _
        Or Not RegWrite( "\\" & $sComputer & "\HKLM\SOFTWARE\Microsoft\Driver Signing", "Policy", "REG_BINARY", Binary($iLM) ) _
        Or Not RegWrite("\\" & $sComputer & "\HKCU\Software\Policies\Microsoft\Windows NT\Driver Signing", "BehaviorOnFailedVerify", "REG_DWORD", $iCU) _
        Then Return SetError(-3, 0, 0)
        Return 1
EndFunc ;==> _SetDriverSigning