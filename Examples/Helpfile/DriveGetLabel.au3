Local $var = DriveGetLabel("c:\")
If $var='' Then
	MsgBox(4096,"´íÎó","C ÅÌ¾í±êÎ´ÉèÖÃ")
Else
	MsgBox(4096,"C ÅÌ¾í±ê: ",$var)
EndIf