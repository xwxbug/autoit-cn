#include <GuiConstantsEx.au3>
#include <ClipBoard.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $aFormats[3]=[2, $CF_TEXT, $CF_OEMTEXT]

	; Create GUI
	$hGUI = GUICreate("Clipboard", 600, 400)
	$iMemo = GUICtrlCreateEdit("", 2, 2, 596, 396, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; See if there is any text in the clipboard
	MemoWrite("Priority formats .:. " & _ClipBoard_GetPriorityFormat($aFormats))
	MemoWrite("Unicode available .: " & _ClipBoard_IsFormatAvailable($CF_UNICODETEXT))
	
	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

EndFunc   ;==>_Main

; Write message to memo
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite