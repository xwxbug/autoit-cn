#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <WindowsConstants.au3>
#include <Crypt.au3>
#include <WinAPI.au3>

; Example of realtime RC4 encryption

$hWnd=GUICreate("Realtime Encrypting",400,300,-1)
$hInputEdit=GUICtrlCreateEdit("",0,0,400,150,$ES_WANTRETURN)
$hOutputEdit=GUICtrlCreateEdit("",0,150,400,150,$ES_READONLY)
GUIRegisterMsg($WM_COMMAND,"WM_COMMAND")
GUISetState(@SW_SHOW)

; To optimize perfomance we start the library and create a key
_Crypt_Startup()
$hKey=_Crypt_DeriveKey("SomePassword",$CALG_RC4)

Do
	$msg=GUIGetMsg()
Until $msg=$GUI_EVENT_close

_Crypt_DestroyKey($hKey)
_Crypt_Shutdown()

Func WM_COMMAND($hWinHandle,$iMsg,$wParam,$lParam)
	; If something was changed in the input editbox
	If _WinAPI_HiWord($wParam)=$EN_CHANGE And _WINAPI_LoWord($wParam)=$hInputEdit Then
		$bEncrypted=_Crypt_EncryptData(GUICtrlRead($hInputEdit),$hKey,$CALG_USERKEY)
		GUICtrlSetData($hOutputEdit,$bEncrypted)
	EndIf
EndFunc
