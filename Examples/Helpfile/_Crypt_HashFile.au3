#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <Crypt.au3>

; Example of hashing files

; Create GUI
$hWnd=GUICreate("Hasher",370,60)
$hFileControl=GUICtrlCreateInput("",5,5,200,20)
$hBrowseButton=GUICtrlCreateButton("...",210,5,35,20)
$hHashCombo=GUICtrlCreateCombo("MD5",250,5,50,20)
GUICtrlSetData(-1,"MD2|MD4|SHA1")
$hCalcButton=GUICtrlCreateButton("Calculate",305,5,60,20)
$hHashLabel=GUICtrlCreateLabel("Hash Digest",5,35,365,20,$SS_CENTER)

GUISetState(@SW_SHOW)

_Crypt_Startup()

Do
	$msg=GUIGetMsg()

	Switch $msg
		Case $hBrowseButton
			$sFile=FileOpenDialog("Open file","","All files (*.*;)")
			GUICtrlSetData($hFileControl,$sFile)

		Case $hCalcButton
			$iALG_ID=0
			; What algorthm did the user choose?
			Switch GUICtrlread($hHashCombo)
				Case "MD2"
					$iALG_ID=$CALG_MD2
				Case "MD4"
					$iALG_ID=$CALG_MD4
				Case "MD5"
					$iALG_ID=$CALG_MD5
				Case "SHA1"
					$iALG_ID=$CALG_SHA1
				Case Else
					MsgBox(16,"Error","Not a valid algorithm!")
					ContinueLoop
			EndSwitch
			$sFile=GUICtrlRead($hFileControl)
			If Not FileExists($sFile) Then
				MsgBox(16,"Error","Invalid file")
				ContinueLoop
			EndIf
			$bDigest=_Crypt_HashFile($sFile,$iALG_ID)
			GUICtrlSetData($hHashLabel,$bDigest)

		Case $GUI_EVENT_CLOSE
			ExitLoop

	EndSwitch
Until False

_Crypt_Shutdown()
