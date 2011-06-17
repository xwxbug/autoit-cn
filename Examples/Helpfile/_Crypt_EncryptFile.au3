#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Crypt.au3>

Local $hWnd = GUICreate("File Encrypter", 234, 178, 260, 238)
GUICtrlCreateLabel("Input file", 8, 0, 44, 17)
Local $InFileInput = GUICtrlCreateInput("", 8, 16, 169, 21)
GUICtrlCreateLabel("Output file", 8, 48, 52, 17)
Local $OutFileInput = GUICtrlCreateInput("", 8, 64, 169, 21)
Local $InFileButton = GUICtrlCreateButton("...", 184, 16, 35, 20, $WS_GROUP)
Local $OutFileButton = GUICtrlCreateButton("...", 184, 64, 35, 20, $WS_GROUP)
GUICtrlCreateLabel("Algorithm", 8, 96, 47, 17)
Local $AlgoCombo = GUICtrlCreateCombo("RC4", 8, 112, 65, 25)
GUICtrlSetData(-1, "3DES|AES 128|AES 192|AES 256|DES|RC2")
GUICtrlCreateLabel("Password", 88, 96, 50, 17)
Local $PasswordInput = GUICtrlCreateInput("", 88, 112, 129, 21)
Local $EncryptButton = GUICtrlCreateButton("Encrypt File", 8, 144, 211, 25, $WS_GROUP)
GUISetState(@SW_SHOW)

Global $Increase = 0
Local $nMsg, $file, $infile, $outfile
While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $InFileButton
			$file = FileOpenDialog("Input File", "", "All files (*.*;)")
			If $file <> "" Then GUICtrlSetData($InFileInput, $file)
		Case $OutFileButton
			$file = FileSaveDialog("Output file", "", "Any file (*.*;)")
			If $file <> "" Then GUICtrlSetData($OutFileInput, $file)

		Case $EncryptButton
			$infile = GUICtrlRead($InFileInput)
			If Not FileExists($infile) Then
				MsgBox(16, "Error", "Input file doesn't exists!")
				ContinueLoop
			EndIf

			$outfile = GUICtrlRead($OutFileInput)
			If $outfile = "" Then
				MsgBox(16, "Error", "Please input a output file")
				ContinueLoop
			EndIf

			Local $algo = 0
			Switch GUICtrlRead($AlgoCombo)
				Case "3DES"
					$algo = $CALG_3DES
				Case "DES"
					$algo = $CALG_DES
				Case "RC2"
					$algo = $CALG_RC2
				Case "RC4"
					$algo = $CALG_RC4
				Case "AES 128"
					If @OSVersion = "WIN_2000" Then
						MsgBox(16, "Error", "Sorry, this algorithm is not available on this system!")
						ContinueLoop
					EndIf
					$algo = $CALG_AES_128
				Case "AES 192"
					If @OSVersion = "WIN_2000" Then
						MsgBox(16, "Error", "Sorry, this algorithm is not available on this system!")
						ContinueLoop
					EndIf
					$algo = $CALG_AES_192
				Case "AES 256"
					If @OSVersion = "WIN_2000" Then
						MsgBox(16, "Error", "Sorry, this algorithm is not available on this system!")
						ContinueLoop
					EndIf
					$algo = $CALG_AES_256
			EndSwitch
			Local $password = GUICtrlRead($PasswordInput)
			If $password = "" Then
				MsgBox(16, "Error", "Please input a password")
				ContinueLoop
			EndIf

			AdlibRegister("Update", 333)
			Local $success = _Crypt_EncryptFile($infile, $outfile, $password, $algo)
			If $success Then
				MsgBox(0, "Success", "Operation succeeded")
			Else
				Switch @error
					Case 1
						MsgBox(16, "Fail", "Failed to create key")
					Case 2
						MsgBox(16, "Fail", "Couldn't open source file")
					Case 3
						MsgBox(16, "Fail", "Couldn't open destination file")
					Case 4 Or 5
						MsgBox(16, "Fail", "Encryption error")
				EndSwitch
			EndIf

			AdlibUnRegister("Update")
			WinSetTitle($hWnd, "", "File Encrypter")
	EndSwitch
WEnd

Func Update()
	Switch Mod($Increase, 4)
		Case 0
			WinSetTitle($hWnd, "", "Processing... |")
		Case 1
			WinSetTitle($hWnd, "", "Processing... /")
		Case 2
			WinSetTitle($hWnd, "", "Processing... ¡ª")
		Case 3
			WinSetTitle($hWnd, "", "Processing... \")
	EndSwitch

	$Increase += 1
EndFunc   ;==>Update
