#include-once
#include <Array.au3>
;#INDEX#==============================================================================
;
; AutoIt Version:  3.0
; Language:   English
; Description ...: Functions that assist with using xml files
;                  Stephen Podhajecki <gehossafats at netmdc.com/>
; Dec 15, 2005, Update Jan10,2006, Update Feb 5,8,14-15, 2006
; Feb 24, 2006 Updated _MSXML_CreateCDATA, code cleaned up Gary Frost (custompcs at charter.net)
; Feb 24, 2006 bug fix in re-init COM error handler, rewrote _MSXML_CreateChildNodeWAttr()
; Jun 20, 2006 Added count to index[0] of the _MSXML_GetValue return value
; Jun 26, 2006 Changed _MSXML_CreateFile to include option flag for UTF-8 encoding
; Jun 29, 2006 Added count to index[0] of the _MSXML_GetValue return
;                  Changed _MSXML_FileOpen and _MSXML_FileCreate to try latest version first.
; Sep 17, 2006 Small changes
; Mar 30, 2007 Rewrote _AddFormat function to break up tags( no indentation)
;                  Added _MSXML_Transform() which runs the document against a xsl(t) style sheet for indentation.
;                  Changed _MSXML_CreateRootChildWAttr() to use new formatting
;                  Changed _MSXML_ChreateChildNode() to use new formatting
; Apr 02, 2007 Added _MSXML_ReplaceChild()
; Apr 03, 2007 Changed other node creating function to use new formatting
;                  Changed _MSXML_FileOpen() _MSXML_FileCreate to take an optional version number of MSXML to use.
;                  Changed _MSXML_FileOpen() _MSXML_FileCreate find latest MSXML version logic.
; Apr 05,2007 Changed all function to require the Dom object be passed as first param.
;                  This removes the need for 2 separate UDF's by allowing this UDF
;                  to handle multiple documents. This also breaks compatibility with old scripts.
;                  MSXML version check starts at 6 instead of 8.
;                  This may still cause an error for some people.
; Apr 06,2007 Changed the _MSXML_GetAttrib() to return just the value.
;      Changed somefunction to return 0 instead of -1 on fail.
;                  Minor changes to _MSXML_GetAllAttrib().
;                  Other small fixes.
; Apr 07,2007 Changed version to 1.2
; Apr 24, 2007 Fixed _MSXML_CreateChileNodeWAttr() - Instead of removal, It points to the function that replaced it.
; Apr 25, 2007 Added _MSXML_CreateAttrib()
;                  Fixed bug with _MSXML_CreateRootChildWAttr , _MSXML_CreateChild[Node]WAttr() where an extra node with same name was added.
;                  Stripped extrenous comments.
;                  Removed dependency on Array.au3 (I added the func from Array.au3 and renamed it to avoid conflicts.)
; May 03, 2007 Changed method of msxml version lookup. Updated api call tips.
; May 11, 2007 Fixed missing \
; Jun 08, 2007 Fixed Namespace issue with _MSXML_CreateChildNode() and _MSXML_CreateChildNodeWAttr()
; Jun 12, 2007 Added workaround for MSXML6 to parse file with DTD's
; Jun 13, 2007 Fixed bug in _MSXML_GetField() where all text was returned in one node.
;                  Actually this is not a bug, because it is the way that WC3 says it will be returned
;                  However, it will now return in a way that is expected.
;                  _MSXML_GetValue now returns just the text associated with the node or empty string.
;===============================================================================
; XML DOM Wrapper functions
;
; These funtions require BETA as they need support for COM
;
;===============================================================================
#cs defs to add to au3.api
_MSXML_CreateFile($sPath, $sRootNode, [$bOverwrite = False]) Creates an XML file with the given name and root.(Requires: #include <_MSXML_DomWrapper.au3>)
_MSXML_FileOpen($sXMLFile,[$sNamespace=""],[$ver=-1]) Creates an instance of an XML file.(Requires: #include <_MSXML_DomWrapper.au3>)
;==============================================================================
_MSXML_GetChildNodes ( $objDoc , strXPath ) Selects XML child Node(s) of an element based on XPath input from root node. (Requires: #include <_MSXML_DomWrapper.au3>)
_MSXML_GetNodeCount ( $objDoc , strXPath, strQry = "", iNodeType = 1 ) Get node count for specified path and type. (Requires: #include <_MSXML_DomWrapper.au3>)
_MSXML_GetPath ( $objDoc , strXPath ) Returns a nodes full path based on XPath input from root node. (Requires: #include <_MSXML_DomWrapper.au3>)
;==============================================================================
_MSXML_SelectNodes ( $objDoc , strXPath ) Selects XML Node(s) based on XPath input from root node. (Requires: #include <_MSXML_DomWrapper.au3>)
_MSXML_GetField ( $objDoc , strXPath ) Get XML Field(s) based on XPath input from root node.(Requires: #include <_MSXML_DomWrapper.au3>)
_MSXML_GetValue ( $objDoc , strXPath ) Get XML Field based on XPath input from root node. (Requires: #include <_MSXML_DomWrapper.au3>)
_MSXML_GetChildText ( $objDoc , strXPath ) Selects XML child Node(s) of an element based on XPath input from root node. (Requires: #include <_MSXML_DomWrapper.au3>)
_MSXML_UpdateField ( $objDoc , strXPath, strData ) Update existing node(s) based on XPath specs.(Requires: #include <_MSXML_DomWrapper.au3>)
_MSXML_ReplaceChild ( $objDoc , objOldNode, objNewNode, ns = "" ) Replaces a node with a new node. (Requires: #include <_MSXML_DomWrapper.au3>)
;==============================================================================
_MSXML_DeleteNode ( $objDoc , strXPath ) Delete specified XPath node.(Requires: #include <_MSXML_DomWrapper.au3>)
_MSXML_DeleteAttr ( $objDoc , strXPath, strAttrib ) Delete attribute for specified XPath(Requires: #include <_MSXML_DomWrapper.au3>)
_MSXML_DeleteAttrNode ( $objDoc , strXPath, strAttrib ) Delete attribute node for specified XPath(Requires: #include <_MSXML_DomWrapper.au3>)
;==============================================================================
_MSXML_GetAttrib ( $objDoc , strXPath, strAttrib, strQuery = "" ) Get XML attribute based on XPath input from root node.(Requires: #include <_MSXML_DomWrapper.au3>)
_MSXML_GetAllAttrib ( $objDoc , strXPath, ByRef aName, ByRef aValue, strQry = "" ) Get all XML Field(s) attributes based on XPath input from root node.(Requires: #include <_MSXML_DomWrapper.au3>)
_MSXML_GetAllAttribIndex ( $objDoc , strXPath, ByRef aName, ByRef aValue, strQry = "", NodeIndex = 0 ) Get all XML Field(s) attributes based on Xpathn and specific index.(Requires: #include <_MSXML_DomWrapper.au3>)
_MSXML_SetAttrib ( $objDoc , strXPath, strAttrib, strValue = "" ) Set XML Field(s) attributes based on XPath input from root node.(Requires: #include <_MSXML_DomWrapper.au3>)
;==============================================================================
_MSXML_CreateCDATA ( $objDoc , strNode, strCDATA, strNameSpc = "" ) Create a CDATA SECTION node directly under root. (Requires: #include <_MSXML_DomWrapper.au3>)
_MSXML_CreateComment ( $objDoc , strNode, strComment ) Create a COMMENT node at specified path.(Requires: #include <_MSXML_DomWrapper.au3>)
_MSXML_CreateAttrib ( $objDoc , strXPath,strAttrName,strAttrValue="" ) Creates an attribute for the specified node. (Requires: #include <_MSXML_DomWrapper.au3>)
;==============================================================================
_MSXML_CreateRootChild ( $objDoc , strNode, strData = "", strNameSpc = "" ) Create node directly under root.(Requires: #include <_MSXML_DomWrapper.au3>)
_MSXML_CreateRootChildWAttr ( $objDoc , strNode, aAttr, aVal, strData = "", strNameSpc = "" ) Create a child node under root node with attributes.(Requires: #include <_MSXML_DomWrapper.au3>)
_MSXML_CreateChildNode ( $objDoc , strXPath, strNode, strData = "", strNameSpc = "" )  Create a child node under the specified XPath Node.(Requires: #include <_MSXML_DomWrapper.au3>)
_MSXML_CreateChildWAttr ( $objDoc , strXPath, strNode, aAttr, aVal, strData = "", strNameSpc = "" ) Create a child node under the specified XPath Node with Attributes. (Requires: #include <_MSXML_DomWrapper.au3>)
;==============================================================================
_MSXML_SchemaValidate (  sXMLFile, ns, sXSDFile ) 	_MSXML_SchemaValidate($sXMLFile, $ns, $sXSDFile) Validate a document against a DTD. (Requires: #include <_MSXML_DomWrapper.au3>)
_MSXML_GetDomVersion ( ) Returns the XSXML version currently in use. (Requires: #include <_MSXML_DomWrapper.au3>)
_MSXML_Error (  sError = "" ) Sets or Gets XML error message generated by XML functions.(Requires: #include <_MSXML_DomWrapper.au3>)
_MSXML_UDFVersion ( ) eturns the UDF Version number. (Requires: #include <_MSXML_DomWrapper.au3>)
_MSXML_Transform ( $oXMLDoc, Style = "",szNewDoc="" ) Transfroms the document using built-in sheet or xsl file passed to function. (Requires: #include <_MSXML_DomWrapper.au3>)
#ce;===============================================================================
;Global variables
Global Const $_MSXML_UDFVER = "1.2.0.19"; udf version
Global Const $NODE_INVALID = 0;
Global Const $NODE_ELEMENT = 1;
Global Const $NODE_ATTRIBUTE = 2;
Global Const $NODE_TEXT = 3;
Global Const $NODE_CDATA_SECTION = 4;
Global Const $NODE_ENTITY_REFERENCE = 5;
Global Const $NODE_ENTITY = 6;
Global Const $NODE_PROCESSING_INSTRUCTION = 7;
Global Const $NODE_COMMENT = 8;
Global Const $NODE_DOCUMENT = 9;
Global Const $NODE_DOCUMENT_TYPE = 10;
Global Const $NODE_DOCUMENT_FRAGMENT = 11;
Global Const $NODE_NOTATION = 12;
Global $MSXMLCURRENTFILE;the current xml file name
;Global $objDoc;then current XML object
Global $oMyError ;COM error handler OBJ ; Initialize SvenP 's  error handler
Global $sXML_error;Error message variable for XML errors
Global $debugging ;flag for debug messages
Global $DOMVERSION = -1
;===============================================================================
;UDF functions
; #FUNCTION# ====================================================================================================================
; Description ...: Creates an instance of an XML file.
; Parameters ....: $objDoc    - Variable of type object that holds the xml document
;                  $strXMLFile  - Filename of an xml file to open
;                  $strNameSpc  - A namespace associated with the xml
;                  $ver         - optional version to use (force use of specific version)
;                  $bValOnParse - Flag to validate the XML when loading file.
; Return values .: On Success - 1 
;                  On Failure - one of the following:
;                  |-1 - error 2 = no obj
;                  |other - parse error
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_FileOpen(ByRef $objDoc, $strXMLFile, $strNameSpc = "", $ver = -1, $bValOnParse = True)
	If Not IsObj($objDoc) Then
		_MSXML_Error("Error: MSXML not found. This object is required to use this program.")
		Return SetError(2,0,-1)
	EndIf
	If $oMyError <> "" Then $oMyError = ""
	$oMyError = ObjEvent("AutoIt.Error", "_COMerr") ; ; Initialize SvenP 's  error handler
	$objDoc.async = False
	$objDoc.preserveWhiteSpace = True
	$MSXMLCURRENTFILE = $strXMLFile
	$objDoc.validateOnParse = $bValOnParse
	if $DOMVERSION > 4 Then $objDoc.setProperty ("ProhibitDTD",false)
	$objDoc.Load ($MSXMLCURRENTFILE)
	If $objDoc.parseError.errorCode <> 0 Then
		_MSXML_Error("Error opening specified file: " & $strXMLFile & @CRLF & $objDoc.parseError.reason)
		Return SetError($objDoc.parseError.errorCode,0,-1)
	EndIf
	$objDoc.setProperty ("SelectionNamespaces", $strNameSpc); "xmlns:ms='urn:schemas-microsoft-com:xslt'"
	$objDoc.setProperty ("SelectionLanguage", "XPath")
	Return 1
EndFunc   ;==>_MSXML_FileOpen
; #FUNCTION# ===================================================================
; Description ...: Creates a new COM instance of msxml
; Parameters ....: $objDoc - variable to use for creation
;                  $ver - optional version to use (force use of specific version)
; Return values .: MSXML major version # on success or 0 on fail (set error 1)
; Author ........: Stephen Podhajecki <gehossafats at netmdc.com/>
; Remarks .......: This must be called first to create an XML objet.
; Related .......:
;===============================================================================
Func _MSXML_InitInstance(ByRef $objDoc,$ver = -1)
	If $ver <> -1 Then
		If $ver > -1 And $ver < 7 Then
			$objDoc = ObjCreate("Msxml2.DOMDocument." & $ver & ".0")
			If IsObj($objDoc) Then
				$DOMVERSION = $ver
			EndIf
		Else
			MsgBox(266288, "Error:", "Failed to create object with MSXML version " & $ver)
			
			Return SetError(1,0,0)
		EndIf
	Else
		For $x = 6 To 0 Step - 1
			If FileExists(@SystemDir&"\msxml"&$x&".dll") Then
				$objDoc = ObjCreate("Msxml2.DOMDocument." & $x & ".0")
				If IsObj($objDoc) Then
					$DOMVERSION = $x
				ExitLoop
				EndIf
			EndIf
		Next
	EndIf
		If Not IsObj($objDoc) Then Return SetError(1,0,0)
Return 1 
EndFunc
		
; #FUNCTION# ===================================================================
; Description ...: Sets a property value
; Parameters ....: $objDoc - MSXML instance 
;                  $strProperty - Property to set
;                  $vValue - the value 
; Return values .: 
; Author ........: Stephen Podhajecki <gehossafats at netmdc.com/>
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_SetProperty(ByRef $objDoc, $strProperty,$vValue)
		If Not IsObj($objDoc) Then
			_MSXML_Error("Error: No MSXML object to work with")
			Return SetError(2,0,-1)
		EndIf
		$objDoc.SetProperty($strProperty,$vValue)
		If $objDoc.parseError.errorCode <> 0 Then
			_MSXML_Error("Error Setting specified property: " & $strProperty)
			SetError($objDoc.parseError.errorCode)
			Return 0
		EndIf
		Return 1
EndFunc

		
; #FUNCTION# ===================================================================
; Description ...: Create a new blank metafile with header.
; Parameters ....: $objDoc    - Variable of type object that holds the xml document
;                  $strPath  - xml tree path from root node (root/child/child..)$filename - The xml filename with full path to create
;                  $strRoot - the root of the xml file to create
;                  $bOverwrite - boolean flag to auto overwrite existing xml file 
;                  $bUTF-8 - boolean flag to specify UTF-8 encoding in header.
;                  $ver    - version to use (force this version if present).
; Return values .: 1 on failure
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......: $bOverwrite defaults to false and will prompt to overwrite.
;                  Overwrite copies the file with the ext .old then deletes the original file.
; Related .......:
;===============================================================================
Func _MSXML_CreateFile(ByRef $objDoc, $strPath, $strRoot, $bOverwrite = False, $bUTF8 = False, $ver = -1)
 	If Not IsObj($objDoc) Then
		_MSXML_Error("Error: Failed to create file. No MSXML object passed.")
		Return SetError(1,0,0)
	EndIf
	Local $retval, $fe, $objPI, $rootElement
	$fe = FileExists($strPath)
	If $fe And Not $bOverwrite Then
		$retval = (MsgBox(4097, "File Exists:", "The specified file exits." & @CRLF & "Click OK to overwrite file or cancel to exit."))
		If $retval = 1 Then
			FileCopy($strPath, $strPath & @YEAR & "-" & @MON & "-" & @MDAY & "_" & @HOUR & "-" & @MIN & "-" & @SEC & ".bak", 1)
			FileDelete($strPath)
			$fe = False
		Else
			_MSXML_Error("Error failed to create file: " & $strPath & @CRLF & "File exists.")
			SetError(1)
			Return -1
		EndIf
	Else
		FileCopy($strPath, $strPath & ".old", 1)
		FileDelete($strPath)
		$fe = False
	EndIf
	If $fe = False Then
		If $bUTF8 Then
			$objPI = $objDoc.createProcessingInstruction ("xml", "version=""1.0"" encoding=""UTF-8""")
		Else
			$objPI = $objDoc.createProcessingInstruction ("xml", "version=""1.0""")
		EndIf
		$objDoc.appendChild ($objPI)
		$rootElement = $objDoc.createElement ($strRoot)
		$objDoc.documentElement = $rootElement
		$objDoc.save ($strPath)
		If $objDoc.parseError.errorCode <> 0 Then
			_MSXML_Error("Error Creating specified file: " & $strPath)
			SetError($objDoc.parseError.errorCode)
			Return -1
		EndIf
		$MSXMLCURRENTFILE = $strPath
		Return 1
	Else
		_MSXML_Error("Error! Failed to create file: " & $strPath)
		SetError(1)
		Return -1
	EndIf
	Return 1
EndFunc   ;==>_MSXML_CreateFile
; #FUNCTION# ===================================================================
; Description ...: Selects XML Node(s) based on XPath input from root node.
; Parameters ....: $objDoc    - Variable of type object that holds the xml document
;                  $strXPath  - xml tree path from root node (root/child/child..)
; Return values .: array of Nodes or -1 on failure
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_SelectNodes(ByRef $objDoc, $strXPath)
	If Not IsObj($objDoc) Then Return SetError(2,0,-1)
	Local $objNode, $objNodeList, $arrResponse[1], $xmlerr
	$objNodeList = $objDoc.selectNodes ($strXPath)
	While @error = 0
		If Not IsObj($objNodeList) Then $xmlerr = @CRLF & "No Matching Nodes found"
		For $objNode In $objNodeList
			_MSXML_ArrayAdd($arrResponse, $objNode.nodeName)
		Next
		$arrResponse[0] = $objNodeList.length
		Return $arrResponse
	WEnd
	_MSXML_Error("Error Selecting Node(s): " & $strXPath & $xmlerr)
	SetError(1)
	Return -1
EndFunc   ;==>_MSXML_SelectNodes
; #FUNCTION# ===================================================================
; Description ...: Get XML Field(s) based on XPath input from root node.
; Parameters ....: $objDoc    - Variable of type object that holds the xml document
;                  $strXPath  - xml tree path from root node (root/child/child..)
; Return values .: array of fields text values -1 on failure
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_GetField(ByRef $objDoc, $strXPath)
	Local $objNodeList, $arrResponse[1], $xmlerr, $szNodePath
	While @error = 0
		$objNodeList = $objDoc.selectSingleNode ($strXPath)
		If Not IsObj($objNodeList) Then
			$xmlerr = @LF & "No Matching Nodes found"
			$arrResponse[0] = 0
			ExitLoop
		EndIf
		If $objNodeList.hasChildNodes () Then
			Local $count = $objNodeList.childNodes.length
			For $x =1 to $count
				$objChild = $objNodeList.childNodes($x)
					_DebugWrite("ParentNode="&$objNodeList.parentNode.nodeType)
					If $objNodeList.parentNode.nodeType =$NODE_DOCUMENT Then
						$szNodePath="/"&$objNodeList.baseName &"/*["&$x&"]"
					Else
						$szNodePath = $objNodeList.baseName &"/*["&$x&"]"
					EndIf
					
					$aRet = _MSXML_GetValue($objDoc, $szNodePath)
					If IsArray($aRet) Then
						If UBound($aRet) > 1 Then
							_MSXML_ArrayAdd($arrResponse, $aRet[1])
							_DebugWrite("GetField>Text:" & $aRet[1])
						EndIf
					Else
						_MSXML_ArrayAdd($arrResponse, "")
						_DebugWrite("GetField>Text:" & "")
					EndIf
			Next
			$arrResponse[0] = UBound($arrResponse) - 1
			Return $arrResponse
		Else
			$arrResponse[0] = 0
			$xmlerr = @LF & "No Child Nodes found"
			SetError(1)
			ExitLoop
		EndIf
		Return $arrResponse
	WEnd
	_MSXML_Error("Error Selecting Node(s): " & $strXPath & $xmlerr)
	SetError(1)
	Return -1
EndFunc   ;==>_MSXML_GetField
; #FUNCTION# ===================================================================
; Description ...: Get XML Fieldbased on XPath input from root node.
; Parameters ....: $objDoc    - Variable of type object that holds the xml document
;                  $strXPath  - xml tree path from root node (root/child/child..)
; Return values .: array of fields text values -1 on failure
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_GetValue(ByRef $objDoc, $strXPath)
	Local $objNodeList, $arrResponse[1], $objNodeChild, $xmlerr
	While @error = 0
		_DebugWrite("GetValue>$strXPath:"&$strXPath)
		$objNodeList = $objDoc.selectNodes ($strXPath)
		If $objNodeList.length > 0 Then
			_DebugWrite("GetValue list length:" & $objNodeList.length)
			For $objNode In $objNodeList
				If $objNode.hasChildNodes () = False Then
					_MSXML_ArrayAdd($arrResponse, $objNode.nodeValue)
				Else
					For $objNodeChild In $objNode.childNodes ()
						If $objNodeChild.nodeType = $NODE_CDATA_SECTION Then
							_MSXML_ArrayAdd($arrResponse, $objNodeChild.data)
							_DebugWrite("GetValue>CData:" & $objNodeChild.data)
						ElseIf $objNodeChild.nodeType = $NODE_TEXT Then
							_MSXML_ArrayAdd($arrResponse, $objNodeChild.Text)
							_DebugWrite("GetValue>Text:" & $objNodeChild.Text)
						EndIf
					Next
				EndIf
			Next
			$arrResponse[0] = UBound($arrResponse) - 1
			Return $arrResponse
		Else
			$xmlerr = @CRLF & "No matching node(s)found!"
			Return SetError(1,0,-1)
			ExitLoop
		EndIf
	WEnd
	_MSXML_Error("Error Retrieving: " & $strXPath & $xmlerr)
	SetError(1)
	Return -1
EndFunc   ;==>_MSXML_GetValue
; #FUNCTION# ===================================================================
; Description ...: Deletes XML Node based on XPath input from root node.
; Parameters ....: $objDoc    - Variable of type object that holds the xml document
;                  $strXPath  - xml tree path from root node (root/child/child..)
; Return values .: array of fields text values -1 on failure
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_DeleteNode(ByRef $objDoc, $strXPath)
	Local $objNode, $xmlerr
	$objNode = $objDoc.selectSingleNode ($strXPath)
	If Not IsObj($objNode) Then $xmlerr = @CRLF & "Node Not found"
	While @error = 0 ;And $objNode.length > 0
		$objNode.parentNode.removeChild ($objNode)
		$objDoc.save ($MSXMLCURRENTFILE)
		
		Return 1
	WEnd
	_MSXML_Error("Error Deleting Node: " & $strXPath & $xmlerr)
	SetError(1)
	Return 0
EndFunc   ;==>_MSXML_DeleteNode
; #FUNCTION# ===================================================================
; Description ...: Delete XML Attribute based on XPath input from root node.
; Parameters ....: $objDoc    - Variable of type object that holds the xml document
;                  $strXPath  - xml tree path from root node (root/child/child..)
;                  $strAttrib - the attribute to delete.
; Return values .: 1 on error and set error to 1
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_DeleteAttr(ByRef $objDoc, $strXPath, $strAttrib)
	Local $objNode, $objAttr, $xmlerr
	$objNode = $objDoc.selectSingleNode ($strXPath)
	While @error = 0 And IsObj($objNode)
		$objAttr = $objNode.getAttributeNode ($strAttrib)
		If Not (IsObj($objAttr)) Then
			$xmlerr = "Attribute " & $strAttrib & " does not exist!"
			ExitLoop
		EndIf
		$objAttr = $objNode.removeAttribute ($strAttrib)
		$objDoc.save ($MSXMLCURRENTFILE)
		Return
	WEnd
	_MSXML_Error("Error Removing Attribute: " & $strXPath & " - " & $strAttrib & @CRLF & $xmlerr)
	$xmlerr = ""
	SetError(1)
	Return -1
EndFunc   ;==>_MSXML_DeleteAttr
; #FUNCTION# ===================================================================
; Description ...: Delete XML Attribute node based on XPath input from root node.
; Parameters ....: $objDoc    - Variable of type object that holds the xml document
;                  $strXPath  - xml tree path from root node (root/child/child..)
;                  $strAttrib - the attribute node to delete.
; Return values .: 1 on error and set error to 1
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_DeleteAttrNode(ByRef $objDoc, $strXPath, $strAttrib)
	Local $objNode, $objAttr, $xmlerr
	$objNode = $objDoc.selectSingleNode ($strXPath)
	If Not IsObj($objNode) Then
		$xmlerr = @CRLF & "Specified node not found!"
	Else
		While @error = 0
			$objAttr = $objNode.removeAttributeNode ($objNode.getAttributeNode ($strAttrib))
			$objDoc.save ($MSXMLCURRENTFILE)
			If Not (IsObj($objAttr)) Then
				$xmlerr = @CRLF & "Unspecified error:!"
				ExitLoop
			EndIf
			Return
		WEnd
	EndIf
	_MSXML_Error("Error Removing Attribute Node: " & $strXPath & " - " & $strAttrib & $xmlerr)
	SetError(1)
	Return -1
EndFunc   ;==>_MSXML_DeleteAttrNode
; #FUNCTION# ===================================================================
; Description ...: Get XML Field(s) based on XPath input from root node.
; Parameters ....: $objDoc    - Variable of type object that holds the xml document
;                  $strXPath  - xml tree path from root node (root/child/child..)
;                  $strAttrib - the attribute to set.
;                  $strQuery  - Query string.
; Return values .: Success - text value
;                  on error - set error to 1 and returns -1
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_GetAttrib(ByRef $objDoc, $strXPath, $strAttrib, $strQuery = "")
	Local $objNodeList, $arrResponse[1], $i, $xmlerr, $objAttr
	$objNodeList = $objDoc.selectSingleNode ($strXPath & $strQuery)
	_DebugWrite(IsObj($objNodeList))
	While @error = 0
		If IsObj($objNodeList) Then
			$objAttr = $objNodeList.getAttribute ($strAttrib)
			$arrResponse = $objAttr
			_DebugWrite("RET>>" & $objAttr)
			Return $arrResponse
		Else
			$xmlerr = @CRLF & "No qualified items found"
			ExitLoop
		EndIf
	WEnd
	_MSXML_Error("Attribute " & $strAttrib & " not found for: " & $strXPath & $xmlerr)
	SetError(1)
	Return Chr(0)
EndFunc   ;==>_MSXML_GetAttrib
; #FUNCTION# ===================================================================
; Description ...: Set XML Field(s) based on XPath input from root node.
; Parameters ....: $objDoc    - Variable of type object that holds the xml document
;                  $strXPath  - xml tree path from root node (root/child/child..)
;                  $strAttrib - the attribute to set.
;                  $strValue  - the value to give the attribute
; Return values .: Success - array of fields text values
;                  on error - returns -1 and sets error to 1
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_SetAttrib(ByRef $objDoc, $strXPath, $strAttrib, $strValue = "")
	Local $objNodeList, $arrResponse[1], $i
	$objNodeList = $objDoc.selectNodes ($strXPath)
	_DebugWrite(" Node list Length: " & $objNodeList.length)
	While @error = 0 And $objNodeList.length > 0
		ReDim $arrResponse[$objNodeList.length]
		For $i = 0 To $objNodeList.length - 1
			$arrResponse[$i] = $objNodeList.item ($i).SetAttribute ($strAttrib, $strValue)
		Next
		$objDoc.save ($MSXMLCURRENTFILE)
		Return $arrResponse
	WEnd
	_MSXML_Error("Error failed to set attribute for: " & $strXPath & @CRLF)
	SetError(1)
	Return 0
	;		EndIf
EndFunc   ;==>_MSXML_SetAttrib
; #FUNCTION# ===================================================================
; Description ...: Get all XML Field(s) attributes based on XPath input from root node.
; Parameters ....: $objDoc - Variable of type object that holds the xml document
;                  $strXPath - xml tree path from root node (root/child/child..)
;                  $aName - An rray for attribute names.
;                  $aValue - An array for the values.
;                  $strQuery - DOM compliant query string (not really necessary as it becomes part of the path
; Return values .: Success - array of fields text values
;                  on error - set error to 1 and returns -1
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_GetAllAttrib(ByRef $objDoc, $strXPath, ByRef $aName, ByRef $aValue, $strQry = "")
	Local $objNodeList, $objQueryNodes, $objNode, $arrResponse[2][1], $i
	
	$objQueryNodes = $objDoc.selectNodes ($strXPath & $strQry)
	If $objDoc.parseError.errorCode <> 0 Then
		_MSXML_Error("_MSXML_GetAllAttrib:" & @LF & "Error Seeking Node: " & $objDoc.parseError.reason)
	EndIf
	While @error = 0 And $objQueryNodes.length > 0
		For $objNode In $objQueryNodes
			$objNodeList = $objNode.attributes
			If ($objNodeList.length) Then
				_DebugWrite("Get all attrib " & $objNodeList.length)
				ReDim $arrResponse[$objNodeList.length + 2][2]
				ReDim $aName[$objNodeList.length]
				ReDim $aValue[$objNodeList.length]
				For $i = 0 To $objNodeList.length - 1
					$arrResponse[$i + 1][0] = $objNodeList.item ($i).nodeName
					$arrResponse[$i + 1][1] = $objNodeList.item ($i).Value
					$aName[$i] = $objNodeList.item ($i).nodeName
					$aValue[$i] = $objNodeList.item ($i).Value
				Next
			Else
				SetError(1)
				$arrResponse = 0
				ExitLoop
			EndIf
		Next
		$arrResponse[0][0] = $objNodeList.length
		Return $arrResponse
	WEnd
	_MSXML_Error("Error retrieving attributes for: " & $strXPath & @CRLF)
	SetError(1)
	Return 0
	;	EndIf
EndFunc   ;==>_MSXML_GetAllAttrib
; #FUNCTION# ===================================================================
; Description ...: Update existing node(s) based on XPath specs.
; Parameters ....: $objDoc - Variable of type object that holds the xml document
;                  $strXPath - Path from root
;                  $strData - The value for the node
; Return values .: on error set error to 1 and returns -1
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_UpdateField(ByRef $objDoc, $strXPath, $strData)
	Local $objField, $objNodeList
	#forceref $objField
	While @error = 0
		$objNodeList = $objDoc.selectNodes ($strXPath)
		If IsObj($objNodeList) And $objNodeList.length > 0 Then
			;	If $objDoc.documentElement.selectNodes ($strXPath) Then
			For $objField In $objNodeList
				$objField.Text = $strData
			Next
			$objDoc.Save ($MSXMLCURRENTFILE)
			$objField = ""
			Return
		Else
			ExitLoop
		EndIf
	WEnd
	_MSXML_Error("Failed to update field for: " & $strXPath & @CRLF)
	SetError(1)
	Return -1
EndFunc   ;==>_MSXML_UpdateField
; #FUNCTION# ===================================================================
; Description ...: Create a CDATA SECTION node directly under root.
; Parameters ....: $objDoc     - Variable of type object that holds the xml document
;                  $strNode    - name of node to create
;                  $strCDATA   - CDATA value
;                  $strNameSpc - Namespace
; Return values .: on error set error to 1 and returns -1
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......: fixme, won't append to exisiting node. must create new node.
; Related .......:
;===============================================================================
Func _MSXML_CreateCDATA(ByRef $objDoc, $strNode, $strCDATA, $strNameSpc = "")
	Local $objChild, $objNode
	While @error = 0
		$objNode = $objDoc.createNode ($NODE_ELEMENT, $strNode, $strNameSpc)
		If Not ($objNode.hasChildNodes ()) Then
			_AddFormat($objDoc, $objNode)
		EndIf
		$objChild = $objDoc.createCDATASection ($strCDATA)
		$objNode.appendChild ($objChild)
		$objDoc.documentElement.appendChild ($objNode)
		$objDoc.Save ($MSXMLCURRENTFILE)
		_AddFormat($objDoc)
		$objChild = ""
		Return
	WEnd
	_MSXML_Error("Failed to create CDATA Section: " & $strNode & @CRLF)
	SetError(1)
	Return -1
EndFunc   ;==>_MSXML_CreateCDATA
; #FUNCTION# ===================================================================
; Description ...: Create a COMMENT node at specified path.
; Parameters ....: $objDoc     - Variable of type object that holds the xml document
;                  $strNode    - name of node to create
;                  $strComment - the comment to add the to the xml file
; Return values .: on error set error to 1 and returns -1
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_CreateComment(ByRef $objDoc, $strNode, $strComment)
	Local $objChild, $objNode
	While @error = 0
		
		$objNode = $objDoc.selectSingleNode ($strNode)
		If Not ($objNode.hasChildNodes ()) Then
			_AddFormat( $objDoc, $objNode)
		EndIf
		$objChild = $objDoc.createComment ($strComment)
		$objNode.insertBefore ($objChild, $objNode.childNodes (0))
		$objDoc.Save ($MSXMLCURRENTFILE)
		_AddFormat($objDoc)
		$objChild = ""
		Return
	WEnd
	_MSXML_Error("Failed to root child: " & $strNode & @CRLF)
	SetError(1)
	Return -1
EndFunc   ;==>_MSXML_CreateComment
; #FUNCTION# ===================================================================
; Description ...: Creates an attribute for the specified node.
; Parameters ....: $objDoc - Variable of type object that holds the xml document
;                  $strXPath - xml tree path from root node (root/child/child..)
;                  $strAttrName - the attribute to set.
;                  $strAttrValue - the value to give the attribute defaults to ""
; Return values .: 1 on success, 0 on error
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_CreateAttrib(ByRef $objDoc,$strXPath, $strAttrName, $strAttrValue = "")
	Local $objNode, $objAttr, $objAttrVal, $err
	$objNode = $objDoc.selectSingleNode ($strXPath)
	If IsObj($objNode) Then
		$objAttr = $objDoc.createAttribute ($strAttrName);, $strNameSpc)
		$objNode.SetAttribute ($strAttrName, $strAttrValue)
		$objDoc.save ($MSXMLCURRENTFILE)
		$objAttr = 0
		$objAttrVal = 0
		$objNode = 0
		$err = $objDoc.parseError.errorCode
		If $err = 0 Then Return 1
	EndIf
	_MSXML_Error("Error creating Attribute: " & $strAttrName & @CRLF & $strXPath & " does not exist." & @CRLF)
	Return 0
EndFunc   ;==>_MSXML_CreateAttrib
; #FUNCTION# ===================================================================
; Description ...: Create node directly under root.
; Parameters ....: $objDoc - Variable of type object that holds the xml document
;                  $strNode  - node to add with attibute(s)
;                  $strData  - Optional value to give the child node.
;                  $strNameSpc - Namespace
; Return values .: on error set error to 1 and returns -1
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_CreateRootChild(ByRef $objDoc, $strNode, $strData = "", $strNameSpc = "")
	Local $objChild
	If Not ($objDoc.documentElement.hasChildNodes ()) Then
		_AddFormat($objDoc)
	EndIf
	$objChild = $objDoc.createNode ($NODE_ELEMENT, $strNode, $strNameSpc)
	If Not @error Then
		If $strData <> "" Then $objChild.text = $strData
		$objDoc.documentElement.appendChild ($objChild)
		
		$objDoc.Save ($MSXMLCURRENTFILE)
		_DebugWrite("Created Root Child")
		_AddFormat($objDoc)
		$objChild = 0
		
		Return
	EndIf
	_MSXML_Error("Failed to root child: " & $strNode & @CRLF)
	SetError(1)
	Return -1
EndFunc   ;==>_MSXML_CreateRootChild
; #FUNCTION# ===================================================================
; Description ...: Create a child node under root node with attributes.
; Parameters ....: $objDoc - Variable of type object that holds the xml document
;                  $strNode  - node to add with attibute(s)
;                  $aAttr    - attribute name(s) -- can be array
;                  $aVal     - attribute value(s) -- can be array
;                  $strData  - Optional value to give the child node.
;                  $strNameSpc - Namespace
; Return values .: on error set error to 1 or 2 and returns -1
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......: This function requires that each attribute name has
;                  a corresponding value.
; Related .......:
;===============================================================================
Func _MSXML_CreateRootChildWAttr(ByRef $objDoc, $strNode, $aAttr, $aVal, $strData = "", $strNameSpc = "")
	Local $objChild, $objAttr, $objAttrVal
	If Not ($objDoc.documentElement.hasChildNodes ()) Then
		_AddFormat($objDoc)
	EndIf
	$objChild = $objDoc.createNode ($NODE_ELEMENT, $strNode, $strNameSpc)
	If $strData <> "" Then $objChild.text = $strData
	While @error = 0
		If IsArray($aAttr) And IsArray($aVal) Then
			If UBound($aAttr) <> UBound($aVal) Then
				_MSXML_Error("Attribute and value mismatch" & @CRLF & "Please make sure each attribute has a matching value.")
				SetError(2)
				Return 0
			Else
				Local $i
				For $i = 0 To UBound($aAttr) - 1
					If $aAttr[$i] = "" Then
						_MSXML_Error("Error creating child node: " & $strNode & @CRLF & " Attribute Name Cannot be NULL." & @CRLF)
						SetError(1)
						Return 0
					EndIf
					$objAttr = $objDoc.createAttribute ($aAttr[$i]);, $strNameSpc)
					$objChild.SetAttribute ($aAttr[$i], $aVal[$i])
				Next
			EndIf
		Else
			$objAttr = $objDoc.createAttribute ($aAttr)
			$objChild.SetAttribute ($aAttr, $aVal)
		EndIf
		$objDoc.documentElement.appendChild ($objChild)
		$objDoc.Save ($MSXMLCURRENTFILE)
		_AddFormat($objDoc)
		$objChild = 0
		Return 1
	WEnd
	_MSXML_Error("Failed to create root child with attributes: " & $strNode & @CRLF)
	SetError(1)
	Return 0
EndFunc   ;==>_MSXML_CreateRootChildWAttr
; #FUNCTION# ===================================================================
; Description ...: Create a child node under the specified XPath Node.
; Parameters ....: $objDoc - Variable of type object that holds the xml document
;                  $strXPath - Path from root
;                  $strNode - Node to add
;                  $strData - The value for the node
;                  $strNameSpc - The namespace
; Return values .: on error set error to 1 and returns -1
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_CreateChildNode(ByRef $objDoc, $strXPath, $strNode, $strData = "", $strNameSpc = "")
	Local $objParent, $objChild, $objNodeList
	While @error = 0
		$objNodeList = $objDoc.selectNodes ($strXPath)
		If IsObj($objNodeList) And $objNodeList.length <> 0 Then
			For $objParent In $objNodeList
				If Not ($objParent.hasChildNodes ()) Then
					_AddFormat($objDoc, $objParent)
				EndIf
				If $strNameSpc = "" Then
					If Not ($objParent.namespaceURI = 0 Or $objParent.namespaceURI = "") Then $strNameSpc = $objParent.namespaceURI
				EndIf
				ConsoleWrite("$strNameSpc=" & $strNameSpc & @LF)
				$objChild = $objDoc.createNode ($NODE_ELEMENT, $strNode, $strNameSpc)
				If $strData <> "" Then $objChild.text = $strData
				$objParent.appendChild ($objChild)
				_AddFormat($objDoc, $objParent)
			Next
			$objDoc.Save ($MSXMLCURRENTFILE)
			$objParent = ""
			$objChild = ""
			Return
		Else
			ExitLoop
		EndIf
	WEnd
	_MSXML_Error("Error creating child node: " & $strNode & @CRLF & $strXPath & " does not exist." & @CRLF)
	SetError(1)
	Return -1
	
EndFunc   ;==>_MSXML_CreateChildNode
; #FUNCTION# ===================================================================
; Description ...: Create a child node(s) under the specified XPath Node with attributes.
; Parameters ....: $objDoc - Variable of type object that holds the xml document
;                  $strXPath - Path from root
;                  $strNode  - node to add with attibute(s)
;                  $aAttr    - attribute name(s) -- can be array
;                  $aVal     - attribute value(s) -- can be array
;                  $strData  - Optional value to give the child node.
;                  $strNameSpc - Namespace
; Return values .: 0 on error and set error 1 or 2
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......: This function requires that each attribute name has a corresponding value.
; Related .......:
;===============================================================================
Func _MSXML_CreateChildNodeWAttr(ByRef $objDoc, $strXPath, $strNode, $aAttr, $aVal, $strData = "", $strNameSpc = "")
	Return _MSXML_CreateChildWAttr($objDoc, $strXPath, $strNode, $aAttr, $aVal, $strData, $strNameSpc)
EndFunc   ;==>_MSXML_CreateChildNodeWAttr
; #FUNCTION# ===================================================================
; Description ...: Create a child node(s) under the specified XPath Node with attributes.
; Parameters ....: $objDoc   - Variable of type object that holds the xml document
;                  $strXPath - Path from root
;                  $strNode  - node to add with attibute(s)
;                  $aAttr    - attribute name(s) -- can be array
;                  $aVal     - attribute value(s) -- can be array
;                  $strData  - Optional value to give the child node.
;                  $strNameSpc - Namespace
; Return values .: 0 on error and set error 1 or 2
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......: This function requires that each attribute name has a corresponding value.
; Related .......:
;===============================================================================
Func _MSXML_CreateChildWAttr(ByRef $objDoc, $strXPath, $strNode, $aAttr, $aVal, $strData = "", $strNameSpc = "")
	Local $objParent, $objChild, $objAttr, $objAttrVal, $objNodeList
	While @error = 0
		$objNodeList = $objDoc.selectNodes ($strXPath)
		_DebugWrite("Node Selected")
		If IsObj($objNodeList) And $objNodeList.length <> 0 Then
			_DebugWrite("Entering if")
			For $objParent In $objNodeList
				If Not ($objParent.hasChildNodes ()) Then
					_AddFormat($objDoc, $objParent)
				EndIf
				_DebugWrite("Entering for")
				If $strNameSpc = "" Then
					If Not ($objParent.namespaceURI = 0 Or $objParent.namespaceURI = "") Then $strNameSpc = $objParent.namespaceURI
				EndIf
				$objChild = $objDoc.createNode ($NODE_ELEMENT, $strNode, $strNameSpc)
				If @error Then Return -1
				If $strData <> "" Then $objChild.text = $strData
				If IsArray($aAttr) And IsArray($aVal) Then
					If UBound($aAttr) <> UBound($aVal) Then
						_MSXML_Error("Attribute and value mismatch" & @CRLF & "Please make sure each attribute has a matching value.")
						SetError(2)
						Return -1
					Else
						Local $i
						For $i = 0 To UBound($aAttr) - 1
							_DebugWrite("Entering inside for")
							If $aAttr[$i] = "" Then
								_MSXML_Error("Error creating child node: " & $strNode & @CRLF & " Attribute Name Cannot be NULL." & @CRLF)
								SetError(1)
								Return -1
							EndIf
							_DebugWrite($aAttr[$i] & " " & $strNameSpc)
							$objAttr = $objDoc.createAttribute ($aAttr[$i]);, $strNameSpc)
							If @error Then ExitLoop
							$objChild.SetAttribute ($aAttr[$i], $aVal[$i])
							If @error <> 0 Then
								_MSXML_Error("Error creating child node: " & $strNode & @CRLF & $strXPath & " does not exist." & @CRLF)
								SetError(1)
								Return -1
							EndIf
							_DebugWrite("Looping inside for")
						Next
					EndIf
				Else
					If IsArray($aAttr) Or IsArray($aVal) Then
						_MSXML_Error("Type non-Array and Array detected" & @LF)
						SetError(1)
						Return -1
					EndIf
					If $aAttr = "" Then
						_MSXML_Error("Attribute Name cannot be empty string." & @LF)
						SetError(5)
						Return -1
					EndIf
					_DebugWrite($aAttr & " " & $strNameSpc)
					$objAttr = $objDoc.createAttribute ($aAttr);, $strNameSpc)
					$objChild.SetAttribute ($aAttr, $aVal)
				EndIf
				$objParent.appendChild ($objChild)
				_DebugWrite("Looping for")
			Next
			_AddFormat($objDoc, $objParent)
			$objDoc.Save ($MSXMLCURRENTFILE)
			_DebugWrite("Saved")
			$objParent = ""
			$objChild = ""
			_DebugWrite("Returning")
			Return
		Else
			_DebugWrite("Exitloop")
			ExitLoop
		EndIf
	WEnd
	_MSXML_Error("Error creating child node: " & $strNode & @CRLF & $strXPath & " does not exist." & @CRLF)
	SetError(1)
	Return -1
EndFunc   ;==>_MSXML_CreateChildWAttr
; #FUNCTION# ===================================================================
; Description ...: Selects XML child Node(s) of an element based on XPath input from root node.
; Parameters ....: $objDoc - Variable of type object that holds the xml document
;                  $strXPath  - xml tree path from root node (root/child/child..)
; Return values .: array of Nodes or -1 on failure
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_GetChildText(ByRef $objDoc, $strXPath)
	Local $objNodeList, $arrResponse[1], $xmlerr
	While @error = 0
		$objNodeList = $objDoc.selectSingleNode ($strXPath)
		If Not IsObj($objNodeList) Then
			$xmlerr = @CRLF & "No Matching Nodes found"
			$arrResponse[0] = 0
			ExitLoop
		EndIf
		If $objNodeList.hasChildNodes () Then
			For $objChild In $objNodeList.childNodes ()
				If $objChild.nodeType = $NODE_ELEMENT Then
					_MSXML_ArrayAdd($arrResponse, $objChild.baseName)
				ElseIf $objChild.nodeType = $NODE_TEXT Then
					_MSXML_ArrayAdd($arrResponse, $objChild.text)
				EndIf
			Next
			$arrResponse[0] = UBound($arrResponse) - 1
			Return $arrResponse
		Else
			$arrResponse[0] = 0
			$xmlerr = @CRLF & "No Child Text Nodes found"
			SetError(1)
			ExitLoop
		EndIf
		Return $arrResponse
	WEnd
	_MSXML_Error("Error Selecting Node(s): " & $strXPath & $xmlerr)
	SetError(1)
	Return -1
EndFunc   ;==>_MSXML_GetChildText
; #FUNCTION# ===================================================================
; Description ...: Checks for the existance of a node.
; Parameters ....: $objDoc - Variable of type object that holds the xml document
;                  $strXPath - xml tree path from root node (root/child/child..)
; Return values .: Exists     - 1
;                  Non Exists - 0
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......:
; Related .......:
;===============================================================================

Func _MSXML_NodeExists(ByRef $objDoc, $strXPath)
	Local $node = $objDoc.selectSingleNode ($strXPath)
	If IsObj($node) Then
		$node = 1
	Else
		$node = 0
	EndIf
	Return $node
EndFunc   ;==>_MSXML_NodeExists
; #FUNCTION# ===================================================================
; Description ...: Selects XML child Node(s) of an element based on XPath input from root node.
; Parameters ....: $objDoc - Variable of type object that holds the xml document
;                  $strXPath - xml tree path from root node (root/child/child..)
; Return values .: array of Nodes or -1 on failure
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_GetChildNodes(ByRef $objDoc, $strXPath)
	Local $objNodeList, $arrResponse[1], $xmlerr
	While @error = 0
		$objNodeList = $objDoc.selectSingleNode ($strXPath)
		If Not IsObj($objNodeList) Then
			$xmlerr = @LF & "No Matching Nodes found"
			$arrResponse = 0
			ExitLoop
		EndIf
		If $objNodeList.hasChildNodes () Then
			For $objChild In $objNodeList.childNodes ()
				If $objChild.nodeType () = $NODE_ELEMENT Then
					_DebugWrite("Child Node Name:" & $objChild.baseName & @LF)
					_MSXML_ArrayAdd($arrResponse, $objChild.baseName)
				EndIf
			Next
			$arrResponse[0] = UBound($arrResponse) - 1
			Return $arrResponse
		Else
			$arrResponse = 0
			$xmlerr = @LF & "No Child Nodes found"
			SetError(1)
			ExitLoop
		EndIf
		Return $arrResponse
	WEnd
	_MSXML_Error("Error Selecting Node(s): " & $strXPath & $xmlerr)
	SetError(1)
	Return 0
EndFunc   ;==>_MSXML_GetChildNodes
; #FUNCTION# ===================================================================
; Description ...: Get Node Count based on XPath input from root node.
; Parameters ....: $objDoc    - Variable of type object that holds the xml document
;                  $strXPath  - xml tree path from root node (root/child/child..)
;                  $strQuery  - DOM compliant query string (not really necessary as it becomes part of the path
;                  $iNodeType - The type of node to count. (element, attrib, comment etc.)
; Return values .: Success - 0 or Number of Nodes found
;                  on error -  set error to 1 and returns -1
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com> & DickB
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_GetNodeCount(ByRef $objDoc, $strXPath, $strQry = "", $iNodeType = 1)
	Local $objQueryNodes, $objNode, $nodeCount = 0, $errMsg
	$objQueryNodes = $objDoc.selectNodes ($strXPath & $strQry)
	If @error = 0 And $objQueryNodes.length > 0 Then
		For $objNode In $objQueryNodes
			If $objNode.nodeType = $iNodeType Then $nodeCount = $nodeCount + 1
		Next
		Return $nodeCount
	Else
		$errMsg = "No nodes of specified type found."
	EndIf
	_MSXML_Error("Error retrieving node count for: " & $strXPath & @CRLF & $errMsg & @CRLF)
	SetError(1)
	Return -1
	;    EndIf
EndFunc   ;==>_MSXML_GetNodeCount
; #FUNCTION# ===================================================================
; Description ...: Get all XML Field(s) attributes based on Xpathn and specific index.
; Parameters ....: $objDoc     - Variable of type object that holds the xml document
;                  $strXPath   - xml tree path from root node (root/child/child..)
;                  $aNames     - the array to return the attrib names
;                  $aValue     - the array to return the attrib values
;                  $strQuery   - DOM compliant query string (not really necessary as it becomes part of the path
;                  $iNodeIndex - node index.
; Return values .: Success - An array of attrib node names, array of attrib values
;                  Failure - on error set error to 1 and returns -1
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_GetAllAttribIndex(ByRef $objDoc, $strXPath, ByRef $aName, ByRef $aValue, $strQry = "", $iNodeIndex = 0)
	Local $objNodeList, $objQueryNodes, $arrResponse[2][1], $i
	$objQueryNodes = $objDoc.selectNodes ($strXPath & $strQry)
	While @error = 0 And $objQueryNodes.length > 0
		$objNodeList = $objQueryNodes.item ($iNodeIndex).attributes
		_DebugWrite("GetAllAttribIndex " & $objNodeList.length)
		ReDim $arrResponse[2][$objNodeList.length + 1]
		ReDim $aName[$objNodeList.length]
		ReDim $aValue[$objNodeList.length]
		For $i = 0 To $objNodeList.length - 1
			$arrResponse[0][$i] = $objNodeList.item ($i).nodeName
			$arrResponse[1][$i] = $objNodeList.item ($i).Value
			$aName[$i] = $objNodeList.item ($i).nodeName
			$aValue[$i] = $objNodeList.item ($i).Value
		Next
		Return $arrResponse
	WEnd
	_MSXML_Error("Error retrieving attributes for: " & $strXPath & @CRLF)
	SetError(1)
	Return -1
EndFunc   ;==>_MSXML_GetAllAttribIndex
; #FUNCTION# ===================================================================
; Description ...: Return a nodes full path based on XPath input from root node.
; Parameters ....: $objDoc - Variable of type object that holds the xml document
;                  $strXPath - xml tree path from root node (root/child/child..)
; Return values .: Success - Array of fields text values
;                  Failure - -1 
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......: Returns an array containing the nodes from the node to root
;                  in backwards order (root last).                  
; Related .......:
;===============================================================================
Func _MSXML_GetPath(ByRef $objDoc, $strXPath)
	If $DOMVERSION < 4 Then
		_MSXML_Error("Error DOM Version: " & "MSXML Version 4 or greater required for this function")
		Return -1
	EndIf
	Local $objNodeList, $arrResponse[1], $objNodeChild, $xmlerr, $nodepath, $ns
	While @error = 0
		$objNodeList = $objDoc.selectNodes ($strXPath)
		If $objNodeList.length > 0 Then
			_DebugWrite("GetPath list length:" & $objNodeList.length)
			For $objNode In $objNodeList
				Local $objNode1 = $objNode
				$nodepath = ""
				$nodepathtag = ""
				If $objNode.nodeType <> $NODE_DOCUMENT Then
					$ns = $objNode.namespaceURI ()
					If $ns <> "" Then
						$ns = StringRight($ns, StringLen($ns) - StringInStr($ns, "/", 0, -1)) & ":"
					EndIf
					$nodepath = "/" & $ns & $objNode.nodeName () & $nodepath
				EndIf
				Do
					$objParent = $objNode1.parentNode ()
					_DebugWrite("parent" & $objParent.nodeName () & @LF)
					If $objParent.nodeType <> $NODE_DOCUMENT Then
						$ns = $objParent.namespaceURI ()
						If $ns <> "" Then
							$ns = StringRight($ns, StringLen($ns) - StringInStr($ns, "/", 0, -1)) & ":"
						EndIf
						$nodepath = "/" & $ns & $objParent.nodeName () & $nodepath
						$objNode1 = $objParent
					Else
						$objNode1 = 0
					EndIf
					$objParent = 0
				Until (Not (IsObj($objNode1)))
				_DebugWrite("Path node>" & $nodepath & @LF)
				_MSXML_ArrayAdd($arrResponse, $nodepath)
			Next
			$arrResponse[0] = UBound($arrResponse) - 1
			Return $arrResponse
		Else
			$xmlerr = @CRLF & "No matching node(s)found!"
			Return -1
			ExitLoop
		EndIf
	WEnd
	_MSXML_Error("Error Retrieving: " & $strXPath & $xmlerr)
	SetError(1)
	Return -1
EndFunc   ;==>_MSXML_GetPath
; #FUNCTION# ===================================================================
; Description ...: Replaces a node with another
; Parameters ....: $objDoc     - Variable of type object that holds the xml document
;                  $objOldNode - Node to replace
;                  $objNewNode - The replacement node.
;                  $ns         - Namespace
; Return values .: Success - True
;                  Failure - False
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com> 
; Remarks .......: adapted from http://www.perfectxml.com/msxmlAnswers.asp?Row_ID=65
; Related .......:
;===============================================================================
Func _MSXML_ReplaceChild(ByRef $objDoc, $objOldNode, $objNewNode, $ns = "")
	If $objOldNode = "" Or $objNewNode = "" Then Return SetError(1)
	Local $nodeRoot
	Local $nodeOld
	Local $nodeNew
	Local $nodeTemp
	Local $bSuccess = False
	;No error handling done
	With $objDoc
		$nodeRoot = .documentElement
		$oldNodes = $nodeRoot.selectNodes ($objOldNode)
		For $nodeOld In $oldNodes
			$nodeNew = .createNode ($NODE_ELEMENT, $objNewNode, $ns)
			For $nodeTemp In $nodeOld.Attributes
				$nodeNew.Attributes.setNamedItem ($nodeTemp.cloneNode (True))
			Next
			;Copy Child Nodes
			For $nodeTemp In $nodeOld.childNodes
				$nodeNew.appendChild ($nodeTemp)
			Next
			;Replace with the renamed node
			If IsObj($nodeOld.parentNode.replaceChild ($nodeNew, $nodeOld)) Then $bSuccess = 1
			If Not ($objDoc.parseError.errorCode = 0) Then
				_MSXML_Error("_MSXML_ReplaceChild:" & @LF & "Error Replacing Child: " & _
						$objDoc.parseError.errorCode & _
						" " & $objDoc.parseError.reason)
				$bSucess = False
				ExitLoop
			Else
				$bSuccess = True
			EndIf
		Next
		_AddFormat( $objDoc, $NodeNew.parentNode ())
		.save ($MSXMLCURRENTFILE)
	EndWith
	$nodeRoot = 0
	$nodeOld = 0
	$nodeNew = 0
	$nodeTemp = 0
	Return $bSuccess
EndFunc   ;==>_MSXML_ReplaceChild
; #FUNCTION# ===================================================================
; Description ...: Validates a document against a dtd.
; Parameters ....: $sXMLFile - The file to validate
;                  $ns - xml namespace
;                  $sXSDFile - DTD file to validate against.
; Return values .: 1 on success or SetError(errorcode) on failure
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_SchemaValidate($sXMLFile, $ns, $sXSDFile)
	Local $cache, $xmldoc
	$cache = ObjCreate("Msxml2.XMLSchemaCache." & $DOMVERSION & ".0");
	If Not IsObj($cache) Then
		MsgBox(266288, "XML Error", "Unable to instantiate the XML object" & @LF & "Please check your components.")
		Return SetError(-1)
	EndIf
	$cache.add ($ns, $sXSDFile)
	
	$xmldoc = ObjCreate("Msxml2.DOMDocument." & $DOMVERSION & ".0");
	If Not IsObj($xmldoc) Then
		MsgBox(266288, "XML Error", "Unable to instantiate the XML object" & @LF & "Please check your components.")
		Return SetError(-1)
	EndIf
	$xmldoc.async = False;
	$xmldoc.schemas = $cache;
	$xmldoc.load ($sXMLFile);
	
	If Not ($xmldoc.parseError.errorCode = 0) Then
		_MSXML_Error("_MSXML_SchemaValidate:" & @LF & "Error: " & $xmldoc.parseError.errorCode & " " & $xmldoc.parseError.reason);
		Return SetError($xmldoc.parseError.errorCode)
	EndIf
	Return 0
EndFunc   ;==>_MSXML_SchemaValidate
; #FUNCTION# ===================================================================
; Description ...: Returns the version of msxml that is in use for the document.
; Parameters ....: None
; Return values .: msxml version or 0
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_GetDomVersion()
	Return $DOMVERSION
EndFunc   ;==>_MSXML_GetDomVersion
; #FUNCTION# ===================================================================
; Description ...: Sets error message generated by XML functs or Gets the message that was Set.
; Parameters ....: $sError - Error code to set
; Return values .: Nothing or Error message
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Remarks .......: Returns the current error message and clears it if no value is
;                  passed to the function.  It sets the error msg to the value
;                  passed otherwise.
; Related .......: _Notifier, _SetDebug, _DebugWrite
;===============================================================================
Func _MSXML_Error($sError = "")
	If $sError = "" Then
		$sError = $sXML_error
		$sXML_error = ""
		Return $sError
	Else
		$sXML_error = $sError
	EndIf
	_DebugWrite($sXML_error)
EndFunc   ;==>_MSXML_Error
; #INTERNAL# ===================================================================
; Description ...: Dummy function to handle COM Error callback.
; Parameters ....: none
; Return values .: none
; Author ........: 
; Remarks .......: 
; Related .......:
;===============================================================================
Func _COMerr()
	_ComErrorHandler()
	Return
EndFunc   ;==>_COMerr
; #INTERNAL# ===================================================================
; Description ...: Displays a message box with the COM Error.
; Parameters ....: $quiet
; Return values .: Can be one of the following:
;                  [a] - Displays Msgbox with error
;                  [b] - Sets _MSXML_Error and set @error to 1
; Author ........: SvenP 's error handler
; Remarks .......: From the forum this came.
; Related .......:
;===============================================================================
Func _ComErrorHandler($quiet = "")
	Local $COMErr_Silent, $HexNumber
	;===============================================================================
	;added silent switch to allow the func returned to the option to display custom
	;error messages
	If $quiet = True Or $quiet = False Then
		$COMErr_Silent = $quiet
		$quiet = ""
	EndIf
	;===============================================================================
	$HexNumber = Hex($oMyError.number, 8)
	If @error Then Return
	Local $msg = "COM Error with DOM!" & @CRLF & @CRLF & _
			"err.description is: " & @TAB & $oMyError.description & @CRLF & _
			"err.windescription:" & @TAB & $oMyError.windescription & @CRLF & _
			"err.number is: " & @TAB & $HexNumber & @CRLF & _
			"err.lastdllerror is: " & @TAB & $oMyError.lastdllerror & @CRLF & _
			"err.scriptline is: " & @TAB & $oMyError.scriptline & @CRLF & _
			"err.source is: " & @TAB & $oMyError.source & @CRLF & _
			"err.helpfile is: " & @TAB & $oMyError.helpfile & @CRLF & _
			"err.helpcontext is: " & @TAB & $oMyError.helpcontext
	If $COMErr_Silent <> True Then
		MsgBox(0, @AutoItExe, $msg)
	Else
		_MSXML_Error($msg)
	EndIf
	SetError(1)
EndFunc   ;==>_ComErrorHandler
; simple helper functions
; #INTERNAL# ===================================================================
; Description ...: Writes a message to console with a crlf on the end
; Parameters ....: $message - the message to display
;                  $flag    - Flag to append @lf to message
;                  $force   - Force a message to be displayed despite debug setting
; Return values .: 
; Author ........: 
; Remarks .......:
; Related .......: _Notifier, _SetDebug, _MSXML_Error
;===============================================================================
Func _DebugWrite($message, $flag = -1, $force = False)
	If $flag = -1 Then $flag = @LF
	If $debugging Or $force Then
		If $flag <> "" Then
			ConsoleWrite($message & $flag)
		Else
			ConsoleWrite($message)
		EndIf
	EndIf
	
EndFunc   ;==>_DebugWrite
; #INTERNAL# ===================================================================
; Description ...: Displays a simple "ok" messagebox
; Parameters ....: $Notifier_Msg - The message to display
; Return values .: The return value of the Msgbox function.
; Author ........: 
; Remarks .......:
; Related .......: _DebugWrite, _SetDebug, _MSXML_Error
;===============================================================================
Func _Notifier($Notifier_msg)
	Return MsgBox(266288, @ScriptName, $Notifier_msg)
EndFunc   ;==>_Notifier
; #FUNCTION# ===================================================================
; Description ...: Turns debugging messages on/off
; Parameters ....: $debug_flag -  Flag, True for debugging
; Return values .: 
; Author ........: 
; Remarks .......: Debugging if off by default.
; Related .......: _Notifier, _DebugWrite, _MSXML_Error
;===============================================================================
Func _SetDebug($debug_flag = True)
	$debugging = $debug_flag
EndFunc   ;==>_SetDebug
; #FUNCTION# ===================================================================
; Description ...: Returns UDF version number
; Parameters ....: none
; Return values .: Udf version number.
; Author ........: 
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_UDFVersion()
	Return $_MSXML_UDFVER
EndFunc   ;==>_MSXML_UDFVersion
; #FUNCTION# ===================================================================
; Description ...: Performs a xsl transform.
; Parameters ....: $objDoc - The document to transform
;                  $Style - (optional) The stylesheet to use
;                  $szNewDoc - (optional) Save to this file.
; Return values .: Return 1 on success or SetError(1) on failure
; Author ........: Stephen Podhajecki <gehossafats at netmdc dot com>
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_Transform(ByRef $objDoc, $Style = "", $szNewDoc = "")
	Local $bIndented = False
	Local $xslt = ObjCreate("MSXML2.XSLTemplate." & $DOMVERSION & ".0")
	Local $xslDoc = ObjCreate("MSXML2.FreeThreadedDOMDocument." & $DOMVERSION & ".0")
	Local $xmldoc = ObjCreate("MSXML2.DOMDocument." & $DOMVERSION & ".0")
	Local $xslProc
	$xslDoc.async = False
	If FileExists($Style) Then
		_DebugWrite("LoadXML:" & $xslDoc.load ($Style) & @LF);Being a reference to the XSL above
	Else
		_DebugWrite("LoadXML:" & $xslDoc.loadXML (_GetDefaultStyleSheet()) & @LF);Being a reference to the XSL above
	EndIf
	If $xslDoc.parseError.errorCode <> 0 Then
		_MSXML_Error("Error TransformingNodeToObject: " & $xslDoc.parseError.reason)
	EndIf
	If Not FileExists("XSLFile.xsl") Then FileWrite("XSLFile.xsl", $xslDoc.xml ())
	$xslt.stylesheet = $xslDoc
	$xslProc = $xslt.createProcessor ()
	$xslProc.input = $objDoc
	$objDoc.preserveWhiteSpace = True
	$objDoc.transformNodeToObject ($xslDoc, $xmldoc)
	
	If $objDoc.parseError.errorCode <> 0 Then
		_MSXML_Error("_MSXML_Transform:" & @LF & "Error TransformingNodeToObject: " & $objDoc.parseError.reason)
		$bIndented = False
	Else
		$bIndented = True
	EndIf
	
	If $bIndented Then
		If $szNewDoc <> "" Then
			$xmlDoc.save ($szNewDoc)
			If $xmldoc.parseError.errorCode <> 0 Then
				_MSXML_Error("_MSXML_Transform:" & @LF & "Error Saving: " & $xmldoc.parseError.reason)
				$bIndented = False
			EndIf
		Else
			$xmlDoc.save ($MSXMLCURRENTFILE)
			$objDoc.Load ($MSXMLCURRENTFILE)
			If $objDoc.parseError.errorCode <> 0 Then
				_MSXML_Error("_MSXML_Transform:" & @LF & "Error Saving: " & $objDoc.parseError.reason)
				$bIndented = False
			EndIf
		EndIf
	EndIf
	$xslProc = 0
	$xslt = 0
	$xslDoc = 0
	$xmldoc = 0
	Return $bIndented
EndFunc   ;==>_MSXML_Transform
; #INTERNAL# ===================================================================
; Description ...: Internal function, returns the default indenting style sheet
; Parameters ....: 
; Return values .: Stylesheet on success for nothing on failure.
; Author ........: 
; Remarks .......:
; Related .......:
;===============================================================================
Func _GetDefaultStyleSheet()
	Return '<?xml version="1.0" encoding="ISO-8859-1"?>' & _
			'<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">' & _
			'<xsl:output method="xml" indent="yes"/> ' & _
			'<xsl:template match="*">' & _
			'<xsl:copy>' & _
			'<xsl:copy-of select="@*" />' & _
			'<xsl:apply-templates />' & _
			'</xsl:copy>' & _
			'</xsl:template>' & _
			'<xsl:template match="comment()|processing-instruction()">' & _
			'<xsl:copy />' & _
			'</xsl:template>' & _
			'</xsl:stylesheet>'
EndFunc   ;==>_GetDefaultStyleSheet
; #INTERNAL# ===================================================================
; Description ...: Add carriage returns to allow for indentation.
; Parameters ....: $objDoc - Document to format
;                  $objParent - Optional node to add formatting to
; Return values .:
; Author ........: Stephen Podhajecki <gehossafats a t netmdc.com>
; Remarks .......: just break up the tags, no indenting is done here.
; Related .......:
;===============================================================================
Func _AddFormat( $objDoc, $objParent = "")
	$objFormat = $objDoc.createTextNode (@CR)
	If IsObj($objParent) Then
		$objParent.appendChild ($objFormat)
	Else
		$objDoc.documentElement.appendChild ($objFormat)
	EndIf
	$objDoc.Save ($MSXMLCURRENTFILE)
EndFunc   ;==>_AddFormat

Func _MSXML_SaveDoc($objDoc, $strFileName="")
	If $strFileName = "" Then
		$objDoc.Save($MSXMLCURRENTFILE)
	Else
		$objDoc.Save($strFileName)
	EndIf
EndFunc

; #FUNCTION# ===================================================================
; Description ...: Resizes an array and adds a value to the end.
; Parameters ....: $avArray - The array to resize
;                  $sValue  - The value to add.
; Return values .:
; Author ........: Stephen Podhajecki <gehossafats a t netmdc.com>
; Remarks .......:
; Related .......:
;===============================================================================
Func _MSXML_ArrayAdd(ByRef $avArray, $sValue)
	_DebugWrite("sValue="&$sValue)
	If IsArray($avArray) Then
		$iBounds = UBound($avArray)
		ReDim $avArray[ $iBounds+ 1]
		$avArray[$iBounds] = $sValue
		SetError(0)
		Return 1
	Else
		Dim $avArray[1]
	 	 $avArray[0] = $sValue
;~ 		SetError(1)
;~ 		Return 0
	  Return 1
	EndIf
EndFunc   ;==>_MSXML_ArrayAdd
;~ Func TestFunc(ByRef $objDoc, $path)
;~  Return $objDoc.selectSingleNode ($path)
;~ EndFunc   ;==>TestFunc


