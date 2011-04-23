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
	$oXMLDoc = 0
	Exit
EndIf

$iCount = _MSXML_GetNodeCount($oXMLDoc,"Books/Book/Title")
MsgBox(0,"Count",$iCount)
$aNodes = _MSXML_SelectNodes($oXMLDoc,"Books/Book")
If IsArray($aNodes) Then
	_ArrayDisplay($aNodes)
EndIf
$aNodes = _MSXML_GetChildNodes($oXMLDoc,"Books/Book[2]")
If IsArray($aNodes) Then
	_ArrayDisplay($aNodes)
EndIf

$aNodes = _MSXML_GetChildText($oXMLDoc,"Books/Book[2]/Title")
If IsArray($aNodes) Then
	_ArrayDisplay($aNodes)
EndIf
_SetDebug(True)
$aNodes = _MSXML_GetField($oXMLDoc,"/Book[2]")
If IsArray($aNodes) Then
	_ArrayDisplay($aNodes)
EndIf
$sValue = _MSXML_GetValue($oXMLDoc,"Books/Book[2]/Title")
If IsArray($sValue) Then
	_ArrayDisplay($sValue)
EndIf

$oXMLDoc = 0
