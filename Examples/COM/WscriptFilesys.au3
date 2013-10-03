#include <Constants.au3>

; Wscript.filesystem Example
;
; Based on AutoItCOM version 3.1.0
;
; Beta version 06-02-2005
;

Local $Folder = @TempDir ; Folder to test the size of

Local $objFSO = ObjCreate("Scripting.FileSystemObject")

If @error Then
	MsgBox($MB_SYSTEMMODAL, "Wscript.filesystem Test", "I'm sorry, but creation of object $objFSO failed. Error code: " & @error)
	Exit
EndIf

Local $objFolder = $objFSO.GetFolder($Folder) ; Get object to the given folder

MsgBox($MB_SYSTEMMODAL, "Wscript.filesystem Test", "Your " & $Folder & " folder size is: " & Round($objFolder.Size / 1024) & " Kilobytes")

Exit
