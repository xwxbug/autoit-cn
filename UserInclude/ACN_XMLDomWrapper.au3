#include-once
;;There is also _MSXML.au3 at http://code.google.com/p/my-autoit/source/browse/#svn/trunk/Scripts/MSXML
;; http://my-autoit.googlecode.com/files/_MSXML.au3
;;which return the xml object instead of using a global var.
;;Therefore using the one above, more than one xml file can be opened at a time.

;;The unfortunate nature of both the scripts is that the func return results are strings or arrys instead of objects.


; #INDEX# =======================================================================================================================
; Title .........: _XMLDomWrapper
; AutoIt Version : 3.2.3++
; Language ......: English
; Description ...: Functions to use for reading and writing XML using msxml.
;                  .Initial release Dec. 15, 2005
;                  .Dec 15, 2005, Update Jan10,2006, Update Feb 5,8,14-15, 2006
;                  .Feb 24, 2006 Updated _XMLCreateCDATA, code cleaned up Gary Frost (custompcs@charter.net)
;                  .Feb 24, 2006 bug fix in re-init COM error handler, rewrote _XMLCreateChildNodeWAttr()
;                  .Jun 20, 2006 Added count to index[0] of the _XMLGetValue return value
;                  .Jun 26, 2006 Changed _XMLCreateFile to include option flag for UTF-8 encoding
;                  .Jun 29, 2006 Added count to index[0] of the _XMLGetValue return
;                  .     Changed _XMLFileOpen and _XMLFileCreate
;                  .Mar 30, 2007 Rewrote _AddFormat function to break up tags( no indentation)
;                  .Added _XMLTransform() which runs the document against a xsl(t) style sheet for indentation.
;                  .     Changed _XMLCreateRootChildWAttr() to use new formatting
;                  .     Changed _XMLChreateChildNode() to use new formatting
;                  .Apr 02, 2007 Added _XMLReplaceChild()
;                  .Apr 03, 2007 Changed other node creating function to use new formatting
;                  .     Changed _XMLFileOpen() _XMLFileCreate to take an optional version number of MSXML to use.
;                  .     Changed _XMLFileOpen() _XMLFileCreate find latest MSXML version logic.
;                  .Apr 24, 2007 Fixed _XMLCreateChileNodeWAttr() - Instead of removal, It points to the function that replaced it.
;                  .Apr 25, 2007 Added _XMLCreateAttrib()
;                  .     Fixed bug with _XMLCreateRootNodeWAttr , _XMLCreateChild[Node]WAttr() where an extra node with same name was added.
;                  .     Stripped extrenous comments.
;                  .     Removed dependency on Array.au3 (I added the func from Array.au3 and renamed it to avoid conflicts.)
;                  .May 03, 2007	Changed method of msxml version lookup.  Updated api call tips.
;                  .May 11, 2007 Fixed missing \
;                  .Jun 08, 2007 Fixed Namespace issue with _XMLCreateChildNode() and _XMLCreateChildNodeWAttr()
;                  .Jun 12, 2007 Added workaround for MSXML6 to parse file with DTD's
;                  .Jun 13, 2007 Fixed bug in _XMLGetField() where all text was returned in one node.
;                  .     Actually this is not a bug, because it is the way that WC3 says it will be returned
;                  .     However, it will now return in a way that is expected.
;                  .     _XMLGetValue now returns just the text associated with the node or empty string.
;                  .Jul 20, 2007 Fixed bug where failure to open the xml file would return an empty xml object, it now returns 0(no object).
;                  .     Added object check to all applicable functions.
;                  .Aug 08, 2007 Add a _XMLSetAutoSave() to turn off/on forced saving within each function. --Thanks drlava
;                  .     Added check for previous COM error handler.		--Thanks Lukasz Suleja
;                  .Aug 27,2007  Changed property setting order for _XMLFileOpen.  The previous order was causing a problem with default namespaces.
;                  .     -- It seems that "selectionLanguage" needs to be declared before some other properties.
;                  .Aug 31,2007 Fixed bug where _XMLUpdateField would inadvertantly erase child nodes.
;                  .Sep 07,2007 Fixed _XMLDeleteNode bug where non-existant node cause COM error.
;                  .     Added _XMLNodeExist function to check for the existence of node or nodes matching the specified path
;                  .Jan 05,2008 Fixed documentation problem in function header with _XMLGetAttrib.
;                  .Feb 25,2008 Fixed dimensioning bug in _XMLGetChildren  --Thanks oblique
;                  .Mar 05,2008 Return values fixed for the following functions: --Thanks oblique
;                  .     _XMLFileOpen ,_XMLLoadXML,_XMLCreateFile,
;                  .     Documentation fixed for _XMLGetNodeCount,_XMLGetChildren --Thanks oblique
;                  .Mar 07,2008 Small changes.
;                  .     Fixed an issue point out by lgr.
;                  .Mar 27,2009 Added function to turn off auto indenting, modified _XMLSetAutoSave, add "force" flag to _XMLSaveDoc
;                  .     Replace _XMLTransform with weaponx provided version.
;                  .     Added _XMLSetAutoFormat, _XMLSetAutoSave, _XMLSaveDoc to function list in header.
;                  .Mar 28,2009 Changed and verified (hopefuly) all function headers to be inline with current standard.
;                  .     Verifed return values make documentation.
;                  .     Automatic saving is now off by default.
;                  .     Automatic formatting is now off by default.
;                  .Mar 30,2009 Fixed a bug in _XMLGetChildren where passing the root would get values of grandchildren.
;                  .Apr 24,2009 Reverted Autosave and Autoformat.
;                  .    Fixed doc error regrading Autoindent vs Autoformat.
;                  .    Change boolean vars to start with $f instead of $b
;                  .Apr 25,2009 Experimental code to remove indenting text node when a node is deleted.
;                  .Apr 27,2010 added _XMLUpdateField2 per weaponx.  Should update multiple nodes.
;                  .Aug 12,2010 Added remarks to _XMLCreateFile.
;                       Added func _XMLGetParent  -- Thanks Mike Rerick
; Author ........: Stephen Podhajecki Eltorro, Weaponx
; ===============================================================================================================================
; XML DOM Wrapper functions

#cs defs to add to au3.api
	_XMLCreateFile($sPath, $sRootNode, [$fOverwrite = False]) Creates an XML file with the given name and root.
	_XMLFileOpen($sXMLFile,[$sNamespace=""],[$ver=-1]) Creates an instance of an XML file.
	_XMLSaveDoc( $sFile="",$iForce = 0 ) Save the xml doc,  use $iForce = 1 to force save if AutoSave is off.  
	; =============================================================================
	_XMLGetChildNodes ( strXPath ) Selects XML child Node(s) of an element based on XPath input from root node. 
	_XMLGetNodeCount ( strXPath, strQry = "", iNodeType = 1 ) Get node count for specified path and type. 
	_XMLGetPath ( strXPath ) Returns a nodes full path based on XPath input from root node. 
	_XMLGetParent($strXPath) Gets the parent node name of the node pointed to by the XPath.
	; =============================================================================
	_XMLSelectNodes ( strXPath ) Selects XML Node(s) based on XPath input from root node. 
	_XMLGetField ( strXPath ) Get XML Field(s) based on XPath input from root node.
	_XMLGetValue ( strXPath ) Get XML Field based on XPath input from root node. 
	_XMLGetChildText ( strXPath ) Selects XML child Node(s) of an element based on XPath input from root node. 
	_XMLUpdateField ( strXPath, strData ) Update existing node based on XPath specs.
	_XMLUpdateField2 ( strXPath, strData ) Update existing node(s) based on XPath specs.
	_XMLReplaceChild ( objOldNode, objNewNode, ns = "" ) Replaces a node with a new node. 
	; =============================================================================
	_XMLDeleteNode ( strXPath ) Delete specified XPath node.
	_XMLDeleteAttr ( strXPath, strAttrib ) Delete attribute for specified XPath
	_XMLDeleteAttrNode ( strXPath, strAttrib ) Delete attribute node for specified XPath
	; =============================================================================
	_XMLGetAttrib ( strXPath, strAttrib, strQuery = "" ) Get XML attribute based on XPath input from root node.
	_XMLGetAllAttrib ( strXPath, ByRef aName, ByRef aValue, strQry = "" ) Get all XML Field(s) attributes based on XPath input from root node.
	_XMLGetAllAttribIndex ( strXPath, ByRef aName, ByRef aValue, strQry = "", NodeIndex = 0 ) Get all XML Field(s) attributes based on Xpathn and specific index.
	_XMLSetAttrib ( strXPath, strAttrib, strValue = "" ) Set XML Field(s) attributes based on XPath input from root node.
	; =============================================================================
	_XMLCreateCDATA ( strNode, strCDATA, strNameSpc = "" ) Create a CDATA SECTION node directly under root. 
	_XMLCreateComment ( strNode, strComment ) Create a COMMENT node at specified path.
	_XMLCreateAttrib ( strXPath,strAttrName,strAttrValue="" ) Creates an attribute for the specified node. 
	; =============================================================================
	_XMLCreateRootChild ( strNode, strData = "", strNameSpc = "" ) Create node directly under root.
	_XMLCreateRootNodeWAttr ( strNode, aAttr, aVal, strData = "", strNameSpc = "" ) Create a child node under root node with attributes.
	_XMLCreateChildNode ( strXPath, strNode, strData = "", strNameSpc = "" )  Create a child node under the specified XPath Node.
	_XMLCreateChildWAttr ( strXPath, strNode, aAttr, aVal, strData = "", strNameSpc = "" ) Create a child node under the specified XPath Node with Attributes. 
	; =============================================================================
	_XMLSchemaValidate ( sXMLFile, ns, sXSDFile ) 	_XMLSchemaValidate($sXMLFile, $ns, $sXSDFile) Validate a document against a DTD. 
	_XMLGetDomVersion (  ) Returns the XSXML version currently in use. 
	_XMLError ( sError = "" ) Sets or Gets XML error message generated by XML functions.
	_XMLUDFVersion (  ) Returns the UDF Version number. 
	_XMLTransform ( oXMLDoc, Style = "",szNewDoc="" ) Transfroms the document using built-in sheet or xsl file passed to function. 
	_XMLNodeExists( $strXPath) Checks for the existence of the specified path. 
	; =============================================================================
	_XMLSetAutoFormat( $fAutoFormat = True ) Turn auto indenting on or off.
	_XMLSetAutoSave( $fSave = True ) Set the automatic save to on or off.
#ce

; #VARIABLES# ===================================================================================================================
Global Const $_XMLUDFVER = "1.0.3.98"
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
Global $oXMLMyError ;COM error handler OBJ ; Initialize SvenP 's error handler
Global $sXML_error
Global $fDEBUGGING
Global $DOMVERSION = -1
Global $objDoc
Global $fXMLAUTOSAVE = True ;auto save updates
Global $fADDFORMATTING = True ;auto indent
; ===============================================================================================================================

