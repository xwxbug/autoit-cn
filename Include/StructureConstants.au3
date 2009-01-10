#include-once

; #INDEX# =======================================================================================================================
; Title .........: Structures
; AutoIt Version: 3.2.++
; Description:    Structures.
; ===============================================================================================================================

;==============================================================================================================================
; #LISTING# =====================================================================================================================
;$tagNMHDR
;$tagCOMBOBOXEXITEM
;$tagNMCBEDRAGBEGIN
;$tagNMCBEENDEDIT
;$tagNMCOMBOBOXEX
;$tagDTPRANGE
;$tagDTPTIME
;$tagNMDATETIMECHANGE
;$tagNMDATETIMEFORMAT
;$tagNMDATETIMEFORMATQUERY
;$tagNMDATETIMEKEYDOWN
;$tagNMDATETIMESTRING
;$tagEVENTLOGRECORD
;$tagGDIPBITMAPDATA
;$tagGDIPENCODERPARAM
;$tagGDIPENCODERPARAMS
;$tagGDIPRECTF
;$tagGDIPSTARTUPINPUT
;$tagGDIPSTARTUPOUTPUT
;$tagGDIPIMAGECODECINFO
;$tagGDIPPENCODERPARAMS
;$tagHDITEM
;$tagNMHDDISPINFO
;$tagNMHDFILTERBTNCLICK
;$tagNMHEADER
;$tagGETIPAddress
;$tagNMIPADDRESS
;$tagLVHITTESTINFO
;$tagLVITEM
;$tagNMLISTVIEW
;$tagNMLVCUSTOMDRAW
;$tagNMLVDISPINFO
;$tagNMLVFINDITEM
;$tagNMLVGETINFOTIP
;$tagNMITEMACTIVATE
;$tagNMLVKEYDOWN
;$tagNMLVSCROLL
;$tagMCHITTESTINFO
;$tagMCMONTHRANGE
;$tagMCRANGE
;$tagMCSELRANGE
;$tagNMDAYSTATE
;$tagNMSELCHANGE
;$tagNMOBJECTNOTIFY
;$tagNMTCKEYDOWN
;$tagTVITEMEX
;$tagNMTREEVIEW
;$tagNMTVCUSTOMDRAW
;$tagNMTVDISPINFO
;$tagNMTVGETINFOTIP
;$tagTVHITTESTINFO
;$tagNMTVKEYDOWN
;$tagNMMOUSE
;$tagPOINT
;$tagRECT
;$tagMargins
;$tagSIZE
;$tagTOKEN_PRIVILEGES
;$tagIMAGEINFO
;$tagMENUINFO
;$tagMENUITEMINFO
;$tagFILETIME
;$tagSYSTEMTIME
;$tagTIME_ZONE_INFORMATION
;$tagREBARBANDINFO
;$tagNMREBARAUTOBREAK
;$tagNMRBAUTOSIZE
;$tagNMREBAR
;$tagNMREBARCHEVRON
;$tagNMREBARCHILDSIZE
;$tagCOLORSCHEME
;$tagNMTOOLBAR
;$tagNMTBHOTITEM
;$tagTBBUTTON
;$tagTBBUTTONINFO
;$tagNETRESOURCE
;$tagOVERLAPPED
;$tagOPENFILENAME
;$tagBITMAPINFO
;$tagBLENDFUNCTION
;$tagGUID
;$tagWINDOWPLACEMENT
;$tagWINDOWPOS
;$tagSCROLLINFO
;$tagSCROLLBARINFO
;$tagLOGFONT
;$tagKBDLLHOOKSTRUCT
;$tagPROCESS_INFORMATION
;$tagSTARTUPINFO
;$tagSECURITY_ATTRIBUTES
; ===============================================================================================================================

; #INTERNAL_USE_ONLY#============================================================================================================
;$tagCOMBOBOXINFO
;$tagEDITBALLOONTIP
;$tagEVENTREAD
;$tagHDHITTESTINFO
;$tagHDLAYOUT
;$tagHDTEXTFILTER
;$tagLVBKIMAGE
;$tagLVCOLUMN
;$tagLVFINDINFO
;$tagLVGROUP
;$tagLVINSERTMARK
;$tagLVSETINFOTIP
;$tagTCHITTESTINFO
;$tagTCITEM
;$tagNMTTDISPINFO
;$tagTTGETTITLE
;$tagTTHITTESTINFO
;$tagTVINSERTSTRUCT
;$tagBORDERS
;$tagCHOOSECOLOR
;$tagCHOOSEFONT
;$tagTEXTMETRIC
;$tagCURSORINFO
;$tagDISPLAY_DEVICE
;$tagFLASHWINDOW
;$tagICONINFO
;$tagIMAGELISTDRAWPARAMS
;$tagMEMMAP
;$tagMDINEXTMENU
;$tagMENUBARINFO
;$tagMENUEX_TEMPLATE_HEADER
;$tagMENUEX_TEMPLATE_ITEM
;$tagMENUGETOBJECTINFO
;$tagMENUITEMTEMPLATE
;$tagMENUITEMTEMPLATEHEADER
;$tagTPMPARAMS
;$tagCONNECTION_INFO_1
;$tagFILE_INFO_3
;$tagSESSION_INFO_2
;$tagSESSION_INFO_502
;$tagSHARE_INFO_2
;$tagSTAT_SERVER_0
;$tagSTAT_WORKSTATION_0
;$tagPBRANGE
;$tagREBARINFO
;$tagTBADDBITMAP
;$tagTBINSERTMARK
;$tagTBMETRICS
;$tagCONNECTDLGSTRUCT
;$tagDISCDLGSTRUCT
;$tagNETCONNECTINFOSTRUCT
;$tagNETINFOSTRUCT
;$tagREMOTENAMEINFO
;$tagTOOLINFO
;================================================================================================================================

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMHDR
; Description ...: Contains information about a notification message
; Fields ........: hWndFrom - Window handle to the control sending a message
;                  IDFrom   - Identifier of the control sending a message
;                  Code     - Notification code
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMHDR = "hwnd hWndFrom;int IDFrom;int Code"

; ===============================================================================================================================
; *******************************************************************************************************************************
; ComboBox Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagCOMBOBOXINFO
; Description ...: Contains combo box status information
; Fields ........: cbSize      - The size, in bytes, of the structure. The calling application must set this to sizeof(COMBOBOXINFO).
;                  rcItem      - A RECT structure that specifies the coordinates of the edit box.
;                  |EditLeft
;                  |EditTop
;                  |EditRight
;                  |EditBottom
;                  rcButton    - A RECT structure that specifies the coordinates of the button that contains the drop-down arrow.
;                  |BtnLeft
;                  |BtnTop
;                  |BtnRight
;                  |BtnBottom
;                  stateButton - The combo box button state. This parameter can be one of the following values.
;                  |0                       - The button exists and is not pressed.
;                  |$STATE_SYSTEM_INVISIBLE - There is no button.
;                  |$STATE_SYSTEM_PRESSED   - The button is pressed.
;                  hCombo      - A handle to the combo box.
;                  hEdit       - A handle to the edit box.
;                  hList       - A handle to the drop-down list.
; Author ........: Gary Frost (gafrost)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagCOMBOBOXINFO = "dword Size;int EditLeft;int EditTop;int EditRight;int EditBottom;int BtnLeft;int BtnTop;" & _
		"int BtnRight;int BtnBottom;dword BtnState;hwnd hCombo;hwnd hEdit;hwnd hList"

; ===============================================================================================================================
; *******************************************************************************************************************************
; ComboBoxEx Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; #STRUCTURE# ===================================================================================================================
; Name...........: $tagCOMBOBOXEXITEM
; Description ...: Contains information about an item in a ComboBoxEx control
; Fields ........: Mask                 - A set of bit flags that specify attributes.  Can be a combination of the following values.
;                  |CBEIF_DI_SETITEM    - Set this flag when processing CBEN_GETDISPINFO
;                  |CBEIF_IMAGE         - The iImage member is valid or must be filled in.
;                  |CBEIF_INDENT        - The iIndent member is valid or must be filled in.
;                  |CBEIF_LPARAM        - The lParam member is valid or must be filled in.
;                  |CBEIF_OVERLAY       - The iOverlay member is valid or must be filled in.
;                  |CBEIF_SELECTEDIMAGE - The iSelectedImage member is valid or must be filled in.
;                  |CBEIF_TEXT          - The pszText member is valid or must be filled in.
;                  Item                 - The zero-based index of the item.
;                  pszText              - A pointer to a character buffer that contains or receives the item's text.
;                  TextMax              - The length of pszText, in TCHARs. If text information is being set, this member is ignored.
;                  Image                - The zero-based index of an image within the image list.
;                  SelectedImage        - The zero-based index of an image within the image list.
;                  OverlayImage         - The one-based index of an overlay image within the image list.
;                  Indent               - The number of indent spaces to display for the item. Each indentation equals 10 pixels.
;                  Param                - A value specific to the item.
; Author ........: Gary Frost (gafrost)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagCOMBOBOXEXITEM = "int Mask;int Item;ptr Text;int TextMax;int Image;int SelectedImage;int OverlayImage;" & _
		"int Indent;int Param"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMCBEDRAGBEGIN
; Description ...: Contains information used with the $CBEN_DRAGBEGIN notification message
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  ItemID               - The zero-based index of the item being dragged.  This value will always be -1,
;                  +indicating that the item being dragged is the item displayed in the edit portion of the control.
;                  Text                 - The character buffer that contains the text of the item being dragged
; Author ........: Gary Frost (gafrost)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMCBEDRAGBEGIN = $tagNMHDR & ";int ItemID;char Text[1024]"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMCBEENDEDIT
; Description ...: Contains information about the conclusion of an edit operation within a ComboBoxEx control
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  fChanged             - Indicating whether the contents of the control's edit box have changed
;                  NewSelection         - The zero-based index of the item that will be selected after completing the edit operation
;                  +This value can be $CB_ERR if no item will be selected
;                  Text                  - A zero-terminated string that contains the text from within the control's edit box
;                  Why                   - The action that generated the $CBEN_ENDEDIT notification message
;                  +This value can be one of the following:
;                  |$CBENF_DROPDOWN      - The user activated the drop-down list
;                  |$CBENF_ESCAPE        - The user pressed ESC
;                  |$CBENF_KILLFOCUS     - The edit box lost the keyboard focus
;                  |$CBENF_RETURN        - The user completed the edit operation by pressing ENTER
; Author ........: Gary Frost (gafrost)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMCBEENDEDIT = $tagNMHDR & ";int fChanged;int NewSelection;char Text[1024];int Why"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMCOMBOBOXEX
; Description ...: Contains information specific to ComboBoxEx items for use with notification messages
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  Mask                 - A set of bit flags that specify attributes.  Can be a combination of the following values.
;                  |CBEIF_DI_SETITEM    - Set this flag when processing CBEN_GETDISPINFO
;                  |CBEIF_IMAGE         - The iImage member is valid or must be filled in.
;                  |CBEIF_INDENT        - The iIndent member is valid or must be filled in.
;                  |CBEIF_LPARAM        - The lParam member is valid or must be filled in.
;                  |CBEIF_OVERLAY       - The iOverlay member is valid or must be filled in.
;                  |CBEIF_SELECTEDIMAGE - The iSelectedImage member is valid or must be filled in.
;                  |CBEIF_TEXT          - The pszText member is valid or must be filled in.
;                  Item                 - The zero-based index of the item.
;                  pszText              - A pointer to a character buffer that contains or receives the item's text.
;                  TextMax              - The length of pszText, in TCHARs. If text information is being set, this member is ignored.
;                  Image                - The zero-based index of an image within the image list.
;                  SelectedImage        - The zero-based index of an image within the image list.
;                  OverlayImage         - The one-based index of an overlay image within the image list.
;                  Indent               - The number of indent spaces to display for the item. Each indentation equals 10 pixels.
;                  Param                - A value specific to the item.
; Author ........: Gary Frost (gafrost)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMCOMBOBOXEX = $tagNMHDR & ";int Mask;int Item;ptr Text;int TextMax;int Image;" & _
		"int SelectedImage;int OverlayImage;int Indent;int Param"

; ===============================================================================================================================
; *******************************************************************************************************************************
; Date/Time Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; #STRUCTURE# ===================================================================================================================
; Name...........: $tagDTPRANGE
; Description ...: Specifies a date and time, in coordinated universal time (UTC)
; Fields ........: MinYear    - Minimum year
;                  MinMonth   - Minimum month
;                  MinDOW     - Minimum day of week
;                  MinDay     - Minimum day
;                  MinHour    - Minimum hour
;                  MinMinute  - Minimum minute
;                  MinSecond  - Minimum second
;                  MinMSecond - Minimum milliseconds
;                  MaxYear    - Maximum year
;                  MaxMonth   - Maximum month
;                  MaxDOW     - Maximum day of week
;                  MaxDay     - Maximum day
;                  MaxHour    - Maximum hour
;                  MaxMaxute  - Maximum Minute
;                  MaxSecond  - Maximum second
;                  MaxMSecond - Maximum milliseconds
;                  MinValid   - If True, minimum data is valid
;                  MaxValid   - If True, maximum data is valid
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagDTPRANGE = "short MinYear;short MinMonth;short MinDOW;short MinDay;short MinHour;short MinMinute;" & _
		"short MinSecond;short MinMSecond;short MaxYear;short MaxMonth;short MaxDOW;short MaxDay;short MaxHour;" & _
		"short MaxMinute;short MaxSecond;short MaxMSecond;int MinValid;int MaxValid"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagDTPTIME
; Description ...: Specifies a date and time, in coordinated universal time (UTC)
; Fields ........: Year    - Year
;                  Month   - Month
;                  DOW     - Day of week
;                  Day     - Day
;                  Hour    - Hour
;                  Minute  - Minute
;                  Second  - Second
;                  MSecond - Milliseconds
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagDTPTIME = "short Year;short Month;short DOW;short Day;short Hour;short Minute;short Second;short MSecond"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMDATETIMECHANGE
; Description ...: Contains information about a change that has taken place in a date and time picker (DTP) control
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  Flags   - Indicates if the control is set to "no date" status.  This flag also specifies whether the  contents
;                  +of the date are valid and contain current time information. This value can be one of the following:
;                  | $GDT_NONE  - The control is set to "no date" status
;                  | $GDT_VALID - The control is not set to the "no date" status
;                  Year    - Year
;                  Month   - Month
;                  DOW     - Day of week
;                  Day     - Day
;                  Hour    - Hour
;                  Minute  - Minute
;                  Second  - Second
;                  MSecond - Milliseconds
; Author ........: Paul Campbell (PaulIA)
; Remarks .......: This  structure  is  used  with  the $DTN_DATETIMECHANGE notification message
; ===============================================================================================================================
Global Const $tagNMDATETIMECHANGE = $tagNMHDR & ";int Flag;short Year;short Month;short DOW;short Day;" & _
		"short Hour;short Minute;short Second;short MSecond"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMDATETIMEFORMAT
; Description ...: Contains information about a portion of the format string that defines a callback field within a date and time picker (DTP) control
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  Format   - Pointer to a null terminated string that defines the control callback field.  The string  comprises
;                  +one or more "X" characters.
;                  Year     - Year
;                  Month    - Month
;                  DOW      - Day of week
;                  Day      - Day
;                  Hour     - Hour
;                  Minute   - Minute
;                  Second   - Second
;                  MSecond  - Milliseconds
;                  pDisplay - Pointer to a null terminated string that contains the display text of the control. By default, this
;                  +is the address of the Display member of this structure.  It is acceptable to have pDisplay point to an
;                  +existing string. In this case, you don't need to assign a value to Display. However, the string that pDisplay
;                  +points to must remain valid until another $DTN_FORMAT notification is sent or until the control is destroyed.
;                  Display  - 64 character buffer that is to receive the null terminated string that the control will display. It
;                  +is not necessary to fill the entire buffer.
; Author ........: Paul Campbell (PaulIA)
; Remarks .......: It carries the string that defines the callback field and contains a buffer to receive the string that will
;                  be displayed in the callback field. This structure is used with the $DTN_FORMAT notification message.
; ===============================================================================================================================
Global Const $tagNMDATETIMEFORMAT = $tagNMHDR & ";ptr Format;short Year;short Month;short DOW;short Day;" & _
		"short Hour;short Minute;short Second;short MSecond;ptr pDisplay;char Display[64]"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMDATETIMEFORMATQUERY
