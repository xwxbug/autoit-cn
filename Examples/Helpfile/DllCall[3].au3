#include <MsgBoxConstants.au3>

; Show the Windows PickIconDlg.
Local $sFileName = @SystemDir & '\shell32.dll'

; Create a structure to store the icon index
Local $stIcon = DllStructCreate("int")
Local $stString = DllStructCreate("wchar[260]")
Local $structsize = DllStructGetSize($stString) / 2
DllStructSetData($stString, 1, $sFileName)

; Run the PickIconDlg - '62' is the ordinal value for this function
DllCall("shell32.dll", "none", 62, _
		"hwnd", 0, _
		"ptr", DllStructGetPtr($stString), _
		"int", $structsize, _
		"ptr", DllStructGetPtr($stIcon))

$sFileName = DllStructGetData($stString, 1)
Local $iIconIndex = DllStructGetData($stIcon, 1)

; Show the new filename and icon index
MsgBox($MB_SYSTEMMODAL, "Info", "Last selected file: " & $sFileName & @CRLF & "Icon-Index: " & $iIconIndex)