; #FUNCTION# ===================================================================
; Name ..........: _XMLFileOpen
; Description ...: Creates an instance of an XML file.
; Syntax.........:  _XMLFileOpen($strXMLFile[, $strNameSpc = ""[, $iVer = -1[, $fValOnParse = True]]])
; Parameters ....: $strXMLFile    - the XML file to open
;                  $strNameSpc    - the namespace to specifiy if the file uses one.
;                  $iVer          - specifically try to use the version supplied here.
;                  $fValOnParse   - validate the document as it is being parsed
; Return values .: Success        - 1
;                  Failure        - -1 and set @error to:
;                  |0 - No error
;                  |1 - Parse error, @Extended = MSXML reason
;                  |2 - No object
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLFileOpen($strXMLFile, $strNameSpc = "", $iVer = -1, $fValOnParse = True)
	;==== pick your poison
	If $iVer <> -1 Then
		If $iVer > -1 And $iVer < 7 Then
			$objDoc = ObjCreate("Msxml2.DOMDocument." & $iVer & ".0")
			If IsObj($objDoc) Then
				$DOMVERSION = $iVer
			EndIf
		Else
			MsgBox(266288, "Error:", "Failed to create object with MSXML version " & $iVer)
			SetError(1)
			Return 0
		EndIf
	Else
		For $x = 8 To 0 Step -1
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
	;Thanks Lukasz Suleja
	$oXMLMyError = ObjEvent("AutoIt.Error")
	If $oXMLMyError = "" Then
		$oXMLMyError = ObjEvent("AutoIt.Error", "_XMLCOMEerr") ; ; Initialize SvenP 's error handler
	EndIf
	$strFile = $strXMLFile
	$objDoc.async = False
	$objDoc.preserveWhiteSpace = True
	$objDoc.validateOnParse = $fValOnParse
	If $DOMVERSION > 4 Then $objDoc.setProperty("ProhibitDTD", False)
	$objDoc.Load($strFile)
	$objDoc.setProperty("SelectionLanguage", "XPath")
	$objDoc.setProperty("SelectionNamespaces", $strNameSpc)
	If $objDoc.parseError.errorCode > 0 Then ConsoleWrite($objDoc.parseError.reason & @LF)
	If $objDoc.parseError.errorCode <> 0 Then
		_XMLError("Error opening specified file: " & $strXMLFile & @CRLF & $objDoc.parseError.reason)
		;Tom Hohmann 2008/02/29
		SetError(1, $objDoc.parseError.errorCode, -1)
		$objDoc = 0
		Return -1
	EndIf
	;Tom Hohmann 2008/02/29
	Return 1
