#include <ACN_MSXML.au3>
#include <Array.au3>
Local $oXMLDoc
_MSXML_InitInstance($oXMLDoc)
If @error Then
	MsgBox(0,"Error","Failed to create instance")
	Exit
EndIf
_MSXML_FileOpen($oXMLDoc, @ScriptDir&"\books.xml") 
If @error Then
	MsgBox(0,"Error",_MSXML_Error())
Else 
	MsgBox(0,"Success","File open and ready.")
EndIf
$oXMLDoc = 0
