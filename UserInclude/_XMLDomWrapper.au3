; =======================================================================
; Project Manager 3.0 Preprocessed - Date 25:04:2007 Time 14:28
; =======================================================================
#include-once
; ------------------------------------------------------------------------------
;
; AutoIt Version: 	3.0
; Language: 		English
; Description: 		Functions that assist with using xml files
;					Stephen Podhajecki <gehossafats@netmdc.com>
; Dec 15, 2005, Update Jan10,2006, Update Feb 5,8,14-15, 2006
; Feb 24, 2006 Updated _XMLCreateCDATA, code cleaned up Gary Frost (custompcs@charter.net)
; Feb 24, 2006 bug fix in re-init COM error handler, rewrote _XMLCreateChildNodeWAttr()
; Jun 20, 2006 Added count to index[0] of the _XMLGetValue return value
; Jun 26, 2006 Changed _XMLCreateFile to include option flag for UTF-8 encoding
; Jun 29, 2006 Added count to index[0] of the _XMLGetValue return
;					Changed _XMLFileOpen and _XMLFileCreate to try latest version first.
; Sep 17, 2006 Small changes
; Mar 30, 2007 Rewrote _AddFormat function to break up tags( no indentation)
;					Added _XMLTransform() which runs the document against a xsl(t) style sheet for indentation.
;					Changed _XMLCreateRootChildWAttr() to use new formatting
;					Changed _XMLChreateChildNode() to use new formatting
; Apr 02, 2007 Added _XMLReplaceChild()
; Apr 03, 2007 Changed other node creating function to use new formatting
;					Changed _XMLFileOpen() _XMLFileCreate to take an optional version number of MSXML to use.
;					Changed _XMLFileOpen() _XMLFileCreate find latest MSXML version logic.
; Apr 24, 2007 Fixed _XMLCreateChileNodeWAttr() - Instead of removal, It points to the function that replaced it.
; Apr 25, 2007 Added _XMLCreateAttrib()
;					Fixed bug with _XMLCreateRootNodeWAttr , _XMLCreateChild[Node]WAttr() where an extra node with same name was added.
;					Stripped extrenous comments.
;					Removed dependency on Array.au3 (I added the func from Array.au3 and renamed it to avoid conflicts.)
; May 03, 2007	Changed method of msxml version lookup.  Updated api call tips.
; May 11, 2007 Fixed missing \
; Jun 08, 2007 Fixed Namespace issue with _XMLCreateChildNode() and _XMLCreateChildNodeWAttr()
; Jun 12, 2007 Added workaround for MSXML6 to parse file with DTD's
; Jun 13, 2007 Fixed bug in _XMLGetField() where all text was returned in one node.
;						Actually this is not a bug, because it is the way that WC3 says it will be returned
;						However, it will now return in a way that is expected.
;					_XMLGetValue now returns just the text associated with the node or empty string.
; Jul 20, 2007 Fixed bug where failure to open the xml file would return an empty xml object, it now returns 0(no object).
;					Added object check to all applicable functions.				
; ------------------------------------------------------------------------------
;===============================================================================
; XML DOM Wrapper functions
;
; These funtions require BETA as they need support for COM
;
;===============================================================================
#cs defs to add to au3.api
	_XMLCreateFile($sPath, $sRootNode, [$bOverwrite = False]) Creates an XML file with the given name and root.(Requires: #include <_XMLDomWrapper.au3>)
	_XMLFileOpen($sXMLFile,[$sNamespace=""],[$ver=-1]) Creates an instance of an XML file.(Requires: #include <_XMLDomWrapper.au3>)
	;==============================================================================
	_XMLGetChildNodes ( strXPath ) Selects XML child Node(s) of an element based on XPath input from root node. (Requires: #include <_XMLDomWrapper.au3>)
	_XMLGetNodeCount ( strXPath, strQry = "", iNodeType = 1 ) Get node count for specified path and type. (Requires: #include <_XMLDomWrapper.au3>)
	_XMLGetPath ( strXPath ) Returns a nodes full path based on XPath input from root node. (Requires: #include <_XMLDomWrapper.au3>)
	;==============================================================================
	_XMLSelectNodes ( strXPath ) Selects XML Node(s) based on XPath input from root node. (Requires: #include <_XMLDomWrapper.au3>)
	_XMLGetField ( strXPath ) Get XML Field(s) based on XPath input from root node.(Requires: #include <_XMLDomWrapper.au3>)
	_XMLGetValue ( strXPath ) Get XML Field based on XPath input from root node. (Requires: #include <_XMLDomWrapper.au3>)
	_XMLGetChildText ( strXPath ) Selects XML child Node(s) of an element based on XPath input from root node. (Requires: #include <_XMLDomWrapper.au3>)
	_XMLUpdateField ( strXPath, strData ) Update existing node(s) based on XPath specs.(Requires: #include <_XMLDomWrapper.au3>)
	_XMLReplaceChild ( objOldNode, objNewNode, ns = "" ) Replaces a node with a new node. (Requires: #include <_XMLDomWrapper.au3>)
	;==============================================================================
	_XMLDeleteNode ( strXPath ) Delete specified XPath node.(Requires: #include <_XMLDomWrapper.au3>)
	_XMLDeleteAttr ( strXPath, strAttrib ) Delete attribute for specified XPath(Requires: #include <_XMLDomWrapper.au3>)
	_XMLDeleteAttrNode ( strXPath, strAttrib ) Delete attribute node for specified XPath(Requires: #include <_XMLDomWrapper.au3>)
	;==============================================================================
	_XMLGetAttrib ( strXPath, strAttrib, strQuery = "" ) Get XML attribute based on XPath input from root node.(Requires: #include <_XMLDomWrapper.au3>)
	_XMLGetAllAttrib ( strXPath, ByRef aName, ByRef aValue, strQry = "" ) Get all XML Field(s) attributes based on XPath input from root node.(Requires: #include <_XMLDomWrapper.au3>)
	_XMLGetAllAttribIndex ( strXPath, ByRef aName, ByRef aValue, strQry = "", NodeIndex = 0 ) Get all XML Field(s) attributes based on Xpathn and specific index.(Requires: #include <_XMLDomWrapper.au3>)
	_XMLSetAttrib ( strXPath, strAttrib, strValue = "" ) Set XML Field(s) attributes based on XPath input from root node.(Requires: #include <_XMLDomWrapper.au3>)
	;==============================================================================
	_XMLCreateCDATA ( strNode, strCDATA, strNameSpc = "" ) Create a CDATA SECTION node directly under root. (Requires: #include <_XMLDomWrapper.au3>)
	_XMLCreateComment ( strNode, strComment ) Create a COMMENT node at specified path.(Requires: #include <_XMLDomWrapper.au3>)
	_XMLCreateAttrib ( strXPath,strAttrName,strAttrValue="" ) Creates an attribute for the specified node. (Requires: #include <_XMLDomWrapper.au3>)
	;==============================================================================
	_XMLCreateRootChild ( strNode, strData = "", strNameSpc = "" ) Create node directly under root.(Requires: #include <_XMLDomWrapper.au3>)
	_XMLCreateRootNodeWAttr ( strNode, aAttr, aVal, strData = "", strNameSpc = "" ) Create a child node under root node with attributes.(Requires: #include <_XMLDomWrapper.au3>)
	_XMLCreateChildNode ( strXPath, strNode, strData = "", strNameSpc = "" )  Create a child node under the specified XPath Node.(Requires: #include <_XMLDomWrapper.au3>)
	_XMLCreateChildWAttr ( strXPath, strNode, aAttr, aVal, strData = "", strNameSpc = "" ) Create a child node under the specified XPath Node with Attributes. (Requires: #include <_XMLDomWrapper.au3>)
	;==============================================================================
	_XMLSchemaValidate ( sXMLFile, ns, sXSDFile ) 	_XMLSchemaValidate($sXMLFile, $ns, $sXSDFile) Validate a document against a DTD. (Requires: #include <_XMLDomWrapper.au3>)
	_XMLGetDomVersion (  ) Returns the XSXML version currently in use. (Requires: #include <_XMLDomWrapper.au3>)
	_XMLError ( sError = "" ) Sets or Gets XML error message generated by XML functions.(Requires: #include <_XMLDomWrapper.au3>)
	_XMLUDFVersion (  ) eturns the UDF Version number. (Requires: #include <_XMLDomWrapper.au3>)
	_XMLTransform ( oXMLDoc, Style = "",szNewDoc="" ) Transfroms the document using built-in sheet or xsl file passed to function. (Requires: #include <_XMLDomWrapper.au3>)
#ce
;===============================================================================
;Global variables
Global Const $_XMLUDFVER = "1.0.3.71"
Global Const $NODE_ELEMENT = 1
Global Const $NODE_ATTRIBUTE = 2
Global Const $NODE_TEXT = 3
Global Const $NODE_CDATA_SECTION = 4
Global Const $NODE_ENTITY_REFERENCE = 5
Global Const $NODE_ENTITY = 6
Global Const $NODE_PROCESSING_INSTRUCTION = 7
Global Const $NODE_COMMENT = 8
Global Const $NODE_DOCUMENT = 9
Global Const $NODE_DOCUMENT_TYPE = 10
Global Const $NODE_DOCUMENT_FRAGMENT = 11
Global Const $NODE_NOTATION = 12
Global $strFile
Global $objDoc
Global $oMyError ;COM error handler OBJ ; Initialize SvenP 's error handler
Global $sXML_error
Global $debugging
Global $DOMVERSION = -1
;===============================================================================
;UDF functions
;===============================================================================
; Function Name:	 _XMLFileOpen
; Description:		Creates an instance of an XML file.
; Parameters:		$filename
; Syntax:			 _XMLFileOpen($strFile)
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			1 on success -1 on failure set error 2 = no obj or
;													error= parse error
;===============================================================================
Func _XMLFileOpen($strXMLFile, $strNameSpc = "", $ver = -1, $bValOnParse = True)
	;==== pick your poison
	If $ver <> -1 Then
		If $ver > -1 And $ver < 7 Then
			$objDoc = ObjCreate("Msxml2.DOMDocument." & $ver & ".0")
			If IsObj($objDoc) Then
				$DOMVERSION = $ver
			EndIf
		Else
			MsgBox(266288, "Error:", "Failed to create object with MSXML version " & $ver)
			SetError(1)
			Return 0
		EndIf
	Else
		For $x = 8 To 0 Step - 1
			If FileExists(@SystemDir & "\msxml" & $x & ".dll") Then
				$objDoc = ObjCreate("Msxml2.DOMDocument." & $x & ".0")
				If IsObj($objDoc) Then
					$DOMVERSION = $x
					ExitLoop
				EndIf
			EndIf
		Next
	EndIf
	If Not IsObj($objDoc) Then
		_XMLError("Error: MSXML not found. This object is required to use this program.")
		SetError(2)
		Return -1
	EndIf
	If $oMyError <> "" Then $oMyError = ""
	$oMyError = ObjEvent("AutoIt.Error", "_COMerr") ; ; Initialize SvenP 's error handler
	$objDoc.async = False
	$objDoc.preserveWhiteSpace = True
	$strFile = $strXMLFile
	$objDoc.validateOnParse = $bValOnParse
	if $DOMVERSION > 4 Then $objDoc.setProperty ("ProhibitDTD",false)
	$objDoc.Load ($strFile)
	$objDoc.setProperty ("SelectionNamespaces", $strNameSpc)
	$objDoc.setProperty ("SelectionLanguage", "XPath")
	If $objDoc.parseError.errorCode <> 0 Then
		_XMLError("Error opening specified file: " & $strXMLFile & @CRLF & $objDoc.parseError.reason)
		SetError($objDoc.parseError.errorCode)
		$objDoc = 0
		Return -1
	EndIf
	Return $objDoc
EndFunc   ;==>_XMLFileOpen
;===============================================================================
; Function Name:	_XMLCreateFile
; Description:		Create a new blank metafile with header.
; Parameters:		$filename	The xml filename with full path to create
;					$root		The root of the xml file to create
;					[overwrite] boolean flag to auto overwrite existing
;								xml file of same name. Defaults to false and
;								will prompt to overwrite.
;								Overwrite copies the file with the ext .old
;								Then deletes the original file.
;					[UTF-8] boolean flag to specify UTF-8 encoding in header.
; Syntax:			_XMLCreateFile($filename,$root,[flag]) flag is boolean
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			-1 on failure,
;===============================================================================
Func _XMLCreateFile($strPath, $strRoot, $bOverwrite = False, $bUTF8 = False, $ver = -1)
	Local $retval, $fe, $objPI, $objDoc, $rootElement
	$fe = FileExists($strPath)
	If $fe And Not $bOverwrite Then
		$retval = (MsgBox(4097, "File Exists:", "The specified file exits." & @CRLF & "Click OK to overwrite file or cancel to exit."))
		If $retval = 1 Then
			FileCopy($strPath, $strPath & @YEAR & "-" & @MON & "-" & @MDAY & "_" & @HOUR & "-" & @MIN & "-" & @SEC & ".bak", 1)
			FileDelete($strPath)
			$fe = False
		Else
			_XMLError("Error failed to create file: " & $strPath & @CRLF & "File exists.")
			SetError(1)
			Return -1
		EndIf
	Else
		FileCopy($strPath, $strPath & ".old", 1)
		FileDelete($strPath)
		$fe = False
	EndIf
	If $fe = False Then
		If $ver <> -1 Then
			If $ver > -1 And $ver < 7 Then
				$objDoc = ObjCreate("Msxml2.DOMDocument." & $ver & ".0")
				If IsObj($objDoc) Then
					$DOMVERSION = $ver
				EndIf
			Else
				MsgBox(266288, "Error:", "Failed to create object with MSXML version " & $ver)
				SetError(1)
				Return 0
			EndIf
		Else
			For $x = 8 To 0 Step - 1
				If FileExists(@SystemDir & "\msxml" & $x & ".dll") Then
					$objDoc = ObjCreate("Msxml2.DOMDocument." & $x & ".0")
					If IsObj($objDoc) Then
						$DOMVERSION = $x
						ExitLoop
					EndIf
				EndIf
			Next
		EndIf
		If Not IsObj($objDoc) Then
			Return SetError(1)
		EndIf
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
			_XMLError("Error Creating specified file: " & $strPath)
			SetError($objDoc.parseError.errorCode)
			Return -1
		EndIf
		Return 1
	Else
		_XMLError("Error! Failed to create file: " & $strPath)
		SetError(1)
		Return -1
	EndIf
	Return 1
EndFunc   ;==>_XMLCreateFile
;===============================================================================
; Function Name:	_XMLSelectNodes
; Description:		Selects XML Node(s) based on XPath input from root node.
; Parameters:		$path	xml tree path from root node (root/child/child..)
; Syntax:			_XMLDeleteNode($path)
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			array of Nodes(count is in first element) or -1 on failure
;===============================================================================
Func _XMLSelectNodes($strXPath)
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLSelectNodes")
		Return SetError(-1,1,0)
	EndIf
	Local $objNode, $objNodeList, $arrResponse[1], $xmlerr
	$objNodeList = $objDoc.selectNodes ($strXPath)
	While @error = 0
		If Not IsObj($objNode) Then $xmlerr = @CRLF & "No Matching Nodes found"
		For $objNode In $objNodeList
			_XMLArrayAdd($arrResponse, $objNode.nodeName)
		Next
		$arrResponse[0] = $objNodeList.length
		Return $arrResponse
	WEnd
	_XMLError("Error Selecting Node(s): " & $strXPath & $xmlerr)
	SetError(1)
	Return -1
EndFunc   ;==>_XMLSelectNodes

;===============================================================================
; Function Name:	_XMLGetField
; Description:		Get XML Field(s) based on XPath input from root node.
; Parameters:		$path	xml tree path from root node (root/child/child..)
; Syntax:			_XMLGetField($path)
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			array of fields text values(count is in first element), -1 on failure
;===============================================================================
Func _XMLGetField($strXPath)
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLGetField")
		Return SetError(1,2,-1)
	EndIf
	
	Local $objNodeList, $arrResponse[1], $xmlerr, $szNodePath , _
		$objChild, $aRet
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
					
					$aRet = _XMLGetValue($szNodePath)
					If IsArray($aRet) Then
						If UBound($aRet) > 1 Then
							_XMLArrayAdd($arrResponse, $aRet[1])
							_DebugWrite("GetField>Text:" & $aRet[1])
						EndIf
					Else
						_XMLArrayAdd($arrResponse, "")
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
	_XMLError("Error Selecting Node(s): " & $strXPath & $xmlerr)
	SetError(1)
	Return -1
EndFunc   ;==>_XMLGetField
;===============================================================================
; Function Name: _XMLGetValue
; Description: Get XML values based on XPath input from root node.
; Parameters: $path xml tree path from root node (root/child/child..)
; Syntax: _XMLGetValue($path)
; Author(s): Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:  The an array of text values(count in first element), or -1 on failure
;===============================================================================
Func _XMLGetValue($strXPath)
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLGetValue")
		Return SetError(1,3,-1)
	EndIf
	Local $objNodeList, $arrResponse[1], $objNodeChild, $xmlerr
	While @error = 0
		_DebugWrite("GetValue>$strXPath:"&$strXPath)
		$objNodeList = $objDoc.documentElement.selectNodes ($strXPath)
		If $objNodeList.length > 0 Then
			_DebugWrite("GetValue list length:" & $objNodeList.length)
			For $objNode In $objNodeList
				If $objNode.hasChildNodes () = False Then
					_XMLArrayAdd($arrResponse, $objNode.nodeValue)
				Else
					For $objNodeChild In $objNode.childNodes ()
						If $objNodeChild.nodeType = $NODE_CDATA_SECTION Then
							_XMLArrayAdd($arrResponse, $objNodeChild.data)
							_DebugWrite("GetValue>CData:" & $objNodeChild.data)
						ElseIf $objNodeChild.nodeType = $NODE_TEXT Then
							_XMLArrayAdd($arrResponse, $objNodeChild.Text)
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
	_XMLError("Error Retrieving: " & $strXPath & $xmlerr)
	SetError(1)
	Return -1
EndFunc   ;==>_XMLGetValue
;===============================================================================
; Function Name:	_XMLDeleteNode
; Description:		Deletes XML Node based on XPath input from root node.
; Parameters:		$path	xml tree path from root node (root/child/child..)
; Syntax:			_XMLDeleteNode($path)
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			returns -1 on error/ failure.
;===============================================================================
Func _XMLDeleteNode($strXPath)
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLDeleteNode")
		Return SetError(1,4,-1)
	EndIf
	Local $objNode, $xmlerr
	$objNode = $objDoc.selectSingleNode ($strXPath)
	If Not IsObj($objNode) Then $xmlerr = @CRLF & "Node Not found"
	While @error = 0
		$objNode.parentNode.removeChild ($objNode)
		$objDoc.save ($strFile)
		Return 0
	WEnd
	_XMLError("Error Deleting Node: " & $strXPath & $xmlerr)
	SetError(1)
	Return -1
EndFunc   ;==>_XMLDeleteNode
;===============================================================================
; Function Name:	_XMLDeleteAttr
; Description:		Delete XML Attribute based on XPath input from root node.
; Parameters:		$path xml tree path from root node (root/child/child..)
;					$attribute The attribute node to delete
; Syntax:			_XMLDeleteAttr($path,$attribute)
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			-1 on error and set error to 1
;===============================================================================
Func _XMLDeleteAttr($strXPath, $strAttrib)
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLDeleteAttr")
		Return SetError(1,5,-1)
	EndIf
Local $objNode, $objAttr, $xmlerr
	$objNode = $objDoc.selectSingleNode ($strXPath)
	While @error = 0 And IsObj($objNode)
		$objAttr = $objNode.getAttributeNode ($strAttrib)
		If Not (IsObj($objAttr)) Then
			$xmlerr = "Attribute " & $strAttrib & " does not exist!"
			ExitLoop
		EndIf
		$objAttr = $objNode.removeAttribute ($strAttrib)
		$objDoc.save ($strFile)
		Return
	WEnd
	_XMLError("Error Removing Attribute: " & $strXPath & " - " & $strAttrib & @CRLF & $xmlerr)
	$xmlerr = ""
	SetError(1)
	Return -1
EndFunc   ;==>_XMLDeleteAttr
;===============================================================================
; Function Name:	_XMLDeleteAttrNode
; Description:		Delete XML Attribute node based on XPath input from root node.
; Parameters:		$path xml tree path from root node (root/child/child..)
;					$attribute The attribute node to delete
; Syntax:			_XMLDeleteAttrNode($path,$attribute)
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			-1 on error and set error to 1
;===============================================================================
Func _XMLDeleteAttrNode($strXPath, $strAttrib)
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLDeleteAttrNode")
		Return SetError(1,6,-1)
	EndIf
	Local $objNode, $objAttr, $xmlerr
	$objNode = $objDoc.selectSingleNode ($strXPath)
	If Not IsObj($objNode) Then
		$xmlerr = @CRLF & "Specified node not found!"
	Else
		While @error = 0
			$objAttr = $objNode.removeAttributeNode ($objNode.getAttributeNode ($strAttrib))
			$objDoc.save ($strFile)
			If Not (IsObj($objAttr)) Then
				$xmlerr = @CRLF & "Unspecified error:!"
				ExitLoop
			EndIf
			Return
		WEnd
	EndIf
	_XMLError("Error Removing Attribute Node: " & $strXPath & " - " & $strAttrib & $xmlerr)
	SetError(1)
	Return -1
EndFunc   ;==>_XMLDeleteAttrNode
;===============================================================================
; Function Name:	_XMLGetAttrib
; Description:		Get XML Field(s) based on XPath input from root node.
; Parameters:		$path	xml tree path from root node (root/child/child..)
; Syntax:			_XMLGetAttrib($path,$attrib)
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			array of fields text values
;					on error set error to 1 and returns -1
;===============================================================================
Func _XMLGetAttrib($strXPath, $strAttrib, $strQuery = "")
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLGetAttrib")
		Return SetError(1,7,-1)
	EndIf
	Local $objNodeList, $arrResponse[1], $i, $xmlerr, $objAttr
	$objNodeList = $objDoc.documentElement.selectNodes ($strXPath & $strQuery)
	_DebugWrite("Get Attrib length= " & $objNodeList.length)
	While @error = 0
		If $objNodeList.length > 0 Then
			ReDim $arrResponse[$objNodeList.length]
			For $i = 0 To $objNodeList.length - 1
				$objAttr = $objNodeList.item ($i).getAttribute ($strAttrib)
				$arrResponse = $objAttr
				_DebugWrite("RET>>" & $objAttr)
			Next
			Return $arrResponse
		Else
			$xmlerr = @CRLF & "No qualified items found"
			ExitLoop
		EndIf
	WEnd
	_XMLError("Attribute " & $strAttrib & " not found for: " & $strXPath & $xmlerr)
	SetError(1)
	Return -1
	;	EndIf
EndFunc   ;==>_XMLGetAttrib
;===============================================================================
; Function Name:	_XMLSetAttrib
; Description:		Set XML Field(s) based on XPath input from root node.
; Parameters:		$path xml tree path from root node (root/child/child..)
;					$attrib the attribute to set.
;					$value the value to give the attribute defaults to ""
; Syntax:			_XMLSetAttrib($path,$attrib,$value)
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			array of fields text values
;					on error returns -1 and sets error to 1
;===============================================================================
Func _XMLSetAttrib($strXPath, $strAttrib, $strValue = "")
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLSetAttrib")
		Return SetError(1,8,-1)
	EndIf
	Local $objNodeList, $arrResponse[1], $i
	$objNodeList = $objDoc.selectNodes ($strXPath)
	_DebugWrite(" Node list Length: " & $objNodeList.length)
	While @error = 0 And $objNodeList.length > 0
		ReDim $arrResponse[$objNodeList.length]
		For $i = 0 To $objNodeList.length - 1
			$arrResponse[$i] = $objNodeList.item ($i).SetAttribute ($strAttrib, $strValue)
		Next
		$objDoc.save ($strFile)
		Return $arrResponse
	WEnd
	_XMLError("Error failed to set attribute for: " & $strXPath & @CRLF)
	SetError(1)
	Return -1
EndFunc   ;==>_XMLSetAttrib
;===============================================================================
; Function Name:	_XMLGetAllAttrib
; Description:		Get all XML Field(s) attributes based on XPath input from root node.
; Parameters:		$path	xml tree path from root node (root/child/child..)
;					$query the query string in xml format
;					$names the array to return the attrib names
;					$value the array to return the attrib values
;					[$query] DOM compliant query string (not really necessary as it becomes
;part of the path
; Syntax:			_XMLGetAllAttrib($path,$query)
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			array of fields text values(number of items is in [0][0]
;					on error set error to 1 and returns -1
;===============================================================================
Func _XMLGetAllAttrib($strXPath, ByRef $aName, ByRef $aValue, $strQry = "")
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLGetAllAttrib")
		Return SetError(1,9,-1)
	EndIf
	Local $objNodeList, $objQueryNodes, $objNode, $arrResponse[2][1], $i
	$objQueryNodes = $objDoc.selectNodes ($strXPath & $strQry)
	While @error = 0 And $objQueryNodes.length > 0
		For $objNode In $objQueryNodes
			$objNodeList = $objNode.attributes
			If ($objNodeList.length) Then
				_DebugWrite("Get all attrib " & $objNodeList.length)
				ReDim $arrResponse[2][$objNodeList.length + 2]
				ReDim $aName[$objNodeList.length]
				ReDim $aValue[$objNodeList.length]
				For $i = 0 To $objNodeList.length - 1
					$arrResponse[0][$i + 1] = $objNodeList.item ($i).nodeName
					$arrResponse[1][$i + 1] = $objNodeList.item ($i).Value
					$aName[$i] = $objNodeList.item ($i).nodeName
					$aValue[$i] = $objNodeList.item ($i).Value
				Next
			Else
				SetError(1)
				ExitLoop
			EndIf
		Next
		$arrResponse[0][0] = $objNodeList.length
		Return $arrResponse
	WEnd
	_XMLError("Error retrieving attributes for: " & $strXPath & @CRLF)
	SetError(1)
	Return -1
	;	EndIf
EndFunc   ;==>_XMLGetAllAttrib
;===============================================================================
; Function Name:	_XMLUpdateField
; Description:		Update existing node(s) based on XPath specs.
; Parameters:		$path	Path from root node
;					$new_data	Data to update node with
; Syntax:			_XMLUpdateField($path,$new_data)
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			on error set error to 1 and returns -1
;===============================================================================
Func _XMLUpdateField($strXPath, $strData)
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLUpdateField")
		Return SetError(1,9,-1)
	EndIf
	Local $objField, $objNodeList
	#forceref $objField
	While @error = 0
		$objNodeList = $objDoc.selectNodes ($strXPath)
		If IsObj($objNodeList) And $objNodeList.length > 0 Then
			For $objField In $objNodeList
				$objField.Text = $strData
			Next
			$objDoc.Save ($strFile)
			$objField = ""
			Return
		Else
			ExitLoop
		EndIf
	WEnd
	_XMLError("Failed to update field for: " & $strXPath & @CRLF)
	SetError(1)
	Return -1
	;	EndIf
EndFunc   ;==>_XMLUpdateField
;===============================================================================
; Function Name: _XMLCreateCDATA
; Description: Create a CDATA SECTION node directly under root.
; Parameters: $node name of node to create
; $data CDATA value
; Syntax: _XMLCreateCDATA($node,$data)
; Author(s): Stephen Podhajecki <gehossafats@netmdc.com>
; Returns: on error set error to 1 and returns -1
; fixme, won't append to exisiting node. must create new node.
;===============================================================================
Func _XMLCreateCDATA($strNode, $strCDATA, $strNameSpc = "")
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLCreateCDATA")
		Return SetError(1,10,-1)
	EndIf
	Local $objChild, $objNode
	While @error = 0
		$objNode = $objDoc.createNode ($NODE_ELEMENT, $strNode, $strNameSpc)
		If Not ($objNode.hasChildNodes ()) Then
			_AddFormat($objDoc, $objNode)
		EndIf
		$objChild = $objDoc.createCDATASection ($strCDATA)
		$objNode.appendChild ($objChild)
		$objDoc.documentElement.appendChild ($objNode)
		$objDoc.Save ($strFile)
		_AddFormat($objDoc)
		$objChild = ""
		Return
	WEnd
	_XMLError("Failed to create CDATA Section: " & $strNode & @CRLF)
	SetError(1)
	Return -1
EndFunc   ;==>_XMLCreateCDATA
;===============================================================================
; Function Name:	_XMLCreateComment
; Description:		Create a COMMENT node at specified path.
; Parameters:		$node	name of node to create
;					$comment the comment to add the to the xml file
; Syntax:			_XMLCreateComment($node,$comment)
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			on error set error to 1 and returns -1
;===============================================================================
Func _XMLCreateComment($strNode, $strComment)
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLCreateComment")
		Return SetError(1,11,-1)
	EndIf
	Local $objChild, $objNode
	While @error = 0
		$objNode = $objDoc.selectSingleNode ($strNode)
		If Not ($objNode.hasChildNodes ()) Then
			_AddFormat($objDoc, $objNode)
		EndIf
		$objChild = $objDoc.createComment ($strComment)
		$objNode.insertBefore ($objChild, $objNode.childNodes (0))
		$objDoc.Save ($strFile)
		_AddFormat($objDoc)
		$objChild = ""
		Return 1
	WEnd
	_XMLError("Failed to root child: " & $strNode & @CRLF)
	SetError(1)
	Return -1
EndFunc   ;==>_XMLCreateComment
;===============================================================================
; Function Name:	_XMLCreateAttribute
; Description:
; Parameters:		$strXPath xml tree path from root node (root/child/child..)
;						$strAttrName the attribute to set.
;						$strAttrValue the value to give the attribute defaults to ""
; Syntax:			 _XMLCreateAttrib($strXPath,$strAttrName,$strAttrValue="")
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			1 on success, 0 on error
;===============================================================================
Func _XMLCreateAttrib($strXPath, $strAttrName, $strAttrValue = "")
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLCreateAttrib")
		Return SetError(1,12,-1)
	EndIf
	Local $objNode, $objAttr, $objAttrVal, $err
	$objNode = $objDoc.selectSingleNode ($strXPath)
	If IsObj($objNode) Then
		$objAttr = $objDoc.createAttribute ($strAttrName);, $strNameSpc)
		$objNode.SetAttribute ($strAttrName, $strAttrValue)
		$objDoc.save ($strFile)
		$objAttr = 0
		$objAttrVal = 0
		$objNode = 0
		$err = $objDoc.parseError.errorCode
		If $err = 0 Then Return 1
	EndIf
	_XMLError("Error creating Attribute: " & $strAttrName & @CRLF & $strXPath & " does not exist." & @CRLF)
	Return 0
EndFunc   ;==>_XMLCreateAttrib
;===============================================================================
; Function Name:	_XMLCreateRootChild
; Description:		Create node directly under root.
; Parameters:		$node	name of node to create
;					$value optional value to create
; Syntax:			_XMLCreateRootChild($node,[$value])
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			on error set error to 1 and returns -1
;===============================================================================
Func _XMLCreateRootChild($strNode, $strData = "", $strNameSpc = "")
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLCreateRootChild")
		Return SetError(1,14,-1)
	EndIf
	Local $objChild
	If Not ($objDoc.documentElement.hasChildNodes ()) Then
		_AddFormat($objDoc)
	EndIf
	$objChild = $objDoc.createNode ($NODE_ELEMENT, $strNode, $strNameSpc)
	If $strData <> "" Then $objChild.text = $strData
	While @error = 0
		$objDoc.documentElement.appendChild ($objChild)
		$objDoc.Save ($strFile)
		_AddFormat($objDoc)
		$objChild = 0
		Return
	WEnd
	_XMLError("Failed to root child: " & $strNode & @CRLF)
	SetError(1)
	Return -1
EndFunc   ;==>_XMLCreateRootChild
;===============================================================================
; Function Name:	_XMLCreateRootNodeWAttr
; Description:		Create a child node under root node with attributes.
; Parameters:		$node node to add with attibute(s)
;					$[array]attrib attribute name(s) -- can be array
;					$[array]value	attribute value(s) -- can be array
;					$data 	optional value to give the node.
; Requirements		This function requires that each attribute name has
;					a corresponding value.
; Syntax:			_XMLCreateRootNodeWAttr($node,$array_attribs,$array_value)
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			on error set error to 1 or 2 and returns -1
;===============================================================================
Func _XMLCreateRootNodeWAttr($strNode, $aAttr, $aVal, $strData = "", $strNameSpc = "")
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLCreateRootNodeWAttr")
		Return SetError(1,15,-1)
	EndIf
	Local $objChild, $objAttr, $objAttrVal
	$objChild = $objDoc.createNode ($NODE_ELEMENT, $strNode, $strNameSpc)
	If $strData <> "" Then $objChild.text = $strData
	If Not ($objDoc.documentElement.hasChildNodes ()) Then
		_AddFormat($objDoc)
	EndIf
	While @error = 0
		If IsArray($aAttr) And IsArray($aVal) Then
			If UBound($aAttr) <> UBound($aVal) Then
				_XMLError("Attribute and value mismatch" & @CRLF & "Please make sure each attribute has a matching value.")
				SetError(2)
				Return -1
			Else
				Local $i
				For $i = 0 To UBound($aAttr) - 1
					If $aAttr[$i] = "" Then
						_XMLError("Error creating child node: " & $strNode & @CRLF & " Attribute Name Cannot be NULL." & @CRLF)
						SetError(1)
						Return -1
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
		$objDoc.Save ($strFile)
		_AddFormat($objDoc)
		$objChild = 0
		Return
	WEnd
	_XMLError("Failed to create root child with attributes: " & $strNode & @CRLF)
	SetError(1)
	Return -1
EndFunc   ;==>_XMLCreateRootNodeWAttr
;===============================================================================
; Function Name:	_XMLCreateChildNode
; Description:		Create a child node under the specified XPath Node.
; Parameters:		$path	Path from root
;					$node	Node to add
; Syntax:			_XMLCreateChildNode($path,$node)
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			on error set error to 1 and returns -1
;===============================================================================
Func _XMLCreateChildNode($strXPath, $strNode, $strData = "", $strNameSpc = "")
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLCreateChildNode")
		Return SetError(1,16,-1)
	EndIf
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
			$objDoc.Save ($strFile)
			$objParent = ""
			$objChild = ""
			Return
		Else
			ExitLoop
		EndIf
	WEnd
	_XMLError("Error creating child node: " & $strNode & @CRLF & $strXPath & " does not exist." & @CRLF)
	SetError(1)
	Return -1
EndFunc   ;==>_XMLCreateChildNode
;===============================================================================
; Function Name:	_XMLCreateChildNodeWAttr
; Description:		Create a child node(s) under the specified XPath Node with attributes.
; Parameters:		$sPath Path from root
; 					$sNode node to add with attibute(s)
;					$[array]attrib attribute name(s) -- can be array
;					$[array]value	attribute value(s) -- can be array
;					$data 			Optional value to give the child node.
; Requirements		This function requires that each attribute name has
;					a corresponding value.
; Syntax:			_XMLCreateChildNodeWAttr($path,$node,$[array]attrib,$]array]value)
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			0 on error and set error 1 or 2
;===============================================================================
Func _XMLCreateChildNodeWAttr($strXPath, $strNode, $aAttr, $aVal, $strData = "", $strNameSpc = "")
	Return _XMLCreateChildWAttr($strXPath, $strNode, $aAttr, $aVal, $strData, $strNameSpc)
EndFunc   ;==>_XMLCreateChildNodeWAttr
;===============================================================================
; Function Name:	_XMLCreateChildWAttr
; Description:		Create a child node(s) under the specified XPath Node with attributes.
; Parameters:		$sPath Path from root
; 					$sNode node to add with attibute(s)
;					$[array]attrib attribute name(s) -- can be array
;					$[array]value	attribute value(s) -- can be array
;					$data 			Optional value to give the child node.
; Requirements		This function requires that each attribute name has
;					a corresponding value.
; Syntax:			_XMLCreateChildWAttr($path,$node,$[array]attrib,$]array]value)
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			0 on error and set error 1 or 2
;===============================================================================
Func _XMLCreateChildWAttr($strXPath, $strNode, $aAttr, $aVal, $strData = "", $strNameSpc = "")
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLCreateChildWAttr")
		Return SetError(1,18,-1)
	EndIf
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
						_XMLError("Attribute and value mismatch" & @CRLF & "Please make sure each attribute has a matching value.")
						SetError(2)
						Return -1
					Else
						Local $i
						For $i = 0 To UBound($aAttr) - 1
							_DebugWrite("Entering inside for")
							If $aAttr[$i] = "" Then
								_XMLError("Error creating child node: " & $strNode & @CRLF & " Attribute Name Cannot be NULL." & @CRLF)
								SetError(1)
								Return -1
							EndIf
							_DebugWrite($aAttr[$i] & " " & $strNameSpc)
							$objAttr = $objDoc.createAttribute ($aAttr[$i]);, $strNameSpc)
							If @error Then ExitLoop
							$objChild.SetAttribute ($aAttr[$i], $aVal[$i])
							If @error <> 0 Then
								_XMLError("Error creating child node: " & $strNode & @CRLF & $strXPath & " does not exist." & @CRLF)
								SetError(1)
								Return -1
							EndIf
							_DebugWrite("Looping inside for")
						Next
					EndIf
				Else
					If IsArray($aAttr) Or IsArray($aVal) Then
						_XMLError("Type non-Array and Array detected" & @LF)
						SetError(1)
						Return -1
					EndIf
					If $aAttr = "" Then
						_XMLError("Attribute Name cannot be empty string." & @LF)
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
			$objDoc.Save ($strFile)
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
	_XMLError("Error creating child node: " & $strNode & @CRLF & $strXPath & " does not exist." & @CRLF)
	SetError(1)
	Return -1
EndFunc   ;==>_XMLCreateChildWAttr
;===============================================================================
; Function Name:	_XMLGetChildText
; Description:		Selects XML child Node(s) of an element based on XPath input from root node.
; Parameters:		$path	xml tree path from root node (root/child/child..)
; Syntax:			_XMLGetChildText($path)
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			array of Nodes or -1 on failure
;===============================================================================
Func _XMLGetChildText($strXPath)
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLGetChildText")
		Return SetError(1,19,-1)
	EndIf
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
					_XMLArrayAdd($arrResponse, $objChild.baseName)
				ElseIf $objChild.nodeType = $NODE_TEXT Then
					_XMLArrayAdd($arrResponse, $objChild.text)
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
	_XMLError("Error Selecting Node(s): " & $strXPath & $xmlerr)
	SetError(1)
	Return -1
EndFunc   ;==>_XMLGetChildText
;===============================================================================
; Function Name:	_XMLGetChildNodes
; Description:		Selects XML child Node(s) of an element based on XPath input from root node.
; Parameters:		$path	xml tree path from root node (root/child/child..)
; Syntax:			_XMLGetChildNodes($path)
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			array of Nodes or -1 on failure
;===============================================================================
Func _XMLGetChildNodes($strXPath)
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLGetChildNodes")
		Return SetError(1,20,-1)
	EndIf
	Local $objNodeList, $arrResponse[1], $xmlerr
	While @error = 0
		$objNodeList = $objDoc.selectSingleNode ($strXPath)
		If Not IsObj($objNodeList) Then
			$xmlerr = @LF & "No Matching Nodes found"
			$arrResponse[0] = 0
			ExitLoop
		EndIf
		If $objNodeList.hasChildNodes () Then
			For $objChild In $objNodeList.childNodes ()
				If $objChild.nodeType () = $NODE_ELEMENT Then
					_XMLArrayAdd($arrResponse, $objChild.baseName)
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
	_XMLError("Error Selecting Node(s): " & $strXPath & $xmlerr)
	SetError(1)
	Return -1
EndFunc   ;==>_XMLGetChildNodes
;===============================================================================
; Function Name:	_XMLGetChildren
; Description:		Selects XML child Node(s) of an element based on XPath input from root node.
;						And returns there text values.
; Parameters:		$path	xml tree path from root node (root/child/child..)
; Syntax:			_XMLGetChildren($path)
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			array of node names and values, or -1 on failure
;===============================================================================
Func _XMLGetChildren($strXPath)
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLGetChildren")
		Return SetError(1,21,-1)
	EndIf
	Local $objNodeList, $arrResponse[1][2], $xmlerr
	While @error = 0
		$objNodeList = $objDoc.selectSingleNode ($strXPath)
		If Not IsObj($objNodeList) Then
			$xmlerr = @LF & "No Matching Nodes found"
			$arrResponse[0][0] = 0
			ExitLoop
		EndIf
		If $objNodeList.hasChildNodes () Then
			For $objChild In $objNodeList.childNodes ()
				If $objChild.nodeType () = $NODE_ELEMENT Then
					Local $dims = UBound($arrResponse,1)
					ReDim $arrResponse[$dims+1][2]
					$arrResponse[$dims][0] = $objChild.baseName
					$arrResponse[$dims][1] = $objChild.text
					;_XMLArrayAdd($arrResponse, $objChild.baseName)
				EndIf
			Next
			$arrResponse[0][0] = UBound($arrResponse,1) - 1
			Return $arrResponse
		Else
			$arrResponse[0][0] = 0
			$xmlerr = @LF & "No Child Nodes found"
			SetError(1)
			ExitLoop
		EndIf
		Return $arrResponse
	WEnd
	_XMLError("Error Selecting Node(s): " & $strXPath & $xmlerr)
	SetError(1)
	Return -1
EndFunc   ;==>_XMLGetChildren

;===============================================================================
; Function Name: _XMLGetNodeCount
; Description: Get Node Count based on XPath input from root node.
; Parameters: $path xml tree path from root node (root/child/child..)
; [$query] DOM compliant query string (not really necessary as it becomes part of the path
;					$iNodeType The type of node to count. (element, attrib, comment etc.)
; Syntax: _XMLGetNodeCount($path,$query)
; Author(s): Stephen Podhajecki <gehossafats@netmdc.com> & DickB
; Returns: 0 or Number of Nodes found
; on error set error to 1 and returns -1
;===============================================================================
Func _XMLGetNodeCount($strXPath, $strQry = "", $iNodeType = 1)
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLGetNodeCount")
		Return SetError(1,22,-1)
	EndIf
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
	_XMLError("Error retrieving node count for: " & $strXPath & @CRLF & $errMsg & @CRLF)
	SetError(1)
	Return -1
	; EndIf
EndFunc   ;==>_XMLGetNodeCount
;===============================================================================
; Function Name:	_XMLGetAllAttribIndex
; Description:		Get all XML Field(s) attributes based on Xpathn and specific index.
; Parameters:		$sXpath	xml tree path from root node (root/child/child..)
;					$aNames the array to return the attrib names
;					$aValue the array to return the attrib values
;					[$sQuery] DOM compliant query string (not really necessary as it becomes
;					[$iNode] node index.
;part of the path
; Syntax:			_XMLGetAllAttribIndex($path,$aNames,$aValues,[$sQuery="",$iNode=0]])
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			array of attrib node names, array of attrib values
;					on error set error to 1 and returns -1
;===============================================================================
Func _XMLGetAllAttribIndex($strXPath, ByRef $aName, ByRef $aValue, $strQry = "", $NodeIndex = 0)
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLGetAllAttribIndex")
		Return SetError(1,23,-1)
	EndIf
	Local $objNodeList, $objQueryNodes, $arrResponse[2][1], $i
	$objQueryNodes = $objDoc.selectNodes ($strXPath & $strQry)
	While @error = 0 And $objQueryNodes.length > 0
		$objNodeList = $objQueryNodes.item($NodeIndex).attributes
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
	_XMLError("Error retrieving attributes for: " & $strXPath & @CRLF)
	SetError(1)
	Return -1
EndFunc   ;==>_XMLGetAllAttribIndex
;===============================================================================
; Function Name: _XMLGetPath
; Description: Return a nodes full path based on XPath input from root node.
; Parameters: $path xml tree path from root node (root/child/child..)
; Syntax: _XMLGetPath($path)
; Author(s): Stephen Podhajecki <gehossafats@netmdc.com>
; Returns: array of fields text values -1 on failure
;===============================================================================
Func _XMLGetPath($strXPath)
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLGetPath")
		Return SetError(1,24,-1)
	EndIf
	If $DOMVERSION < 4 Then
		_XMLError("Error DOM Version: " & "MSXML Version 4 or greater required for this function")
		Return -1
	EndIf
	Local $objNodeList, $arrResponse[1], $objNodeChild, $xmlerr, $nodepath, $ns , _
		$nodepathtag, $objParent
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
					If $ns <> ""  Then
						$ns = StringRight($ns, StringLen($ns) - StringInStr($ns, "/", 0, -1)) & ":"
					EndIf
					if $ns =0 then $ns =""
					$nodepath = "/" & $ns & $objNode.nodeName () & $nodepath
				EndIf
				Do
					$objParent = $objNode1.parentNode ()
					_DebugWrite("parent " & $objParent.nodeName () & @LF)
		
					If $objParent.nodeType <> $NODE_DOCUMENT Then
						$ns = $objParent.namespaceURI ()
						If $ns <> "" Then
							$ns = StringRight($ns, StringLen($ns) - StringInStr($ns, "/", 0, -1)) & ":"
						EndIf
						if $ns =0 then $ns= ""
						$nodepath = "/" &$ns  & $objParent.nodeName ()& $nodepath
						$objNode1 = $objParent
					Else
						$objNode1 = 0
					EndIf
					$objParent = 0
				Until (Not (IsObj($objNode1)))
				_DebugWrite("Path node> " & $nodepath & @LF)
				_XMLArrayAdd($arrResponse, $nodepath)
			Next
			$arrResponse[0] = UBound($arrResponse) - 1
			Return $arrResponse
		Else
			$xmlerr = @CRLF & "No matching node(s)found!"
			Return -1
			ExitLoop
		EndIf
	WEnd
	_XMLError("Error Retrieving: " & $strXPath & $xmlerr)
	SetError(1)
	Return -1
EndFunc   ;==>_XMLGetPath

;===============================================================================
; Function Name	:	_XMLGetPathInternal
; Description		:	Returns the path of a valid node object.
; Parameter(s)		:	$objNode		A valid node object
; Requirement(s)	:	
; Return Value(s)	:	A string path,  an empty string and set error on fail.
; User CallTip		:	
; Author(s)			:	Stephen Podhajecki <gehossafats at netmdc.com/>
; Note(s)			:	
;===============================================================================
Func _XMLGetPathInternal($objNode)
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLGetPathInternal")
		Return SetError(1,25,-1)
	EndIf
	Local $nodepath, $na, $objParent, $ns
	If IsObj($objNode) Then
		$nodepath = "/" & $objNode.baseName
		Do
			$objParent = $objNode.parentNode ()
			_DebugWrite("parent" & $objParent.nodeName () & ">" & @LF)
			If $objParent.nodeType <> $NODE_DOCUMENT Then
				$ns = $objParent.namespaceURI ()
				If $ns = 0 Then $ns = ""
				If $ns <> "" Then
					$ns = StringRight($ns, StringLen($ns) - StringInStr($ns, "/", 0, -1)) & ":"
				EndIf
				$nodepath = "/" & $ns & $objParent.nodeName () & $nodepath
				$objNode = $objParent
			Else
				$objNode = 0
			EndIf
			$objParent = 0
		Until (Not (IsObj($objNode)))
		_DebugWrite("Path node>" & $nodepath & @LF)
		Return ($nodepath)
	Else
		Return SetError(1, 0, "")
	EndIf
EndFunc   ;==>_XMLGetPathInternal
;===============================================================================
; Function Name: _XMLReplaceChild
; Description: Replaces a node with another
; Parameters: $oldNode Node to replace
;					 $newNode The replacement node.
; Syntax: _XMLReplaceChild(oldNode,newNode)
; Author(s): Stephen Podhajecki <gehossafats@netmdc.com> adapted from
;					http://www.perfectxml.com/msxmlAnswers.asp?Row_ID=65
; Returns:
;===============================================================================
Func _XMLReplaceChild($objOldNode, $objNewNode, $ns = "")
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLReplaceChild")
		Return SetError(1,26,-1)
	EndIf
	If $objOldNode = "" Or $objNewNode = "" Then Return SetError(1)
	Local $nodeRoot
	Local $nodeOld
	Local $nodeNew
	Local $nodeTemp,$oldNodes
	Local $bSuccess = False
	Local $bSucess
	;No error handling done
	With $objDoc
		;;.Load "c:\books.xml"
		$nodeRoot = .documentElement
		$oldNodes = $nodeRoot.selectNodes ($objOldNode)
		;'For each Node
		For $nodeOld In $oldNodes
			;Create a New element
			$nodeNew = .createNode ($NODE_ELEMENT, $objNewNode, $ns)
			;Copy attributes
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
				_XMLError("_XMLReplaceChild:" & @LF & "Error Replacing Child: " & _
						$objDoc.parseError.errorCode & _
						" " & $objDoc.parseError.reason)
				$bSucess = False
				ExitLoop
			Else
				$bSuccess = True
			EndIf
		Next
		.save ($strFile)
	EndWith
	$nodeRoot = 0
	$nodeOld = 0
	$nodeNew = 0
	$nodeTemp = 0
	Return $bSuccess
EndFunc   ;==>_XMLReplaceChild
;===============================================================================
; Function Name:	_XMLSchemaValidate
; Description:		Validates a document against a dtd.
; Parameter(s):	$sXMLFile	The file to validate
;						$ns	 xml namespace
;						$sXSDFile	DTD file to validate against.
; Syntax:			_XMLSchemaValidate($sXMLFile, $ns, $sXSDFile)
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			1 on success or SetError(errorcode) on failure
;===============================================================================
Func _XMLSchemaValidate($sXMLFile, $ns, $sXSDFile)
;~ 	If not IsObj($objDoc) then
;~ 		_XMLError("No object passed to function _XMLSchemaValidate")
;~ 		Return SetError(1,27,-1)
;~ 	EndIf
	Local $cache, $xmldoc
	$cache = ObjCreate("Msxml2.XMLSchemaCache." & $DOMVERSION & ".0")
	If Not IsObj($cache) Then
		MsgBox(266288, "XML Error", "Unable to instantiate the XML object" & @LF & "Please check your components.")
		Return SetError(-1)
	EndIf
	$cache.add ($ns, $sXSDFile)
	$xmldoc = ObjCreate("Msxml2.DOMDocument." & $DOMVERSION & ".0")
	If Not IsObj($xmldoc) Then
		MsgBox(266288, "XML Error", "Unable to instantiate the XML object" & @LF & "Please check your components.")
		Return SetError(-1)
	EndIf
	$xmldoc.async = False
	$xmldoc.schemas = $cache
	$xmldoc.load ($sXMLFile)
	If Not ($xmldoc.parseError.errorCode = 0) Then
		_XMLError("_XMLSchemaValidate:" & @LF & "Error: " & $xmldoc.parseError.errorCode & " " & $xmldoc.parseError.reason)
		Return SetError($xmldoc.parseError.errorCode)
	EndIf
	Return 0
EndFunc   ;==>_XMLSchemaValidate
;===============================================================================
; Function Name:	_XMLGetDomVersion
; Description:		Returns the version of msxml that is in use for the document.
;
; Syntax:			_XMLGetDomVersion()
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			msxml version or -1
;===============================================================================
Func _XMLGetDomVersion()
	Return $DOMVERSION
EndFunc   ;==>_XMLGetDomVersion
;===============================================================================
; Function Name:	_XMLError
; Description:		Sets error message generated by XML functs.
;					or Gets the message that was Set.
; Parameters:		$sError Node from root to delete
; Syntax:			_XMLError([$sError)
; Author(s):		Stephen Podhajecki <gehossafats@netmdc.com>
; Returns:			Nothing or Error message
;===============================================================================
Func _XMLError($sError = "")
	If $sError = "" Then
		$sError = $sXML_error
		$sXML_error = ""
		Return $sError
	Else
		$sXML_error = $sError
	EndIf
	_DebugWrite($sXML_error)
EndFunc   ;==>_XMLError
;===============================================================================
; Function Name:	_COMerr
; Description:		Displays a message box with the COM Error.
; Parameters:		none
; Syntax:			_COMerr()
; Author(s):		SvenP 's error handler
; Returns:
; From the forum this came.
;===============================================================================
Func _COMerr()
	_ComErrorHandler()
	Return
EndFunc   ;==>_COMerr
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
		_XMLError($msg)
	EndIf
	SetError(1)
EndFunc   ;==>_ComErrorHandler
; simple helper functions
;===============================================================================
; Function Name:	- 	_DebugWrite($message)
; Description:		- Writes a message to console with a crlf on the end
; Parameters:		- $message the message to display
; Syntax:			- _DebugWrite($message)
; Author(s):		-
; Returns:			-
;===============================================================================
Func _DebugWrite($message, $flag = @LF)
	If $debugging Then
		If $flag <> "" Then
			ConsoleWrite($message & $flag)
		Else
			ConsoleWrite($message)
		EndIf
	EndIf
EndFunc   ;==>_DebugWrite
;===============================================================================
; Function Name:	_Notifier($Notifier_msg)
; Description:		displays a simple "ok" messagebox
; Parameters:		$Notifier_Msg The message to display
; Syntax:			_Notifier($Notifier_msg)
; Author(s):		-
; Returns:			-
;===============================================================================
Func _Notifier($Notifier_msg)
	Return MsgBox(266288, @ScriptName, $Notifier_msg)
EndFunc   ;==>_Notifier
;===============================================================================
; Function Name:	- 	_SetDebug($flag =False)
; Description:		- Writes a message to console with a crlf on the end
; Parameters:		- $message the message to display
; Syntax:			- _DebugWrite($message)
; Author(s):		-
; Returns:			-
;===============================================================================
Func _SetDebug($debug_flag = True)
	$debugging = $debug_flag
	ConsoleWrite("Debug = " & $debugging & @LF)
EndFunc   ;==>_SetDebug
;===============================================================================
; Function Name:	- 	_XMLUDFVersion()
; Description:		- Returns UDF version number
; Parameters:		- none
; Syntax:			- _XMLUDFVersion()
; Author(s):		-
; Returns:			-
;===============================================================================
Func _XMLUDFVersion()
	Return $_XMLUDFVER
EndFunc   ;==>_XMLUDFVersion
;===============================================================================
; Function Name:	_XMLTransform
; Description:
; Parameter(s):	$oXMLDoc		The document to transform
;						$Style		(optional) The stylesheet to use
;						$szNewDoc	(optional) Save to this file.
; Return Value(s):	Return 1 on success or SetError(1) on failure
; User CallTip:
; Author(s):		Stephen Podhajecki <gehossafats at netmdc dot com>
; Note(s):
;===============================================================================
Func _XMLTransform($oXMLDoc, $Style = "", $szNewDoc = "")
	If not IsObj($oXMLDoc) then
		_XMLError("No object passed to function _XMLSetAttrib")
		Return SetError(1,29,-1)
	EndIf
	Local $bIndented = False
	Local $xslt = ObjCreate("MSXML2.XSLTemplate." & $DOMVERSION & ".0")
	Local $xslDoc = ObjCreate("MSXML2.FreeThreadedDOMDocument." & $DOMVERSION & ".0")
	Local $xmldoc = ObjCreate("MSXML2.DOMDocument." & $DOMVERSION & ".0")
	Local $xslProc
	$xslDoc.async = False
	If FileExists($Style) Then
		_DebugWrite("LoadXML:1:" & $xslDoc.load ($Style) & @LF)
	Else
		_DebugWrite("LoadXML:2:" & $xslDoc.loadXML (_GetDefaultStyleSheet()) & @LF)
	EndIf
	If $xslDoc.parseError.errorCode <> 0 Then
		_XMLError("Error Transforming NodeToObject: " & $xslDoc.parseError.reason)
	EndIf
	If Not FileExists("XSLFile.xsl") Then FileWrite("XSLFile.xsl", $xslDoc.xml ())
	$xslt.stylesheet = $xslDoc
	$xslProc = $xslt.createProcessor ()
	$xslProc.input = $objDoc
	$oXMLDoc.transformNodeToObject ($xslDoc, $xmldoc)
	If $oXMLDoc.parseError.errorCode <> 0 Then
		_XMLError("_XMLTransform:" & @LF & "Error Transforming NodeToObject: " & $oXMLDoc.parseError.reason)
		$bIndented = False
	Else
		$bIndented = True
	EndIf
	If $bIndented Then
		If $szNewDoc <> "" Then
			$xmldoc.save ($szNewDoc)
			If $xmldoc.parseError.errorCode <> 0 Then
				_XMLError("_XMLTransform:" & @LF & "Error Saving: " & $xmldoc.parseError.reason)
				$bIndented = False
			EndIf
		Else
			$xmldoc.save ($strFile)
			$oXMLDoc.Load ($strFile)
			If $oXMLDoc.parseError.errorCode <> 0 Then
				_XMLError("_XMLTransform:" & @LF & "Error Saving: " & $oXMLDoc.parseError.reason)
				$bIndented = False
			EndIf
		EndIf
	EndIf
	$xslProc = 0
	$xslt = 0
	$xslDoc = 0
	$xmldoc = 0
	Return $bIndented
EndFunc   ;==>_XMLTransform
;===============================================================================
; Function Name:	_GetDefaultStyleSheet
; Description:	 Internal function, returns the default indenting style sheet
; Parameter(s): Requirement(s):
; Return Value(s): Stylesheet on success for nothing on failure.
; User CallTip:
; Author(s):
; Note(s):
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
;===============================================================================
; Function Name:	_AddFormat
; Description:
; Parameter(s):	$objDoc	 Document to format
;						$objParent	 Optional node to add formatting to
; Requirement(s):
; Return Value(s):
; User CallTip:
; Author(s):		Stephen Podhajecki <gehossafats a t netmdc.com>
; Note(s):			just break up the tags, no indenting is done here.
;===============================================================================
Func _AddFormat($objDoc, $objParent = "")
	If not IsObj($objDoc) then
		_XMLError("No object passed to function _XMLAddFormat")
		Return SetError(1,30,-1)
	EndIf
	Local $objFormat = $objDoc.createTextNode (@CR)
	If IsObj($objParent) Then
		$objParent.appendChild ($objFormat)
	Else
		$objDoc.documentElement.appendChild ($objFormat)
	EndIf
	$objDoc.Save ($strFile)
EndFunc   ;==>_AddFormat
; =======================================================================
; Preprocessed included functions...
; =======================================================================
Func _XMLArrayAdd(ByRef $avArray, $sValue)
	If IsArray($avArray) Then
		ReDim $avArray[UBound($avArray) + 1]
		$avArray[UBound($avArray) - 1] = $sValue
		SetError(0)
		Return 1
	Else
		SetError(1)
		Return 0
	EndIf
EndFunc   ;==>_XMLArrayAdd