EndFunc   ;==>_XMLFileOpen
;
; #FUNCTION# ===================================================================
; Name ..........: _XMLLoadXML
; Description ...: Creates an instance for a string of XML .
; Syntax.........:  _XMLLoadXML($strXML[,$strNameSpc=""[, $iVer = -1[, $fValOnParse = True]]])
; Parameters ....: $strXML        - The XML to load into the document
;                  $strNameSpc    - the namespace to specifiy if the file uses one.
;                  $iVer          - specifically try to use the version supplied here.
;                  $fValOnParse   - Set the MSXML ValidateOnParse property
; Return values .: Success        - 1
;                  Failure        - -1 and set @error to
;                  |1 - failed to create object, @Extended = MSXML reason
;                  |2 - no object found (MSXML required for _XML functions
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>,Lukasz Suleja,Tom Hohmann
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLLoadXML($strXML, $strNameSpc = "", $iVer = -1, $fValOnParse = True)
	If $iVer <> -1 Then
		If $iVer > -1 And $iVer < 7 Then
			$objDoc = ObjCreate("Msxml2.DOMDocument." & $iVer & ".0")
			If IsObj($objDoc) Then
				$DOMVERSION = $iVer
			EndIf
		Else
			MsgBox(266288, "Error:", "Failed to create object with MSXML version " & $iVer)
			SetError(1)
			Return 0
		EndIf
	Else
		For $x = 8 To 0 Step -1
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
	;Thanks Lukasz Suleja
	$oXMLMyError = ObjEvent("AutoIt.Error")
	If $oXMLMyError = "" Then
		$oXMLMyError = ObjEvent("AutoIt.Error", "_XMLCOMEerr") ; ; Initialize SvenP 's error handler
	EndIf
	$objDoc.async = False
	$objDoc.preserveWhiteSpace = True
	$objDoc.validateOnParse = $fValOnParse
	If $DOMVERSION > 4 Then $objDoc.setProperty("ProhibitDTD", False)
	$objDoc.LoadXml($strXML)
	$objDoc.setProperty("SelectionLanguage", "XPath")
	$objDoc.setProperty("SelectionNamespaces", $strNameSpc); "xmlns:ms='urn:schemas-microsoft-com:xslt'"
	If $objDoc.parseError.errorCode <> 0 Then
		_XMLError("Error loading the XML data: " & @CRLF & $objDoc.parseError.reason)
		;Tom Hohmann 2008/02/29
		SetError(1, $objDoc.parseError.errorCode, -1)
		Return -1
	EndIf
	;Tom Hohmann 2008/02/29
	Return 1
EndFunc   ;==>_XMLLoadXML

; #FUNCTION# ===================================================================
; Name ..........: _XMLCreateFile
; Description ...: Create a new blank metafile with header.
; Syntax.........:  _XMLCreateFile($strPath, $strRoot[, $fOverwrite = False[, $fUTF8 = False[, $ver = -1]]])
; Parameters ....: $strPath       - The xml filename with full path to create
;                  $strRoot       - The root of the xml file to create
;                  $fOverwrite    - boolean flag to auto overwrite existing file of same name.
;                  $fUTF8         - boolean flag to specify UTF-8 encoding in header.
;                  $iVer          - specifically try to use the version supplied here.
; Return values .: Success        - 1
;                  Failure        - -1 and sets @Error to:
;                  |0 - No error
;                  |1 - Failed to create file
;                  |2 - No object
;                  |3 - File creation failed MSXML error
;                  |4 - File exists
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......: Use _XMLFileOpen after using this function to access the file. (PsaltyDS)
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLCreateFile($strPath, $strRoot, $fOverwrite = False, $fUTF8 = False, $ver = -1)
	Local $retval, $fe, $objPI, $rootElement
	$fe = FileExists($strPath)
	If $fe And Not $fOverwrite Then
		$retval = (MsgBox(4097, "File Exists:", "The specified file exits." & @CRLF & "Click OK to overwrite file or cancel to exit."))
		If $retval = 1 Then
			FileCopy($strPath, $strPath & @YEAR & "-" & @MON & "-" & @MDAY & "_" & @HOUR & "-" & @MIN & "-" & @SEC & ".bak", 1)
			FileDelete($strPath)
			$fe = False
		Else
			_XMLError("Error failed to create file: " & $strPath & @CRLF & "File exists.")
			SetError(4)
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
				SetError(3)
				Return 0
			EndIf
		Else
			For $x = 8 To 0 Step -1
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
			Return SetError(2)
		EndIf
		If $fUTF8 Then
			$objPI = $objDoc.createProcessingInstruction("xml", "version=""1.0"" encoding=""UTF-8""")
		Else
			$objPI = $objDoc.createProcessingInstruction("xml", "version=""1.0""")
		EndIf
		$objDoc.appendChild($objPI)
		$rootElement = $objDoc.createElement($strRoot)
		$objDoc.documentElement = $rootElement
		$objDoc.save($strPath)
		;_XMLSaveDoc (,1)
		
		If $objDoc.parseError.errorCode <> 0 Then
			_XMLError("Error Creating specified file: " & $strPath)
			;			Tom Hohmann 2008/02/29
			$objDoc = 0
			SetError(1, $objDoc.parseError.errorCode, -1)
			Return -1
		EndIf
		Return 1
	Else
		_XMLError("Error! Failed to create file: " & $strPath)
		$objDoc = 0
		SetError(1)
		Return 0
	EndIf
	$objDoc = 0
	Return 1
EndFunc   ;==>_XMLCreateFile
; #FUNCTION# ===================================================================
; Name ..........: _XMLSelectNodes
; Description ...: Selects XML Node(s) based on XPath input from root node.
; Syntax.........:  _XMLSelectNodes($strXPath)
; Parameters ....: $strXPath      - xml tree path from root node (root/child/child..)
; Return values .: Success        - An array of Nodes(count is in first element)
;                  Failure        - -1 and set @Error = 1
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLSelectNodes(ByRef $objDoc, $strXPath)
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLSelectNodes")
		Return SetError(2, 0, -1)
	EndIf
	Local $objNode, $objNodeList, $arrResponse[1], $xmlerr
	$objNodeList = $objDoc.selectNodes($strXPath)
	If Not IsObj($objNodeList) Then
		_XMLError("\nNo matching nodes found")
		Return SetError(1, 0, -1)
	EndIf
	If $objNodeList.length < 1 Then
		_XMLError("\nNo matching nodes found")
		Return SetError(1, 0, -1)
	EndIf
	For $objNode In $objNodeList
		_XMLArrayAdd($arrResponse, $objNode.nodeName)
		_DebugWrite($objNode.nodeName)
		_DebugWrite($objNode.namespaceURI)
	Next
	$arrResponse[0] = $objNodeList.length
	Return $arrResponse
	_XMLError("Error Selecting Node(s): " & $strXPath & $xmlerr)
	Return SetError(1, 0, -1)
EndFunc   ;==>_XMLSelectNodes

; #FUNCTION# ===================================================================
; Name ..........: _XMLGetField
; Description ...: Get XML Field(s) based on XPath input from root node.
; Syntax.........:  _XMLGetField($strXPath)
; Parameters ....: $strXPath      - The XML tree path from root node (root/child/child..)
; Return values .: Success        - An array of fields text values(count is in first element)
;                  Failure        - -1 and sets @Error = 1
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLGetField(ByRef $objDoc, $strXPath)
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLGetField")
		Return SetError(1, 2, -1)
	EndIf
	Local $objNodeList, $arrResponse[1], $xmlerr, $szNodePath
	$objNodeList = $objDoc.selectSingleNode($strXPath)
	If Not IsObj($objNodeList) Then
		_XMLError("\nNo Matching Nodes found")
		$arrResponse[0] = 0
		Return SetError(2, 0, -1)
	EndIf
	If $objNodeList.hasChildNodes() Then
		Local $count = $objNodeList.childNodes.length
		For $x = 1 To $count
			$objChild = $objNodeList.childNodes($x)
			_DebugWrite("ParentNode=" & $objNodeList.parentNode.nodeType)
			If $objNodeList.parentNode.nodeType = $NODE_DOCUMENT Then
				$szNodePath = "/" & $objNodeList.baseName & "/*[" & $x & "]"
			Else
				$szNodePath = $objNodeList.baseName & "/*[" & $x & "]"
			EndIf
			
			$aRet = _XMLGetValue($objDoc, $szNodePath)
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
		_XMLError("\nNo Child Nodes found")
		Return SetError(1, 0, -1)
	EndIf
	_XMLError("Error Selecting Node(s): " & $strXPath & $xmlerr)
	Return SetError(1, 0, -1)
EndFunc   ;==>_XMLGetField
; #FUNCTION# ===================================================================
; Name ..........: _XMLGetValue
; Description ...: Get XML values based on XPath input from root node.
; Syntax.........:  _XMLGetValue($strXPath)
; Parameters ....: $strXPath      - xml tree path from root node (root/child/child..)
; Return values .: Success        - An array of fields text values(count is in first element)
;                  Failure        - -1 and sets @Error = 1, @Extended to:
;                  |0 - No matching node.
;                  |1 - No object passed.
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLGetValue(ByRef $objDoc,$strXPath)
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLGetValue")
		Return SetError(1, 1, -1)
	EndIf
	Local $objNodeList, $arrResponse[1], $objNodeChild, $xmlerr
	_DebugWrite("GetValue>$strXPath:" & $strXPath)
	$objNodeList = $objDoc.documentElement.selectNodes($strXPath)
	If $objNodeList.length > 0 Then
		_DebugWrite("GetValue list length:" & $objNodeList.length)
		For $objNode In $objNodeList
			If $objNode.hasChildNodes() = False Then
				_XMLArrayAdd($arrResponse, $objNode.nodeValue)
			Else
				For $objNodeChild In $objNode.childNodes()
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
		Return SetError(1, 0, -1)
	EndIf
	_XMLError("Error Retrieving: " & $strXPath & $xmlerr)
	
	Return SetError(1, 0, -1)
EndFunc   ;==>_XMLGetValue
; #FUNCTION# ===================================================================
; Name ..........: _XMLDeleteNode
; Description ...: Deletes XML Node based on XPath input from root node.
; Syntax.........:  _XMLDeleteNode($strXPath)
; Parameters ....: $strXPath      - The XML tree path from root node (root/child/child..)
; Return values .: Success        - 1
;                  Failure        - -1 and sets @Error to:
;                  |0 - No error
;                  |1 - Deletion error
;                  |2 - No object passed
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLDeleteNode(ByRef $objDoc,$strXPath)
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLDeleteNode")
		Return SetError(2, 0, -1)
	EndIf
	Local $objNode, $xmlerr
	$objNode = $objDoc.selectNodes($strXPath)
	If Not IsObj($objNode) Then $xmlerr = @CRLF & "Node Not found"
	If @error = 0 Then
		For $objChild In $objNode
			If $objChild.hasChildNodes Then
				For $objGrandChild in $objChild.childNodes
					If $objGrandChild.nodeType = $NODE_TEXT Then
						If StringStripWS($objGrandChild.text,7) = "" Then
							$objChild.removeChild($objGrandChild)
						EndIf
					EndIf
				Next
			EndIf
			$objChild.parentNode.removeChild($objChild)
		Next
		_XMLSaveDoc($strFile)
		Return 1
	EndIf
	_XMLError("Error Deleting Node: " & $strXPath & $xmlerr)
	Return SetError(1, 0, -1)
EndFunc   ;==>_XMLDeleteNode

; #FUNCTION# ===================================================================
; Name ..........: _XMLDeleteAttr
; Description ...: Delete XML Attribute based on XPath input from root node.
; Syntax.........:  _XMLDeleteAttr($strXPath, $strAttrib)
; Parameters ....: $strXPath      - The XML tree path from root node (root/child/child..)
;                  $strAttribute  - The attribute node to delete
; Return values .: Success        - 1
;                  Failure        - -1 and sets @Error to:
;                  |0 - No error
;                  |1 - Error removing attribute
;                  |2 - No object
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLDeleteAttr(ByRef $objDoc,$strXPath, $strAttrib)
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLDeleteAttr")
		Return SetError(2, 0, -1)
	EndIf
	Local $objNode, $objAttr, $xmlerr
	$objNode = $objDoc.selectSingleNode($strXPath)
	If IsObj($objNode) Then
		$objAttr = $objNode.getAttributeNode($strAttrib)
		If Not (IsObj($objAttr)) Then
			_XMLError("Attribute " & $strAttrib & " does not exist!")
			Return SetError(2, 0, -1)
		EndIf
		$objAttr = $objNode.removeAttribute($strAttrib)
		_XMLSaveDoc($strFile)
		Return 1
	EndIf
	_XMLError("Error Removing Attribute: " & $strXPath & " - " & $strAttrib & @CRLF & $xmlerr)
	$xmlerr = ""
	Return SetError(1, 0, -1)
EndFunc   ;==>_XMLDeleteAttr
; #FUNCTION# ===================================================================
; Name ..........: _XMLDeleteAttrNode
; Description ...: Delete XML Attribute node based on XPath input from root node.
; Syntax.........:  _XMLDeleteAttrNode($strXPath, $strAttrib)
; Parameters ....: $strXpath      - XML tree path from root node (root/child/child..)
;                  $strAttrib     - The attribute node to delete
; Return values .: Success        - 1
;                  Failure        - -1 and sets @Error to:
;                  |0 - No error
;                  |1 - Error removing node
;                  |2 - No object
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLDeleteAttrNode(ByRef $objDoc,$strXPath, $strAttrib)
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLDeleteAttrNode")
		Return SetError(2, 0, -1)
	EndIf
	Local $objNode, $objAttr, $xmlerr
	$objNode = $objDoc.selectSingleNode($strXPath)
	If Not IsObj($objNode) Then
		_XMLError("\nSpecified node not found!")
		Return SetError(2, 0, -1)
	EndIf
	$objAttr = $objNode.removeAttributeNode($objNode.getAttributeNode($strAttrib))
	_XMLSaveDoc($strFile)
	If Not (IsObj($objAttr)) Then
		_XMLError("\nUnspecified error:!")
		Return SetError(1, 0, -1)
	EndIf
	Return 1
EndFunc   ;==>_XMLDeleteAttrNode
; #FUNCTION# ===================================================================
; Name ..........: _XMLGetAttrib
; Description ...: Get XML Field based on XPath input from root node.
; Syntax.........:  _XMLGetAttrib($strXPath, $strAttrib[, $strQuery = ""])
; Parameters ....: $strXPath      - XML tree path from root node (root/child/child..)
;                  $strAttrib     - The attribute node to read.
;                  $strQuery      - The query string in xml format
; Return values .: Success        - The attribute value.
;                  Failure        - -1 and sets	@Error to:
;                  |0 - No error
;                  |1 - Attribute not found.
;                  |2 - No object
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLGetAttrib(ByRef $objDoc,$strXPath, $strAttrib, $strQuery = "")
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLGetAttrib")
		Return SetError(2, 0, -1)
	EndIf
	;Local $objNodeList, $arrResponse[1], $i, $xmlerr, $objAttr
	Local $objNodeList, $arrResponse, $i, $xmlerr, $objAttr
	$objNodeList = $objDoc.documentElement.selectNodes($strXPath & $strQuery)
	_DebugWrite("Get Attrib length= " & $objNodeList.length)
	If $objNodeList.length > 0 Then
		For $i = 0 To $objNodeList.length - 1
			$objAttr = $objNodeList.item($i).getAttribute($strAttrib)
			$arrResponse = $objAttr
			_DebugWrite("RET>>" & $objAttr)
		Next
		Return $arrResponse
	EndIf
	$xmlerr = "\nNo qualified items found"
	_XMLError("Attribute " & $strAttrib & " not found for: " & $strXPath & $xmlerr)
	Return SetError(1, 0, -1)
EndFunc   ;==>_XMLGetAttrib
; #FUNCTION# ===================================================================
; Name ..........: _XMLSetAttrib
; Description ...: Set XML Field(s) based on XPath input from root node.
; Syntax.........:  _XMLSetAttrib($strXPath, $strAttrib[, $strValue = ""[, $iIndex =-1]])
; Parameters ....: $strXPath      - Xml tree path from root node (root/child/child..)
;                  $strAttrib     - The attribute to set.
;                  $strValue      - The value to give the attribute defaults to ""
;                  $iIndex        - Used to specify a specific index for "same named" nodes.
; Return values .: Success        - Anarray of fields text values
;                  Failure        - -1 and sets @error to 1
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLSetAttrib(ByRef $objDoc,$strXPath, $strAttrib, $strValue = "", $iIndex = -1)
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLSetAttrib")
		Return SetError(1, 8, -1)
	EndIf
	Local $objNodeList, $arrResponse[1], $i
	$objNodeList = $objDoc.selectNodes($strXPath)
	_DebugWrite(" Node list Length: " & $objNodeList.length)
	If @error = 0 And $objNodeList.length > 0 Then
		If $iIndex > 0 Then
			$arrResponse[0] = $objNodeList.item($iIndex).SetAttribute($strAttrib, $strValue)
		Else
			ReDim $arrResponse[$objNodeList.length]
			For $i = 0 To $objNodeList.length - 1
				$arrResponse[$i] = $objNodeList.item($i).SetAttribute($strAttrib, $strValue)
				If $objDoc.parseError.errorCode <> 0 Then ExitLoop
			Next
		EndIf
		If $objDoc.parseError.errorCode <> 0 Then
			_XMLError("Error setting attribute for: " & $strXPath & @CRLF & $objDoc.parseError.reason)
			Return SetError(1, $objDoc.parseError.errorCode, -1)
		EndIf
		_XMLSaveDoc($strFile)
		Return $arrResponse
	EndIf
	_XMLError("Error failed to set attribute for: " & $strXPath & @CRLF)
	SetError(1)
	Return -1
EndFunc   ;==>_XMLSetAttrib
; #FUNCTION# ===================================================================
; Name ..........: _XMLGetAllAttrib
; Description ...: Get all XML Field(s) attributes based on XPath input from root node.
; Syntax.........:  _XMLGetAllAttrib($strXPath, ByRef $aName, ByRef $aValue[, $strQry = ""])
; Parameters ....: $strXPath      - XML tree path from root node (root/child/child..)
;                  $aName         - The array to return the attrib names
;                  $aValue        - The array to return the attrib values
;                  $strQuery      - DOM compliant query string (not really necessary as it becomes part of the path)
; Return values .: Success        - array of fields text values(number of items is in [0][0])
;                  Failure        - @error set to 1 and returns -1
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLGetAllAttrib(ByRef $objDoc,$strXPath, ByRef $aName, ByRef $aValue, $strQry = "")
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLGetAllAttrib")
		Return SetError(1, 9, -1)
	EndIf
	Local $objNodeList, $objQueryNodes, $objNode, $arrResponse[2][1], $i
	$objQueryNodes = $objDoc.selectNodes($strXPath & $strQry)
	If $objQueryNodes.length > 0 Then
		For $objNode In $objQueryNodes
			$objNodeList = $objNode.attributes
			If ($objNodeList.length) Then
				_DebugWrite("Get all attrib " & $objNodeList.length)
				ReDim $arrResponse[2][$objNodeList.length + 2]
				ReDim $aName[$objNodeList.length]
				ReDim $aValue[$objNodeList.length]
				For $i = 0 To $objNodeList.length - 1
					$arrResponse[0][$i + 1] = $objNodeList.item($i).nodeName
					$arrResponse[1][$i + 1] = $objNodeList.item($i).Value
					$aName[$i] = $objNodeList.item($i).nodeName
					$aValue[$i] = $objNodeList.item($i).Value
				Next
			Else
				_XMLError("No Attributes found for node")
				Return SetError(1, 0, -1)
			EndIf
		Next
		$arrResponse[0][0] = $objNodeList.length
		Return $arrResponse
	EndIf
	_XMLError("Error retrieving attributes for: " & $strXPath & @CRLF)
	Return SetError(1, 0, -1)
	;	EndIf
EndFunc   ;==>_XMLGetAllAttrib
; #FUNCTION# ===================================================================
; Name ..........: _XMLUpdateField
; Description ...: Update existing node(s) based on XPath specs.
; Syntax.........:  _XMLUpdateField($strXPath, $strData)
; Parameters ....: $strXPath      - Path from root node.
;                  $strData       - The data to update the node with.
; Return values .: Success        - 1
;                  Failure        - -1 and sets @error to 1.
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......: Weaponx
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLUpdateField(ByRef $objDoc,$strXPath, $strData)
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLUpdateField")
		Return SetError(1, 9, -1)
	EndIf
	Local $objField, $fUpdate, $objNode
	#forceref $objField
	$objField = $objDoc.selectSingleNode($strXPath)
	If IsObj($objField) Then
		If $objField.hasChildNodes Then
			For $objChild In $objField.childNodes()
				If $objChild.nodetype = $NODE_TEXT Then
					$objChild.Text = $strData
					$fUpdate = True
					ExitLoop
				EndIf
			Next
		EndIf
		If $fUpdate = False Then
			$objNode = $objDoc.createTextNode($strData)
			$objField.appendChild($objNode)
		EndIf
		_XMLSaveDoc($strFile)
		$objField = ""
		Return 1
	EndIf
	_XMLError("Failed to update field for: " & $strXPath & @CRLF)
	Return SetError(1, 0, -1)

EndFunc   ;==>_XMLUpdateField

; #FUNCTION# ===================================================================
; Name ..........: _XMLUpdateField2
; Description ...: Update existing node(s) based on XPath specs.
; Syntax.........:  _XMLUpdateField2($strXPath, $strData)
; Parameters ....: $strXPath      - Path from root node.
;                  $strData       - The data to update the node with.
; Return values .: Success        - 1
; Author ........: Stephen Podhajecki (eltorro)
; Modified.......: Weaponx
; Remarks .......: 
; Related .......: 
; Link ..........: 
; Example .......: [yes/no]
; ================================================================================
Func _XMLUpdateField2(ByRef $objDoc,$strXPath, $strData)
    If Not IsObj($objDoc) Then
        _XMLError("No object passed to function _XMLUpdateField2")
        Return SetError(1, 9, -1)
    EndIf
    
    Local $objNodeList, $objNodeChild, $xmlerr
    
    $objNodeList = $objDoc.documentElement.selectNodes($strXPath)
    If $objNodeList.length > 0 Then
        _DebugWrite("GetValue list length:" & $objNodeList.length)
        For $objNode In $objNodeList
            If $objNode.hasChildNodes() = False Then
                ;???
            Else
                For $objNodeChild In $objNode.childNodes()
                    If $objNodeChild.nodetype = $NODE_TEXT Then
                        $objNodeChild.Text = $strData
                        $bUpdate = True
                        ExitLoop
                    EndIf
                Next
            EndIf
        Next
        Return 1
    Else
        $xmlerr = @CRLF & "No matching node(s)found!"
        Return SetError(1, 0, -1)
    EndIf
    _XMLError("Error Retrieving: " & $strXPath & $xmlerr)
    Return SetError(1, 0, -1)
EndFunc ;==>_XMLUpdateField2

; #FUNCTION# ===================================================================
; Name ..........: _XMLCreateCDATA
; Description ...: Create a CDATA SECTION node directly under root.
; Syntax.........:  _XMLCreateCDATA($strNode, $strCDATA[, $strNameSpc = ""])
; Parameters ....: $strNode       - name of node to create
;                  $strData       - CDATA value
;                  $strNameSpc    - the namespace to specifiy if the xml uses one.
; Return values .: Success        - 1
;                  Failure        - 1 and sets @Error to 1.
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......: fixme, won't append to exisiting node. must create new node.
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLCreateCDATA(ByRef $objDoc,$strNode, $strCDATA, $strNameSpc = "")
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLCreateCDATA")
		Return SetError(1, 10, -1)
	EndIf
	Local $objChild, $objNode
	$objNode = $objDoc.createNode($NODE_ELEMENT, $strNode, $strNameSpc)
	If IsObj($objNode) Then
		If Not ($objNode.hasChildNodes()) Then
			_AddFormat($objDoc, $objNode)
		EndIf
		$objChild = $objDoc.createCDATASection($strCDATA)
		$objNode.appendChild($objChild)
		$objDoc.documentElement.appendChild($objNode)
		_XMLSaveDoc($strFile)
		_AddFormat($objDoc)
		$objChild = ""
		Return 1
	EndIf
	_XMLError("Failed to create CDATA Section: " & $strNode & @CRLF)
	Return SetError(1, 0, -1)
EndFunc   ;==>_XMLCreateCDATA
; #FUNCTION# ===================================================================
; Name ..........: _XMLCreateComment
; Description ...: Create a COMMENT node at specified path.
; Syntax.........:  _XMLCreateComment($strNode, $strComment)
; Parameters ....: $strNode       - The name of node to create.
;                  $strComment    - The comment to add the to the xml file.
; Return values .: Success        - 1
;                  Failure        - -1 and @error set to 1.
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLCreateComment(ByRef $objDoc,$strNode, $strComment)
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLCreateComment")
		Return SetError(1, 11, -1)
	EndIf
	Local $objChild, $objNode

	$objNode = $objDoc.selectSingleNode($strNode)
	If IsObj($objNode) Then
		If Not ($objNode.hasChildNodes()) Then
			_AddFormat($objDoc, $objNode)
		EndIf
		$objChild = $objDoc.createComment($strComment)
		$objNode.insertBefore($objChild, $objNode.childNodes(0))
		_XMLSaveDoc($strFile)
		_AddFormat($objDoc)
		$objChild = ""
		Return 1
	EndIf
	_XMLError("Failed to root child: " & $strNode & @CRLF)
	Return SetError(1, 0, -1)
EndFunc   ;==>_XMLCreateComment
; #FUNCTION# ===================================================================
; Name ..........: _XMLCreateAttribute
; Description ...: Adds an XML Attribute to specified node.
; Syntax.........:  _XMLCreateAttrib($strXPath, $strAttrName[, $strAttrValue = ""])
; Parameters ....: $strXPath      - The XML tree path from root node (root/child/child..)
;                  $strAttrName   - The attribute to set.
;                  $strAttrValue  - The value to give the attribute, defaults to "".
; Return values .: Success        - 1
;                  Failure        - 0 or @error set to 0 and return -1
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLCreateAttrib(ByRef $objDoc,$strXPath, $strAttrName, $strAttrValue = "")
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLCreateAttrib")
		Return SetError(1, 12, -1)
	EndIf
	Local $objNode, $objAttr, $objAttrVal, $err
	$objNode = $objDoc.selectSingleNode($strXPath)
	If IsObj($objNode) Then
		$objAttr = $objDoc.createAttribute($strAttrName);, $strNameSpc)
		$objNode.SetAttribute($strAttrName, $strAttrValue)
		_XMLSaveDoc($strFile)
		$objAttr = 0
		$objAttrVal = 0
		$objNode = 0
		$err = $objDoc.parseError.errorCode
		If $err = 0 Then Return 1
	EndIf
	_XMLError("Error creating Attribute: " & $strAttrName & @CRLF & $strXPath & " does not exist." & @CRLF)
	Return 0