; Description ...: Contains information about the control callback field
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  Format  - Pointer to a null terminated string that defines the control callback field.  The string  comprises
;                  +one or more "X" characters.
;                  SizeX   - Must be filled with the maximum width of the text that will be displayed in the callback field
;                  SizeY   - Must be filled with the maximum height of the text that will be displayed in the callback field
; Author ........: Paul Campbell (PaulIA)
; Remarks .......: It contains a string (taken from the control's format string) that defines a callback field. The structure
;                  receives the maximum allowable size of the text that will be displayed in the callback field. This structure
;                  is used with the $DTN_FORMATQUERY notification message.
; ===============================================================================================================================
Global Const $tagNMDATETIMEFORMATQUERY = $tagNMHDR & ";ptr Format;int SizeX;int SizeY"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMDATETIMEKEYDOWN
; Description ...: Carries information used to describe and handle a $DTN_WMKEYDOWN notification message
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  VirtKey - Virtual key code that represents the key that the user pressed
;                  Format  - Pointer to a null terminated string that defines the control callback field.  The  string  comprises
;                  +one or more "X" characters.
;                  Year    - Year
;                  Month   - Month
;                  DOW     - Day of week
;                  Day     - Day
;                  Hour    - Hour
;                  Minute  - Minute
;                  Second  - Second
;                  MSecond - Milliseconds
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMDATETIMEKEYDOWN = $tagNMHDR & ";int VirtKey;ptr Format;short Year;short Month;short DOW;" & _
		"short Day;short Hour;short Minute;short Second;short MSecond"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMDATETIMESTRING
; Description ...: Contains information specific to an edit operation that has taken place in the control
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  UserString - Address of the null terminated string that the user entered
;                  Year       - Year
;                  Month      - Month
;                  DOW        - Day of week
;                  Day        - Day
;                  Hour       - Hour
;                  Minute     - Minute
;                  Second     - Second
;                  MSecond    - Milliseconds
;                  Flags      - Return field. Set this member to $GDT_VALID to indicate that the date is valid or to $GDT_NONE to
;                  +set the control to "no date" status ($DTS_SHOWNONE style only).
; Author ........: Paul Campbell (PaulIA)
; Remarks .......: This message is used with the $DTN_USERSTRING notification message.
; ===============================================================================================================================
Global Const $tagNMDATETIMESTRING = $tagNMHDR & ";ptr UserString;short Year;short Month;short DOW;short Day;" & _
		"short Hour;short Minute;short Second;short MSecond;int Flags"

; ===============================================================================================================================
; *******************************************************************************************************************************
; Edit Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagEDITBALLOONTIP
; Description ...: Contains information about a balloon tip
; Fields ........: Size     - Size of this structure, in bytes
;                  Title    - Pointer to the buffer that holds Title of the ToolTip
;                  Text     - Pointer to the buffer that holds Text of the ToolTip
;                  Icon     - Type of Icon.  This can be one of the following values:
;                  |$TTI_ERROR   - Use the error icon
;                  |$TTI_INFO    - Use the information icon
;                  |$TTI_NONE    - Use no icon
;                  |$TTI_WARNING - Use the warning icon
; Author ........: Gary Frost (gafrost)
; Remarks .......: For use with Edit control (minimum O.S. Win XP)
; ===============================================================================================================================
Global Const $tagEDITBALLOONTIP = "dword Size;ptr Title;ptr Text;int Icon"

; ===============================================================================================================================
; *******************************************************************************************************************************
; Event Log Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; #STRUCTURE# ===================================================================================================================
; Name...........: $tagEVENTLOGRECORD
; Description ...: Contains information about an event record
; Fields ........: Length              - The size of this event record, in bytes
;                  Reserved            - Reserved
;                  RecordNumber        - The number of the record
;                  TimeGenerated       - The time at which this entry was submitted
;                  TimeWritten         - The time at which this entry was received by the service to be written to the log
;                  EventID             - The event identifier
;                  EventType           - The type of event
;                  NumStrings          - The number of strings present in the log
;                  EventCategory       - The category for this event
;                  ReservedFlags       - Reserved
;                  ClosingRecordNumber - Reserved
;                  StringOffset        - The offset of the description strings within this event log record
;                  UserSidLength       - The size of the UserSid member, in bytes
;                  UserSidOffset       - The offset of the security identifier (SID) within this event log record
;                  DataLength          - The size of the event-specific data (at the position indicated by DataOffset), in bytes
;                  DataOffset          - The offset of the event-specific information within this event log record, in bytes
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagEVENTLOGRECORD = "int Length;int Reserved;int RecordNumber;int TimeGenerated;int TimeWritten;int EventID;" & _
		"short EventType;short NumStrings;short EventCategory;short ReservedFlags;int ClosingRecordNumber;int StringOffset;" & _
		"int UserSidLength;int UserSidOffset;int DataLength;int DataOffset"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagEVENTREAD
; Description ...: tagEVENTREAD structure
; Fields ........: Buffer    - Buffer for the data read from the event log
;                  BytesRead - The size of the buffer, in bytes
;                  BytesMin  - The number of bytes required for the next log entry
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagEVENTREAD = "byte Buffer[4096];int BytesRead;int BytesMin"

; ===============================================================================================================================
; *******************************************************************************************************************************
; GDI+ Structures
; *******************************************************************************************************************************
; ===============================================================================================================================

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagGDIPBITMAPDATA
; Description ...: Bitmap Data
; Fields ........: Width    - Number of pixels in one scan line of the bitmap
;                  Height   - Number of scan lines in the bitmap
;                  Stride   - Offset, in bytes, between consecutive scan lines of the bitmap.  If the  stride  is  positive,  the
;                  +bitmap is top-down. If the stride is negative, the bitmap is bottom-up
;                  Format   - Specifies the pixel format of the bitmap
;                  Scan0    - Pointer to the first (index 0) scan line of the bitmap
;                  Reserved - Reserved for future use
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagGDIPBITMAPDATA = "uint Width;uint Height;int Stride;uint Format;ptr Scan0;ptr Reserved"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagGDIPENCODERPARAM
; Description ...: $tagGDIPENCODERPARAM structure
; Fields ........: GUID   - Indentifies the parameter category (GDI_EPG constants)
;                  Count  - Number of values in the array pointed to by the Value member
;                  Type   - Identifies the data type of the parameters (GDI_EPT constants)
;                  Values - Pointer to an array of values. Each value has the type specified by the Type member.
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagGDIPENCODERPARAM = "byte GUID[16];dword Count;dword Type;ptr Values"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagGDIPENCODERPARAMS
; Description ...: $tagGDIPENCODERPARAMS structure
; Fields ........: Count  - Number of $tagGDIPENCODERPARAM structures in the array
;                  Params - Start of $tagGDIPENCODERPARAM structures
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagGDIPENCODERPARAMS = "dword Count;byte Params[0]"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagGDIPRECTF
; Description ...: $tagGDIPRECTF structure
; Fields ........: X      - X coordinate of upper left hand corner of rectangle
;                  Y      - Y coordinate of upper left hand corner of rectangle
;                  Width  - Rectangle width
;                  Height - Rectangle height
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagGDIPRECTF = "float X;float Y;float Width;float Height"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagGDIPSTARTUPINPUT
; Description ...: $tagGDIPSTARTUPINPUT structure
; Fields ........: Version  - Specifies the version of Microsoft Windows GDI+
;                  Callback - Pointer to a callback function that GDI+ can call, on debug builds, for assertions and warnings
;                  NoThread - Boolean value that specifies whether to suppress the GDI+ background thread. If you set this member
;                  +to True, GdiplusStartup returns a pointer to a hook function and a pointer to an  unhook  function.  You must
;                  +call those functions appropriately to replace the background thread. If you do not want to be responsible for
;                  +calling the hook and unhook functions, set this member to False.
;                  NoCodecs - Boolean value that specifies whether you want GDI+ to suppress external image codecs.  GDI+ version
;                  +1.0 does not support external image codecs, so this parameter is ignored.
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagGDIPSTARTUPINPUT = "int Version;ptr Callback;int NoThread;int NoCodecs"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagGDIPSTARTUPOUTPUT
; Description ...: $tagGDIPSTARTUPOUTPUT structure
; Fields ........: HookProc   - Receives a pointer to a hook function
;                  UnhookProc - Receives a pointer to an unhook function
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagGDIPSTARTUPOUTPUT = "ptr HookProc;ptr UnhookProc"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagGDIPIMAGECODECINFO
; Description ...: $tagGDIPIMAGECODECINFO structure
; Fields ........: CLSID      - Codec identifier (GUID structure)
;                  FormatID   - File format identifier (GUID structure)
;                  CodecName  - Pointer to a Unicode null terminated string that contains the codec name
;                  DllName    - Pointer to a Unicode null terminated string that contains the path name of the DLL in  which  the
;                  +codec resides. If the codec is not in a DLL, this pointer is 0.
;                  FormatDesc - Pointer to a Unicode null terminated string that contains the name of the file format used by the
;                  +codec.
;                  FileExt    - Pointer to a Unicode null terminated string that contains all filename extensions associated with
;                  +the codec. The extensions are separated by semicolons.
;                  MimeType   - Pointer to a null-terminated string that contains the mime type of the codec
;                  Flags      - Combination of $GDIP_ICF flags
;                  Version    - Indicates the version of the codec
;                  SigCount   - Indicates the number of signatures used by the file format associated with the codec
;                  SigSize    - Indicates the number of bytes in each signature
;                  SigPattern - Pointer to an array of bytes that contains the pattern for each signature
;                  SigMask    - Pointer to an array of bytes that contains the mask for each signature
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagGDIPIMAGECODECINFO = "byte CLSID[16];byte FormatID[16];ptr CodecName;ptr DllName;ptr FormatDesc;ptr FileExt;" & _
		"ptr MimeType;dword Flags;dword Version;dword SigCount;dword SigSize;ptr SigPattern;ptr SigMask"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagGDIPPENCODERPARAMS
; Description ...: tagGDIPPENCODERPARAMS structure
; Fields ........: Count  - Number of tagGDIPENCODERPARAM structures in the array
;                  Params - Start of tagGDIPENCODERPARAM structures
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagGDIPPENCODERPARAMS = "dword Count;byte Params[0]"

; ===============================================================================================================================
; *******************************************************************************************************************************
; Header Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagHDHITTESTINFO
; Description ...: Contains information about a hit test
; Fields ........: X     - Horizontal postion to be hit test, in client coordinates
;                  Y     - Vertical position to be hit test, in client coordinates
;                  Flags - Information about the results of a hit test
;                  Item  - If the hit test is successful, contains the index of the item at the hit test point
; Author ........: Paul Campbell (PaulIA)
; Remarks .......: This structure is used with the $HDM_HITTEST message.
; ===============================================================================================================================
Global Const $tagHDHITTESTINFO = "int X;int Y;int Flags;int Item"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagHDITEM
; Description ...: Contains information about an item in a header control
; Fields ........: Mask    - Flags indicating which other structure members contain valid data or must be filled in
;                  XY      - Width or height of the item
;                  Text    - Address of Item string
;                  hBMP    - Handle to the item bitmap
;                  TextMax - Length of the item string
;                  Fmt     - Flags that specify the item's format
;                  Param   - Application-defined item data
;                  Image   - Zero-based index of an image within the image list
;                  Order   - Order in which the item appears within the header control, from left to right
;                  Type    - Type of filter specified by pFilter
;                  pFilter - Address of an application-defined data item
;                  State   - Item state
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagHDITEM = "int Mask;int XY;ptr Text;hwnd hBMP;int TextMax;int Fmt;int Param;int Image;int Order;int Type;ptr pFilter;int State"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagHDLAYOUT
; Description ...: Contains information used to set the size and position of the control
; Fields ........: Rect      - Pointer to a RECT structure that contains the rectangle that the header control will occupy
;                  WindowPos - Pointer to a WINDOWPOS structure that receives information about the size/position of the control
; Author ........: Paul Campbell (PaulIA)
; Remarks .......: This structure is used with the $HDM_LAYOUT message
; ===============================================================================================================================
Global Const $tagHDLAYOUT = "ptr Rect;ptr WindowPos"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagHDTEXTFILTER
; Description ...: Contains information about header control text filters
; Fields ........: Text    - Pointer to the buffer containing the filter
;                  TextMax - The maximum size, in characters, for an edit control buffer
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagHDTEXTFILTER = "ptr Text;int TextMax"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMHDDISPINFO
; Description ...: Contains information used in handling $HDN_GETDISPINFO notification messages
; Fields ........: WndFrom - Window handle to the control sending a message
;                  IDFrom  - Identifier of the control sending a message
;                  Code    - Notification code
;                  Item    - Zero based index of the item in the header control
;                  Mask    - Set of bit flags specifying which members of the structure must be filled in by  the  owner  of  the
;                  +control. This value can be a combination of the following values:
;                  |$HDI_TEXT       - The Text field must be filled in
;                  |$HDI_IMAGE      - The Image field must be filled in
;                  |$HDI_LPARAM     - The lParam field must be filled in
;                  |$HDI_DI_SETITEM - A return value. Indicates that the control should store the item information  and  not  ask
;                  +for it again.
;                  Text    - Pointer to a null terminated string containing the text that will be displayed for the header item
;                  TextMax - Size of the buffer that Text points to
;                  Image   - Zero based index of an image within the image list.  The specified image will be displayed with  the
;                  +header item, but it does not take the place of the item's bitmap.  If iImage is set to $I_IMAGECALLBACK,  the
;                  +control requests image information for this item by using an $HDN_GETDISPINFO notification message.
;                  lParam  - An application-defined value to associate with the item
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMHDDISPINFO = "hwnd WndFrom;int IDFrom;int Code;int Item;int Mask;ptr Text;int TextMax;int Image;int lParam"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMHDFILTERBTNCLICK
; Description ...: Specifies or receives the attributes of a filter button click
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  Item     - Zero based index of the control to which this structure refers
;                  Left     - X coordinate of the upper left corner of the rectangle
;                  Top      - Y coordinate of the upper left corner of the rectangle
;                  Right    - X coordinate of the lower right corner of the rectangle
;                  Bottom   - Y coordinate of the lower right corner of the rectangle
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMHDFILTERBTNCLICK = $tagNMHDR & ";int Item;int Left;int Top;int Right;int Bottom"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMHEADER
; Description ...: Contains information about control notification messages
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  Item     - Zero based index of the control to which this structure refers
;                  Button   - Index of the mouse button used to generate the notification message.  This member can be one of  the
;                  +following values:
;                  |0 - Left button
;                  |1 - Right button
;                  |2 - Middle button
;                  pItem   - Optional pointer to a tagHDITEM structure containing information about the item specified  by  Item.
;                  +The mask member of the tagHDITEM structure indicates which of its members are valid.
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMHEADER = $tagNMHDR & ";int Item;int Button;ptr pItem"

; ===============================================================================================================================
; *******************************************************************************************************************************
; IPAddress Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; #STRUCTURE# ===================================================================================================================
; Name...........: $tagGETIPAddress
; Description ...: Contains information for all 4 fields of the IP Address control
; Fields ........: Field4   - contains bits 0 through 7
;                  Field3   - contains bits 8 through 15
;                  Field2   - contains bits 16 through 23
;                  Field1   - contains bits 24 through 31
; Author ........: Gary Frost (gafrost)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagGETIPAddress = "ubyte Field4;ubyte Field3;ubyte Field2;ubyte Field1"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMIPADDRESS
; Description ...: Contains information for the $IPN_FIELDCHANGED notification message
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  Field      - The zero-based number of the field that was changed.
;                  Value      - The new value of the field specified in the iField member.
;                  +While processing the $IPN_FIELDCHANGED notification, this member can be set to any value that is within the
;                  +range of the field and the control will place this new value in the field.
; Author ........: Gary Frost (gafrost)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMIPADDRESS = $tagNMHDR & ";int Field;int Value"

; ===============================================================================================================================
; *******************************************************************************************************************************
; ListView Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagLVBKIMAGE
; Description ...: Contains information about the background image of a list-view control
; Fields ........: Flags      - This member may be one or more of the following flags.  You can use the LVBKIF_SOURCE_MASK value
;                  +to mask off all but the source flags.  You can use the LVBKIF_STYLE_MASK value to mask off all but the  style
;                  +flags.
;                  |$LVBKIF_SOURCE_NONE     - The control has no background image
;                  |$LVBKIF_SOURCE_URL      - The Image member contains the URL of the background image
;                  |$LVBKIF_STYLE_NORMAL    - The background image is displayed normally
;                  |$LVBKIF_STYLE_TILE      - The background image will be tiled to fill the entire background of the control
;                  |$LVBKIF_FLAG_TILEOFFSET - You use this flag to specify the coordinates of the first tile.  This flag is valid
;                  +only if the $LVBKIF_STYLE_TILE flag is also specified. If this flag is not specified the first tile begins at
;                  +the upper-left corner of the client area.
;                  hBmp        - Not used
;                  Image       - Address of a string that contains the URL of the background image. This member is only valid if
;                  +the $LVBKIF_SOURCE_URL flag is set in Flags.  This member must be initialized to point  to  the  buffer  that
;                  +contains or receives the text before sending the message.
;                  ImageMax    - Size of the buffer at the address in Image.  If information is being sent to the  control,  this
;                  +member is ignored.
;                  XOffPercent - Percentage of the client area that the image should be offset horizontally.  For example, at  0
;                  +percent, the image will be displayed against the left edge of the control's client area.  At 50 percent,  the
;                  +image will be displayed horizontally centered in the control's client area. At 100 percent, the image will be
;                  +displayed against the right edge  of  the  control's  client  area.  This  member  is  only  valid  when  the
;                  +$LVBKIF_STYLE_NORMAL is specified in  Flags.  If  both  $LVBKIF_FLAG_TILEOFFSET  and  $LVBKIF_STYLE_TILE  are
;                  +specified in Flags, then the value specifies the pixel, not percentage offset, of the first tile.  Otherwise,
;                  +the value is ignored.
;                  YOffPercent - Percentage of the control's client area that the image should be offset vertically. For example
;                  +at 0 percent, the image will be displayed against the top edge of the control's client area.  At 50  percent,
;                  +the image will be displayed vertically centered in the control's client area.  At 100 percent, the image will
;                  +be displayed against the bottom edge of the control's client  area.  This  member  is  only  valid  when  the
;                  +$LVBKIF_STYLE_NORMAL is specified in  Flags.  If  both  $LVBKIF_FLAG_TILEOFFSET  and  $LVBKIF_STYLE_TILE  are
;                  +specified in Flags, then the value specifies the pixel, not percentage offset, of the first tile.  Otherwise,
;                  +the value is ignored.
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagLVBKIMAGE = "int Flags;hwnd hBmp;int Image;int ImageMax;int XOffPercent;int YOffPercent"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagLVCOLUMN
; Description ...: Contains information about a column in report view
; Fields ........: Mask    - Variable specifying which members contain valid information.  This member can be zero,  or  one  or
;                  +more of the following values:
;                  |LVCF_FMT     - The Fmt member is valid
;                  |LVCF_WIDTH   - The CX member is valid
;                  |LVCF_TEXT    - The Text member is valid
;                  |LVCF_SUBITEM - The SubItem member is valid
;                  |LVCF_IMAGE   - The Image member is valid
;                  |LVCF_ORDER   - The Order member is valid.
;                  Fmt     - Alignment of the column header and the subitem text in the column.  This member can be one  of  the
;                  +following values. The alignment of the leftmost column is always left-justified; it cannot be changed:
;                  |LVCFMT_LEFT            - Text is left-aligned
;                  |LVCFMT_RIGHT           - Text is right-aligned
;                  |LVCFMT_CENTER          - Text is centered
;                  |LVCFMT_JUSTIFYMASK     - A bitmask used to select those bits of Fmt that control field justification
;                  |LVCFMT_IMAGE           - The item displays an image from an image list
;                  |LVCFMT_BITMAP_ON_RIGHT - The bitmap appears to the right of text
;                  |LVCFMT_COL_HAS_IMAGES  - The header item contains an image in the image list.
;                  CX      - Width of the column, in pixels
;                  Text    - If column information is being set, this member is the address of a string that contains the column
;                  +header text.  If the structure is receiving information about a column, this member specifies the address  of
;                  +the buffer that receives the column header text.
;                  TextMax - Size of the buffer pointed to by the Text member.  If the structure is  not  receiving  information
;                  +about a column, this member is ignored.
;                  SubItem - Index of subitem associated with the column
;                  Image   - Zero based index of an image within the image list
;                  Order   - Zero-based column offset. Column offset is in left-to-right order.
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagLVCOLUMN = "int Mask;int Fmt;int CX;ptr Text;int TextMax;int SubItem;int Image;int Order"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagLVFINDINFO
; Description ...: Contains information used when searching for a list-view item
; Fields ........: Flags     - Type of search to perform. This member can be set to one or more of the following values:
;                  |$LVFI_PARAM    - Searches for a match between this structure's Param member and the Param member of an item.
;                  +If $LVFI_PARAM is specified, all other flags are ignored.
;                  |$LVFI_PARTIAL  - Checks to see if the item text begins with the string pointed to by the Text  member.  This
;                  +value implies use of $LVFI_STRING.
;                  |$LVFI_STRING   - Searches based on the item text.  Unless additional values are specified, the item text  of
;                  +the matching item must exactly match the string pointed to by the Text member.
;                  |$LVFI_WRAP     - Continues the search at the beginning if no match is found
;                  |LVFI_NEARESTXY - Finds the item nearest to the position specified in the X and Y members, in  the  direction
;                  +specified by the Direction member. This flag is supported only by large icon and small icon modes.
;                  Text      - Address of a string to compare with the item text.  It is valid if $LVFI_STRING or  $LVFI_PARTIAL
;                  +is set in the Flags member.
;                  Param     - Value to compare with the Param member of an item's  $LVITEM  structure.  It  is  valid  only  if
;                  +$LVFI_PARAM is set in the flags member.
;                  X         - Initial X search position. It is valid only if $LVFI_NEARESTXY is set in the Flags member.
;                  Y         - Initial Y search position. It is valid only if $LVFI_NEARESTXY is set in the Flags member.
;                  Direction - Virtual key code that specifies the direction to search. The following codes are supported:
;                  |VK_LEFT
;                  |VK_RIGHT
;                  |VK_UP
;                  |VK_DOWN
;                  |VK_HOME
;                  |VK_END
;                  |VK_PRIOR
;                  |VK_NEXT
;                  |This member is valid only if $LVFI_NEARESTXY is set in the flags member.
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagLVFINDINFO = "int Flags;ptr Text;int Param;int X;int Y;int Direction"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagLVGROUP
; Description ...: Used to set and retrieve groups
; Fields ........: Size      - Size of this structure, in bytes
;                  Mask      - Mask that specifies which members of the structure are valid input.  Can be one or  more  of  the
;                  +following values:
;                  |$LVGF_NONE    - No other items are valid
;                  |$LVGF_HEADER  - Header and HeaderMax members are valid
;                  |$LVGF_FOOTER  - Reserved
;                  |$LVGF_STATE   - Reserved
;                  |$LVGF_ALIGN   - Align member is valid
;                  |$LVGF_GROUPID - GroupId member is valid
;                  Header    - Pointer to a string that contains the header text when item information is being  set.  If  group
;                  +information is being retrieved this member specifies the address of the buffer that receives the header text.
;                  HeaderMax - Size of the buffer pointed to by the Header member. If the structure is not receiving information
;                  +about a group, this member is ignored.
;                  Footer    - Reserved
;                  FooterMax - Reserved
;                  GroupID   - ID of the group
;                  StateMask - Reserved
;                  State     - Reserved
;                  Align     - Indicates the alignment of the header text.  It can have one or more of the following values. Use
;                  +one of the header flags.
;                  |LVGA_HEADER_CENTER - Header text is centered horizontally in the window
;                  |LVGA_HEADER_LEFT   - Header text is aligned at the left of the window
;                  |LVGA_HEADER_RIGHT  - Header text is aligned at the right of the window.
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagLVGROUP = "int Size;int Mask;ptr Header;int HeaderMax;ptr Footer;int FooterMax;int GroupID;int StateMask;int State;int Align"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagLVHITTESTINFO
; Description ...: Contains information about a hit test
; Fields ........: X       - X position to hit test
;                  Y       - Y position to hit test
;                  Flags   - Results of a hit test. Can be one or more of the following values:
;                  |$LVHT_ABOVE           - The position is above the control's client area
;                  |$LVHT_BELOW           - The position is below the control's client area
;                  |$LVHT_NOWHERE         - The position is inside the client window, but it is not over a list item
;                  |$LVHT_ONITEMICON      - The position is over an item's icon
;                  |$LVHT_ONITEMLABEL     - The position is over an item's text
;                  |$LVHT_ONITEMSTATEICON - The position is over the state image of an item
;                  |$LVHT_TOLEFT          - The position is to the left of the client area
;                  |$LVHT_TORIGHT         - The position is to the right of the client area
;                  Item    - Receives the index of the matching item. Or if hit-testing a subitem,  this  value  represents  the
;                  +subitem's parent item.
;                  SubItem - Receives the index of the matching subitem. When hit-testing an item, this member will be zero.
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagLVHITTESTINFO = "int X;int Y;int Flags;int Item;int SubItem"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagLVINSERTMARK
; Description ...: Used to describe insertion points
; Fields ........: Size     - Size of this structure, in bytes
;                  Flags    - Flag that specifies where the insertion point should appear:
;                  |$LVIM_AFTER - The insertion point appears after the item specified if the $LVIM_AFTER flag is set; otherwise
;                  +it appears before the specified item.
;                  Item     - Item next to which the insertion point appears. If -1, there is no insertion point.
;                  Reserved - Reserved. Must be set to 0.
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagLVINSERTMARK = "uint Size;dword Flags;int Item;dword Reserved"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagLVITEM
; Description ...: Specifies or receives the attributes of a list-view item
; Fields ........: Mask      - Set of flags that specify which members of this structure contain data to be set or which members
;                  +are being requested. This member can have one or more of the following flags set:
;                  |$LVIF_COLUMNS     - The Columns member is valid
;                  |$LVIF_DI_SETITEM  - The operating system should store the requested list item information
;                  |$LVIF_GROUPID     - The GroupID member is valid
;                  |$LVIF_IMAGE       - The Image member is valid
;                  |$LVIF_INDENT      - The Indent member is valid
;                  |$LVIF_NORECOMPUTE - The control will not generate LVN_GETDISPINFO to retrieve text information
;                  |$LVIF_PARAM       - The Param member is valid
;                  |$LVIF_STATE       - The State member is valid
;                  |$LVIF_TEXT        - The Text member is valid
;                  Item      - Zero based index of the item to which this structure refers
;                  SubItem   - One based index of the subitem to which this structure refers
;                  State     - Indicates the item's state, state image, and overlay image
;                  StateMask - Value specifying which bits of the state member will be retrieved or modified
;                  Text      - Pointer to a string containing the item text
;                  TextMax   - Number of bytes in the buffer pointed to by Text, including the string terminator
;                  Image     - Index of the item's icon in the control's image list
;                  Param     - Value specific to the item
;                  Indent    - Number of image widths to indent the item
;                  GroupID   - Identifier of the tile view group that receives the item
;                  Columns   - Number of tile view columns to display for this item
;                  pColumns  - Pointer to the array of column indices
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagLVITEM = "int Mask;int Item;int SubItem;int State;int StateMask;ptr Text;int TextMax;int Image;int Param;" & _
		"int Indent;int GroupID;int Columns;ptr pColumns"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMLISTVIEW
; Description ...: Contains information about a list-view notification message
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  Item     - Identifies the item, or -1 if not used
;                  SubItem  - Identifies the subitem, or zero if none
;                  NewState - New item state
;                  OldState - Old item state
;                  Changed  - Set of flags that indicate the item attributes that have changed
;                  ActionX  - X position at which the event occurred
;                  ActionY  - Y position at which the event occurred
;                  Param    - Application-defined value of the item
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMLISTVIEW = $tagNMHDR & ";int Item;int SubItem;int NewState;int OldState;int Changed;" & _
		"int ActionX;int ActionY;int Param"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMLVCUSTOMDRAW
; Description ...: Contains information specific to an NM_CUSTOMDRAW (list view) notification message sent by a list-view control
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  dwDrawStage - The current drawing stage. This is one of the following values:
;                  |Global Values:
;                  |  $CDDS_POSTERASE     - After the erasing cycle is complete.
;                  |  $CDDS_POSTPAINT     - After the painting cycle is complete.
;                  |  $CDDS_PREERASE      - Before the erasing cycle begins.
;                  |  $CDDS_PREPAINT      - Before the painting cycle begins.
;                  |Item-specific Values:
;                  |  $CDDS_ITEM          - Indicates that the dwItemSpec, uItemState, and lItemlParam members are valid.
;                  |  $CDDS_ITEMPOSTERASE - After an item has been erased.
;                  |  $CDDS_ITEMPOSTPAINT - After an item has been drawn.
;                  |  $CDDS_ITEMPREERASE  - Before an item is erased.
;                  |  $CDDS_ITEMPREPAINT  - Before an item is drawn.
;                  |  $CDDS_SUBITEM       - Flag combined with $CDDS_ITEMPREPAINT or $CDDS_ITEMPOSTPAINT if a subitem is being drawn.
;                  |  This will only be set if $CDRF_NOTIFYITEMDRAW is returned from $CDDS_PREPAINT.
;                  hdc        - A handle to the control's device context.
;                  |  Use this handle to a device context (HDC) to perform any Microsoft Windows Graphics Device Interface (GDI) functions.
;                  Left        - X coordinate of the upper left corner of the rectangle of the area being drawn. This member is initialized only by the $CDDS_ITEMPREPAINT notification
;                  Top         - Y coordinate of the upper left corner of the rectangle of the area being drawn. This member is initialized only by the $CDDS_ITEMPREPAINT notification
;                  Right       - X coordinate of the lower right corner of the rectangle of the area being drawn. This member is initialized only by the $CDDS_ITEMPREPAINT notification
;                  Bottom      - Y coordinate of the lower right corner of the rectangle of the area being drawn. This member is initialized only by the $CDDS_ITEMPREPAINT notification
;                  dwItemSpec  - The item number
;                  uItemState  - The current item state. This value is a combination of the following flags:
;                  |  $CDIS_CHECKED          - The item is checked.
;                  |  $CDIS_DEFAULT          - The item is in its default state.
;                  |  $CDIS_DISABLED         - The item is disabled.
;                  |  $CDIS_FOCUS            - The item is in focus.
;                  |  $CDIS_GRAYED           - The item is grayed.
;                  |  $CDIS_HOT              - The item is currently under the pointer ("hot").
;                  |  $CDIS_INDETERMINATE    - The item is in an indeterminate state.
;                  |  $CDIS_MARKED           - The item is marked. The meaning of this is determined by the implementation.
;                  |  $CDIS_SELECTED         - The item is selected.
;                  |  $CDIS_SHOWKEYBOARDCUES - Version 6.0 Comctl32.  The item is a keyboard cue.
;                  |  $CDIS_NEARHOT          - The item is part of a control that is currently under the mouse pointer ("hot"), but the item is not "hot" itself.
;                  |    The meaning of this is determined by the implementation.
;                  |  $CDIS_OTHERSIDEHOT     - The item is part of a splitbutton that is currently under the mouse pointer ("hot"), but the item is not "hot" itself.
;                  |    The meaning of this is determined by the implementation.
;                  |  $CDIS_DROPHILITED      - The item is currently the drop target of a drag-and-drop operation.
;                  lItemlParam - Application-defined item data.
;                  clrText     - COLORREF value representing the color that will be used to display text foreground in the list-view control.
;                  clrTextBk   - COLORREF value representing the color that will be used to display text background in the list-view control.
;                  iSubItem    - Index of the subitem that is being drawn. If the main item is being drawn, this member will be zero.
;                  dwItemType  - Version 6.0. DWORD that contains the type of the item to draw. This member can be one of the following values:
;                  |  $LVCDI_ITEM            - An item is to be drawn.
;                  |  $LVCDI_GROUP           - A group is to be drawn.
;                  clrFace     - Version 6.0. COLORREF value representing the color that will be used to display the face of an item.
;                  iIconEffect - Version 6.0.  Value of type int that specifies the effect that is applied to an icon, such as Glow, Shadow, or Pulse.
;                  iIconPhase  - Version 6.0.  Value of type int that specifies the phase of an icon.
;                  iPartId     - Version 6.0.  Value of type int that specifies the ID of the part of an item to draw.
;                  iStateId    - Version 6.0.  Value of type int that specifies the ID of the state of an item to draw.
;                  TextLeft    - X coordinate of the upper left corner of the rectangle in which the text is to be drawn
;                  TextTop     - Y coordinate of the upper left corner of the rectangle in which the text is to be drawn
;                  TextRight   - X coordinate of the lower right corner of the rectangle in which the text is to be drawn
;                  TextBottom  - Y coordinate of the lower right corner of the rectangle in which the text is to be drawn
;                  uAlign      - Version 6.0. UINT that specifies how a group should be aligned. This member can be one of the following values:
;                  |  $LVGA_HEADER_CENTER    - Center the group.
;                  |  $LVGA_HEADER_LEFT      - Align the group on the left.
;                  |  $LVGA_HEADER_RIGHT     - Align the group on the right.
; Author ........: Gary Frost
; Remarks .......: $LVxxx_ constants require ListViewConstants.au3, $CDxx_ constants require WindowsConstants.au3
; ===============================================================================================================================
Global Const $tagNMLVCUSTOMDRAW = $tagNMHDR & ";dword dwDrawStage;hwnd hdc;int Left;int Top;int Right;int Bottom;" & _
		"dword dwItemSpec;uint uItemState;long lItemlParam;int clrText;int clrTextBk;int iSubItem;dword dwItemType;int clrFace;int iIconEffect;" & _
		"int iIconPhase;int iPartId;int iStateId;int TextLeft;int TextTop;int TextRight;int TextBottom;uint uAlign"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMLVDISPINFO
; Description ...: Contains information about an $LVN_GETDISPINFO or $LVN_SETDISPINFO notification message
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  Mask      - Set of flags that specify which members of this structure contain data to be set or which members
;                  +are being requested. This member can have one or more of the following flags set:
;                  |$LVIF_COLUMNS     - The Columns member is valid
;                  |$LVIF_DI_SETITEM  - The operating system should store the requested list item information
;                  |$LVIF_GROUPID     - The GroupID member is valid
;                  |$LVIF_IMAGE       - The Image member is valid
;                  |$LVIF_INDENT      - The Indent member is valid
;                  |$LVIF_NORECOMPUTE - The control will not generate LVN_GETDISPINFO to retrieve text information
;                  |$LVIF_PARAM       - The Param member is valid
;                  |$LVIF_STATE       - The State member is valid
;                  |$LVIF_TEXT        - The Text member is valid
;                  Item      - Zero based index of the item to which this structure refers
;                  SubItem   - One based index of the subitem to which this structure refers
;                  State     - Indicates the item's state, state image, and overlay image
;                  StateMask - Value specifying which bits of the state member will be retrieved or modified
;                  Text      - Pointer to a string containing the item text
;                  TextMax   - Number of bytes in the buffer pointed to by Text, including the string terminator
;                  Image     - Index of the item's icon in the control's image list
;                  Param     - Value specific to the item
;                  Indent    - Number of image widths to indent the item
;                  GroupID   - Identifier of the tile view group that receives the item
;                  Columns   - Number of tile view columns to display for this item
;                  pColumns  - Pointer to the array of column indices
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMLVDISPINFO = $tagNMHDR & ";int Mask;int Item;int SubItem;int State;int StateMask;" & _
		"ptr Text;int TextMax;int Image;int Param;int Indent;int GroupID;int Columns;ptr pColumns"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMLVFINDITEM
; Description ...: Contains information the owner needs to find items requested by a virtual list view control
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  Start    - Index of the item at which the search will start
;                  Flags     - Type of search to perform. This member can be set to one or more of the following values:
;                  |$LVFI_PARAM    - Searches for a match between this structure's Param member and the Param member of an item.
;                  +If $LVFI_PARAM is specified, all other flags are ignored.
;                  |$LVFI_PARTIAL  - Checks to see if the item text begins with the string pointed to by the Text  member.  This
;                  +value implies use of $LVFI_STRING.
;                  |$LVFI_STRING   - Searches based on the item text.  Unless additional values are specified, the item text  of
;                  +the matching item must exactly match the string pointed to by the Text member.
;                  |$LVFI_WRAP     - Continues the search at the beginning if no match is found
;                  |LVFI_NEARESTXY - Finds the item nearest to the position specified in the X and Y members, in  the  direction
;                  +specified by the Direction member. This flag is supported only by large icon and small icon modes.
;                  Text      - Address of a string to compare with the item text.  It is valid if $LVFI_STRING or  $LVFI_PARTIAL
;                  +is set in the Flags member.
;                  Param     - Value to compare with the Param member of an item's  $LVITEM  structure.  It  is  valid  only  if
;                  +$LVFI_PARAM is set in the flags member.
;                  X         - Initial X search position. It is valid only if $LVFI_NEARESTXY is set in the Flags member.
;                  Y         - Initial Y search position. It is valid only if $LVFI_NEARESTXY is set in the Flags member.
;                  Direction - Virtual key code that specifies the direction to search. The following codes are supported:
;                  |VK_LEFT
;                  |VK_RIGHT
;                  |VK_UP
;                  |VK_DOWN
;                  |VK_HOME
;                  |VK_END
;                  |VK_PRIOR
;                  |VK_NEXT
;                  |This member is valid only if $LVFI_NEARESTXY is set in the flags member.
; Author ........: Gary Frost (gafrost)
; Remarks .......: This notification gives an application (or the notification receiver) the opportunity to customize an incremental search.
;                  For example, if the search items are numeric, the application can perform a numerical search instead of a string search.
;                  The application sets the Param member to the result of the search, or to another application defined value to fail the
;                  search and indicate to the control how to proceed
; ===============================================================================================================================
Global Const $tagNMLVFINDITEM = $tagNMHDR & ";int Start;int Flags;ptr Text;int Param;int X;int Y;int Direction"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMLVGETINFOTIP
; Description ...: Contains and receives list-view item information needed to display a ToolTip for an item
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  Flags      - Either zero or $LVGIT_UNFOLDED
;                  Text       - Address of a string buffer that receives any additional text information
;                  +If Flags is zero, this member will contain the existing item text
;                  +In this case, you should append any additional text onto the end of this string
;                  TextMax     - Size, in characters, of the buffer pointed to by Text
;                  +Although you should never assume that this buffer will be of any particular size, the $INFOTIPSIZE value can
;                  +be used for design purposes
;                  Item        - Zero-based index of the item to which this structure refers.
;                  SubItem     - One-based index of the subitem to which this structure refers
;                  +If this member is zero, the structure is referring to the item and not a subitem
;                  +This member is not currently used and will always be zero
;                  lParam      - Application-defined value associated with the item
;                  +This member is not currently used and will always be zero.
; Author ........: Gary Frost (gafrost)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMLVGETINFOTIP = $tagNMHDR & ";int Flags;ptr Text;int TextMax;int Item;int SubItem;int lParam"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMITEMACTIVATE
; Description ...: Sent by a list-view control when the user activates an item
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  Index      - Index of the list-view item. If the item index is not used for the notification,
;                  +this member will contain -1
;                  SubItem    - One-based index of the subitem. If the subitem index is not used for the notification or the
;                  +notification does not apply to a subitem, this member will contain zero.
;                  NewState   - New item state. This member is zero for notification messages that do not use it
;                  OldState   - Old item state. This member is zero for notification messages that do not use it
;                  Changed    - Set of flags that indicate the item attributes that have changed.
;                  +This member is zero for notifications that do not use it.
;                  +This member can have one or more of the following flags set:
;                  |$LVIF_COLUMNS     - The Columns member is valid
;                  |$LVIF_DI_SETITEM  - The operating system should store the requested list item information
;                  |$LVIF_GROUPID     - The GroupID member is valid
;                  |$LVIF_IMAGE       - The Image member is valid
;                  |$LVIF_INDENT      - The Indent member is valid
;                  |$LVIF_NORECOMPUTE - The control will not generate LVN_GETDISPINFO to retrieve text information
;                  |$LVIF_PARAM       - The Param member is valid
;                  |$LVIF_STATE       - The State member is valid
;                  |$LVIF_TEXT        - The Text member is valid
;                  X - Specifies the x-coordinate of the point
;                  Y - Specifies the y-coordinate of the point
;                  lParam             - Application-defined value of the item. This member is undefined for notification messages that do not use it
;                  KeyFlags           - Modifier keys that were pressed at the time of the activation.
;                  +This member contains zero or a combination of the following flags:
;                  |$LVKF_ALT         - The key is pressed.
;                  |$LVKF_CONTROL     - The key is pressed.
;                  |$LVKF_SHIFT       - The key is pressed.
; Author ........: Gary Frost (gafrost)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMITEMACTIVATE = $tagNMHDR & ";int Index;int SubItem;int NewState;int OldState;" & _
		"int Changed;int X;int Y;int lParam;int KeyFlags"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMLVKEYDOWN
; Description ...: Contains information used in processing the $LVN_KEYDOWN notification message
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  VKey     - Virtual key code
;                  Flags    - This member must always be zero
; Author ........: Gary Frost (gafrost)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMLVKEYDOWN = $tagNMHDR & ";int VKey;int Flags"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMLVSCROLL
; Description ...: Provides information about a scrolling operation
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  DX         - Specifies in pixels the horizontal position where a scrolling operation should begin or end
;                  DY         - Specifies in pixels the vertical position where a scrolling operation should begin or end
; Author ........: Gary Frost (gafrost)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMLVSCROLL = $tagNMHDR & ";int DX;int DY"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagLVSETINFOTIP
; Description ...: Provides information about tooltip text that is to be set
; Fields ........: Size    - Size of this structure, in bytes
;                  Flags   - Flag that specifies how the text should be set. Set to zero.
;                  Text    - Pointer to a Unicode string that contains the tooltip text
;                  Item    - Contains the zero based index of the item to which this structure refers
;                  SubItem - Contains the one based index of the subitem to which this structure refers
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagLVSETINFOTIP = "int Size;int Flags;ptr Text;int Item;int SubItem"

; ===============================================================================================================================
; *******************************************************************************************************************************
; Month Calendar Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; #STRUCTURE# ===================================================================================================================
; Name...........: $tagMCHITTESTINFO
; Description ...: Carries information specific to hit-testing points for a month calendar control
; Fields ........: Size     - Size of this structure, in bytes
;                  X        - X position of the point to be hit tested
;                  Y        - Y position of the point to be hit tested
;                  Hit      - Results of the hit test operation. This value will be one of the following:
;                  |$MCHT_CALENDARBK       - The given point was in the calendar's background
;                  |$MCHT_CALENDARDATE     - The given point was on a particular date within the calendar
;                  |$MCHT_CALENDARDATENEXT - The given point was over a date from the next month
;                  |$MCHT_CALENDARDATEPREV - The given point was over a date from the previous month
;                  |$MCHT_CALENDARDAY      - The given point was over a day abbreviation
;                  |$MCHT_CALENDARWEEKNUM  - The given point was over a week number
;                  |$MCHT_NOWHERE          - The given point was not on the month calendar control
;                  |$MCHT_TITLEBK          - The given point was over the background of a month's title
;                  |$MCHT_TITLEBTNNEXT     - The given point was over the button at the top right corner
;                  |$MCHT_TITLEBTNPREV     - The given point was over the button at the top left corner
;                  |$MCHT_TITLEMONTH       - The given point was in a month's title bar, over a month name
;                  |$MCHT_TITLEYEAR        - The given point was in a month's title bar, over the year value
;                  Year     - Year
;                  Month    - Month
;                  DOW      - DOW
;                  Day      - Day
;                  Hour     - Hour
;                  Minute   - Minute
;                  Second   - Seconds
;                  MSeconds - Milliseconds
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagMCHITTESTINFO = "int Size;int X;int Y;int Hit;short Year;short Month;short DOW;short Day;short Hour;" & _
		"short Minute;short Second;short MSeconds"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagMCMONTHRANGE
; Description ...: Retrieves date information that represents the high and low limits of a month calendar control's display
; Fields ........: MinYear     - Year
;                  MinMonth    - Month
;                  MinDOW      - DOW
;                  MinDay      - Day
;                  MinHour     - Hour
;                  MinMinute   - Minute
;                  MinSecond   - Seconds
;                  MinMSeconds - Milliseconds
;                  MaxMonth    - Month
;                  MaxDOW      - DOW
;                  MaxDay      - Day
;                  MaxHour     - Hour
;                  MaxMinute   - Minute
;                  MaxSecond   - Seconds
;                  MaxMSeconds - Milliseconds
;                  Span        - Range, in months, spanned by the two limits
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagMCMONTHRANGE = "short MinYear;short MinMonth;short MinDOW;short MinDay;short MinHour;short MinMinute;short MinSecond;" & _
		"short MinMSeconds;short MaxYear;short MaxMonth;short MaxDOW;short MaxDay;short MaxHour;short MaxMinute;short MaxSecond;" & _
		"short MaxMSeconds;short Span"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagMCRANGE
; Description ...: Contains information for setting the minimum and maximum allowable dates for a month calendar control
; Fields ........: MinYear     - Year
;                  MinMonth    - Month
;                  MinDOW      - DOW
;                  MinDay      - Day
;                  MinHour     - Hour
;                  MinMinute   - Minute
;                  MinSecond   - Seconds
;                  MinMSeconds - Milliseconds
;                  MaxMonth    - Month
;                  MaxDOW      - DOW
;                  MaxDay      - Day
;                  MaxHour     - Hour
;                  MaxMaxute   - Maxute
;                  MaxSecond   - Seconds
;                  MaxMSeconds - Milliseconds
;                  MinSet      - A minimum limit is set for the control
;                  MaxSet      - A maximum limit is set for the control
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagMCRANGE = "short MinYear;short MinMonth;short MinDOW;short MinDay;short MinHour;short MinMinute;short MinSecond;" & _
		"short MinMSeconds;short MaxYear;short MaxMonth;short MaxDOW;short MaxDay;short MaxHour;short MaxMinute;short MaxSecond;" & _
		"short MaxMSeconds;short MinSet;short MaxSet"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagMCSELRANGE
; Description ...: Specifies a date and time, in coordinated universal time (UTC)
; Fields ........: MinYear     - Year
;                  MinMonth    - Month
;                  MinDOW      - DOW
;                  MinDay      - Day
;                  MinHour     - Hour
;                  MinMinute   - Minute
;                  MinSecond   - Seconds
;                  MinMSeconds - Milliseconds
;                  MaxMonth    - Month
;                  MaxDOW      - DOW
;                  MaxDay      - Day
;                  MaxHour     - Hour
;                  MaxMaxute   - Maxute
;                  MaxSecond   - Seconds
;                  MaxMSeconds - Milliseconds
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagMCSELRANGE = "short MinYear;short MinMonth;short MinDOW;short MinDay;short MinHour;short MinMinute;short MinSecond;" & _
		"short MinMSeconds;short MaxYear;short MaxMonth;short MaxDOW;short MaxDay;short MaxHour;short MaxMinute;short MaxSecond;" & _
		"short MaxMSeconds"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMDAYSTATE
; Description ...: Carries information required to process the $MCN_GETDAYSTATE notification me
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  Year      - Year
;                  Month     - Month
;                  DOW       - DOW
;                  Day       - Day
;                  Hour      - Hour
;                  Minute    - Minute
;                  Second    - Seconds
;                  MSeconds  - Milliseconds
;                  DayState  - The total number of elements that must be in the array at pDayState
;                  pDayState - Address of an array of MONTHDAYSTATE (DWORD bit field that holds the state of each day in a month)
;                  +Each bit (1 through 31) represents the state of a day in a month. If a bit is on, the corresponding day will
;                  +be displayed in bold; otherwise it will be displayed with no emphasis.
;                  +The buffer at this address must be large enough to contain at least DayState elements.
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMDAYSTATE = $tagNMHDR & ";short Year;short Month;short DOW;short Day;short Hour;" & _
		"short Minute;short Second;short MSeconds;int DayState;ptr pDayState"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMSELCHANGE
; Description ...: Carries information required to process the $MCN_SELCHANGE notification message
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  BegYear     - Year
;                  BegMonth    - Month
;                  BegDOW      - DOW
;                  BegDay      - Day
;                  BegHour     - Hour
;                  BegMinute   - Minute
;                  BegSecond   - Seconds
;                  BegMSeconds - Milliseconds
;                  EndYear     - Year
;                  EndMonth    - Month
;                  EndDOW      - DOW
;                  EndDay      - Day
;                  EndHour     - Hour
;                  EndMinute   - Minute
;                  EndSecond   - Seconds
;                  EndMSeconds - Milliseconds
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMSELCHANGE = $tagNMHDR & ";short BegYear;short BegMonth;short BegDOW;short BegDay;" & _
		"short BegHour;short BegMinute;short BegSecond;short BegMSeconds;short EndYear;short EndMonth;short EndDOW;" & _
		"short EndDay;short EndHour;short EndMinute;short EndSecond;short EndMSeconds"

; ===============================================================================================================================
; *******************************************************************************************************************************
; Tab Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMOBJECTNOTIFY
; Description ...: Contains information used with the $TBN_GETOBJECT, $TCN_GETOBJECT, $RBN_GETOBJECT, and $PSN_GETOBJECT notification messages
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  Item     - A control-specific item identifier
;                  piid     - A pointer to an interface identifier of the requested object
;                  pObject  - A pointer to an object provided by the window processing the notification message
;                  +The application processing the notification message sets this member
;                  Result   - COM success or failure flags. The application processing the notification message sets this member
; Author ........: Gary Frost (gafrost)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMOBJECTNOTIFY = $tagNMHDR & ";int Item;ptr piid;ptr pObject;int Result"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMTCKEYDOWN
; Description ...: Contains information used in processing the $LVN_KEYDOWN notification message
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  VKey     - Virtual key code
;                  Flags    - Bits as shown in the following table:
;                  |0-15    - Specifies the repeat count for the current message.
;                  |16-23   - Specifies the scan code. The value depends on the OEM.
;                  |24      - Specifies whether the key is an extended key, such as the right-hand ALT and CTRL keys that appear
;                  +on an enhanced 101- or 102-key keyboard. The value is 1 if it is an extended key; otherwise, it is 0.
;                  |25-28   - Reserved; do not use.
;                  |29      - Specifies the context code. The value is always 0 for a $WM_KEYDOWN message.
;                  |30      - Specifies the previous key state. The value is 1 if the key is down before the message is sent,
;                  +or it is zero if the key is up.
;                  |31      - Specifies the transition state. The value is always zero for a $WM_KEYDOWN message
; Author ........: Gary Frost (gafrost)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMTCKEYDOWN = $tagNMHDR & ";int VKey;int Flags"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagTCITEM
; Description ...: Specifies or receives the attributes of a tab item
; Fields ........: Mask      - Value that specifies which members to retrieve or set:
;                  |$TCIF_IMAGE      - The Image member is valid
;                  |$TCIF_PARAM      - The Param member is valid
;                  |$TCIF_RTLREADING - The string pointed to by Text will be displayed in the opposite direction
;                  |$TCIF_STATE      - The State member is valid
;                  |$TCIF_TEXT       - The Text member is valid
;                  State     - Specifies the item's current state if information is being retrieved. If item information is being
;                  +set this member contains the state value to be set for the item.
;                  StateMask - Specifies which bits of the dwState member contain valid information
;                  Text      - String that contains the tab text when item information is being set. If item information is being
;                  +retrieved, this member specifies the address of the buffer that receives the tab text.
;                  TextMax   - Size of the buffer pointed to by the Text member.  If the structure is not receiving  information,
;                  +this member is ignored.
;                  Image     - Index in the tab control's image list, or -1 if there is no image for the tab.
;                  Param     - Application-defined data associated with the tab control item
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagTCITEM = "int Mask;int State;int StateMask;ptr Text;int TextMax;int Image;int Param"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagTCHITTESTINFO
; Description ...: Contains information about a hit test
; Fields ........: X     - X position to hit test
;                  Y     - Y position to hit test
;                  Flags - Results of a hit test. The control sets this member to one of the following values:
;                  |$TCHT_NOWHERE     - The position is not over a tab
;                  |$TCHT_ONITEM      - The position is over a tab but not over its icon or its text
;                  |$TCHT_ONITEMICON  - The position is over a tab's icon
;                  |$TCHT_ONITEMLABEL - The position is over a tab's text
;                  |$TCHT_ONITEM      - Bitwise OR of $TCHT_ONITEMICON and $TCHT_ONITEMLABEL
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagTCHITTESTINFO = "int X;int Y;int Flags"

; ===============================================================================================================================
; *******************************************************************************************************************************
; TreeView Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; #STRUCTURE# ===================================================================================================================
; Name...........: $tagTVITEMEX
; Description ...: Specifies or receives attributes of a tree-view item
; Fields ........: Mask          - Flags that indicate which of the other structure members contain valid data:
;                  |$TVIF_CHILDREN      - The Children member is valid
;                  |$TVIF_DI_SETITEM    - The will retain the supplied information and will not request it again
;                  |$TVIF_HANDLE        - The hItem member is valid
;                  |$TVIF_IMAGE         - The Image member is valid
;                  |$TVIF_INTEGRAL      - The Integral member is valid
;                  |$TVIF_PARAM         - The Param member is valid
;                  |$TVIF_SELECTEDIMAGE - The SelectedImage member is valid
;                  |$TVIF_STATE         - The State and StateMask members are valid
;                  |$TVIF_TEXT          - The Text and TextMax members are valid
;                  hItem         - Item to which this structure refers
;                  State         - Set of bit flags and image list indexes that indicate the item's state. When setting the state
;                  +of an item, the StateMask member indicates the bits of this member that are valid.  When retrieving the state
;                  +of an item, this member returns the current state for the bits indicated in  the  StateMask  member.  Bits  0
;                  +through 7 of this member contain the item state flags. Bits 8 through 11 of this member specify the one based
;                  +overlay image index.
;                  StateMask     - Bits of the state member that are valid.  If you are retrieving an item's state, set the  bits
;                  +of the stateMask member to indicate the bits to be returned in the state member. If you are setting an item's
;                  +state, set the bits of the stateMask member to indicate the bits of the state member that you want to set.
;                  Text          - Pointer to a null-terminated string that contains the item text.
;                  TextMax       - Size of the buffer pointed to by the Text member, in characters
;                  Image         - Index in the image list of the icon image to use when the item is in the nonselected state
;                  SelectedImage - Index in the image list of the icon image to use when the item is in the selected state
;                  Children      - Flag that indicates whether the item has associated child items. This member can be one of the
;                  +following values:
;                  |0 - The item has no child items
;                  |1 - The item has one or more child items
;                  Param         - A value to associate with the item
;                  Integral      - Height of the item
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagTVITEMEX = "int Mask;int hItem;int State;int StateMask;ptr Text;int TextMax;int Image;int SelectedImage;" & _
		"int Children;int Param;int Integral"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMTREEVIEW
; Description ...: Contains information about a tree-view notification message
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  Action           - Notification-specific action flag
;                  OldMask          - Flags that indicate which of the other structure members contain valid data.
;                  OldhItem         - Item to which this structure refers
;                  OldState         - Set of bit flags and image list indexes that indicate the item's state
;                  OldStateMask     - Bits of the state member that are valid
;                  OldText          - Pointer to a null-terminated string that contains the item text.
;                  OldTextMax       - Size of the buffer pointed to by the Text member, in characters
;                  OldImage         - Index in the image list of the icon image to use when the item is in the nonselected state
;                  OldSelectedImage - Index in the image list of the icon image to use when the item is in the selected state
;                  OldChildren      - Flag that indicates whether the item has associated child items
;                  OldParam         - A value to associate with the item
;                  NewMask          - Flags that indicate which of the other structure members contain valid data.
;                  NewhItem         - Item to which this structure refers
;                  NewState         - Set of bit flags and image list indexes that indicate the item's state
;                  NewStateMask     - Bits of the state member that are valid
;                  NewText          - Pointer to a null-terminated string that contains the item text.
;                  NewTextMax       - Size of the buffer pointed to by the Text member, in characters
;                  NewImage         - Index in the image list of the icon image to use when the item is in the nonselected state
;                  NewSelectedImage - Index in the image list of the icon image to use when the item is in the selected state
;                  NewChildren      - Flag that indicates whether the item has associated child items
;                  NewParam         - A value to associate with the item
;                  PointX           - X position that of the mouse at the time the event occurred
;                  PointY           - Y position that of the mouse at the time the event occurred
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMTREEVIEW = $tagNMHDR & ";int Action;int OldMask;int OldhItem;int OldState;int OldStateMask;" & _
		"ptr OldText;int OldTextMax;int OldImage;int OldSelectedImage;int OldChildren;int OldParam;int NewMask;int NewhItem;" & _
		"int NewState;int NewStateMask;ptr NewText;int NewTextMax;int NewImage;int NewSelectedImage;int NewChildren;" & _
		"int NewParam;int PointX; int PointY"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMTVCUSTOMDRAW
; Description ...: Contains information specific to an NM_CUSTOMDRAW (tree view) notification message sent by a tree-view control
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  DrawStage - Current drawing stage. This value is one of the following:
;                  |Global Values:
;                  |  $CDDS_POSTERASE - After the erasing cycle is complete
;                  |  $CDDS_POSTPAINT - After the painting cycle is complete
;                  |  $CDDS_PREERASE  - Before the erasing cycle begins
;                  |  $CDDS_PREPAINT  - Before the painting cycle begins
;                  |Item-specific Values:
;                  |  $CDDS_ITEM          - Indicates that the ItemSpec, ItemState, and ItemParam members are valid
;                  |  $CDDS_ITEMPOSTERASE - After an item has been erased
;                  |  $CDDS_ITEMPOSTPAINT - After an item has been drawn
;                  |  $CDDS_ITEMPREERASE  - Before an item is erased
;                  |  $CDDS_ITEMPREPAINT  - Before an item is drawn
;                  |  $CDDS_SUBITEM       - Flag combined with $CDDS_ITEMPREPAINT or $CDDS_ITEMPOSTPAINT if a subitem is being drawn
;                  HDC       - Handle to the control's device context
;                  Left      - X coordinate of upper left corner of bounding rectangle being drawn
;                  Top       - Y coordinate of upper left corner of bounding rectangle being drawn
;                  Right     - X coordinate of lower right corner of bounding rectangle being drawn
;                  Bottom    - Y coordinate of lower right corner of bounding rectangle being drawn
;                  ItemSpec  - Item number
;                  ItemState - Current item state. This value is a combination of the following:
;                  |  $CDIS_CHECKED          - The item is checked
;                  |  $CDIS_DEFAULT          - The item is in its default state
;                  |  $CDIS_DISABLED         - The item is disabled
;                  |  $CDIS_FOCUS            - The item is in focus
;                  |  $CDIS_GRAYED           - The item is grayed
;                  |  $CDIS_HOT              - The item is currently under the pointer
;                  |  $CDIS_INDETERMINATE    - The item is in an indeterminate state
;                  |  $CDIS_MARKED           - The item is marked
;                  |  $CDIS_SELECTED         - The item is selected
;                  |  $CDIS_SHOWKEYBOARDCUES - The item is a keyboard cue
;                  ItemParam - Application defined item data
;                  ClrText   - The color that will be used to display text foreground in the control
;                  CltTextBk - The color that will be used to display text background in the control
;                  Level     - Zero based level of the item being drawn
; Author ........: Paul Campbell (PaulIA)
; Remarks .......: $CDxx_ constants require WindowsConstants.au3
; ===============================================================================================================================
Global Const $tagNMTVCUSTOMDRAW = $tagNMHDR & ";uint DrawStage;hwnd HDC;int Left;int Top;int Right;int Bottom;" & _
		"ptr ItemSpec;uint ItemState;int ItemParam;int ClrText;int ClrTextBk;int Level"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMTVDISPINFO
; Description ...: Contains and receives display information for a tree-view item
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  Mask          - Specifies which information is being set or retrieved. It can be one or more of the following values:
;                  |$TVIF_CHILDREN      - The Children member is valid
;                  |$TVIF_IMAGE         - The Image member is valid
;                  |$TVIF_SELECTEDIMAGE - The SelectedImage member is valid
;                  |$TVIF_TEXT          - The Text and TextMax members are valid
;                  hItem         - Item to which this structure refers
;                  State         - Set of bit flags and image list indexes that indicate the item's state. When setting the state
;                  +of an item, the StateMask member indicates the bits of this member that are valid.  When retrieving the state
;                  +of an item, this member returns the current state for the bits indicated in  the  StateMask  member.  Bits  0
;                  +through 7 of this member contain the item state flags. Bits 8 through 11 of this member specify the one based
;                  +overlay image index.
;                  StateMask     - Bits of the state member that are valid.  If you are retrieving an item's state, set the  bits
;                  +of the stateMask member to indicate the bits to be returned in the state member. If you are setting an item's
;                  +state, set the bits of the stateMask member to indicate the bits of the state member that you want to set.
;                  Text          - Pointer to a null-terminated string that contains the item text.
;                  TextMax       - Size of the buffer pointed to by the Text member, in characters
;                  Image         - Index in the image list of the icon image to use when the item is in the nonselected state
;                  SelectedImage - Index in the image list of the icon image to use when the item is in the selected state
;                  Children      - Flag that indicates whether the item has associated child items. This member can be one of the
;                  +following values:
;                  |0 - The item has no child items
;                  |1 - The item has one or more child items
;                  Param         - A value to associate with the item
; Author ........: Gary Frost (gafrost)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMTVDISPINFO = $tagNMHDR & ";int Mask;int hItem;int State;int StateMask;" & _
		"ptr Text;int TextMax;int Image;int SelectedImage;int Children;int Param"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMTVGETINFOTIP
; Description ...: Contains and receives tree-view item information needed to display a ToolTip for an item
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  Text      - Address of a character buffer that contains the text to be displayed
;                  TextMax   - Size of the buffer at Text, in characters. Although you should never assume that this buffer will be
;                  +of any particular size, the $INFOTIPSIZE value can be used for design purposes
;                  hItem     - Tree handle to the item for which the ToolTip is being displayed
;                  lParam    - Application-defined data associated with the item for which the ToolTip is being displayed
; Author ........: Gary Frost (gafrost)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMTVGETINFOTIP = $tagNMHDR & ";ptr Text;int TextMax;hwnd hItem;int lParam"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagTVHITTESTINFO
; Description ...: Contains information used to determine the location of a point relative to a tree-view control
; Fields ........: X     - X position, in client coordiantes, to be tested
;                  Y     - Y position, in client coordiantes, to be tested
;                  Flags - Results of a hit test. This member can be one or more of the following values:
;                  |$TVHT_ABOVE           - Above the client area
;                  |$TVHT_BELOW           - Below the client area
;                  |$TVHT_NOWHERE         - In the client area, but below the last item
;                  |$TVHT_ONITEM          - On the bitmap or label associated with an item
;                  |$TVHT_ONITEMBUTTON    - On the button associated with an item
;                  |$TVHT_ONITEMICON      - On the bitmap associated with an item
;                  |$TVHT_ONITEMINDENT    - In the indentation associated with an item
;                  |$TVHT_ONITEMLABEL     - On the label (string) associated with an item
;                  |$TVHT_ONITEMRIGHT     - In the area to the right of an item
;                  |DllStructGetData($TVHT_ONITEMSTATEICON - On the state icon for an item that is in a user-defined state, "")
;                  |$TVHT_TOLEFT          - To the left of the client area
;                  |$TVHT_TORIGHT         - To the right of the client area
;                  Item  - Handle to the item that occupies the position
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagTVHITTESTINFO = "int X;int Y;int Flags;int Item"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagTVINSERTSTRUCT
; Description ...: Contains information used to add a new item to a tree-view control
; Fields ........: Parent        - Handle to the parent item. If this member is $TVI_ROOT, the item is inserted at the root
;                  InsertAfter   - Handle to the item after which the new item is to be inserted, or one of the following values:
;                  |$TVI_FIRST - Inserts the item at the beginning of the list
;                  |$TVI_LAST  - Inserts the item at the end of the list
;                  |$TVI_ROOT  - Add the item as a root item
;                  |$TVI_SORT  - Inserts the item into the list in alphabetical order
;                  Mask          - Flags that indicate which of the other structure members contain valid data:
;                  |$TVIF_CHILDREN      - The Children member is valid
;                  |$TVIF_DI_SETITEM    - The will retain the supplied information and will not request it again
;                  |$TVIF_HANDLE        - The hItem member is valid
;                  |$TVIF_IMAGE         - The Image member is valid
;                  |$TVIF_INTEGRAL      - The Integral member is valid
;                  |$TVIF_PARAM         - The Param member is valid
;                  |$TVIF_SELECTEDIMAGE - The SelectedImage member is valid
;                  |$TVIF_STATE         - The State and StateMask members are valid
;                  |$TVIF_TEXT          - The Text and TextMax members are valid
;                  hItem         - Item to which this structure refers
;                  State         - Set of bit flags and image list indexes that indicate the item's state. When setting the state
;                  +of an item, the StateMask member indicates the bits of this member that are valid.  When retrieving the state
;                  +of an item, this member returns the current state for the bits indicated in  the  StateMask  member.  Bits  0
;                  +through 7 of this member contain the item state flags. Bits 8 through 11 of this member specify the one based
;                  +overlay image index.
;                  StateMask     - Bits of the state member that are valid.  If you are retrieving an item's state, set the  bits
;                  +of the stateMask member to indicate the bits to be returned in the state member. If you are setting an item's
;                  +state, set the bits of the stateMask member to indicate the bits of the state member that you want to set.
;                  Text          - Pointer to a null-terminated string that contains the item text.
;                  TextMax       - Size of the buffer pointed to by the Text member, in characters
;                  Image         - Index in the image list of the icon image to use when the item is in the nonselected state
;                  SelectedImage - Index in the image list of the icon image to use when the item is in the selected state
;                  Children      - Flag that indicates whether the item has associated child items. This member can be one of the
;                  +following values:
;                  |0 - The item has no child items
;                  |1 - The item has one or more child items
;                  Param         - A value to associate with the item
;                  Integral      - Height of the item
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagTVINSERTSTRUCT = "hwnd Parent;int InsertAfter;int Mask;hwnd hItem;int State;int StateMask;ptr Text;int TextMax;" & _
		"int Image;int SelectedImage;int Children;int Param"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMTVKEYDOWN
; Description ...: Contains information about a keyboard event in a tree-view control
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  VKey     - Virtual key code
;                  Flags    - Always zero
; Author ........: Gary Frost (gafrost)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMTVKEYDOWN = $tagNMHDR & ";int VKey;int Flags"

; ===============================================================================================================================
; *******************************************************************************************************************************
; ToolTip Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagNMTTDISPINFO
; Description ...: Contains information used in handling the $TTN_GETDISPINFO notification message
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  pText     - Pointer to a string that will be displayed as the ToolTip text.  If Instance specifies an instance
;                  +handle, this member must be the identifier of a string resource.
;                  aText     - Buffer that receives the ToolTip text.  An application can copy the text to this buffer instead of
;                  +specifying a string address or string resource.
;                  Instance  - Handle to the instance that contains a string resource to be used as the ToolTip text. If pText is
;                  +the address of the ToolTip text string, this member must be 0.
;                  Flags     - Flags that indicates how to interpret the IDFrom member:
;                  |$TTF_IDISHWND   - If this flag is set, IDFrom is the tool's handle. Otherwise, it is the tool's identifier.
;                  |$TTF_RTLREADING - Specifies right to left text
;                  |$TTF_DI_SETITEM - If you add this flag to Flags while processing the notification, the ToolTip  control  will
;                  +retain the supplied information and not request it again.
;                  Param     - Application-defined data associated with the tool
; Author ........: Paul Campbell (PaulIA)
; Remarks .......: You need to point the pText array to your own private buffer when the text used in the ToolTip text exceeds 80
;                  +characters in length.  The system automatically strips the accelerator from all strings passed to  a  ToolTip
;                  control, unless the control has the $TTS_NOPREFIX style.
; ===============================================================================================================================
Global Const $tagNMTTDISPINFO = $tagNMHDR & ";ptr pText;char aText[80];hwnd Instance;int Flags;int Param"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagTOOLINFO
; Description ...: Contains information about a tool in a ToolTip contr
; Fields ........: Size    - Size of this structure, in bytes
;                  Flags    - Flags that control the ToolTip display. This member can be a combination of the following values:
;                  |$TTF_ABSOLUTE    - Positions the ToolTip at the same coordinates provided by $TTM_TRACKPOSITION
;                  |$TTF_CENTERTIP   - Centers the ToolTip below the tool specified by the ID member
;                  |$TTF_IDISHWND    - Indicates that the ID member is the window handle to the tool
;                  |$TTF_PARSELINKS  - Indicates that links in the tooltip text should be parsed
;                  |$TTF_RTLREADING  - Indicates that the ToolTip text will be displayed in the opposite direction
;                  |$TTF_SUBCLASS    - Indicates that the ToolTip control should subclass the tool's window to intercept messages
;                  |$TTF_TRACK       - Positions the ToolTip next to the tool to which it corresponds
;                  |$TTF_TRANSPARENT - Causes the ToolTip control to forward mouse event messages to the parent window
;                  hWnd     - Handle to the window that contains the tool
;                  ID       - Application-defined identifier of the tool
;                  Left     - X position of upper left corner of bounding rectangle
;                  Top      - Y position of upper left corner of bounding rectangle
;                  Right    - X position of lower right corner of bounding rectangle
;                  Bottom   - Y position of lower right corner of bounding rectangle
;                  hInst    - Handle to the instance that contains the string resource for the too
;                  Text     - Pointer to the buffer that contains the text for the tool
;                  Param    - A 32-bit application-defined value that is associated with the tool
;                  Reserved - Reserved
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagTOOLINFO = "int Size;int Flags;hwnd hWnd;int ID;int Left;int Top;int Right;int Bottom;hwnd hInst;ptr Text;int Param;ptr Reserved"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagTTGETTITLE
; Description ...: Provides information about the title of a tooltip control
; Fields ........: Size     - Size of this structure, in bytes
;                  Bitmap   - The tooltip icon
;                  TitleMax - Specifies the number of characters in the title
;                  Title    - Pointer to a wide character string that contains the title
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagTTGETTITLE = "int Size;int Bitmap;int TitleMax;ptr Title"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagTTHITTESTINFO
; Description ...: Contains information that a ToolTip control uses to determine whether a point is in the bounding rectangle of the specified tool
; Fields ........: Tool     - Handle to the tool or window with the specified tool
;                  X        - X position to be tested, in client coordinates
;                  Y        - Y position to be tested, in client coordinates
;                  Size     - Size of a TOOLINFO structure
;                  Flags    - Flags that control the ToolTip display. This member can be a combination of the following values:
;                  |$TTF_ABSOLUTE    - Positions the ToolTip at the same coordinates provided by $TTM_TRACKPOSITION
;                  |$TTF_CENTERTIP   - Centers the ToolTip below the tool specified by the ID member
;                  |$TTF_IDISHWND    - Indicates that the ID member is the window handle to the tool
;                  |$TTF_PARSELINKS  - Indicates that links in the tooltip text should be parsed
;                  |$TTF_RTLREADING  - Indicates that the ToolTip text will be displayed in the opposite direction
;                  |$TTF_SUBCLASS    - Indicates that the ToolTip control should subclass the tool's window to intercept messages
;                  |$TTF_TRACK       - Positions the ToolTip next to the tool to which it corresponds
;                  |$TTF_TRANSPARENT - Causes the ToolTip control to forward mouse event messages to the parent window
;                  hWnd     - Handle to the window that contains the tool
;                  ID       - Application-defined identifier of the tool
;                  Left     - X position of upper left corner of bounding rectangle
;                  Top      - Y position of upper left corner of bounding rectangle
;                  Right    - X position of lower right corner of bounding rectangle
;                  Bottom   - Y position of lower right corner of bounding rectangle
;                  hInst    - Handle to the instance that contains the string resource for the too
;                  Text     - Pointer to the buffer that contains the text for the tool
;                  Param    - A 32-bit application-defined value that is associated with the tool
;                  Reserved - Reserved
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagTTHITTESTINFO = "hwnd Tool;int X;int Y;int Size;int Flags;hwnd hWnd;int ID;int Left;int Top;int Right;int Bottom;" & _
		"hwnd hInst;ptr Text;int Param;ptr Reserved"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMMOUSE
; Description ...: Contains information used with mouse notification messages
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  ItemSpec - A control-specific item identifier
;                  ItemData - A control-specific item data
;                  X        - Specifies the x-coordinate of the point
;                  Y        - Specifies the y-coordinate of the point
;                  HitInfo  - Carries information about where on the item or control the cursor is pointing
; Author ........: Gary Frost (gafrost)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMMOUSE = $tagNMHDR & ";dword ItemSpec;dword ItemData;int X;int Y;dword HitInfo"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagPOINT
; Description ...: Defines the x- and y- coordinates of a point
; Fields ........: X - Specifies the x-coordinate of the point
;                  Y - Specifies the y-coordinate of the point
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagPOINT = "int X;int Y"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagRECT
; Description ...: Defines the coordinates of the upper-left and lower-right corners of a rectangle
; Fields ........: Left   - Specifies the x-coordinate of the upper-left corner of the rectangle
;                  Top    - Specifies the y-coordinate of the upper-left corner of the rectangle
;                  Right  - Specifies the x-coordinate of the lower-right corner of the rectangle
;                  Bottom - Specifies the y-coordinate of the lower-right corner of the rectangle
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagRECT = "int Left;int Top;int Right;int Bottom"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagMargins
; Description ...: Defines the margins of windows that have visual styles applied
; Fields ........: cxLeftWidth    - Width of the left border that retains its size
;                  cxRightWidth   - Width of the right border that retains its size
;                  cyTopHeight    - Height of the top border that retains its size
;                  cyBottomHeight - Height of the bottom border that retains its size
; Author ........: Gary Frost
; Remarks .......:
; ===============================================================================================================================
Global Const $tagMargins = "int cxLeftWidth;int cxRightWidth;int cyTopHeight;int cyBottomHeight"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagSIZE
; Description ...: Stores an ordered pair of integers, typically the width and height of a rectangle
; Fields ........: X - Width
;                  Y - Height
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagSIZE = "int X;int Y"

; ===============================================================================================================================
; *******************************************************************************************************************************
; Misc Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; *******************************************************************************************************************************
; Security Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; #STRUCTURE# ===================================================================================================================
; Name...........: $tagTOKEN_PRIVILEGES
; Description ...: Contains information about a set of privileges for an access token
; Fields ........: Count      - Specifies the number of entries
;                  LUID       - Specifies a LUID value
;                  Attributes - Specifies attributes of the LUID
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagTOKEN_PRIVILEGES = "int Count;int64 LUID;int Attributes"

; ===============================================================================================================================
; *******************************************************************************************************************************
; ImageList Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; #STRUCTURE# ===================================================================================================================
; Name...........: $tagIMAGEINFO
; Description ...: Contains information about an image in an image list
; Fields ........: hBitmap - Handle to the bitmap that contains the images
;                  hMask   - Handle to a monochrome bitmap that contains the masks for the images
;                  Unused1 - Not used
;                  Unused2 - Not used
;                  Left    - Left side of the rectangle of the image
;                  Top     - Top of the rectangle of the image
;                  Right   - Right side of the rectangle of the image
;                  Bottom  - Bottom of the rectangle of the image
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagIMAGEINFO = "hwnd hBitmap;hwnd hMask;int Unused1;int Unused2;int Left;int Top;int Right;int Bottom"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagIMAGELISTDRAWPARAMS
; Description ...: Contains information about an image list draw operation and is used with the ImageList Draw function
; Fields ........: Size    - Size of this structure, in bytes
;                  hWnd    - Handle to the image list that contains the image to be drawn
;                  Image   - Zero based index of the image to be drawn
;                  hDC     - Handle to the destination device context
;                  X       - The X coordinate that specifies where the image is drawn
;                  Y       - The Y coordinate that specifies where the image is drawn
;                  CX      - The number of pixels to draw relative to the upper left corner of the drawing operation as specified
;                  +by XBitmap and YBitmap. If CX and XY are zero, then ImageList_Draw draws the entire valid section. The method
;                  +does not ensure that the parameters are valid.
;                  CY      - The number of pixels to draw relative to the upper left corner of the drawing operation as specified
;                  +by XBitmap and YBitmap. If CX and CY are zero, then ImageList_Draw draws the entire valid section. The method
;                  +does not ensure that the parameters are valid.
;                  XBitmap - The X coordinate that specifies the upper left corner of the drawing operation in reference  to  the
;                  +image itself. Pixels of the image that are to the left of XBitmap and above YBitmap do not appear.
;                  YBitMap - The Y coordinate that specifies the upper left corner of the drawing operation in reference  to  the
;                  +image itself. Pixels of the image that are to the left of XBitmap and above YBitmap do not appear.
;                  BK      - Image background color. This can be an application defined RGB value or one of the following values:
;                  |$CLR_DEFAULT - Default background color. The image is drawn using the image list background color.
;                  |$CLR_NONE    - No background color. The image is drawn transparently.
;                  FG      - Image foreground color. This member is used only if Style includes the $ILD_BLEND25 or  $ILD_BLEND50
;                  +flag. This can be an application defined RGB value or one of the following values:
;                  |$CLR_DEFAULT - Default foreground color. The image is drawn using the system highlight color.
;                  |$CLR_NONE    - No blend color. The image is blended with the color of the destination device context.
;                  Style   - Flag specifying the drawing style and, optionally, the overlay image
;                  ROP     - Value specifying a raster operation code. This defines how the color data for the  source  rectangle
;                  +will be combined with the color data for the destination rectangle to achieve the final color. This member is
;                  +ignored if Style does not include the $ILD_ROP flag. Some common raster operation codes include:
;                  |$BLACKNESS   - Fills the destination rectangle using the color from index zero in the physical palette.
;                  |$DSTINVERT   - Inverts the destination rectangle .
;                  |$MERGECOPY   - Merges the source rectangle colors with the specified pattern using the AND operator .
;                  |$MERGEPAINT  - Merges the inverted source rectangle colors with the destination rectangle colors by using the
;                  +OR operator.
;                  |$NOTSRCCOPY  - Copies the inverted source rectangle to the destination.
;                  |$NOTSRCERASE - Combines the source and destination rectangle colors by using the  OR  operator.  Inverts  the
;                  +resultant color.
;                  |$PATCOPY     - Copies the specified pattern into the destination bitmap
;                  |$PATINVERT   - Combines the specified pattern colors with the destination rectangle colors by using  the  XOR
;                  +operator.
;                  |$PATPAINT    - Combines the pattern colors with the inverted source rectangle colors and combines the  result
;                  +_with the destination rectangle colors by using the OR operator.
;                  |$SRCAND      - Combines the source and destination rectangle colors by using the Boolean AND operator.
;                  |$SRCCOPY     - Copies the source rectangle directly to the destination rectangle.
;                  |$SRCERASE    - Combines the destination rectangle's inverted colors with the source rectangle colors by using
;                  +the AND operator.
;                  |$SRCINVERT   - Combines the source and destination rectangle colors by using the Boolean XOR operator.
;                  |$SRCPAINT    - Combines the source and destination rectangle colors by using the Boolean OR operator.
;                  |$WHITENESS   - Fills the destination rectangle using the color from index one in the physical palette
;                  State   - Flag that specifies the drawing state
;                  Frame   - Used with the alpha-blending effect. When used with $ILS_ALPHA, this member holds the value for  the
;                  +alpha channel. This value can be from 0 to 255, with 0 being completely transparent, and 255 being completely
;                  +opaque.
;                  Effect  - Color used for the glow and shadow effects
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagIMAGELISTDRAWPARAMS = "int Size;hwnd hWnd;int Image;hwnd hDC;int X;int Y;int CX;int CY;int XBitmap;int YBitmap;" & _
		"int BK;int FG;int Style;int ROP;int State;int Frame;int Effect"

; ===============================================================================================================================
; *******************************************************************************************************************************
; Memory Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagMEMMAP
; Description ...: Contains information about the memory
; Fields ........: hProc - Handle to the external process
;                  Size  - Size, in bytes, of the memory block allocated
;                  Mem   - Pointer to the memory block
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagMEMMAP = "hwnd hProc;int Size;ptr Mem"

; ===============================================================================================================================
; *******************************************************************************************************************************
; Menu Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagMDINEXTMENU
; Description ...: tagMDINEXTMENU structure
; Fields ........: hMenuIn   - Receives a handle to the current menu
;                  hMenuNext - Specifies a handle to the menu to be activated
;                  hWndNext  - Specifies a handle to the window to receive the menu notification messages
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagMDINEXTMENU = "hwnd hMenuIn;hwnd hMenuNext;hwnd hWndNext"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagMENUBARINFO
; Description ...: tagMENUBARINFO structure
; Fields ........: Size     - Specifies the size, in bytes, of the structure
;                  Left     - Specifies the x coordinate of the upper left corner of the rectangle
;                  Top      - Specifies the y coordinate of the upper left corner of the rectangle
;                  Right    - Specifies the x coordinate of the lower right corner of the rectangle
;                  Bottom   - Specifies the y coordinate of the lower right corner of the rectangle
;                  hMenu    - Handle to the menu bar or popup menu
;                  hWndMenu - Handle to the menu bar or popup menu
;                  Focused  - True if the item has focus
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagMENUBARINFO = "int Size;int Left;int Top;int Right;int Bottom;int hMenu;int hWndMenu;int Focused"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagMENUEX_TEMPLATE_HEADER
; Description ...: tagMENUEX_TEMPLATE_HEADER structure
; Fields ........: Version - Template version number. This member must be 1 for extended menu templates.
;                  Offset  - Offset of the first tagMENUEX_TEMPLATE_ITEM structure, relative to the end of this structure member.
;                  +If the first item definition immediately follows the HelpId member, this member should be 4.
;                  HelpID  - Help identifier of menu bar
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagMENUEX_TEMPLATE_HEADER = "short Version;short Offset;int HelpID"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagMENUEX_TEMPLATE_ITEM
; Description ...: tagMENUEX_TEMPLATE_ITEM structure
; Fields ........: HelpID  - Help identifier for a drop down menu or submenu.  This member, which is included only for items that
;                  +open drop down menus or submenus, is located at the first dword boundary following the variable  length  Text
;                  +member.
;                  Type    - Menu item type
;                  State   - Menu item state
;                  MenuID  - Menu item identifier
;                  ResInfo - Value specifying whether the menu item is the last item in the menu bar, drop down menu, submenu, or
;                  +shortcut menu and whether it is an item that opens a drop down menu or submenu.  This member can be  zero  or
;                  +more of these values:
;                  |0x0001 - The structure defines a item that opens a drop down menu or submenu.  Subsequent  structures  define
;                  +menu items in the corresponding drop down menu or submenu.
;                  |0x0080 - The structure defines the last menu item
;                  Text    - Menu item text. This is a null terminated Unicode string aligned on a word boundary. The size of the
;                  +menu item definition varies depending on the length of this string.
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagMENUEX_TEMPLATE_ITEM = "int HelpID;int Type;int State;int MenuID;short ResInfo;ptr Text"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagMENUGETOBJECTINFO
; Description ...: tagMENUGETOBJECTINFO structure
; Fields ........: Flags - Position of the mouse cursor with respect to the item indicated by Pos. It can be one of the following
;                  +values.:
;                  |$MNGOF_BOTTOMGAP - Mouse is on the bottom of the item indicated by Pos
;                  |$MNGOF_TOPGAP    - Mouse is on the top of the item indicated by Pos
;                  Pos   - Position of the item the mouse cursor is on
;                  hMenu - Handle to the menu the mouse cursor is on
;                  RIID  - Identifier of the requested interface. Currently it can only be IDropTarget.
;                  Obj   - Pointer to the interface corresponding to the RIID member.  This pointer is  to  be  returned  by  the
;                  +application when processing the message.
; Author ........: Paul Campbell (PaulIA)
; Remarks .......: The tagMENUGETOBJECTINFO structure is used only in drag and drop menus.  When the $WM_MENUGETOBJECT message is
;                  sent, lParam is a pointer to  this  structure.  To  create  a  drag  and  drop  menu,  call  SetMenuInfo  with
;                  $MNS_DRAGDROP set
; ===============================================================================================================================
Global Const $tagMENUGETOBJECTINFO = "int Flags;int Pos;hwnd hMenu;ptr RIID;ptr Obj"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagMENUINFO
; Description ...: Contains information about a menu
; Fields ........: Size          - Specifies the size, in bytes, of the structure
;                  Mask          - Members to retrieve or set. This member can be one or more of the following values:
;                  |$MIM_APPLYTOSUBMENUS - Settings apply to the menu and all of its submenus
;                  |$MIM_BACKGROUND      - Retrieves or sets the hBack member
;                  |$MIM_HELPID          - Retrieves or sets the ContextHelpID member
;                  |$MIM_MAXHEIGHT       - Retrieves or sets the YMax member
;                  |$MIM_MENUDATA        - Retrieves or sets the MenuData member
;                  |$MIM_STYLE           - Retrieves or sets the Style member
;                  Style         - Style of the menu. It can be one or more of the following values:
;                  |$MNS_AUTODISMISS - Menu automatically ends when mouse is outside the menu for approximately 10 seconds
;                  |$MNS_CHECKORBMP  - The same space is reserved for the check mark and the bitmap
;                  |$MNS_DRAGDROP    - Menu items are OLE drop targets or drag sources
;                  |$MNS_MODELESS    - Menu is modeless
;                  |$MNS_NOCHECK     - No space is reserved to the left of an item for a check mark
;                  |$MNS_NOTIFYBYPOS - A WM_MENUCOMMAND message is sent instead of a WM_COMMAND message when a selection is made
;                  YMax          - Maximum height of the menu in pixels
;                  hBack         - Brush to use for the menu's background
;                  ContextHelpID - The context help identifier
;                  MenuData      - An application defined value
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagMENUINFO = "int Size;int Mask;int Style;int YMax;int hBack;int ContextHelpID;ptr MenuData"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagMENUITEMINFO
; Description ...: Contains information about a menu item
; Fields ........: Size         - Specifies the size, in bytes, of the structure
;                  Mask         - Members to retrieve or set. This member can be one or more of these values:
;                  |$MIIM_BITMAP     - Retrieves or sets the BmpItem member
;                  |$MIIM_CHECKMARKS - Retrieves or sets the BmpChecked and BmpUnchecked members
;                  |$MIIM_DATA       - Retrieves or sets the ItemData member
;                  |$MIIM_FTYPE      - Retrieves or sets the Type member
;                  |$MIIM_ID         - Retrieves or sets the ID member
;                  |$MIIM_STATE      - Retrieves or sets the State member
;                  |$MIIM_STRING     - Retrieves or sets the TypeData member
;                  |$MIIM_SUBMENU    - Retrieves or sets the SubMenu member
;                  |$MIIM_TYPE       - Retrieves or sets the Type and TypeData members
;                  Type         - Menu item type. This member can be one or more of the following values:
;                  |$MFT_BITMAP       - Displays the menu item using a bitmap
;                  |$MFT_MENUBARBREAK - Places the menu item on a new line or in a new column
;                  |$MFT_MENUBREAK    - Places the menu item on a new line or in a new column
;                  |$MFT_OWNERDRAW    - Assigns responsibility for drawing the menu item to the menu owner
;                  |$MFT_RADIOCHECK   - Displays selected menu items using a radio button mark
;                  |$MFT_RIGHTJUSTIFY - Right justifies the menu item and any subsequent items
;                  |$MFT_RIGHTORDER   - Specifies that menus cascade right to left
;                  |$MFT_SEPARATOR    - Specifies that the menu item is a separator
;                  State        - Menu item state. This member can be one or more of these values:
;                  |$MFS_CHECKED   - Checks the menu item
;                  |$MFS_DEFAULT   - Specifies that the menu item is the default
;                  |$MFS_DISABLED  - Disables the menu item and grays it so that it cannot be selected
;                  |$MFS_ENABLED   - Enables the menu item so that it can be selected
;                  |$MFS_GRAYED    - Disables the menu item and grays it so that it cannot be selected
;                  |$MFS_HILITE    - Highlights the menu item
;                  ID           - Application-defined 16-bit value that identifies the menu item
;                  SubMenu      - Handle to the drop down menu or submenu associated with the menu item
;                  BmpChecked   - Handle to the bitmap to display next to the item if it is selected
;                  BmpUnchecked - Handle to the bitmap to display next to the item if it is not selected
;                  ItemData     - Application-defined value associated with the menu item
;                  TypeData     - Content of the menu item
;                  CCH          - Length of the menu item text
;                  BmpItem      - Handle to the bitmap to be displayed
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagMENUITEMINFO = "int Size;int Mask;int Type;int State;int ID;int SubMenu;int BmpChecked;int BmpUnchecked;" & _
		"int ItemData;ptr TypeData;int CCH;int BmpItem"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagMENUITEMTEMPLATE
; Description ...: tagMENUITEMTEMPLATE structure
; Fields ........: Option - Specifies one or more of the following predefined menu options that control  the  appearance  of  the
;                  +menu item:
;                  |$MF_CHECKED      - Indicates that the menu item has a check mark next to it
;                  |$MF_GRAYED       - Indicates that the menu item is initially inactive and drawn with a gray effect
;                  |$MF_HELP         - Indicates that the menu item has a vertical separator to its left
;                  |$MF_MENUBARBREAK - Indicates that the menu item is placed in a new column, separated by a bar
;                  |$MF_MENUBREAK    - Indicates that the menu item is placed in a new column
;                  |$MF_OWNERDRAW    - Indicates that the menu item is owner drawn
;                  |$MF_POPUP        - Indicates that the item is one that opens a drop down menu or submenu
;                  ID     - Specifies the menu item identifier
;                  String - Specifies the null terminated string for the menu item
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagMENUITEMTEMPLATE = "short Option;short ID;ptr String"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagMENUITEMTEMPLATEHEADER
; Description ...: tagMENUITEMTEMPLATEHEADER structure
; Fields ........: Version - Specifies the version number. This member must be zero.
;                  Offset  - Specifies the offset in bytes from the end of the header.  The menu item list begins at this offset.
;                  +Usually, this member is zero, and the menu item list follows immediately after the header.
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagMENUITEMTEMPLATEHEADER = "short Version;short Offset"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagTPMPARAMS
; Description ...: tagTPMPARAMS structure
; Fields ........: Size   - Size of structure, in bytes
;                  Left   - X position of upper left corner to exclude when positioing the window
;                  Top    - Y position of upper left corner to exclude when positioing the window
;                  Right  - X position of lower right corner to exclude when positioing the window
;                  Bottom - Y position of lower right corner to exclude when positioing the window
; Author ........: Paul Campbell (PaulIA)
; Remarks .......: All coordinates are in screen coordinates
; ===============================================================================================================================
Global Const $tagTPMPARAMS = "short Version;short Offset"

; ===============================================================================================================================
; *******************************************************************************************************************************
; Net Share Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagCONNECTION_INFO_1
; Description ...: tagCONNECTION_INFO_1 structure
; Fields ........: ID       - Specifies a connection identification number
;                  Type     - Specifies the type of connection made from the local device name to the shared resource:
;                  |$STYPE_DISKTREE - Print queue
;                  |$STYPE_PRINTQ   - Disk drive
;                  |$STYPE_DEVICE   - Communication device
;                  |$STYPE_IPC      - IPC
;                  |$STYPE_SPECIAL  - Special share reserved for IPC$ or remote administration of the server
;                  Opens    - Specifies the number of files currently open as a result of the connection
;                  Users    - Specifies the number of users on the connection
;                  Time     - Specifies the number of seconds that the connection has been established
;                  Username - If the server sharing the resource is running with user-level security, this member describes which
;                  +user made the connection.  If the server is running with share-level security, this  member  describes  which
;                  +computer made the connection.
;                  Netname  - Specifies either the share name of the server's shared resource or the computername of the client
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagCONNECTION_INFO_1 = "int ID;int Type;int Opens;int Users;int Time;ptr Username;ptr NetName"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagFILE_INFO_3
; Description ...: tagFILE_INFO_3 structure
; Fields ........: ID          - The identification number assigned to the resource when it is opened
;                  Permissions - the access permissions associated with the opening application:
;                  |$PERM_FILE_READ   - Permission to read a resource and, by default, execute the resource
;                  |$PERM_FILE_WRITE  - Permission to write to a resource
;                  |$PERM_FILE_CREATE - Permission to create a resource
;                  Locks       - Contains the number of file locks on the file, device, or pipe
;                  Pathname    - Specifies the path of the opened resource
;                  Username    - Specifies which user or which computer opened the resource
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagFILE_INFO_3 = "int ID;int Permissions;int Locks;ptr Pathname;ptr Username"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagSESSION_INFO_2
; Description ...: tagSESSION_INFO_2 structure
; Fields ........: CName     - Unicode string specifying the name of the computer that established the session
;                  Username  - Unicode string specifying the name of the user who established the session
;                  Opens     - Specifies the number of files, devices, and pipes opened during the session
;                  Time      - Specifies the number of seconds the session has been active
;                  Idle      - Specifies the number of seconds the session has been idle
;                  Flags     - Specifies a value that describes how the user established the session:
;                  |$SESS_GUEST        - The user established the session using a guest account
;                  |$SESS_NOENCRYPTION - The user established the session without using password encryption
;                  TypeName  - Unicode string that specifies the type of client that established the session
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagSESSION_INFO_2 = "ptr CName;ptr Username;int Opens;int Time;int Idle;int Flags;ptr TypeName"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagSESSION_INFO_502
; Description ...: tagSESSION_INFO_502 structure
; Fields ........: CName     - Unicode string specifying the name of the computer that established the session
;                  Username  - Unicode string specifying the name of the user who established the session
;                  Opens     - Specifies the number of files, devices, and pipes opened during the session
;                  Time      - Specifies the number of seconds the session has been active
;                  Idle      - Specifies the number of seconds the session has been idle
;                  Flags     - Specifies a value that describes how the user established the session:
;                  |$SESS_GUEST        - The user established the session using a guest account
;                  |$SESS_NOENCRYPTION - The user established the session without using password encryption
;                  TypeName  - Unicode string that specifies the type of client that established the session
;                  Transport - Specifies the name of the transport that the client is using
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagSESSION_INFO_502 = "ptr CName;ptr Username;int Opens;int Time;int Idle;int Flags;ptr TypeName;ptr Transport"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagSHARE_INFO_2
; Description ...: tagSHARE_INFO_2 structure
; Fields ........: NetName     - Unicode string specifying the share name of a resource
;                  Type        - Contains the type of the shared resource. Can be a combination of:
;                  |$STYPE_DISKTREE  - Print queue
;                  |$STYPE_PRINTQ    - Disk drive
;                  |$STYPE_DEVICE    - Communication device
;                  |$STYPE_IPC       - IPC
;                  |$STYPE_SPECIAL   - Special share reserved for IPC$ or remote administration of the server
;                  |$STYPE_TEMPORARY - A temporary share
;                  Remark      - Unicode string that contains an optional comment about the shared resource
;                  Permissions - Indicates the shared resource's permissions:
;                  |$ACCESS_READ   - Permission to read data from a resource and, by default, to execute the resource
;                  |$ACCESS_WRITE  - Permission to write data to the resource
;                  |$ACCESS_CREATE - Permission to create an instance of the resource
;                  |$ACCESS_EXEC   - Permission to execute the resource
;                  |$ACCESS_DELETE - Permission to delete the resource
;                  |$ACCESS_ATRIB  - Permission to modify the resource's attributes
;                  |$ACCESS_PERM   - Permission to modify the permissions assigned to a resource
;                  |$ACCESS_ALL    - Permission to read, write, create, execute, and delete resources
;                  MaxUses     - The maximum number of concurrent connections that the shared resource can accommodate
;                  CurrentUses - Indicates the number of current connections to the resource
;                  Path        - Unicode string specifying the local path for the shared resource
;                  Password    - Unicode string that specifies the share's password
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagSHARE_INFO_2 = "ptr NetName;int Type;ptr Remark;int Permissions;int MaxUses;int CurrentUses;ptr Path;ptr Password"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagSTAT_SERVER_0
; Description ...: tagSTAT_SERVER_0
; Fields ........: Start      - Indicates the time when statistics collection started.  The value is  stored  as  the  number  of
;                  +seconds that have elapsed since 00:00:00, January 1, 1970, GMT.
;                  FOpens     - Indicates the number of times a file is opened on a server
;                  DevOpens   - Indicates the number of times a server device is opened
;                  JobsQueued - Indicates the number of server print jobs spooled
;                  SOpens     - Indicates the number of times the server session started
;                  STimeOut   - Indicates the number of times the server session automatically disconnected
;                  SErrorOut  - Indicates the number of times the server sessions failed with an error
;                  PWErrors   - Indicates the number of server password violations
;                  PermErrors - Indicates the number of server access permission errors
;                  SysErrors  - Indicates the number of server system errors
;                  ByteSent   - Number of server bytes sent to the network
;                  ByteRecv   - Number of server bytes received from the network
;                  AvResponse - Indicates the average server response time (in milliseconds)
;                  ReqBufNeed - Indicates the number of times the server required a request buffer but failed to allocate one
;                  BigBufNeed - Indicates the number of times the server required a big buffer but failed to allocate one
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagSTAT_SERVER_0 = "int Start;int FOpens;int DevOpens;int JobsQueued;int SOpens;int STimedOut;int SErrorOut;" & _
		"int PWErrors;int PermErrors;int SysErrors;int64 ByteSent;int64 ByteRecv;int AvResponse;int ReqBufNeed;int BigBufNeed"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagSTAT_WORKSTATION_0
; Description ...: tagSTAT_WORKSTATION_0
; Fields ........: StartTime         - Specifies the time statistics collection started.  The value is stored as  the  number  of
;                  +seconds elapsed since 00:00:00, January 1, 1970.
;                  BytesSent         - Specifies the total number of bytes received by the workstation
;                  SMBSRecv          - Specifies the total number of server message blocks (SMBs) received by the workstation
;                  PageRead          - Specifies the total number of bytes that have been read by paging I/O requests
;                  NonPageRead       - Specifies the total number of bytes that have been read by non-paging I/O requests
;                  CacheRead         - Specifies the total number of bytes that have been read by cache I/O requests
;                  NetRead           - Specifies the total amount of bytes that have been read by disk I/O requests
;                  BytesTran         - Specifies the total number of bytes transmitted by the workstation
;                  SMBSTran          - Specifies the total number of SMBs transmitted by the workstation
;                  PageWrite         - Specifies the total number of bytes that have been written by paging I/O requests
;                  NonPageWrite      - Specifies the total number of bytes that have been written by non-paging I/O requests
;                  CacheWrite        - Specifies the total number of bytes that have been written by cache I/O requests
;                  NetWrite          - Specifies the total number of bytes that have been written by disk I/O requests
;                  InitFailed        - Specifies the total number of network operations that failed to begin
;                  FailedComp        - Specifies the total number of network operations that failed to complete
;                  ReadOp            - Specifies the total number of read operations initiated by the workstation
;                  RandomReadOp      - Specifies the total number of random access reads initiated by the workstation
;                  ReadSMBS          - Specifies the total number of read requests the workstation has sent to servers
;                  LargeReadSMBS     - Specifies the total number of read requests the workstation has sent to servers  that  are
;                  +greater than twice the size of the server's negotiated buffer size.
;                  SmallReadSMBS     - Specifies the total number of read requests the workstation has sent to servers  that  are
;                  +less than 1/4 of the size of the server's negotiated buffer size.
;                  WriteOp           - Specifies the total number of write operations initiated by the workstation
;                  RandomWriteOp     - Specifies the total number of random access writes initiated by the workstation
;                  WriteSMBS         - Specifies the total number of write requests the workstation has sent to servers
;                  LargeWriteSMBS    - Specifies the total number of write requests the workstation has sent to servers that  are
;                  +greater than twice the size of the server's negotiated buffer size.
;                  SmallWriteSMBS    - Specifies the total number of write requests the workstation has sent to servers that  are
;                  +less than 1/4 of the size of the server's negotiated buffer size.
;                  RawReadsDenied    - Specifies the total number of raw read requests made by the  workstation  that  have  been
;                  +denied.
;                  RawWritesDenied   - Specifies the total number of raw write requests made by the workstation  that  have  been
;                  +denied.
;                  NetworkErrors     - Specifies the total number of network errors received by the workstation
;                  Sessions          - Specifies the total number of workstation sessions that were established
;                  FailedSessions    - Specifies the number of times the workstation attempted to create a session but failed
;                  Reconnects        - Specifies the total number of connections that have failed
;                  CoreConnects      - Specifies the total number of connections to servers supporting  the  PCNET  dialect  that
;                  +have succeeded.
;                  LM20Connects      - Specifies the total number of connections to servers supporting the LanManager 2.0 dialect
;                  +that have succeeded.
;                  LM21Connects      - Specifies the total number of connections to servers supporting the LanManager 2.1 dialect
;                  +that have succeeded.
;                  LMNTConnects      - Specifies the total number of connections to servers supporting  the  Windows  NT  dialect
;                  +that have succeeded.
;                  ServerDisconnects - Specifies the number of times the workstation was disconnected by a network server
;                  HungSessions      - Specifies the total number of sessions that have expired on the workstation
;                  UseCount          - Specifies the total number of network connections established by the workstation
;                  FailedUseCount    - Specifies the total number of failed network connections for the workstation
;                  CurrentCommands   - Specifies the number of current requests that have not been completed
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagSTAT_WORKSTATION_0 = "int64 StartTime;int64 BytesRecv;int64 SMBSRecv;int64 PageRead;int64 NonPageRead;" & _
		"int64 CacheRead;int64 NetRead;int64 BytesTran;int64 SMBSTran;int64 PageWrite;int64 NonPageWrite;int64 CacheWrite;" & _
		"int64 NetWrite;int InitFailed;int FailedComp;int ReadOp;int RandomReadOp;int ReadSMBS;int LargeReadSMBS;" & _
		"int SmallReadSMBS;int WriteOp;int RandomWriteOp;int WriteSMBS;int LargeWriteSMBS;int SmallWriteSMBS;" & _
		"int RawReadsDenied;int RawWritesDenied;int NetworkErrors;int Sessions;int FailedSessions;int Reconnects;" & _
		"int CoreConnects;int LM20Connects;int LM21Connects;int LMNTConnects;int ServerDisconnects;int HungSessions;" & _
		"int UseCount;int FailedUseCount;int CurrentCommands"

; ===============================================================================================================================
; *******************************************************************************************************************************
; Time Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; #STRUCTURE# ===================================================================================================================
; Name...........: $tagFILETIME
; Description ...: Contains the number of 100-nanosecond intervals since January 1, 1601
; Fields ........: Lo - The low order part of the file time
;                  Hi - The high order part of the file time
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagFILETIME = "dword Lo;dword Hi"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagSYSTEMTIME
; Description ...: Specifies a date and time, in coordinated universal time (UTC)
; Fields ........: Year     - Year
;                  Month    - Month
;                  Dow      - Day of week
;                  Day      - Day
;                  Hour     - Hour
;                  Minute   - Minute
;                  Second   - Second
;                  MSeconds - MSeconds
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagSYSTEMTIME = "short Year;short Month;short Dow;short Day;short Hour;short Minute;short Second;short MSeconds"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagTIME_ZONE_INFORMATION
; Description ...: Specifies information specific to the time zone
; Fields ........: Bias    - The current bias for local time translation on this computer, in minutes
;                  StdName - A description for standard time
;                  StdDate - A SYSTEMTIME structure that contains a date and local time when the transition from daylight  saving
;                  +time to standard time occurs on this operating system.
;                  StdBias - The bias value to be used during local time translations that occur during standard time
;                  DayName - A description for daylight saving time
;                  DayDate - A SYSTEMTIME structure that contains a date and local time when the transition  from  standard  time
;                  +to daylight saving time occurs on this operating system.
;                  DayBias - The bias value to be used during local time translations that occur during daylight saving time
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagTIME_ZONE_INFORMATION = "long Bias;byte StdName[64];ushort StdDate[8];long StdBias;byte DayName[64];ushort DayDate[8];long DayBias"

; ===============================================================================================================================
; *******************************************************************************************************************************
; ProgressBar Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagPBRANGE
; Description ...: Contains information about the high and low limits of a progress bar control
; Fields ........: Low          - Low limit for the progress bar control
;                  High         - High limit for the progress bar control
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagPBRANGE = "int Low;int High"

; ===============================================================================================================================
; *******************************************************************************************************************************
; Rebar Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; #STRUCTURE# ===================================================================================================================
; Name...........: $tagREBARBANDINFO
; Description ...: Contains information about an item in a ComboBoxEx control
; Fields ........: cbSize     - Size of this structure, in bytes. Your application must fill this member before sending any messages that use the address of this structure as a parameter.
;                  fMask      - Flags that indicate which members of this structure are valid or must be filled. This value can be a combination of the following:;
;                  |$RBBIM_BACKGROUND      - The hbmBack member is valid or must be set.
;                  |$RBBIM_CHILD           - The hwndChild member is valid or must be set.
;                  |$RBBIM_CHILDSIZE       - The cxMinChild, cyMinChild, cyChild, cyMaxChild, and cyIntegral members are valid or must be set.
;                  |$RBBIM_COLORS          - The clrFore and clrBack members are valid or must be set.
;                  |$RBBIM_HEADERSIZE      - Version 4.71. The cxHeader member is valid or must be set.
;                  |$RBBIM_IDEALSIZE       - Version 4.71. The cxIdeal member is valid or must be set.
;                  |$RBBIM_ID              - The wID member is valid or must be set.
;                  |$RBBIM_IMAGE           - The iImage member is valid or must be set.
;                  |$RBBIM_LPARAM          - Version 4.71. The lParam member is valid or must be set.
;                  |$RBBIM_SIZE            - The cx member is valid or must be set.
;                  |$RBBIM_STYLE           - The fStyle member is valid or must be set.
;                  |$RBBIM_TEXT            - The lpText member is valid or must be set.
;                  |$RBBIM_CHEVRONLOCATION - The rcChevronLocation member is valid or must be set.
;                  |$RBBIM_CHEVRONSTATE    - The uChevronState member is valid or must be set.
;                  fStyle     - Flags that specify the band style. This value can be a combination of the following:
;                  |$RBBS_BREAK            - The band is on a new line.
;                  |$RBBS_CHILDEDGE        - The band has an edge at the top and bottom of the child window.
;                  |$RBBS_FIXEDBMP         - The background bitmap does not move when the band is resized.
;                  |$RBBS_FIXEDSIZE        - The band can't be sized. With this style, the sizing grip is not displayed on the band.
;                  |$RBBS_GRIPPERALWAYS    - Version 4.71. The band will always have a sizing grip, even if it is the only band in the rebar.
;                  |$RBBS_HIDDEN           - The band will not be visible.
;                  |$RBBS_NOGRIPPER        - Version 4.71. The band will never have a sizing grip, even if there is more than one band in the rebar.
;                  |$RBBS_USECHEVRON       - Version 5.80. Show a chevron button if the band is smaller than cxIdeal.
;                  |$RBBS_VARIABLEHEIGHT   - Version 4.71. The band can be resized by the rebar control; cyIntegral and cyMaxChild affect how the rebar will resize the band.
;                  |$RBBS_NOVERT           - Don't show when vertical.
;                  |$RBBS_USECHEVRON       - Display drop-down button.
;                  |$RBBS_HIDETITLE        - Keep band title hidden.
;                  |$RBBS_TOPALIGN         - Keep band in top row.
;                  clrFore    - Band foreground colors.
;                  clrBack    - Band background colors.
;                  |If hbmBack specifies a background bitmap, these members are ignored.
;                  |By default, the band will use the background color of the rebar control set with the $RB_SETBKCOLOR message.
;                  |If a background color is specified here, then this background color will be used instead.
;                  lpText     - Pointer to a buffer that contains the display text for the band.
;                  |If band information is being requested from the control and $RBBIM_TEXT is specified in fMask,
;                  |this member must be initialized to the address of the buffer that will receive the text.
;                  cch        - Size of the buffer at lpText, in bytes. If information is not being requested from the control, this member is ignored.
;                  iImage     - Zero-based index of any image that should be displayed in the band. The image list is set using the $RB_SETBARINFO message.
;                  hwndChild  - Handle to the child window contained in the band, if any.
;                  cxMinChild - Minimum width of the child window, in pixels. The band can't be sized smaller than this value.
;                  cyMinChild - Minimum height of the child window, in pixels. The band can't be sized smaller than this value.
;                  cx         - Length of the band, in pixels.
;                  hbmBack    - Handle to a bitmap that is used as the background for this band.
;                  wID        - UINT value that the control uses to identify this band for custom draw notification messages.
;                  cyChild    - Version 4.71. Initial height of the band, in pixels. This member is ignored unless the $RBBS_VARIABLEHEIGHT style is specified.
;                  cyMaxChild - Version 4.71. Maximum height of the band, in pixels. This member is ignored unless the $RBBS_VARIABLEHEIGHT style is specified.
;                  cyIntegral - Version 4.71. Step value by which the band can grow or shrink, in pixels.
;                  |If the band is resized, it will be resized in steps specified by this value.
;                  |This member is ignored unless the $RBBS_VARIABLEHEIGHT style is specified.
;                  cxIdeal    - Version 4.71. Ideal width of the band, in pixels.
;                  |If the band is maximized to the ideal width (see $RB_MAXIMIZEBAND), the rebar control will attempt to make the band this width.
;                  lParam     - Version 4.71. Application-defined value.
;                  cxHeader   - Version 4.71. Size of the band's header, in pixels.
;                  |The band header is the area between the edge of the band and the edge of the child window.
;                  |This is the area where band text and images are displayed, if they are specified.
;                  |If this value is specified, it will override the normal header dimensions that the control calculates for the band.
; Author ........: Gary Frost
; Remarks .......:
; ===============================================================================================================================
Global Const $tagREBARBANDINFO = "uint cbSize;uint fMask;uint fStyle;dword clrFore;dword clrBack;ptr lpText;uint cch;" & _
		"int iImage;hwnd hwndChild;uint cxMinChild;uint cyMinChild;uint cx;hwnd hbmBack;uint wID;uint cyChild;uint cyMaxChild;" & _
		"uint cyIntegral;uint cxIdeal;int lParam;uint cxHeader"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMREBARAUTOBREAK
; Description ...: Contains information used with the $RBN_AUTOBREAK notification
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  uBand         - Zero-based index of the band affected by the notification. This is -1 if no band is affected.
;                  wID           - Application-defined ID of the band.
;                  lParam        - Application-defined value from the lParam member of the $tagREBARBANDINFO structure that defines the rebar band.
;                  uMsg          - ID of the message.
;                  fStyleCurrent - Style of the specified band.
;                  fAutoBreak    - indicates whether a break should occur.
; Author ........: Gary Frost
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMREBARAUTOBREAK = $tagNMHDR & ";uint uBand;uint wID;int lParam;uint uMsg;uint fStyleCurrent;int fAutoBreak"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMRBAUTOSIZE
; Description ...: Contains information used in handling the $RBN_AUTOSIZE notification messages
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  fChanged      - Member that indicates if the size or layout of the rebar control has changed (nonzero if a change occurred or zero otherwise)
;                  TargetLeft   - Specifies the x-coordinate of the upper-left corner of the rectangle to which the rebar control tried to size itself
;                  TargetTop    - Specifies the y-coordinate of the upper-left corner of the rectangle to which the rebar control tried to size itself
;                  TargetRight  - Specifies the x-coordinate of the lower-right corner of the rectangle to which the rebar control tried to size itself
;                  TargetBottom - Specifies the y-coordinate of the lower-right corner of the rectangle to which the rebar control tried to size itself
;                  ActualLeft   - Specifies the x-coordinate of the upper-left corner of the rectangle to which the rebar control actually sized itself
;                  ActualTop    - Specifies the y-coordinate of the upper-left corner of the rectangle to which the rebar control actually sized itself
;                  ActualRight  - Specifies the x-coordinate of the lower-right corner of the rectangle to which the rebar control actually sized itself
;                  ActualBottom - Specifies the y-coordinate of the lower-right corner of the rectangle to which the rebar control actually sized itself
; Author ........: Gary Frost
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMRBAUTOSIZE = $tagNMHDR & ";int fChanged;int TargetLeft;int TargetTop;int TargetRight;int TargetBottom;" & _
		"int ActualLeft;int ActualTop;int ActualRight;int ActualBottom"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMREBAR
; Description ...: Contains information used in handling various rebar notification messages
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  dwMask        - Set of flags that define which members of this structure contain valid information. This can be one or more of the following values:
;                  |$RBNM_ID     - The wID member contains valid information.
;                  |$RBNM_LPARAM - The lParam member contains valid information.
;                  |$RBNM_STYLE  - The fStyle member contains valid information.
;                  uBand         - Zero-based index of the band affected by the notification. This will be -1 if no band is affected.
;                  fStyle        - The style of the band. This is one or more of the $RBBS_ styles detailed in the fStyle member of the $tagREBARBANDINFO structure.
;                  |This member is only valid if dwMask contains $RBNM_STYLE.
;                  wID           - Application-defined identifier of the band. This member is only valid if dwMask contains $RBNM_ID.
;                  lParam        - Application-defined value associated with the band. This member is only valid if dwMask contains $RBNM_LPARAM
; Author ........: Gary Frost
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMREBAR = $tagNMHDR & ";dword dwMask;uint uBand;uint fStyle;uint wID;int lParam"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMREBARCHEVRON
; Description ...: Contains information used in handling the RBN_CHEVRONPUSHED notification message
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  uBand         - Zero-based index of the band sending the notification
;                  wID           - Application-defined identifier for the band
;                  lParam        - Application-defined value associated with the band
;                  Left          - Specifies the x-coordinate of the upper-left corner of the rectangle
;                  Top           - Specifies the y-coordinate of the upper-left corner of the rectangle
;                  Right         - Specifies the x-coordinate of the lower-right corner of the rectangle
;                  Bottom        - Specifies the y-coordinate of the lower-right corner of the rectangle
;                  lParamNM      - An application-defined value
;                  |If the $RBN_CHEVRONPUSHED notification was sent as a result of an $RB_PUSHCHEVRON message, this member contains the message's lAppValue value.
;                  |Otherwise, it is set to zero.
; Author ........: Gary Frost
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMREBARCHEVRON = $tagNMHDR & ";uint uBand;uint wID;int lParam;int Left;int Top;int Right;int Bottom;int lParamNM"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMREBARCHILDSIZE
; Description ...: Contains information used in handling the RBN_CHILDSIZE notification message
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  uBand         - Zero-based index of the band sending the notification
;                  wID           - Application-defined identifier for the band
;                  CLeft     - Specifies the x-coordinate of the upper-left corner of the rectangle of the new size of the child window
;                  |This member can be changed during the notification to modify the child window's position and size
;                  CTop      - Specifies the y-coordinate of the upper-left corner of the rectangle of the new size of the child window
;                  |This member can be changed during the notification to modify the child window's position and size
;                  CRight    - Specifies the x-coordinate of the lower-right corner of the rectangle of the new size of the child window
;                  |This member can be changed during the notification to modify the child window's position and size
;                  CBottom   - Specifies the y-coordinate of the lower-right corner of the rectangle of the new size of the child window
;                  |This member can be changed during the notification to modify the child window's position and size
;                  BLeft     - Specifies the x-coordinate of the upper-left corner of the rectangle of the new size of the band
;                  BTop      - Specifies the y-coordinate of the upper-left corner of the rectangle of the new size of the band
;                  BRight    - Specifies the x-coordinate of the lower-right corner of the rectangle of the new size of the band
;                  BBottom   - Specifies the y-coordinate of the lower-right corner of the rectangle of the new size of the band
; Author ........: Gary Frost
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMREBARCHILDSIZE = $tagNMHDR & ";uint uBand;uint wID;int CLeft;int CTop;int CRight;int CBottom;" & _
		"int BLeft;int BTop;int BRight;int BBottom"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagREBARINFO
; Description ...: Contains information that describes rebar control characteristics
; Fields ........: cbSize         - Size of this structure, in bytes. Your application must fill this member before sending any messages that use the address of this structure as a parameter.
;                  fMask          - Flag values that describe characteristics of the rebar control. Currently, rebar controls support only one value:
;                  |$RBIM_IMAGELIST - The himl member is valid or must be filled
;                  himl           - Handle to an image list. The rebar control will use the specified image list to obtain images
; Author ........: Gary Frost
; Remarks .......:
; ===============================================================================================================================
Global Const $tagREBARINFO = "uint cbSize;uint fMask;hwnd himl"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagRBHITTESTINFO
; Description ...: Contains information specific to a hit test operation
; Fields ........: X - Specifies the x-coordinate of the point
;                  Y - Specifies the y-coordinate of the point
;                  flags - Member that receives a flag value indicating the rebar band's component located at the point described by pt
;                  |This member will be one of the following:
;                  -
;                  |$RBHT_CAPTION - The point was in the rebar band's caption
;                  |$RBHT_CHEVRON - The point was in the rebar band's chevron (version 5.80 and greater)
;                  |$RBHT_CLIENT  - The point was in the rebar band's client area
;                  |$RBHT_GRABBER - The point was in the rebar band's gripper
;                  |$RBHT_NOWHERE - The point was not in a rebar band
;                  iBand - Member that receives the rebar band's index at the point described by pt
;                  |This value will be the zero-based index of the band, or -1 if no band was at the hit-tested point
; Author ........: Gary Frost
; Remarks .......:
; ===============================================================================================================================
Global Const $tagRBHITTESTINFO = "int X;int Y;uint flags;int iBand"

; ===============================================================================================================================
; *******************************************************************************************************************************
; ToolBar Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; #STRUCTURE# ===================================================================================================================
; Name...........: $tagCOLORSCHEME
; Description ...: Contains information for the drawing of buttons in a toolbar or rebar
; Fields ........: Size         - Size of this structure, in bytes
;                  BtnHighlight - The COLORREF value that represents the highlight color of the buttons. Use $CLR_DEFAULT for the
;                  +default highlight color.
;                  BtnShadow    - The COLORREF value that represents the shadow color of the buttons.  Use $CLR_DEFAULT  for  the
;                  +default shadow color.
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagCOLORSCHEME = "int Size;int BtnHighlight;int BtnShadow"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagTBADDBITMAP
; Description ...: Adds a bitmap that contains button images to a toolbar
; Fields ........: hInst - Handle to the module instance with the executable file that contains a bitmap resource.  To use bitmap
;                  +handles instead of resource IDs, set this member to 0.  You can add the system-defined button bitmaps to  the
;                  +list by specifying $HINST_COMMCTRL as the hInst member and one of the following values as the ID member:
;                  |$IDB_STD_LARGE_COLOR  - Adds large, color standard bitmaps
;                  |$IDB_STD_SMALL_COLOR  - Adds small, color standard bitmaps
;                  |$IDB_VIEW_LARGE_COLOR - Adds large, color view bitmaps
;                  |$IDB_VIEW_SMALL_COLOR - Adds small, color view bitmaps
;                  ID    - If hInst is 0, set this member to the bitmap handle of the bitmap with the button  images.  Otherwise,
;                  +set it to the resource identifier of the bitmap with the button images.
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagTBADDBITMAP = "int hInst;int ID"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMTOOLBAR
; Description ...: Contains information used to process toolbar notification messages
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  iItem    - Command identifier of the button associated with the notification
;                  iBitmap  - Zero-based index of the button image.
;                  |If the button is a separator, that is, if fsStyle is set to $BTNS_SEP, iBitmap determines the width of the separator, in pixels
;                  idCommand - Command identifier associated with the button. This identifier is used in a WM_COMMAND message when the button is chosen
;                  fsState   - Button state flags. This member can be a combination of the values listed in Toolbar Button States
;                  fsStyle   - Button style. This member can be a combination of the button style values listed in Toolbar Control and Button Styles
;                  dwData    - Application-defined value
;                  iString   - Zero-based index of the button string, or a pointer to a string buffer that contains text for the button
;                  cchText  - Count of characters in the button text
;                  pszText  - Address of a character buffer that contains the button text
;                  Left   - Specifies the x-coordinate of the upper-left corner of the rectangle
;                  Top    - Specifies the y-coordinate of the upper-left corner of the rectangle
;                  Right  - Specifies the x-coordinate of the lower-right corner of the rectangle
;                  Bottom - Specifies the y-coordinate of the lower-right corner of the rectangle
; Author ........: Gary Frost
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNMTOOLBAR = $tagNMHDR & ";int iItem;int iBitmap;int idCommand;" & _
		"byte fsState;byte fsStyle;byte bReserved1;byte bReserved2;dword dwData;int iString;int cchText;" & _
		"ptr pszText;int Left;int Top;int Right;int Bottom"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNMTBHOTITEM
; Description ...: Contains information used with the $TBN_HOTITEMCHANGE notification
; Fields ........: $tagNMHDR - Contains information about a notification message
;                  idOld    - Command identifier of the previously highlighted item
;                  idNew    - Command identifier of the item about to be highlighted
;                  dwFlags  - Flags that indicate why the hot item has changed. This can be one or more of the following values:
;                  |$HICF_ACCELERATOR - The change in the hot item was caused by a shortcut key
;                  |$HICF_ARROWKEYS   - The change in the hot item was caused by an arrow key
;                  |$HICF_DUPACCEL    - Modifies $HICF_ACCELERATOR. If this flag is set, more than one item has the same shortcut key character
;                  |$HICF_ENTERING    - Modifies the other reason flags. If this flag is set, there is no previous hot item and idOld does not contain valid information
;                  |$HICF_LEAVING     - Modifies the other reason flags. If this flag is set, there is no new hot item and idNew does not contain valid information
;                  |$HICF_LMOUSE      - The change in the hot item resulted from a left-click mouse event
;                  |$HICF_MOUSE       - The change in the hot item resulted from a mouse event
;                  |$HICF_OTHER       - The change in the hot item resulted from an event that could not be determined. This will most often be due to a change in focus or the $TB_SETHOTITEM message
;                  |$HICF_RESELECT    - The change in the hot item resulted from the user entering the shortcut key for an item that was already hot
;                  |$HICF_TOGGLEDROPDOWN - Version 5.80. Causes the button to switch states
; Author ........: Gary Frost
; Remarks .......: Needs alignment for x64
; ===============================================================================================================================
Global Const $tagNMTBHOTITEM = $tagNMHDR & ";int idOld;int idNew;dword dwFlags"


; #STRUCTURE# ===================================================================================================================
; Name...........: $tagTBBUTTON
; Description ...: Contains information about a button in a toolbar
; Fields ........: Bitmap   - Zero based index of the button image. Set this member to $I_IMAGECALLBACK,  and  the  toolbar  will
;                  +send the $TBN_GETDISPINFO notification to retrieve the image index when it is  needed.  Set  this  member  to
;                  +$I_IMAGENONE to indicate that the button does not have an image. The button layout will not include any space
;                  +for a bitmap, only text.  If the button is a separator, Bitmap determines the  width  of  the  separator,  in
;                  +pixels.
;                  Command  - Command identifier associated with the button.  This identifier is used in a  $WM_COMMAND  message
;                  +when the button is chosen.
;                  State    - Button state flags
;                  Style    - Button style flags
;                  Reserved - Reserved
;                  Param    - Application defined value
;                  String   - Zero based index of the button string, or a pointer to a string that contains text for the button
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagTBBUTTON = "int Bitmap;int Command;byte State;byte Style;short Reserved;int Param;int String"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagTBBUTTONINFO
; Description ...: Contains or receives information for a specific button in a toolbar
; Fields ........: Size       - Size of this structure, in bytes
;                  Mask       - Set of flags that indicate which members contain valid information:
;                  |$TBIF_BYINDEX    - The Param sent with a $TB_GETBUTTONINFO or $TB_SETBUTTONINFO message is an index
;                  |$TBIF_COMMAND    - The Command member contains valid information or is being requested
;                  |$TBIF_IMAGE      - The Image member contains valid information or is being requested
;                  |$TBIF_IMAGELABEL - Indicates that ImageLabel should be used
;                  |$TBIF_LPARAM     - The Param member contains valid information or is being requested
;                  |$TBIF_SIZE       - The CX member contains valid information or is being requested
;                  |$TBIF_STATE      - The State member contains valid information or is being requested
;                  |$TBIF_STYLE      - The Style member contains valid information or is being requested
;                  |$TBIF_TEXT       - The Text member contains valid information or is being requested
;                  Command    - Command identifier of the button
;                  Image      - Image index of the button. Set this member to $I_IMAGECALLBACK, and the  toolbar  will  send  the
;                  +$TBN_GETDISPINFO notification to retrieve the image index when it is needed.  Set this member to $I_IMAGENONE
;                  +to indicate that the button does not have an image.
;                  State      - State flags of the button
;                  Style      - Style flags of the button
;                  CX         - Width of the button, in pixels
;                  Param      - Application defined value associated with the button
;                  Text       - Address of a character buffer that contains or receives the button text
;                  TextMax    - Size of the buffer at Text. If the button information is being set, this member is ignored
;                  ImageLabel - Provides the ability to replace the text label of an item with an image
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagTBBUTTONINFO = "int Size;int Mask;int Command;int Image;byte State;byte Style;short CX;int Param;ptr Text;int TextMax"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagTBINSERTMARK
; Description ...: Contains information on the insertion mark in a toolbar control
; Fields ........: Button - Zero based index of the insertion mark. If this member is -1, there is no insertion mark
;                  Flags  - Defines where the insertion mark is in relation to Button. This can be one of the following values:
;                  |0                   - The insertion mark is to the left of the specified button
;                  |$TBIMHT_AFTER       - The insertion mark is to the right of the specified button
;                  |$TBIMHT_BACKGROUND  - The insertion mark is on the background of the toolbar.  This flag is  only  used  with
;                  +the $TB_INSERTMARKHITTEST message.
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagTBINSERTMARK = "int Button;int Flags"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagTBMETRICS
; Description ...: Defines the metrics of a toolbar that are used to shrink or expand toolbar items
; Fields ........: Size     - Size of this structure, in bytes
;                  Mask     - Mask that determines the metric to retrieve. It can be any combination of the following:
;                  |$TBMF_PAD           - Retrieve the XPad and YPad values
;                  |$TBMF_BARPAD        - Retrieve the XBarPad and YBarPad values
;                  |$TBMF_BUTTONSPACING - Retrieve the XSpacing and YSpacing values
;                  XPad     - Width of the padding inside the toolbar buttons
;                  YPad     - Height of the padding inside the toolbar buttons
;                  XBarPad  - Width of the toolbar. Not used.
;                  YBarPad  - Height of the toolbar. Not used.
;                  XSpacing - Width of the space between toolbar buttons
;                  YSpacing - Height of the space between toolbar buttons
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagTBMETRICS = "int Size;int Mask;int XPad;int YPad;int XBarPad;int YBarPad;int XSpacing;int YSpacing"

; ===============================================================================================================================
; *******************************************************************************************************************************
; Windows Networking Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagCONNECTDLGSTRUCT
; Description ...: tagCONNECTDLGSTRUCT structure
; Fields ........: Size     - Size of this structure, in bytes
;                  hWnd     - Handle to the owner window for the dialog box
;                  Resource - Pointer to a tagNETRESOURCE structure.  If the lemoteName member of  tagNETRESOURCE  is  specified,
;                  +it will be entered into the path field of the dialog box.  With the exception of the Type member,  all  other
;                  +members of the tagNETRESOURCE structure must be set to 0.
;                  Flags    - Set of flags describing options for the dialog box display:
;                  |$SidTypeUser         - The account is a user account
;                  |$CONNDLG_RO_PATH     - Display a read-only path instead of allowing the user to type in a path
;                  |$CONNDLG_CONN_POINT  - Internal flag. Do not use.
;                  |$CONNDLG_USE_MRU     - Enter the most recently used paths into the combination box
;                  |$CONNDLG_HIDE_BOX    - Show the check box allowing the user to restore the connection at logon
;                  |$CONNDLG_PERSIST     - Restore the connection at logon
;                  |$CONNDLG_NOT_PERSIST - Do not restore the connection at logon
;                  DevNum   - If the call to the _WNet_ConnectionDialog1 function is successful, this member returns  the  number
;                  +of the connected device. The value is 1 for A:, 2 for B:, 3 for C:, and so on.  If the user made a deviceless
;                  +connection, the value is –1.
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagCONNECTDLGSTRUCT = "int Size;hwnd hWnd;ptr Resource;int Flags;int DevNum"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagDISCDLGSTRUCT
; Description ...: tagDISCDLGSTRUCT structure
; Fields ........: Size       - Size of this structure, in bytes
;                  hWnd       - Handle to the owner window for the dialog box
;                  LocalName  - Pointer to a null-terminated string that specifies the local device name that  is  redirected  to
;                  +the network resource, such as "F:" or "LPT1".
;                  RemoteName - Pointer to a null-terminated string that specifies the name of the resource to  disconnect.  This
;                  +member can be 0 if the LocalName member is specified.  When LocalName is specified,  the  connection  to  the
;                  +network resource redirected from LocalName is disconnected.
;                  Flags      - Set of bit flags describing the connection:
;                  |$DISC_UPDATE_PROFILE - If this value is set, the specified connection is no longer  a  persistent  one.  This
;                  +flag is valid only if the LocalName member specifies a local device.
;                  |$DISC_NO_FORCE       - If this value is not set, the system applies force when attempting to disconnect  from
;                  +the network resource. This situation typically occurs when the user has files open over the connection.  This
;                  +value means that the user will be informed if there are open files on the connection, and asked if he or  she
;                  +still wants to disconnect. If the user wants to proceed, the disconnect procedure re-attempts with additional
;                  +force.
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagDISCDLGSTRUCT = "int Size;hwnd hWnd;ptr LocalName;ptr RemoteName;int Flags"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagNETCONNECTINFOSTRUCT
; Description ...: tagNETCONNECTINFOSTRUCT structure
; Fields ........: Size        - Size of this structure, in bytes
;                  Flags       - Set of bit flags describing the connection:
;                  |$WNCON_FORNETCARD  - In the absence of information about the  actual  connection,  the  information  returned
;                  +applies to the performance of the network card.  If this flag is not set, information is being  returned  for
;                  +the current connection with the resource, with any routing degradation taken into consideration.
;                  |$WNCON_NOTROUTED  - The connection is not being routed.  If this flag is not set, the connection may be going
;                  +through routers that limit performance.  Consequently, if WNCON_FORNETCARD is set, actual performance may  be
;                  +much less than the information returned.
;                  |$WNCON_SLOWLINK   - The connection is over a medium that is typically slow.  You should not set this  bit  if
;                  +the Speed member is set to a nonzero value.
;                  |$WNCON_DYNAMIC    - Some of the information returned is calculated dynamically, so reissuing this request may
;                  +return different (and more current) information.
;                  Speed       - Speed of the media to the network resource, in 100 bits-per-second
;                  Delay       - One-way delay time that the network introduces when sending information, in milliseconds
;                  OptDataSize - Size of data that an application should use when making a single request to the network resource
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNETCONNECTINFOSTRUCT = "int Size;int Flags;int Speed;int Delay;int OptDataSize"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagNETINFOSTRUCT
; Description ...: tagNETINFOSTRUCT structure
; Fields ........: Size     - Size of this structure, in bytes
;                  Version  - Version number of the network provider software
;                  Status   - Current status of the network provider software:
;                  |$NO_ERROR         - The network is running
;                  |$ERROR_NO_NETWORK - The network is unavailable
;                  |$ERROR_BUSY       - The network is currently unavailable, but it should become available shortly
;                  Char     - Characteristics of the network provider software. This value is zero.
;                  Handle   - Instance handle for the network provider or for the 16-bit Windows network driver
;                  NetType  - Network type unique to the running network
;                  Printers - Set of bit flags indicating the valid print numbers for redirecting local printer devices, with the
;                  +low order bit corresponding to LPT1.
;                  Drives   - Set of bit flags indicating the valid local disk devices for redirecting disk drives, with the  low
;                  +order bit corresponding to A:.
;                  Reserved - Reserved, must be 0
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNETINFOSTRUCT = "int Size;int Version;int Status;int Char;int Handle;short NetType;int Printers;int Drives;short Reserved"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagNETRESOURCE
; Description ...: tagNETRESOURCE structure
; Fields ........: Scope       - Scope of the enumeration:
;                  |$RESOURCE_CONNECTED  - Enumerate currently connected resources
;                  |$RESOURCE_GLOBALNET  - Enumerate all resources on the network
;                  |$RESOURCE_REMEMBERED - Enumerate remembered connections
;                  Type        - Set of bit flags identifying the type of resource:
;                  |$RESOURCETYPE_ANY   - All resources
;                  |$RESOURCETYPE_DISK  - Disk resources
;                  |$RESOURCETYPE_PRINT - Print resources
;                  DisplayType - Display options for the network object in a network browsing user interface:
;                  |$RESOURCEDISPLAYTYPE_DOMAIN  - The object should be displayed as a domain
;                  |$RESOURCEDISPLAYTYPE_SERVER  - The object should be displayed as a server
;                  |$RESOURCEDISPLAYTYPE_SHARE   - The object should be displayed as a share
;                  |$RESOURCEDISPLAYTYPE_GENERIC - The method used to display the object does not matter
;                  Usage       - Set of bit flags describing how the resource can be used. Note that this member can be specified
;                  +only if the Scope member is equal to $RESOURCE_GLOBALNET. This member can be one of the following values:
;                  |$RESOURCEUSAGE_CONNECTABLE - The resource is a connectable resource; the name pointed to by RemoteName can be
;                  +passed to the _WNet_AddConnection function to make a network connection.
;                  |$RESOURCEUSAGE_CONTAINER   - The resource is a container resource; the name pointed to by RemoteName  can  be
;                  +passed to the WNet_OpenEnum function to enumerate the resources in the container.
;                  LocalName   - If the Scope member is equal to $RESOURCE_CONNECTED or $RESOURCE_REMEMBERED, this  member  is  a
;                  +pointer to a null terminated character string that specifies the name of a local device.  This member is 0 if
;                  +the connection does not use a device.
;                  RemoteName  - If the entry is a network resource, this member is a pointer to a null  terminated  string  that
;                  +specifies the remote network name. If the entry is a current or persistent connection, RemoteName  points  to
;                  +the network name associated with the name pointed to by the LocalName member.
;                  Comment     - Pointer to a null-terminated string that contains a comment supplied by the network provider
;                  Provider    - Pointer to a null-terminated string that contains  the  name  of  the  provider  that  owns  the
;                  +resource. This member can be NULL if the provider name is unknown.  To retrieve the provider  name,  you  can
;                  +call the _WNet_GetProviderName function.
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagNETRESOURCE = "int Scope;int Type;int DisplayType;int Usage;ptr LocalName;ptr RemoteName;ptr Comment;ptr Provider"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagREMOTENAMEINFO
; Description ...: tagREMOTENAMEINFO structure
; Fields ........: Universal  - Pointer to the null-terminated UNC name string that identifies a network resource
;                  Connection - Pointer to a null-terminated string that is the name of a network connection
;                  Remaining  - Pointer to a null-terminated name string
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagREMOTENAMEINFO = "ptr Universal;ptr Connection;ptr Remaining"

; ===============================================================================================================================
; *******************************************************************************************************************************
; Odds and Ends Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; ===============================================================================================================================
; #STRUCTURE# ===================================================================================================================
; Name...........: $tagOVERLAPPED
; Description ...: Contains information used in asynchronous (or overlapped) input and output (I/O).
; Fields ........: Internal     - Reserved for operating system use.  This member, which specifies a system-dependent status,  is
;                  +valid when the GetOverlappedResult function  returns  without  setting  the  extended  error  information  to
;                  +ERROR_IO_PENDING.
;                  InternalHigh - Reserved for operating system use.  This  member,  which  specifies  the  length  of  the  data
;                  +transferred, is valid when the GetOverlappedResult function returns True.
;                  Offset       - File position at which to start the transfer. The file position is a byte offset from the start
;                  +of the file. The calling process must set this member before calling the ReadFile or WriteFile function. This
;                  +member is used only when the device is a file. Otherwise, this member must be zero.
;                  OffsetHigh   - High-order word of the file position at which to start the transfer.  This member is used  only
;                  +when the device is a file. Otherwise, this member must be zero.
;                  hEvent       - Handle to an event that will be set to the signaled state when the operation has completed. The
;                  +calling process must set this member either to zero or a valid event handle  before  calling  any  overlapped
;                  +functions.
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagOVERLAPPED = "int Internal;int InternalHigh;int Offset;int OffsetHigh;int hEvent"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagOPENFILENAME
; Description ...: Contains information information that the GetOpenFileName and GetSaveFileName functions use to initialize an Open or Save As dialog box
; Fields ........: StructSize - Specifies the length, in bytes, of the structure.
;                  hwndOwner  - Handle to the window that owns the dialog box. This member can be any valid window handle, or it can be NULL if the dialog box has no owner.
;                  hInstance  - If the $OFN_ENABLETEMPLATEHANDLE flag is set in the Flags member, hInstance is a handle to a memory object containing a dialog box template.
;                  |If the $OFN_ENABLETEMPLATE flag is set, hInstance is a handle to a module that contains a dialog box template named by the lpTemplateName member.
;                  |If neither flag is set, this member is ignored.
;                  |If the $OFN_EXPLORER flag is set, the system uses the specified template to create a dialog box that is a child of the default Explorer-style dialog box.
;                  |If the $OFN_EXPLORER flag is not set, the system uses the template to create an old-style dialog box that replaces the default dialog box.
;                  lpstrFilter - Pointer to a buffer containing pairs of null-terminated filter strings. The last string in the buffer must be terminated by two NULL characters.
;                  lpstrCustomFilter - Pointer to a static buffer that contains a pair of null-terminated filter strings for preserving the filter pattern chosen by the user.
;                  |The first string is your display string that describes the custom filter, and the second string is the filter pattern selected by the user.
;                  |The first time your application creates the dialog box, you specify the first string, which can be any nonempty string.
;                  |When the user selects a file, the dialog box copies the current filter pattern to the second string.
;                  |The preserved filter pattern can be one of the patterns specified in the lpstrFilter buffer, or it can be a filter pattern typed by the user.
;                  |The system uses the strings to initialize the user-defined file filter the next time the dialog box is created.
;                  |If the nFilterIndex member is zero, the dialog box uses the custom filter.
;                  |If this member is NULL, the dialog box does not preserve user-defined filter patterns.
;                  |If this member is not NULL, the value of the nMaxCustFilter member must specify the size, in TCHARs, of the lpstrCustomFilter buffer.
;                  |For the ANSI version, this is the number of bytes; for the Unicode version, this is the number of characters.
;                  nMaxCustFilter - Specifies the size, in TCHARs, of the buffer identified by lpstrCustomFilter.
;                  |For the ANSI version, this is the number of bytes; for the Unicode version, this is the number of characters.
;                  |This buffer should be at least 40 characters long. This member is ignored if lpstrCustomFilter is NULL or points to a NULL string.
;                  nFilterIndex - Specifies the index of the currently selected filter in the File Types control.
;                  |The buffer pointed to by lpstrFilter contains pairs of strings that define the filters.
;                  |The first pair of strings has an index value of 1, the second pair 2, and so on.
;                  |An index of zero indicates the custom filter specified by lpstrCustomFilter.
;                  |You can specify an index on input to indicate the initial filter description and filter pattern for the dialog box.
;                  |When the user selects a file, nFilterIndex returns the index of the currently displayed filter.
;                  |If nFilterIndex is zero and lpstrCustomFilter is NULL, the system uses the first filter in the lpstrFilter buffer.
;                  |If all three members are zero or NULL, the system does not use any filters and does not show any files in the file list control of the dialog box.
;                  lpstrFile - Pointer to a buffer that contains a file name used to initialize the File Name edit control.
;                  |The first character of this buffer must be NULL if initialization is not necessary.
;                  |When the _WinAPI_GetOpenFileName or _WinAPI_GetSaveFileName function returns successfully, this buffer contains the drive designator, path, file name, and extension of the selected file.
;                  |If the $OFN_ALLOWMULTISELECT flag is set and the user selects multiple files, the buffer contains the current directory followed by the file names of the selected files.
;                  |For Explorer-style dialog boxes, the directory and file name strings are NULL separated, with an extra NULL character after the last file name.
;                  |For old-style dialog boxes, the strings are space separated and the function uses short file names for file names with spaces.
;                  |You can use the FindFirstFile function to convert between long and short file names.
;                  |If the user selects only one file, the lpstrFile string does not have a separator between the path and file name.
;                  |If the buffer is too small, the function returns FALSE and the _WinAPI_CommDlgExtendedError function returns $FNERR_BUFFERTOOSMALL.
;                  |In this case, the first two bytes of the lpstrFile buffer contain the required size, in bytes or characters.
;                  nMaxFile - Specifies the size, in TCHARs, of the buffer pointed to by lpstrFile.
;                  |For the ANSI version, this is the number of bytes; for the Unicode version, this is the number of characters.
;                  |The buffer must be large enough to store the path and file name string or strings, including the terminating NULL character.
;                  |The _WinAPI_GetOpenFileName and _WinAPI_GetSaveFileName functions return FALSE if the buffer is too small to contain the file information.
;                  |The buffer should be at least 256 characters long.
;                  lpstrFileTitle - Pointer to a buffer that receives the file name and extension (without path information) of the selected file. This member can be NULL.
;                  nMaxFileTitle - Specifies the size, in TCHARs, of the buffer pointed to by lpstrFileTitle.
;                  |For the ANSI version, this is the number of bytes; for the Unicode version, this is the number of characters. This member is ignored if lpstrFileTitle is NULL.
;                  lpstrInitialDir - Pointer to a NULL terminated string that can specify the initial directory.
;                  lpstrTitle - Pointer to a string to be placed in the title bar of the dialog box. If this member is NULL, the system uses the default title (that is, Save As or Open).
;                  Flags - A set of bit flags you can use to initialize the dialog box. When the dialog box returns, it sets these flags to indicate the user's input. This member can be a combination of the following flags.
;                  |  $OFN_ALLOWMULTISELECT - Specifies that the File Name list box allows multiple selections.
;                  |    If you also set the $OFN_EXPLORER flag, the dialog box uses the Explorer-style user interface; otherwise, it uses the old-style user interface.
;                  |  $OFN_CREATEPROMPT - If the user specifies a file that does not exist, this flag causes the dialog box to prompt the user for permission to create the file.
;                  |    If the user chooses to create the file, the dialog box closes and the function returns the specified name; otherwise, the dialog box remains open.
;                  |    If you use this flag with the $OFN_ALLOWMULTISELECT flag, the dialog box allows the user to specify only one nonexistent file.
;                  |  $OFN_DONTADDTORECENT - Windows 2000/XP: Prevents the system from adding a link to the selected file in the file system directory that contains the user's most recently used documents.
;                  |  $OFN_ENABLEHOOK - Enables the hook function specified in the lpfnHook member.
;                  |  $OFN_ENABLEINCLUDENOTIFY - Windows 2000/XP: Causes the dialog box to send CDN_INCLUDEITEM notification messages to your OFNHookProc hook procedure when the user opens a folder.
;                  |    The dialog box sends a notification for each item in the newly opened folder.
;                  |    These messages enable you to control which items the dialog box displays in the folder's item list.
;                  |  $OFN_ENABLESIZING - Windows 2000/XP, Windows 98/Me: Enables the Explorer-style dialog box to be resized using either the mouse or the keyboard.
;                  |    By default, the Explorer-style Open and Save As dialog boxes allow the dialog box to be resized regardless of whether this flag is set.
;                  |    This flag is necessary only if you provide a hook procedure or custom template. The old-style dialog box does not permit resizing.
;                  |  $OFN_ENABLETEMPLATE - Indicates that the lpTemplateName member is a pointer to the name of a dialog template resource in the module identified by the hInstance member.
;                  |    If the $OFN_EXPLORER flag is set, the system uses the specified template to create a dialog box that is a child of the default Explorer-style dialog box.
;                  |    If the $OFN_EXPLORER flag is not set, the system uses the template to create an old-style dialog box that replaces the default dialog box.
;                  |  $OFN_ENABLETEMPLATEHANDLE - Indicates that the hInstance member identifies a data block that contains a preloaded dialog box template.
;                  |    The system ignores lpTemplateName if this flag is specified.
;                  |    If the $OFN_EXPLORER flag is set, the system uses the specified template to create a dialog box that is a child of the default Explorer-style dialog box.
;                  |    If the $OFN_EXPLORER flag is not set, the system uses the template to create an old-style dialog box that replaces the default dialog box.
;                  |  $OFN_EXPLORER - Indicates that any customizations made to the Open or Save As dialog box use the new Explorer-style customization methods.
;                  |    By default, the Open and Save As dialog boxes use the Explorer-style user interface regardless of whether this flag is set.
;                  |    This flag is necessary only if you provide a hook procedure or custom template, or set the $OFN_ALLOWMULTISELECT flag.
;                  |    If you want the old-style user interface, omit the $OFN_EXPLORER flag and provide a replacement old-style template or hook procedure.
;                  |    If you want the old style but do not need a custom template or hook procedure, simply provide a hook procedure that always returns FALSE.
;                  |  $OFN_EXTENSIONDIFFERENT - Specifies that the user typed a file name extension that differs from the extension specified by lpstrDefExt.
;                  |    The function does not use this flag if lpstrDefExt is NULL.
;                  |  $OFN_FILEMUSTEXIST - Specifies that the user can type only names of existing files in the File Name entry field.
;                  |    If this flag is specified and the user enters an invalid name, the dialog box procedure displays a warning in a message box.
;                  |    If this flag is specified, the $OFN_PATHMUSTEXIST flag is also used. This flag can be used in an Open dialog box. It cannot be used with a Save As dialog box.
;                  |  $OFN_FORCESHOWHIDDEN - Windows 2000/XP: Forces the showing of system and hidden files, thus overriding the user setting to show or not show hidden files.
;                  |    However, a file that is marked both system and hidden is not shown.
;                  |  $OFN_HIDEREADONLY - Hides the Read Only check box.
;                  |  $OFN_LONGNAMES - For old-style dialog boxes, this flag causes the dialog box to use long file names.
;                  |    If this flag is not specified, or if the $OFN_ALLOWMULTISELECT flag is also set, old-style dialog boxes use short file names (8.3 format) for file names with spaces.
;                  |    Explorer-style dialog boxes ignore this flag and always display long file names.
;                  |  $OFN_NOCHANGEDIR - Restores the current directory to its original value if the user changed the directory while searching for files.
;                  |    Windows NT 4.0/2000/XP: This flag is ineffective for GetOpenFileName.
;                  |  $OFN_NODEREFERENCELINKS - Directs the dialog box to return the path and file name of the selected shortcut (.LNK) file.
;                  |    If this value is not specified, the dialog box returns the path and file name of the file referenced by the shortcut.
;                  |  $OFN_NOLONGNAMES - For old-style dialog boxes, this flag causes the dialog box to use short file names (8.3 format).
;                  |    Explorer-style dialog boxes ignore this flag and always display long file names.
;                  |  $OFN_NONETWORKBUTTON - Hides and disables the Network button.
;                  |  $OFN_NOREADONLYRETURN - Specifies that the returned file does not have the Read Only check box selected and is not in a write-protected directory.
;                  |  $OFN_NOTESTFILECREATE - Specifies that the file is not created before the dialog box is closed.
;                  |    This flag should be specified if the application saves the file on a create-nonmodify network share.
;                  |    When an application specifies this flag, the library does not check for write protection, a full disk, an open drive door, or network protection.
;                  |    Applications using this flag must perform file operations carefully, because a file cannot be reopened once it is closed.
;                  |  $OFN_NOVALIDATE - Specifies that the common dialog boxes allow invalid characters in the returned file name.
;                  |    Typically, the calling application uses a hook procedure that checks the file name by using the FILEOKSTRING message.
;                  |    If the text box in the edit control is empty or contains nothing but spaces, the lists of files and directories are updated.
;                  |    If the text box in the edit control contains anything else, nFileOffset and nFileExtension are set to values generated by parsing the text.
;                  |    No default extension is added to the text, nor is text copied to the buffer specified by lpstrFileTitle.
;                  |    If the value specified by nFileOffset is less than zero, the file name is invalid.
;                  |    Otherwise, the file name is valid, and nFileExtension and nFileOffset can be used as if the $OFN_NOVALIDATE flag had not been specified.
;                  |  $OFN_OVERWRITEPROMPT - Causes the Save As dialog box to generate a message box if the selected file already exists.
;                  |    The user must confirm whether to overwrite the file.
;                  |  $OFN_PATHMUSTEXIST - Specifies that the user can type only valid paths and file names.
;                  |    If this flag is used and the user types an invalid path and file name in the File Name entry field, the dialog box function displays a warning in a message box.
;                  |  $OFN_READONLY - Causes the Read Only check box to be selected initially when the dialog box is created.
;                  |    This flag indicates the state of the Read Only check box when the dialog box is closed.
;                  |  $OFN_SHAREAWARE - Specifies that if a call to the OpenFile function fails because of a network sharing violation, the error is ignored and the dialog box returns the selected file name.
;                  |    If this flag is not set, the dialog box notifies your hook procedure when a network sharing violation occurs for the file name specified by the user.
;                  |    If you set the $OFN_EXPLORER flag, the dialog box sends the CDN_SHAREVIOLATION message to the hook procedure.
;                  |    If you do not set $OFN_EXPLORER, the dialog box sends the SHAREVISTRING registered message to the hook procedure.
;                  |  $OFN_SHOWHELP - Causes the dialog box to display the Help button.
;                  |    The hwndOwner member must specify the window to receive the HELPMSGSTRING registered messages that the dialog box sends when the user clicks the Help button.
;                  |    An Explorer-style dialog box sends a CDN_HELP notification message to your hook procedure when the user clicks the Help button.
;                  |  $OFN_USESHELLITEM - Do not use.
;                  nFileOffset - Specifies the zero-based offset, in TCHARs, from the beginning of the path to the file name in the string pointed to by lpstrFile.
;                  |For the ANSI version, this is the number of bytes; for the Unicode version, this is the number of characters.
;                  nFileExtension - Specifies the zero-based offset, in TCHARs, from the beginning of the path to the file name extension in the string pointed to by lpstrFile.
;                  |For the ANSI version, this is the number of bytes; for the Unicode version, this is the number of characters.
;                  lpstrDefExt - Pointer to a buffer that contains the default extension.
;                  lCustData - Specifies application-defined data that the system passes to the hook procedure identified by the lpfnHook member.
;                  lpfnHook - Pointer to a hook procedure. This member is ignored unless the Flags member includes the $OFN_ENABLEHOOK flag.
;                  lpTemplateName - Pointer to a null-terminated string that names a dialog template resource in the module identified by the hInstance member.
;                  pvReserved - Reserved. Must be set to NULL.
;                  dwReserved - Reserved. Must be set to 0.
;                  FlagsEx - Windows 2000/XP: A set of bit flags you can use to initialize the dialog box. Currently, this member can be zero or the following flag.
;                  |  $OFN_EX_NOPLACESBAR - If this flag is set, the places bar is not displayed.
;                  |    If this flag is not set, Explorer-style dialog boxes include a places bar containing icons for commonly-used folders, such as Favorites and Desktop.
; Author ........: Gary Frost
; Remarks .......:
; ===============================================================================================================================
Global Const $tagOPENFILENAME = "dword StructSize;hwnd hwndOwner;hwnd hInstance;ptr lpstrFilter;ptr lpstrCustomFilter;" & _
		"dword nMaxCustFilter;dword nFilterIndex;ptr lpstrFile;dword nMaxFile;ptr lpstrFileTitle;int nMaxFileTitle;" & _
		"ptr lpstrInitialDir;ptr lpstrTitle;dword Flags;short nFileOffset;short nFileExtension;ptr lpstrDefExt;ptr lCustData;" & _
		"ptr lpfnHook;ptr lpTemplateName;ptr pvReserved;dword dwReserved;dword FlagsEx"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagBITMAPINFO
; Description ...: This structure defines the dimensions and color information of a Windows-based device-independent bitmap (DIB).
; Fields ........: Size          - The number of bytes required by the structure, minus the size of the RGBQuad data
;                  Width         - Specifies the width of the bitmap, in pixels
;                  Height        - Specifies the height of the bitmap, in pixels
;                  Planes        - Specifies the number of planes for the target device. This must be set to 1
;                  BitCount      - Specifies the number of bits-per-pixel
;                  Compression   - Specifies the type of compression for a compressed bottom-up bitmap
;                  SizeImage     - Specifies the size, in bytes, of the image
;                  XPelsPerMeter - Specifies the horizontal resolution, in pixels-per-meter, of the target device for the bitmap
;                  YPelsPerMeter - Specifies the vertical resolution, in pixels-per-meter, of the target device for the bitmap
;                  ClrUsed       - Specifies the number of color indexes in the color table that are actually used by the bitmap
;                  ClrImportant  - Specifies the number of color indexes that are required for displaying the bitmap
;                  RGBQuad       - An array of tagRGBQUAD structures. The elements of the array that make up the color table.
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagBITMAPINFO = "dword Size;long Width;long Height;ushort Planes;ushort BitCount;dword Compression;dword SizeImage;" & _
		"long XPelsPerMeter;long YPelsPerMeter;dword ClrUsed;dword ClrImportant;dword RGBQuad"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagBLENDFUNCTION
; Description ...: $tagBLENDFUNCTION structure controls blending by specifying the blending functions for source and destination bitmaps
; Fields ........: Op     - Specifies the source blend operation:
;                  Flags  - Must be zero
;                  Alpha  - Specifies an alpha transparency value to be used on the entire source bitmap.  This value is combined
;                  +with any per-pixel alpha values in the source bitmap.  If set  to  0,  it  is  assumed  that  your  image  is
;                  +transparent. Set to 255 (opaque) when you only want to use per-pixel alpha values.
;                  Format - This member controls the way the source and destination bitmaps are interpreted:
;                  |$AC_SRC_ALPHA - This flag is set when the bitmap has an Alpha channel (that is, per-pixel alpha).  Note  that
;                  +the APIs use premultiplied alpha, which means that the red, green and blue channel values in the bitmap  must
;                  +be premultiplied with the alpha channel value.
; Author ........: Paul Campbell (PaulIA)
; Remarks .......: The source bitmap used with $tagBLENDFUNCTION must be 32 bpp
; ===============================================================================================================================
Global Const $tagBLENDFUNCTION = "byte Op;byte Flags;byte Alpha;byte Format"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagBORDERS
; Description ...: Structure that recieves the current widths of the horizontal and vertical borders of a status window
; Fields ........: BX - Width of the horizontal border
;                  BY - Width of the vertical border
;                  RX - Width of the border between rectangles
; Author ........: Gary Frost (gafrost)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagBORDERS = "int BX;int BY;int RX"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagCHOOSECOLOR
; Description ...: Contains information the _ChooseColor function uses to initialize the Color dialog box
; Fields ........: Size           - Specifies the size, in bytes, of the structure
;                  hWndOwner      - Handle to the window that owns the dialog box
;                  hInstance      - If the $CC_ENABLETEMPLATEHANDLE flag is set in the Flags member, hInstance is a handle to a memory
;                  +object containing a dialog box template. If the $CC_ENABLETEMPLATE flag is set, hInstance is a handle to a module
;                  +that contains a dialog box template named by the lpTemplateName member. If neither $CC_ENABLETEMPLATEHANDLE
;                  +nor $CC_ENABLETEMPLATE is set, this member is ignored.
;                  rgbResult      - If the $CC_RGBINIT flag is set, rgbResult specifies the color initially selected when the dialog
;                  +box is created.
;                  CustColors     - Pointer to an array of 16 values that contain red, green, blue (RGB) values for the custom color
;                  +boxes in the dialog box.
;                  Flags          - A set of bit flags that you can use to initialize the Color dialog box. When the dialog box returns,
;                  +it sets these flags to indicate the user's input. This member can be a combination of the following flags:
;                  |$CC_ANYCOLOR             - Causes the dialog box to display all available colors in the set of basic colors
;                  |$CC_ENABLEHOOK           - Enables the hook procedure specified in the lpfnHook member
;                  |$CC_ENABLETEMPLATE       - Indicates that the hInstance and lpTemplateName members specify a dialog box template
;                  |$CC_ENABLETEMPLATEHANDLE - Indicates that the hInstance member identifies a data block that contains a preloaded
;                  +dialog box template
;                  |$CC_FULLOPEN             - Causes the dialog box to display the additional controls that allow the user to create
;                  +custom colors
;                  |$CC_PREVENTFULLOPEN      - Disables the Define Custom Color
;                  |$CC_RGBINIT              - Causes the dialog box to use the color specified in the rgbResult member as the initial
;                  +color selection
;                  |$CC_SHOWHELP             - Causes the dialog box to display the Help button
;                  |$CC_SOLIDCOLOR           - Causes the dialog box to display only solid colors in the set of basic colors
;                  lCustData      - Specifies application-defined data that the system passes to the hook procedure identified by the
;                  +lpfnHook member
;                  lpfnHook       - Pointer to a CCHookProc hook procedure that can process messages intended for the dialog box.
;                  +This member is ignored unless the CC_ENABLEHOOK flag is set in the Flags member
;                  lpTemplateName - Pointer to a null-terminated string that names the dialog box template resource in the module
;                  +identified by the hInstance m
; Author ........: Gary Frost (gafrost)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagCHOOSECOLOR = "dword Size;hwnd hWndOwnder;hwnd hInstance;int rgbResult;int_ptr CustColors;dword Flags;int_ptr lCustData;" & _
		"ptr lpfnHook;ptr lpTemplateName"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagCHOOSEFONT
; Description ...: Contains information that the _ChooseFont function uses to initialize the Font dialog box
; Fields ........: Size           - Specifies the size, in bytes, of the structure
;                  hWndOwner      - Handle to the window that owns the dialog box
;                  hDC            - Handle to the device context
;                  LogFont        - Pointer to a structure
;                  PointSize      - Specifies the size of the selected font, in units of 1/10 of a point
;                  Flags   - A set of bit flags that you can use to initialize the Font dialog box.
;                  +This parameter can be one of the following values:
;                  |$CF_APPLY          - Causes the dialog box to display the Apply button
;                  |$CF_ANSIONLY       - This flag is obsolete
;                  |$CF_TTONLY         - Specifies that ChooseFont should only enumerate and allow the selection of TrueType fonts
;                  |$CF_EFFECTS        - Causes the dialog box to display the controls that allow the user to specify strikeout,
;                  +underline, and text color options
;                  |$CF_ENABLEHOOK     - Enables the hook procedure specified in the lpfnHook member of this structure
;                  |$CF_ENABLETEMPLATE - Indicates that the hInstance and lpTemplateName members specify a dialog box template to use
;                  +in place of the default template
;                  |$CF_ENABLETEMPLATEHANDLE - Indicates that the hInstance member identifies a data block that contains a preloaded
;                  +dialog box template
;                  |$CF_FIXEDPITCHONLY - Specifies that ChooseFont should select only fixed-pitch fonts
;                  |$CF_FORCEFONTEXIST - Specifies that ChooseFont should indicate an error condition if the user attempts to select
;                  +a font or style that does not exist.
;                  |$CF_INITTOLOGFONTSTRUCT - Specifies that ChooseFont should use the structure pointed to by the lpLogFont member
;                  +to initialize the dialog box controls.
;                  |$CF_LIMITSIZE - Specifies that ChooseFont should select only font sizes within the range specified by the nSizeMin and nSizeMax members.
;                  |$CF_NOOEMFONTS - Same as the $CF_NOVECTORFONTS flag.
;                  |$CF_NOFACESEL - When using a LOGFONT structure to initialize the dialog box controls, use this flag to selectively prevent the dialog box
;                  +from displaying an initial selection for the font name combo box.
;                  |$CF_NOSCRIPTSEL - Disables the Script combo box.
;                  |$CF_NOSTYLESEL - When using a LOGFONT structure to initialize the dialog box controls, use this flag to selectively prevent the dialog box
;                  +from displaying an initial selection for the font style combo box.
;                  |$CF_NOSIZESEL - When using a structure to initialize the dialog box controls, use this flag to selectively prevent the dialog box from
;                  +displaying an initial selection for the font size combo box.
;                  |$CF_NOSIMULATIONS - Specifies that ChooseFont should not allow graphics device interface (GDI) font simulations.
;                  |$CF_NOVECTORFONTS - Specifies that ChooseFont should not allow vector font selections.
;                  |$CF_NOVERTFONTS - Causes the Font dialog box to list only horizontally oriented fonts.
;                  |$CF_PRINTERFONTS - Causes the dialog box to list only the fonts supported by the printer associated with the device context
;                  +(or information context) identified by the hDC member.
;                  |$CF_SCALABLEONLY - Specifies that ChooseFont should allow only the selection of scalable fonts.
;                  |$CF_SCREENFONTS - Causes the dialog box to list only the screen fonts supported by the system.
;                  |$CF_SCRIPTSONLY - Specifies that ChooseFont should allow selection of fonts for all non-OEM and Symbol character sets, as well as
;                  +the ANSI character set. This supersedes the $CF_ANSIONLY value.
;                  |$CF_SELECTSCRIPT - When specified on input, only fonts with the character set identified in the lfCharSet member of the LOGFONT
;                  +structure are displayed.
;                  |$CF_SHOWHELP - Causes the dialog box to display the Help button. The hwndOwner member must specify the window to receive the HELPMSGSTRING
;                  +registered messages that the dialog box sends when the user clicks the Help button.
;                  |$CF_USESTYLE - Specifies that the lpszStyle member is a pointer to a buffer that contains style data that ChooseFont should use to initialize
;                  +the Font Style combo box. When the user closes the dialog box, ChooseFont copies style data for the user's selection to this buffer.
;                  |$CF_WYSIWYG - Specifies that ChooseFont should allow only the selection of fonts available on both the printer and the display
;                  rgbColors - If the CF_EFFECTS flag is set, rgbColors specifies the initial text color
;                  CustData - Specifies application-defined data that the system passes to the hook procedure identified by the lpfnHook member
;                  fnHook - Pointer to a CFHookProc hook procedure that can process messages intended for the dialog box
;                  TemplateName - Pointer to a null-terminated string that names the dialog box template resource in the module
;                  +identified by the hInstance member
;                  hInstance - If the $CF_ENABLETEMPLATEHANDLE flag is set in the Flags member, hInstance is a handle to a memory
;                  +object containing a dialog box template. If the $CF_ENABLETEMPLATE flag is set, hInstance is a handle to a
;                  +module that contains a dialog box template named by the TemplateName member. If neither $CF_ENABLETEMPLATEHANDLE
;                  +nor $CF_ENABLETEMPLATE is set, this member is ignored.
;                  szStyle - Pointer to a buffer that contains style data
;                  FontType - Specifies the type of the selected font when ChooseFont returns. This member can be one or more of the following values.
;                  |$BOLD_FONTTYPE - The font weight is bold. This information is duplicated in the lfWeight member of the LOGFONT
;                  +structure and is equivalent to FW_BOLD.
;                  |$ITALIC_FONTTYPE - The italic font attribute is set. This information is duplicated in the lfItalic member of the LOGFONT structure.
;                  |$PRINTER_FONTTYPE - The font is a printer font.
;                  |$REGULAR_FONTTYPE - The font weight is normal. This information is duplicated in the lfWeight member of the LOGFONT structure and is
;                  +equivalent to FW_REGULAR.
;                  |$SCREEN_FONTTYPE - The font is a screen font.
;                  |$SIMULATED_FONTTYPE - The font is simulated by the graphics device interface (GDI).
;                  SizeMin - Specifies the minimum point size a user can select
;                  SizeMax - Specifies the maximum point size a user can select
; Author ........: Gary Frost (gafrost)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagCHOOSEFONT = "dword Size;hwnd hWndOwner;hwnd hDC;ptr LogFont;int PointSize;dword Flags;int rgbColors;int_ptr CustData;" & _
		"ptr fnHook;ptr TemplateName;hwnd hInstance;ptr szStyle;ushort FontType;int SizeMin;int SizeMax"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagTEXTMETRIC
; Description ...: Contains basic information about a physical font. All sizes are specified in logical units, that is, they depend on the current mapping mode of the display context.
; Fields ........: tmHeight - Specifies the height (ascent + descent) of characters.
;                  tmAscent - Specifies the ascent (units above the base line) of characters.
;                  tmDescent - Specifies the descent (units below the base line) of characters.
;                  tmInternalLeading - Specifies the amount of leading (space) inside the bounds set by the tmHeight member.
;                  |  Accent marks and other diacritical characters may occur in this area. The designer may set this member to zero.
;                  tmExternalLeading - Specifies the amount of extra leading (space) that the application adds between rows.
;                  |  Since this area is outside the font, it contains no marks and is not altered by text output calls in either OPAQUE or TRANSPARENT mode.
;                  |  The designer may set this member to zero.
;                  tmAveCharWidth - Specifies the average width of characters in the font (generally defined as the width of the letter x).
;                  |  This value does not include the overhang required for bold or italic characters.
;                  tmMaxCharWidth - Specifies the width of the widest character in the font.
;                  tmWeight - Specifies the weight of the font.
;                  tmOverhang - Specifies the extra width per string that may be added to some synthesized fonts.
;                  |  When synthesizing some attributes, such as bold or italic, graphics device interface (GDI) or a device may have to add width to a string on both a per-character and per-string basis.
;                  |  For example, GDI makes a string bold by expanding the spacing of each character and overstriking by an offset value
;                  |  it italicizes a font by shearing the string. In either case, there is an overhang past the basic string.
;                  |  For bold strings, the overhang is the distance by which the overstrike is offset. For italic strings, the overhang is the amount the top of the font is sheared past the bottom of the font.
;                  |  The tmOverhang member enables the application to determine how much of the character width returned by a GetTextExtentPoint32 function call on a single character is the actual character width and how much is the per-string extra width.
;                  |  The actual width is the extent minus the overhang.
;                  tmDigitizedAspectX - Specifies the horizontal aspect of the device for which the font was designed.
;                  tmDigitizedAspectY - Specifies the vertical aspect of the device for which the font was designed.
;                  |  The ratio of the tmDigitizedAspectX and tmDigitizedAspectY members is the aspect ratio of the device for which the font was designed.
;                  tmFirstChar - Specifies the value of the first character defined in the font.
;                  tmLastChar - Specifies the value of the last character defined in the font.
;                  tmDefaultChar - Specifies the value of the character to be substituted for characters not in the font.
;                  tmBreakChar - Specifies the value of the character that will be used to define word breaks for text justification.
;                  tmItalic - Specifies an italic font if it is nonzero.
;                  tmUnderlined - Specifies an underlined font if it is nonzero.
;                  tmStruckOut - Specifies a strikeout font if it is nonzero.
;                  tmPitchAndFamily - Specifies information about the pitch, the technology, and the family of a physical font.
;                  tmCharSet - Specifies the character set of the font. The character set can be one of the following values.
;                  |ANSI_CHARSET
;                  |BALTIC_CHARSET
;                  |CHINESEBIG5_CHARSET
;                  |DEFAULT_CHARSET
;                  |EASTEUROPE_CHARSET
;                  |GB2312_CHARSET
;                  |GREEK_CHARSET
;                  |HANGUL_CHARSET
;                  |MAC_CHARSET
;                  |OEM_CHARSET
;                  |RUSSIAN_CHARSET
;                  |SHIFTJIS_CHARSET
;                  |SYMBOL_CHARSET
;                  |TURKISH_CHARSET
;                  |VIETNAMESE_CHARSET
; Author ........: Gary Frost
; Remarks .......:
; ===============================================================================================================================
Global Const $tagTEXTMETRIC = "long tmHeight;long tmAscent;long tmDescent;long tmInternalLeading;long tmExternalLeading;" & _
		"long tmAveCharWidth;long tmMaxCharWidth;long tmWeight;long tmOverhang;long tmDigitizedAspectX;long tmDigitizedAspectY;" & _
		"char tmFirstChar;char tmLastChar;char tmDefaultChar;char tmBreakChar;byte tmItalic;byte tmUnderlined;byte tmStruckOut;" & _
		"byte tmPitchAndFamily;byte tmCharSet"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagCURSORINFO
; Description ...: Contains global cursor information
; Fields ........: Size    - Specifies the size, in bytes, of the structure
;                  Flags   - Specifies the cursor state. This parameter can be one of the following values:
;                  |0               - The cursor is hidden
;                  |$CURSOR_SHOWING - The cursor is showing
;                  hCursor - Handle to the cursor
;                  X       - X position of the cursor, in screen coordinates
;                  Y       - Y position of the cursor, in screen coordinates
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagCURSORINFO = "int Size;int Flags;hwnd hCursor;int X;int Y"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagDISPLAY_DEVICE
; Description ...: Receives information about the display device
; Fields ........: Size   - Specifies the size, in bytes, of the structure
;                  Name   - Either the adapter device or the monitor device
;                  String - Either a description of the display adapter or of the display monitor
;                  Flags  - Device state flags:
;                  |$DISPLAY_DEVICE_ATTACHED_TO_DESKTOP - The device is part of the desktop
;                  |$DISPLAY_DEVICE_MIRRORING_DRIVER    - Represents a pseudo device used to mirror drawing for remoting or other
;                  +purposes. An invisible pseudo monitor is associated with this device.
;                  |$DISPLAY_DEVICE_MODESPRUNED         - The device has more display modes than its output devices support
;                  |$DISPLAY_DEVICE_PRIMARY_DEVICE      - The primary desktop is on the device
;                  |$DISPLAY_DEVICE_REMOVABLE           - The device is removable; it cannot be the primary display
;                  |$DISPLAY_DEVICE_VGA_COMPATIBLE      - The device is VGA compatible.
;                  ID     - This is the Plug and Play identifier
;                  Key    - Reserved
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagDISPLAY_DEVICE = "int Size;char Name[32];char String[128];int Flags;char ID[128];char Key[128]"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagFLASHWINDOW
; Description ...: Contains the flash status for a window and the number of times the system should flash the window
; Fields ........: Size    - The size of the structure, in bytes
;                  hWnd    - A handle to the window to be flashed. The window can be either opened or minimized.
;                  Flags   - The flash status. This parameter can be one or more of the following values:
;                  |$FLASHW_ALL       - Flash both the window caption and taskbar button
;                  |$FLASHW_CAPTION   - Flash the window caption
;                  |$FLASHW_STOP      - Stop flashing
;                  |$FLASHW_TIMER     - Flash continuously, until the $FLASHW_STOP flag is set
;                  |$FLASHW_TIMERNOFG - Flash continuously until the window comes to the foreground
;                  |$FLASHW_TRAY      - Flash the taskbar button
;                  Count   - The number of times to flash the window
;                  Timeout - The rate at which the window is to be flashed, in milliseconds
; Author ........: Paul Campbell (PaulIA)
; Remarks .......: Needs Constants.au3 for pre-defined constants
; ===============================================================================================================================
Global Const $tagFLASHWINDOW = "int Size;hwnd hWnd;int Flags;int Count;int TimeOut"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagGUID
; Description ...: Represents a globally unique identifier (GUID)
; Fields ........: Data1 - Data 1 element
;                  Data2 - Data 2 element
;                  Data3 - Data 2 element
;                  Data4 - Data 2 element
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagGUID = "int Data1;short Data2;short Data3;byte Data4[8]"

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: $tagICONINFO
; Description ...: Contains information about an icon or a cursor
; Fields ........: Icon     - Specifies the contents of the structure:
;                  |True  - Icon
;                  |False - Cursor
;                  XHotSpot - Specifies the x-coordinate of a cursor's hot spot
;                  YHotSpot - Specifies the y-coordinate of the cursor's hot spot
;                  hMask    - Specifies the icon bitmask bitmap
;                  hColor   - Handle to the icon color bitmap
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagICONINFO = "int Icon;int XHotSpot;int YHotSpot;hwnd hMask;hwnd hColor"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagWINDOWPLACEMENT
; Description ...: The WINDOWPLACEMENT structure contains information about the placement of a window on the screen
; Fields ........: length      - Specifies the length, in bytes, of the structure
;                  flags       - Specifies flags that control the position of the minimized window and the method by which the window is restored. This member can be one or more of the following values
;                  |$WPF_ASYNCWINDOWPLACEMENT - Windows 2000/XP: If the calling thread and the thread that owns the window are attached to different input queues, the system posts the request to the thread that owns the window.
;                  |$WPF_RESTORETOMAXIMIZED   - Specifies that the restored window will be maximized, regardless of whether it was maximized before it was minimized.
;                  |  This setting is only valid the next time the window is restored. It does not change the default restoration behavior.
;                  |  This flag is only valid when the @SW_SHOWMINIMIZED value is specified for the showCmd member.
;                  |$WPF_SETMINPOSITION       - Specifies that the coordinates of the minimized window may be specified.
;                  |  This flag must be specified if the coordinates are set in the ptMinPosition member.
;                  showCmd - Specifies the current show state of the window. This member can be one of the following values:
;                  |@SW_HIDE            - Hides the window and activates another window.
;                  |@SW_MAXIMIZE        - Maximizes the specified window.
;                  |@SW_MINIMIZE        - Minimizes the specified window and activates the next top-level window in the z-order.
;                  |@SW_RESTORE         - Activates and displays the window. If the window is minimized or maximized, the system restores it to its original size and position.
;                  |  An application should specify this flag when restoring a minimized window.
;                  |@SW_SHOW            - Activates the window and displays it in its current size and position.
;                  |@SW_SHOWMAXIMIZED   - Activates the window and displays it as a maximized window.
;                  |@SW_SHOWMINIMIZED   - Activates the window and displays it as a minimized window.
;                  |@SW_SHOWMINNOACTIVE - Displays the window as a minimized window.
;                  |  This value is similar to @SW_SHOWMINIMIZED, except the window is not activated.
;                  |@SW_SHOWNA - Displays the window in its current size and position.
;                  |  This value is similar to @SW_SHOW, except the window is not activated.
;                  |@SW_SHOWNOACTIVATE - Displays a window in its most recent size and position.
;                  |  This value is similar to @SW_SHOWNORMAL, except the window is not actived.
;                  |@SW_SHOWNORMAL     - Activates and displays a window.
;                  |  If the window is minimized or maximized, the system restores it to its original size and position.
;                  |  An application should specify this flag when displaying the window for the first time.
;                  ptMinPosition    - Specifies the coordinates of the window's upper-left corner when the window is minimized.
;                  ptMaxPosition    - Specifies the coordinates of the window's upper-left corner when the window is maximized.
;                  rcNormalPosition - Specifies the window's coordinates when the window is in the restored position.
; Author ........: PsaltyDS
; Remarks .......:
; ===============================================================================================================================
Global Const $tagWINDOWPLACEMENT = "UINT length; UINT flags; UINT showCmd; int ptMinPosition[2]; int ptMaxPosition[2]; int rcNormalPosition[4]"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagWINDOWPOS
; Description ...: The WINDOWPOS structure contains information about the size and position of a window
; Fields ........: hWnd        - Handle to the window
;                  InsertAfter - Specifies the position of the window in Z order
;                  X           - Specifies the position of the left edge of the window
;                  Y           - Specifies the position of the top edge of the window
;                  CX          - Specifies the window width, in pixels
;                  CY          - Specifies the window height, in pixels
;                  Flags       - Specifies the window position. This member can be one or more of the following values:
;                  |$SWP_DRAWFRAME      - Draws a frame around the window
;                  |$SWP_FRAMECHANGED   - Sends a WM_NCCALCSIZE message to the window, even if the window's size is not being changed
;                  |$SWP_HIDEWINDOW     - Hides the window
;                  |$SWP_NOACTIVATE     - Does not activate the window
;                  |$SWP_NOCOPYBITS     - Discards the entire contents of the client area
;                  |$SWP_NOMOVE         - Retains the current position (ignores the x and y parameters)
;                  |$SWP_ NOOWNERZORDER - Does not change the owner window's position in the Z order
;                  |$SWP_NOREDRAW       - Does not redraw changes
;                  |$SWP_NOREPOSITION   - Same as the SWP_NOOWNERZORDER flag
;                  |$SWP_NOSENDCHANGING - Prevents the window from receiving the WM_WINDOWPOSCHANGING message
;                  |$SWP_NOSIZE         - Retains the current size (ignores the cx and cy parameters)
;                  |$SWP_NOZORDER       - Retains the current Z order (ignores the InsertAfter parameter)
;                  |$SWP_SHOWWINDOW     - Displays the window
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagWINDOWPOS = "hwnd hWnd;int InsertAfter;int X;int Y;int CX;int CY;int Flags"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagSCROLLINFO
; Description ...: Contains scroll bar parameters to be set by the $SBM_SETSCROLLINFO message, or retrieved by the $SBM_GETSCROLLINFO message
; Fields ........: cbSize - Specifies the size, in bytes, of this structure. The caller must set this to DllStructGetSize($tagSCROLLINFO).
;                  fMask  - Specifies the scroll bar parameters to set or retrieve. This member can be a combination of the following values:
;                  |$SIF_ALL - Combination of $SIF_PAGE, $SIF_POS, $SIF_RANGE, and $SIF_TRACKPOS.
;                  |$SIF_DISABLENOSCROLL - This value is used only when setting a scroll bar's parameters.
;                  |  If the scroll bar's new parameters make the scroll bar unnecessary, disable the scroll bar instead of removing it.
;                  |$SIF_PAGE - The nPage member contains the page size for a proportional scroll bar.
;                  |$SIF_POS  - The nPos member contains the scroll box position, which is not updated while the user drags the scroll box.
;                  |$SIF_RANGE - The nMin and nMax members contain the minimum and maximum values for the scrolling range.
;                  |$SIF_TRACKPOS - The nTrackPos member contains the current position of the scroll box while the user is dragging it.
;                  nMin - Specifies the minimum scrolling position.
;                  nMax - Specifies the maximum scrolling position.
;                  nPage - Specifies the page size. A scroll bar uses this value to determine the appropriate size of the proportional scroll box.
;                  nPos  - Specifies the position of the scroll box.
;                  nTrackPos - Specifies the immediate position of a scroll box that the user is dragging.
;                  |An application can retrieve this value while processing the $SB_THUMBTRACK request code.
;                  |An application cannot set the immediate scroll position, the SetScrollInfo function ignores this member.
; Author ........: Gary Frost
; Remarks .......: $SIF_xxxxx and $SB_xxxxx for scrollbar require WindowsConstants.au3
; ===============================================================================================================================
Global Const $tagSCROLLINFO = "uint cbSize;uint fMask;int  nMin;int  nMax;uint nPage;int  nPos;int  nTrackPos"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagSCROLLBARINFO
; Description ...: Contains scroll bar information
; Fields ........: cbSize - Specifies the size, in bytes, of this structure. The caller must set this to DllStructGetSize($tagSCROLLBARINFO).
;                  Left   - Specifies the x-coordinate of the upper-left corner of the rectangle coordinates of the scroll bar
;                  Top    - Specifies the y-coordinate of the upper-left corner of the rectangle coordinates of the scroll bar
;                  Right  - Specifies the x-coordinate of the lower-right corner of the rectangle coordinates of the scroll bar
;                  Bottom - Specifies the y-coordinate of the lower-right corner of the rectangle coordinates of the scroll bar
;                  dxyLineButton - Height or width of the thumb.
;                  xyThumbTop    - Position of the top or left of the thumb.
;                  xyThumbBottom - Position of the bottom or right of the thumb.
;                  reserved      - Reserved.
;                  rgstate       - An array of DWORD elements. Each element indicates the state of a scroll bar component.
;                  |The following values show the scroll bar component that corresponds to each array index:
;                  |  0 The scroll bar itself.
;                  |  1 The top or right arrow button.
;                  |  2 The page up or page right region.
;                  |  3 The scroll box (thumb).
;                  |  4 The page down or page left region.
;                  |  5 The bottom or left arrow button.
;                  -
;                  |The DWORD element for each scroll bar component can include a combination of the following bit flags.
;                  |  STATE_SYSTEM_INVISIBLE   - For the scroll bar itself, indicates the specified vertical or horizontal scroll bar does not exist.
;                  |    For the page up or page down regions, indicates the thumb is positioned such that the region does not exist.
;                  |  STATE_SYSTEM_OFFSCREEN   - For the scroll bar itself, indicates the window is sized such that the specified vertical or horizontal scroll bar is not currently displayed.
;                  |  STATE_SYSTEM_PRESSED     - The arrow button or page region is pressed.
;                  |  STATE_SYSTEM_UNAVAILABLE - The component is disabled.
; Author ........: Gary Frost
; Remarks .......: $SIF_xxxxx and $SB_xxxxx for scrollbar require WindowsConstants.au3
; ===============================================================================================================================
Global Const $tagSCROLLBARINFO = "dword cbSize;int Left;int Top;int Right;int Bottom;int dxyLineButton;int xyThumbTop;" & _
		"int xyThumbBottom;int reserved;dword rgstate[6]"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagLOGFONT
; Description ...: Defines the attributes of a font
; Fields ........: Height         - Height, in logical units, of the font's character cell or character
;                  Width          - Specifies the average width, in logical units, of characters in the font
;                  Escapement     - Specifies the angle, in tenths of degrees, between the escapement vector and the X axis
;                  Orientation    - Specifies the angle, in tenths of degrees, between each character's base line and the X axis
;                  Weight         - Specifies the weight of the font in the range 0 through 1000
;                  Italic         - Specifies an italic font if set to True
;                  Underline      - Specifies an underlined font if set to True
;                  StrikeOut      - Specifies a strikeout font if set to True
;                  CharSet        - Specifies the character set
;                  OutPrecision   - Specifies the output precision
;                  ClipPrecision  - Specifies the clipping precision
;                  Quality        - Specifies the output quality
;                  PitchAndFamily - Specifies the pitch and family of the font
;                  FaceName       - Specifies the typeface name of the font
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagLOGFONT = "int Height;int Width;int Escapement;int Orientation;int Weight;byte Italic;byte Underline;" & _
		"byte Strikeout;byte CharSet;byte OutPrecision;byte ClipPrecision;byte Quality;byte PitchAndFamily;char FaceName[32]"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagKBDLLHOOKSTRUCT
; Description ...: Contains information about a low-level keyboard input event
; Fields ........: vkCode               - Specifies a virtual-key code. The code must be a value in the range 1 to 254
;                  scanCode             - Specifies a hardware scan code for the key
;                  flags                - Specifies the extended-key flag, event-injected flag, context code, and transition-state flag. This member is specified as follows.
;                  +  An application can use the following values to test the keystroke flags:
;                  |$LLKHF_EXTENDED     - Test the extended-key flag
;                  |$LLKHF_INJECTED     - Test the event-injected flag
;                  |$LLKHF_ALTDOWN      - Test the context code
;                  |$LLKHF_UP           - Test the transition-state flag
;                  |  0      - Specifies whether the key is an extended key, such as a function key or a key on the numeric keypad
;                  |    The value is 1 if the key is an extended key; otherwise, it is 0
;                  |  1 to 3 - Reserved
;                  |  4      - Specifies whether the event was injected. The value is 1 if the event was injected; otherwise, it is 0
;                  |  5      - Specifies the context code. The value is 1 if the ALT key is pressed; otherwise, it is 0
;                  |  6      - Reserved
;                  |  7      - Specifies the transition state. The value is 0 if the key is pressed and 1 if it is being released
;                  time                 - Specifies the time stamp for this message, equivalent to what GetMessageTime would return for this message
;                  dwExtraInfo          - Specifies extra information associated with the message
; Author ........: Gary Frost (gafrost)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagKBDLLHOOKSTRUCT = "dword vkCode;dword scanCode;dword flags;dword time;ulong_ptr dwExtraInfo"

; ===============================================================================================================================
; *******************************************************************************************************************************
; Process and Thread Structures
; *******************************************************************************************************************************
; ===============================================================================================================================

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagPROCESS_INFORMATION
; Description ...: Contains information about a newly created process and its primary thread
; Fields ........: hProcess  - A handle to the newly created process
;                  hThread   - A handle to the primary thread of the newly created process
;                  ProcessID - A value that can be used to identify a process
;                  ThreadID  - A value that can be used to identify a thread
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagPROCESS_INFORMATION = "hwnd hProcess;hwnd hThread;int ProcessID;int ThreadID"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagSTARTUPINFO
; Description ...: Specifies the window station, desktop, standard handles, and appearance of the main window for a process at creation time
; Fields ........: Size          - The size of the structure, in bytes
;                  Reserved1     - Reserved, must be zero
;                  Desktop       - The name of the desktop, or the name of both the desktop and window station for this process
;                  Title         - For console processes, the title displayed in the title bar if a new console is created
;                  X             - If Flags specifies $STARTF_USEPOSITION, this member is the x offset of the upper  left  corner
;                  +of a window if a new window is created, in pixels.
;                  Y             - If Flags specifies $STARTF_USEPOSITION, this member is the y offset of the upper  left  corner
;                  +of a window if a new window is created, in pixels.
;                  XSize         - If Flags specifies $STARTF_USESIZE, this member is the height of the window, in pixels
;                  YSize         - If Flags specifies $STARTF_USESIZE, this member is the width of the window, in pixels
;                  XCountChars   - If Flags specifies $STARTF_USECOUNTCHARS, if a new console window  is  created  in  a  console
;                  +process, this member specifies the screen buffer width, in character columns.
;                  YCountChars   - If Flags specifies $STARTF_USECOUNTCHARS, if a new console window  is  created  in  a  console
;                  +process, this member specifies the screen buffer height, in character rows.
;                  FillAttribute - If Flags specifies $STARTF_USEFILLATTRIBUTE, this member is the initial  text  and  background
;                  +colors if a new console window is created in a console application.
;                  Flags         - Determines which members are used when the process creates a window:
;                  |$STARTF_FORCEONFEEDBACK  - The cursor is in feedback mode for two seconds after CreateProcess is  called. The
;                  +Working in Background cursor is displayed.  If during those two seconds the process makes the first GUI call,
;                  +the system gives five more seconds to the process.  If during those five seconds the process shows a  window,
;                  +the system gives five more seconds to the process to finish drawing the window. The system turns the feedback
;                  +cursor off after the first call to GetMessage, regardless of whether the process is drawing.
;                  |$STARTF_FORCEOFFFEEDBACK - Indicates that the feedback cursor is forced off while the  process  is  starting.
;                  +The Normal Select cursor is displayed.
;                  |$STARTF_RUNFULLSCREEN    - Indicates that the process should be run in  full  screen  mode,  rather  than  in
;                  +windowed mode. This flag is only valid for console applications running on an x86 computer.
;                  |$STARTF_USECOUNTCHARS    - The XCountChars and YCountChars members are valid
;                  |$STARTF_USEFILLATTRIBUTE - The FillAttribute member is valid
;                  |$STARTF_USEPOSITION      - The X and Y members are valid
;                  |$STARTF_USESHOWWINDOW    - The ShowWindow member is valid
;                  |$STARTF_USESIZE          - The XSize and YSize members are valid
;                  |$STARTF_USESTDHANDLES    - The hStdInput, hStdOutput, and hStdError members are valid
;                  ShowWindow    - If Flags specifies $STARTF_USESHOWWINDOW, this member can be any of the SW_ constants
;                  Reserved2     -  Reserved, must be zero
;                  Reserved3     -  Reserved, must be zero
;                  StdInput      - If Flags specifies $STARTF_USESTDHANDLES, this member is the standard input handle
;                  StdOutput     - If Flags specifies $STARTF_USESTDHANDLES, this member is the standard output handle
;                  StdError      - If Flags specifies $STARTF_USESTDHANDLES, this member is the standard error handle
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagSTARTUPINFO = "int Size;ptr Reserved1;ptr Desktop;ptr Title;int X;int Y;int XSize;int YSize;int XCountChars;" & _
		"int YCountChars;int FillAttribute;int Flags;short ShowWindow;short Reserved2;ptr Reserved3;int StdInput;" & _
		"int StdOutput;int StdError"

; ===============================================================================================================================
; *******************************************************************************************************************************
; Authorization Structures
; *******************************************************************************************************************************
; ===============================================================================================================================
; #STRUCTURE# ===================================================================================================================
; Name...........: $tagSECURITY_ATTRIBUTES
; Description ...: Contains the security descriptor for an object and specifies whether the handle retrieved by specifying this structure is inheritable
; Fields ........: Length        - The size, in bytes, of this structure
;                  Descriptor    - A pointer to a security descriptor for the object that controls the sharing of it
;                  InheritHandle - If True, the new process inherits the handle.
; Author ........: Paul Campbell (PaulIA)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagSECURITY_ATTRIBUTES = "int Length;ptr Descriptor;int InheritHandle"

; == Leave this line at the end of the file =====================================================================================