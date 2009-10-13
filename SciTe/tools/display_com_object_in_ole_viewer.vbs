'~~Author~~. Kinook Software
'~~Email_Address~~. kinook@kinook.com
'~~Script_Type~~. vbscript
'~~Sub_Type~~. Misc
'~~Keywords~~. make, visual c++, project, workspace
'~~Comment~~.
'Looks up a COM object in the registry and loads it up in OLE Viewer if requested.
'~~Script~~.
'
' COMLookup.vbs
' Copyright © 2000 Kinook Software.  All rights reserved.
' http://www.kinook.com
' Be sure to visit www.kinook.com for more handy utilities and tools,
' including Visual Build, the build management tool for Windows and web
' developers.
'
' COMLookup is freeware.  You may freely distribute it, as long as you do not
' sell it or make it part of another package or application.  If any
' modifications are made to the script code, they must be clearly marked in
' the code and documented in the Modifications section below, and these header
' comments must not be changed or removed.
'
' Do you ever get tired of verifying that a component is properly registered,
' where it is registered, and what its type library is?  Doing this over and
' over:
'   1) Start RegEdit
'   2) Navigate to HKEY_CLASSES_ROOT, <ProgId>\Clsid
'   3) Lookup the CLSID
'   4) Navigate to CLSID\<clsid>
'   5) Lookup server executable name
'   6) Lookup TypeLib GUID and Version
'   7) Navigate to Typelib\<libid>\<version>\0\win32
'   8) Lookup type library filename
'   9) Start OLE Viewer
'  10) Browse to the component/typelib to view it
'
' COMLookup is a VBScript utility that does this lookup for you. Given a
' ProgId or CLSID, it will tell you if the component is properly registered,
' display the path for any InprocServer32, InprocHandler32, or LocalServer32
' entries, and Typelib entries, and load it up in OLE Viewer if requested.
'
' Usage: double-click COMLookup.vbs and enter a ProgId or CLSID
'
' Dependencies:
'   1) Microsoft Windows Scripting 5.0+ (comes with Win98 & Win2000, download
'      for NT 4.0 and Win95 at http://msdn.microsoft.com/scripting)
'
' Modifications:
' Jan 3, 2000 (1.0) => initial version
'
' script entry point

   scriptName = "Display COM object in OLE Viewer"
   OLEView_path = "c:\@Developer\WSH\@Soft\OLEView\OLEView.exe"

   On Error Resume Next
   
   ' create shell object
   Set objShell = WScript.CreateObject("WScript.Shell")
   If Err.Number <> 0 Then ExitWithError "Failed to create WScript.Shell object."

   ' get component to lookup from the user
   strProgId = WScript.StdIn.ReadAll
   If Len(strProgId) > 0 Then
      If Left(strProgId, 1) = "{" Then
         strCLSID = strProgId
      Else    ' lookup CLSID for the ProgId
         strCLSID = objShell.RegRead("HKCR\" & strProgId & "\Clsid\")
         If Err.Number <> 0 Then ExitWithMsg "ProgId '" & strProgId & "' not registered."
      End If

      ' see if the CLSID key exists
      objShell.RegRead("HKCR\CLSID\" & strCLSID & "\")
      If Err.Number <> 0 Then ExitWithMsg "CLSID '" & strCLSID & "' not registered."

      ' lookup server path
      strServer = objShell.RegRead("HKCR\CLSID\" & strCLSID & "\InprocServer32\")
      If Len(strServer) = 0 Then strServer = objShell.RegRead("HKCR\CLSID\" & strCLSID & "\InprocHandler32\")
      If Len(strServer) = 0 Then strServer = objShell.RegRead("HKCR\CLSID\" & strCLSID & "\LocalServer32\")
      Err.Clear

      ' lookup type library path
      strTypelibGUID = objShell.RegRead("HKCR\CLSID\" & strCLSID & "\TypeLib\")
      strTypelibVer = objShell.RegRead("HKCR\CLSID\" & strCLSID & "\Version\")
      If Len(strTypelibGUID) > 0 And Len(strTypelibVer) > 0 Then
         strTypelib = objShell.RegRead("HKCR\Typelib\" & strTypelibGUID & "\" & HexifyVer(strTypelibVer) & "\0\win32\")
      End If
      Err.Clear

      If Len(strServer) = 0 Then
         MsgBox strProgId & " is not a creatable component.", vbInformation, scriptName
      ElseIf strCLSID <> strProgId Then
         intReturn = MsgBox(strProgId & vbNewLine & "is registered as   " & strServer & vbNewLine & "CLSID = " & strCLSID & vbNewLine & _
            "Open in OLE Viewer?", vbInformation + vbYesNo, WScript.ScriptName)
      Else
         intReturn = MsgBox(strCLSID & " is registered as '" & strServer & "'. " & _
            "Open in OLE Viewer?", vbInformation + vbYesNo, scriptName)
      End If

      ' open in OLE Viewer if requested
      If intReturn = vbYes Then RunOleView strServer

      ' if has a typelib and not the same as the component, prompt for opening it too
      If Len(strTypelib) > 0 And strTypelib <> strServer Then
         intReturn = MsgBox("TypeLib for " & strProgid & " is '" & strTypelib & "' (LIBID = " & _
            strTypelibGUID & "). " & "Open in OLE Viewer?", vbInformation + vbYesNo, scriptName)

         ' open in OLE Viewer if requested
         If intReturn = vbYes Then RunOleView strServer
      End If
   End If
   WScript.Quit 0		' exit with success code if we got here


'**************************************************************************
' RunOleView
' starts OleView.exe with specified component filename

Sub RunOleView(strServer)

   On Error Resume Next

   ' lookup path to OLE Viewer in registry
   strOLEView = objShell.RegRead("HKLM\SOFTWARE\Microsoft\Shared Tools\oleview.exe\Path")
   Err.Clear
   If Len(strOLEView) = 0 Then strOLEView = OLEView_path

   objShell.Run("""" & strOLEView & """ " & strServer)
   If Err.Number <> 0 Then ExitWithError "Failed to launch oleview.exe."

End Sub

'**************************************************************************
' HexifyVer
' convert string in format 999.9 to XX.9

Function HexifyVer(strVer)
  intPos = InStr(strVer, ".")
  HexifyVer = Hex(Left(strVer, intPos - 1)) & Mid(strVer, intPos)
End Function

'**************************************************************************

' ExitWithError
' write the error description to standard output and exit with a failure
exitcode

Sub ExitWithError(strExtraDescr)

   If Len(strExtraDescr) > 0 Then
      MsgBox strExtraDescr & vbCrlf & Err.Description, vbExclamation, scriptName
   Else
      MsgBox Err.Description, vbExclamation, scriptName
   End If
   WScript.Quit Err.Number

End Sub

'**************************************************************************

' ExitWithMsg
' write the description to standard output and exit with a failure exitcode

Sub ExitWithMsg(strDescr)
   MsgBox strDescr, vbInformation, scriptName
   WScript.Quit -1
End Sub