EndFunc   ;==>_XMLCreateAttrib
; #FUNCTION# ===================================================================
; Name ..........: _XMLCreateRootChild
; Description ...: Create node directly under root.
; Syntax.........:  _XMLCreateRootChild($strNode[, $strData = ""[, $strNameSpc = ""]])
; Parameters ....: $strNode       - The name of node to create.
;                  $strData       - The optional value to create
;                  $$strNameSpc   - the namespace to specifiy if the file uses one.
; Return values .: Success        - 1
;                  Failure        - -1 and @error set to 1.
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLCreateRootChild(ByRef $objDoc,$strNode, $strData = "", $strNameSpc = "")
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLCreateRootChild")
		Return SetError(1, 14, -1)
	EndIf
	;ConsoleWrite("_XMLCreateRootChild:"&$strNode&@LF)
	Local $objChild
	If Not ($objDoc.documentElement.hasChildNodes()) Then
		_AddFormat($objDoc)
	EndIf
	$objChild = $objDoc.createNode($NODE_ELEMENT, $strNode, $strNameSpc)
	If IsObj($objChild) Then
		If $strData <> "" Then $objChild.text = $strData
		$objDoc.documentElement.appendChild($objChild)
		_XMLSaveDoc($strFile)
		_AddFormat($objDoc)
		$objChild = 0
		Return 1
	EndIf
	_XMLError("Failed to root child: " & $strNode & @CRLF)
	Return SetError(1, 0, -1)
EndFunc   ;==>_XMLCreateRootChild
; #FUNCTION# ===================================================================
; Name ..........: _XMLCreateRootNodeWAttr
; Description ...: Create a child node under root node with attributes.
; Syntax.........:  _XMLCreateRootNodeWAttr($strNode, $aAttr, $aVal[, $strData = ""[, $strNameSpc = ""]])
; Parameters ....: $strNode       - The node to add with attibute(s)
;                  $aAttr         - The attribute name(s) -- can be array
;                  $aVal          - The	attribute value(s) -- can be array
;                  $strData       - The optional value to give the node.
; Return values .: Success        - 1
;                  Failure        - -1 and @error set to:
;                  |1 - Could not create node.
;                  |2 - Mismatch between attribute name and value counts.
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......: This function requires that each attribute name has	a corresponding value.
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLCreateRootNodeWAttr(ByRef $objDoc,$strNode, $aAttr, $aVal, $strData = "", $strNameSpc = "")
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLCreateRootNodeWAttr")
		Return SetError(1, 15, -1)
	EndIf
	Local $objChild, $objAttr, $objAttrVal
	$objChild = $objDoc.createNode($NODE_ELEMENT, $strNode, $strNameSpc)
	If IsObj($objChild) Then
		If $strData <> "" Then $objChild.text = $strData
		If Not ($objDoc.documentElement.hasChildNodes()) Then
			_AddFormat($objDoc)
		EndIf
		If IsArray($aAttr) And IsArray($aVal) Then
			If UBound($aAttr) <> UBound($aVal) Then
				_XMLError("Attribute and value mismatch" & @CRLF & "Please make sure each attribute has a matching value.")
				Return SetError(2, 15, -1)
			Else
				Local $i
				For $i = 0 To UBound($aAttr) - 1
					If $aAttr[$i] = "" Then
						_XMLError("Error creating child node: " & $strNode & @CRLF & " Attribute Name Cannot be NULL." & @CRLF)
						Return SetError(1, 0, -1)
					EndIf
					$objAttr = $objDoc.createAttribute($aAttr[$i]);, $strNameSpc)
					$objChild.SetAttribute($aAttr[$i], $aVal[$i])
				Next
			EndIf
		Else
			$objAttr = $objDoc.createAttribute($aAttr)
			$objChild.SetAttribute($aAttr, $aVal)
		EndIf
		$objDoc.documentElement.appendChild($objChild)
		_XMLSaveDoc($strFile)
		_AddFormat($objDoc)
		$objChild = 0
		Return 1
	EndIf
	_XMLError("Failed to create root child with attributes: " & $strNode & @CRLF)
	Return SetError(1, 0, -1)
