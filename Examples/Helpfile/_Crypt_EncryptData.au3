#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <WindowsConstants.au3>
#include <Crypt.au3>
#include <WinAPI.au3>

; 实时 RC4 加密示例

GUICreate("Realtime Encrypting", 400, 300, -1)
Global $hInputEdit = GUICtrlCreateEdit("", 0, 0, 400, 150, $ES_WANTRETURN)
Global $hOutputEdit = GUICtrlCreateEdit("", 0, 150, 400, 150, $ES_READONLY)
GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")
GUISetState(@SW_SHOW)

; 为了改善性能我们初始化库并创建密匙
_Crypt_Startup()
Local $hKey = _Crypt_DeriveKey("SomePassword", $CALG_RC4)

Do
	Local $msg = GUIGetMsg()
Until $msg = $GUI_EVENT_close

_Crypt_DestroyKey($hKey)
_Crypt_Shutdown()

Func WM_COMMAND($hWinHandle, $iMsg, $wParam, $lParam)
	#forceref $hWinHandle, $iMsg, $lParam
	; 当输入编辑框中数据变化时
	If _WinAPI_HiWord($wParam) = $EN_CHANGE And _WinAPI_LoWord($wParam) = $hInputEdit Then
		Local $bEncrypted = _Crypt_EncryptData(GUICtrlRead($hInputEdit), $hKey, $CALG_USERKEY)
		GUICtrlSetData($hOutputEdit, $bEncrypted)
	EndIf
EndFunc   ;==>WM_COMMAND
