#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <Crypt.au3>

; 散列化文件示例

; 创建 GUI
GUICreate("Hasher", 370, 60)
Local $hFileControl = GUICtrlCreateInput("", 5, 5, 200, 20)
Local $hBrowseButton = GUICtrlCreateButton("...", 210, 5, 35, 20)
Local $hHashCombo = GUICtrlCreateCombo("MD5", 250, 5, 50, 20)
GUICtrlSetData(-1, "MD2|MD4|SHA1")
Local $hCalcButton = GUICtrlCreateButton("Calculate", 305, 5, 60, 20)
Local $hHashLabel = GUICtrlCreateLabel("Hash Digest", 5, 35, 365, 20, $SS_CENTER)

GUISetState(@SW_SHOW)

_Crypt_Startup()

Local $msg, $sFile
Do
	$msg = GUIGetMsg()

	Switch $msg
		Case $hBrowseButton
			$sFile = FileOpenDialog("Open file", "", "All files (*.*;)")
			GUICtrlSetData($hFileControl, $sFile)

		Case $hCalcButton
			Local $iALG_ID = 0
			; 用户选择什么算法?
			Switch GUICtrlRead($hHashCombo)
				Case "MD2"
					$iALG_ID = $CALG_MD2
				Case "MD4"
					$iALG_ID = $CALG_MD4
				Case "MD5"
					$iALG_ID = $CALG_MD5
				Case "SHA1"
					$iALG_ID = $CALG_SHA1
				Case Else
					MsgBox(16, "Error", "Not a valid algorithm!")
					ContinueLoop
			EndSwitch
			$sFile = GUICtrlRead($hFileControl)
			If Not FileExists($sFile) Then
				MsgBox(16, "Error", "Invalid file")
				ContinueLoop
			EndIf
			Local $bDigest = _Crypt_HashFile($sFile, $iALG_ID)
			GUICtrlSetData($hHashLabel, $bDigest)

		Case $GUI_EVENT_CLOSE
			ExitLoop

	EndSwitch
Until False

_Crypt_Shutdown()