EndFunc   ;==>_XMLCreateRootNodeWAttr
; #FUNCTION# ===================================================================
; Name ..........: _XMLCreateChildNode
; Description ...: Create a child node under the specified XPath Node.
; Syntax.........:  _XMLCreateChildNode($strXPath, $strNode[, $strData = ""[, $strNameSpc = ""]])
; Parameters ....: $strXPath      - The node from root.
;                  $strNode       - Node name to add.
;                  $strData       - Value to give the node
; Return values .: Success        - 1
;                  Failure        - -1 and @error set to 1.
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLCreateChildNode(ByRef $objDoc,$strXPath, $strNode, $strData = "", $strNameSpc = "")
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLCreateChildNode")
		Return SetError(1, 16, -1)
	EndIf
	Local $objParent, $objChild, $objNodeList
	$objNodeList = $objDoc.selectNodes($strXPath)
	If IsObj($objNodeList) And $objNodeList.length > 0 Then
		For $objParent In $objNodeList
			If Not ($objParent.hasChildNodes()) Then
				_AddFormat($objDoc, $objParent)
			EndIf
			If $strNameSpc = "" Then
				If Not ($objParent.namespaceURI = 0 Or $objParent.namespaceURI = "") Then $strNameSpc = $objParent.namespaceURI
			EndIf
			;ConsoleWrite("$strNameSpc=" & $strNameSpc & @LF)
			$objChild = $objDoc.createNode($NODE_ELEMENT, $strNode, $strNameSpc)
			If $strData <> "" Then $objChild.text = $strData
			$objParent.appendChild($objChild)
			_AddFormat($objDoc, $objParent)
		Next
		_XMLSaveDoc($strFile)
		$objParent = ""
		$objChild = ""
		Return 1
	EndIf
	_XMLError("Error creating child node: " & $strNode & @CRLF & $strXPath & " does not exist." & @CRLF)
	Return SetError(1, 0, -1)
EndFunc   ;==>_XMLCreateChildNode
; #FUNCTION# ===================================================================
; Name ..........: _XMLCreateChildNodeWAttr
; Description ...: Create a child node(s) under the specified XPath Node with attributes.
; Syntax.........:  _XMLCreateChildNodeWAttr($strXPath, $strNode, $aAttr, $aVal[, $strData = ""[, $strNameSpc = ""]])
; Parameters ....: $sPath         - Path from root
;                  $sNode         - node to add with attibute(s)
;                  $aAttr         - The attribute name(s) -- can be array
;                  $aVal          - The	attribute value(s) -- can be array
;                  $strData       - The optional value to give the child node.
; Return values .: Success        - 1
;                  Failure        - -1, @error set to:
;                  |1 - Could not create node.
;                  |2 - Mismatch between attribute name and value counts.
;                  |3 - Attribute Name cannot be empty string.
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......: This function requires that each attribute name has	a corresponding value.
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLCreateChildNodeWAttr(ByRef $objDoc,$strXPath, $strNode, $aAttr, $aVal, $strData = "", $strNameSpc = "")
	Return _XMLCreateChildWAttr($strXPath, $strNode, $aAttr, $aVal, $strData, $strNameSpc)
EndFunc   ;==>_XMLCreateChildNodeWAttr

; #FUNCTION# ===================================================================
; Name ..........: _XMLCreateChildWAttr
; Description ...: Create a child node(s) under the specified XPath Node with attributes.
; Syntax.........:  _XMLCreateChildWAttr($strXPath, $strNode, $aAttr, $aVal[, $strData = ""[, $strNameSpc = ""]])
; Parameters ....: $sPath         - Path from root
;                  $sNode         - The node to add with attibute(s)
;                  $aAttr         - The attribute name(s) -- can be array
;                  $aVal          - The	attribute value(s) -- can be array
;                  $strData       - The optional value to give the child node.
; Return values .: Success        - 1
;                  Failure        - -1, @error set to:
;                  |1 - Could not create node.
;                  |2 - Mismatch between attribute name and value counts.
;                  |3 - Attribute Name cannot be empty string.
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......: This function requires that each attribute name has	a corresponding value.
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLCreateChildWAttr(ByRef $objDoc,$strXPath, $strNode, $aAttr, $aVal, $strData = "", $strNameSpc = "")
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLCreateChildWAttr")
		Return SetError(1, 18, -1)
	EndIf
	Local $objParent, $objChild, $objAttr, $objAttrVal, $objNodeList
	$objNodeList = $objDoc.selectNodes($strXPath)
	_DebugWrite("Node Selected")
	If IsObj($objNodeList) And $objNodeList.length <> 0 Then
		_DebugWrite("Entering if")
		For $objParent In $objNodeList
			If Not ($objParent.hasChildNodes()) Then
				_AddFormat($objDoc, $objParent)
			EndIf
			_DebugWrite("Entering for")
			If $strNameSpc = "" Then
				If Not ($objParent.namespaceURI = 0 Or $objParent.namespaceURI = "") Then $strNameSpc = $objParent.namespaceURI
			EndIf
			$objChild = $objDoc.createNode($NODE_ELEMENT, $strNode, $strNameSpc)
			If @error Then Return -1
			If $strData <> "" Then $objChild.text = $strData
			If IsArray($aAttr) And IsArray($aVal) Then
				If UBound($aAttr) <> UBound($aVal) Then
					_XMLError("Attribute and value mismatch" & @CRLF & "Please make sure each attribute has a matching value.")
					Return SetError(2, 0, -1)
				Else
					Local $i
					For $i = 0 To UBound($aAttr) - 1
						_DebugWrite("Entering inside for")
						If $aAttr[$i] = "" Then
							_XMLError("Error creating child node: " & $strNode & @CRLF & " Attribute Name Cannot be NULL." & @CRLF)
							Return SetError(1, 0, -1)
						EndIf
						_DebugWrite($aAttr[$i] & " " & $strNameSpc)
						$objAttr = $objDoc.createAttribute($aAttr[$i]);, $strNameSpc)
						If @error Then ExitLoop
						$objChild.SetAttribute($aAttr[$i], $aVal[$i])
						If @error <> 0 Then
							_XMLError("Error creating child node: " & $strNode & @CRLF & $strXPath & " does not exist." & @CRLF)
							Return SetError(1, 0, -1)
						EndIf
						_DebugWrite("Looping inside for")
					Next
				EndIf
			Else
				If IsArray($aAttr) Or IsArray($aVal) Then
					_XMLError("Type non-Array and Array detected" & @LF)
					Return SetError(1, 0, -1)
				EndIf
				If $aAttr = "" Then
					_XMLError("Attribute Name cannot be empty string." & @LF)
					Return SetError(3, 0, -1)
				EndIf
				_DebugWrite($aAttr & " " & $strNameSpc)
				$objAttr = $objDoc.createAttribute($aAttr);, $strNameSpc)
				$objChild.SetAttribute($aAttr, $aVal)
			EndIf
			$objParent.appendChild($objChild)
			_DebugWrite("Looping for")
		Next
		_AddFormat($objDoc, $objParent)
		_XMLSaveDoc($strFile)
		_DebugWrite("Saved")
		$objParent = ""
		$objChild = ""
		_DebugWrite("Returning")
		Return 1
	EndIf
	_XMLError("Error creating child node: " & $strNode & @CRLF & $strXPath & " does not exist." & @CRLF)
	Return SetError(1, 0, -1)
EndFunc   ;==>_XMLCreateChildWAttr
; #FUNCTION# ===================================================================
; Name ..........: _XMLGetChildText
; Description ...: Selects XML child Node(s) of an element based on XPath input from root node.
; Syntax.........:  _XMLGetChildText($strXPath)
; Parameters ....: $strXPath      - The xml tree path from root node (root/child/child..)
; Return values .: Success        - An array of Nodes.
;                  Failure        - -1 and @error set to 1.
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLGetChildText(ByRef $objDoc,$strXPath)
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLGetChildText")
		Return SetError(1, 19, -1)
	EndIf
	Local $objNodeList, $arrResponse[1], $xmlerr
	$objNodeList = $objDoc.selectSingleNode($strXPath)
	If Not IsObj($objNodeList) Then
		_XMLError(@CRLF & "No Matching Nodes found")
		$arrResponse[0] = 0
		Return SetError(1, 0, -1)
	EndIf
	If $objNodeList.hasChildNodes() Then
		For $objChild In $objNodeList.childNodes()
			If $objChild.nodeType = $NODE_ELEMENT Then
				_XMLArrayAdd($arrResponse, $objChild.baseName)
			ElseIf $objChild.nodeType = $NODE_TEXT Then
				_XMLArrayAdd($arrResponse, $objChild.text)
			EndIf
		Next
		$arrResponse[0] = UBound($arrResponse) - 1
		Return $arrResponse
	EndIf
	$arrResponse[0] = 0
	$xmlerr = @CRLF & "No Child Text Nodes found"
	_XMLError("Error Selecting Node(s): " & $strXPath & $xmlerr)
	Return SetError(1, 0, -1)
EndFunc   ;==>_XMLGetChildText
; #FUNCTION# ===================================================================
; Name ..........: _XMLGetChildNodes
; Description ...: Selects XML child Node(s) of an element based on XPath input from root node.
; Syntax.........:  _XMLGetChildNodes($strXPath)
; Parameters ....: $strXPath      - The xml tree path from root node (root/child/child..)
; Return values .: Success        - An array of Nodes, count in [0] element.
;                  Failure        - -1 and @error set to 1.
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLGetChildNodes(ByRef $objDoc,$strXPath)
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLGetChildNodes")
		Return SetError(1, 20, -1)
	EndIf
	Local $objNodeList, $arrResponse[1], $xmlerr
	$objNodeList = $objDoc.selectSingleNode($strXPath)
	If Not IsObj($objNodeList) Then
		_XMLError(@LF & "No Matching Nodes found")
		$arrResponse[0] = 0
		Return SetError(1, 0, -1)
	EndIf
	If $objNodeList.hasChildNodes() Then
		For $objChild In $objNodeList.childNodes()
			If $objChild.nodeType() = $NODE_ELEMENT Then
				_DebugWrite($objChild.NamespaceURI & "::" & $objChild.baseName & @LF)
				_XMLArrayAdd($arrResponse, $objChild.baseName)
			EndIf
		Next
		$arrResponse[0] = UBound($arrResponse) - 1
		Return $arrResponse
	EndIf
	$arrResponse[0] = 0
	$xmlerr = @LF & "No Child Nodes found"
	_XMLError("Error Selecting Node(s): " & $strXPath & $xmlerr)
	Return SetError(1, 0, -1)
EndFunc   ;==>_XMLGetChildNodes
; #FUNCTION# ===================================================================
; Name ..........: _XMLGetChildren
; Description ...: Selects XML child Node(s) of an element based on XPath input from root node and returns there text values.
; Syntax.........:  _XMLGetChildren($strXPath)
; Parameters ....: $strXPath      - The XML tree path from root node (root/child/child..)
; Return values .: Success        - An array where:
;                  |$array[0][0] = Size of array
;                  |$array[1][0] = Name
;                  |$array[1][1] = Text
;                  |$array[1][2] = NameSpaceURI
;                  |...
;                  |$array[n][0] = Name
;                  |$array[n][1] = Text
;                  |$array[n][2] = NamespaceURI
;                  Failure        - -1 and @error set to 1.
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLGetChildren(ByRef $objDoc,$strXPath)
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLGetChildren")
		Return SetError(1, 21, -1)
	EndIf
	Local $objNodeList, $arrResponse[1][3], $xmlerr
	$objNodeList = $objDoc.selectSingleNode($strXPath)
	If Not IsObj($objNodeList) Then
		_XMLError(@LF & "No Matching Nodes found")
		$arrResponse[0][0] = 0
		Return SetError(1, 0, -1)
	EndIf
	If $objNodeList.hasChildNodes() Then
		For $objChild In $objNodeList.childNodes()
			If $objChild.nodeType() = $NODE_ElEMENT Then
				If $objChild.hasChildNodes() Then
					For $objChildNode in $objChild.childNodes()
						If $objChildNode.nodeType() =  $NODE_TEXT Then
							Local $dims = UBound($arrResponse, 1)
							ReDim $arrResponse[$dims + 1][3]
							$arrResponse[$dims][0] = $objChildNode.parentNode.baseName
							$arrResponse[$dims][1] = $objChildNode.text
							$arrResponse[$dims][2] = $objChildNode.NamespaceURI
							;_XMLArrayAdd($arrResponse, $objChild.baseName)
						EndIf
					Next
				EndIf	
            EndIf
		Next
		$arrResponse[0][0] = UBound($arrResponse, 1) - 1
		Return $arrResponse
	EndIf
	$arrResponse[0][0] = 0
	$xmlerr = @LF & "No Child Nodes found"
	_XMLError("Error Selecting Node(s): " & $strXPath & $xmlerr)
	Return SetError(1, 0, -1)
