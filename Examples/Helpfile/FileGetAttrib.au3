$attrib = FileGetAttrib("c:\boot.ini")
If @error Then
	MsgBox(4096,"Error", "Could not obtain attributes.")
	Exit
Else
	If StringInStr($attrib, "R") Then
	MsgBox(4096,"", "File is read-only.")
	EndIf
EndIf

; Display full attribute information in text form
; Arrays rely upon the fact that each capital letter is unique
; Figuring out how this works is a good string exercise...
$input = StringSplit("R,A,S,H,N,D,O,C,T",",")
$output = StringSplit("Read-only /, Archive /, System /, Hidden /" & _
		", Normal /, Directory /, Offline /, Compressed /, Temporary /",  ",")
For $i = 1 to 9
	$attrib = StringReplace($attrib, $input[$i], $output[$i], 0, 1)
	; last parameter in StringReplace means case-sensitivity
Next
$attrib = StringTrimRight($attrib, 2) ;remove trailing slash
MsgBox(0,"Full file attributes:", $attrib)
