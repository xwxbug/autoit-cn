#include  <File.au3>
If Not _FileCreate(" error.log ") Then
	msgbox(4096, "Error ", "Error Creating/Resetting log.      error:" & @error)
EndIf