EndFunc   ;==>_XMLGetChildren

; #FUNCTION# ===================================================================
; Name ..........: _XMLGetNodeCount
; Description ...: Get Node Count based on XPath input from root node.
; Syntax.........:  _XMLGetNodeCount($strXPath[, $strQry = ""[, $iNodeType = 1]])
; Parameters ....: $strXPath      - The XML tree path from root node (root/child/child..
;                  $strQry        - A DOM compliant query string (not really necessary as it becomes part of the path
;                  $iNodeType     - The type of node to count. (element, attrib, comment etc.)
; Return values .: Success        - Number of nodes found (can be 0)
;                  Failure        - -1 and @error set to 1.
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com> & DickB
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLGetNodeCount(ByRef $objDoc,$strXPath, $strQry = "", $iNodeType = 1)
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLGetNodeCount")
		Return SetError(1, 22, -1)
	EndIf
	Local $objQueryNodes, $objNode, $nodeCount = 0, $errMsg
	$objQueryNodes = $objDoc.selectNodes($strXPath & $strQry)
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
;part of the path
; #FUNCTION# ===================================================================
; Name ..........: _XMLGetAllAttribIndex
; Description ...: Get all XML Field(s) attributes based on Xpathn and specific index.
; Syntax.........:  _XMLGetAllAttribIndex($strXPath, ByRef $aName, ByRef $aValue[, $strQry = ""[, $iNodeIndex = 0]])
; Parameters ....: $strXpath      - The xml tree path from root node (root/child/child..)
;                  $aNames        - The array to return the attrib names in.
;                  $aValue        - The array to return the attrib values in.
;                  $strQry        - DOM compliant query string (not really necessary as it becomes
;                  $iNodeIndex    - The index of node to retrieve.
; Return values .: Success        - The number of elements.
;                  Failure        - -1 and @error set to 1.
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLGetAllAttribIndex(ByRef $objDoc, $strXPath, ByRef $aName, ByRef $aValue, $strQry = "", $iNodeIndex = 0)
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLGetAllAttribIndex")
		Return SetError(1, 23, -1)
	EndIf
	Local $objNodeList, $objQueryNodes, $i ;, $arrResponse[2][1]
	$objQueryNodes = $objDoc.selectNodes($strXPath & $strQry)
	If $objQueryNodes.length > 0 Then
		$objNodeList = $objQueryNodes.item($iNodeIndex).attributes
		_DebugWrite("GetAllAttribIndex " & $objNodeList.length)
		;ReDim $arrResponse[2][$objNodeList.length + 1]
		ReDim $aName[$objNodeList.length]
		ReDim $aValue[$objNodeList.length]
		For $i = 0 To $objNodeList.length - 1
			;$arrResponse[0][$i] = $objNodeList.item ($i).nodeName
			;$arrResponse[1][$i] = $objNodeList.item ($i).Value
			$aName[$i] = $objNodeList.item($i).nodeName
			$aValue[$i] = $objNodeList.item($i).Value
		Next
		;Return $arrResponse
		Return $objNodeList.length
	EndIf
	_XMLError("Error retrieving attributes for: " & $strXPath & @CRLF)
	Return SetError(1, 0, -1)
EndFunc   ;==>_XMLGetAllAttribIndex
; #FUNCTION# ===================================================================
; Name ..........: _XMLGetPath
; Description ...: Return a nodes full path based on XPath input from root node.
; Syntax.........:  _XMLGetPath($strXPath)
; Parameters ....: $strXPath      - The XML tree path from root node (root/child/child..)
; Return values .: Success        - An array of node names from root, count in [0] element.
;                  Failure        - -1 and @error set to 1.
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLGetPath(ByRef $objDoc, $strXPath)
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLGetPath")
		Return SetError(1, 24, -1)
	EndIf
	If $DOMVERSION < 4 Then
		_XMLError("Error DOM Version: " & "MSXML Version 4 or greater required for this function")
		Return SetError(1, 0, -1)
	EndIf
	Local $objNodeList, $arrResponse[1], $objNodeChild, $xmlerr, $nodepath, $ns
	$objNodeList = $objDoc.selectNodes($strXPath)
	If $objNodeList.length > 0 Then
		_DebugWrite("GetPath list length:" & $objNodeList.length)
		For $objNode In $objNodeList
			Local $objNode1 = $objNode
			$nodepath = ""
			$nodepathtag = ""
			If $objNode.nodeType <> $NODE_DOCUMENT Then
				$ns = $objNode.namespaceURI()
				If $ns <> "" Then
					$ns = StringRight($ns, StringLen($ns) - StringInStr($ns, "/", 0, -1)) & ":"
				EndIf
				If $ns = 0 Then $ns = ""
				$nodepath = "/" & $ns & $objNode.nodeName() & $nodepath
			EndIf
			Do
				$objParent = $objNode1.parentNode()
				_DebugWrite("parent " & $objParent.nodeName() & @LF)
				If $objParent.nodeType <> $NODE_DOCUMENT Then
					$ns = $objParent.namespaceURI()
					If $ns <> "" Then
						;$ns = StringRight($ns, StringLen($ns) - StringInStr($ns, "/", 0, -1)) & ":"
						$ns &= ":"
					EndIf
					If $ns = 0 Then $ns = ""
					$nodepath = "/" & $ns & $objParent.nodeName() & $nodepath
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
	EndIf
	$xmlerr = @CRLF & "No matching node(s)found!"
	_XMLError("Error Retrieving: " & $strXPath & $xmlerr)
	Return SetError(1, 0, -1)
EndFunc   ;==>_XMLGetPath

; #FUNCTION# ===================================================================
; Function Name	 :	_XMLGetPathInternal
; Description ...: Returns the path of a valid node object.
; Syntax ........:  _XMLGetPathInternal($objNode)
; Parameters ....: $objNode       - A valid node object
; Return values .: Success        - Path from root as string.
;                  Failure        - An empty string and @error set to 1.
; Author ........: Stephen Podhajecki <gehossafats at netmdc.com/>
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLGetPathInternal($objNode)
	If Not IsObj($objNode) Then
		_XMLError("No object passed to function _XMLGetPathInternal")
		Return SetError(1, 25, "")
	EndIf
	Local $nodepath, $na, $objParent
	If IsObj($objNode) Then
		$nodepath = "/" & $objNode.baseName
		Do
			$objParent = $objNode.parentNode()
			_DebugWrite("parent" & $objParent.nodeName() & ">" & @LF)
			If $objParent.nodeType <> $NODE_DOCUMENT Then
				$ns = $objParent.namespaceURI()
				If $ns = 0 Then $ns = ""
				If $ns <> "" Then
					$ns = StringRight($ns, StringLen($ns) - StringInStr($ns, "/", 0, -1)) & ":"
				EndIf
				$nodepath = "/" & $ns & $objParent.nodeName() & $nodepath
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
;					http://www.perfectxml.com/msxmlAnswers.asp?Row_ID=65
; #FUNCTION# ===================================================================
; Name ..........: _XMLReplaceChild
; Description ...: Replaces a node with another
; Syntax.........:  _XMLReplaceChild($objOldNode, $objNewNode[, $ns = ""])
; Parameters ....: $objOldNode    - The node to replace
;                  $objNewNode    - The replacement node.
; Return values .: Success        - 1.
;                  Failure        - -1 and @error set to 1.
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com> adapted from
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLReplaceChild(ByRef $objDoc,$objOldNode, $objNewNode, $ns = "")
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLReplaceChild")
		Return SetError(1, 26, -1)
	EndIf
	If $objOldNode = "" Or $objNewNode = "" Then Return SetError(1)
	Local $nodeRoot
	Local $nodeOld
	Local $nodeNew
	Local $nodeTemp
	Local $fSuccess = False
	;No error handling done
	With $objDoc
		;;.Load "c:\books.xml"
		$nodeRoot = .documentElement
		$oldNodes = $nodeRoot.selectNodes($objOldNode)
		;'For each Node
		For $nodeOld In $oldNodes
			;Create a New element
			$nodeNew = .createNode($NODE_ELEMENT, $objNewNode, $ns)
			;Copy attributes
			For $nodeTemp In $nodeOld.Attributes
				$nodeNew.Attributes.setNamedItem($nodeTemp.cloneNode(True))
			Next
			;Copy Child Nodes
			For $nodeTemp In $nodeOld.childNodes
				$nodeNew.appendChild($nodeTemp)
			Next
			;Replace with the renamed node
			If IsObj($nodeOld.parentNode.replaceChild($nodeNew, $nodeOld)) Then $fSuccess = 1
			If Not ($objDoc.parseError.errorCode = 0) Then
				_XMLError("_XMLReplaceChild:" & @LF & "Error Replacing Child: " & _
						$objDoc.parseError.errorCode & _
						" " & $objDoc.parseError.reason)
				$fSuccess = False
				ExitLoop
			Else
				$fSuccess = True
			EndIf
		Next
		.save($strFile)
	EndWith
	$nodeRoot = 0
	$nodeOld = 0
	$nodeNew = 0
	$nodeTemp = 0
	If ($fSuccess = False) Then Return SetError(1, 0, -1)
	Return 1
EndFunc   ;==>_XMLReplaceChild
; #FUNCTION# ===================================================================
; Name ..........: _XMLSchemaValidate
; Description ...: Validates a document against a dtd.
; Syntax.........:  _XMLSchemaValidate($sXMLFile, $strNameSpc, $sXSDFile)
; Parameters ....: $sXMLFile      - The file to validate
;                  $strNameSpc    - xml namespace
;                  $sXSDFile      - DTD file to validate against.
; Return values .: Success        - 1
;                  Failure        - -1 and @error set to 1.
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLSchemaValidate(ByRef $objDoc,$sXMLFile, $strNameSpc, $sXSDFile)
	Local $cache, $xmldoc
	$cache = ObjCreate("Msxml2.XMLSchemaCache." & $DOMVERSION & ".0")
	If Not IsObj($cache) Then
		MsgBox(266288, "XML Error", "Unable to instantiate the XML object" & @LF & "Please check your components.")
		Return SetError(1, 0, -1)
	EndIf
	$cache.add($strNameSpc, $sXSDFile)
	$xmldoc = ObjCreate("Msxml2.DOMDocument." & $DOMVERSION & ".0")
	If Not IsObj($xmldoc) Then
		MsgBox(266288, "XML Error", "Unable to instantiate the XML object" & @LF & "Please check your components.")
		Return SetError(1, 0, -1)
	EndIf
	$xmldoc.async = False
	$xmldoc.schemas = $cache
	$xmldoc.load($sXMLFile)
	If Not ($xmldoc.parseError.errorCode = 0) Then
		_XMLError("_XMLSchemaValidate:" & @LF & "Error: " & $xmldoc.parseError.errorCode & " " & $xmldoc.parseError.reason)
		Return SetError($xmldoc.parseError.errorCode)
	EndIf
	Return 1
EndFunc   ;==>_XMLSchemaValidate
; #FUNCTION# ===================================================================
; Name ..........: _XMLGetDomVersion
; Description ...: Returns the version of msxml that is in use for the document.
; Syntax.........:  _XMLGetDomVersion()
; Parameters ....:                none
; Return values .: Success        - msxml version
;                  Failure        - 0
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLGetDomVersion()
	Return $DOMVERSION
EndFunc   ;==>_XMLGetDomVersion
; #FUNCTION# ===================================================================
; Name ..........: _XMLError
; Description ...: Sets or Gets error message that may be generated by the UDF functs.
; Syntax.........:  _XMLError($sError = "")
; Parameters ....: $sError        - Error message to set.
; Return values .: Success        - one of the following:
;                  |$sError <> "" - Nothing.
;                  |$sError = "" - Last error set.
;                  Failure        - Nothing.
; Author ........: Stephen Podhajecki <gehossafats@netmdc.com>
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLError($sError = "")
	If $sError = "" Then
		$sError = $sXML_error
		$sXML_error = ""
		Return $sError
	Else
		$sXML_error = StringFormat($sError)
	EndIf
	_DebugWrite($sXML_error)
EndFunc   ;==>_XMLError
; From the forum this came.
; #FUNCTION# ===================================================================
; Name ..........: _XMLCOMEerr
; Description ...: Displays a message box with the COM Error.
; Syntax.........:  _XMLCOMEerr()
; Parameters ....:                None
; Return values .:
; Author ........: SvenP 's error handler
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLCOMEerr()
	_ComErrorHandler()
	Return
EndFunc   ;==>_XMLCOMEerr
; #FUNCTION# ===================================================================
; Name ..........: _ComErrorHandler
; Description ...: A COM error handling routine.
; Syntax.........: _ComErrorHandler($quiet = "")
; Parameters ....: $quiet - Work silently
; Return values .: None
; Author ........: 
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _ComErrorHandler($quiet = "")
	Local $COMErr_Silent, $HexNumber
	; ==============================================================================
	;added silent switch to allow the func returned to the option to display custom
	;error messages
	If $quiet = True Or $quiet = False Then
		$COMErr_Silent = $quiet
		$quiet = ""
	EndIf
	; ==============================================================================
	$HexNumber = Hex($oXMLMyError.number, 8)
	If @error Then Return
	Local $msg = "COM Error with DOM!" & @CRLF & @CRLF & _
			"err.description is: " & @TAB & $oXMLMyError.description & @CRLF & _
			"err.windescription:" & @TAB & $oXMLMyError.windescription & @CRLF & _
			"err.number is: " & @TAB & $HexNumber & @CRLF & _
			"err.lastdllerror is: " & @TAB & $oXMLMyError.lastdllerror & @CRLF & _
			"err.scriptline is: " & @TAB & $oXMLMyError.scriptline & @CRLF & _
			"err.source is: " & @TAB & $oXMLMyError.source & @CRLF & _
			"err.helpfile is: " & @TAB & $oXMLMyError.helpfile & @CRLF & _
			"err.helpcontext is: " & @TAB & $oXMLMyError.helpcontext
	If $COMErr_Silent <> True Then
		MsgBox(0, @AutoItExe, $msg)
	Else
		_XMLError($msg)
	EndIf
	SetError(1)
EndFunc   ;==>_ComErrorHandler
; simple helper functions
; #FUNCTION# ===================================================================
; Name ..........: _DebugWrite
; Description ...: Writes a message to console with a crlf on the end
; Syntax.........:  _DebugWrite($strMsg[, $sLineEnding = @LF])
; Parameters ....: $strMsg        - The message to display
;                  $sLineEnding   - Line ending to add
; Return values .: On Succes      - None.
;                  Failure        - None.
; Author ........:
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _DebugWrite($strMsg, $sLineEnding = @LF)
	If $fDEBUGGING Then
		ConsoleWrite(StringFormat($strMsg) & $sLineEnding)
	EndIf
EndFunc   ;==>_DebugWrite
; #FUNCTION# ===================================================================
; Name ..........: _Notifier
; Description ...: displays a simple "ok" messagebox
; Syntax.........:  _Notifier($Notifier_msg)
; Parameters ....: $Notifier_Msg  - The message to display
; Return values .: On Succes      - None.
;                  Failure        - None.
; Author ........:
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _Notifier($Notifier_msg)
	MsgBox(266288, @ScriptName, $Notifier_msg)
EndFunc   ;==>_Notifier
; #FUNCTION# ===================================================================
; Name ..........: _SetDebug
; Description ...: Turn debugging info on or off
; Syntax.........:  _SetDebug($fDbug = True)
; Parameters ....: $fDbug         - Boolean value for debugging.
; Return values .: Success        - The debugging state.
; Author ........:
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _SetDebug($fDbug = True)
	$fDEBUGGING = $fDbug
	_DebugWrite("Debug = " & $fDEBUGGING)
	Return $fDEBUGGING
EndFunc   ;==>_SetDebug
; #FUNCTION# ===================================================================
; Name ..........: _XMLUDFVersion
; Description ...: Returns UDF version number
; Syntax.........:  _XMLUDFVersion()
; Parameters ....:                None
; Return values .: Success        - The UDF version number
; Author ........: Stephen Podhajecki
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLUDFVersion()
	Return $_XMLUDFVER
EndFunc   ;==>_XMLUDFVersion
; #FUNCTION# ===================================================================
; Name ..........: _XMLTransform
; Description ...:
; Syntax.........:  _XMLTransform([$oXMLDoc = ""[, $Style = ""[, $szNewDoc = ""]]])
; Parameters ....: $oXMLDoc       - The document to transform
;                  $Style         - The stylesheet to use
;                  $szNewDoc      - Save to this file.
; Return values .: Success        - Returns True
;                  Failure        - -1 and @error set to 1.
; Author ........: Stephen Podhajecki <gehossafats at netmdc dot com>, Modified by WeaponX
; Modified ......:
; Remarks .......: Default stylesheet is used for indenting.
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLTransform($oXMLDoc = "", $Style = "", $szNewDoc = "")
	If $oXMLDoc = "" Then
		$oXMLDoc = $objDoc
	EndIf
	If Not IsObj($oXMLDoc) Then
		_XMLError("No object passed to function _XMLTransform")
		Return SetError(1, 29, -1)
	EndIf
	Local $fIndented = False
	Local $xslt = ObjCreate("MSXML2.XSLTemplate." & $DOMVERSION & ".0")
	Local $xslDoc = ObjCreate("MSXML2.FreeThreadedDOMDocument." & $DOMVERSION & ".0")
	Local $xmldoc = ObjCreate("MSXML2.DOMDocument." & $DOMVERSION & ".0")
	Local $xslProc
	$xslDoc.async = False
	If FileExists($Style) Then
		_DebugWrite("LoadXML:1:" & $xslDoc.load($Style) & @LF)
	Else
		_DebugWrite("LoadXML2:" & $xslDoc.loadXML(_GetDefaultStyleSheet()) & @LF)
	EndIf
	If $xslDoc.parseError.errorCode <> 0 Then
		_XMLError("Error Transforming NodeToObject: " & $xslDoc.parseError.reason)
	EndIf
	
	$xslt.stylesheet = $xslDoc
	$xslProc = $xslt.createProcessor()
	$xslProc.input = $objDoc
	$oXMLDoc.transformNodeToObject($xslDoc, $xmldoc)
	If $oXMLDoc.parseError.errorCode <> 0 Then
		_XMLError("_XMLTransform:" & @LF & "Error Transforming NodeToObject: " & $oXMLDoc.parseError.reason)
		$fIndented = False
	Else
		$fIndented = True
	EndIf
	If $fIndented Then
		;Write transformed xml to a file if a filename is given
		If $szNewDoc <> "" Then
			$xmldoc.save($szNewDoc)
			If $xmldoc.parseError.errorCode <> 0 Then
				_XMLError("_XMLTransform:" & @LF & "Error Saving: " & $xmldoc.parseError.reason)
				$fIndented = False
			EndIf
		Else
			;Overwrite original object with transformed object
			$objDoc = $xmldoc
			_XMLSaveDoc($strFile)
			If $oXMLDoc.parseError.errorCode <> 0 Then
				_XMLError("_XMLTransform:" & @LF & "Error Saving: " & $oXMLDoc.parseError.reason)
				$fIndented = False
			EndIf
		EndIf
	EndIf
	$xslProc = 0
	$xslt = 0
	$xslDoc = 0
	$xmldoc = 0
	If $fIndented = False Then Return SetError(1, 0, -1)
	Return $fIndented
EndFunc   ;==>_XMLTransform
; #INTERNAL_USE_ONLY#==========================================================
; Name ..........: _GetDefaultStyleSheet
; Description ...: Internal function, returns the default indenting style sheet.
; Syntax.........:  _GetDefaultStyleSheet()
; Parameters ....:
; Return values .: Success        - The default stylesheet.
;                  Failure        - Nothing.
; Author ........: Hew Wolff - Art & Logic, Inc.
; Modified ......:
; Remarks .......: Posted all over the web.
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _GetDefaultStyleSheet()

	Return '<?xml version="1.0" encoding="UTF-8"?>' & _
			'<!--' & _
			'Converts XML into a nice readable format.' & _
			'Tested with Saxon 6.5.3.' & _
			'As a test, this stylesheet should not change when run on itself.' & _
			'But note that there are no guarantees about attribute order within an' & _
			'element (see http://www.w3.org/TR/xpath#dt-document-order), or about' & _
			'which characters are escaped (see' & _
			'http://www.w3.org/TR/xslt#disable-output-escaping).' & _
			'I did not test processing instructions, CDATA sections, or' & _
			'namespaces.' & _
			'Hew Wolff' & _
			'Senior Engineer' & _
			'Art & Logic, Inc.' & _
			'www.artlogic.com' & _
			'-->' & _
			'<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">' & _
			'<!-- Take control of the whitespace. -->' & _
			'<xsl:output method="xml" indent="no" encoding="UTF-8"/>' & _
			'<xsl:strip-space elements="*"/>' & _
			'<xsl:preserve-space elements="xsl:text"/>' & _
			'<!-- Copy comments, and elements recursively. -->' & _
			'<xsl:template match="*|comment()">' & _
			'<xsl:param name="depth">0</xsl:param>' & _
			'<!--' & _
			'Set off from the element above if one of the two has children.' & _
			'Also, set off a comment from an element.' & _
			'And set off from the XML declaration if necessary.' & _
			'-->' & _
			'<xsl:variable name="isFirstNode" select="count(../..) = 0 and position() = 1"/>' & _
			'<xsl:variable name="previous" select="preceding-sibling::node()[1]"/>' & _
			'<xsl:variable name="adjacentComplexElement" select="count($previous/*) &gt; 0 or count(*) &gt; 0"/>' & _
			'<xsl:variable name="adjacentDifferentType" select="not(($previous/self::comment() and self::comment()) or ($previous/self::* and self::*))"/>' & _
			'<xsl:if test="$isFirstNode or ($previous and ($adjacentComplexElement or $adjacentDifferentType))">' & _
			'<xsl:text>&#xA;</xsl:text>' & _
			'</xsl:if>' & _
			'<!-- Start a new line.' & _
			'<xsl:text>&#xA;</xsl:text> -->' & _
			'<xsl:call-template name="indent">' & _
			'<xsl:with-param name="depth" select="$depth"/>' & _
			'</xsl:call-template>' & _
			'<xsl:copy>' & _
			'<xsl:if test="self::*">' & _
			'<xsl:copy-of select="@*"/>' & _
			'<xsl:apply-templates>' & _
			'<xsl:with-param name="depth" select="$depth + 1"/>' & _
			'</xsl:apply-templates>' & _
			'<xsl:if test="count(*) &gt; 0">' & _
			'<xsl:text>&#xA;</xsl:text>' & _
			'<xsl:call-template name="indent">' & _
			'<xsl:with-param name="depth" select="$depth"/>' & _
			'</xsl:call-template>' & _
			'</xsl:if>' & _
			'</xsl:if>' & _
			'</xsl:copy>' & _
			'<xsl:variable name="isLastNode" select="count(../..) = 0 and position() = last()"/>' & _
			'<xsl:if test="$isLastNode">' & _
			'<xsl:text>&#xA;</xsl:text>' & _
			'</xsl:if>' & _
			'</xsl:template>' & _
			'<xsl:template name="indent">' & _
			'<xsl:param name="depth"/>' & _
			'<xsl:if test="$depth &gt; 0">' & _
			'<xsl:text>   </xsl:text>' & _
			'<xsl:call-template name="indent">' & _
			'<xsl:with-param name="depth" select="$depth - 1"/>' & _
			'</xsl:call-template>' & _
			'</xsl:if>' & _
			'</xsl:template>' & _
			'<!-- Escape newlines within text nodes, for readability. -->' & _
			'<xsl:template match="text()">' & _
			'<xsl:call-template name="escapeNewlines">' & _
			'<xsl:with-param name="text">' & _
			'<xsl:value-of select="."/>' & _
			'</xsl:with-param>' & _
			'</xsl:call-template>' & _
			'</xsl:template>' & _
			'<xsl:template name="escapeNewlines">' & _
			'<xsl:param name="text"/>' & _
			'<xsl:if test="string-length($text) &gt; 0">' & _
			'<xsl:choose>' & _
			'<xsl:when test="substring($text, 1, 1) = ' & "'#xA;'" & '">' & _
			'<xsl:text disable-output-escaping="yes">&amp;#xA;</xsl:text>' & _
			'</xsl:when>' & _
			'<xsl:otherwise>' & _
			'<xsl:value-of select="substring($text, 1, 1)"/>' & _
			'</xsl:otherwise>' & _
			'</xsl:choose>' & _
			'<xsl:call-template name="escapeNewlines">' & _
			'<xsl:with-param name="text" select="substring($text, 2)"/>' & _
			'</xsl:call-template>' & _
			'</xsl:if>' & _
			'</xsl:template>' & _
			'</xsl:stylesheet>'
EndFunc   ;==>_GetDefaultStyleSheet
; #INTERNAL_USE_ONLY#==========================================================
; Name ..........: _AddFormat
; Description ...:
; Syntax.........:  _AddFormat($objDoc[, $objParent = ""])
; Parameters ....: $objDoc	       - Document to format
;                  $objParent     - Optional node to add formatting to
; Return values .: Success        - 1
;                  Failure        - -1 and @error set to 1.
; Author ........: Stephen Podhajecki <gehossafats a t netmdc.com>
; Modified ......:
; Remarks .......: Just break up the tags, no indenting is done here.
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _AddFormat($objDoc, $objParent = "")
	If $fADDFORMATTING = True Then
		If Not IsObj($objDoc) Then
			_XMLError("No object passed to function _XMLAddFormat")
			Return SetError(1, 30, -1)
		EndIf
		$objFormat = $objDoc.createTextNode(@CR)
		If IsObj($objParent) Then
			$objParent.appendChild($objFormat)
		Else
			$objDoc.documentElement.appendChild($objFormat)
		EndIf
		_XMLSaveDoc($strFile)
	EndIf
	Return 1
EndFunc   ;==>_AddFormat
; #FUNCTION# ===================================================================
; Name ..........: _XMLSetAutoSave
; Description ...: Set the automatic save to on or off
; Syntax.........:  _XMLSetAutoSave($fSave = True)
; Parameters ....: $fSave         - Boolean value to set automatic saving.
; Return values .: Success        - Previous state of autosave.
; Author ........: Stephen Podhajecki <gehossafats a t netmdc.com>
; Modified ......:
; Remarks .......: Defaults to true.
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLSetAutoSave($fSave = True)
	Local $oldSave = $fXMLAUTOSAVE
	$fXMLAUTOSAVE = Not $fXMLAUTOSAVE
	Return $oldSave
EndFunc   ;==>_XMLSetAutoSave

; #FUNCTION# ===================================================================
; Name ..........: _XMLSetAutoFormat
; Description ...: Turn auto formatting on or off
; Syntax.........:  _XMLSetAutoFormat($fAutoFormat = True)
; Parameters ....: $fAutoFormat   - Boolean flag for automatic formatting
; Return values .: Success        - The previous state.
;                  Failure        - Nothing.
; Author ........: Stephen Podhajecki {gehossafats at netmdc. com}
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLSetAutoFormat($fAutoFormat = True)
	Local $oldFormat = $fADDFORMATTING
	$fADDFORMATTING = $fAutoFormat
	Return $oldFormat
EndFunc   ;==>_XMLSetAutoFormat



; #FUNCTION# ===================================================================
; Name ..........: _XMLSaveDoc
; Description ...: Save the current xml doc
; Syntax.........:  _XMLSaveDoc([$sFile=""[,$iForce = 0]])
; Parameters ....: $sFile         - The filename to save the xml doc as.
;                  $iForce        - If true, save the file regardless of autosave state.
; Return values .: Success        - 1
;                  Failure        - -1 and @error set to the following:
;                  |1 - error trying to save.
;                  |2 - Autosave is off.
;                  |3 - No filename given for save and default is blank.
; Author ........: Stephen Podhajecki {gehossafats at netmdc. com}
; Modified ......:
; Remarks .......: Defaults to the current filename.
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLSaveDoc(ByRef $objDoc,$sFile = "", $iForce = 0)
	If ($fXMLAUTOSAVE = True) Or ($iForce = 1) Then
		If $sFile = "" Then $sFile = $strFile
		If $sFile <> "" Then
			$objDoc.save($sFile)
			If $objDoc.parseError.errorCode <> 0 Then
				_XMLError("_XMLSaveDoc: Saving " & $sFile & " failed.:" & @LF & _
						$objDoc.parseError.errorCode & _
						" " & $objDoc.parseError.reason)
				Return SetError(1, 0, -1)
			EndIf
			Return 1
		Else
			_XMLError("_XMLSaveDoc:" & " Error Saving: No Filename given")
			Return SetError(3, 0, -1)
		EndIf
	EndIf
	Return SetError(2, 0, 1)
EndFunc   ;==>_XMLSaveDoc

; #FUNCTION# ===================================================================
; Name ..........: _XMLNodeExists
; Description ...: Checks for the existence of a node or nodes matching the specified path
; Syntax.........:  _XMLNodeExists($strXPath)
; Parameters ....: $strXPath      - Path to check for.
; Return values .: Success        - 1 or Higher , 0
;                  Failure        -	0 and @Error set to:
;                  |0 - No error.
;                  |1 - No XML object @extended = 31.
;                  |2 - Node not found.
; Author ........: Stephen Podhajecki <gehossafats a t netmdc.com>
; Modified ......:
; Remarks .......: Returns the number of nodes found (could be greater than 1)
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
Func _XMLNodeExists(ByRef $objDoc,$strXPath)
	If Not IsObj($objDoc) Then
		_XMLError("No object passed to function _XMLNodeExists")
		Return SetError(1, 31, 0)
	EndIf
	Local $objNode, $iCount
	Local $objNode = $objDoc.SelectNodes($strXPath)
	If IsObj($objNode) Then $iCount = $objNode.length
	$objNode = 0
	If $iCount Then Return $iCount
	Return SetError(2, 0, 0)
EndFunc   ;==>_XMLNodeExists

; #INTERNAL_USE_ONLY#==========================================================
; Name ..........: _XMLArrayAdd
; Description ...: Adds an item to an array.
; Syntax.........:  _XMLArrayAdd(ByRef $avArray, $sValue)
; Parameters ....: $avArray       - The array to modify.
;                  $sValue        - The value to add to the array.
; Return values .: Success        - 1 and value added to array.
;                  Failure        - 0 and @error set to 1
; Author ........:
; Modified ......:
; Remarks .......: Local version of _ArrayAdd to remove dependency on Array.au3
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
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

; #FUNCTION# =====================================================================
; Name ..........: _XMLGetParent
; Description ...: Gets the parent node name of the node pointed to by the XPath
; Syntax ........: _XMLGetParent($strXPath)
; Parameters ....: $strXPath - IN -
; Return values .: 
; Author ........: Mike Rerick <mrerick@iwsinc.com>
; Modified.......: 
; Remarks .......: Returns empty string if the XPath is not valid
; Related .......: 
; Link ..........: 
; Example .......: [yes/no]
; ================================================================================
Func _XMLGetParent($strXPath)
    Local $objNodeList, $arrResponse[1], $objNodeChild, $xmlerr, $nodepath, $ns
   Local $parentName = ""

    If not IsObj($objDoc) then
        _XMLError("No object passed to function _XMLGetParent")
        Return SetError(1,24,-1)
    EndIf

   If $DOMVERSION < 4 Then
        _XMLError("Error DOM Version: " & "MSXML Version 4 or greater required for this function")
        Return SetError(1,0,-1)
    EndIf

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

         $objParent = $objNode1.parentNode ()
         _DebugWrite("parent " & $objParent.nodeName () & @LF)
         If $objParent.nodeType <> $NODE_DOCUMENT Then
            $ns = $objParent.namespaceURI ()
            If $ns <> "" Then
               $ns &=":"
            EndIf
            if $ns =0 then $ns= ""
            $nodepath = "/" &$ns  & $objParent.nodeName ()& $nodepath
            $objNode1 = $objParent
            $parentName = $objParent.nodeName()
         Else
            $objNode1 = 0
         EndIf
         $objParent = 0
            _DebugWrite("Path node> " & $nodepath & @LF)
            _XMLArrayAdd($arrResponse, $nodepath)
        Next

        $arrResponse[0] = UBound($arrResponse) - 1
        Return $parentName
    EndIf

    $xmlerr = @CRLF & "No matching node(s)found!"
    _XMLError("Error Retrieving: " & $strXPath & $xmlerr)
    SetError(1,0,-1)
   Return $parentName
EndFunc   ;==>_XMLGetParent
 