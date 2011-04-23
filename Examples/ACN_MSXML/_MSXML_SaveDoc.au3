#include <ACN_MSXML.au3>
Local $oXMLDoc
_MSXML_InitInstance($oXMLDoc)
If @error Then
	MsgBox(0,"Error","Failed to create instance")
	Exit
EndIf
_MSXML_CreateFile($oXMLDoc, @ScriptDir&"\settings.xml", "SETTINGS", True,  False)
_MSXML_CreateRootChild($oXMLDoc,"DesktopWidth",@DesktopWidth)
_MSXML_CreateRootChild($oXMLDoc,"DesktopHeight",@DesktopHeight)
Local $aNames[2]=["width","height"]
Local $aValues[2]=[@DesktopWidth,@DesktopHeight]
_MSXML_CreateRootChildWAttr($oXMLDoc,"DeskTopMetrics",$aNames,$aValues)
_MSXML_SaveDoc($oXMLDoc, @ScriptDir&"\settings.xml")
$oXMLDoc = 0
MsgBox(0,"Settings",FileRead(@ScriptDir&"\settings.xml"))
