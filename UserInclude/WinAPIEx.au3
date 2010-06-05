#Region Header

#cs

    Title:          WinAPI Extended UDF Library for AutoIt3
    Filename:       WinAPIEx.au3
    Description:    Additional variables, constants and functions for the WinAPI.au3
    Author:         Yashied
    Version:        2.6
    Requirements:   AutoIt v3.3 +, Developed/Tested on WindowsXP Pro Service Pack 2
    Uses:           WinAPI.au3
    Note:           The library uses the following system DLLs:

                    advapi32.dll
                    comctl32.dll
                    dwmapi.dll (Windows Vista or above)
                    gdi32.dll
                    kernel32.dll
                    ole32.dll
                    psapi.dll
                    sensapi.dll
                    shell32.dll
                    shlwapi.dll
                    user32.dll
                    userenv.dll
                    uxtheme.dll
                    winmm.dll
                    winspool.drv

    Available functions:

    _WinAPI_ActivateKeyboardLayout
    _WinAPI_AboutDlg
    _WinAPI_AddFontResourceEx
    _WinAPI_AddMRUString
    _WinAPI_AdjustTokenPrivileges
    _WinAPI_AdjustWindowRectEx
    _WinAPI_AlphaBlend
    _WinAPI_AnimateWindow
    _WinAPI_ArrayToStruct
    _WinAPI_AssignProcessToJobObject
    _WinAPI_AssocGetPerceivedType
    _WinAPI_AssocQueryString
    _WinAPI_BeginPaint
    _WinAPI_BringWindowToTop
    _WinAPI_BroadcastSystemMessage
    _WinAPI_BrowseForFolderDlg
    _WinAPI_CharToOem
    _WinAPI_ChildWindowFromPointEx
    _WinAPI_CloseThemeData
    _WinAPI_CloseWindow
    _WinAPI_ColorHLSToRGB
    _WinAPI_ColorRGBToHLS
    _WinAPI_CommandLineToArgv
    _WinAPI_CopyFileEx
    _WinAPI_CopyImage
    _WinAPI_CopyRect
    _WinAPI_CoTaskMemAlloc
    _WinAPI_CoTaskMemFree
    _WinAPI_CoTaskMemRealloc
    _WinAPI_CreateBrushIndirect
    _WinAPI_CreateCaret
    _WinAPI_CreateCompatibleBitmapEx
    _WinAPI_CreateDIBSection
    _WinAPI_CreateEllipticRgn
    _WinAPI_CreateFileEx
    _WinAPI_CreateGUID
    _WinAPI_CreateIconIndirect
    _WinAPI_CreateJobObject
    _WinAPI_CreateMRUList
    _WinAPI_CreatePolygonRgn
    _WinAPI_CreateRect
    _WinAPI_CreateRectEx
    _WinAPI_CreateRectRgnIndirect
    _WinAPI_CreateSemaphore
    _WinAPI_CreateStreamOnHGlobal
    _WinAPI_DefineDosDevice
    _WinAPI_DeleteVolumeMountPoint
    _WinAPI_DeregisterShellHookWindow
    _WinAPI_DestroyCaret
    _WinAPI_DeviceIoControl
    _WinAPI_DllInstall
    _WinAPI_DllUninstall
    _WinAPI_DragAcceptFiles
    _WinAPI_DragFinish
    _WinAPI_DragQueryFileEx
    _WinAPI_DragQueryPoint
    _WinAPI_DrawAnimatedRects
    _WinAPI_DrawBitmap
    _WinAPI_DrawShadowText
    _WinAPI_DrawThemeBackground
    _WinAPI_DrawThemeParentBackground
    _WinAPI_DrawThemeText
 ***_WinAPI_DrawThemeTextEx
    _WinAPI_DuplicateBitmap
    _WinAPI_DuplicateCursor
    _WinAPI_DuplicateIcon
    _WinAPI_DuplicateStruct
 ***_WinAPI_DwmEnableBlurBehindWindow
 ***_WinAPI_DwmEnableComposition
 ***_WinAPI_DwmGetColorizationColor
 ***_WinAPI_DwmGetWindowAttribute
 ***_WinAPI_DwmExtendFrameIntoClientArea
 ***_WinAPI_DwmIsCompositionEnabled
 ***_WinAPI_DwmQueryThumbnailSourceSize
 ***_WinAPI_DwmRegisterThumbnail
 ***_WinAPI_DwmSetWindowAttribute
 ***_WinAPI_DwmUnregisterThumbnail
 ***_WinAPI_DwmUpdateThumbnailProperties
    _WinAPI_DWordToInt
    _WinAPI_EjectMedia
    _WinAPI_Ellipse
    _WinAPI_EmptyWorkingSet
    _WinAPI_EndPaint
    _WinAPI_EnumChildProcess
    _WinAPI_EnumChildWindows
    _WinAPI_EnumDeviceDrivers
    _WinAPI_EnumDisplaySettings
    _WinAPI_EnumMRUList
    _WinAPI_EnumProcessThreads
    _WinAPI_EnumProcessWindows
    _WinAPI_EnumResourceLanguages
    _WinAPI_EnumResourceNames
    _WinAPI_EnumResourceTypes
    _WinAPI_EnumSystemLocales
    _WinAPI_EqualRect
    _WinAPI_EqualRgn
    _WinAPI_EqualStruct
    _WinAPI_ExtSelectClipRgn
    _WinAPI_FatalExit
    _WinAPI_FileTimeToLocalFileTime
    _WinAPI_FileTimeToSystemTime
   *_WinAPI_FillRect
    _WinAPI_FillRgn
    _WinAPI_FillStruct
    _WinAPI_FindResource
    _WinAPI_FindResourceEx
    _WinAPI_FitToBitmap
    _WinAPI_FormatDriveDlg
   *_WinAPI_FrameRect
    _WinAPI_FrameRgn
    _WinAPI_FreeCursor
    _WinAPI_FreeHandle
    _WinAPI_FreeIcon
    _WinAPI_FreeMRUList
    _WinAPI_FreeObject
    _WinAPI_FreeResource
    _WinAPI_GetActiveWindow
    _WinAPI_GetBinaryType
    _WinAPI_GetBitmapDimension
    _WinAPI_GetBkColor
    _WinAPI_GetBValue
    _WinAPI_GetCaretBlinkTime
    _WinAPI_GetCaretPos
    _WinAPI_GetClassLong
    _WinAPI_GetCompression
    _WinAPI_GetCurrentDirectory
    _WinAPI_GetCurrentHwProfile
    _WinAPI_GetCurrentThemeName
    _WinAPI_GetCursor
    _WinAPI_GetDateFormat
    _WinAPI_GetDefaultPrinter
    _WinAPI_GetDeviceDriverBaseName
    _WinAPI_GetDeviceDriverFileName
    _WinAPI_GetDiskFreeSpaceEx
    _WinAPI_GetDriveBusType
    _WinAPI_GetDriveGeometryEx
    _WinAPI_GetDriveNumber
    _WinAPI_GetDriveType
    _WinAPI_GetFontResourceInfo
   *_WinAPI_GetForegroundWindow
    _WinAPI_GetGValue
    _WinAPI_GetHandleInformation
    _WinAPI_GetHGlobalFromStream
    _WinAPI_GetIconBitmap
    _WinAPI_GetIconDimension
    _WinAPI_GetIconMask
    _WinAPI_GetIdleTime
    _WinAPI_GetKeyboardLayout
    _WinAPI_GetKeyboardLayoutList
    _WinAPI_GetKeyboardState
    _WinAPI_GetKeyboardType
    _WinAPI_GetKeyNameText
    _WinAPI_GetKeyState
   *_WinAPI_GetLayeredWindowAttributes
    _WinAPI_GetLocaleInfo
    _WinAPI_GetModuleFileNameEx
    _WinAPI_GetObjectEx
    _WinAPI_GetObjectType
    _WinAPI_GetParentProcess
    _WinAPI_GetPerformanceInfo
    _WinAPI_GetPixel
    _WinAPI_GetPosFromRect
    _WinAPI_GetProcAddress
    _WinAPI_GetProcessCreationTime
    _WinAPI_GetProcessIoCounters
    _WinAPI_GetProcessMemoryInfo
    _WinAPI_GetProcessName
    _WinAPI_GetProfilesDirectory
    _WinAPI_GetRgnBox
    _WinAPI_GetROP2
    _WinAPI_GetRValue
    _WinAPI_GetSystemDefaultLCID
    _WinAPI_GetSystemInfo
    _WinAPI_GetSystemPowerStatus
    _WinAPI_GetSystemWow64Directory
    _WinAPI_GetTempFileName
    _WinAPI_GetTextColor
    _WinAPI_GetTextFace
    _WinAPI_GetTextMetrics
    _WinAPI_GetThemeAppProperties
    _WinAPI_GetThemeColor
    _WinAPI_GetThemeDocumentationProperty
    _WinAPI_GetThemeFont
    _WinAPI_GetThemeInt
    _WinAPI_GetThemeMargins
    _WinAPI_GetThemePartSize
    _WinAPI_GetThemePosition
    _WinAPI_GetThemeRect
    _WinAPI_GetTickCount
 ***_WinAPI_GetTickCount64
    _WinAPI_GetTimeFormat
    _WinAPI_GetTopWindow
    _WinAPI_GetUpdateRect
    _WinAPI_GetUpdateRgn
    _WinAPI_GetUserDefaultLCID
    _WinAPI_GetVersion
    _WinAPI_GetVersionEx
    _WinAPI_GetVolumeNameForVolumeMountPoint
    _WinAPI_GetWindowInfo
    _WinAPI_GetWindowModuleFileName
    _WinAPI_GetWorkArea
    _WinAPI_GradientFill
    _WinAPI_HideCaret
    _WinAPI_HiDWord
    _WinAPI_InflateRect
    _WinAPI_IntersectRect
    _WinAPI_IntToDWord
   *_WinAPI_InvalidateRect
    _WinAPI_InvalidateRgn
    _WinAPI_InvertRect
    _WinAPI_InvertRgn
    _WinAPI_IsChild
    _WinAPI_IsDoorOpen
    _WinAPI_IsHungAppWindow
    _WinAPI_IsIconic
    _WinAPI_IsLoadKBLayout
    _WinAPI_IsNetworkAlive
    _WinAPI_IsPressed
    _WinAPI_IsProcessInJob
    _WinAPI_IsProcessorFeaturePresent
    _WinAPI_IsRectEmpty
    _WinAPI_IsThemeActive
    _WinAPI_IsThemeBackgroundPartiallyTransparent
    _WinAPI_IsThemePartDefined
    _WinAPI_IsValidLocale
    _WinAPI_IsWindowEnabled
    _WinAPI_IsWindowUnicode
    _WinAPI_IsWow64Process
    _WinAPI_IsWritable
    _WinAPI_IsZoomed
    _WinAPI_Keybd_Event
    _WinAPI_KillTimer
    _WinAPI_LoadCursor
    _WinAPI_LoadCursorFromFile
 ***_WinAPI_LoadIconWithScaleDown
    _WinAPI_LoadKeyboardLayout
    _WinAPI_LoadMedia
    _WinAPI_LoadResource
    _WinAPI_LockDevice
    _WinAPI_LockFile
    _WinAPI_LockResource
    _WinAPI_LockWorkStation
    _WinAPI_LoDWord
    _WinAPI_LookupPrivilegeName
    _WinAPI_LookupPrivilegeValue
    _WinAPI_MessageBoxCheck
    _WinAPI_MoveFileEx
    _WinAPI_OemToChar
    _WinAPI_OffsetClipRgn
    _WinAPI_OffsetRect
    _WinAPI_OffsetRgn
    _WinAPI_OpenIcon
    _WinAPI_OpenJobObject
    _WinAPI_OpenProcessToken
    _WinAPI_OpenSemaphore
    _WinAPI_OpenThemeData
    _WinAPI_PaintRgn
    _WinAPI_PatBlt
    _WinAPI_PathCompactPath
    _WinAPI_PathFindExtension
    _WinAPI_PathFindFileName
    _WinAPI_PathFindNextComponent
   *_WinAPI_PathFindOnPath
    _WinAPI_PathGetArgs
    _WinAPI_PathGetCharType
    _WinAPI_PathGetDriveNumber
    _WinAPI_PathIsExe
    _WinAPI_PathIsDirectory
    _WinAPI_PathIsDirectoryEmpty
    _WinAPI_PathIsFileSpec
    _WinAPI_PathIsRelative
    _WinAPI_PathIsSameRoot
    _WinAPI_PathMatchSpec
    _WinAPI_PathRenameExtension
    _WinAPI_PathSearchAndQualify
    _WinAPI_PathUnExpandEnvStrings
    _WinAPI_PathYetAnotherMakeUniqueName
    _WinAPI_PickIconDlg
    _WinAPI_PlaySound
    _WinAPI_Polygon
    _WinAPI_PrintWindow
  **_WinAPI_PrivateExtractIcon
    _WinAPI_PtInRectEx
    _WinAPI_PtInRegion
    _WinAPI_QueryDosDevice
    _WinAPI_QueryInformationJobObject
    _WinAPI_QueryPerformanceCounter
    _WinAPI_QueryPerformanceFrequency
    _WinAPI_RadialGradientFill
    _WinAPI_Rectangle
    _WinAPI_RegCloseKey
    _WinAPI_RegConnectRegistry
    _WinAPI_RegCopyTree
    _WinAPI_RegCreateKey
    _WinAPI_RegDeleteEmptyKey
    _WinAPI_RegDeleteKey
    _WinAPI_RegDeleteTree
    _WinAPI_RegEnumKey
    _WinAPI_RegEnumValue
    _WinAPI_RegFlushKey
    _WinAPI_RegisterHotKey
    _WinAPI_RegisterShellHookWindow
    _WinAPI_RegOpenKey
    _WinAPI_RegQueryInfoKey
    _WinAPI_RegQueryLastWriteTime
    _WinAPI_RegQueryValue
    _WinAPI_RegRestoreKey
    _WinAPI_RegSaveKey
    _WinAPI_RegSetValue
    _WinAPI_ReleaseSemaphore
    _WinAPI_RemoveFontResourceEx
    _WinAPI_RestartDlg
    _WinAPI_RestoreDC
    _WinAPI_RGB
    _WinAPI_RoundRect
    _WinAPI_SaveDC
    _WinAPI_SendMessageTimeout
    _WinAPI_SetActiveWindow
    _WinAPI_SetClassLong
    _WinAPI_SetCompression
    _WinAPI_SetCaretBlinkTime
    _WinAPI_SetCaretPos
    _WinAPI_SetCurrentDirectory
   *_WinAPI_SetDefaultPrinter
    _WinAPI_SetDCBrushColor
    _WinAPI_SetDCPenColor
    _WinAPI_SetFilePointerEx
    _WinAPI_SetForegroundWindow
   *_WinAPI_SetHandleInformation
    _WinAPI_SetInformationJobObject
    _WinAPI_SetKeyboardLayout
    _WinAPI_SetKeyboardState
   *_WinAPI_SetLayeredWindowAttributes
    _WinAPI_SetLibraryColorMode
   *_WinAPI_SetParent
    _WinAPI_SetPixel
    _WinAPI_SetROP2
    _WinAPI_SetStretchBltMode
    _WinAPI_SetSystemCursor
    _WinAPI_SetThemeAppProperties
    _WinAPI_SetTimer
    _WinAPI_SetVolumeMountPoint
    _WinAPI_ShellAddToRecentDocs
    _WinAPI_ShellChangeNotify
    _WinAPI_ShellChangeNotifyDeregister
    _WinAPI_ShellChangeNotifyRegister
    _WinAPI_ShellEmptyRecycleBin
    _WinAPI_ShellExtractAssociatedIcon
    _WinAPI_ShellExtractIcons
    _WinAPI_ShellFileOperation
    _WinAPI_ShellGetFileInfo
 ***_WinAPI_ShellGetKnownFolderPath
    _WinAPI_ShellGetPathFromIDList
    _WinAPI_ShellGetSettings
    _WinAPI_ShellGetSpecialFolderLocation
    _WinAPI_ShellGetSpecialFolderPath
 ***_WinAPI_ShellGetStockIconInfo
    _WinAPI_ShellILCreateFromPath
    _WinAPI_ShellNotifyIcon
    _WinAPI_ShellObjectProperties
 ***_WinAPI_ShellOpenWithDlg
    _WinAPI_ShellQueryRecycleBin
    _WinAPI_ShellSetSettings
    _WinAPI_ShowCaret
    _WinAPI_ShowLastError
    _WinAPI_ShowOwnedPopups
    _WinAPI_ShutdownDlg
    _WinAPI_SizeofResource
    _WinAPI_StretchBlt
    _WinAPI_StrLen
    _WinAPI_StructToArray
    _WinAPI_SubtractRect
    _WinAPI_SwitchColor
  **_WinAPI_SwitchToThisWindow
    _WinAPI_TransparentBlt
    _WinAPI_TextOut
    _WinAPI_UnionRect
    _WinAPI_UnionStruct
    _WinAPI_UniqueHardwaeID
    _WinAPI_UnloadKeyboardLayout
    _WinAPI_UnlockFile
    _WinAPI_UnregisterHotKey
    _WinAPI_UpdateLayeredWindowEx
    _WinAPI_ValidateRect
    _WinAPI_ValidateRgn
    _WinAPI_WindowFromDC

   * Available in native AutoIt library
  ** Deprecated
 *** Required Windows Vista or above

#ce

#Include-once

#Include <WinAPI.au3>

#EndRegion Header

#Region Global Variables and Constants

; ===============================================================================================================================
; _WinAPI_ActivateKeyboardLayout(), _WinAPI_LoadKeyboardLayout()
; ===============================================================================================================================

Global Const $KLF_ACTIVATE = 0x00000001
Global Const $KLF_NOTELLSHELL = 0x00000080
Global Const $KLF_REORDER = 0x00000008
Global Const $KLF_REPLACELANG = 0x00000010
Global Const $KLF_RESET = 0x40000000
Global Const $KLF_SETFORPROCESS = 0x00000100
Global Const $KLF_SHIFTLOCK = 0x00010000
Global Const $KLF_SUBSTITUTE_OK = 0x00000002

Global Const $HKL_NEXT = 1
Global Const $HKL_PREV = 0

; ===============================================================================================================================
; _WinAPI_AddFontResourceEx(), _WinAPI_RemoveFontResourceEx()
; ===============================================================================================================================

Global Const $FR_PRIVATE = 0x10
Global Const $FR_NOT_ENUM = 0x20

; ===============================================================================================================================
; _WinAPI_AnimateWindow()
; ===============================================================================================================================

Global Const $AW_SLIDE = 0x00040000
Global Const $AW_ACTIVATE = 0x00020000
Global Const $AW_BLEND = 0x00080000
Global Const $AW_HIDE = 0x00010000
Global Const $AW_CENTER = 0x00000010
Global Const $AW_HOR_POSITIVE = 0x00000001
Global Const $AW_HOR_NEGATIVE = 0x00000002
Global Const $AW_VER_POSITIVE = 0x00000004
Global Const $AW_VER_NEGATIVE = 0x00000008

; ===============================================================================================================================
; _WinAPI_AssocGetPerceivedType()
; ===============================================================================================================================

Global Const $PERCEIVED_TYPE_CUSTOM = -3
Global Const $PERCEIVED_TYPE_UNSPECIFIED = -2
Global Const $PERCEIVED_TYPE_FOLDER = -1
Global Const $PERCEIVED_TYPE_UNKNOWN = 0
Global Const $PERCEIVED_TYPE_TEXT = 1
Global Const $PERCEIVED_TYPE_IMAGE = 2
Global Const $PERCEIVED_TYPE_AUDIO = 3
Global Const $PERCEIVED_TYPE_VIDEO = 4
Global Const $PERCEIVED_TYPE_COMPRESSED = 5
Global Const $PERCEIVED_TYPE_DOCUMENT = 6
Global Const $PERCEIVED_TYPE_SYSTEM = 7
Global Const $PERCEIVED_TYPE_APPLICATION = 8
Global Const $PERCEIVED_TYPE_GAMEMEDIA = 9
Global Const $PERCEIVED_TYPE_CONTACTS = 10

Global Const $PERCEIVEDFLAG_UNDEFINED = 0x0000
Global Const $PERCEIVEDFLAG_SOFTCODED = 0x0001
Global Const $PERCEIVEDFLAG_HARDCODED = 0x0002
Global Const $PERCEIVEDFLAG_NATIVESUPPORT = 0x0004
Global Const $PERCEIVEDFLAG_GDIPLUS = 0x0010
Global Const $PERCEIVEDFLAG_WMSDK = 0x0020
Global Const $PERCEIVEDFLAG_ZIPFOLDER = 0x0040

; ===============================================================================================================================
; _WinAPI_AssocQueryString()
; ===============================================================================================================================

Global Const $ASSOCSTR_COMMAND = 1
Global Const $ASSOCSTR_EXECUTABLE = 2
Global Const $ASSOCSTR_FRIENDLYDOCNAME = 3
Global Const $ASSOCSTR_FRIENDLYAPPNAME = 4
Global Const $ASSOCSTR_NOOPEN = 5
Global Const $ASSOCSTR_SHELLNEWVALUE = 6
Global Const $ASSOCSTR_DDECOMMAND = 7
Global Const $ASSOCSTR_DDEIFEXEC = 8
Global Const $ASSOCSTR_DDEAPPLICATION = 9
Global Const $ASSOCSTR_DDETOPIC = 10
Global Const $ASSOCSTR_INFOTIP = 11
Global Const $ASSOCSTR_QUICKTIP = 12
Global Const $ASSOCSTR_TILEINFO = 13
Global Const $ASSOCSTR_CONTENTTYPE = 14
Global Const $ASSOCSTR_DEFAULTICON = 15
Global Const $ASSOCSTR_SHELLEXTENSION = 16

Global Const $ASSOCF_INIT_NOREMAPCLSID = 0x00000001
Global Const $ASSOCF_INIT_BYEXENAME = 0x00000002
Global Const $ASSOCF_OPEN_BYEXENAME = 0x00000002
Global Const $ASSOCF_INIT_DEFAULTTOSTAR = 0x00000004
Global Const $ASSOCF_INIT_DEFAULTTOFOLDER = 0x00000008
Global Const $ASSOCF_NOUSERSETTINGS = 0x00000010
Global Const $ASSOCF_NOTRUNCATE = 0x00000020
Global Const $ASSOCF_VERIFY = 0x00000040
Global Const $ASSOCF_REMAPRUNDLL = 0x00000080
Global Const $ASSOCF_NOFIXUPS = 0x00000100
Global Const $ASSOCF_IGNOREBASECLASS = 0x00000200
Global Const $ASSOCF_INIT_IGNOREUNKNOWN = 0x00000400

; ===============================================================================================================================
; _WinAPI_BroadcastSystemMessage()
; ===============================================================================================================================

Global Const $BSF_ALLOWSFW = 0x0080
Global Const $BSF_FLUSHDISK = 0x0004
Global Const $BSF_FORCEIFHUNG = 0x0020
Global Const $BSF_IGNORECURRENTTASK = 0x0002
Global Const $BSF_NOHANG = 0x0008
Global Const $BSF_NOTIMEOUTIFNOTHUNG = 0x0040
Global Const $BSF_POSTMESSAGE = 0x0010
Global Const $BSF_QUERY = 0x0001
Global Const $BSF_SENDNOTIFYMESSAGE = 0x0100

Global Const $BSM_ALLCOMPONENTS = 0x00
Global Const $BSM_ALLDESKTOPS = 0x08
Global Const $BSM_APPLICATIONS = 0x10
Global Const $BSM_INSTALLABLEDRIVERS = 0x04
Global Const $BSM_NETDRIVER = 0x02
Global Const $BSM_VXDS = 0x01

; ===============================================================================================================================
; _WinAPI_BrowseForFolderDlg()
; ===============================================================================================================================

Global Const $BIF_RETURNONLYFSDIRS = 0x00000001
Global Const $BIF_DONTGOBELOWDOMAIN = 0x00000002
Global Const $BIF_STATUSTEXT = 0x00000004
Global Const $BIF_RETURNFSANCESTORS = 0x00000008
Global Const $BIF_EDITBOX = 0x00000010
Global Const $BIF_VALIDATE = 0x00000020
Global Const $BIF_NEWDIALOGSTYLE = 0x00000040
Global Const $BIF_BROWSEINCLUDEURLS = 0x00000080
Global Const $BIF_USENEWUI = BitOR($BIF_EDITBOX, $BIF_NEWDIALOGSTYLE)
Global Const $BIF_UAHINT = 0x00000100
Global Const $BIF_NONEWFOLDERBUTTON = 0x00000200
Global Const $BIF_NOTRANSLATETARGETS = 0x00000400
Global Const $BIF_BROWSEFORCOMPUTER = 0x00001000
Global Const $BIF_BROWSEFORPRINTER = 0x00002000
Global Const $BIF_BROWSEINCLUDEFILES = 0x00004000
Global Const $BIF_SHAREABLE = 0x00008000

; *Windows 7 or above
Global Const $BIF_BROWSEFILEJUNCTIONS = 0x00010000

Global Const $BFFM_INITIALIZED = 1
Global Const $BFFM_IUNKNOWN = 5
Global Const $BFFM_SELCHANGED = 2
Global Const $BFFM_VALIDATEFAILED = 4

Global Const $BFFM_ENABLEOK = 0x0465 ; WM_USER + 101
Global Const $BFFM_SETOKTEXT = 0x0469 ; WM_USER + 105
Global Const $BFFM_SETSELECTION = 0x0467 ; WM_USER + 103
Global Const $BFFM_SETEXPANDED = 0x046A ; WM_USER + 106
Global Const $BFFM_SETSTATUSTEXT = 0x0468 ; WM_USER + 104

; ===============================================================================================================================
; _WinAPI_ChildWindowFromPointEx()
; ===============================================================================================================================

Global Const $CWP_ALL = 0x00
Global Const $CWP_SKIPINVISIBLE = 0x01
Global Const $CWP_SKIPDISABLED = 0x02
Global Const $CWP_SKIPTRANSPARENT = 0x04

; ===============================================================================================================================
; _WinAPI_CreateDIBSection()
; ===============================================================================================================================

Global Const $BI_RGB = 0
Global Const $BI_RLE8 = 1
Global Const $BI_RLE4 = 2
Global Const $BI_BITFIELDS = 3
Global Const $BI_JPEG = 4
Global Const $BI_PNG = 5

; ===============================================================================================================================
; _WinAPI_CreateMRUList()
; ===============================================================================================================================

Global Const $MRU_BINARY = 0x0001
Global Const $MRU_CACHEWRITE = 0x0002

; ===============================================================================================================================
; _WinAPI_CopyFileEx(), _WinAPI_MoveFileEx()
; ===============================================================================================================================

Global Const $COPY_FILE_ALLOW_DECRYPTED_DESTINATION = 0x0008
Global Const $COPY_FILE_COPY_SYMLINK = 0x0800
Global Const $COPY_FILE_FAIL_IF_EXISTS = 0x0001
Global Const $COPY_FILE_NO_BUFFERING = 0x1000
Global Const $COPY_FILE_OPEN_SOURCE_FOR_WRITE = 0x0004
Global Const $COPY_FILE_RESTARTABLE = 0x0002

Global Const $MOVE_FILE_COPY_ALLOWED = 0x0002
Global Const $MOVE_FILE_CREATE_HARDLINK = 0x0010
Global Const $MOVE_FILE_DELAY_UNTIL_REBOOT = 0x0004
Global Const $MOVE_FILE_FAIL_IF_NOT_TRACKABLE = 0x0020
Global Const $MOVE_FILE_REPLACE_EXISTING = 0x0001
Global Const $MOVE_FILE_WRITE_THROUGH = 0x0008

Global Const $PROGRESS_CONTINUE = 0
Global Const $PROGRESS_CANCEL = 1
Global Const $PROGRESS_STOP = 2
Global Const $PROGRESS_QUIET = 3

; ===============================================================================================================================
; _WinAPI_CopyImage()
; ===============================================================================================================================

#cs

Global Const $LR_DEFAULTCOLOR = 0x0000
Global Const $LR_DEFAULTSIZE = 0x0040
Global Const $LR_COLOR = 0x0002
Global Const $LR_COPYDELETEORG = 0x0008
Global Const $LR_COPYFROMRESOURCE = 0x4000
Global Const $LR_COPYRETURNORG = 0x0004
Global Const $LR_CREATEDIBSECTION = 0x2000
Global Const $LR_LOADFROMFILE = 0x0010
Global Const $LR_LOADMAP3DCOLORS = 0x1000
Global Const $LR_LOADTRANSPARENT = 0x0020
Global Const $LR_MONOCHROME = 0x0001
Global Const $LR_SHARED = 0x8000
Global Const $LR_VGACOLOR = 0x0080

#ce

; ===============================================================================================================================
; _WinAPI_CreateBrushIndirect()
; ===============================================================================================================================

Global Const $BS_DIBPATTERN = 5
Global Const $BS_DIBPATTERN8X8 = 8
Global Const $BS_DIBPATTERNPT = 6
Global Const $BS_HATCHED = 2
Global Const $BS_HOLLOW = 1
Global Const $BS_NULL = 1
Global Const $BS_PATTERN = 3
Global Const $BS_PATTERN8X8 = 7
Global Const $BS_SOLID = 0

Global Const $HS_BDIAGONAL = 3
Global Const $HS_CROSS = 4
Global Const $HS_DIAGCROSS = 5
Global Const $HS_FDIAGONAL = 2
Global Const $HS_HORIZONTAL = 0
Global Const $HS_VERTICAL = 1

Global Const $DIB_PAL_COLORS = 1
Global Const $DIB_RGB_COLORS = 0

; ===============================================================================================================================
; _WinAPI_CreateFileEx()
; ===============================================================================================================================

#cs

Global Const $CREATE_NEW = 1
Global Const $CREATE_ALWAYS = 2
Global Const $OPEN_EXISTING = 3
Global Const $OPEN_ALWAYS = 4
Global Const $TRUNCATE_EXISTING = 5

Global Const $GENERIC_ALL = 0x10000000
Global Const $GENERIC_EXECUTE = 0x20000000
Global Const $GENERIC_WRITE = 0x40000000
Global Const $GENERIC_READ = 0x80000000

Global Const $FILE_SHARE_READ = 0x01
Global Const $FILE_SHARE_WRITE = 0x02
Global Const $FILE_SHARE_DELETE = 0x04

Global Const $FILE_ATTRIBUTE_READONLY = 0x00000001
Global Const $FILE_ATTRIBUTE_HIDDEN = 0x00000002
Global Const $FILE_ATTRIBUTE_SYSTEM = 0x00000004
Global Const $FILE_ATTRIBUTE_DIRECTORY = 0x00000010
Global Const $FILE_ATTRIBUTE_ARCHIVE = 0x00000020
Global Const $FILE_ATTRIBUTE_DEVICE = 0x00000040
Global Const $FILE_ATTRIBUTE_NORMAL = 0x00000080
Global Const $FILE_ATTRIBUTE_TEMPORARY = 0x00000100
Global Const $FILE_ATTRIBUTE_SPARSE_FILE = 0x00000200
Global Const $FILE_ATTRIBUTE_REPARSE_POINT = 0x00000400
Global Const $FILE_ATTRIBUTE_COMPRESSED = 0x00000800
Global Const $FILE_ATTRIBUTE_OFFLINE = 0x00001000
Global Const $FILE_ATTRIBUTE_NOT_CONTENT_INDEXED = 0x00002000
Global Const $FILE_ATTRIBUTE_ENCRYPTED = 0x00004000

#ce

Global Const $FILE_FLAG_BACKUP_SEMANTICS = 0x02000000
Global Const $FILE_FLAG_DELETE_ON_CLOSE = 0x04000000
Global Const $FILE_FLAG_NO_BUFFERING = 0x20000000
Global Const $FILE_FLAG_OPEN_NO_RECALL = 0x00100000
Global Const $FILE_FLAG_OPEN_REPARSE_POINT = 0x00200000
Global Const $FILE_FLAG_OVERLAPPED = 0x40000000
Global Const $FILE_FLAG_POSIX_SEMANTICS = 0x0100000
Global Const $FILE_FLAG_RANDOM_ACCESS = 0x10000000
Global Const $FILE_FLAG_SEQUENTIAL_SCAN = 0x08000000
Global Const $FILE_FLAG_WRITE_THROUGH = 0x80000000

Global Const $SECURITY_ANONYMOUS = 0x00000000
Global Const $SECURITY_IDENTIFICATION = 0x00010000
Global Const $SECURITY_IMPERSONATION = 0x00020000
Global Const $SECURITY_DELEGATION = 0x00030000
Global Const $SECURITY_CONTEXT_TRACKING = 0x00040000
Global Const $SECURITY_EFFECTIVE_ONLY = 0x00080000

; ===============================================================================================================================
; _WinAPI_CreatePolygonRgn()
; ===============================================================================================================================

Global Const $ALTERNATE = 1
Global Const $WINDING = 2

; ===============================================================================================================================
; _WinAPI_GetCurrentHwProfile()
; ===============================================================================================================================

Global Const $DOCKINFO_DOCKED = 0x02
Global Const $DOCKINFO_UNDOCKED = 0x01
Global Const $DOCKINFO_USER_SUPPLIED = 0x04
Global Const $DOCKINFO_USER_DOCKED = 0x05
Global Const $DOCKINFO_USER_UNDOCKED = 0x06

; ===============================================================================================================================
; _WinAPI_DefineDosDevice()
; ===============================================================================================================================

Global Const $DDD_EXACT_MATCH_ON_REMOVE = 0x04
Global Const $DDD_NO_BROADCAST_SYSTEM = 0x08
Global Const $DDD_RAW_TARGET_PATH = 0x01
Global Const $DDD_REMOVE_DEFINITION = 0x02

; ===============================================================================================================================
; _WinAPI_DrawShadowText()
; ===============================================================================================================================

#cs

Global Const $DT_BOTTOM = 0x00000008
Global Const $DT_CALCRECT = 0x00000400
Global Const $DT_CENTER = 0x00000001
Global Const $DT_EDITCONTROL = 0x00002000
Global Const $DT_END_ELLIPSIS = 0x00008000
Global Const $DT_EXPANDTABS = 0x00000040
Global Const $DT_EXTERNALLEADING = 0x00000200
Global Const $DT_HIDEPREFIX = 0x00100000
Global Const $DT_INTERNAL = 0x00001000
Global Const $DT_LEFT = 0x00000000
Global Const $DT_MODIFYSTRING = 0x00010000
Global Const $DT_NOCLIP = 0x00000100
Global Const $DT_NOFULLWIDTHCHARBREAK = 0x00080000
Global Const $DT_NOPREFIX = 0x00000800
Global Const $DT_PATH_ELLIPSIS = 0x00004000
Global Const $DT_PREFIXONLY = 0x00200000
Global Const $DT_RIGHT = 0x00000002
Global Const $DT_RTLREADING = 0x00020000
Global Const $DT_SINGLELINE = 0x00000020
Global Const $DT_TABSTOP = 0x00000080
Global Const $DT_TOP = 0x00000000
Global Const $DT_VCENTER = 0x00000004
Global Const $DT_WORDBREAK = 0x00000010
Global Const $DT_WORD_ELLIPSIS = 0x00040000

#ce

; ===============================================================================================================================
; _WinAPI_DrawThemeTextEx()
; ===============================================================================================================================

Global Const $DTT_TEXTCOLOR = 0x00000001
Global Const $DTT_BORDERCOLOR = 0x00000002
Global Const $DTT_SHADOWCOLOR = 0x00000004
Global Const $DTT_SHADOWTYPE = 0x00000008
Global Const $DTT_SHADOWOFFSET = 0x00000010
Global Const $DTT_BORDERSIZE = 0x00000020
Global Const $DTT_FONTPROP = 0x00000040
Global Const $DTT_COLORPROP = 0x00000080
Global Const $DTT_STATEID = 0x00000100
Global Const $DTT_CALCRECT = 0x00000200
Global Const $DTT_APPLYOVERLAY = 0x00000400
Global Const $DTT_GLOWSIZE = 0x00000800
Global Const $DTT_CALLBACK = 0x00001000
Global Const $DTT_COMPOSITED = 0x00002000
Global Const $DTT_VALIDBITS = BitOR($DTT_TEXTCOLOR, $DTT_BORDERCOLOR, $DTT_SHADOWCOLOR, $DTT_SHADOWTYPE, $DTT_SHADOWOFFSET, $DTT_BORDERSIZE, $DTT_FONTPROP, $DTT_COLORPROP, $DTT_STATEID, $DTT_CALCRECT, $DTT_APPLYOVERLAY, $DTT_GLOWSIZE, $DTT_COMPOSITED)

Global Const $TST_NONE = 0
Global Const $TST_SINGLE = 1
Global Const $TST_CONTINUOUS = 2

; ===============================================================================================================================
; _WinAPI_DwmGetWindowAttribute(), _WinAPI_DwmSetWindowAttribute()
; ===============================================================================================================================

Global Const $DWMWA_NCRENDERING_ENABLED = 1
Global Const $DWMWA_NCRENDERING_POLICY = 2
Global Const $DWMWA_TRANSITIONS_FORCEDISABLED = 3
Global Const $DWMWA_ALLOW_NCPAINT = 4
Global Const $DWMWA_CAPTION_BUTTON_BOUNDS = 5
Global Const $DWMWA_NONCLIENT_RTL_LAYOUT = 6
Global Const $DWMWA_FORCE_ICONIC_REPRESENTATION = 7
Global Const $DWMWA_FLIP3D_POLICY = 8
Global Const $DWMWA_EXTENDED_FRAME_BOUNDS = 9

; *Windows 7 or above
Global Const $DWMWA_HAS_ICONIC_BITMAP = 10
Global Const $DWMWA_DISALLOW_PEEK = 11
Global Const $DWMWA_EXCLUDED_FROM_PEEK = 12

Global Const $DWMNCRP_USEWINDOWSTYLE = 0
Global Const $DWMNCRP_DISABLED = 1
Global Const $DWMNCRP_ENABLED = 2

Global Const $DWMFLIP3D_DEFAULT = 0
Global Const $DWMFLIP3D_EXCLUDEBELOW = 1
Global Const $DWMFLIP3D_EXCLUDEABOVE = 2

; ===============================================================================================================================
; _WinAPI_EnumDisplaySettings()
; ===============================================================================================================================

Global Const $ENUM_CURRENT_SETTINGS = -1
Global Const $ENUM_REGISTRY_SETTINGS = -2

Global Const $DM_GRAYSCALE = 0x01
Global Const $DM_INTERLACED = 0x02

; ===============================================================================================================================
; _WinAPI_ExtSelectClipRgn()
; ===============================================================================================================================

#cs

Global Const $RGN_AND = 1
Global Const $RGN_OR = 2
Global Const $RGN_XOR = 3
Global Const $RGN_DIFF = 4
Global Const $RGN_COPY = 5

#ce

; ===============================================================================================================================
; _WinAPI_FindResource(), _WinAPI_FindResourceEx()
; ===============================================================================================================================

Global Const $RT_ACCELERATOR = 9
Global Const $RT_ANICURSOR = 21
Global Const $RT_ANIICON = 22
Global Const $RT_BITMAP = 2
Global Const $RT_CURSOR = 1
Global Const $RT_DIALOG = 5
Global Const $RT_DLGINCLUDE = 17
Global Const $RT_FONT = 8
Global Const $RT_FONTDIR = 7
Global Const $RT_GROUP_CURSOR = 12
Global Const $RT_GROUP_ICON = 14
Global Const $RT_HTML = 23
Global Const $RT_ICON = 3
Global Const $RT_MANIFEST = 24
Global Const $RT_MENU = 4
Global Const $RT_MESSAGETABLE = 11
Global Const $RT_PLUGPLAY = 19
Global Const $RT_RCDATA = 10
Global Const $RT_STRING = 6
Global Const $RT_VERSION = 16
Global Const $RT_VXD = 20

; ===============================================================================================================================
; _WinAPI_FitToBitmap(), _WinAPI_SetStretchBltMode()
; ===============================================================================================================================

Global Const $BLACKONWHITE = 1
Global Const $COLORONCOLOR = 3
Global Const $HALFTONE = 4
Global Const $WHITEONBLACK = 2
Global Const $STRETCH_ANDSCANS = $BLACKONWHITE
Global Const $STRETCH_DELETESCANS = $COLORONCOLOR
Global Const $STRETCH_HALFTONE = $HALFTONE
Global Const $STRETCH_ORSCANS = $WHITEONBLACK

; ===============================================================================================================================
; _WinAPI_FormatDriveDlg()
; ===============================================================================================================================

Global Const $SHFMT_ID_DEFAULT = 0xFFFF

Global Const $SHFMT_OPT_FULL = 0x00
Global Const $SHFMT_OPT_QUICKFORMAT = 0x01
Global Const $SHFMT_OPT_SYSONLY = 0x02

Global Const $SHFMT_ERROR = -1
Global Const $SHFMT_CANCEL = -2
Global Const $SHFMT_NOFORMAT = -3

; ===============================================================================================================================
; _WinAPI_GetBinaryType()
; ===============================================================================================================================

Global Const $SCS_32BIT_BINARY = 0
Global Const $SCS_64BIT_BINARY = 6
Global Const $SCS_DOS_BINARY = 1
Global Const $SCS_OS216_BINARY = 5
Global Const $SCS_PIF_BINARY = 3
Global Const $SCS_POSIX_BINARY = 4
Global Const $SCS_WOW_BINARY = 2

; ===============================================================================================================================
; _WinAPI_GetClassLong(), _WinAPI_SetClassLong()
; ===============================================================================================================================

Global Const $GCL_CBCLSEXTRA = -20
Global Const $GCL_CBWNDEXTRA = -18
Global Const $GCL_HBRBACKGROUND = -10
Global Const $GCL_HCURSOR = -12
Global Const $GCL_HICON = -14
Global Const $GCL_HICONSM = -34
Global Const $GCL_HMODULE = -16
Global Const $GCL_MENUNAME = -8
Global Const $GCL_STYLE = -26
Global Const $GCL_WNDPROC = -24

; ===============================================================================================================================
; _WinAPI_GetCompression(), _WinAPI_SetCompression()
; ===============================================================================================================================

Global Const $COMPRESSION_FORMAT_NONE = 0
Global Const $COMPRESSION_FORMAT_DEFAULT = 1
Global Const $COMPRESSION_FORMAT_LZNT1 = 2

; ===============================================================================================================================
; _WinAPI_GetDateFormat()
; ===============================================================================================================================

Global Const $DATE_LONGDATE = 0x02
Global Const $DATE_SHORTDATE = 0x01
Global Const $DATE_USE_ALT_CALENDAR = 0x04

; *Windows Vista or above
Global Const $DATE_LTRREADING = 0x10
Global Const $DATE_RTLREADING = 0x20
Global Const $DATE_YEARMONTH = 0x08

; *Windows 7 or above
Global Const $DATE_AUTOLAYOUT = 0x40

; ===============================================================================================================================
; _WinAPI_GetDriveBusType()
; ===============================================================================================================================

Global Const $DRIVE_BUS_TYPE_UNKNOWN = 0x00
Global Const $DRIVE_BUS_TYPE_SCSI = 0x01
Global Const $DRIVE_BUS_TYPE_ATAPI = 0x02
Global Const $DRIVE_BUS_TYPE_ATA = 0x03
Global Const $DRIVE_BUS_TYPE_1394 = 0x04
Global Const $DRIVE_BUS_TYPE_SSA = 0x05
Global Const $DRIVE_BUS_TYPE_FIBRE = 0x06
Global Const $DRIVE_BUS_TYPE_USB = 0x07
Global Const $DRIVE_BUS_TYPE_RAID = 0x08
Global Const $DRIVE_BUS_TYPE_ISCSI = 0x09
Global Const $DRIVE_BUS_TYPE_SAS = 0x0A
Global Const $DRIVE_BUS_TYPE_SATA = 0x0B
Global Const $DRIVE_BUS_TYPE_SD = 0x0C
Global Const $DRIVE_BUS_TYPE_MMC = 0x0D

; ===============================================================================================================================
; _WinAPI_GetDriveNumber()
; ===============================================================================================================================

Global Const $FILE_DEVICE_8042_PORT = 0x27
Global Const $FILE_DEVICE_ACPI = 0x32
Global Const $FILE_DEVICE_BATTERY = 0x29
Global Const $FILE_DEVICE_BEEP = 0x01
Global Const $FILE_DEVICE_BUS_EXTENDER = 0x2A
Global Const $FILE_DEVICE_CD_ROM = 0x02
Global Const $FILE_DEVICE_CD_ROM_FILE_SYSTEM = 0x03
Global Const $FILE_DEVICE_CHANGER = 0x30
Global Const $FILE_DEVICE_CONTROLLER = 0x04
Global Const $FILE_DEVICE_DATALINK = 0x05
Global Const $FILE_DEVICE_DFS = 0x06
Global Const $FILE_DEVICE_DFS_FILE_SYSTEM = 0x35
Global Const $FILE_DEVICE_DFS_VOLUME = 0x36
Global Const $FILE_DEVICE_DISK = 0x07
Global Const $FILE_DEVICE_DISK_FILE_SYSTEM = 0x08
Global Const $FILE_DEVICE_DVD = 0x33
Global Const $FILE_DEVICE_FILE_SYSTEM = 0x09
Global Const $FILE_DEVICE_FIPS = 0x3A
Global Const $FILE_DEVICE_FULLSCREEN_VIDEO = 0x34
Global Const $FILE_DEVICE_INPORT_PORT = 0x0A
Global Const $FILE_DEVICE_KEYBOARD = 0x0B
Global Const $FILE_DEVICE_KS = 0x2F
Global Const $FILE_DEVICE_KSEC = 0x39
Global Const $FILE_DEVICE_MAILSLOT = 0x0C
Global Const $FILE_DEVICE_MASS_STORAGE = 0x2D
Global Const $FILE_DEVICE_MIDI_IN = 0x0D
Global Const $FILE_DEVICE_MIDI_OUT = 0x0E
Global Const $FILE_DEVICE_MODEM = 0x2B
Global Const $FILE_DEVICE_MOUSE = 0x0F
Global Const $FILE_DEVICE_MULTI_UNC_PROVIDER = 0x10
Global Const $FILE_DEVICE_NAMED_PIPE = 0x11
Global Const $FILE_DEVICE_NETWORK = 0x12
Global Const $FILE_DEVICE_NETWORK_BROWSER = 0x13
Global Const $FILE_DEVICE_NETWORK_FILE_SYSTEM = 0x14
Global Const $FILE_DEVICE_NETWORK_REDIRECTOR = 0x28
Global Const $FILE_DEVICE_NULL = 0x15
Global Const $FILE_DEVICE_PARALLEL_PORT = 0x16
Global Const $FILE_DEVICE_PHYSICAL_NETCARD = 0x17
Global Const $FILE_DEVICE_PRINTER = 0x18
Global Const $FILE_DEVICE_SCANNER = 0x19
Global Const $FILE_DEVICE_SCREEN = 0x1C
Global Const $FILE_DEVICE_SERENUM = 0x37
Global Const $FILE_DEVICE_SERIAL_MOUSE_PORT = 0x1A
Global Const $FILE_DEVICE_SERIAL_PORT = 0x1B
Global Const $FILE_DEVICE_SMARTCARD = 0x31
Global Const $FILE_DEVICE_SMB = 0x2E
Global Const $FILE_DEVICE_SOUND = 0x1D
Global Const $FILE_DEVICE_STREAMS = 0x1E
Global Const $FILE_DEVICE_TAPE = 0x1F
Global Const $FILE_DEVICE_TAPE_FILE_SYSTEM = 0x20
Global Const $FILE_DEVICE_TERMSRV = 0x38
Global Const $FILE_DEVICE_TRANSPORT = 0x21
Global Const $FILE_DEVICE_UNKNOWN = 0x22
Global Const $FILE_DEVICE_VDM = 0x2C
Global Const $FILE_DEVICE_VIDEO = 0x23
Global Const $FILE_DEVICE_VIRTUAL_DISK = 0x24
Global Const $FILE_DEVICE_WAVE_IN = 0x25
Global Const $FILE_DEVICE_WAVE_OUT = 0x26

; ===============================================================================================================================
; _WinAPI_GetDriveType()
; ===============================================================================================================================

Global Const $DRIVE_UNKNOWN = 0
Global Const $DRIVE_NO_ROOT_DIR = 1
Global Const $DRIVE_REMOVABLE = 2
Global Const $DRIVE_FIXED = 3
Global Const $DRIVE_REMOTE = 4
Global Const $DRIVE_CDROM = 5
Global Const $DRIVE_RAMDISK = 6

; ===============================================================================================================================
; _WinAPI_GetHandleInformation(), _WinAPI_SetHandleInformation()
; ===============================================================================================================================

Global Const $HANDLE_FLAG_INHERIT = 0x00000001
Global Const $HANDLE_FLAG_PROTECT_FROM_CLOSE = 0x00000002

; ===============================================================================================================================
; _WinAPI_GetLayeredWindowAttributes(), _WinAPI_SetLayeredWindowAttributes()
; ===============================================================================================================================

#cs

Global Const $LWA_COLORKEY = 0x01
Global Const $LWA_ALPHA = 0x02

#ce

; ===============================================================================================================================
; _WinAPI_GetLocaleInfo()
; ===============================================================================================================================

Global Const $LOCALE_ILANGUAGE              = 0x00000001 ; Language ID
Global Const $LOCALE_SLANGUAGE              = 0x00000002 ; Localized name of language
Global Const $LOCALE_SENGLANGUAGE           = 0x00001001 ; English name of language
Global Const $LOCALE_SABBREVLANGNAME        = 0x00000003 ; Abbreviated language name
Global Const $LOCALE_SNATIVELANGNAME        = 0x00000004 ; Native name of language

Global Const $LOCALE_ICOUNTRY               = 0x00000005 ; Country code
Global Const $LOCALE_SCOUNTRY               = 0x00000006 ; Localized name of country
Global Const $LOCALE_SENGCOUNTRY            = 0x00001002 ; English name of country
Global Const $LOCALE_SABBREVCTRYNAME        = 0x00000007 ; Abbreviated country name
Global Const $LOCALE_SNATIVECTRYNAME        = 0x00000008 ; Native name of country

Global Const $LOCALE_IDEFAULTLANGUAGE       = 0x00000009 ; Default language id
Global Const $LOCALE_IDEFAULTCOUNTRY        = 0x0000000A ; Default country code
Global Const $LOCALE_IDEFAULTCODEPAGE       = 0x0000000B ; Default oem code page
Global Const $LOCALE_IDEFAULTANSICODEPAGE   = 0x00001004 ; Default ansi code page
Global Const $LOCALE_IDEFAULTMACCODEPAGE    = 0x00001011 ; Default mac code page

Global Const $LOCALE_SLIST                  = 0x0000000C ; List item separator
Global Const $LOCALE_IMEASURE               = 0x0000000D ; 0 = Metric, 1 = US

Global Const $LOCALE_SDECIMAL               = 0x0000000E ; Decimal separator
Global Const $LOCALE_STHOUSAND              = 0x0000000F ; Thousand separator
Global Const $LOCALE_SGROUPING              = 0x00000010 ; Digit grouping
Global Const $LOCALE_IDIGITS                = 0x00000011 ; Number of fractional digits
Global Const $LOCALE_ILZERO                 = 0x00000012 ; Leading zeros for decimal
Global Const $LOCALE_INEGNUMBER             = 0x00001010 ; Negative number mode
Global Const $LOCALE_SNATIVEDIGITS          = 0x00000013 ; Native ASCII 0-9

Global Const $LOCALE_SCURRENCY              = 0x00000014 ; Local monetary symbol
Global Const $LOCALE_SINTLSYMBOL            = 0x00000015 ; Intl monetary symbol
Global Const $LOCALE_SMONDECIMALSEP         = 0x00000016 ; Monetary decimal separator
Global Const $LOCALE_SMONTHOUSANDSEP        = 0x00000017 ; Monetary thousand separator
Global Const $LOCALE_SMONGROUPING           = 0x00000018 ; Monetary grouping
Global Const $LOCALE_ICURRDIGITS            = 0x00000019 ; # local monetary digits
Global Const $LOCALE_IINTLCURRDIGITS        = 0x0000001A ; # intl monetary digits
Global Const $LOCALE_ICURRENCY              = 0x0000001B ; Positive currency mode
Global Const $LOCALE_INEGCURR               = 0x0000001C ; Negative currency mode

Global Const $LOCALE_SDATE                  = 0x0000001D ; Date separator
Global Const $LOCALE_STIME                  = 0x0000001E ; Time separator
Global Const $LOCALE_SSHORTDATE             = 0x0000001F ; Short date format string
Global Const $LOCALE_SLONGDATE              = 0x00000020 ; Long date format string
Global Const $LOCALE_STIMEFORMAT            = 0x00001003 ; Time format string
Global Const $LOCALE_IDATE                  = 0x00000021 ; Short date format ordering
Global Const $LOCALE_ILDATE                 = 0x00000022 ; Long date format ordering
Global Const $LOCALE_ITIME                  = 0x00000023 ; Time format specifier
Global Const $LOCALE_ITIMEMARKPOSN          = 0x00001005 ; Time marker position
Global Const $LOCALE_ICENTURY               = 0x00000024 ; Century format specifier (short date)
Global Const $LOCALE_ITLZERO                = 0x00000025 ; Leading zeros in time field
Global Const $LOCALE_IDAYLZERO              = 0x00000026 ; Leading zeros in day field (short date)
Global Const $LOCALE_IMONLZERO              = 0x00000027 ; Leading zeros in month field (short date)
Global Const $LOCALE_S1159                  = 0x00000028 ; AM designator
Global Const $LOCALE_S2359                  = 0x00000029 ; PM designator

Global Const $LOCALE_ICALENDARTYPE          = 0x00001009 ; Type of calendar specifier
Global Const $LOCALE_IOPTIONALCALENDAR      = 0x0000100B ; Additional calendar types specifier
Global Const $LOCALE_IFIRSTDAYOFWEEK        = 0x0000100C ; First day of week specifier
Global Const $LOCALE_IFIRSTWEEKOFYEAR       = 0x0000100D ; First week of year specifier

Global Const $LOCALE_SDAYNAME1              = 0x0000002A ; Long name for Monday
Global Const $LOCALE_SDAYNAME2              = 0x0000002B ; Long name for Tuesday
Global Const $LOCALE_SDAYNAME3              = 0x0000002C ; Long name for Wednesday
Global Const $LOCALE_SDAYNAME4              = 0x0000002D ; Long name for Thursday
Global Const $LOCALE_SDAYNAME5              = 0x0000002E ; Long name for Friday
Global Const $LOCALE_SDAYNAME6              = 0x0000002F ; Long name for Saturday
Global Const $LOCALE_SDAYNAME7              = 0x00000030 ; Long name for Sunday
Global Const $LOCALE_SABBREVDAYNAME1        = 0x00000031 ; Abbreviated name for Monday
Global Const $LOCALE_SABBREVDAYNAME2        = 0x00000032 ; Abbreviated name for Tuesday
Global Const $LOCALE_SABBREVDAYNAME3        = 0x00000033 ; Abbreviated name for Wednesday
Global Const $LOCALE_SABBREVDAYNAME4        = 0x00000034 ; Abbreviated name for Thursday
Global Const $LOCALE_SABBREVDAYNAME5        = 0x00000035 ; Abbreviated name for Friday
Global Const $LOCALE_SABBREVDAYNAME6        = 0x00000036 ; Abbreviated name for Saturday
Global Const $LOCALE_SABBREVDAYNAME7        = 0x00000037 ; Abbreviated name for Sunday
Global Const $LOCALE_SMONTHNAME1            = 0x00000038 ; Long name for January
Global Const $LOCALE_SMONTHNAME2            = 0x00000039 ; Long name for February
Global Const $LOCALE_SMONTHNAME3            = 0x0000003A ; Long name for March
Global Const $LOCALE_SMONTHNAME4            = 0x0000003B ; Long name for April
Global Const $LOCALE_SMONTHNAME5            = 0x0000003C ; Long name for May
Global Const $LOCALE_SMONTHNAME6            = 0x0000003D ; Long name for June
Global Const $LOCALE_SMONTHNAME7            = 0x0000003E ; Long name for July
Global Const $LOCALE_SMONTHNAME8            = 0x0000003F ; Long name for August
Global Const $LOCALE_SMONTHNAME9            = 0x00000040 ; Long name for September
Global Const $LOCALE_SMONTHNAME10           = 0x00000041 ; Long name for October
Global Const $LOCALE_SMONTHNAME11           = 0x00000042 ; Long name for November
Global Const $LOCALE_SMONTHNAME12           = 0x00000043 ; Long name for December
Global Const $LOCALE_SMONTHNAME13           = 0x0000100E ; long name for 13th month (if exists)
Global Const $LOCALE_SABBREVMONTHNAME1      = 0x00000044 ; Abbreviated name for January
Global Const $LOCALE_SABBREVMONTHNAME2      = 0x00000045 ; Abbreviated name for February
Global Const $LOCALE_SABBREVMONTHNAME3      = 0x00000046 ; Abbreviated name for March
Global Const $LOCALE_SABBREVMONTHNAME4      = 0x00000047 ; Abbreviated name for April
Global Const $LOCALE_SABBREVMONTHNAME5      = 0x00000048 ; Abbreviated name for May
Global Const $LOCALE_SABBREVMONTHNAME6      = 0x00000049 ; Abbreviated name for June
Global Const $LOCALE_SABBREVMONTHNAME7      = 0x0000004A ; Abbreviated name for July
Global Const $LOCALE_SABBREVMONTHNAME8      = 0x0000004B ; Abbreviated name for August
Global Const $LOCALE_SABBREVMONTHNAME9      = 0x0000004C ; Abbreviated name for September
Global Const $LOCALE_SABBREVMONTHNAME10     = 0x0000004D ; Abbreviated name for October
Global Const $LOCALE_SABBREVMONTHNAME11     = 0x0000004E ; Abbreviated name for November
Global Const $LOCALE_SABBREVMONTHNAME12     = 0x0000004F ; Abbreviated name for December
Global Const $LOCALE_SABBREVMONTHNAME13     = 0x0000100F ; Abbreviated name for 13th month (if exists)

Global Const $LOCALE_SPOSITIVESIGN          = 0x00000050 ; Positive sign
Global Const $LOCALE_SNEGATIVESIGN          = 0x00000051 ; Negative sign
Global Const $LOCALE_IPOSSIGNPOSN           = 0x00000052 ; Positive sign position
Global Const $LOCALE_INEGSIGNPOSN           = 0x00000053 ; Negative sign position
Global Const $LOCALE_IPOSSYMPRECEDES        = 0x00000054 ; Mon sym precedes pos amt
Global Const $LOCALE_IPOSSEPBYSPACE         = 0x00000055 ; Mon sym sep by space from pos amt
Global Const $LOCALE_INEGSYMPRECEDES        = 0x00000056 ; Mon sym precedes neg amt
Global Const $LOCALE_INEGSEPBYSPACE         = 0x00000057 ; Mon sym sep by space from neg amt

Global Const $LOCALE_FONTSIGNATURE          = 0x00000058 ; Font signature
Global Const $LOCALE_SISO639LANGNAME        = 0x00000059 ; ISO abbreviated language name
Global Const $LOCALE_SISO3166CTRYNAME       = 0x0000005A ; ISO abbreviated country name

Global Const $LOCALE_IDEFAULTEBCDICCODEPAGE = 0x00001012 ; Default ebcdic code page
Global Const $LOCALE_IPAPERSIZE             = 0x0000100A ; 0 = Letter, 1 = A4, 2 = Legal, 3 = A3
Global Const $LOCALE_SENGCURRNAME           = 0x00001007 ; English name of currency
Global Const $LOCALE_SNATIVECURRNAME        = 0x00001008 ; Native name of currency
Global Const $LOCALE_SYEARMONTH             = 0x00001006 ; Year month format string
Global Const $LOCALE_SSORTNAME              = 0x00001013 ; Sort name
Global Const $LOCALE_IDIGITSUBSTITUTION     = 0x00001014 ; 0 = None, 1 = Context, 2 = Native digit

; ===============================================================================================================================
; _WinAPI_GetObjectType()
; ===============================================================================================================================

Global Const $OBJ_BITMAP = 7
Global Const $OBJ_BRUSH = 2
Global Const $OBJ_COLORSPACE = 14
Global Const $OBJ_DC = 3
Global Const $OBJ_ENHMETADC = 12
Global Const $OBJ_ENHMETAFILE = 13
Global Const $OBJ_EXTPEN = 11
Global Const $OBJ_FONT = 6
Global Const $OBJ_MEMDC = 10
Global Const $OBJ_METADC = 4
Global Const $OBJ_METAFILE = 9
Global Const $OBJ_PAL = 5
Global Const $OBJ_PEN = 1
Global Const $OBJ_REGION = 8

; ===============================================================================================================================
; _WinAPI_GetROP2(), _WinAPI_SetROP2()
; ===============================================================================================================================

Global Const $R2_BLACK = 1
Global Const $R2_COPYPEN = 13
Global Const $R2_LAST = 16
Global Const $R2_MASKNOTPEN = 3
Global Const $R2_MASKPEN = 9
Global Const $R2_MASKPENNOT = 5
Global Const $R2_MERGENOTPEN = 12
Global Const $R2_MERGEPEN = 15
Global Const $R2_MERGEPENNOT = 14
Global Const $R2_NOP = 11
Global Const $R2_NOT = 6
Global Const $R2_NOTCOPYPEN = 4
Global Const $R2_NOTMASKPEN = 8
Global Const $R2_NOTMERGEPEN = 2
Global Const $R2_NOTXORPEN = 10
Global Const $R2_WHITE = 16
Global Const $R2_XORPEN = 7

; ===============================================================================================================================
; _WinAPI_GetSystemInfo()
; ===============================================================================================================================

Global Const $PROCESSOR_ARCHITECTURE_AMD64 = 9
Global Const $PROCESSOR_ARCHITECTURE_IA64 = 6
Global Const $PROCESSOR_ARCHITECTURE_INTEL = 0
Global Const $PROCESSOR_ARCHITECTURE_UNKNOWN = 0xFFFF

Global Const $PROCESSOR_INTEL_386 = 386
Global Const $PROCESSOR_INTEL_486 = 486
Global Const $PROCESSOR_INTEL_PENTIUM = 586
Global Const $PROCESSOR_INTEL_IA64 = 2200
Global Const $PROCESSOR_AMD_X8664 = 8664

; ===============================================================================================================================
; _WinAPI_GetTextMetrics()
; ===============================================================================================================================

Global Const $TMPF_FIXED_PITCH = 0x01
Global Const $TMPF_VECTOR = 0x02
Global Const $TMPF_TRUETYPE = 0x04
Global Const $TMPF_DEVICE = 0x08

; ===============================================================================================================================
; _WinAPI_GetThemeAppProperties(), _WinAPI_SetThemeAppProperties()
; ===============================================================================================================================

Global Const $STAP_ALLOW_NONCLIENT = 0x01
Global Const $STAP_ALLOW_CONTROLS = 0x02
Global Const $STAP_ALLOW_WEBCONTENT = 0x04

; ===============================================================================================================================
; _WinAPI_GetThemeDocumentationProperty()
; ===============================================================================================================================

Global Const $SZ_THDOCPROP_AUTHOR = 'Author'
Global Const $SZ_THDOCPROP_CANONICALNAME = 'ThemeName'
Global Const $SZ_THDOCPROP_DISPLAYNAME = 'DisplayName'
Global Const $SZ_THDOCPROP_TOOLTIP = 'ToolTip'

; ===============================================================================================================================
; _WinAPI_GetThemePartSize()
; ===============================================================================================================================

Global Const $TS_MIN = 0
Global Const $TS_TRUE = 1
Global Const $TS_DRAW = 2

; ===============================================================================================================================
; _WinAPI_GetTimeFormat()
; ===============================================================================================================================

Global Const $TIME_FORCE24HOURFORMAT = 0x08
Global Const $TIME_NOMINUTESORSECONDS = 0x01
Global Const $TIME_NOSECONDS = 0x02
Global Const $TIME_NOTIMEMARKER = 0x04

; ===============================================================================================================================
; _WinAPI_GetVersionEx()
; ===============================================================================================================================

Global Const $VER_SUITE_BACKOFFICE = 0x00000004
Global Const $VER_SUITE_BLADE = 0x00000400
Global Const $VER_SUITE_COMPUTE_SERVER = 0x00004000
Global Const $VER_SUITE_DATACENTER = 0x00000080
Global Const $VER_SUITE_ENTERPRISE = 0x00000002
Global Const $VER_SUITE_EMBEDDEDNT = 0x00000040
Global Const $VER_SUITE_PERSONAL = 0x00000200
Global Const $VER_SUITE_SINGLEUSERTS = 0x00000100
Global Const $VER_SUITE_SMALLBUSINESS = 0x00000001
Global Const $VER_SUITE_SMALLBUSINESS_RESTRICTED = 0x00000020
Global Const $VER_SUITE_STORAGE_SERVER = 0x00002000
Global Const $VER_SUITE_TERMINAL = 0x00000010
Global Const $VER_SUITE_WH_SERVER = 0x00008000

Global Const $VER_NT_DOMAIN_CONTROLLER = 0x0000002
Global Const $VER_NT_SERVER = 0x0000003
Global Const $VER_NT_WORKSTATION = 0x0000001

; ===============================================================================================================================
; _WinAPI_IsNetworkAlive()
; ===============================================================================================================================

Global Const $NETWORK_ALIVE_LAN = 0x01
Global Const $NETWORK_ALIVE_WAN = 0x02
Global Const $NETWORK_ALIVE_AOL = 0x04

; ===============================================================================================================================
; _WinAPI_IsProcessorFeaturePresent()
; ===============================================================================================================================

Global Const $PF_3DNOW_INSTRUCTIONS_AVAILABLE = 7
Global Const $PF_CHANNELS_ENABLED = 16
Global Const $PF_COMPARE_EXCHANGE_DOUBLE = 2
Global Const $PF_COMPARE_EXCHANGE128 = 14
Global Const $PF_COMPARE64_EXCHANGE128 = 15
Global Const $PF_FLOATING_POINT_EMULATED = 1
Global Const $PF_FLOATING_POINT_PRECISION_ERRATA = 0
Global Const $PF_MMX_INSTRUCTIONS_AVAILABLE = 3
Global Const $PF_NX_ENABLED = 12
Global Const $PF_PAE_ENABLED = 9
Global Const $PF_RDTSC_INSTRUCTION_AVAILABLE = 8
Global Const $PF_SSE3_INSTRUCTIONS_AVAILABLE = 13
Global Const $PF_XMMI_INSTRUCTIONS_AVAILABLE = 6
Global Const $PF_XMMI64_INSTRUCTIONS_AVAILABLE = 10
Global Const $PF_XSAVE_ENABLED = 17

; ===============================================================================================================================
; _WinAPI_IsValidLocale()
; ===============================================================================================================================

Global Const $LCID_INSTALLED = 1
Global Const $LCID_SUPPORTED = 2

; ===============================================================================================================================
; _WinAPI_Keybd_Event()
; ===============================================================================================================================

Global Const $KEYEVENTF_EXTENDEDKEY = 0x01
Global Const $KEYEVENTF_KEYUP = 0x02

; ===============================================================================================================================
; _WinAPI_Keybd_Event() and similar
; ===============================================================================================================================

#cs

Global Const $VK_LBUTTON = 0x01
Global Const $VK_RBUTTON = 0x02
Global Const $VK_CANCEL = 0x03
Global Const $VK_MBUTTON = 0x04
Global Const $VK_XBUTTON1 = 0x05
Global Const $VK_XBUTTON2 = 0x06
Global Const $VK_BACK = 0x08
Global Const $VK_TAB = 0x09
Global Const $VK_SHIFT = 0x10
Global Const $VK_CLEAR = 0x0C
Global Const $VK_RETURN = 0x0D
Global Const $VK_CONTROL = 0x11
Global Const $VK_MENU = 0x12
Global Const $VK_PAUSE = 0x13
Global Const $VK_CAPITAL = 0x14
Global Const $VK_ESCAPE = 0x1B
Global Const $VK_SPACE = 0x20
Global Const $VK_PRIOR = 0x21
Global Const $VK_NEXT = 0x22
Global Const $VK_END = 0x23
Global Const $VK_HOME = 0x24
Global Const $VK_LEFT = 0x25
Global Const $VK_UP = 0x26
Global Const $VK_RIGHT = 0x27
Global Const $VK_DOWN = 0x28
Global Const $VK_SELECT = 0x29
Global Const $VK_PRINT = 0x2A
Global Const $VK_EXECUTE = 0x2B
Global Const $VK_SNAPSHOT = 0x2C
Global Const $VK_INSERT = 0x2D
Global Const $VK_DELETE = 0x2E
Global Const $VK_HELP = 0x2F
Global Const $VK_0 = 0x30
Global Const $VK_1 = 0x31
Global Const $VK_2 = 0x32
Global Const $VK_3 = 0x33
Global Const $VK_4 = 0x34
Global Const $VK_5 = 0x35
Global Const $VK_6 = 0x36
Global Const $VK_7 = 0x37
Global Const $VK_8 = 0x38
Global Const $VK_9 = 0x39
Global Const $VK_A = 0x41
Global Const $VK_B = 0x42
Global Const $VK_C = 0x43
Global Const $VK_D = 0x44
Global Const $VK_E = 0x45
Global Const $VK_F = 0x46
Global Const $VK_G = 0x47
Global Const $VK_H = 0x48
Global Const $VK_I = 0x49
Global Const $VK_J = 0x4A
Global Const $VK_K = 0x4B
Global Const $VK_L = 0x4C
Global Const $VK_M = 0x4D
Global Const $VK_N = 0x4E
Global Const $VK_O = 0x4F
Global Const $VK_P = 0x50
Global Const $VK_Q = 0x51
Global Const $VK_R = 0x52
Global Const $VK_S = 0x53
Global Const $VK_T = 0x54
Global Const $VK_U = 0x55
Global Const $VK_V = 0x56
Global Const $VK_W = 0x57
Global Const $VK_X = 0x58
Global Const $VK_Y = 0x59
Global Const $VK_Z = 0x5A
Global Const $VK_LWIN = 0x5B
Global Const $VK_RWIN = 0x5C
Global Const $VK_APPS = 0x5D
Global Const $VK_SLEEP = 0x5F
Global Const $VK_NUMPAD0 = 0x60
Global Const $VK_NUMPAD1 = 0x61
Global Const $VK_NUMPAD2 = 0x62
Global Const $VK_NUMPAD3 = 0x63
Global Const $VK_NUMPAD4 = 0x64
Global Const $VK_NUMPAD5 = 0x65
Global Const $VK_NUMPAD6 = 0x66
Global Const $VK_NUMPAD7 = 0x67
Global Const $VK_NUMPAD8 = 0x68
Global Const $VK_NUMPAD9 = 0x69
Global Const $VK_MULTIPLY = 0x6A
Global Const $VK_ADD = 0x6B
Global Const $VK_SEPARATOR = 0x6C
Global Const $VK_SUBTRACT = 0x6D
Global Const $VK_DECIMAL = 0x6E
Global Const $VK_DIVIDE = 0x6F
Global Const $VK_F1 = 0x70
Global Const $VK_F2 = 0x71
Global Const $VK_F3 = 0x72
Global Const $VK_F4 = 0x73
Global Const $VK_F5 = 0x74
Global Const $VK_F6 = 0x75
Global Const $VK_F7 = 0x76
Global Const $VK_F8 = 0x77
Global Const $VK_F9 = 0x78
Global Const $VK_F10 = 0x79
Global Const $VK_F11 = 0x7A
Global Const $VK_F12 = 0x7B
Global Const $VK_F13 = 0x7C
Global Const $VK_F14 = 0x7D
Global Const $VK_F15 = 0x7E
Global Const $VK_F16 = 0x7F
Global Const $VK_F17 = 0x80
Global Const $VK_F18 = 0x81
Global Const $VK_F19 = 0x82
Global Const $VK_F20 = 0x83
Global Const $VK_F21 = 0x84
Global Const $VK_F22 = 0x85
Global Const $VK_F23 = 0x86
Global Const $VK_F24 = 0x87
Global Const $VK_NUMLOCK = 0x90
Global Const $VK_SCROLL = 0x91
Global Const $VK_LSHIFT = 0xA0
Global Const $VK_RSHIFT = 0xA1
Global Const $VK_LCONTROL = 0xA2
Global Const $VK_RCONTROL = 0xA3
Global Const $VK_LMENU = 0xA4
Global Const $VK_RMENU = 0xA5
Global Const $VK_BROWSER_BACK = 0xA6
Global Const $VK_BROWSER_FORWARD = 0xA7
Global Const $VK_BROWSER_REFRESH = 0xA8
Global Const $VK_BROWSER_STOP = 0xA9
Global Const $VK_BROWSER_SEARCH = 0xAA
Global Const $VK_BROWSER_FAVORITES = 0xAB
Global Const $VK_BROWSER_HOME = 0xAC
Global Const $VK_VOLUME_MUTE = 0xAD
Global Const $VK_VOLUME_DOWN = 0xAE
Global Const $VK_VOLUME_UP = 0xAF
Global Const $VK_MEDIA_NEXT_TRACK = 0xB0
Global Const $VK_MEDIA_PREV_TRACK = 0xB1
Global Const $VK_MEDIA_STOP = 0xB2
Global Const $VK_MEDIA_PLAY_PAUSE = 0xB3
Global Const $VK_LAUNCH_MAIL = 0xB4
Global Const $VK_LAUNCH_MEDIA_SELECT = 0xB5
Global Const $VK_LAUNCH_APP1 = 0xB6
Global Const $VK_LAUNCH_APP2 = 0xB7
Global Const $VK_OEM_1 = 0xBA ; ';:'
Global Const $VK_OEM_PLUS = 0xBB ; '=+'
Global Const $VK_OEM_COMMA = 0xBC ; ',<'
Global Const $VK_OEM_MINUS = 0xBD ; '-_'
Global Const $VK_OEM_PERIOD = 0xBE ; '.>'
Global Const $VK_OEM_2 = 0xBF ; '/?'
Global Const $VK_OEM_3 = 0xC0 ; '`~'
Global Const $VK_OEM_4 = 0xDB ; '[{'
Global Const $VK_OEM_5 = 0xDC ; '\|'
Global Const $VK_OEM_6 = 0xDD ; ']}'
Global Const $VK_OEM_7 = 0xDE ; ''"'
Global Const $VK_OEM_8 = 0xDF
Global Const $VK_OEM_102 = 0xE2
Global Const $VK_ATTN = 0xF6
Global Const $VK_CRSEL = 0xF7
Global Const $VK_EXSEL = 0xF8
Global Const $VK_EREOF = 0xF9
Global Const $VK_PLAY = 0xFA
Global Const $VK_ZOOM = 0xFB
Global Const $VK_NONAME = 0xFC
Global Const $VK_PA1 = 0xFD
Global Const $VK_OEM_CLEAR = 0xFE

#ce

; ===============================================================================================================================
; _WinAPI_LoadCursor()
; ===============================================================================================================================

#cs

Global Const $IDC_APPSTARTING = 32650
Global Const $IDC_HAND = 32649
Global Const $IDC_ARROW = 32512
Global Const $IDC_CROSS = 32515
Global Const $IDC_IBEAM = 32513
Global Const $IDC_ICON = 32641
Global Const $IDC_NO = 32648
Global Const $IDC_SIZE = 32640
Global Const $IDC_SIZEALL = 32646
Global Const $IDC_SIZENESW = 32643
Global Const $IDC_SIZENS = 32645
Global Const $IDC_SIZENWSE = 32642
Global Const $IDC_SIZEWE = 32644
Global Const $IDC_UPARROW = 32516
Global Const $IDC_WAIT = 32514

#ce

; ===============================================================================================================================
; _WinAPI_LoadIconWithScaleDown()
; ===============================================================================================================================

#cs

Global Const $IDI_APPLICATION = 32512
Global Const $IDI_ASTERISK = 32516
Global Const $IDI_EXCLAMATION = 32515
Global Const $IDI_HAND = 32513
Global Const $IDI_QUESTION = 32514
Global Const $IDI_SHIELD = 32518
Global Const $IDI_WINLOGO = 32517
Global Const $IDI_ERROR = $IDI_HAND
Global Const $IDI_INFORMATION = $IDI_ASTERISK
Global Const $IDI_WARNING = $IDI_EXCLAMATION

#ce

; ===============================================================================================================================
; _WinAPI_LookupPrivilegeValue()
; ===============================================================================================================================

#cs

Global Const $SE_ASSIGNPRIMARYTOKEN_NAME = 'SeAssignPrimaryTokenPrivilege'
Global Const $SE_AUDIT_NAME = 'SeAuditPrivilege'
Global Const $SE_BACKUP_NAME = 'SeBackupPrivilege'
Global Const $SE_CHANGE_NOTIFY_NAME = 'SeChangeNotifyPrivilege'
Global Const $SE_CREATE_GLOBAL_NAME = 'SeCreateGlobalPrivilege'
Global Const $SE_CREATE_PAGEFILE_NAME = 'SeCreatePagefilePrivilege'
Global Const $SE_CREATE_PERMANENT_NAME = 'SeCreatePermanentPrivilege'
Global Const $SE_CREATE_SYMBOLIC_LINK_NAME = 'SeCreateSymbolicLinkPrivilege'
Global Const $SE_CREATE_TOKEN_NAME = 'SeCreateTokenPrivilege'
Global Const $SE_DEBUG_NAME = 'SeDebugPrivilege'
Global Const $SE_ENABLE_DELEGATION_NAME = 'SeEnableDelegationPrivilege'
Global Const $SE_IMPERSONATE_NAME = 'SeImpersonatePrivilege'
Global Const $SE_INC_BASE_PRIORITY_NAME = 'SeIncreaseBasePriorityPrivilege'
Global Const $SE_INCREASE_QUOTA_NAME = 'SeIncreaseQuotaPrivilege'
Global Const $SE_INC_WORKING_SET_NAME = 'SeIncreaseWorkingSetPrivilege'
Global Const $SE_LOAD_DRIVER_NAME = 'SeLoadDriverPrivilege'
Global Const $SE_LOCK_MEMORY_NAME = 'SeLockMemoryPrivilege'
Global Const $SE_MACHINE_ACCOUNT_NAME = 'SeMachineAccountPrivilege'
Global Const $SE_MANAGE_VOLUME_NAME = 'SeManageVolumePrivilege'
Global Const $SE_PROF_SINGLE_PROCESS_NAME = 'SeProfileSingleProcessPrivilege'
Global Const $SE_RELABEL_NAME = 'SeRelabelPrivilege'
Global Const $SE_REMOTE_SHUTDOWN_NAME = 'SeRemoteShutdownPrivilege'
Global Const $SE_RESTORE_NAME = 'SeRestorePrivilege'
Global Const $SE_SECURITY_NAME = 'SeSecurityPrivilege'
Global Const $SE_SHUTDOWN_NAME = 'SeShutdownPrivilege'
Global Const $SE_SYNC_AGENT_NAME = 'SeSyncAgentPrivilege'
Global Const $SE_SYSTEM_ENVIRONMENT_NAME = 'SeSystemEnvironmentPrivilege'
Global Const $SE_SYSTEM_PROFILE_NAME = 'SeSystemProfilePrivilege'
Global Const $SE_SYSTEMTIME_NAME = 'SeSystemtimePrivilege'
Global Const $SE_TAKE_OWNERSHIP_NAME = 'SeTakeOwnershipPrivilege'
Global Const $SE_TCB_NAME = 'SeTcbPrivilege'
Global Const $SE_TIME_ZONE_NAME = 'SeTimeZonePrivilege'
Global Const $SE_TRUSTED_CREDMAN_ACCESS_NAME = 'SeTrustedCredManAccessPrivilege'
Global Const $SE_UNDOCK_NAME = 'SeUndockPrivilege'
Global Const $SE_UNSOLICITED_INPUT_NAME = 'SeUnsolicitedInputPrivilege'

#ce

; ===============================================================================================================================
; _WinAPI_MessageBoxCheck()
; ===============================================================================================================================

#cs

Global Const $MB_OK = 0
Global Const $MB_OKCANCEL = 1
Global Const $MB_YESNO = 4

Global Const $MB_ICONEXCLAMATION = 48
Global Const $MB_ICONHAND = 16
Global Const $MB_ICONINFORMATION = 64
Global Const $MB_ICONQUESTION = 32

Global Const $IDOK = 1
Global Const $IDCANCEL = 2
Global Const $IDYES = 6
Global Const $IDNO = 7

#ce

; ===============================================================================================================================
; _WinAPI_OpenJobObject(), _WinAPI_QueryInformationJobObject(), _WinAPI_SetInformationJobObject()
; ===============================================================================================================================

Global Const $JOB_OBJECT_ALL_ACCESS = 0x001F001F
Global Const $JOB_OBJECT_ASSIGN_PROCESS = 0x00000001
Global Const $JOB_OBJECT_QUERY = 0x00000004
Global Const $JOB_OBJECT_SET_ATTRIBUTES = 0x00000002
Global Const $JOB_OBJECT_SET_SECURITY_ATTRIBUTES = 0x00000010
Global Const $JOB_OBJECT_TERMINATE = 0x00000008

Global Const $JOB_OBJECT_LIMIT_ACTIVE_PROCESS = 0x00000008
Global Const $JOB_OBJECT_LIMIT_AFFINITY = 0x00000010
Global Const $JOB_OBJECT_LIMIT_BREAKAWAY_OK = 0x00000800
Global Const $JOB_OBJECT_LIMIT_DIE_ON_UNHANDLED_EXCEPTION = 0x00000400
Global Const $JOB_OBJECT_LIMIT_JOB_MEMORY = 0x00000200
Global Const $JOB_OBJECT_LIMIT_JOB_TIME = 0x00000004
Global Const $JOB_OBJECT_LIMIT_KILL_ON_JOB_CLOSE = 0x00002000
Global Const $JOB_OBJECT_LIMIT_PRESERVE_JOB_TIME = 0x00000040
Global Const $JOB_OBJECT_LIMIT_PRIORITY_CLASS = 0x00000020
Global Const $JOB_OBJECT_LIMIT_PROCESS_MEMORY = 0x00000100
Global Const $JOB_OBJECT_LIMIT_PROCESS_TIME = 0x00000002
Global Const $JOB_OBJECT_LIMIT_SCHEDULING_CLASS = 0x00000080
Global Const $JOB_OBJECT_LIMIT_SILENT_BREAKAWAY_OK = 0x00001000
Global Const $JOB_OBJECT_LIMIT_WORKINGSET = 0x00000001

Global Const $JOB_OBJECT_UILIMIT_DESKTOP = 0x00000040
Global Const $JOB_OBJECT_UILIMIT_DISPLAYSETTINGS = 0x00000010
Global Const $JOB_OBJECT_UILIMIT_EXITWINDOWS = 0x00000080
Global Const $JOB_OBJECT_UILIMIT_GLOBALATOMS = 0x00000020
Global Const $JOB_OBJECT_UILIMIT_HANDLES = 0x00000001
Global Const $JOB_OBJECT_UILIMIT_READCLIPBOARD = 0x00000002
Global Const $JOB_OBJECT_UILIMIT_SYSTEMPARAMETERS = 0x00000008
Global Const $JOB_OBJECT_UILIMIT_WRITECLIPBOARD = 0x00000004

Global Const $JOB_OBJECT_SECURITY_FILTER_TOKENS = 0x00000008
Global Const $JOB_OBJECT_SECURITY_NO_ADMIN = 0x00000001
Global Const $JOB_OBJECT_SECURITY_ONLY_TOKEN = 0x00000004
Global Const $JOB_OBJECT_SECURITY_RESTRICTED_TOKEN = 0x00000002

Global Const $JOB_OBJECT_TERMINATE_AT_END_OF_JOB = 0
Global Const $JOB_OBJECT_POST_AT_END_OF_JOB = 1

; ===============================================================================================================================
; _WinAPI_OpenProcessToken()
; ===============================================================================================================================

#cs

Global Const $TOKEN_ADJUST_DEFAULT = 0x00000080
Global Const $TOKEN_ADJUST_GROUPS = 0x00000040
Global Const $TOKEN_ADJUST_PRIVILEGES = 0x00000020
Global Const $TOKEN_ADJUST_SESSIONID = 0x00000100
Global Const $TOKEN_ASSIGN_PRIMARY = 0x00000001
Global Const $TOKEN_DUPLICATE = 0x00000002
Global Const $TOKEN_EXECUTE = 0x00020000
Global Const $TOKEN_IMPERSONATE = 0x00000004
Global Const $TOKEN_QUERY = 0x00000008
Global Const $TOKEN_QUERY_SOURCE = 0x00000010
Global Const $TOKEN_READ = 0x00020008
Global Const $TOKEN_WRITE = 0x000200E0
Global Const $TOKEN_ALL_ACCESS = 0x000F01FF

#ce

; ===============================================================================================================================
; _WinAPI_OpenSemaphore()
; ===============================================================================================================================

Global Const $SEMAPHORE_ALL_ACCESS = 0x001F0003
Global Const $SEMAPHORE_MODIFY_STATE = 0x00000002

; ===============================================================================================================================
; _WinAPI_PathGetCharType()
; ===============================================================================================================================

Global Const $GCT_INVALID = 0x00
Global Const $GCT_LFNCHAR = 0x01
Global Const $GCT_SEPARATOR = 0x08
Global Const $GCT_SHORTCHAR = 0x02
Global Const $GCT_WILD = 0x04

; ===============================================================================================================================
; _WinAPI_PlaySound()
; ===============================================================================================================================

Global Const $SND_APPLICATION = 0x00000080
Global Const $SND_ALIAS = 0x00010000
Global Const $SND_ALIAS_ID = 0x00110000
Global Const $SND_ASYNC = 0x00000001
Global Const $SND_FILENAME = 0x00020000
Global Const $SND_LOOP = 0x00000008
Global Const $SND_MEMORY = 0x00000004
Global Const $SND_NODEFAULT = 0x00000002
Global Const $SND_NOSTOP = 0x00000010
Global Const $SND_NOWAIT = 0x00002000
Global Const $SND_PURGE = 0x00000040
Global Const $SND_RESOURCE = 0x00040004
Global Const $SND_SYNC = 0x00000000

; *Windows Vista or above
Global Const $SND_SENTRY = 0x00080000
Global Const $SND_SYSTEM = 0x00200000

Global Const $SND_ALIAS_SYSTEMASTERISK = 'SystemAsterisk'
Global Const $SND_ALIAS_SYSTEMDEFAULT = 'SystemDefault'
Global Const $SND_ALIAS_SYSTEMEXCLAMATION = 'SystemExclamation'
Global Const $SND_ALIAS_SYSTEMEXIT = 'SystemExit'
Global Const $SND_ALIAS_SYSTEMHAND = 'SystemHand'
Global Const $SND_ALIAS_SYSTEMQUESTION = 'SystemQuestion'
Global Const $SND_ALIAS_SYSTEMSTART = 'SystemStart'
Global Const $SND_ALIAS_SYSTEMWELCOME = 'SystemWelcome'

; ===============================================================================================================================
; _WinAPI_RegisterHotKey()
; ===============================================================================================================================

Global Const $MOD_ALT = 0x0001
Global Const $MOD_CONTROL = 0x0002
Global Const $MOD_SHIFT = 0x0004
Global Const $MOD_WIN = 0x0008

; *Windows 7 or above
Global Const $MOD_NOREPEAT = 0x4000

; ===============================================================================================================================
; _WinAPI_RegisterShellHookWindow
; ===============================================================================================================================

Global Const $HSHELL_WINDOWCREATED = 1
Global Const $HSHELL_WINDOWDESTROYED = 2
Global Const $HSHELL_ACTIVATESHELLWINDOW = 3
Global Const $HSHELL_WINDOWACTIVATED = 4
Global Const $HSHELL_GETMINRECT = 5
Global Const $HSHELL_REDRAW = 6
Global Const $HSHELL_TASKMAN = 7
Global Const $HSHELL_LANGUAGE = 8
Global Const $HSHELL_SYSMENU = 9
Global Const $HSHELL_ENDTASK = 10
Global Const $HSHELL_ACCESSIBILITYSTATE = 11
Global Const $HSHELL_APPCOMMAND = 12
Global Const $HSHELL_WINDOWREPLACED = 13
Global Const $HSHELL_WINDOWREPLACING = 14
Global Const $HSHELL_RUDEAPPACTIVATED = 32772
Global Const $HSHELL_FLASH = 32774

; ===============================================================================================================================
; _WinAPI_Reg...
; ===============================================================================================================================

Global Const $HKEY_CLASSES_ROOT = 0x80000000
Global Const $HKEY_CURRENT_CONFIG = 0x80000005
Global Const $HKEY_CURRENT_USER = 0x80000001
Global Const $HKEY_LOCAL_MACHINE = 0x80000002
Global Const $HKEY_PERFORMANCE_DATA = 0x80000004
Global Const $HKEY_PERFORMANCE_NLSTEXT = 0x80000060
Global Const $HKEY_PERFORMANCE_TEXT = 0x80000050
Global Const $HKEY_USERS = 0x80000003

Global Const $KEY_ALL_ACCESS = 0xF003F
Global Const $KEY_CREATE_LINK = 0x0020
Global Const $KEY_CREATE_SUB_KEY = 0x0004
Global Const $KEY_ENUMERATE_SUB_KEYS = 0x0008
Global Const $KEY_EXECUTE = 0x20019
Global Const $KEY_NOTIFY = 0x0010
Global Const $KEY_QUERY_VALUE = 0x0001
Global Const $KEY_READ = 0x20019
Global Const $KEY_SET_VALUE = 0x0002
Global Const $KEY_WOW64_32KEY = 0x0200
Global Const $KEY_WOW64_64KEY = 0x0100
Global Const $KEY_WRITE = 0x20006

Global Const $REG_OPTION_BACKUP_RESTORE = 0x04
Global Const $REG_OPTION_CREATE_LINK = 0x02
Global Const $REG_OPTION_NON_VOLATILE = 0x00
Global Const $REG_OPTION_VOLATILE = 0x01

#cs

Global Const $REG_BINARY = 3
Global Const $REG_DWORD = 4
Global Const $REG_DWORD_BIG_ENDIAN = 5
Global Const $REG_DWORD_LITTLE_ENDIAN = 4
Global Const $REG_EXPAND_SZ = 2
Global Const $REG_LINK = 6
Global Const $REG_MULTI_SZ = 7
Global Const $REG_NONE = 0
Global Const $REG_QWORD = 11
Global Const $REG_QWORD_LITTLE_ENDIAN = 11
Global Const $REG_SZ = 1

#ce

; ===============================================================================================================================
; _WinAPI_RestartDlg()
; ===============================================================================================================================

Global Const $EWX_LOGOFF = 0
Global Const $EWX_POWEROFF = 8
Global Const $EWX_REBOOT = 2
Global Const $EWX_SHUTDOWN = 1
Global Const $EWX_FORCE = 4
Global Const $EWX_FORCEIFHUNG = 16

; ===============================================================================================================================
; _WinAPI_SendMessageTimeout()
; ===============================================================================================================================

Global Const $SMTO_BLOCK = 0x0001
Global Const $SMTO_NORMAL = 0x0000
Global Const $SMTO_ABORTIFHUNG = 0x0002
Global Const $SMTO_NOTIMEOUTIFNOTHUNG = 0x0008
Global Const $SMTO_ERRORONEXIT = 0x0020

; ===============================================================================================================================
; _WinAPI_SetSystemCursor()
; ===============================================================================================================================

#cs

Global Const $OCR_APPSTARTING = 32650
Global Const $OCR_NORMAL = 32512
Global Const $OCR_CROSS = 32515
Global Const $OCR_HAND = 32649
Global Const $OCR_IBEAM = 32513
Global Const $OCR_NO = 32648
Global Const $OCR_SIZEALL = 32646
Global Const $OCR_SIZENESW = 32643
Global Const $OCR_SIZENS = 32645
Global Const $OCR_SIZENWSE = 32642
Global Const $OCR_SIZEWE = 32644
Global Const $OCR_UP = 32516
Global Const $OCR_WAIT = 32514
Global Const $OCR_ICON = 32641
Global Const $OCR_SIZE = 32640

#ce

; ===============================================================================================================================
; _WinAPI_ShellChangeNotify()
; ===============================================================================================================================

Global Const $SHCNE_ALLEVENTS = 0x7FFFFFFF
Global Const $SHCNE_ASSOCCHANGED = 0x8000000
Global Const $SHCNE_ATTRIBUTES = 0x00000800
Global Const $SHCNE_CREATE = 0x00000002
Global Const $SHCNE_DELETE = 0x00000004
Global Const $SHCNE_DRIVEADD = 0x00000100
Global Const $SHCNE_DRIVEADDGUI = 0x00010000
Global Const $SHCNE_DRIVEREMOVED = 0x00000080
Global Const $SHCNE_EXTENDED_EVENT = 0x04000000
Global Const $SHCNE_FREESPACE = 0x00040000
Global Const $SHCNE_MEDIAINSERTED = 0x00000020
Global Const $SHCNE_MEDIAREMOVED = 0x00000040
Global Const $SHCNE_MKDIR = 0x00000008
Global Const $SHCNE_NETSHARE = 0x00000200
Global Const $SHCNE_NETUNSHARE = 0x00000400
Global Const $SHCNE_RENAMEFOLDER = 0x00020000
Global Const $SHCNE_RENAMEITEM = 0x00000001
Global Const $SHCNE_RMDIR = 0x00000010
Global Const $SHCNE_SERVERDISCONNECT = 0x00004000
Global Const $SHCNE_UPDATEDIR = 0x00001000
Global Const $SHCNE_UPDATEIMAGE = 0x00008000
Global Const $SHCNE_UPDATEITEM = 0x00002000
Global Const $SHCNE_DISKEVENTS = 0x0002381F
Global Const $SHCNE_GLOBALEVENTS = 0x0C0581E0
Global Const $SHCNE_INTERRUPT = 0x80000000

Global Const $SHCNF_DWORD = 0x00000003
Global Const $SHCNF_IDLIST = 0x00000000
Global Const $SHCNF_PATH = 0x00000001
Global Const $SHCNF_PRINTER = 0x00000002
Global Const $SHCNF_FLUSH = 0x00001000
Global Const $SHCNF_FLUSHNOWAIT = 0x00002000
Global Const $SHCNF_NOTIFYRECURSIVE = 0x00010000

; ===============================================================================================================================
; _WinAPI_ShellChangeNotifyRegister()
; ===============================================================================================================================

Global Const $SHCNRF_INTERRUPTLEVEL = 0x0001
Global Const $SHCNRF_SHELLLEVEL = 0x0002
Global Const $SHCNRF_RECURSIVEINTERRUPT = 0x1000
Global Const $SHCNRF_NEWDELIVERY = 0x8000

; ===============================================================================================================================
; _WinAPI_ShellEmptyRecycleBin()
; ===============================================================================================================================

Global Const $SHERB_NOCONFIRMATION = 0x01
Global Const $SHERB_NOPROGRESSUI = 0x02
Global Const $SHERB_NOSOUND = 0x04
Global Const $SHERB_NO_UI = BitOR($SHERB_NOCONFIRMATION, $SHERB_NOPROGRESSUI, $SHERB_NOSOUND)

; ===============================================================================================================================
; _WinAPI_ShellFileOperation()
; ===============================================================================================================================

Global Const $FO_COPY = 2
Global Const $FO_DELETE = 3
Global Const $FO_MOVE = 1
Global Const $FO_RENAME = 4

Global Const $FOF_ALLOWUNDO = 0x0040
Global Const $FOF_CONFIRMMOUSE = 0x0002
Global Const $FOF_FILESONLY = 0x0080
Global Const $FOF_MULTIDESTFILES = 0x0001
Global Const $FOF_NOCONFIRMATION = 0x0010
Global Const $FOF_NOCONFIRMMKDIR = 0x0200
Global Const $FOF_NO_CONNECTED_ELEMENTS = 0x2000
Global Const $FOF_NOCOPYSECURITYATTRIBS = 0x0800
Global Const $FOF_NOERRORUI = 0x0400
Global Const $FOF_NORECURSEREPARSE = 0x8000
Global Const $FOF_NORECURSION = 0x1000
Global Const $FOF_RENAMEONCOLLISION = 0x0008
Global Const $FOF_SILENT = 0x0004
Global Const $FOF_SIMPLEPROGRESS = 0x0100
Global Const $FOF_WANTMAPPINGHANDLE = 0x0020
Global Const $FOF_WANTNUKEWARNING = 0x4000
Global Const $FOF_NO_UI = BitOR($FOF_NOCONFIRMATION, $FOF_NOCONFIRMMKDIR, $FOF_NOERRORUI, $FOF_SILENT)

; ===============================================================================================================================
; _WinAPI_ShellGetFileInfo()
; ===============================================================================================================================

Global Const $SHGFI_ATTR_SPECIFIED = 0x00020000
Global Const $SHGFI_ATTRIBUTES = 0x00000800
Global Const $SHGFI_DISPLAYNAME = 0x00000200
Global Const $SHGFI_EXETYPE = 0x00002000
Global Const $SHGFI_ICON = 0x00000100
Global Const $SHGFI_ICONLOCATION = 0x00001000
Global Const $SHGFI_LARGEICON = 0x00000000
Global Const $SHGFI_LINKOVERLAY = 0x00008000
Global Const $SHGFI_OPENICON = 0x00000002
Global Const $SHGFI_OVERLAYINDEX = 0x00000040
Global Const $SHGFI_PIDL = 0x00000008
Global Const $SHGFI_SELECTED = 0x00010000
Global Const $SHGFI_SHELLICONSIZE = 0x00000004
Global Const $SHGFI_SMALLICON = 0x00000001
Global Const $SHGFI_SYSICONINDEX = 0x00004000
Global Const $SHGFI_TYPENAME = 0x00000400
Global Const $SHGFI_USEFILEATTRIBUTES = 0x00000010

; ===============================================================================================================================
; _WinAPI_ShellGetKnownFolderPath()
; ===============================================================================================================================

Global Const $FOLDERID_AddNewPrograms = '{DE61D971-5EBC-4F02-A3A9-6C82895E5C04}'
Global Const $FOLDERID_AdminTools = '{724EF170-A42D-4FEF-9F26-B60E846FBA4F}'
Global Const $FOLDERID_AppUpdates = '{A305CE99-F527-492B-8B1A-7E76FA98D6E4}'
Global Const $FOLDERID_CDBurning = '{9E52AB10-F80D-49DF-ACB8-4330F5687855}'
Global Const $FOLDERID_ChangeRemovePrograms = '{DF7266AC-9274-4867-8D55-3BD661DE872D}'
Global Const $FOLDERID_CommonAdminTools = '{D0384E7D-BAC3-4797-8F14-CBA229B392B5}'
Global Const $FOLDERID_CommonOEMLinks = '{C1BAE2D0-10DF-4334-BEDD-7AA20B227A9D}'
Global Const $FOLDERID_CommonPrograms = '{0139D44E-6AFE-49F2-8690-3DAFCAE6FFB8}'
Global Const $FOLDERID_CommonStartMenu = '{A4115719-D62E-491D-AA7C-E74B8BE3B067}'
Global Const $FOLDERID_CommonStartup = '{82A5EA35-D9CD-47C5-9629-E15D2F714E6E}'
Global Const $FOLDERID_CommonTemplates = '{B94237E7-57AC-4347-9151-B08C6C32D1F7}'
Global Const $FOLDERID_ComputerFolder = '{0AC0837C-BBF8-452A-850D-79D08E667CA7}'
Global Const $FOLDERID_ConflictFolder = '{4BFEFB45-347D-4006-A5BE-AC0CB0567192}'
Global Const $FOLDERID_ConnectionsFolder = '{6F0CD92B-2E97-45D1-88FF-B0D186B8DEDD}'
Global Const $FOLDERID_Contacts = '{56784854-C6CB-462B-8169-88E350ACB882}'
Global Const $FOLDERID_ControlPanelFolder = '{82A74AEB-AEB4-465C-A014-D097EE346D63}'
Global Const $FOLDERID_Cookies = '{2B0F765D-C0E9-4171-908E-08A611B84FF6}'
Global Const $FOLDERID_Desktop = '{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}'
Global Const $FOLDERID_DeviceMetadataStore = '{5CE4A5E9-E4EB-479D-B89F-130C02886155}'
Global Const $FOLDERID_DocumentsLibrary = '{7B0DB17D-9CD2-4A93-9733-46CC89022E7C}'
Global Const $FOLDERID_Downloads = '{374DE290-123F-4565-9164-39C4925E467B}'
Global Const $FOLDERID_Favorites = '{1777F761-68AD-4D8A-87BD-30B759FA33DD}'
Global Const $FOLDERID_Fonts = '{FD228CB7-AE11-4AE3-864C-16F3910AB8FE}'
Global Const $FOLDERID_Games = '{CAC52C1A-B53D-4EDC-92D7-6B2E8AC19434}'
Global Const $FOLDERID_GameTasks = '{054FAE61-4DD8-4787-80B6-090220C4B700}'
Global Const $FOLDERID_History = '{D9DC8A3B-B784-432E-A781-5A1130A75963}'
Global Const $FOLDERID_HomeGroup = '{52528A6B-B9E3-4ADD-B60D-588C2DBA842D}'
Global Const $FOLDERID_ImplicitAppShortcuts = '{BCB5256F-79F6-4CEE-B725-DC34E402FD46}'
Global Const $FOLDERID_InternetCache = '{352481E8-33BE-4251-BA85-6007CAEDCF9D}'
Global Const $FOLDERID_InternetFolder = '{4D9F7874-4E0C-4904-967B-40B0D20C3E4B}'
Global Const $FOLDERID_Libraries = '{1B3EA5DC-B587-4786-B4EF-BD1DC332AEAE}'
Global Const $FOLDERID_Links = '{BFB9D5E0-C6A9-404C-B2B2-AE6DB6AF4968}'
Global Const $FOLDERID_LocalAppData = '{F1B32785-6FBA-4FCF-9D55-7B8E7F157091}'
Global Const $FOLDERID_LocalAppDataLow = '{A520A1A4-1780-4FF6-BD18-167343C5AF16}'
Global Const $FOLDERID_LocalizedResourcesDir = '{2A00375E-224C-49DE-B8D1-440DF7EF3DDC}'
Global Const $FOLDERID_Music = '{4BD8D571-6D19-48D3-BE97-422220080E43}'
Global Const $FOLDERID_MusicLibrary = '{2112AB0A-C86A-4FFE-A368-0DE96E47012E}'
Global Const $FOLDERID_NetHood = '{C5ABBF53-E17F-4121-8900-86626FC2C973}'
Global Const $FOLDERID_NetworkFolder = '{D20BEEC4-5CA8-4905-AE3B-BF251EA09B53}'
Global Const $FOLDERID_OriginalImages = '{2C36C0AA-5812-4B87-BFD0-4CD0DFB19B39}'
Global Const $FOLDERID_PhotoAlbums = '{69D2CF90-FC33-4FB7-9A0C-EBB0F0FCB43C}'
Global Const $FOLDERID_PicturesLibrary = '{A990AE9F-A03B-4E80-94BC-9912D7504104}'
Global Const $FOLDERID_Pictures = '{33E28130-4E1E-4676-835A-98395C3BC3BB}'
Global Const $FOLDERID_Playlists = '{DE92C1C7-837F-4F69-A3BB-86E631204A23}'
Global Const $FOLDERID_PrintersFolder = '{76FC4E2D-D6AD-4519-A663-37BD56068185}'
Global Const $FOLDERID_PrintHood = '{9274BD8D-CFD1-41C3-B35E-B13F55A758F4}'
Global Const $FOLDERID_Profile = '{5E6C858F-0E22-4760-9AFE-EA3317B67173}'
Global Const $FOLDERID_ProgramData = '{62AB5D82-FDC1-4DC3-A9DD-070D1D495D97}'
Global Const $FOLDERID_ProgramFiles = '{905E63B6-C1BF-494E-B29C-65B732D3D21A}'
Global Const $FOLDERID_ProgramFilesX64 = '{6D809377-6AF0-444B-8957-A3773F02200E}'
Global Const $FOLDERID_ProgramFilesX86 = '{7C5A40EF-A0FB-4BFC-874A-C0F2E0B9FA8E}'
Global Const $FOLDERID_ProgramFilesCommon = '{F7F1ED05-9F6D-47A2-AAAE-29D317C6F066}'
Global Const $FOLDERID_ProgramFilesCommonX64 = '{6365D5A7-0F0D-45E5-87F6-0DA56B6A4F7D}'
Global Const $FOLDERID_ProgramFilesCommonX86 = '{DE974D24-D9C6-4D3E-BF91-F4455120B917}'
Global Const $FOLDERID_Programs = '{A77F5D77-2E2B-44C3-A6A2-ABA601054A51}'
Global Const $FOLDERID_Public = '{DFDF76A2-C82A-4D63-906A-5644AC457385}'
Global Const $FOLDERID_PublicDesktop = '{C4AA340D-F20F-4863-AFEF-F87EF2E6BA25}'
Global Const $FOLDERID_PublicDocuments = '{ED4824AF-DCE4-45A8-81E2-FC7965083634}'
Global Const $FOLDERID_PublicDownloads = '{3D644C9B-1FB8-4F30-9B45-F670235F79C0}'
Global Const $FOLDERID_PublicGameTasks = '{DEBF2536-E1A8-4C59-B6A2-414586476AEA}'
Global Const $FOLDERID_PublicLibraries = '{48DAF80B-E6CF-4F4E-B800-0E69D84EE384}'
Global Const $FOLDERID_PublicMusic = '{3214FAB5-9757-4298-BB61-92A9DEAA44FF}'
Global Const $FOLDERID_PublicPictures = '{B6EBFB86-6907-413C-9AF7-4FC2ABF07CC5}'
Global Const $FOLDERID_PublicRingtones = '{E555AB60-153B-4D17-9F04-A5FE99FC15EC}'
Global Const $FOLDERID_PublicVideos = '{2400183A-6185-49FB-A2D8-4A392A602BA3}'
Global Const $FOLDERID_QuickLaunch = '{52A4F021-7B75-48A9-9F6B-4B87A210BC8F}'
Global Const $FOLDERID_Recent = '{AE50C081-EBD2-438A-8655-8A092E34987A}'
Global Const $FOLDERID_RecordedTVLibrary = '{1A6FDBA2-F42D-4358-A798-B74D745926C5}'
Global Const $FOLDERID_RecycleBinFolder = '{B7534046-3ECB-4C18-BE4E-64CD4CB7D6AC}'
Global Const $FOLDERID_ResourceDir = '{8AD10C31-2ADB-4296-A8F7-E4701232C972}'
Global Const $FOLDERID_Ringtones = '{C870044B-F49E-4126-A9C3-B52A1FF411E8}'
Global Const $FOLDERID_RoamingAppData = '{3EB685DB-65F9-4CF6-A03A-E3EF65729F3D}'
Global Const $FOLDERID_SampleMusic = '{B250C668-F57D-4EE1-A63C-290EE7D1AA1F}'
Global Const $FOLDERID_SamplePictures = '{C4900540-2379-4C75-844B-64E6FAF8716B}'
Global Const $FOLDERID_SamplePlaylists = '{15CA69B3-30EE-49C1-ACE1-6B5EC372AFB5}'
Global Const $FOLDERID_SampleVideos = '{859EAD94-2E85-48AD-A71A-0969CB56A6CD}'
Global Const $FOLDERID_SavedGames = '{4C5C32FF-BB9D-43B0-B5B4-2D72E54EAAA4}'
Global Const $FOLDERID_SavedSearches = '{7D1D3A04-DEBB-4115-95CF-2F29DA2920DA}'
Global Const $FOLDERID_SEARCH_CSC = '{EE32E446-31CA-4ABA-814F-A5EBD2FD6D5E}'
Global Const $FOLDERID_SEARCH_MAPI = '{98EC0E18-2098-4D44-8644-66979315A281}'
Global Const $FOLDERID_SearchHome = '{190337D1-B8CA-4121-A639-6D472D16972A}'
Global Const $FOLDERID_SendTo = '{8983036C-27C0-404B-8F08-102D10DCFD74}'
Global Const $FOLDERID_SidebarDefaultParts = '{7B396E54-9EC5-4300-BE0A-2482EBAE1A26}'
Global Const $FOLDERID_SidebarParts = '{A75D362E-50FC-4FB7-AC2C-A8BEAA314493}'
Global Const $FOLDERID_StartMenu = '{625B53C3-AB48-4EC1-BA1F-A1EF4146FC19}'
Global Const $FOLDERID_Startup = '{B97D20BB-F46A-4C97-BA10-5E3608430854}'
Global Const $FOLDERID_SyncManagerFolder = '{43668BF8-C14E-49B2-97C9-747784D784B7}'
Global Const $FOLDERID_SyncResultsFolder = '{289A9A43-BE44-4057-A41B-587A76D7E7F9}'
Global Const $FOLDERID_SyncSetupFolder = '{0F214138-B1D3-4A90-BBA9-27CBC0C5389A}'
Global Const $FOLDERID_System = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}'
Global Const $FOLDERID_SystemX86 = '{D65231B0-B2F1-4857-A4CE-A8E7C6EA7D27}'
Global Const $FOLDERID_Templates = '{A63293E8-664E-48DB-A079-DF759E0509F7}'
Global Const $FOLDERID_UserPinned = '{9E3995AB-1F9C-4F13-B827-48B24B6C7174}'
Global Const $FOLDERID_UserProfiles = '{0762D272-C50A-4BB0-A382-697DCD729B80}'
Global Const $FOLDERID_UserProgramFiles = '{5CD7AEE2-2219-4A67-B85D-6C9CE15660CB}'
Global Const $FOLDERID_UserProgramFilesCommon = '{BCBD3057-CA5C-4622-B42D-BC56DB0AE516}'
Global Const $FOLDERID_UsersFiles = '{F3CE0F7C-4901-4ACC-8648-D5D44B04EF8F}'
Global Const $FOLDERID_UsersLibraries = '{A302545D-DEFF-464B-ABE8-61C8648D939B}'
Global Const $FOLDERID_Videos = '{18989B1D-99B5-455B-841C-AB7C74E4DDFC}'
Global Const $FOLDERID_VideosLibrary = '{491E922F-5643-4AF4-A7EB-4E7A138D8174}'
Global Const $FOLDERID_Windows = '{F38BF404-1D43-42F2-9305-67DE0B28FC23}'

Global Const $KF_FLAG_CREATE = 0x00008000
Global Const $KF_FLAG_DONT_VERIFY = 0x00004000
Global Const $KF_FLAG_DONT_UNEXPAND = 0x00002000
Global Const $KF_FLAG_NO_ALIAS = 0x00001000
Global Const $KF_FLAG_INIT = 0x00000800
Global Const $KF_FLAG_DEFAULT_PATH = 0x00000400
Global Const $KF_FLAG_NOT_PARENT_RELATIVE = 0x00000200
Global Const $KF_FLAG_SIMPLE_IDLIST = 0x00000100

; *Windows 7 or above
Global Const $KF_FLAG_ALIAS_ONLY = 0x80000000

; ===============================================================================================================================
; _WinAPI_ShellGetSettings(), _WinAPI_ShellSetSettings()
; ===============================================================================================================================

Global Const $SSF_SHOWALLOBJECTS = 0x00000001
Global Const $SSF_SHOWEXTENSIONS = 0x00000002
Global Const $SSF_SHOWCOMPCOLOR = 0x00000008
Global Const $SSF_SHOWSYSFILES = 0x00000020
Global Const $SSF_DOUBLECLICKINWEBVIEW = 0x00000080
Global Const $SSF_DESKTOPHTML = 0x00000200
Global Const $SSF_WIN95CLASSIC = 0x00000400
Global Const $SSF_DONTPRETTYPATH = 0x00000800
Global Const $SSF_MAPNETDRVBUTTON = 0x00001000
Global Const $SSF_SHOWINFOTIP = 0x00002000
Global Const $SSF_HIDEICONS = 0x00004000
Global Const $SSF_NOCONFIRMRECYCLE = 0x00008000
Global Const $SSF_WEBVIEW = 0x00020000
Global Const $SSF_SHOWSUPERHIDDEN = 0x00040000
Global Const $SSF_SEPPROCESS = 0x00080000
Global Const $SSF_NONETCRAWLING = 0x00100000
Global Const $SSF_STARTPANELON = 0x00200000

; *Windows Vista or above
Global Const $SSF_AUTOCHECKSELECT = 0x00800000
Global Const $SSF_ICONSONLY = 0x01000000
Global Const $SSF_SHOWTYPEOVERLAY = 0x02000000

; ===============================================================================================================================
; _WinAPI_ShellGetSpecialFolderPath()
; ===============================================================================================================================

Global Const $CSIDL_ADMINTOOLS = 0x0030
Global Const $CSIDL_ALTSTARTUP = 0x001D
Global Const $CSIDL_APPDATA = 0x001A
Global Const $CSIDL_BITBUCKET = 0x000A
Global Const $CSIDL_CDBURN_AREA = 0x003B
Global Const $CSIDL_COMMON_ADMINTOOLS = 0x002F
Global Const $CSIDL_COMMON_ALTSTARTUP = 0x001E
Global Const $CSIDL_COMMON_APPDATA = 0x0023
Global Const $CSIDL_COMMON_DESKTOPDIRECTORY = 0x0019
Global Const $CSIDL_COMMON_DOCUMENTS = 0x002E
Global Const $CSIDL_COMMON_FAVORITES = 0x001F
Global Const $CSIDL_COMMON_MUSIC = 0x0035
Global Const $CSIDL_COMMON_PICTURES = 0x0036
Global Const $CSIDL_COMMON_PROGRAMS = 0x0017
Global Const $CSIDL_COMMON_STARTMENU = 0x0016
Global Const $CSIDL_COMMON_STARTUP = 0x0018
Global Const $CSIDL_COMMON_TEMPLATES = 0x002D
Global Const $CSIDL_COMMON_VIDEO = 0x0037
Global Const $CSIDL_COMPUTERSNEARME = 0x003D
Global Const $CSIDL_CONNECTIONS = 0x0031
Global Const $CSIDL_CONTROLS = 0x0003
Global Const $CSIDL_COOKIES = 0x0021
Global Const $CSIDL_DESKTOP = 0x0000
Global Const $CSIDL_DESKTOPDIRECTORY = 0x0010
Global Const $CSIDL_DRIVES = 0x0011
Global Const $CSIDL_FAVORITES = 0x0006
Global Const $CSIDL_FONTS = 0x0014
Global Const $CSIDL_INTERNET_CACHE = 0x0020
Global Const $CSIDL_HISTORY = 0x0022
Global Const $CSIDL_LOCAL_APPDATA = 0x001C
Global Const $CSIDL_MYMUSIC = 0x000D
Global Const $CSIDL_MYPICTURES = 0x0027
Global Const $CSIDL_MYVIDEO = 0x000E
Global Const $CSIDL_NETHOOD = 0x0013
Global Const $CSIDL_PERSONAL = 0x0005
Global Const $CSIDL_PRINTERS = 0x0004
Global Const $CSIDL_PRINTHOOD = 0x001B
Global Const $CSIDL_PROFILE = 0x0028
Global Const $CSIDL_PROGRAM_FILES = 0x0026
Global Const $CSIDL_PROGRAM_FILES_COMMON = 0x002B
Global Const $CSIDL_PROGRAM_FILES_COMMONX86 = 0x002C
Global Const $CSIDL_PROGRAM_FILESX86 = 0x002A
Global Const $CSIDL_PROGRAMS = 0x0002
Global Const $CSIDL_RECENT = 0x0008
Global Const $CSIDL_SENDTO = 0x0009
Global Const $CSIDL_STARTMENU = 0x000B
Global Const $CSIDL_STARTUP = 0x0007
Global Const $CSIDL_SYSTEM = 0x0025
Global Const $CSIDL_SYSTEMX86 = 0x0029
Global Const $CSIDL_TEMPLATES = 0x0015
Global Const $CSIDL_WINDOWS = 0x0024

; ===============================================================================================================================
; _WinAPI_ShellGetStockIconInfo()
; ===============================================================================================================================

Global Const $SIID_DOCNOASSOC = 0
Global Const $SIID_DOCASSOC = 1
Global Const $SIID_APPLICATION = 2
Global Const $SIID_FOLDER = 3
Global Const $SIID_FOLDEROPEN = 4
Global Const $SIID_DRIVE525 = 5
Global Const $SIID_DRIVE35 = 6
Global Const $SIID_DRIVEREMOVE = 7
Global Const $SIID_DRIVEFIXED = 8
Global Const $SIID_DRIVENET = 9
Global Const $SIID_DRIVENETDISABLED = 10
Global Const $SIID_DRIVECD = 11
Global Const $SIID_DRIVERAM = 12
Global Const $SIID_WORLD = 13
Global Const $SIID_SERVER = 15
Global Const $SIID_PRINTER = 16
Global Const $SIID_MYNETWORK = 17
Global Const $SIID_FIND = 22
Global Const $SIID_HELP = 23
Global Const $SIID_SHARE = 28
Global Const $SIID_LINK = 29
Global Const $SIID_SLOWFILE = 30
Global Const $SIID_RECYCLER = 31
Global Const $SIID_RECYCLERFULL = 32
Global Const $SIID_MEDIACDAUDIO = 40
Global Const $SIID_LOCK = 47
Global Const $SIID_AUTOLIST = 49
Global Const $SIID_PRINTERNET = 50
Global Const $SIID_SERVERSHARE = 51
Global Const $SIID_PRINTERFAX = 52
Global Const $SIID_PRINTERFAXNET = 53
Global Const $SIID_PRINTERFILE = 54
Global Const $SIID_STACK = 55
Global Const $SIID_MEDIASVCD = 56
Global Const $SIID_STUFFEDFOLDER = 57
Global Const $SIID_DRIVEUNKNOWN = 58
Global Const $SIID_DRIVEDVD = 59
Global Const $SIID_MEDIADVD = 60
Global Const $SIID_MEDIADVDRAM = 61
Global Const $SIID_MEDIADVDRW = 62
Global Const $SIID_MEDIADVDR = 63
Global Const $SIID_MEDIADVDROM = 64
Global Const $SIID_MEDIACDAUDIOPLUS = 65
Global Const $SIID_MEDIACDRW = 66
Global Const $SIID_MEDIACDR = 67
Global Const $SIID_MEDIACDBURN = 68
Global Const $SIID_MEDIABLANKCD = 69
Global Const $SIID_MEDIACDROM = 70
Global Const $SIID_AUDIOFILES = 71
Global Const $SIID_IMAGEFILES = 72
Global Const $SIID_VIDEOFILES = 73
Global Const $SIID_MIXEDFILES = 74
Global Const $SIID_FOLDERBACK = 75
Global Const $SIID_FOLDERFRONT = 76
Global Const $SIID_SHIELD = 77
Global Const $SIID_WARNING = 78
Global Const $SIID_INFO = 79
Global Const $SIID_ERROR = 80
Global Const $SIID_KEY = 81
Global Const $SIID_SOFTWARE = 82
Global Const $SIID_RENAME = 83
Global Const $SIID_DELETE = 84
Global Const $SIID_MEDIAAUDIODVD = 85
Global Const $SIID_MEDIAMOVIEDVD = 86
Global Const $SIID_MEDIAENHANCEDCD = 87
Global Const $SIID_MEDIAENHANCEDDVD = 88
Global Const $SIID_MEDIAHDDVD = 89
Global Const $SIID_MEDIABLURAY = 90
Global Const $SIID_MEDIAVCD = 91
Global Const $SIID_MEDIADVDPLUSR = 92
Global Const $SIID_MEDIADVDPLUSRW = 93
Global Const $SIID_DESKTOPPC = 94
Global Const $SIID_MOBILEPC = 95
Global Const $SIID_USERS = 96
Global Const $SIID_MEDIASMARTMEDIA = 97
Global Const $SIID_MEDIACOMPACTFLASH = 98
Global Const $SIID_DEVICECELLPHONE = 99
Global Const $SIID_DEVICECAMERA = 100
Global Const $SIID_DEVICEVIDEOCAMERA = 101
Global Const $SIID_DEVICEAUDIOPLAYER = 102
Global Const $SIID_NETWORKCONNECT = 103
Global Const $SIID_INTERNET = 104
Global Const $SIID_ZIPFILE = 105
Global Const $SIID_SETTINGS = 106
Global Const $SIID_DRIVEHDDVD = 132
Global Const $SIID_DRIVEBD = 133
Global Const $SIID_MEDIAHDDVDROM = 134
Global Const $SIID_MEDIAHDDVDR = 135
Global Const $SIID_MEDIAHDDVDRAM = 136
Global Const $SIID_MEDIABDROM = 137
Global Const $SIID_MEDIABDR = 138
Global Const $SIID_MEDIABDRE = 139
Global Const $SIID_CLUSTEREDDRIVE = 140
Global Const $SIID_MAX_ICONS = 174

Global Const $SHGSI_ICONLOCATION = 0
Global Const $SHGSI_ICON = $SHGFI_ICON
Global Const $SHGSI_SYSICONINDEX = $SHGFI_SYSICONINDEX
Global Const $SHGSI_LINKOVERLAY = $SHGFI_LINKOVERLAY
Global Const $SHGSI_SELECTED = $SHGFI_SELECTED
Global Const $SHGSI_LARGEICON = $SHGFI_LARGEICON
Global Const $SHGSI_SMALLICON = $SHGFI_SMALLICON
Global Const $SHGSI_SHELLICONSIZE = $SHGFI_SHELLICONSIZE

; ===============================================================================================================================
; _WinAPI_ShellNotifyIcon()
; ===============================================================================================================================

Global Const $NIM_ADD = 0x00
Global Const $NIM_MODIFY = 0x01
Global Const $NIM_DELETE = 0x02
Global Const $NIM_SETFOCUS = 0x03
Global Const $NIM_SETVERSION = 0x04

Global Const $NIF_MESSAGE = 0x01
Global Const $NIF_ICON = 0x02
Global Const $NIF_TIP = 0x04
Global Const $NIF_STATE = 0x08
Global Const $NIF_INFO = 0x10
Global Const $NIF_GUID = 0x20
Global Const $NIF_REALTIME = 0x40
Global Const $NIF_SHOWTIP = 0x80

Global Const $NIS_HIDDEN = 0x01
Global Const $NIS_SHAREDICON = 0x02

Global Const $NIIF_NONE = 0x00
Global Const $NIIF_INFO = 0x01
Global Const $NIIF_WARNING = 0x02
Global Const $NIIF_ERROR = 0x03
Global Const $NIIF_USER = 0x04
Global Const $NIIF_NOSOUND = 0x10
Global Const $NIIF_LARGE_ICON = 0x10
Global Const $NIIF_RESPECT_QUIET_TIME = 0x80
Global Const $NIIF_ICON_MASK = 0x0F

; ===============================================================================================================================
; _WinAPI_ShellObjectProperties()
; ===============================================================================================================================

Global Const $SHOP_PRINTERNAME = 1
Global Const $SHOP_FILEPATH = 2
Global Const $SHOP_VOLUMEGUID = 4

; ===============================================================================================================================
; _WinAPI_ShellOpenWithDlg()
; ===============================================================================================================================

Global Const $OAIF_ALLOW_REGISTRATION = 0x00000001
Global Const $OAIF_REGISTER_EXT = 0x00000002
Global Const $OAIF_EXEC = 0x00000004
Global Const $OAIF_FORCE_REGISTRATION = 0x00000008
Global Const $OAIF_HIDE_REGISTRATION = 0x00000020
Global Const $OAIF_URL_PROTOCOL = 0x00000040

; ===============================================================================================================================
; _WinAPI_PatBlt(), _WinAPI_StretchBlt()
; ===============================================================================================================================

#cs

Global Const $BLACKNESS = 0x00000042
Global Const $CAPTUREBLT = 0x40000000
Global Const $DSTINVERT = 0x00550009
Global Const $MERGECOPY = 0x00C000CA
Global Const $MERGEPAINT = 0x00BB0226
Global Const $NOMIRRORBITMAP = 0x80000000
Global Const $NOTSRCCOPY = 0x00330008
Global Const $NOTSRCERASE = 0x001100A6
Global Const $PATCOPY = 0x00F00021
Global Const $PATINVERT = 0x005A0049
Global Const $PATPAINT = 0x00FB0A09
Global Const $SRCAND = 0x008800C6
Global Const $SRCCOPY = 0x00CC0020
Global Const $SRCERASE = 0x00440328
Global Const $SRCINVERT = 0x00660046
Global Const $SRCPAINT = 0x00EE0086
Global Const $WHITENESS = 0x00FF0062

#ce

; ===============================================================================================================================
; _WinAPI_UniqueHardwaeID()
; ===============================================================================================================================

Global Const $UHID_MB = 0x00
Global Const $UHID_BIOS = 0x01
Global Const $UHID_CPU = 0x02
Global Const $UHID_HDD = 0x04
Global Const $UHID_All = BitOR($UHID_MB, $UHID_BIOS, $UHID_CPU, $UHID_HDD)

; ===============================================================================================================================
; *Structure constants
; ===============================================================================================================================

Global Const $tagBITMAP = 'long bmType;long bmWidth;long bmHeight;long bmWidthBytes;ushort bmPlanes;ushort bmBitsPixel;ptr bmBits;'
Global Const $tagBITMAPINFOHEADER = 'dword biSize;long biWidth;long biHeight;ushort biPlanes;ushort biBitCount;dword biCompression;dword biSizeImage;long biXPelsPerMeter;long biYPelsPerMeter;dword biClrUsed;dword biClrImportant;'
Global Const $tagBITMAPV4HEADER = 'dword bV4Size;long bV4Width;long bV4Height;ushort bV4Planes;ushort bV4BitCount;dword bV4Compression;dword bV4SizeImage;long bV4XPelsPerMeter;long bV4YPelsPerMeter;dword bV4ClrUsed;dword bV4ClrImportant;dword bV4RedMask;dword bV4GreenMask;dword bV4BlueMask;dword bV4AlphaMask;dword bV4CSType;int bV4Endpoints[3];dword bV4GammaRed;dword bV4GammaGreen;dword bV4GammaBlue;'
Global Const $tagBITMAPV5HEADER = 'dword bV5Size;long bV5Width;long bV5Height;ushort bV5Planes;ushort bV5BitCount;dword bV5Compression;dword bV5SizeImage;long bV5XPelsPerMeter;long bV5YPelsPerMeter;dword bV5ClrUsed;dword bV5ClrImportant;dword bV5RedMask;dword bV5GreenMask;dword bV5BlueMask;dword bV5AlphaMask;dword bV5CSType;int bV5Endpoints[3];dword bV5GammaRed;dword bV5GammaGreen;dword bV5GammaBlue;dword bV5Intent;dword bV5ProfileData;dword bV5ProfileSize;dword bV5Reserved;'
;Global Const $tagBITMAPINFO = $tagBITMAPINFOHEADER & 'dword bmiColors[1];'
Global Const $tagDIBSECTION = $tagBITMAP & $tagBITMAPINFOHEADER & 'dword dsBitfields[3];ptr dshSection;dword dsOffset;'
Global Const $tagDISK_GEOMETRY = 'int64 Cylinders;dword MediaType;dword TracksPerCylinder;dword SectorsPerTrack;dword BytesPerSector;'
Global Const $tagDISK_GEOMETRY_EX = $tagDISK_GEOMETRY & 'int64 DiskSize;' ; & 'byte Data[n];'
Global Const $tagDTTOPTS = 'dword Size;dword Flags;dword clrText;dword clrBorder;dword clrShadow;int TextShadowType;' & $tagPOINT & ';int BorderSize;int FontPropId;int ColorPropId;int StateId;int ApplyOverlay;int GlowSize;ptr DrawTextCallback;lparam lParam;'
Global Const $tagEXTLOGPEN = 'dword PenStyle;dword Width;uint BrushStyle;dword Color;ulong_ptr Hatch;dword NumEntries' ; & 'dword StyleEntry[n];'
Global Const $tagHW_PROFILE_INFO = 'dword DockInfo;wchar ProfileGuid[39];wchar ProfileName[80];'
Global Const $tagIO_COUNTERS = 'uint64 ReadOperationCount;uint64 WriteOperationCount;uint64 OtherOperationCount;uint64 ReadTransferCount;uint64 WriteTransferCount;uint64 OtherTransferCount;'
Global Const $tagLOGBRUSH = 'uint Style;dword Color;ulong_ptr Hatch;'
Global Const $tagLOGPEN = 'uint Style;dword Width;dword Color;'
Global Const $tagLUID = 'dword LowPart;long HighPart;'
Global Const $tagNOTIFYICONDATA = 'dword Size;hwnd hWnd;uint ID;uint Flags;uint CallbackMessage;ptr hIcon;wchar Tip[128];dword State;dword StateMask;wchar Info[256];uint Version;wchar InfoTitle[64];dword InfoFlags;'
Global Const $tagNOTIFYICONDATA_XP = $tagNOTIFYICONDATA & 'uint GUID;'
Global Const $tagNOTIFYICONDATA_VISTA = $tagNOTIFYICONDATA_XP & 'ptr hBalloonIcon;'
Global Const $tagJOBOBJECT_ASSOCIATE_COMPLETION_PORT = 'ulong_ptr CompletionKey;ptr CompletionPort;'
Global Const $tagJOBOBJECT_BASIC_ACCOUNTING_INFORMATION = 'int64 TotalUserTime;int64 TotalKernelTime;int64 ThisPeriodTotalUserTime;int64 ThisPeriodTotalKernelTime;dword TotalPageFaultCount;dword TotalProcesses;dword ActiveProcesses;dword TotalTerminatedProcesses;'
Global Const $tagJOBOBJECT_BASIC_AND_IO_ACCOUNTING_INFORMATION = $tagJOBOBJECT_BASIC_ACCOUNTING_INFORMATION & $tagIO_COUNTERS
Global Const $tagJOBOBJECT_BASIC_LIMIT_INFORMATION = 'int64 PerProcessUserTimeLimit;int64 PerJobUserTimeLimit;dword LimitFlags;ulong_ptr MinimumWorkingSetSize;ulong_ptr MaximumWorkingSetSize;dword ActiveProcessLimit;ulong_ptr Affinity;dword PriorityClass;dword SchedulingClass;'
Global Const $tagJOBOBJECT_BASIC_PROCESS_ID_LIST = 'dword NumberOfAssignedProcesses;dword NumberOfProcessIdsInList' ; & 'ulong_ptr ProcessIdList[n];'
Global Const $tagJOBOBJECT_BASIC_UI_RESTRICTIONS = 'dword UIRestrictionsClass;'
Global Const $tagJOBOBJECT_END_OF_JOB_TIME_INFORMATION = 'dword EndOfJobTimeAction;'
Global Const $tagJOBOBJECT_EXTENDED_LIMIT_INFORMATION = $tagJOBOBJECT_BASIC_LIMIT_INFORMATION & $tagIO_COUNTERS & 'ulong_ptr ProcessMemoryLimit;ulong_ptr JobMemoryLimit;ulong_ptr PeakProcessMemoryUsed;ulong_ptr PeakJobMemoryUsed;'
Global Const $tagJOBOBJECT_GROUP_INFORMATION = '' ; & 'ushort ProcessorGroup[n];'
Global Const $tagJOBOBJECT_SECURITY_LIMIT_INFORMATION = 'dword SecurityLimitFlags;ptr JobToken;ptr SidsToDisable;ptr PrivilegesToDelete;ptr RestrictedSids;'
Global Const $tagOSVERSIONINFO = 'dword OSVersionInfoSize;dword MajorVersion;dword MinorVersion;dword BuildNumber;dword PlatformId;wchar CSDVersion[128];'
Global Const $tagOSVERSIONINFOEX = $tagOSVERSIONINFO & 'ushort ServicePackMajor;ushort ServicePackMinor;ushort SuiteMask;byte ProductType;byte Reserved;'
Global Const $tagPAINTSTRUCT = 'hwnd hDC;int fErase;dword rPaint[4];int fRestore;int fIncUpdate;byte rgbReserved[32];'
Global Const $tagPROCESS_MEMORY_COUNTERS = 'dword Size;dword PageFaultCount;ulong_ptr PeakWorkingSetSize;ulong_ptr WorkingSetSize;ulong_ptr QuotaPeakPagedPoolUsage;ulong_ptr QuotaPagedPoolUsage;ulong_ptr QuotaPeakNonPagedPoolUsage;ulong_ptr QuotaNonPagedPoolUsage;ulong_ptr PagefileUsage;ulong_ptr PeakPagefileUsage;'
Global Const $tagSHFILEINFO = 'ptr hIcon;int iIcon;dword Attributes;wchar DisplayName[260];wchar TypeName[80];'
Global Const $tagSHFILEOPSTRUCT = 'hwnd hWnd;uint Func;ptr From;ptr To;dword Flags;int fAnyOperationsAborted;ptr hNameMappings;ptr ProgressTitle;'
Global Const $tagSHSTOCKICONINFO = 'dword Size;ptr hIcon;int SysImageIndex;int iIcon;wchar Path[260];'
Global Const $tagSTORAGE_DEVICE_NUMBER = 'dword DeviceType;ulong DeviceNumber;ulong PartitionNumber;'
;Global Const $tagTEXTMETRIC = 'long tmHeight;long tmAscent;long tmDescent;long tmInternalLeading;long tmExternalLeading;long tmAveCharWidth;long tmMaxCharWidth;long tmWeight;long tmOverhang;long tmDigitizedAspectX;long tmDigitizedAspectY;wchar tmFirstChar;wchar tmLastChar;wchar tmDefaultChar;wchar tmBreakChar;byte tmItalic;byte tmUnderlined;byte tmStruckOut;byte tmPitchAndFamily;byte tmCharSet;'
Global Const $tagWINDOWINFO = 'dword Size;dword rWindow[4];dword rClient[4];dword Style;dword ExStyle;dword WindowStatus;uint cxWindowBorders;uint cyWindowBorders;ushort atomWindowType;ushort CreatorVersion;'
Global Const $tagHELPWININFO = 'int Size;int X;int Y;int Width;int Height;int wMax;wchar rgchMember[256];'

#EndRegion Global Variables and Constants

#Region Local Variables and Constants

Global $__Data, $__RGB = True

#EndRegion Local Variables and Constants

#Region Public Functions

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ActivateKeyboardLayout
; Description....: Sets the input locale identifier for the calling thread or the current process.
; Syntax.........: _WinAPI_ActivateKeyboardLayout ( $hLocale [, $iFlag] )
; Parameters.....: $hLocale - The input locale identifier to be activated. This parameter must be either the handle to a keyboard
;                             layout or one of the following values.
;
;                             $HKL_NEXT
;                             $HKL_PREV
;
;                  $iFlag   - The flag that specifies how the input locale identifier is to be activated. This parameter can be
;                             one of the following values.
;
;                             $KLF_REORDER
;                             $KLF_RESET
;                             $KLF_SETFORPROCESS
;                             $KLF_SHIFTLOCK
;
; Return values..: Success  - The previous input locale identifier.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ ActivateKeyboardLayout
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ActivateKeyboardLayout($hLocale, $iFlag = 0)

	Local $Ret = DllCall('user32.dll', 'long', 'ActivateKeyboardLayout', 'long', $hLocale, 'uint', $iFlag)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_ActivateKeyboardLayout

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_AboutDlg
; Description....: Displays a Windows About dialog box.
; Syntax.........: _WinAPI_AboutDlg ( $sTitle, $sName, $sText [, $hIcon [, $hParent]] )
; Parameters.....: $sTitle  - The title of the Windows About dialog box.
;                  $sName   - The first line after the text "Microsoft".
;                  $sText   - The text to be displayed in the dialog box after the version and copyright information.
;                  $hIcon   - Handle to the icon that the function displays in the dialog box.
;                  $hParent - Handle to a parent window.
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ ShellAbout
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_AboutDlg($sTitle, $sName, $sText, $hIcon = 0, $hParent = 0)

	Local $Ret = DllCall('shell32.dll', 'int', 'ShellAboutW', 'hwnd', $hParent, 'wstr', $sTitle & '#' & $sName, 'wstr', $sText, 'ptr', $hIcon)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_AboutDlg

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_AddFontResourceEx
; Description....: Adds the font resource from the specified file to the system font table.
; Syntax.........: _WinAPI_AddFontResourceEx ( $sFont [, $iFlag [, $fNotify]] )
; Parameters.....: $sFont   - String that contains a valid font file name. This parameter can specify any of the following files:
;
;                             .fon - Font resource file.
;                             .fnt - Raw bitmap font file.
;                             .ttf - Raw TrueType file.
;                             .ttc - East Asian Windows: TrueType font collection.
;                             .fot - TrueType resource file.
;                             .otf - PostScript OpenType font.
;                             .mmm - Multiple master Type1 font resource file. It must be used with .pfm and .pfb files.
;                             .pfb - Type 1 font bits file. It is used with a .pfm file.
;                             .pfm - Type 1 font metrics file. It is used with a .pfb file.
;
;                             To add a font whose information comes from several resource files, they must be separated by a "|".
;                             For example, abcxxxxx.pfm|abcxxxxx.pfb.
;
;                  $iFlag   - The characteristics of the font to be added to the system. This parameter can be one of the following values.
;
;                             $FR_PRIVATE
;                             $FR_NOT_ENUM
;
;                  $fNotify - Specifies whether sends a WM_FONTCHANGE message, valid values:
;                  |TRUE    - Send the WM_FONTCHANGE message to all top-level windows after changing the pool of font resources.
;                  |FALSE   - Don`t send. (Default)
; Return values..: Success  - The value that specifies the number of fonts added.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function installs the font only for the current session. When the system restarts, the font will not be present.
;                  To have the font installed even after restarting the system, the font must be listed in the registry.
; Related........:
; Link...........: @@MsdnLink@@ AddFontResourceEx
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_AddFontResourceEx($sFont, $iFlag = 0, $fNotify = 0)

	Local $Ret = DllCall('gdi32.dll', 'int', 'AddFontResourceExW', 'wstr', $sFont, 'dword', $iFlag, 'ptr', 0)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	If $fNotify Then
		DllCall('user32.dll', 'int', 'SendMessage', 'hwnd', 0xFFFF, 'uint', 0x001D, 'int', 0, 'int', 0)
	EndIf
	Return SetError(0, 0, $Ret[0])
EndFunc   ;==>_WinAPI_AddFontResourceEx

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_AddMRUString
; Description....: Adds a string to the top of the most recently used (MRU) list.
; Syntax.........: _WinAPI_AddMRUString ( $hMRU, $sStr )
; Parameters.....: $hMRU   - Handle of the MRU list.
;                  $sStr   - The string or binary data to be added. If the MRU list was created with the $MRU_BINARY flag this
;                            parameter must be a binary type.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ AddMRUStringW
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_AddMRUString($hMRU, $sStr)

	Local $tData, $Lenght

	If IsBinary($sStr) Then
		$Lenght = BinaryLen($sStr)
		$tData = DllStructCreate('dword;byte[' & $Lenght & ']')
		DllStructSetData($tData, 1, 4)
		DllStructSetData($tData, 2, $sStr)
	Else
		$tData = DllStructCreate('wchar[' & (StringLen($sStr) + 1) & ']')
		DllStructSetData($tData, 1, $sStr)
	EndIf

	Local $Ret = DllCall('comctl32.dll ', 'int', 'AddMRUStringW', 'ptr', $hMRU, 'ptr', DllStructGetPtr($tData))

	If (@error) Or ($Ret[0] < 0) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_AddMRUString

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_AdjustTokenPrivileges
; Description....: Enables or disables privileges in the specified access token.
; Syntax.........: _WinAPI_AdjustTokenPrivileges ( $hToken, $aPrivileges, $iState )
; Parameters.....: $hToken      - Handle to the access token that contains the privileges to be modified. The handle must have
;                                 $TOKEN_ADJUST_PRIVILEGES and $TOKEN_QUERY accesses to the token.
;                  $aPrivileges - The variable that specifies a privileges. If this parameter is (-1), the function disables of the token's
;                                 privileges and ignores the $iState parameter. $aPrivileges can be one of the following types.
;
;                                 Single privileges constants ($SE_...).
;                                 1D array of $SE_... constants.
;                                 2D array of $SE_... constants and their attributes (see $iState).
;
;                                 [0][0] - Privilege
;                                 [0][1] - Attribute
;                                 [n][0] - Privilege
;                                 [n][1] - Attribute
;
;                  $iState      - The privilege attribute. If $aPrivileges parameter is 1D array, $iState applied to the entire
;                                 array. If $aPrivileges parameter is (-1) or 2D array, the function ignores this parameter and will
;                                 use the attributes specified in the array. This parameter can be one of the following values.
;
;                                 0 - The privilege is disabled.
;                                 1 - The privilege is enabled.
;                                 2 - The privilege is enabled by default.
;
; Return values..: Success      - If $aPrivileges is a single $SE_... constant, returns a previous privilege attribute (0 or 1),
;                                 otherwise always returns 1. To determine whether the function adjusted all of the specified privileges,
;                                 check @extended flag, which returns one of the following values when the function succeeds:
;
;                                 0 - The function adjusted all specified privileges.
;                                 1 - The token does not have one or more of the privileges specified in the $aPrivileges parameter.
;
;                  Failure      - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function cannot add new privileges to the access token. It can only enable or disable the token's
;                  existing privileges.
; Related........:
; Link...........: @@MsdnLink@@ AdjustTokenPrivileges
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_AdjustTokenPrivileges($hToken, $aPrivileges, $iState)

	Switch $iState
		Case 0

		Case 1
			$iState = 2
		Case 2
			$iState = 1
		Case Else
			Return SetError(1, 0, 0)
	EndSwitch

	Local $tLUID, $tPrivileges = 0, $tPrev = 0, $iPrivileges = $aPrivileges, $Global = 0, $Result = 1
	Local $Struct = 'dword;dword;long;dword'

	If $aPrivileges = -1 Then
		$Global = 1
	Else
		If Not IsArray($aPrivileges) Then
			Dim $aPrivileges[1][2] = [[$iPrivileges, $iState]]
			$tPrev = DllStructCreate($Struct)
			If @error Then
				Return SetError(1, 0, 0)
			EndIf
		Else
			If Not UBound($aPrivileges, 2) Then
				Dim $aPrivileges[UBound($iPrivileges)][2]
				For $i = 0 To UBound($iPrivileges) - 1
					$aPrivileges[$i][0] = $iPrivileges[$i]
					$aPrivileges[$i][1] = $iState
				Next
			EndIf
		EndIf
		For $i = 1 To UBound($aPrivileges) - 1
			$Struct &= ';dword;long;dword'
		Next
		$tPrivileges = DllStructCreate($Struct)
		If @error Then
			Return SetError(1, 0, 0)
		EndIf
		DllStructSetData($tPrivileges, 1, UBound($aPrivileges))
		For $i = 0 To UBound($aPrivileges) - 1
			$tLUID = _WinAPI_LookupPrivilegeValue($aPrivileges[$i][0])
			If @error Then
				Return SetError(1, 0, 0)
			EndIf
			DllStructSetData($tPrivileges, 3 * $i + 2, DllStructGetData($tLUID, 1))
			DllStructSetData($tPrivileges, 3 * $i + 3, DllStructGetData($tLUID, 2))
			DllStructSetData($tPrivileges, 3 * $i + 4, $aPrivileges[$i][1])
		Next
	EndIf

	Local $Ret = DllCall('advapi32.dll', 'int', 'AdjustTokenPrivileges', 'ptr', $hToken, 'int', $Global, 'ptr', DllStructGetPtr($tPrivileges), 'dword', DllStructGetSize($tPrev), 'ptr', DllStructGetPtr($tPrev), 'dword*', 0)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	If IsDllStruct($tPrev) Then
		$Result = DllStructGetData($tPrev, 4)
	EndIf
	Return SetError(0, _WinAPI_GetLastError(), $Result)
EndFunc   ;==>_WinAPI_AdjustTokenPrivileges

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_AdjustWindowRectEx
; Description....: Calculates the required size of the window rectangle, based on the desired size of the client rectangle.
; Syntax.........: _WinAPI_AdjustWindowRectEx ( ByRef $tRECT, $iStyle [, $iExStyle [, $fMenu] )
; Parameters.....: $tRECT    - $tagRECT structure that contains the coordinates of the desired client area.
;                  $iStyle   - The window style of the window whose required size is to be calculated. Note that you cannot
;                              specify the $WS_OVERLAPPED style.
;                  $iExStyle - The extended window style of the window whose required size is to be calculated.
;                  $fMenu    - Specifies whether the window has a menu.
;                  |TRUE     - The window has a menu.
;                  |FALSE    - The window does not has a menu. (Default)
; Return values..: Success   - 1.
;                  Failure   - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ AdjustWindowRectEx
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_AdjustWindowRectEx(ByRef $tRECT, $iStyle, $iExStyle = 0, $fMenu = 0)

	Local $Ret = DllCall('user32.dll', 'int', 'AdjustWindowRectEx', 'ptr', DllStructGetPtr($tRECT), 'dword', $iStyle, 'int', $fMenu, 'dword', $iExStyle)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_AdjustWindowRectEx

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_AlphaBlend
; Description....: Displays bitmaps that have transparent or semitransparent pixels.
; Syntax.........: _WinAPI_AlphaBlend ( $hDestDC, $iXDest, $iYDest, $iWidthDest, $iHeightDest, $hSrcDC, $iXSrc, $iYSrc, $iWidthSrc, $iHeightSrc, $iAlpha [, $fAlpha] )
; Parameters.....: $hDestDC     - Handle to the destination device context.
;                  $iXDest      - The x-coordinate, in logical units, of the upper-left corner of the destination rectangle.
;                  $iYDest      - The y-coordinate, in logical units, of the upper-left corner of the destination rectangle.
;                  $iWidthDest  - The width, in logical units, of the destination rectangle.
;                  $iHeightDest - The height, in logical units, of the destination rectangle.
;                  $hSrcDC      - Handle to the source device context.
;                  $iXSrc       - The x-coordinate, in logical units, of the upper-left corner of the source rectangle.
;                  $iYSrc       - The y-coordinate, in logical units, of the upper-left corner of the source rectangle.
;                  $iWidthSrc   - The width, in logical units, of the source rectangle.
;                  $iHeightSrc  - The height, in logical units, of the source rectangle.
;                  $iAlpha      - The alpha transparency value to be used on the entire source bitmap. This value is combined with
;                                 any per-pixel alpha values in the source bitmap. If you set $iAlpha to 0, it is assumed that
;                                 your image is transparent. Set $iAlpha value to 255 (opaque) when you only want to use per-pixel
;                                 alpha values.
;                  $fAlpha      - Specifies whether uses an Alpha channel from the source bitmap, valid values:
;                  |TRUE        - Use the Alpha channel (that is, per-pixel alpha). Note that the APIs use premultiplied alpha,
;                                 which means that the red, green and blue channel values in the bitmap must be premultiplied with the
;                                 alpha channel value. For example, if the alpha channel value is x, the red, green and blue channels
;                                 must be multiplied by x and divided by 255 prior to the call.
;                  |FALSE       - Do not use the Alpha channel. (Default)
; Return values..: Success      - 1.
;                  Failure      - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: If the source rectangle and destination rectangle are not the same size, the source bitmap is stretched to
;                  match the destination rectangle. If the _WinAPI_SetStretchBltMode() function is used, the stretching mode value
;                  is automatically converted to $COLORONCOLOR for this function (that is, $BLACKONWHITE, $WHITEONBLACK, and
;                  $HALFTONE are changed to $COLORONCOLOR).
;
;                  If destination and source bitmaps do not have the same color format, _WinAPI_AlphaBlend() function converts
;                  the source bitmap to match the destination bitmap.
; Related........:
; Link...........: @@MsdnLink@@ GdiAlphaBlend
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_AlphaBlend($hDestDC, $iXDest, $iYDest, $iWidthDest, $iHeightDest, $hSrcDC, $iXSrc, $iYSrc, $iWidthSrc, $iHeightSrc, $iAlpha, $fAlpha = 0)

	Local $iBlend = BitOR(BitShift(Not ($fAlpha = 0), -24), BitShift(BitAND($iAlpha, 0xFF), -16))
	Local $Ret  = DllCall('gdi32.dll', 'int', 'GdiAlphaBlend', 'hwnd', $hDestDC, 'int', $iXDest, 'int', $iYDest, 'int', $iWidthDest, 'int', $iHeightDest, 'hwnd', $hSrcDC, 'int', $iXSrc, 'int', $iYSrc, 'int', $iWidthSrc, 'int', $iHeightSrc, 'dword', $iBlend)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_AlphaBlend

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_AnimateWindow
; Description....: Enables you to produce special effects when showing or hiding windows.
; Syntax.........: _WinAPI_AnimateWindow ( $hWnd, $iFlags [, $iDuration] )
; Parameters.....: $hWnd      - Handle to the window to animate.
;                  $iFlags    - The flags that specify the type of animation. This parameter can be one or more of the following
;                               values. Note that, by default, these flags take effect when showing a window. To take effect when
;                               hiding a window, use AW_HIDE and a logical OR operator with the appropriate flags.
;
;                               $AW_SLIDE
;                               $AW_ACTIVATE
;                               $AW_BLEND
;                               $AW_HIDE
;                               $AW_CENTER
;                               $AW_HOR_POSITIVE
;                               $AW_HOR_NEGATIVE
;                               $AW_VER_POSITIVE
;                               $AW_VER_NEGATIVE
;
;                  $iDuration - Specifies how long it takes to play the animation, in milliseconds. Default is 1000.
; Return values..: Success    - 1.
;                  Failure    - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ AnimateWindow
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_AnimateWindow($hWnd, $iFlags, $iDuration = 1000)

	Local $Ret = DllCall('user32.dll', 'int', 'AnimateWindow', 'hwnd', $hWnd, 'dword', $iDuration, 'dword', $iFlags)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_AnimateWindow

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ArrayToStruct
; Description....: Converts an array of strings to the structure.
; Syntax.........: _WinAPI_ArrayToStruct ( $aData [, $iStart [, $iEnd]] )
; Parameters.....: $aData  - The array to convert.
;                  $iStart - The index of array to start converting at.
;                  $iEnd   - The index of array to stop converting at.
; Return values..: Success - The structure of the type "string1;{0};string2;{0}; ... ;stringN;{0};{0}".
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function works for Unicode strings only.
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ArrayToStruct($aData, $iStart = 0, $iEnd = -1)

	If Not IsArray($aData) Then
		Return SetError(2, 0, 0)
	EndIf

	Local $tData, $Count, $Struct = ''

	If $iStart < 0 Then
		$iStart = 0
	EndIf
	If ($iEnd < 0) Or ($iEnd > UBound($aData) - 1) Then
		$iEnd = UBound($aData) - 1
	EndIf
	For $i = $iStart To $iEnd
		$Struct &= 'wchar[' & (StringLen($aData[$i]) + 1) & '];'
	Next
	$tData = DllStructCreate($Struct & 'wchar[1]')
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	$Count = 1
	For $i = $iStart To $iEnd
		DllStructSetData($tData, $Count, $aData[$i])
		$Count += 1
	Next
	DllStructSetData($tData, $Count, ChrW(0))
	Return $tData
EndFunc   ;==>_WinAPI_ArrayToStruct

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_AssignProcessToJobObject
; Description....: Assigns a process to an existing job object.
; Syntax.........: _WinAPI_AssignProcessToJobObject ( $hJob, $hProcess )
; Parameters.....: $hJob     - Handle to the job object to which the process will be associated. The handle must have the
;                              $JOB_OBJECT_ASSIGN_PROCESS access right.
;                  $hProcess - Handle to the process to associate with the job object. The process must not already be assigned to a job.
; Return values..: Success   - 1.
;                  Failure   - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: After you associate a process with a job object, the process is subject to the limits set for the job. To set
;                  limits for a job, use the _WinAPI_SetInformationJobObject() function.
;
;                  The process can be associated only with a single job. The process inherits limits from the job it is associated
;                  with and adds its accounting information to the job. If a process is associated with a job, all processes it
;                  creates are associated with that job by default.
; Related........:
; Link...........: @@MsdnLink@@ AssignProcessToJobObject
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_AssignProcessToJobObject($hJob, $hProcess)

	Local $Ret = DllCall('kernel32.dll', 'int', 'AssignProcessToJobObject', 'ptr', $hJob, 'ptr', $hProcess)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_AssignProcessToJobObject

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_AssocGetPerceivedType
; Description....: Retrieves a file's perceived type based on its extension.
; Syntax.........: _WinAPI_AssocGetPerceivedType ( $sExt )
; Parameters.....: $sExt   - The file's extension. This should include the leading period, for example ".txt".
; Return values..: Success - The array containing the following parameters:
;
;                            [0] - The perceived type ($PERCEIVED_TYPE_...).
;                            [1] - The source of the perceived type information ($PERCEIVEDFLAG_...).
;                            [2] - The perceived type string, for instance "text" or "video".
;
;                  Failure - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ AssocGetPerceivedType
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_AssocGetPerceivedType($sExt)

	Local $Ret = DllCall('shlwapi.dll', 'uint', 'AssocGetPerceivedType', 'wstr', $sExt, 'int*', 0, 'dword*', 0, 'wstr*', '')

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf

	Local $Result[3]

	For $i = 0 To 2
		$Result[$i] = $Ret[$i + 2]
	Next
	Return $Result
EndFunc   ;==>_WinAPI_AssocGetPerceivedType

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_AssocQueryString
; Description....: Searches for and retrieves a file or protocol association-related string from the registry.
; Syntax.........: _WinAPI_AssocQueryString ( $sAssoc, $iType [, $iFlags [, $sExtra]] )
; Parameters.....: $sAssoc - The string that is used to determine the root key. The following four types of strings can be used.
;
;                            The file name extension, such as ".txt".
;                            The class identifier (CLSID) GUID in the standard "{GUID}" format.
;                            The application's ProgID, such as Word.Document.8.
;                            The name of an application's .exe file. The $ASSOCF_OPEN_BYEXENAME flag must be set.
;
;                  $iType  - The value that specifies the type of string that is to be returned. This parameter can be one of the
;                            following values.
;
;                            $ASSOCSTR_COMMAND
;                            $ASSOCSTR_EXECUTABLE
;                            $ASSOCSTR_FRIENDLYDOCNAME
;                            $ASSOCSTR_FRIENDLYAPPNAME
;                            $ASSOCSTR_NOOPEN
;                            $ASSOCSTR_SHELLNEWVALUE
;                            $ASSOCSTR_DDECOMMAND
;                            $ASSOCSTR_DDEIFEXEC
;                            $ASSOCSTR_DDEAPPLICATION
;                            $ASSOCSTR_DDETOPIC
;                            $ASSOCSTR_INFOTIP
;                            $ASSOCSTR_QUICKTIP
;                            $ASSOCSTR_TILEINFO
;                            $ASSOCSTR_CONTENTTYPE
;                            $ASSOCSTR_DEFAULTICON
;                            $ASSOCSTR_SHELLEXTENSION
;
;                  $iFlags - The flags that can be used to control the search. It can be any combination of the following
;                            values, except that only one $ASSOCF_INIT_... value can be included.
;
;                            $ASSOCF_INIT_NOREMAPCLSID
;                            $ASSOCF_INIT_BYEXENAME
;                            $ASSOCF_OPEN_BYEXENAME
;                            $ASSOCF_INIT_DEFAULTTOSTAR
;                            $ASSOCF_INIT_DEFAULTTOFOLDER
;                            $ASSOCF_NOUSERSETTINGS
;                            $ASSOCF_NOTRUNCATE
;                            $ASSOCF_VERIFY
;                            $ASSOCF_REMAPRUNDLL
;                            $ASSOCF_NOFIXUPS
;                            $ASSOCF_IGNOREBASECLASS
;                            $ASSOCF_INIT_IGNOREUNKNOWN
;
;                  $sExtra - The optional string with additional information about the location of the string. It is typically
;                            set to a Shell verb such as open.
; Return values..: Success - The string that contains the requested ($ASSOCSTR_...) information.
;                  Failure - Empty string and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ AssocQueryString
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_AssocQueryString($sAssoc, $iType, $iFlags = 0, $sExtra = '')

	Local $TypeOfExtra = 'wstr'

	If Not StringStripWS($sExtra, 3) Then
		$TypeOfExtra = 'ptr'
		$sExtra = 0
	EndIf

	Local $tData = DllStructCreate('wchar[1024]')
	Local $Ret = DllCall('shlwapi.dll', 'uint', 'AssocQueryStringW', 'dword', $iFlags, 'dword', $iType, 'wstr', $sAssoc, $TypeOfExtra, $sExtra, 'ptr', DllStructGetPtr($tData), 'dword*', 1024)

	If @error Then
		Return SetError(1, 0, '')
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], '')
		EndIf
	EndIf
	Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_AssocQueryString

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_BeginPaint
; Description....: Prepares the specified window for painting.
; Syntax.........: _WinAPI_BeginPaint ( $hWnd, ByRef $tPAINTSTRUCT )
; Parameters.....: $hWnd         - Handle to the window to be repainted.
;                  $tPAINTSTRUCT - $tagPAINTSTRUCT structure that will receive painting information.
; Return values..: Success       - Handle to a display device context for the specified window.
;                  Failure       - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function automatically sets the clipping region of the device context to exclude any area outside the
;                  update region. The update region is set by the _WinAPI_InvalidateRect() or _WinAPI_InvalidateRgn() function and
;                  by the system after sizing, moving, creating, scrolling, or any other operation that affects the client area.
;                  If the update region is marked for erasing, _WinAPI_BeginPaint() sends a WM_ERASEBKGND message to the window.
;
;                  An application should not call _WinAPI_BeginPaint() except in response to a WM_PAINT message. Each call to
;                  _WinAPI_BeginPaint() must have a corresponding call to the _WinAPI_EndPaint() function.
; Related........:
; Link...........: @@MsdnLink@@ BeginPaint
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_BeginPaint($hWnd, ByRef $tPAINTSTRUCT)

	$tPAINTSTRUCT = DllStructCreate($tagPAINTSTRUCT)

	Local $Ret = DllCall('user32.dll', 'hwnd', 'BeginPaint', 'hwnd', $hWnd, 'ptr', DllStructGetPtr($tPAINTSTRUCT))

	If (@error) Or (Not $Ret[0]) Then
		$tPAINTSTRUCT = 0
	EndIf
	Return SetError(Number(IsDllStruct($tPAINTSTRUCT)), 0, $Ret[0])
EndFunc   ;==>_WinAPI_BeginPaint

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_BringWindowToTop
; Description....: Brings the specified window to the top of the Z order.
; Syntax.........: _WinAPI_BringWindowToTop ( $hWnd )
; Parameters.....: $hWnd   - Handle to the window to bring to the top of the Z order.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ BringWindowToTop
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_BringWindowToTop($hWnd)

	Local $Ret = DllCall('user32.dll', 'int', 'BringWindowToTop', 'hwnd', $hWnd)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_BringWindowToTop

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_BroadcastSystemMessage
; Description....: Sends a message to the specified recipients.
; Syntax.........: _WinAPI_BroadcastSystemMessage ( $iMessage [, $wParam [, $lParam [, $iFlags [, $iRecipients]]]] )
; Parameters.....: $iMessage    - The message to be sent.
;                  $wParam      - Additional message-specific information.
;                  $lParam      - Additional message-specific information.
;                  $iFlags      - The broadcast option. This parameter can be one or more of the following values.
;
;                                 $BSF_ALLOWSFW
;                                 $BSF_FLUSHDISK
;                                 $BSF_FORCEIFHUNG
;                                 $BSF_IGNORECURRENTTASK
;                                 $BSF_NOHANG
;                                 $BSF_NOTIMEOUTIFNOTHUNG
;                                 $BSF_POSTMESSAGE
;                                 $BSF_QUERY
;                                 $BSF_SENDNOTIFYMESSAGE
;
;                  $iRecipients - The recipients of the message. This parameter can be one or more of the following values.
;
;                                 $BSM_ALLCOMPONENTS
;                                 $BSM_ALLDESKTOPS
;                                 $BSM_APPLICATIONS
;                                 $BSM_INSTALLABLEDRIVERS
;                                 $BSM_NETDRIVER
;                                 $BSM_VXDS
;
; Return values..: Success      - 1 or 0 (see below), @extended flag receives a combination of $BSM_... values identifying which
;                                 recipients actually received the message.
;                  Failure      - (-1) and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: If the $iFlags parameter is $BSF_QUERY and at least one recipient returned BROADCAST_QUERY_DENY to the corresponding
;                  message, the return value is 0.
;
;                  The system only does marshalling for system messages (those in the range 0 to (WM_USER-1)). To send other messages
;                  (those >= WM_USER) to another process, you must do custom marshalling.
; Related........:
; Link...........: @@MsdnLink@@ BroadcastSystemMessage
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_BroadcastSystemMessage($iMessage, $wParam = 0, $lParam = 0, $iFlags = 0, $iRecipients = 0)

	Local $Ret = DllCall('user32.dll', 'long', 'BroadcastSystemMessageW', 'dword', $iFlags, 'dword*', $iRecipients, 'uint', $iMessage, 'wparam', $wParam, 'lparam', $lParam)

	If (@error) Or ($Ret[0] < 0) Then
		Return SetError(1, 0, -1)
	EndIf
	Return SetError(0, $Ret[2], $Ret[0])
EndFunc   ;==>_WinAPI_BroadcastSystemMessage

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_BrowseForFolderDlg
; Description....: Displays a dialog box that enables the user to select a Shell folder.
; Syntax.........: _WinAPI_BrowseForFolderDlg ( [$sRoot [, $sText [, $iFlags [, $pBrowseProc [, $lParam [, $hParent] )
; Parameters.....: $sRoot       - The root folder from which to start browsing. Only the specified folder and its subfolders in the
;                                 namespace hierarchy appear in the dialog box. If this parameter is 0, the namespace root
;                                 (the Desktop folder) is used.
;                  $sText       - The string that is displayed above the tree view control in the dialog box.
;                  $iFlags      - Flags that specify the options for the dialog box. This parameter can a combination of the
;                                 following values.
;
;                                 $BIF_RETURNONLYFSDIRS
;                                 $BIF_DONTGOBELOWDOMAIN
;                                 $BIF_STATUSTEXT
;                                 $BIF_RETURNFSANCESTORS
;                                 $BIF_EDITBOX
;                                 $BIF_VALIDATE
;                                 $BIF_NEWDIALOGSTYLE
;                                 $BIF_BROWSEINCLUDEURLS
;                                 $BIF_USENEWUI
;                                 $BIF_UAHINT
;                                 $BIF_NONEWFOLDERBUTTON
;                                 $BIF_NOTRANSLATETARGETS
;                                 $BIF_BROWSEFORCOMPUTER
;                                 $BIF_BROWSEFORPRINTER
;                                 $BIF_BROWSEINCLUDEFILES
;                                 $BIF_SHAREABLE
;
;                  $pBrowseProc - Pointer to a callback function that the dialog box calls when an event occurs. This function will
;                                 receive one of the following event messages.
;
;                                 $BFFM_INITIALIZED
;                                 $BFFM_IUNKNOWN
;                                 $BFFM_SELCHANGED
;                                 $BFFM_VALIDATEFAILED
;
;                                 (See MSDN for more information)
;
;                  $lParam      - The value that the dialog box passes to the callback function.
;                  $hParent     - Handle to the parent window for the dialog box.
; Return values..: Success      - The full path for chosen folder, or empty string if user cancels/closes the dialog.
;                  Failure      - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SHBrowseForFolder
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_BrowseForFolderDlg($sRoot = '', $sText = '', $iFlags= 0, $pBrowseProc = 0, $lParam = 0, $hParent = 0)

	Local $tBROWSEINFO = DllStructCreate('hwnd;ptr;ptr;ptr;int;ptr;uint_ptr;int')
	Local $tText = DllStructCreate('wchar[1024]')
	Local $tName = DllStructCreate('wchar[260]')
	Local $PIDL = 0, $Result = ''

	If _WinAPI_PathIsDirectory($sRoot) Then
		$PIDL = _WinAPI_ShellILCreateFromPath(_WinAPI_PathSearchAndQualify($sRoot))
	EndIf

	DllStructSetData($tBROWSEINFO, 1, $hParent)
	DllStructSetData($tBROWSEINFO, 2, $PIDL)
	DllStructSetData($tBROWSEINFO, 3, DllStructGetPtr($tName))
	DllStructSetData($tBROWSEINFO, 4, DllStructGetPtr($tText))
	DllStructSetData($tBROWSEINFO, 5, $iFlags)
	DllStructSetData($tBROWSEINFO, 6, $pBrowseProc)
	DllStructSetData($tBROWSEINFO, 7, $lParam)
	DllStructSetData($tBROWSEINFO, 8, 0)

	DllStructSetData($tText, 1, $sText)

	Local $Ret = DllCall('shell32.dll', 'ptr', 'SHBrowseForFolderW', 'ptr', DllStructGetPtr($tBROWSEINFO))

	If @error Then
		Return SetError(1, 0, '')
	Else
		If Not $Ret[0] Then
			Return ''
		EndIf
	EndIf
	$Result = _WinAPI_ShellGetPathFromIDList($Ret[0])
	_WinAPI_CoTaskMemFree($Ret[0])
	If $PIDL Then
		_WinAPI_CoTaskMemFree($PIDL)
	EndIf
	If Not $Result Then
		Return SetError(1, 0, '')
	EndIf
	Return $Result
EndFunc   ;==>_WinAPI_BrowseForFolderDlg

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CharToOem
; Description....: Converts a string into the OEM-defined character set.
; Syntax.........: _WinAPI_CharToOem ( $sStr )
; Parameters.....: $sStr   - The string that must be converted.
; Return values..: Success - The converted string.
;                  Failure - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ CharToOem
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CharToOem($sStr)

	Local $tData = DllStructCreate('char[' & StringLen($sStr) + 1 & ']')
	Local $Ret = DllCall('user32.dll', 'int', 'CharToOem', 'str', $sStr, 'ptr', DllStructGetPtr($tData))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, '')
	EndIf
	Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_CharToOem

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ChildWindowFromPointEx
; Description....: Determines which, if any, of the child windows belonging to the specified parent window contains the specified point.
; Syntax.........: _WinAPI_ChildWindowFromPointEx ( $hWnd, $tPOINT [, $iFlags] )
; Parameters.....: $hWnd   - Handle to the parent window.
;                  $tPOINT - $tagPOINT structure that defines the client coordinates (relative to hwndParent) of the point to
;                            be checked.
;                  $iFlags - The flags that specify which child windows to skip. This parameter can be one or more of the
;                            following values.
;
;                            $CWP_ALL
;                            $CWP_SKIPINVISIBLE
;                            $CWP_SKIPDISABLED
;                            $CWP_SKIPTRANSPARENT
;
; Return values..: Success - Handle to the first child window. If the point is within the parent window but not within any child
;                            window that meets the criteria, the return value is a handle to the parent window. If the point lies
;                            outside the parent window, the return value is 0.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The system maintains an internal list that contains the handles of the child windows associated with a
;                  parent window. The order of the handles in the list depends on the Z order of the child windows. If more than
;                  one child window contains the specified point, the system returns a handle to the first window in the list
;                  that contains the point and meets the criteria specified by $iFlags.
; Related........:
; Link...........: @@MsdnLink@@ ChildWindowFromPointEx
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ChildWindowFromPointEx($hWnd, $tPOINT, $iFlags = 0)

	Local $Ret = DllCall('user32.dll', 'hwnd', 'ChildWindowFromPointEx', 'hwnd', $hWnd, 'int', DllStructGetData($tPOINT, 1), 'int', DllStructGetData($tPOINT, 2), 'uint', $iFlags)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_ChildWindowFromPointEx

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CloseThemeData
; Description....: Closes the theme data handle.
; Syntax.........: _WinAPI_CloseThemeData ( $hTheme )
; Parameters.....: $hTheme - Handle to a window's specified theme data.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ CloseThemeData
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CloseThemeData($hTheme)

	Local $Ret = DllCall('uxtheme.dll', 'uint', 'CloseThemeData', 'ptr', $hTheme)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_CloseThemeData

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CloseWindow
; Description....: Minimizes (but does not destroy) the specified window.
; Syntax.........: _WinAPI_CloseWindow ( $hWnd )
; Parameters.....: $hWnd   - Handle to the window to be minimized.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ CloseWindow
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CloseWindow($hWnd)

	Local $Ret = DllCall('user32.dll', 'int', 'CloseWindow', 'hwnd', $hWnd)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_CloseWindow

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ColorHLSToRGB
; Description....: Converts colors from hue-luminance-saturation (HLS) to RGB format.
; Syntax.........: _WinAPI_ColorHLSToRGB ( $iHue, $iLuminance, $iSaturation )
; Parameters.....: $iHue        - HLS hue value.
;                  $iLuminance  - HLS luminance value.
;                  $iSaturation - HLS saturation value.
; Return values..: Success      - Returns the RGB value.
;                  Failure      - (-1) and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ ColorHLSToRGB
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ColorHLSToRGB($iHue, $iLuminance, $iSaturation)

	If Not $iSaturation Then
		$iHue = 160
	EndIf

	Local $Ret = DllCall('shlwapi.dll', 'dword', 'ColorHLSToRGB', 'dword', $iHue, 'dword', $iLuminance, 'dword', $iSaturation)

	If @error Then
		Return SetError(1, 0, -1)
	EndIf
	Return __IsRGB($Ret[0])
EndFunc   ;==>_WinAPI_ColorHLSToRGB

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ColorRGBToHLS
; Description....: Converts colors from RGB to hue-luminance-saturation (HLS) format.
; Syntax.........: _WinAPI_ColorRGBToHLS ( $iRGB, ByRef $iHue, ByRef $iLuminance, ByRef $iSaturation )
; Parameters.....: $iRGB        - RGB color.
;                  $iHue        - HLS hue value.
;                  $iLuminance  - HLS luminance value.
;                  $iSaturation - HLS saturation value.
; Return values..: Success      - 1.
;                  Failure      - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ ColorRGBToHLS
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ColorRGBToHLS($iRGB, ByRef $iHue, ByRef $iLuminance, ByRef $iSaturation)

	Local $Ret = DllCall('shlwapi.dll', 'none', 'ColorRGBToHLS', 'dword', __IsRGB($iRGB), 'dword*', 0, 'dword*', 0, 'dword*', 0)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	$iHue = $Ret[2]
	$iLuminance = $Ret[3]
	$iSaturation = $Ret[4]
	Return 1
EndFunc   ;==>_WinAPI_ColorRGBToHLS

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CommandLineToArgv
; Description....: Parses a command line string and returns an array of the command line arguments.
; Syntax.........: _WinAPI_CommandLineToArgv ( $sCmd )
; Parameters.....: $sCmd   - The string that contains the full command line. If this parameter is an empty string the function returns
;                            an empty array (zeroth element is 0).
; Return values..: Success - The array of the command line arguments. The zeroth array element contains the number of arguments.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ CommandLineToArgvW
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CommandLineToArgv($sCmd)

	Local $Result[1] = [0]

	$sCmd = StringStripWS($sCmd, 3)
	If Not $sCmd Then
		Return $Result
	EndIf

	Local $Ret, $Struct, $tArg, $tCmd, $tPtr

	$Struct = 'wchar[' & (StringLen($sCmd) + 1) & ']'
	$tCmd = DllStructCreate($Struct)
	DllStructSetData($tCmd, 1, $sCmd)
	$Ret = DllCall('shell32.dll', 'ptr', 'CommandLineToArgvW', 'ptr', DllStructGetPtr($tCmd), 'int*', 0)
	If (@error) Or (Not $Ret[0]) Or (Not $Ret[2]) Then
		Return SetError(1, 0, 0)
	EndIf
	$tPtr = DllStructCreate('ptr[' & $Ret[2] & ']', $Ret[0])
	Dim $Result[$Ret[2] + 1] = [$Ret[2]]
	For $i = 1 To $Ret[2]
		$tArg = DllStructCreate($Struct, DllStructGetData($tPtr, 1, $i))
		If Not @error Then
			$Result[$i] = DllStructGetData($tArg, 1)
		Else
			$Result = 0
			ExitLoop
		EndIf
	Next
	_WinAPI_LocalFree($Ret[0])
	If Not IsArray($Result) Then
		Return SetError(2, 0, 0)
	EndIf
	Return $Result
EndFunc   ;==>_WinAPI_CommandLineToArgv

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CopyFileEx
; Description....: Copies an existing file to a new file, notifying the application of its progress through a callback function.
; Syntax.........: _WinAPI_CopyFileEx ( $sExistingFile, $sNewFile [, $iFlags [, $pProgressProc [, $pData] )
; Parameters.....: $sExistingFile - The name of an existing file.
;                  $sNewFile      - The name of the new file.
;                  $iFlags        - The flags that specify how the file is to be copied. This parameter can be a combination
;                                   of the following values.
;
;                                   $COPY_FILE_ALLOW_DECRYPTED_DESTINATION
;                                   $COPY_FILE_COPY_SYMLINK
;                                   $COPY_FILE_FAIL_IF_EXISTS
;                                   $COPY_FILE_NO_BUFFERING
;                                   $COPY_FILE_OPEN_SOURCE_FOR_WRITE
;                                   $COPY_FILE_RESTARTABLE
;
;                  $pProgressProc - The address of a callback function that is called each time another portion of the file
;                                   has been copied.
;
;                                   (See MSDN for more information)
;
;                  $pData         - The argument to be passed to the callback function.
; Return values..: Success        - 1.
;                  Failure        - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ CopyFileEx
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CopyFileEx($sExistingFile, $sNewFile, $iFlags = 0, $pProgressProc = 0, $pData = 0)

	Local $Ret = DllCall('kernel32.dll', 'int', 'CopyFileExW', 'wstr', $sExistingFile, 'wstr', $sNewFile, 'ptr', $pProgressProc, 'ptr', $pData, 'ptr', 0, 'dword', $iFlags)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_CopyFileEx

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CopyImage
; Description....: Creates a new image (icon, cursor, or bitmap) and copies the attributes of the specified image to the new one.
; Syntax.........: _WinAPI_CopyImage ( $hImage [, $iType [, $xDesired [, $yDesired [, $iFlags]]]] )
; Parameters.....: $hImage   - Handle to the image to be copied.
;                  $iType    - Specifies the type of image to be copied. This parameter can be one of the following values.
;
;                              $IMAGE_BITMAP
;                              $IMAGE_CURSOR
;                              $IMAGE_ICON
;
;                  $xDesired - Specifies the desired width, in pixels, of the image. If this is zero, then the returned image will
;                              have the same width as the original $hImage.
;                  $yDesired - Specifies the desired height, in pixels, of the image. If this is zero, then the returned image will
;                              have the same height as the original $hImage.
;                  $iFlags   - This parameter can be one or more of the following values.
;
;                              $LR_COPYDELETEORG
;                              $LR_COPYFROMRESOURCE
;                              $LR_COPYRETURNORG
;                              $LR_CREATEDIBSECTION
;                              $LR_DEFAULTSIZE
;                              $LR_MONOCHROME
;
; Return values..: Success   - Handle to the newly created image.
;                  Failure   - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: When you are finished using the resource, you can release its associated memory by calling _WinAPI_Free...
;                  function respectively for bitmaps, cursors, or icons. The system automatically deletes the resource when its
;                  process terminates, however, calling the appropriate function saves memory and decreases the size of the
;                  process's working set.
; Related........:
; Link...........: @@MsdnLink@@ CopyImage
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CopyImage($hImage, $iType = 0, $xDesired = 0, $yDesired = 0, $iFlags = 0)

	Local $Ret = DllCall('user32.dll', 'ptr', 'CopyImage', 'ptr', $hImage, 'int', $iType, 'int', $xDesired, 'int', $yDesired, 'int', $iFlags)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_CopyImage

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CopyRect
; Description....: Copies the coordinates of one rectangle to another.
; Syntax.........: _WinAPI_CopyRect ( $tRECT )
; Parameters.....: $tRECT  - $tagRECT structure whose coordinates are to be copied in logical units.
; Return values..: Success - $tagRECT structure that contains the logical coordinates of the source rectangle.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ CopyRect
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CopyRect($tRECT)

	Local $tData = DllStructCreate($tagRECT)
	Local $Ret = DllCall('user32.dll', 'int', 'CopyRect ', 'ptr', DllStructGetPtr($tData), 'ptr', DllStructGetPtr($tRECT))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $tData
EndFunc   ;==>_WinAPI_CopyRect

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CoTaskMemAlloc
; Description....: Allocates a block of task memory.
; Syntax.........: _WinAPI_CoTaskMemAlloc ( $iSize )
; Parameters.....: $iSize  - The size of the memory block to be allocated, in bytes.
; Return values..: Success - The allocated memory block.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: If $iSize is 0, _WinAPI_CoTaskMemAlloc() allocates a zero-length item and returns a valid pointer to that item.
;                  The allocated block may be larger than $iSize bytes because of the space required for alignment and for
;                  maintenance information.
; Related........:
; Link...........: @@MsdnLink@@ CoTaskMemAlloc
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CoTaskMemAlloc($iSize)

	Local $Ret = DllCall('ole32.dll', 'ptr', 'CoTaskMemAlloc', 'uint_ptr', $iSize)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_CoTaskMemAlloc

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CoTaskMemFree
; Description....: Frees a block of task memory.
; Syntax.........: _WinAPI_CoTaskMemFree ( $hMemory )
; Parameters.....: $hMemory - The pointer to the memory block to be freed.
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ CoTaskMemFree
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CoTaskMemFree($hMemory)

	Local $Ret = DllCall('ole32.dll', 'int', 'CoTaskMemFree', 'ptr', $hMemory)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_CoTaskMemFree

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CoTaskMemRealloc
; Description....: Changes the size of a previously allocated block of task memory.
; Syntax.........: _WinAPI_CoTaskMemRealloc ( $hMemory, $iSize )
; Parameters.....: $hMemory - The pointer to the memory block to be reallocated.
;                  $iSize   - The size of the memory block to be reallocated, in bytes.
; Return values..: Success  - The reallocated memory block.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: If $hMemory is 0, function allocates a new memory block in the same way as the _WinAPI_CoTaskMemAlloc() function.
;                  If $hMemory is not 0, it should be a pointer returned by a prior call to _WinAPI_CoTaskMemAlloc().
;
;                  The contents of the block are unchanged up to the shorter of the new and old sizes, although the new block
;                  can be in a different location. If $hMemory is not 0 and $iSize is 0, then the memory pointed to by
;                  $hMemory is freed.
; Related........:
; Link...........: @@MsdnLink@@ CoTaskMemRealloc
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CoTaskMemRealloc($hMemory, $iSize)

	Local $Ret = DllCall('ole32.dll', 'ptr', 'CoTaskMemRealloc', 'ptr', $hMemory, 'uint_ptr', $iSize)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_CoTaskMemRealloc

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CreateBrushIndirect
; Description....: Creates a logical brush that has the specified style, color, and pattern.
; Syntax.........: _WinAPI_CreateBrushIndirect ( $iStyle, $iRGB, $iHatch )
; Parameters.....: $iStyle - The brush style. This parameter can be one of the following styles.
;
;                            $BS_DIBPATTERN
;                            $BS_DIBPATTERN8X8
;                            $BS_DIBPATTERNPT
;                            $BS_HATCHED
;                            $BS_HOLLOW
;                            $BS_NULL
;                            $BS_PATTERN
;                            $BS_PATTERN8X8
;                            $BS_SOLID
;
;                  $iRGB   - The color of a brush, in RGB, or one of the following values.
;
;                            $DIB_PAL_COLORS
;                            $DIB_RGB_COLORS
;
;                  $iHatch - A hatch style. The meaning depends on the brush style defined by $iStyle parameter.
;
;                            $BS_DIBPATTERN
;                            Contains a handle to a packed DIB.
;
;                            $BS_DIBPATTERNPT
;                            Contains a pointer to a packed DIB.
;
;                            $BS_HATCHED
;                            Specifies the orientation of the lines used to create the hatch. It can be one of the orientation constants ($HS_...).
;
;                            $BS_PATTERN
;                            Contains a handle to the bitmap that defines the pattern. The bitmap cannot be a DIB section bitmap.
;
;                            $BS_HOLLOW, $BS_SOLID
;                            Ignored.
;
; Return values..: Success - The value identifies a logical brush.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: After an application creates a brush by calling _WinAPI_CreateBrushIndirect(), it can select it into any
;                  device context by calling the _WinAPI_SelectObject() function. When you no longer need the brush,
;                  call the _WinAPI_FreeObject() function to delete it.
; Related........:
; Link...........: @@MsdnLink@@ CreateBrushIndirect
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CreateBrushIndirect($iStyle, $iRGB, $iHatch = 0)

	Local $tLOGBRUSH = DllStructCreate($tagLOGBRUSH)

	DllStructSetData($tLOGBRUSH, 1, $iStyle)
	DllStructSetData($tLOGBRUSH, 2, __IsRGB($iRGB))
	DllStructSetData($tLOGBRUSH, 3, $iHatch)

	Local $Ret = DllCall('gdi32.dll', 'int', 'CreateBrushIndirect', 'ptr', DllStructGetPtr($tLOGBRUSH))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_CreateBrushIndirect

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CreateCaret
; Description....: Creates a new shape for the system caret and assigns ownership of the caret to the specified window.
; Syntax.........: _WinAPI_CreateCaret ( $hWnd, $hBitmap [, $iWidth [, $iHeight]] )
; Parameters.....: $hWnd    - Handle to the window that owns the caret.
;                  $hBitmap - Handle to the bitmap that defines the caret shape. If this parameter is 0, the caret is solid.
;                             If this parameter is 1, the caret is gray. If this parameter is a bitmap handle, the caret is
;                             the specified bitmap.
;                  $iWidth  - The width of the caret in logical units. If this parameter is 0, the width is set to the system-defined
;                             window border width. If $hBitmap is a bitmap handle, _WinAPI_CreateCaret() ignores this parameter.
;                  $iHeight - The height of the caret in logical units. If this parameter is 0, the height is set to the system-defined
;                             window border height. If $hBitmap  is a bitmap handle, _WinAPI_CreateCaret() ignores this parameter.
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: _WinAPI_CreateCaret() automatically destroys the previous caret shape, if any, regardless of the window that owns the caret.
;                  The caret is hidden until the application calls the _WinAPI_ShowCaret() function to make the caret visible.
;
;                  The system provides one caret per queue. A window should create a caret only when it has the keyboard focus or is active.
;                  The window should destroy the caret before losing the keyboard focus or becoming inactive.
;
;                  You can retrieve the width or height of the system's window border by using the _WinAPI_GetSystemMetrics() function,
;                  specifying the $SM_CXBORDER and $SM_CYBORDER values. Using the window border width or height guarantees that the
;                  caret will be visible on a high-resolution screen.
; Related........:
; Link...........: @@MsdnLink@@ CreateCaret
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CreateCaret($hWnd, $hBitmap, $iWidth = 0, $iHeight = 0)

	Local $Ret = DllCall('user32.dll', 'int', 'CreateCaret', 'hwnd', $hWnd, 'ptr', $hBitmap, 'int', $iWidth, 'int', $iHeight)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_CreateCaret

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CreateCompatibleBitmapEx
; Description....: Creates a bitmap compatible with the device and fills it the specified color.
; Syntax.........: _WinAPI_CreateSolidBitmapEx ( $hDC, $iWidth, $iHeight, $iRGB )
; Parameters.....: $hDC     - Handle to a device context.
;                  $iWidht  - The bitmap width, in pixels.
;                  $iHeight - The bitmap height, in pixels.
;                  $iRGB    - The bitmap color, in RGB.
; Return values..: Success  - Handle to the compatible solid bitmap (DDB).
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The color format of the bitmap created by the _WinAPI_CreateCompatibleBitmapEx() function matches the color
;                  format of the device identified by the hdc parameter. This bitmap can be selected into any memory device context
;                  that is compatible with the original device.
;
;                  When you no longer need the bitmap, call the _WinAPI_FreeObject() function to delete it.
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CreateCompatibleBitmapEx($hDC, $iWidth, $iHeight, $iRGB)

	Local $Ret, $tRECT, $hBmp, $hBrush, $hDestDC, $hDestSv

	$hBrush = _WinAPI_CreateBrushIndirect($BS_SOLID, $iRGB)
	$Ret = DllCall('gdi32.dll', 'hwnd', 'CreateCompatibleDC', 'hwnd', $hDC)
	$hDestDC = $Ret[0]
	$Ret = DllCall('gdi32.dll', 'hwnd', 'CreateCompatibleBitmap', 'hwnd', $hDC, 'int', $iWidth, 'int', $iHeight)
	$hBmp = $Ret[0]
	$Ret = DllCall('gdi32.dll', 'hwnd', 'SelectObject', 'hwnd', $hDestDC, 'ptr', $hBmp)
	$hDestSv = $Ret[0]
	$tRECT = _WinAPI_CreateRectEx(0, 0, $iWidth, $iHeight)
	$Ret = DllCall('user32.dll', 'int', 'FillRect', 'hwnd', $hDestDC, 'ptr', DllStructGetPtr($tRECT), 'ptr', $hBrush)
	If (@error) Or (Not $Ret[0]) Then
		_WinAPI_FreeObject($hBmp)
		$Ret = 0
	EndIf
	_WinAPI_FreeObject($hBrush)
	DllCall('gdi32.dll', 'ptr', 'SelectObject', 'hwnd', $hDestDC, 'ptr', $hDestSv)
	DllCall('gdi32.dll', 'int', 'DeleteDC', 'hwnd', $hDestDC)
	If Not IsArray($Ret) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $hBmp
EndFunc   ;==>_WinAPI_CreateCompatibleBitmapEx

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CreateDIBSection
; Description....: Creates a DIB that applications can write to directly.
; Syntax.........: _WinAPI_CreateDIBSection ( $hDC, $tBITMAPINFO, $iUsage, ByRef $pBits [, $hSection [, $iOffset]] )
; Parameters.....: $hDC         - Handle to a device context. If the value of $iUsage is $DIB_PAL_COLORS, the function uses this
;                                 device context's logical palette to initialize the DIB colors.
;                  $tBITMAPINFO - $tagBITMAPINFO structure that specifies various attributes of the DIB, including the bitmap
;                                 dimensions and colors.
;                  $iUsage      - The type of data contained in the $pBits array. (either logical palette indexes or literal RGB values).
;                                 The following values are defined.
;
;                                 $DIB_PAL_COLORS
;                                 $DIB_RGB_COLORS
;
;                  $pBits       - Pointer to a variable that receives a pointer to the location of the DIB bit values.
;                  $hSection    - Handle to a file-mapping object that the function will use to create the DIB.
;                  $iOffset     - The offset from the beginning of the file-mapping object referenced by $hSection where storage
;                                 for the bitmap bit values is to begin. This value is ignored if $hSection is 0.
; Return values..: Success      - Handle to the newly created DIB, and $pBits points to the bitmap bit values. You can create the
;                                 structure by using $pBits pointer to further its filling. For example,
;                                 DllStructCreate('dword[4]', $pBits).
;                  Failure      - 0 and sets the @error flag to non-zero, $pBits also is 0.
; Author.........: Yashied
; Modified.......:
; Remarks........: When you are finished using the icon, destroy it using the _WinAPI_FreeIcon() function.
; Related........:
; Link...........: @@MsdnLink@@ CreateDIBSection
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CreateDIBSection($hDC, $tBITMAPINFO, $iUsage, ByRef $pBits, $hSection = 0, $iOffset = 0)

	Local $Ret = DllCall('gdi32.dll', 'ptr', 'CreateDIBSection', 'hwnd', $hDC, 'ptr', DllStructGetPtr($tBITMAPINFO), 'uint', $iUsage, 'ptr*', 0, 'ptr', $hSection, 'dword', $iOffset)

	If (@error) Or (Not $Ret[0]) Then
		$pBits = 0
	Else
		$pBits = $Ret[4]
	EndIf
	Return SetError(Number(Not $Ret[0]), 0, $Ret[0])
EndFunc   ;==>_WinAPI_CreateDIBSection

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CreateEllipticRgn
; Description....: Creates an elliptical region.
; Syntax.........: _WinAPI_CreateEllipticRgn ( $tRECT )
; Parameters.....: $tRECT  - $tagRECT structure that contains the coordinates of the upper-left and lower-right corners of the
;                            bounding rectangle of the ellipse in logical units.
; Return values..: Success - The handle to the region.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: A bounding rectangle defines the size, shape, and orientation of the region: The long sides of the rectangle
;                  define the length of the ellipse's major axis; the short sides define the length of the ellipse's minor axis;
;                  and the center of the rectangle defines the intersection of the major and minor axes.
;
;                  When you no longer need the HRGN object, call the _WinAPI_FreeObject() function to delete it.
; Related........:
; Link...........: @@MsdnLink@@ CreateEllipticRgnIndirect
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CreateEllipticRgn($tRECT)

	Local $Ret = DllCall('gdi32.dll', 'ptr', 'CreateEllipticRgnIndirect', 'ptr', DllStructGetPtr($tRECT))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_CreateEllipticRgn

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CreateFileEx
; Description....: Creates or opens a file or I/O device.
; Syntax.........: _WinAPI_CreateFileEx ( $sFile, $iCreation, $iAccess, $iShare [, $iFlagsAndAttributes [, $tSecurity [, $hTemplate]]] )
; Parameters.....: $sFile               - The name of the file or device to be created or opened.
;                  $iCreation           - The action to take on a file or device that exists or does not exist. This parameter
;                                         must be one of the following values, which cannot be combined.
;
;                                         $CREATE_NEW
;                                         $CREATE_ALWAYS
;                                         $OPEN_EXISTING
;                                         $OPEN_ALWAYS
;                                         $TRUNCATE_EXISTING
;
;                  $iAccess             - The requested access to the file or device, which can be summarized as read, write,
;                                         both or neither (zero).
;
;                                         $GENERIC_READ
;                                         $GENERIC_WRITE
;
;                  $iShare              - The requested sharing mode of the file or device, which can be read, write, both,
;                                         delete, all of these, or none. If this parameter is 0 and _WinAPI_CreateFileEx()
;                                         succeeds, the file or device cannot be shared and cannot be opened again until the
;                                         handle to the file or device is closed.
;
;                                         $FILE_SHARE_READ
;                                         $FILE_SHARE_WRITE
;                                         $FILE_SHARE_DELETE
;
;                  $iFlagsAndAttributes - The file or device attributes and flags. This parameter can be one or more of the
;                                         following values.
;
;                                         $FILE_ATTRIBUTE_READONLY
;                                         $FILE_ATTRIBUTE_HIDDEN
;                                         $FILE_ATTRIBUTE_SYSTEM
;                                         $FILE_ATTRIBUTE_DIRECTORY
;                                         $FILE_ATTRIBUTE_ARCHIVE
;                                         $FILE_ATTRIBUTE_DEVICE
;                                         $FILE_ATTRIBUTE_NORMAL
;                                         $FILE_ATTRIBUTE_TEMPORARY
;                                         $FILE_ATTRIBUTE_SPARSE_FILE
;                                         $FILE_ATTRIBUTE_REPARSE_POINT
;                                         $FILE_ATTRIBUTE_COMPRESSED
;                                         $FILE_ATTRIBUTE_OFFLINE
;                                         $FILE_ATTRIBUTE_NOT_CONTENT_INDEXED
;                                         $FILE_ATTRIBUTE_ENCRYPTED
;
;                                         $FILE_FLAG_BACKUP_SEMANTICS
;                                         $FILE_FLAG_DELETE_ON_CLOSE
;                                         $FILE_FLAG_NO_BUFFERING
;                                         $FILE_FLAG_OPEN_NO_RECALL
;                                         $FILE_FLAG_OPEN_REPARSE_POINT
;                                         $FILE_FLAG_OVERLAPPED
;                                         $FILE_FLAG_POSIX_SEMANTICS
;                                         $FILE_FLAG_RANDOM_ACCESS
;                                         $FILE_FLAG_SEQUENTIAL_SCAN
;                                         $FILE_FLAG_WRITE_THROUGH
;
;                                         $SECURITY_ANONYMOUS
;                                         $SECURITY_IDENTIFICATION
;                                         $SECURITY_IMPERSONATION
;                                         $SECURITY_DELEGATION
;                                         $SECURITY_CONTEXT_TRACKING
;                                         $SECURITY_EFFECTIVE_ONLY
;
;                  $tSecurity           - $tagSECURITY_ATTRIBUTES structure that contains two separate but related data members:
;                                         an optional security descriptor, and a Boolean value that determines whether the returned
;                                         handle can be inherited by child processes.
;                  $hTemplate           - Handle to a template file with the $GENERIC_READ access right. The template file supplies
;                                         file attributes and extended attributes for the file that is being created.
; Return values..: Success              - Handle to the specified file, device, named pipe, or mail slot.
;                  Failure              - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ CreateFile
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CreateFileEx($sFile, $iCreation, $iAccess, $iShare, $iFlagsAndAttributes = 0, $tSecurity = 0, $hTemplate = 0)

	Local $Ret = DllCall('kernel32.dll', 'ptr', 'CreateFileW', 'wstr', $sFile, 'dword', $iAccess, 'dword', $iShare, 'ptr', DllStructGetPtr($tSecurity), 'dword', $iCreation, 'dword', $iFlagsAndAttributes, 'ptr', $hTemplate)

	If (@error) Or ($Ret[0] = -1) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_CreateFileEx

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CreateGUID
; Description....: Creates a globally unique identifier (GUID).
; Syntax.........: _WinAPI_CreateGUID ( )
; Parameters.....: None
; Return values..: Success - The string representation of the GUID.
;                  Failure - Empty string and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CreateGUID()

	Local $tData = DllStructCreate('wchar[39]')
	Local $tGUID = DllStructCreate($tagGUID)
	Local $Ret

	$Ret = DllCall('ole32.dll', 'uint', 'CoCreateGuid', 'ptr', DllStructGetPtr($tGUID))
	If @error Then
		Return SetError(1, 0, '')
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	$Ret = DllCall('ole32.dll', 'int', 'StringFromGUID2', 'ptr', DllStructGetPtr($tGUID), 'ptr', DllStructGetPtr($tData), 'int', 39)
	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, '')
	EndIf
	Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_CreateGUID

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CreateIconIndirect
; Description....: Creates an icon or cursor that has the specified size, colors, and bit patterns.
; Syntax.........: _WinAPI_CreateIconIndirect ( $hBitmap, $hMask [, $XHotspot [, $YHotspot [, $fIcon]]] )
; Parameters.....: $hBitmap  - Handle to the icon color bitmap.
;                  $hMask    - Handle to the icon bitmask bitmap.
;                  $XHotspot - Specifies the x-coordinate of a cursor's hot spot. If creates an icon, the hot spot is always in
;                              the center of the icon, and this member is ignored.
;                  $YHotspot - Specifies the y-coordinate of the cursor's hot spot. If creates an icon, the hot spot is always in
;                              the center of the icon, and this member is ignored.
;                  $fIcon    - Specifies whether creates an icon or a cursor, valid values:
;                  |TRUE     - Creates an icon. (Default)
;                  |FALSE    - Creates a cursor.
; Return values..: Success   - Handle to the icon or cursor that is created.
;                  Failure   - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The system copies the bitmaps before creating the icon or cursor. Because the system may temporarily
;                  select the bitmaps in a device context, $hBitmap and $hMask should not already be selected into a device context.
;                  The application must continue to manage the original bitmaps and delete them by _WinAPI_FreeObject() when they
;                  are no longer necessary.
; Related........:
; Link...........: @@MsdnLink@@ CreateIconIndirect
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CreateIconIndirect($hBitmap, $hMask, $XHotspot = 0, $YHotspot = 0, $fIcon = 1)

	Local $tICONINFO = DllStructCreate($tagICONINFO)

	DllStructSetData($tICONINFO, 1, $fIcon)
	DllStructSetData($tICONINFO, 2, $XHotspot)
	DllStructSetData($tICONINFO, 3, $YHotspot)
	DllStructSetData($tICONINFO, 4, $hMask)
	DllStructSetData($tICONINFO, 5, $hBitmap)

	Local $Ret = DllCall('user32.dll', 'ptr', 'CreateIconIndirect', 'ptr', DllStructGetPtr($tICONINFO))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_CreateIconIndirect

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CreateJobObject
; Description....: Creates or opens a job object.
; Syntax.........: _WinAPI_CreateJobObject ( [$sName [, $tSecurity] )
; Parameters.....: $sName     - The name of the job. Name comparison is case-sensitive. If this parameter is 0, the job is
;                               created without a name.
;                  $tSecurity - $tagSECURITY_ATTRIBUTES structure that specifies the security descriptor for the job object
;                               and determines whether child processes can inherit the returned handle. If this parameter is 0,
;                               the job object gets a default security descriptor and the handle cannot be inherited.
; Return values..: Success    - Handle to the job object. If the object existed before the function call, the function
;                               returns a handle to the existing job object.
;                  Failure    - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: When a job is created, its accounting information is initialized to zero, all limits are inactive, and there
;                  are no associated processes. To assign a process to a job object, use the _WinAPI_AssignProcessToJobObject()
;                  function. To set limits for a job, use the _WinAPI_SetInformationJobObject() function. To query accounting
;                  information, use the _WinAPI_QueryInformationJobObject() function.
;
;                  All processes associated with a job must run in the same session. A job is associated with the session of the
;                  first process to be assigned to the job.
;
;                  To close a job object handle, use the _WinAPI_FreeHandle() function. The job is destroyed when its last
;                  handle has been closed and all associated processes have exited.
; Related........:
; Link...........: @@MsdnLink@@ CreateJobObject
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CreateJobObject($sName = '', $tSecurity = 0)

	Local $TypeOfName = 'wstr'

	If Not StringStripWS($sName, 3) Then
		$TypeOfName = 'ptr'
		$sName = 0
	EndIf

	Local $Ret = DllCall('kernel32.dll', 'int', 'CreateJobObjectW', 'ptr', $tSecurity, $TypeOfName, $sName)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_CreateJobObject

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CreateMRUList
; Description....: Creates a new most recently used (MRU) list.
; Syntax.........: _WinAPI_CreateMRUList ( $hKey, $sSubKey [, $iFlag [, $iMax [, $pCompare]]] )
; Parameters.....: $hKey     - Handle to the currently open key, or one of the following predefined values under which to store the MRU data.
;
;                              $HKEY_CURRENT_USER
;                              $HKEY_LOCAL_MACHINE
;
;                  $sSubKey  - The subkey under which to store the MRU data.
;                  $iFlag    - This parameter can have one of the following values.
;
;                              $MRU_BINARY
;                              $MRU_CACHEWRITE
;
;                  $iMax     - The maximum number of entries in the MRU list. Default is 26 (A..Z).
;                  $pCompare - The pointer to an optional data comparison function that can be used to determine whether an item is
;                              present in the MRU list. This is useful when the MRU list was created with the $MRU_BINARY flag.
;                              If this member is 0, standard string comparison functions are used; for binary data, a direct memory
;                              comparison is used.
; Return values..: Success   - Handle to the new MRU list.
;                  Failure   - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ CreateMRUListW
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CreateMRUList($hKey, $sSubKey, $iFlag = 0, $iMax = 26, $pCompare = 0)

	Local $tMRUINFO = DllStructCreate('dword;uint;uint;ulong_ptr;ptr;ptr')
	Local $tSubKey = DllStructCreate('wchar[' & (StringLen($sSubKey) + 1) & ']')

	DllStructSetData($tMRUINFO, 1, DllStructGetSize($tMRUINFO))
	DllStructSetData($tMRUINFO, 2, $iMax)
	DllStructSetData($tMRUINFO, 3, $iFlag)
	DllStructSetData($tMRUINFO, 4, $hKey)
	DllStructSetData($tMRUINFO, 5, DllStructGetPtr($tSubKey))
	DllStructSetData($tMRUINFO, 6, $pCompare)

	DllStructSetData($tSubKey, 1, $sSubKey)

	Local $Ret = DllCall('comctl32.dll ', 'int', 'CreateMRUListW', 'ptr', DllStructGetPtr($tMRUINFO))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_CreateMRUList

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CreatePolygonRgn
; Description....: Creates a polygonal region.
; Syntax.........: _WinAPI_CreatePolygonRgn ( $aPoint [, $iStart [, $iEnd [, $iMode]]] )
; Parameters.....: $aPoint - The 2D array ([x1, y1], [x2, y2], ... [xN, yN]) that contains the vertices of the polygon in logical
;                            units. The polygon is presumed closed. Each vertex can be specified only once.
;                  $iStart - The index of array to start creating at.
;                  $iEnd   - The index of array to stop creating at.
;                  $iMode  - The fill mode used to determine which pixels are in the region. This parameter can be one of the
;                            following values.
;
;                            $ALTERNATE
;                            $WINDING
;
; Return values..: Success - The handle to the region.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: When you no longer need the HRGN object, call the _WinAPI_FreeObject() function to delete it.
; Related........:
; Link...........: @@MsdnLink@@ CreatePolygonRgn
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CreatePolygonRgn($aPoint, $iStart = 0, $iEnd = -1, $iMode = 1)

	If UBound($aPoint, 2) < 2  Then
		Return SetError(2, 0, 0)
	EndIf

	Local $Count, $tData, $Struct = ''

	If $iStart < 0 Then
		$iStart = 0
	EndIf
	If ($iEnd < 0) Or ($iEnd > UBound($aPoint) - 1) Then
		$iEnd = UBound($aPoint) - 1
	EndIf
	For $i = $iStart To $iEnd
		$Struct &= 'int[2];'
	Next
	$tData = DllStructCreate($Struct)
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	$Count = 1
	For $i = $iStart To $iEnd
		For $j = 0 To 1
			DllStructSetData($tData, $Count, $aPoint[$i][$j], $j + 1)
		Next
		$Count += 1
	Next

	Local $Ret = DllCall('gdi32.dll', 'ptr', 'CreatePolygonRgn', 'ptr', DllStructGetPtr($tData), 'int', $Count - 1, 'int', $iMode)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_CreatePolygonRgn

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CreateRect
; Description....: Creates $tagRECT structure with the coordinates of the specified rectangle.
; Syntax.........: _WinAPI_CreateRect ( $iLeft, $iTop, $iRight, $iBottom )
; Parameters.....: $iLeft   - The x-coordinate of the upper-left corner of the rectangle.
;                  $iTop    - The y-coordinate of the upper-left corner of the rectangle.
;                  $iRight  - The x-coordinate of the lower-right corner of the rectangle.
;                  $iBottom - The y-coordinate of the lower-right corner of the rectangle.
; Return values..: Success  - $tagRECT structure that contains the specified rectangle.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CreateRect($iLeft, $iTop, $iRight, $iBottom)

	Local $tRECT = DllStructCreate($tagRECT)

	DllStructSetData($tRECT, 1, $iLeft)
	DllStructSetData($tRECT, 2, $iTop)
	DllStructSetData($tRECT, 3, $iRight)
	DllStructSetData($tRECT, 4, $iBottom)

	Return $tRECT
EndFunc   ;==>_WinAPI_CreateRect

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CreateRectEx
; Description....: Creates $tagRECT structure with the coordinates of the specified rectangle.
; Syntax.........: _WinAPI_CreateRectEx ( $iX, $iY, $iWidth, $iHeight )
; Parameters.....: $iX      - The x-coordinate of the upper-left corner of the rectangle.
;                  $iY      - The y-coordinate of the upper-left corner of the rectangle.
;                  $iWidth  - The width of the rectangle.
;                  $iHeight - The height of the rectangle.
; Return values..: Success  - $tagRECT structure that contains the specified rectangle.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CreateRectEx($iX, $iY, $iWidth, $iHeight)

	Local $tRECT = DllStructCreate($tagRECT)

	DllStructSetData($tRECT, 1, $iX)
	DllStructSetData($tRECT, 2, $iY)
	DllStructSetData($tRECT, 3, $iX + $iWidth)
	DllStructSetData($tRECT, 4, $iY + $iHeight)

	Return $tRECT
EndFunc   ;==>_WinAPI_CreateRectEx

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CreateRectRgnIndirect
; Description....: Creates a rectangular region.
; Syntax.........: _WinAPI_CreateRectRgnIndirect ( $tRECT )
; Parameters.....: $tRECT  - $tagRECT structure that contains the coordinates of the upper-left and lower-right corners of the
;                            rectangle that defines the region in logical units.
; Return values..: Success - The handle to the region.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: When you no longer need the HRGN object, call the _WinAPI_FreeObject() function to delete it.
; Related........:
; Link...........: @@MsdnLink@@ CreateRectRgnIndirect
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CreateRectRgnIndirect($tRECT)

	Local $Ret = DllCall('gdi32.dll', 'ptr', 'CreateRectRgnIndirect', 'ptr', DllStructGetPtr($tRECT))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_CreateRectRgnIndirect

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CreateSemaphore
; Description....: Creates or opens a named or unnamed semaphore object.
; Syntax.........: _WinAPI_CreateSemaphore ( $sSemaphore, $iInitial, $iMaximum )
; Parameters.....: $sSemaphore - The name of the semaphore to be opened. Name comparisons are case sensitive.
;                  $iInitial   - The initial count for the semaphore object. This value must be greater than or equal to zero and
;                                less than or equal to $iMaximum.
;                  $iMaximum   - The maximum count for the semaphore object. This value must be greater than zero.
; Return values..: Success     - The handle to the semaphore object. If the named semaphore object existed before the function call,
;                                the function returns a handle to the existing object.
;                  Failure     - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: Any process can specify the semaphore-object handle in a call to _WinAPI_WaitFor... functions. The single-object
;                  wait functions return when the state of the specified object is signaled. The multiple-object wait functions can
;                  be instructed to return either when any one or when all of the specified objects are signaled. When a wait function
;                  returns, the waiting process is released to continue its execution.
;
;                  The state of a semaphore object is signaled when its count is greater than zero, and nonsignaled when its count
;                  is equal to zero. The $iInitial parameter specifies the initial count. Each time a waiting process is released
;                  because of the semaphore's signaled state, the count of the semaphore is decreased by one. Use the _WinAPI_ReleaseSemaphore()
;                  function to increment a semaphore's count by a specified amount. The count can never be less than zero or greater
;                  than the value specified in the $iMaximum parameter.
; Link...........: @@MsdnLink@@ CreateSemaphore
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CreateSemaphore($sSemaphore, $iInitial, $iMaximum)

	Local $Ret = DllCall('kernel32.dll', 'ptr', 'CreateSemaphoreW', 'ptr', 0, 'int', $iInitial, 'int', $iMaximum, 'wstr', $sSemaphore)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_CreateSemaphore

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CreateStreamOnHGlobal
; Description....: Creates a stream object that uses a memory handle to store the stream contents.
; Syntax.........: _WinAPI_CreateStreamOnHGlobal ( $hGlobal [, $fDeleteOnRelease] )
; Parameters.....: $hGlobal          - The memory handle, or if 0 a new handle is to be allocated instead. The handle must be
;                                      allocated as moveable and nondiscardable.
;                  $fDeleteOnRelease - Specifies whether the underlying handle for this stream object should be automatically
;                                      freed when the stream object is released, valid values:
;                  |TRUE             - The final release will automatically free the $hGlobal parameter. (Default)
;                  |FALSE            - The user must free the $hGlobal after the final release.
; Return values..: Success           - The pointer to the new stream object.
;                  Failure           - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: If $hGlobal is 0, the function allocates a new memory handle and the stream is initially empty, otherwise, the
;                  initial contents of the stream are the current contents of the memory block. Thus, _WinAPI_CreateStreamOnHGlobal()
;                  can be used to open an existing stream in memory. The memory handle and its contents are undisturbed by the
;                  creation of the new stream object.
;
;                  After creating the stream object with _WinAPI_CreateStreamOnHGlobal(), call _WinAPI_GetHGlobalFromStream() to
;                  retrieve the memory handle associated with the stream object.
; Related........:
; Link...........: @@MsdnLink@@ CreateStreamOnHGlobal
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_CreateStreamOnHGlobal($hGlobal, $fDeleteOnRelease = 1)

	Local $Ret = DllCall('ole32.dll', 'uint', 'CreateStreamOnHGlobal', 'ptr', $hGlobal, 'int', $fDeleteOnRelease, 'ptr*', 0)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return $Ret[3]
EndFunc   ;==>_WinAPI_CreateStreamOnHGlobal

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DefineDosDevice
; Description....: Defines, redefines, or deletes MS-DOS device names.
; Syntax.........: _WinAPI_DefineDosDevice ( $sDevice, $iFlags [, $sPath] )
; Parameters.....: $sDevice - The name of the MS-DOS device.
;                  $iFlags  - This parameter can be one or more of the following values.
;
;                             $DDD_EXACT_MATCH_ON_REMOVE
;                             $DDD_NO_BROADCAST_SYSTEM
;                             $DDD_RAW_TARGET_PATH
;                             $DDD_REMOVE_DEFINITION
;
;                  $sPath   - The path that will implement device.
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ DefineDosDevice
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DefineDosDevice($sDevice, $iFlags, $sPath = '')

	Local $TypeOfPath = 'wstr'

	If Not StringStripWS($sPath, 3) Then
		$TypeOfPath = 'ptr'
		$sPath = 0
	EndIf

	Local $Ret = DllCall('kernel32.dll', 'int', 'DefineDosDeviceW', 'dword', $iFlags, 'wstr', $sDevice, $TypeOfPath, $sPath)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_DefineDosDevice

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DeleteVolumeMountPoint
; Description....: Deletes a drive letter or mounted folder.
; Syntax.........: _WinAPI_DeleteVolumeMountPoint ( $sPath )
; Parameters.....: $sPath  - The drive letter or mounted folder to be deleted (for example, X:\ or Y:\MountX\).
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: Deleting a mounted folder does not cause the underlying directory to be deleted.
; Related........:
; Link...........: @@MsdnLink@@ DeleteVolumeMountPoint
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DeleteVolumeMountPoint($sPath)

	Local $Ret = DllCall('kernel32.dll', 'int', 'DeleteVolumeMountPointW', 'wstr', $sPath)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_DeleteVolumeMountPoint

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DeregisterShellHookWindow
; Description....: Unregisters a specified Shell window that is registered to receive Shell hook messages.
; Syntax.........: _WinAPI_DeregisterShellHookWindow ( $hWnd )
; Parameters.....: $hWnd   - Handle to the window to unregister from receiving Shell hook messages.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ DeregisterShellHookWindow
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DeregisterShellHookWindow($hWnd)

	Local $Ret = DllCall('user32.dll', 'int', 'DeregisterShellHookWindow', 'hwnd', $hWnd)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_DeregisterShellHookWindow

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DestroyCaret
; Description....: Destroys the caret's current shape, frees the caret from the window, and removes the caret from the screen.
; Syntax.........: _WinAPI_DestroyCaret ( )
; Parameters.....: None
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: _WinAPI_DestroyCaret() destroys the caret only if a window in the current task owns the caret. If a window that
;                  is not in the current task owns the caret, _WinAPI_DestroyCaret() does nothing and returns 0.
;
;                  The window should destroy the caret before losing the keyboard focus or becoming inactive.
; Related........:
; Link...........: @@MsdnLink@@ DestroyCaret
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DestroyCaret()

	Local $Ret = DllCall('user32.dll', 'int', 'DestroyCaret')

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_DestroyCaret

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DeviceIoControl
; Description....: Sends a control code directly to a specified device driver.
; Syntax.........: _WinAPI_DeviceIoControl ( $hDevice, $iControlCode [, $pInBuffer [, $iInBufferSize [, $pOutBuffer [, $iOutBufferSize]]]] )
; Parameters.....: $hDevice        - Handle to the device on which the operation is to be performed. The device is typically a volume,
;                                    directory, file, or stream. To retrieve a device handle, use the _WinAPI_CreateFileEx function.
;                                    To specify a device name, use the following format:
;
;                                    _WinAPI_CreateFileEx("\\.\DeviceName", ...)
;
;                  $iControlCode   - The control code for the operation. This value identifies the specific operation to be performed
;                                    and the type of device on which to perform it.
;                  $pInBuffer      - A pointer to the input buffer that contains the data required to perform the operation.
;                  $iInBufferSize  - The size of the input buffer, in bytes.
;                  $pOutBuffer     - A pointer to the output buffer that is to receive the data returned by the operation.
;                  $iOutBufferSize - The size of the output buffer, in bytes.
; Return values..: Success - 1 and @extended flag contains the size of the data stored in the output buffer, in bytes.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ DeviceIoControl
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DeviceIoControl($hDevice, $iControlCode, $pInBuffer = 0, $iInBufferSize = 0, $pOutBuffer = 0, $iOutBufferSize = 0)

	Local $Ret = DllCall('kernel32.dll', 'int', 'DeviceIoControl', 'ptr', $hDevice, 'dword', $iControlCode, 'ptr', $pInBuffer, 'dword', $iInBufferSize, 'ptr', $pOutBuffer, 'dword', $iOutBufferSize, 'dword*', 0, 'ptr', 0)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return SetError(0, $Ret[7], 1)
EndFunc   ;==>_WinAPI_DeviceIoControl

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DllInstall
; Description....: Registers OLE controls such as DLL or ActiveX Controls (OCX) files.
; Syntax.........: _WinAPI_DllInstall ( $sPath )
; Parameters.....: $sPath  - Path to the DLL file that will be registered.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DllInstall($sPath)

    Local $Ret = RunWait(@SystemDir & '\regsvr32.exe /s ' & $sPath)

    If (@error) Or ($Ret) Then
		Return SetError(1, 0, 0)
	EndIf
    Return 1
EndFunc   ;==>_WinAPI_DllInstall

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DllUninstall
; Description....: Unregisters OLE controls such as DLL or ActiveX Controls (OCX) files.
; Syntax.........: _WinAPI_DllUninstall ( $sPath )
; Parameters.....: $sPath  - Path to the DLL file that will be unregistered.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DllUninstall($sPath)

    Local $Ret = RunWait(@SystemDir & '\regsvr32.exe /s /u ' & $sPath)

    If (@error) Or ($Ret) Then
		Return SetError(1, 0, 0)
	EndIf
    Return 1
EndFunc   ;==>_WinAPI_DllUninstall

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DragAcceptFiles
; Description....: Registers whether a window accepts dropped files.
; Syntax.........: _WinAPI_DragAcceptFiles ( $hWnd [, $fAccept] )
; Parameters.....: $hWnd    - Handle to the window that is registering whether it will accept dropped files.
;                  $fAccept - Specifies whether a window accepts dropped files, valid values:
;                  |TRUE    - Accept dropped files. (Default)
;                  |FALSE   - Discontinue accepting dropped files.
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ DragAcceptFiles
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DragAcceptFiles($hWnd, $fAccept = 1)
	DllCall('shell32.dll', 'none', 'DragAcceptFiles', 'hwnd', $hWnd, 'int', $fAccept)
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_DragAcceptFiles

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DragFinish
; Description....: Releases memory that the system allocated for use in transferring file names to the application.
; Syntax.........: _WinAPI_DragFinish ( $hDrop )
; Parameters.....: $hDrop  - Handle of the drop structure that describes the dropped file. This parameter is passed to
;                            WM_DROPFILES message with WPARAM parameter.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ DragFinish
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DragFinish($hDrop)
	DllCall('shell32.dll', 'none', 'DragFinish', 'ptr', $hDrop)
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_DragFinish

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DragQueryFileEx
; Description....: Retrieves the names of dropped files that result from a successful drag-and-drop operation.
; Syntax.........: _WinAPI_DragQueryFileEx ( $hDrop [, $iFlag] )
; Parameters.....: $hDrop  - Handle of the drop structure that describes the dropped file. This parameter is passed to
;                            WM_DROPFILES message with WPARAM parameter.
;                  $iFlag  - The flag that specifies whether to return files folders or both, valid values:
;                  |0 - Return both files and folders. (Default)
;                  |1 - Return files only.
;                  |2 - Return folders only.
; Return values..: Success - The array of the names of a dropped files. The zeroth array element contains the number of file names.
;                            If no files that satisfy the condition ($iFlag), the function fails.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ DragQueryFile
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DragQueryFileEx($hDrop, $iFlag = 0)

	Local $Ret, $Count, $Dir, $File, $tData, $aData[1] = [0]

	$Ret = DllCall('shell32.dll', 'int', 'DragQueryFileW', 'ptr', $hDrop, 'uint', -1, 'ptr', 0, 'uint', 0)
	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	$Count = $Ret[0]
	ReDim $aData[$Count + 1]
	For $i = 0 To $Count - 1
		$tData = DllStructCreate('wchar[1024]')
		$Ret = DllCall('shell32.dll', 'int', 'DragQueryFileW', 'ptr', $hDrop, 'uint', $i, 'ptr', DllStructGetPtr($tData), 'uint', 1024)
		If Not $Ret[0] Then
			Return SetError(1, 0, 0)
		EndIf
		$File = DllStructGetData($tData, 1)
		$tData = 0
		If $iFlag Then
			$Dir = _WinAPI_PathIsDirectory($File)
			If Not @error Then
				If (($iFlag = 1) And ($Dir)) Or (($iFlag = 2) And (Not $Dir)) Then
					ContinueLoop
				EndIf
			EndIf
		EndIf
		$aData[$i + 1] = $File
		$aData[0] += 1
	Next
	If Not $aData[0] Then
		Return SetError(1, 0, 0)
	EndIf
	ReDim $aData[$aData[0] + 1]
	Return $aData
EndFunc   ;==>_WinAPI_DragQueryFileEx

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DragQueryPoint
; Description....: Retrieves the position of the mouse pointer at the time a file was dropped during a drag-and-drop operation.
; Syntax.........: _WinAPI_DragQueryPoint ( $hDrop )
; Parameters.....: $hDrop  - Handle of the drop structure that describes the dropped file. This parameter is passed to
;                            WM_DROPFILES message with WPARAM parameter.
; Return values..: Success - $tagPOINT structure that contains the coordinates of the mouse pointer at the time the
;                            file was dropped.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ DragQueryPoint
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DragQueryPoint($hDrop)

	Local $tPOINT = DllStructCreate($tagPOINT)
	Local $Ret = DllCall('shell32.dll', 'int', 'DragQueryPoint', 'ptr', $hDrop, 'ptr', DllStructGetPtr($tPOINT))

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $tPOINT
EndFunc   ;==>_WinAPI_DragQueryPoint

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DrawAnimatedRects
; Description....: Animates the caption of a window to indicate the opening of an icon or the minimizing or maximizing of a window.
; Syntax.........: _WinAPI_DrawAnimatedRects ( $hWnd, $tRectFrom, $tRectTo )
; Parameters.....: $hWnd      - Handle to the window whose caption should be animated on the screen.
;                  $tRectFrom - $tagRECT structure specifying the location and size of the icon or minimized window.
;                  $tRectTo   - $tagRECT structure specifying the location and size of the restored window.
; Return values..: Success    - 1.
;                  Failure    - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The window caption will animate from the position specified by $tRectFrom to the position specified by $tRectTo.
;                  The effect is similar to minimizing or maximizing a window.
; Related........:
; Link...........: @@MsdnLink@@ DrawAnimatedRects
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DrawAnimatedRects($hWnd, $tRectFrom, $tRectTo)

	Local $Ret = DllCall('user32.dll', 'int', 'DrawAnimatedRects', 'hwnd', $hWnd, 'int', 3, 'ptr', DllStructGetPtr($tRectFrom), 'ptr', DllStructGetPtr($tRectTo))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_DrawAnimatedRects

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DrawBitmap
; Description....: Draws a bitmap into the specified device context.
; Syntax.........: _WinAPI_DrawBitmap ( $hDC, $iX, $iY, $hBitmap [, $iRop] )
; Parameters.....: $hDC     - Handle to the device context into which the bitmap will be drawn.
;                  $iX      - Specifies the logical x-coordinate of the upper-left corner of the bitmap.
;                  $iY      - Specifies the logical y-coordinate of the upper-left corner of the bitmap.
;                  $hBitmap - Handle to the bitmap to be drawn.
;                  $iRop    - The raster-operation code (same as for _WinAPI_BitBlt()).
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function does not support bitmaps with Alpha channel, use _WinAPI_AlphaBlend() to work with them.
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DrawBitmap($hDC, $iX, $iY, $hBitmap, $iRop = 0x00CC0020)

	Local $Ret, $tObj, $_hDC, $hSrcDC, $hSrcSv

    $tObj = DllStructCreate($tagBITMAP)
	$Ret = DllCall('gdi32.dll', 'int', 'GetObject', 'int', $hBitmap, 'int', DllStructGetSize($tObj), 'ptr', DllStructGetPtr($tObj))
	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	$Ret = DllCall('user32.dll', 'hwnd', 'GetDC', 'hwnd', 0)
	$_hDC = $Ret[0]
	$Ret = DllCall('gdi32.dll', 'hwnd', 'CreateCompatibleDC', 'hwnd', $_hDC)
	$hSrcDC = $Ret[0]
	$Ret = DllCall('gdi32.dll', 'hwnd', 'SelectObject', 'hwnd', $hSrcDC, 'ptr', $hBitmap)
	$hSrcSv = $Ret[0]
	$Ret = DllCall('gdi32.dll', 'int', 'BitBlt', 'hwnd', $hDC, 'int', $iX, 'int', $iY, 'int', DllStructGetData($tObj, 'bmWidth'), 'int', DllStructGetData($tObj, 'bmHeight'), 'hwnd', $hSrcDC, 'int', 0, 'int', 0, 'int', $iRop)
	If (@error) Or (Not $Ret[0]) Then
		$Ret = 0
	EndIf
	DllCall('user32.dll', 'int', 'ReleaseDC', 'hwnd', 0, 'hwnd', $_hDC)
	DllCall('gdi32.dll', 'ptr', 'SelectObject', 'hwnd', $hSrcDC, 'ptr', $hSrcSv)
	DllCall('gdi32.dll', 'int', 'DeleteDC', 'hwnd', $hSrcDC)
	If Not IsArray($Ret) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_DrawBitmap

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DrawShadowText
; Description....: Draws formatted text in the specified rectangle with a drop shadow.
; Syntax.........: _WinAPI_DrawShadowText ( $hDC, $sText, $rgbText, $rgbShadow [, $iXOffset [, $iYOffset [, $tRECT [, $iFlags]]]] )
; Parameters.....: $hDC       - Handle to a device context.
;                  $sText     - The string that contains the text to be drawn.
;                  $rgbText   - The color of the text, in RGB.
;                  $rgbShadow - The color of the shadow, in RGB.
;                  $iXOffset  - The x-coordinate of where the text should begin.
;                  $iYOffset  - The y-coordinate of where the text should begin.
;                  $tRECT     - $tagRECT structure that contains, in logical coordinates, the rectangle in which the text is to
;                               be drawn. If this parameter is 0, the size will be equal size of the device context ($hDC).
;                  $iFlags    - The flags that specifies how the text is to be drawn. This parameter can be a combination of
;                               the formatting text constants ($DT_...).
; Return values..: Success    - 1.
;                  Failure    - 0 and sets the @error flag to non-zero.
; Author.........: Rover
; Modified.......: Yashied
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ DrawShadowText
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DrawShadowText($hDC, $sText, $rgbText, $rgbShadow, $iXOffset = 0, $iYOffset = 0, $tRECT = 0, $iFlags = 0)

	Local $Ret

	If Not IsDllStruct($tRECT) Then
		$tRECT = DllStructCreate($tagRECT)
		$Ret = DllCall('user32.dll', 'int', 'GetClientRect', 'hwnd', _WinAPI_WindowFromDC($hDC), 'ptr', DllStructGetPtr($tRECT))
		If (@error) Or (Not $Ret[0]) Then
			Return SetError(1, 0, 0)
		EndIf
	EndIf
	$Ret = DllCall('comctl32.dll', 'int', 'DrawShadowText', 'hwnd', $hDC, 'wstr', $sText, 'uint', -1, 'ptr', DllStructGetPtr($tRECT), 'dword', $iFlags, 'int', __IsRGB($rgbText), 'int', __IsRGB($rgbShadow), 'int', $iXOffset, 'int', $iYOffset)
	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_DrawShadowText

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DrawThemeBackground
; Description....: Draws the border and fill defined by the visual style for the specified control part.
; Syntax.........: _WinAPI_DrawThemeBackground ( $hTheme, $iPartId, $iStateId, $hDC, $tRECT [, $tCLIP] )
; Parameters.....: $hTheme   - Handle to a window's specified theme data.
;                  $iPartId  - The part to draw.
;                  $iStateId - The state of the part to draw.
;                  $hDC      - Handle to the device context for drawing the theme-defined background image.
;                  $tRECT    - $tagRECT structure that contains the rectangle in which the background image is drawn.
;                  $tCLIP    - $tagRECT structure that contains a clipping rectangle.
; Return values..: Success   - 1.
;                  Failure   - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ DrawThemeBackground
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DrawThemeBackground($hTheme, $iPartId, $iStateId, $hDC, $tRECT, $tCLIP = 0)

	Local $Ret = DllCall('uxtheme.dll', 'uint', 'DrawThemeBackground', 'ptr', $hTheme, 'hwnd', $hDC, 'int', $iPartId, 'int', $iStateId, 'ptr', DllStructGetPtr($tRECT), 'ptr', DllStructGetPtr($tCLIP))

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_DrawThemeBackground

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DrawThemeParentBackground
; Description....: Draws the part of a parent control that is covered by a partially-transparent or alpha-blended child control.
; Syntax.........: _WinAPI_DrawThemeParentBackground ( $hWnd, $hDC [, $tRECT] )
; Parameters.....: $hWnd   - Handle of the child control.
;                  $hDC    - Handle to the child control's DC.
;                  $tRECT  - $tagRECT structure that defines the area, in the child window's coordinates, to be drawn.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ DrawThemeParentBackground
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DrawThemeParentBackground($hWnd, $hDC, $tRECT = 0)

	Local $Ret = DllCall('uxtheme.dll', 'uint', 'DrawThemeParentBackground', 'hwnd', $hWnd, 'hwnd', $hDC, 'ptr', DllStructGetPtr($tRECT))

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_DrawThemeParentBackground

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DrawThemeText
; Description....: Draws text using the color and font defined by the visual style.
; Syntax.........: _WinAPI_DrawThemeText ( $hTheme, $iPartId, $iStateId, $hDC, $sText, $tRECT, $iFlags )
; Parameters.....: $hTheme   - Handle to a window's specified theme data.
;                  $iPartId  - The part that has the desired text appearance. If this value is 0, the text is drawn in the
;                              default font, or a font selected into the device context.
;                  $iStateId - The state that has the desired text appearance.
;                  $hDC      - Handle to the device context to use for drawing.
;                  $sText    - The string that contains the text to draw.
;                  $tRECT    - $tagRECT structure that contains the rectangle in which the text is to be drawn.
;                  $iFlags   - The string's formatting flags. This parameter can be one or more of the $DT_... values.
; Return values..: Success   - 1.
;                  Failure   - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ DrawThemeText
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DrawThemeText($hTheme, $iPartId, $iStateId, $hDC, $sText, $tRECT, $iFlags)

	Local $Ret = DllCall('uxtheme.dll', 'uint', 'DrawThemeText', 'ptr', $hTheme, 'hwnd', $hDC, 'int', $iPartId, 'int', $iStateId, 'wstr', $sText, 'int', -1, 'dword', $iFlags, 'dword', 0, 'ptr', DllStructGetPtr($tRECT))

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_DrawThemeText

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DrawThemeTextEx
; Description....: Draws text using the color and font defined by the visual style.
; Syntax.........: _WinAPI_DrawThemeTextEx ( $hTheme, $iPartId, $iStateId, $hDC, $sText, $tRECT, $iFlags, $tDTTOPTS )
; Parameters.....: $hTheme   - Handle to a window's specified theme data.
;                  $iPartId  - The part that has the desired text appearance. If this value is 0, the text is drawn in the
;                              default font, or a font selected into the device context.
;                  $iStateId - The state that has the desired text appearance.
;                  $hDC      - Handle to the device context to use for drawing.
;                  $sText    - The string that contains the text to draw.
;                  $tRECT    - $tagRECT structure that contains the rectangle in which the text is to be drawn.
;                  $iFlags   - The string's formatting flags. This parameter can be one or more of the $DT_... values.
;                  $tDTTOPTS - $tagDTTOPTS structure that defines additional formatting options.
; Return values..: Success   - 1.
;                  Failure   - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function requires Windows Vista or above.
; Related........:
; Link...........: @@MsdnLink@@ DrawThemeTextEx
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DrawThemeTextEx($hTheme, $iPartId, $iStateId, $hDC, $sText, $tRECT, $iFlags, $tDTTOPTS)

	Local $Ret = DllCall('uxtheme.dll', 'uint', 'DrawThemeTextEx', 'ptr', $hTheme, 'hwnd', $hDC, 'int', $iPartId, 'int', $iStateId, 'wstr', $sText, 'int', -1, 'dword', $iFlags, 'ptr', DllStructGetPtr($tRECT), 'ptr', DllStructGetPtr($tDTTOPTS))

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_DrawThemeTextEx

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DuplicateBitmap
; Description....: Creates a duplicate of a specified bitmap with a device-independent bitmap (DIB) section.
; Syntax.........: _WinAPI_DuplicateBitmap ( $hBitmap )
; Parameters.....: $hBitmap - Handle to the bitmap to be duplicated.
; Return values..: Success  - Handle to the new bitmap that was created.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: When you are finished using the bitmap, destroy it using the _WinAPI_FreeObject() function.
; Related........:
; Link...........: @@MsdnLink@@ CopyImage
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DuplicateBitmap($hBitmap)
	Return _WinAPI_CopyImage($hBitmap, 0, 0, 0, 0x2000)
EndFunc   ;==>_WinAPI_DuplicateBitmap

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DuplicateCursor
; Description....: Creates a duplicate of a specified cursor.
; Syntax.........: _WinAPI_DuplicateCursor ( $hCursor )
; Parameters.....: $hCursor - Handle to the cursor to be duplicated.
; Return values..: Success  - Handle to the new cursor that was created.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: When you are finished using the cursor, destroy it using the _WinAPI_FreeCursor() function.
; Related........:
; Link...........: @@MsdnLink@@ CopyIcon
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DuplicateCursor($hCursor)
	Return _WinAPI_DuplicateIcon($hCursor)
EndFunc   ;==>_WinAPI_DuplicateCursor

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DuplicateIcon
; Description....: Creates a duplicate of a specified icon.
; Syntax.........: _WinAPI_DuplicateIcon ( $hIcon )
; Parameters.....: $hIcon  - Handle to the icon to be duplicated.
; Return values..: Success - Handle to the new icon that was created.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: When you are finished using the icon, destroy it using the _WinAPI_FreeIcon() function.
; Related........:
; Link...........: @@MsdnLink@@ CopyIcon
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DuplicateIcon($hIcon)

	Local $Ret = DllCall('user32.dll', 'ptr', 'CopyIcon', 'ptr', $hIcon)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_DuplicateIcon

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DuplicateStruct
; Description....: Creates a duplicate of a specified structure.
; Syntax.........: _WinAPI_DuplicateStruct (ByRef $tStruct [, $sStruct] )
; Parameters.....: $tStruct - The structure to be duplicated.
;                  $sStruct - The string representing the structure (same as for the DllStructCreate()).
; Return values..: Success  - "byte[n]" or $sStruct structure that was created.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DuplicateStruct(ByRef $tStruct, $sStruct = '')

	Local $Size = DllStructGetSize($tStruct)

	If Not $Size Then
		Return SetError(1, 0, 0)
	EndIf

	Local $tSrc, $tDst, $tResult

	If Not StringStripWS($sStruct, 7) Then
		$sStruct = 'byte[' & $Size & ']'
	EndIf
	$tResult = DllStructCreate($sStruct)
	$tDst = DllStructCreate('byte[' & $Size & ']', DllStructGetPtr($tResult))
	$tSrc = DllStructCreate('byte[' & $Size & ']', DllStructGetPtr($tStruct))
	If (Not IsDllStruct($tResult)) Or (Not IsDllStruct($tDst)) Or (Not IsDllStruct($tSrc)) Then
		Return SetError(1, 0, 0)
	EndIf
	For $i = 1 To $Size
		DllStructSetData($tDst, 1, DllStructGetData($tSrc, 1, $i), $i)
		If @error Then
			Return SetError(1, 0, 0)
		EndIf
	Next
	Return $tResult
EndFunc   ;==>_WinAPI_DuplicateStruct

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DwmEnableBlurBehindWindow
; Description....: Enables the blur effect on a specified window.
; Syntax.........: _WinAPI_DwmEnableBlurBehindWindow ( $hWnd [, $fEnable [, $fTransition [, $hRgn]]] )
; Parameters.....: $hWnd        - Handle to the window on which the blur behind data is applied.
;                  $fEnable     - Specifies whether register or unregister the window handle to DWM blur behind, valid values:
;                  |TRUE        - Register.
;                  |FALSE       - Unregister.
;                  $fTransition - Specifies whether colorize transition to match the maximized windows, valid values:
;                  |TRUE        - The window's should be colorized.
;                  |FALSE       - Otherwise.
;                  $hRgn        - The region within the client area to apply the blur behind. A zeroth value will apply the blur
;                                 behind the entire client area.
; Return values..: Success      - 1.
;                  Failure      - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: The alpha values in the window are honored and the rendering atop the blur will use these alpha values.
;                  It is the application's responsibility for ensuring that the alpha values of all pixels in the window are correct.
;                  Some Windows Graphics Device Interface (GDI) operations do not preserve alpha values, so care must be taken when
;                  presenting child windows because the alpha values they contribute are unpredictable.
;
;                  This function must be called whenever Desktop Window Manager (DWM) composition is toggled. Handle the
;                  WM_DWMCOMPOSITIONCHANGED message for composition change notification.
;
;                  This function requires Windows Vista or above.
; Related........:
; Link...........: @@MsdnLink@@ DwmEnableBlurBehindWindow
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DwmEnableBlurBehindWindow($hWnd, $fEnable = 1, $fTransition = 0, $hRgn = 0)

	Local $tBLURBEHIND = DllStructCreate('dword;int;ptr;int')
	Local $Flags = 0

	If $hRgn Then
		$Flags += 2
		DllStructSetData($tBLURBEHIND, 3, $hRgn)
	EndIf

	DllStructSetData($tBLURBEHIND, 1, BitOR($Flags, 0x05))
	DllStructSetData($tBLURBEHIND, 2, $fEnable)
	DllStructSetData($tBLURBEHIND, 4, $fTransition)

	Local $Ret = DllCall('dwmapi.dll', 'uint', 'DwmEnableBlurBehindWindow', 'hwnd', $hWnd, 'ptr', DllStructGetPtr($tBLURBEHIND))

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_DwmEnableBlurBehindWindow

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DwmEnableComposition
; Description....: Enables or disables Desktop Window Manager (DWM) composition.
; Syntax.........: _WinAPI_DwmEnableComposition ( $fEnable )
; Parameters.....: $fEnable  - Specifies whether enable or disable DWM composition, valid values:
;                  |TRUE     - Enable.
;                  |FALSE    - Disable.
; Return values..: Success   - 1.
;                  Failure   - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: Disabling DWM composition disables it for the entire desktop. DWM composition will be automatically enabled
;                  when all processes that have disabled composition have called _WinAPI_DwmEnableComposition() to enable it or have
;                  been terminated. The WM_DWMCOMPOSITIONCHANGED notification is sent when DWM composition has enabled or disabled.
;
;                  This function requires Windows Vista or above.
; Related........:
; Link...........: @@MsdnLink@@ DwmEnableComposition
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DwmEnableComposition($fEnable)

	If $fEnable Then
		$fEnable = 1
	EndIf

	Local $Ret = DllCall('dwmapi.dll', 'uint', 'DwmEnableComposition', 'uint', $fEnable)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_DwmEnableComposition

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DwmGetColorizationColor
; Description....: Retrieves the current color used for Desktop Window Manager (DWM) glass composition.
; Syntax.........: _WinAPI_DwmGetColorizationColor ( )
; Parameters.....: None
; Return values..: Success - The current color (0xAARRGGBB) used for glass composition, @extended flag indicates whether the
;                            color is an opaque blend:
;                            1 - The color is an opaque blend.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function requires Windows Vista or above.
; Related........:
; Link...........: @@MsdnLink@@ DwmGetColorizationColor
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DwmGetColorizationColor()

	Local $Ret = DllCall('dwmapi.dll', 'uint', 'DwmGetColorizationColor', 'dword*', 0, 'int*', 0)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return SetError(0, $Ret[2], $Ret[1])
EndFunc   ;==>_WinAPI_DwmGetColorizationColor

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DwmGetWindowAttribute
; Description....: Retrieves the current value of a specified attribute applied to the window.
; Syntax.........: _WinAPI_DwmGetWindowAttribute ( $hWnd, $iAttribute )
; Parameters.....: $hWnd       - Handle to the window for which the attribute data is retrieved.
;                  $iAttribute - The attribute to retrieve. This parameter can be one of the following values.
;
;                                $DWMWA_NCRENDERING_ENABLED
;                                $DWMWA_CAPTION_BUTTON_BOUNDS
;                                $DWMWA_EXTENDED_FRAME_BOUNDS
;
; Return values..: Success     - The value that contains the current value of the attribute. The type of the returned value depends
;                                on the value of the $iAttribute parameter.
;                  Failure     - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function requires Windows Vista or above.
; Related........:
; Link...........: @@MsdnLink@@ DwmGetWindowAttribute
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DwmGetWindowAttribute($hWnd, $iAttribute)

	Local $Struct

	Switch $iAttribute
		Case $DWMWA_CAPTION_BUTTON_BOUNDS, $DWMWA_EXTENDED_FRAME_BOUNDS
			$Struct = $tagRECT
		Case $DWMWA_NCRENDERING_ENABLED
			$Struct = 'uint'
		Case Else
			Return SetError(1, 0, 0)
	EndSwitch

	Local $tData = DllStructCreate($Struct)
	Local $Ret = DllCall('dwmapi.dll', 'uint', 'DwmGetWindowAttribute', 'hwnd', $hWnd, 'dword', $iAttribute, 'ptr', DllStructGetPtr($tData), 'dword', DllStructGetSize($tData))

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Switch $iAttribute
		Case $DWMWA_NCRENDERING_ENABLED
			Return DllStructGetData($tData, 1)
		Case Else
			Return $tData
	EndSwitch
EndFunc   ;==>_WinAPI_DwmGetWindowAttribute

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DwmExtendFrameIntoClientArea
; Description....: Extends the window frame behind the client area.
; Syntax.........: _WinAPI_DwmExtendFrameIntoClientArea ( $hWnd [, $tMARGINS] )
; Parameters.....: $hWnd     - Handle to the window for which the frame is extended into the client area.
;                  $tMARGINS - $tagMARGINS structure that describes the margins to use when extending the frame into the client area.
;                              Negative margins are used to create the "sheet of glass" effect where the client area is rendered as
;                              a solid surface with no window border.
; Return values..: Success   - 1.
;                  Failure   - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function must be called whenever Desktop Window Manager (DWM) composition is toggled. Handle the
;                  WM_DWMCOMPOSITIONCHANGED message for composition change notification.
;
;                  This function requires Windows Vista or above.
; Related........:
; Link...........: @@MsdnLink@@ DwmExtendFrameIntoClientArea
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DwmExtendFrameIntoClientArea($hWnd, $tMARGINS = 0)

	If Not IsDllStruct($tMARGINS) Then
		$tMARGINS = DllStructCreate('int;int;int;int')
		For $i = 1 To 4
			DllStructSetData($tMARGINS, $i, -1)
		Next
	EndIf

	Local $Ret = DllCall('dwmapi.dll', 'uint', 'DwmExtendFrameIntoClientArea', 'hwnd', $hWnd, 'ptr', DllStructGetPtr($tMARGINS))

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_DwmExtendFrameIntoClientArea

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DwmIsCompositionEnabled
; Description....: Determines whether Desktop Window Manager (DWM) composition is enabled.
; Syntax.........: _WinAPI_DwmIsCompositionEnabled ( )
; Parameters.....: None
; Return values..: Success - 1 - DWM composition is enabled.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function requires Windows Vista or above.
; Related........:
; Link...........: @@MsdnLink@@ DwmIsCompositionEnabled
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DwmIsCompositionEnabled()

	Local $Ret = DllCall('dwmapi.dll', 'uint', 'DwmIsCompositionEnabled', 'int*', 0)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return $Ret[1]
EndFunc   ;==>_WinAPI_DwmIsCompositionEnabled

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DwmQueryThumbnailSourceSize
; Description....: Returns the source size of the Desktop Window Manager (DWM) thumbnail.
; Syntax.........: _WinAPI_DwmUnregisterThumbnail ( $hThumbnail )
; Parameters.....: $hThumbnail - Handle of the thumbnail to retrieve the source window size from.
; Return values..: Success     - $tagSIZE structure that contains the size of the source thumbnail.
;                  Failure     - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function requires Windows Vista or above.
; Related........:
; Link...........: @@MsdnLink@@ DwmQueryThumbnailSourceSize
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DwmQueryThumbnailSourceSize($hThumbnail)

	Local $tSIZE = DllStructCreate($tagSIZE)
	Local $Ret = DllCall('dwmapi.dll', 'uint', 'DwmQueryThumbnailSourceSize', 'ptr', $hThumbnail, 'ptr', DllStructGetPtr($tSIZE))

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return $tSIZE
EndFunc   ;==>_WinAPI_DwmQueryThumbnailSourceSize

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DwmRegisterThumbnail
; Description....: Creates a Desktop Window Manager (DWM) thumbnail relationship between the destination and source windows.
; Syntax.........: _WinAPI_DwmRegisterThumbnail ( $hDestination, $hSource )
; Parameters.....: $hDestination - Handle to the window that will use the DWM thumbnail.
;                  $hSource      - Handle to the window to use as the thumbnail source.
; Return values..: Success       - Handle that represents the registration of the DWM thumbnail.
;                  Failure       - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: The window designated by $hDestination must either be the desktop window itself or be owned by the process that
;                  is calling _WinAPI_DwmRegisterThumbnail().
;
;                  This function requires Windows Vista or above.
; Related........:
; Link...........: @@MsdnLink@@ DwmRegisterThumbnail
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DwmRegisterThumbnail($hDestination, $hSource)

	Local $Ret = DllCall('dwmapi.dll', 'uint', 'DwmRegisterThumbnail', 'hwnd', $hDestination, 'hwnd', $hSource, 'ptr*', 0)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return $Ret[3]
EndFunc   ;==>_WinAPI_DwmRegisterThumbnail

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DwmSetWindowAttribute
; Description....: Sets the value of the specified attributes for non-client rendering to apply to the window.
; Syntax.........: _WinAPI_DwmSetWindowAttribute ( $hWnd, $iAttribute, $iData )
; Parameters.....: $hWnd       - The window handle to apply the given attribute.
;                  $iAttribute - The attribute to apply to the window. This parameter can be one of the following values.
;
;                                $DWMWA_NCRENDERING_POLICY
;                                $DWMWA_TRANSITIONS_FORCEDISABLED
;                                $DWMWA_ALLOW_NCPAINT
;                                $DWMWA_NONCLIENT_RTL_LAYOUT
;                                $DWMWA_FORCE_ICONIC_REPRESENTATION
;                                $DWMWA_FLIP3D_POLICY
;
;                                *Windows 7 or above
;
;                                $DWMWA_HAS_ICONIC_BITMAP
;                                $DWMWA_DISALLOW_PEEK
;                                $DWMWA_EXCLUDED_FROM_PEEK
;
;                  $iData      - The value of the attribute.
; Return values..: Success     - 1.
;                  Failure     - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function requires Windows Vista or above.
; Related........:
; Link...........: @@MsdnLink@@ DwmSetWindowAttribute
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DwmSetWindowAttribute($hWnd, $iAttribute, $iData)
	Switch $iAttribute
		Case $DWMWA_NCRENDERING_POLICY, $DWMWA_TRANSITIONS_FORCEDISABLED, $DWMWA_ALLOW_NCPAINT, $DWMWA_NONCLIENT_RTL_LAYOUT, $DWMWA_FORCE_ICONIC_REPRESENTATION, $DWMWA_FLIP3D_POLICY, $DWMWA_HAS_ICONIC_BITMAP, $DWMWA_DISALLOW_PEEK, $DWMWA_EXCLUDED_FROM_PEEK

		Case Else
			Return SetError(1, 0, 0)
	EndSwitch

	Local $tData = DllStructCreate('uint')

	DllStructSetData($tData, 1, $iData)
	If @error Then
		Return SetError(1, 0, 0)
	EndIf

	Local $Ret = DllCall('dwmapi.dll', 'uint', 'DwmSetWindowAttribute', 'hwnd', $hWnd, 'dword', $iAttribute, 'ptr', DllStructGetPtr($tData), 'dword', DllStructGetSize($tData))

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_DwmSetWindowAttribute

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DwmUnregisterThumbnail
; Description....: Removes a Desktop Window Manager (DWM) thumbnail relationship.
; Syntax.........: _WinAPI_DwmUnregisterThumbnail ( $hThumbnail )
; Parameters.....: $hThumbnail - Handle to the thumbnail relationship to be removed.
; Return values..: Success     - 1.
;                  Failure     - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function requires Windows Vista or above.
; Related........:
; Link...........: @@MsdnLink@@ DwmUnregisterThumbnail
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DwmUnregisterThumbnail($hThumbnail)

	Local $Ret = DllCall('dwmapi.dll', 'uint', 'DwmUnregisterThumbnail', 'ptr', $hThumbnail)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_DwmUnregisterThumbnail

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DwmUpdateThumbnailProperties
; Description....: Specifies Desktop Window Manager (DWM) thumbnail properties.
; Syntax.........: _WinAPI_DwmUpdateThumbnailProperties ( $hThumbnail [, $fVisible [, $fClientAreaOnly [, $iOpacity [, $tRectDest [, $tRectSrc]]]]] )
; Parameters.....: $hThumbnail      - Handle of the thumbnail to retrieve the source window size from.
;                  $fVisible        - Specifies whether make the thumbnail visible or invisible, valid values:
;                  |TRUE            - Visible.
;                  |FALSE           - Invisible.
;                  $fClientAreaOnly - Specifies whether use only the thumbnail source's client area or entire window, valid values:
;                  |TRUE            - Use only source's client area.
;                  |FALSE           - Use entire window.
;                  $iOpacity        - The opacity with which to render the thumbnail. 0 is fully transparent while 255 is fully opaque.
;                  $tRectDest       - $tagRECT structure containing the rectangle in the destination window the thumbnail will be
;                                     rendered. By default, the size of this rectangle equal to the source size of the DWM thumbnail
;                                     which returns the _WinAPI_DwmQueryThumbnailSourceSize() function.
;                  $tRectSrc        - $tagRECT structure containing the rectangle that specifies the region of the source window
;                                     to use as the thumbnail. By default, the entire window is used as the thumbnail.
; Return values..: Success          - 1.
;                  Failure          - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: Thumbnail relationships created by _WinAPI_DwmRegisterThumbnail() will not be rendered to the destination window
;                  until this function is called. Subsequent calls will update the thumbnail according to the properties.
;
;                  This function requires Windows Vista or above.
; Related........:
; Link...........: @@MsdnLink@@ DwmUpdateThumbnailProperties
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DwmUpdateThumbnailProperties($hThumbnail, $fVisible = 1, $fClientAreaOnly = 0, $iOpacity = 255, $tRectDest = 0, $tRectSrc = 0)

	Local $tTHUMBNAIL = DllStructCreate('dword;int[4];int[4];byte;int;int')
	Local $tSIZE, $Flags = 0

	If Not IsDllStruct($tRectDest) Then
		$tSIZE = _WinAPI_DwmQueryThumbnailSourceSize($hThumbnail)
		If @error Then
			Return SetError(1, 0, 0)
		EndIf
		$tRectDest = _WinAPI_CreateRectEx(0, 0, DllStructGetData($tSIZE, 1), DllStructGetData($tSIZE, 2))
	EndIf
	For $i = 1 To 4
		DllStructSetData($tTHUMBNAIL, 2, DllStructGetData($tRectDest, $i), $i)
	Next
	If IsDllStruct($tRectSrc) Then
		$Flags += 2
		For $i = 1 To 4
			DllStructSetData($tTHUMBNAIL, 3, DllStructGetData($tRectSrc, $i), $i)
		Next
	EndIf

	DllStructSetData($tTHUMBNAIL, 1, BitOR($Flags, 0x1D))
	DllStructSetData($tTHUMBNAIL, 4, $iOpacity)
	DllStructSetData($tTHUMBNAIL, 5, $fVisible)
	DllStructSetData($tTHUMBNAIL, 6, $fClientAreaOnly)

	Local $Ret = DllCall('dwmapi.dll', 'uint', 'DwmUpdateThumbnailProperties', 'ptr', $hThumbnail, 'ptr', DllStructGetPtr($tTHUMBNAIL))

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_DwmUpdateThumbnailProperties

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DWordToInt
; Description....: Converts a value of type DWORD to a value of type INT.
; Syntax.........: _WinAPI_DWordToInt ( $iValue )
; Parameters.....: $iValue - The value to be converted.
; Return values..: The converted (INT) value.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_DWordToInt($iValue)

	Local $tData = DllStructCreate('int')

	DllStructSetData($tData, 1, $iValue)

	Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_DWordToInt

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_EjectMedia
; Description....: Causes the device to eject the media.
; Syntax.........: _WinAPI_EjectMedia ( $sDrive )
; Parameters.....: $sDrive - The drive letter of the CD tray to eject, in the format D:, E:, etc.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ IOCTL_STORAGE_EJECT_MEDIA
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_EjectMedia($sDrive)

	If Not (_WinAPI_GetDriveType($sDrive) = $DRIVE_CDROM) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $hFile = _WinAPI_CreateFileEx('\\.\' & $sDrive, 3, 0x80000000, 0x01)

	If Not $hFile Then
		Return SetError(1, 0, 0)
	EndIf

	Local $Ret = DllCall('kernel32.dll', 'int', 'DeviceIoControl', 'ptr', $hFile, 'dword', 0x002D4808, 'ptr', 0, 'dword', 0, 'ptr', 0, 'dword', 0, 'dword*', 0, 'ptr', 0)

	If (@error) Or (Not $Ret[0]) Then
		$Ret = 0
	EndIf
	_WinAPI_FreeHandle($hFile)
	If Not IsArray($Ret) Then
		Return SetError(2, 0, 0)
	EndIf
	Return SetError(0, 0, 1)
EndFunc   ;==>_WinAPI_EjectMedia

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_Ellipse
; Description....: Draws an ellipse.
; Syntax.........: _WinAPI_Ellipse ( $hDC, $tRECT )
; Parameters.....: $hDC     - Handle to the device context.
;                  $tRECT   - $tagRECT structure that contains the logical coordinates of the bounding rectangle.
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The ellipse is outlined by using the current pen and is filled by using the current brush.
; Related........:
; Link...........: @@MsdnLink@@ Ellipse
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_Ellipse($hDC, $tRECT)

	Local $Ret = DllCall('gdi32.dll', 'int', 'Ellipse', 'hwnd', $hDC, 'int', DllStructGetData($tRECT, 1), 'int', DllStructGetData($tRECT, 2), 'int', DllStructGetData($tRECT, 3), 'int', DllStructGetData($tRECT, 4))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_Ellipse

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_EmptyWorkingSet
; Description....: Removes as many pages as possible from the working set of the specified process.
; Syntax.........: _WinAPI_EmptyWorkingSet ( [$PID] )
; Parameters.....: $PID    - The PID of the process. Default (0) is the current process.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ EmptyWorkingSet
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_EmptyWorkingSet($PID = 0)

	If Not $PID Then
		$PID = _WinAPI_GetCurrentProcessID()
		If Not $PID Then
			Return SetError(1, 0, 0)
		EndIf
	EndIf

	Local $hProcess = DllCall('kernel32.dll', 'ptr', 'OpenProcess', 'dword', 0x001F0FFF, 'int', 0, 'dword', $PID)

	If (@error) Or (Not $hProcess[0]) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $Ret = DllCall('psapi.dll', 'int', 'EmptyWorkingSet', 'ptr', $hProcess[0])

	If (@error) Or (Not $Ret[0]) Then
		$Ret = 0
	EndIf
	_WinAPI_FreeHandle($hProcess[0])
	If Not IsArray($Ret) Then
		Return SetError(1, 0, 0)
	EndIf
	Return SetError(0, 0, 1)
EndFunc   ;==>_WinAPI_EmptyWorkingSet

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_EndPaint
; Description....: Marks the end of painting in the specified window.
; Syntax.........: _WinAPI_EndPaint ( $hWnd, ByRef $tPAINTSTRUCT )
; Parameters.....: $hWnd         - Handle to the window that has been repainted.
;                  $tPAINTSTRUCT - $tagPAINTSTRUCT structure that contains the painting information retrieved by _WinAPI_BeginPaint().
; Return values..: Success       - 1.
;                  Failure       - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function is required for each call to the _WinAPI_BeginPaint() function, but only after painting is complete.
; Related........:
; Link...........: @@MsdnLink@@ EndPaint
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_EndPaint($hWnd, ByRef $tPAINTSTRUCT)

	Local $Ret = DllCall('user32.dll', 'int', 'EndPaint', 'hwnd', $hWnd, 'ptr', DllStructGetPtr($tPAINTSTRUCT))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_EndPaint

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_EnumChildProcess
; Description....: Enumerates the child processes that belong to the specified process.
; Syntax.........: _WinAPI_EnumChildProcess ( [$PID] )
; Parameters.....: $PID    - The PID of the process. Default (0) is the current process.
; Return values..: Success - The 2D array of the PIDs and process names.
;
;                            [0][0] - Number of rows in array (n)
;                            [0][1] - Unused
;                            [1][0] - PID
;                            [1][1] - Process name
;                            [n][0] - PID
;                            [n][1] - Process name
;
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_EnumChildProcess($PID = 0)

	If Not $PID Then
		$PID = _WinAPI_GetCurrentProcessID()
		If Not $PID Then
			Return SetError(1, 0, 0)
		EndIf
	EndIf

	Local $hSnapshot = DllCall('kernel32.dll', 'ptr', 'CreateToolhelp32Snapshot', 'dword', 0x00000002, 'dword', 0)

	If (@error) Or (Not $hSnapshot[0]) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $tPROCESSENTRY32 = DllStructCreate('dword Size;dword Usage;dword ProcessID;ulong_ptr DefaultHeapID;dword ModuleID;dword Threads;dword ParentProcessID;long PriClassBase;dword Flags;wchar ExeFile[260]')
	Local $pPROCESSENTRY32 = DllStructGetPtr($tPROCESSENTRY32)
	Local $Ret, $Result[101][2] = [[0]]

	$hSnapshot = $hSnapshot[0]
	DllStructSetData($tPROCESSENTRY32, 'Size', DllStructGetSize($tPROCESSENTRY32))
	$Ret = DllCall('kernel32.dll', 'int', 'Process32FirstW', 'ptr', $hSnapshot, 'ptr', $pPROCESSENTRY32)
	While (Not @error) And ($Ret[0])
		If DllStructGetData($tPROCESSENTRY32, 'ParentProcessID') = $PID Then
			$Result[0][0] += 1
			If $Result[0][0] > UBound($Result) - 1 Then
				ReDim $Result[$Result[0][0] + 100][2]
			EndIf
			$Result[$Result[0][0]][0] = DllStructGetData($tPROCESSENTRY32, 'ProcessID')
			$Result[$Result[0][0]][1] = DllStructGetData($tPROCESSENTRY32, 'ExeFile')
		EndIf
		$Ret = DllCall('kernel32.dll', 'int', 'Process32NextW', 'ptr', $hSnapshot, 'ptr', $pPROCESSENTRY32)
	WEnd
	_WinAPI_FreeHandle($hSnapshot)
	If $Result[0][0] Then
		ReDim $Result[$Result[0][0] + 1][2]
	Else
		Return SetError(1, 0, 0)
	EndIf
	Return $Result
EndFunc   ;==>_WinAPI_EnumChildProcess

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_EnumChildWindows
; Description....: Enumerates the child windows that belong to the specified parent window.
; Syntax.........: _WinAPI_EnumChildWindows ( $hWnd [, $fVisible] )
; Parameters.....: $hWnd     - Handle to the parent window whose child windows are to be enumerated. If this parameter is 0,
;                              this function is equivalent to _WinAPI_EnumWindows().
;                  $fVisible - Specifies whether enumerates the invisible window, valid values:
;                  |TRUE     - Enumerate only visible windows. (Default)
;                  |FALSE    - Enumerate all windows.
; Return values..: Success   - The 2D array of the handles to the child windows and classes for the specified parent window.
;
;                              [0][0] - Number of rows in array (n)
;                              [0][1] - Unused
;                              [1][0] - Window handle
;                              [1][1] - Window class name
;                              [n][0] - Window handle
;                              [n][1] - Window class name
;
;                  Failure   - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ EnumChildWindows
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_EnumChildWindows($hWnd, $fVisible = 1)

	If Not _WinAPI_GetWindow($hWnd, 5) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $hEnumProc = DllCallbackRegister('__EnumWindowsProc','int','hwnd;int')
	Local $Error = 1

	Dim $__Data[101][2] = [[0]]
	DllCall('user32.dll', 'int', 'EnumChildWindows', 'hwnd', $hWnd, 'ptr', DllCallbackGetPtr($hEnumProc), 'int', $fVisible)
	If @error Then
		$__Data = 0
	Else
		$Error = 0
		If $__Data[0][0] Then
			ReDim $__Data[$__Data[0][0] + 1][2]
		Else
			$__Data = 0
		EndIf
	EndIf
	DllCallbackFree($hEnumProc)
	Return SetError($Error, 0, $__Data)
EndFunc   ;==>_WinAPI_EnumChildWindows

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_EnumDeviceDrivers
; Description....: Retrieves the load address for each device driver in the system.
; Syntax.........: _WinAPI_EnumDeviceDrivers ( )
; Parameters.....: None
; Return values..: Success - The array of device driver addresses. The zeroth array element contains the number of addresses.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ EnumDeviceDrivers
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_EnumDeviceDrivers()

	Local $tData, $Size, $Ret, $Result

	$Ret = DllCall('psapi.dll', 'int', 'EnumDeviceDrivers', 'ptr', 0, 'dword', 0, 'dword*', 0)
	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	If @AutoItX64 Then
		$Size = $Ret[3] / 8
	Else
		$Size = $Ret[3] / 4
	EndIf
	$tData = DllStructCreate('ptr[' & $Size & ']')
	$Ret = DllCall('psapi.dll', 'int', 'EnumDeviceDrivers', 'ptr', DllStructGetPtr($tData), 'dword', DllStructGetSize($tData), 'dword*', 0)
	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Dim $Result[$Size + 1] = [$Size]
	For $i = 1 To $Size
		$Result[$i] = DllStructGetData($tData, 1, $i)
	Next
	Return $Result
EndFunc   ;==>_WinAPI_EnumDeviceDrivers

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_EnumDisplaySettings
; Description....: Retrieves information about one of the graphics modes for a display device.
; Syntax.........: _WinAPI_EnumDisplaySettings ( $sDevice, $iMode )
; Parameters.....: $sDevice - The display device about whose graphics mode the function will obtain information. An empty string
;                             specifies the current display device on the computer on which the calling process is running.
;                  $iMode   - The type of information to be retrieved. This value can be a graphics mode index or one of the
;                             following values.
;
;                             $ENUM_CURRENT_SETTINGS
;                             $ENUM_REGISTRY_SETTINGS
;
;                             Graphics mode indexes start at zero. To obtain information for all of a display device's graphics
;                             modes, make a series of calls to _WinAPI_EnumDisplaySettings(), as follows: Set $iMode to zero for
;                             the first call, and increment $iMode by one for each subsequent call. Continue calling the function
;                             until the return value is zero.
;
;                             When you call _WinAPI_EnumDisplaySettings() with $iMode set to zero, the operating system initializes
;                             and caches information about the display device. When you call _WinAPI_EnumDisplaySettings() with
;                             $iMode set to a non-zero value, the function returns the information that was cached the last time
;                             the function was called with $iMode set to zero.
;
; Return values..: Success  - The array containing the following parameters:
;
;                             [0] - The width, in pixels, of the visible device surface.
;                             [1] - The height, in pixels, of the visible device surface.
;                             [2] - The color resolution, in bits per pixel, of the display device.
;                             [3] - The frequency, in hertz (cycles per second), of the display device in a particular mode.
;                             [4] - The device's display mode ($DM_...).
;
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ EnumDisplaySettings
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_EnumDisplaySettings($sDevice, $iMode)

	Local $TypeOfDevice = 'wstr'

	If Not StringStripWS($sDevice, 3) Then
		$TypeOfDevice = 'ptr'
		$sDevice = 0
	EndIf

	Local $tDEVMODE = DllStructCreate('wchar[32];ushort;ushort;ushort;ushort;dword;dword[2];dword;dword;short;short;short;short;short;wchar[32];ushort;dword;dword;dword;dword;dword')

	DllStructSetData($tDEVMODE, 4, DllStructGetSize($tDEVMODE))
	DllStructSetData($tDEVMODE, 5, 0)

	Local $Ret = DllCall('user32.dll', 'int', 'EnumDisplaySettingsW', $TypeOfDevice, $sDevice, 'dword', $iMode, 'ptr', DllStructGetPtr($tDEVMODE))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $Result[5]

	$Result[0] = DllStructGetData($tDEVMODE, 18)
	$Result[1] = DllStructGetData($tDEVMODE, 19)
	$Result[2] = DllStructGetData($tDEVMODE, 17)
	$Result[3] = DllStructGetData($tDEVMODE, 21)
	$Result[4] = DllStructGetData($tDEVMODE, 20)

	Return $Result
EndFunc   ;==>_WinAPI_EnumDisplaySettings

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_EnumMRUList
; Description....: Enumerates the contents of the most recently used (MRU) list.
; Syntax.........: _WinAPI_EnumMRUList ( $hMRU, $iItem [, $fBinary] )
; Parameters.....: $hMRU    - Handle of the MRU list, obtained when the list was created.
;                  $iItem   - The item to return. If this value is (-1), the function returns the number of items in the MRU list.
;                  $fBinary - Specifies whether to return an item as binary data, valid values:
;                  |TRUE    - Returns as binary data. Only if the MRU list was created with the $MRU_BINARY flag.
;                  |FALSE   - Returns as string. (Default)
; Return values..: Success  - The item requested in $iItem. If $iItem is (-1) - the number of items in the MRU list.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ EnumMRUListW
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_EnumMRUList($hMRU, $iItem, $fBinary = 0)

	Local $TypeOfData = 'wchar'

	If $fBinary Then
		$TypeOfData = 'byte'
	EndIf

	Local $tData = DllStructCreate($TypeOfData & '[4096]')
	Local $Ret = DllCall('comctl32.dll ', 'int', 'EnumMRUListW', 'ptr', $hMRU, 'int', $iItem, 'ptr', DllStructGetPtr($tData), 'uint', 4096)

	If (@error) Or ($Ret[0] < 0) Then
		Return SetError(1, 0, 0)
	EndIf
	If $iItem < 0 Then
		Return $Ret[0]
	Else
		If Not $Ret[0] Then
			Return SetError(1, 0, 0)
		EndIf
	EndIf

	Local $tResult = DllStructCreate($TypeOfData & '[' & $Ret[0] & ']', DllStructGetPtr($tData))

	Return DllStructGetData($tResult, 1)
EndFunc   ;==>_WinAPI_EnumMRUList

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_EnumProcessThreads
; Description....: Enumerates the threads that belong to the specified process.
; Syntax.........: _WinAPI_EnumProcessThreads ( [$PID] )
; Parameters.....: $PID    - The PID of the process. Default (0) is the current process.
; Return values..: Success - The array of threads identifiers (ID). The zeroth array element contains the number of threads.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_EnumProcessThreads($PID = 0)

	If Not $PID Then
		$PID = _WinAPI_GetCurrentProcessID()
		If Not $PID Then
			Return SetError(1, 0, 0)
		EndIf
	EndIf

	Local $hSnapshot = DllCall('kernel32.dll', 'ptr', 'CreateToolhelp32Snapshot', 'dword', 0x00000004, 'dword', 0)

	If (@error) Or (Not $hSnapshot[0]) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $tTHREADENTRY32 = DllStructCreate('dword Size;dword Usage;dword ThreadID;dword OwnerProcessID;long BasePri;long DeltaPri;dword Flags')
	Local $pTHREADENTRY32 = DllStructGetPtr($tTHREADENTRY32)
	Local $Ret, $Result[101] = [0]

	$hSnapshot = $hSnapshot[0]
	DllStructSetData($tTHREADENTRY32, 'Size', DllStructGetSize($tTHREADENTRY32))
	$Ret = DllCall('kernel32.dll', 'int', 'Thread32First', 'ptr', $hSnapshot, 'ptr', $pTHREADENTRY32)
	While (Not @error) And ($Ret[0])
		If DllStructGetData($tTHREADENTRY32, 'OwnerProcessID') = $PID Then
			$Result[0] += 1
			If $Result[0] > UBound($Result) - 1 Then
				ReDim $Result[$Result[0] + 100]
			EndIf
			$Result[$Result[0]] = DllStructGetData($tTHREADENTRY32, 'ThreadID')
		EndIf
		$Ret = DllCall('kernel32.dll', 'int', 'Thread32Next', 'ptr', $hSnapshot, 'ptr', $pTHREADENTRY32)
	WEnd
	_WinAPI_FreeHandle($hSnapshot)
	If $Result[0] Then
		ReDim $Result[$Result[0] + 1]
	Else
		Return SetError(1, 0, 0)
	EndIf
	Return $Result
EndFunc   ;==>_WinAPI_EnumProcessThreads

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_EnumProcessWindows
; Description....: Enumerates the windows that belong to the specified process.
; Syntax.........: _WinAPI_EnumProcessWindows ( [$PID [, $fVisible]] )
; Parameters.....: $PID      - The PID of the process. Default (0) is the current process.
;                  $fVisible - Specifies whether enumerates the invisible window, valid values:
;                  |TRUE     - Enumerate only visible windows. (Default)
;                  |FALSE    - Enumerate all windows.
; Return values..: Success   - The 2D array of the handles to the windows and classes for the specified process.
;
;                              [0][0] - Number of rows in array (n)
;                              [0][1] - Unused
;                              [1][0] - Window handle
;                              [1][1] - Window class name
;                              [n][0] - Window handle
;                              [n][1] - Window class name
;
;                  Failure   - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_EnumProcessWindows($PID = 0, $fVisible = 1)

	Local $Threads = _WinAPI_EnumProcessThreads($PID)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf

	Local $hEnumProc = DllCallbackRegister('__EnumWindowsProc','int','hwnd;int')
	Local $Error = 1

	Dim $__Data[101][2] = [[0]]
	For $i = 1 To $Threads[0]
		DllCall('user32.dll', 'int', 'EnumThreadWindows', 'dword', $Threads[$i], 'ptr',  DllCallbackGetPtr($hEnumProc), 'int', $fVisible)
		If @error Then
			$__Data = 0
			ExitLoop
		EndIf
	Next
	If IsArray($__Data) Then
		$Error = 0
		If $__Data[0][0] Then
			ReDim $__Data[$__Data[0][0] + 1][2]
		Else
			$__Data = 0
		EndIf
	EndIf
	DllCallbackFree($hEnumProc)
	Return SetError($Error, 0, $__Data)
EndFunc   ;==>_WinAPI_EnumProcessWindows

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_EnumResourceLanguages
; Description....: Enumerates language-specific resources, of the specified type and name, associated with a binary module.
; Syntax.........: _WinAPI_EnumResourceLanguages ( $sModule, $sType, $sName )
; Parameters.....: $sModule - Handle to a module to search.
;                  $sType   - The type of the resource. This parameter can be string or integer type.
;                  $sName   - The name of the resource. This parameter can be string or integer type.
; Return values..: Success  - The array of the LCIDs for specified resource type and name.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ EnumResourceLanguages
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_EnumResourceLanguages($sModule, $sType, $sName)

	Local $Ret, $hModule, $hEnumProc, $TypeOfName = 'ptr', $TypeOfType = 'ptr'

	If IsString($sModule) Then
		If Not StringStripWS($sModule, 3) Then
			$hModule = DllCall('kernel32.dll', 'ptr', 'GetModuleHandle', 'ptr', 0)
		Else
			$hModule = DllCall('kernel32.dll', 'ptr', 'LoadLibraryW', 'wstr', $sModule)
		EndIf
		If (@error) Or (Not $hModule[0]) Then
			Return SetError(1, 0, 0)
		EndIf
		$hModule = $hModule[0]
	Else
		$hModule = $sModule
	EndIf
	If IsString($sName) Then
		$TypeOfName = 'wstr'
	EndIf
	If IsString($sType) Then
		$TypeOfType = 'wstr'
	EndIf
	Dim $__Data[101] = [0]
	$hEnumProc = DllCallbackRegister('__EnumResLanguagesProc','int','ptr;ptr;ptr;ushort;long_ptr')
	$Ret = DllCall('kernel32.dll', 'int', 'EnumResourceLanguagesW', 'ptr', $hModule, $TypeOfType, $sType, $TypeOfName, $sName, 'ptr', DllCallbackGetPtr($hEnumProc), 'long_ptr', 0)
	If (@error) Or (Not $Ret[0]) Then
		$__Data = 0
	Else
		ReDim $__Data[$__Data[0] + 1]
	EndIf
	DllCallbackFree($hEnumProc)
	If IsString($sModule) Then
		_WinAPI_FreeLibrary($hModule)
	EndIf
	Return SetError(Number(Not $__Data), 0, $__Data)
EndFunc   ;==>_WinAPI_EnumResourceLanguages

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_EnumResourceNames
; Description....: Enumerates resources of a specified type within a binary module.
; Syntax.........: _WinAPI_EnumResourceNames ( $sModule, $sType )
; Parameters.....: $sModule - Handle to a module to search.
;                  $sType   - The type of the resource. This parameter can be string or integer type.
; Return values..: Success  - The array of the names for the specified resource type.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ EnumResourceNames
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_EnumResourceNames($sModule, $sType)

	Local $Ret, $hModule, $hEnumProc, $TypeOfType = 'ptr'

	If IsString($sModule) Then
		If Not StringStripWS($sModule, 3) Then
			$hModule = DllCall('kernel32.dll', 'ptr', 'GetModuleHandle', 'ptr', 0)
		Else
			$hModule = DllCall('kernel32.dll', 'ptr', 'LoadLibraryW', 'wstr', $sModule)
		EndIf
		If (@error) Or (Not $hModule[0]) Then
			Return SetError(1, 0, 0)
		EndIf
		$hModule = $hModule[0]
	Else
		$hModule = $sModule
	EndIf
	If IsString($sType) Then
		$TypeOfType = 'wstr'
	EndIf
	Dim $__Data[101] = [0]
	$hEnumProc = DllCallbackRegister('__EnumResNamesProc','int','ptr;ptr;ptr;long_ptr')
	$Ret = DllCall('kernel32.dll', 'int', 'EnumResourceNamesW', 'ptr', $hModule, $TypeOfType, $sType, 'ptr', DllCallbackGetPtr($hEnumProc), 'long_ptr', 0)
	If (@error) Or (Not $Ret[0]) Then
		$__Data = 0
	Else
		ReDim $__Data[$__Data[0] + 1]
	EndIf
	DllCallbackFree($hEnumProc)
	If IsString($sModule) Then
		_WinAPI_FreeLibrary($hModule)
	EndIf
	Return SetError(Number(Not $__Data), 0, $__Data)
EndFunc   ;==>_WinAPI_EnumResourceNames

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_EnumResourceTypes
; Description....: Enumerates resource types within a binary module.
; Syntax.........: _WinAPI_EnumResourceTypes ( $sModule )
; Parameters.....: $sModule - Handle to a module to search.
; Return values..: Success  - The array of the types of the resources for the specified module.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ EnumResourceTypes
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_EnumResourceTypes($sModule)

	Local $Ret, $hModule, $hEnumProc

	If IsString($sModule) Then
		If Not StringStripWS($sModule, 3) Then
			$hModule = DllCall('kernel32.dll', 'ptr', 'GetModuleHandle', 'ptr', 0)
		Else
			$hModule = DllCall('kernel32.dll', 'ptr', 'LoadLibraryW', 'wstr', $sModule)
		EndIf
		If (@error) Or (Not $hModule[0]) Then
			Return SetError(1, 0, 0)
		EndIf
		$hModule = $hModule[0]
	Else
		$hModule = $sModule
	EndIf
	Dim $__Data[101] = [0]
	$hEnumProc = DllCallbackRegister('__EnumResTypesProc','int','ptr;ptr;long_ptr')
	$Ret = DllCall('kernel32.dll', 'int', 'EnumResourceTypesW', 'ptr', $hModule, 'ptr', DllCallbackGetPtr($hEnumProc), 'long_ptr', 0)
	If (@error) Or (Not $Ret[0]) Then
		$__Data = 0
	Else
		ReDim $__Data[$__Data[0] + 1]
	EndIf
	DllCallbackFree($hEnumProc)
	If IsString($sModule) Then
		_WinAPI_FreeLibrary($hModule)
	EndIf
	Return SetError(Number(Not $__Data), 0, $__Data)
EndFunc   ;==>_WinAPI_EnumResourceTypes

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_EnumSystemLocales
; Description....: Enumerates the locales that are either installed on or supported by an operating system.
; Syntax.........: _WinAPI_EnumSystemLocales ( $iFlag )
; Parameters.....: $iFlag  - Flags specifying the locale identifiers to enumerate. This parameter can have one of the
;                            following values.
;
;                            $LCID_INSTALLED
;                            $LCID_SUPPORTED
;
; Return values..: Success - The array of the locale identifiers.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ EnumSystemLocales
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_EnumSystemLocales($iFlag)

	Local $Ret, $hEnumProc

	Dim $__Data[101] = [0]
	$hEnumProc = DllCallbackRegister('__EnumLocalesProc','int','ptr')
	$Ret = DllCall('kernel32.dll', 'int', 'EnumSystemLocalesW', 'ptr', DllCallbackGetPtr($hEnumProc), 'dword', $iFlag)
	If (@error) Or (Not $Ret[0]) Or (Not IsArray($__Data)) Then
		$__Data = 0
	Else
		ReDim $__Data[$__Data[0] + 1]
	EndIf
	DllCallbackFree($hEnumProc)
	Return SetError(Number(Not $__Data), 0, $__Data)
EndFunc   ;==>_WinAPI_EnumSystemLocales

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_EqualRect
; Description....: Determines whether the two specified rectangles are equal.
; Syntax.........: _WinAPI_EqualRect ( $tRECT1, $tRECT2 )
; Parameters.....: $tRECT1 - $tagRECT structure that contains the logical coordinates of the first rectangle.
;                  $tRECT2 - $tagRECT structure that contains the logical coordinates of the second rectangle.
; Return values..: Success - 1 - The two rectangles are identical.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function does not treat empty rectangles as equal if their coordinates are different.
; Related........:
; Link...........: @@MsdnLink@@ EqualRect
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_EqualRect($tRECT1, $tRECT2)

	Local $Ret = DllCall('user32.dll', 'int', 'EqualRect', 'ptr', DllStructGetPtr($tRECT1), 'ptr', DllStructGetPtr($tRECT2))

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_EqualRect

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_EqualRgn
; Description....: Checks the two specified regions to determine whether they are identical.
; Syntax.........: _WinAPI_EqualRgn ( $hRgn1, $hRgn2 )
; Parameters.....: $hRgn1  - Handle to a region.
;                  $hRgn2  - Handle to a region.
; Return values..: Success - 1 - The two regions are equal.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ EqualRgn
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_EqualRgn($hRgn1, $hRgn2)

	Local $Ret = DllCall('gdi32.dll', 'int', 'EqualRgn', 'ptr', $hRgn1, 'ptr', $hRgn2)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_EqualRgn

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_EqualStruct
; Description....: Determines whether the two specified structures are equal.
; Syntax.........: _WinAPI_EqualStruct (ByRef $tStruct1, ByRef $tStruct2)
; Parameters.....: $tStruct1 - The structure that contains the first source data.
;                  $tStruct2 - The structure that contains the second source data.
; Return values..: Success   - 1 - The two structures are identical.
;                              0 - Otherwise.
;                  Failure   - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_EqualStruct(ByRef $tStruct1, ByRef $tStruct2)

	Local $Size1 = DllStructGetSize($tStruct1)
	Local $Size2 = DllStructGetSize($tStruct2)

	If (Not $Size1) Or (Not $Size2) Then
		Return SetError(1, 0, 0)
	Else
		If $Size1 <> $Size2 Then
			Return 0
		EndIf
	EndIf

	Local $tData1 = DllStructCreate('byte[' & $Size1 & ']', DllStructGetPtr($tStruct1))
	Local $tData2 = DllStructCreate('byte[' & $Size2 & ']', DllStructGetPtr($tStruct2))

	If (Not IsDllStruct($tData1)) Or (Not IsDllStruct($tData2)) Then
		Return SetError(1, 0, 0)
	EndIf
	For $i = 1 To $Size1
		If DllStructGetData($tData1, 1, $i) <> DllStructGetData($tData2, 1, $i) Then
			Return 0
		EndIf
	Next
	Return 1
EndFunc   ;==>_WinAPI_EqualStruct

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ExtSelectClipRgn
; Description....: Combines the specified region with the current clipping region using the specified mode.
; Syntax.........: _WinAPI_ExtSelectClipRgn ( $hDC, $hRgn [, $iMode] )
; Parameters.....: $hDC    - Handle to the device context.
;                  $hRgn   - Handle to the region to be selected. This handle can only be 0 when the $RGN_COPY mode is specified.
;                  $iMode  - The operation to be performed. It must be one of the following values.
;
;                            $RGN_AND
;                            $RGN_COPY
;                            $RGN_DIFF
;                            $RGN_OR
;                            $RGN_XOR
;
; Return values..: Success - The value that specifies the new clipping region's complexity; it can be one of the following values.
;
;                            $COMPLEXREGION
;                            $NULLREGION
;                            $SIMPLEREGION
;
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ ExtSelectClipRgn
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ExtSelectClipRgn($hDC, $hRgn, $iMode = 5)

	Local $Ret = DllCall('gdi32.dll', 'int', 'ExtSelectClipRgn', 'hwnd', $hDC, 'ptr', $hRgn, 'int', $iMode)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_ExtSelectClipRgn

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_FatalExit
; Description....: Transfers execution control to the debugger.
; Syntax.........: _WinAPI_FatalExit ( $iCode )
; Parameters.....: $iCode  - The error code associated with the exit.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ FatalExit
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_FatalExit($iCode)
	DllCall('kernel32.dll', 'none', 'FatalExit', 'int', $iCode)
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_FatalExit

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_FileTimeToLocalFileTime
; Description....: Converts a file time to a local file time.
; Syntax.........: _WinAPI_FileTimeToLocalFileTime ( $tFILETIME )
; Parameters.....: $tFILETIME - $tagFILETIME structure containing the UTC-based file time to be converted into a local file time.
; Return values..: Success    - $tagFILETIME structure that contains the converted local file time.
;                  Failure    - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This functions uses the current settings for the time zone and daylight saving time. Therefore, if it is daylight
;                  saving time, this function will take daylight saving time into account, even if the time you are converting is
;                  in standard time.
; Related........:
; Link...........: @@MsdnLink@@ FileTimeToLocalFileTime
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_FileTimeToLocalFileTime($tFILETIME)

	Local $tFILETIMELOCAL = DllStructCreate($tagFILETIME)
	Local $Ret = DllCall('kernel32.dll', 'int', 'FileTimeToLocalFileTime', 'ptr', DllStructGetPtr($tFILETIME), 'ptr', DllStructGetPtr($tFILETIMELOCAL))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $tFILETIMELOCAL
EndFunc   ;==>_WinAPI_FileTimeToLocalFileTime

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_FileTimeToSystemTime
; Description....: Converts a file time to system time format.
; Syntax.........: _WinAPI_FileTimeToSystemTime ( $tFILETIME )
; Parameters.....: $tFILETIME - $tagFILETIME structure containing he file time to convert to system date and time format.
; Return values..: Success    - $tagSYSTEMTIME structure that contains the converted file time.
;                  Failure    - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ FileTimeToSystemTime
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_FileTimeToSystemTime($tFILETIME)

	Local $tSYSTEMTIME = DllStructCreate($tagSYSTEMTIME)
	Local $Ret = DllCall('kernel32.dll', 'int', 'FileTimeToSystemTime', 'ptr', DllStructGetPtr($tFILETIME), 'ptr', DllStructGetPtr($tSYSTEMTIME))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $tSYSTEMTIME
EndFunc   ;==>_WinAPI_FileTimeToSystemTime

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_FillRect
; Description....: Fills a rectangle by using the specified brush.
; Syntax.........: _WinAPI_FillRect ( $hDC, $tRECT, $hBrush )
; Parameters.....: $hDC    - Handle to the device context.
;                  $tRECT  - $tagRECT structure that contains the logical coordinates of the rectangle to be filled.
;                  $hBrush - Handle to the brush used to fill the rectangle.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ FillRect
; Example........: Yes
; ===============================================================================================================================

#cs

Func _WinAPI_FillRect($hDC, $tRECT, $hBrush)

	Local $Ret = DllCall('user32.dll', 'int', 'FillRect', 'hwnd', $hDC, 'ptr', DllStructGetPtr($tRECT), 'ptr', $hBrush)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_FillRect

#ce

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_FillRgn
; Description....: Fills a region by using the specified brush.
; Syntax.........: _WinAPI_FillRgn ( $hDC, $hRgn, $hBrush )
; Parameters.....: $hDC    - Handle to the device context.
;                  $hRgn   - Handle to the region to be filled. The region's coordinates are presumed to be in logical units.
;                  $hBrush - Handle to the brush to be used to fill the region.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ FillRgn
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_FillRgn($hDC, $hRgn, $hBrush)

	Local $Ret = DllCall('gdi32.dll', 'int', 'FillRgn', 'hwnd', $hDC, 'ptr', $hRgn, 'ptr', $hBrush)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_FillRgn

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_FillStruct
; Description....: Fills the structure with a specified value in the specified range.
; Syntax.........: _WinAPI_FillStruct ( ByRef $tStruct, $iValue [, $iBytes [, $iStart [, $iEnd]]] )
; Parameters.....: $tStruct - The structure to be filled that returned by DllStructCreate() function. It should contain a single
;                             element or element is an array. For example, "byte[32]", "int[8]", "int64[4]", etc.
;                  $iValue  - The value to be used to fill the structure. $iValue must be an integer, the chars are not allowed.
;                             To fill with a character use the Asc() or AscW() functions.
;                  $iBytes  - The number of bytes for each element required. It can be one of the following values: 1, 2, 4,
;                             or 8. For other values of this parameter the function is fails.
;                  $iStart  - The index of element in the structure to start filling at.
;                  $iEnd    - The index of element in the structure to stop filling at.
; Return values..: Success  - The number of elements that has been filled. If successful, the same ($iEnd - $iStart + 1).
;                  Failure  - 0 and sets the @error flag to one of the following values:
;                  |1 - $tStruct not a correct structure returned by DllStructCreate().
;                  |2 - $iByte value is incorrect.
;                  |3 - $iStart or $iEnd values outside of the structure.
;                  |4 - Failed to allocate the memory.
;                  |5 - Error filling structure.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_FillStruct(ByRef $tStruct, $iValue, $iBytes = 1, $iStart = 1, $iEnd = -1)

	Local $tData, $sData, $Count, $Size = DllStructGetSize($tStruct)

	If Not IsDllStruct($tStruct) Then
		Return SetError(1, 0, 0)
	EndIf

	Switch $iBytes
		Case 1
			$sData = 'byte'
		Case 2
			$sData = 'short'
		Case 4
			$sData = 'int'
		Case 8
			$sData = 'int64'
		Case Else
			Return SetError(2, 0, 0)
	EndSwitch
	$Count = Int($Size / $iBytes)
	If $iStart < 1 Then
		$iStart = 1
	EndIf
	If $iEnd < 0 Then
		$iEnd = $Count
	EndIf
	If ($iStart > $iEnd) Or ($iEnd > $Count) Then
		Return SetError(3, 0, 0)
	EndIf
	$tData = DllStructCreate($sData & '[' & $Count & ']', DllStructGetPtr($tStruct))
	If @error Then
		Return SetError(4, 0, 0)
	EndIf
	For $i = $iStart To $iEnd
		DllStructSetData($tData, 1, $iValue, $i)
		If @error Then
			Return SetError(5, 0, $i - $iStart)
		EndIf
	Next
	Return $iEnd - $iStart + 1
EndFunc   ;==>_WinAPI_FillStruct

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_FindResource
; Description....: Determines the location of a resource with the specified type and name in the specified module.
; Syntax.........: _WinAPI_FindResource ( $hInstance, $sName, $sType )
; Parameters.....: $hInstance - Handle to the module whose executable file contains the resource. A value of 0 specifies the module
;                               handle associated with the image file that the operating system used to create the current process.
;                  $sName     - The name of the resource. This parameter can be string or integer type.
;                  $sType     - The type of the resource. This parameter can be string or integer type.
; Return values..: Success    - Handle to the specified resource's information block. To obtain a handle to the resource, pass this
;                               handle to the _WinAPI_LoadResource() function.
;                  Failure    - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: If the first character of the string of the $sName or $sType parameter is a pound sign (#), the remaining
;                  characters represent a decimal number that specifies the integer identifier of the resource's name or type.
;                  For example, the string "#258" represents the integer identifier 258.
;
;                  To reduce the amount of memory required for a resource, an application should refer to it by integer identifier
;                  instead of by name.
;
;                  An application can use _WinAPI_FindResource() to find any type of resource, but this function should be used
;                  only if the application must access the binary resource data when making subsequent calls to _WinAPI_LockResource().
; Related........:
; Link...........: @@MsdnLink@@ FindResource
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_FindResource($hInstance, $sName, $sType)

	Local $TypeOfName = 'ptr', $TypeOfType = 'ptr'

	If IsString($sName) Then
		$TypeOfName = 'wstr'
	EndIf
	If IsString($sType) Then
		$TypeOfType = 'wstr'
	EndIf

	Local $Ret = DllCall('kernel32.dll', 'ptr', 'FindResourceW', 'ptr', $hInstance, $TypeOfName, $sName, $TypeOfType, $sType)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_FindResource

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_FindResourceEx
; Description....: Determines the location of the resource with the specified type, name, and language in the specified module.
; Syntax.........: _WinAPI_FindResourceEx ( $hInstance, $sName, $sType, $iLanguage )
; Parameters.....: $hInstance - Handle to the module whose executable file contains the resource. A value of 0 specifies the module
;                               handle associated with the image file that the operating system used to create the current process.
;                  $sName     - The name of the resource. This parameter can be string or integer type.
;                  $sType     - The type of the resource. This parameter can be string or integer type.
;                  $iLanguage - The language of the resource (LCID constant).
; Return values..: Success    - Handle to the specified resource's information block. To obtain a handle to the resource, pass this
;                               handle to the _WinAPI_LoadResource() function.
;                  Failure    - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: If the first character of the string of the $sName or $sType parameter is a pound sign (#), the remaining
;                  characters represent a decimal number that specifies the integer identifier of the resource's name or type.
;                  For example, the string "#258" represents the integer identifier 258.
;
;                  To reduce the amount of memory required for a resource, an application should refer to it by integer identifier
;                  instead of by name.
;
;                  An application can use _WinAPI_FindResource() to find any type of resource, but this function should be used
;                  only if the application must access the binary resource data when making subsequent calls to _WinAPI_LockResource().
; Related........:
; Link...........: @@MsdnLink@@ FindResourceEx
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_FindResourceEx($hInstance, $sName, $sType, $iLanguage)

	Local $TypeOfName = 'ptr', $TypeOfType = 'ptr'

	If IsString($sName) Then
		$TypeOfName = 'wstr'
	EndIf
	If IsString($sType) Then
		$TypeOfType = 'wstr'
	EndIf

	Local $Ret = DllCall('kernel32.dll', 'ptr', 'FindResourceExW', 'ptr', $hInstance, $TypeOfType, $sType, $TypeOfName, $sName, 'ushort', $iLanguage)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_FindResourceEx

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_FitToBitmap
; Description....: Changes the size of a bitmap to the specified dimensions.
; Syntax.........: _WinAPI_FitToBitmap ( $hBitmap, $iWidth, $iHeight [, $iMode] )
; Parameters.....: $hBitmap - Handle to the bitmap to be resized.
;                  $iWidth  - The width, in pixels, in which the bitmap must fit.
;                  $iHeight - The height, in pixels, in which the bitmap must fit.
;                  $iMode   - The resizing mode. This parameter can be one of the following values (same as for
;                             _WinAPI_SetStretchBltMode()).
;
;                             $BLACKONWHITE
;                             $COLORONCOLOR
;                             $HALFTONE
;                             $WHITEONBLACK
;                             $STRETCH_ANDSCANS
;                             $STRETCH_DELETESCANS
;                             $STRETCH_HALFTONE
;                             $STRETCH_ORSCANS
;
; Return values..: Success  - Handle to the new bitmap that was created.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function does not support bitmaps with Alpha channel, use _WinAPI_AlphaBlend() to work with them.
;
;                  When you are finished using the bitmap, destroy it using the _WinAPI_FreeObject() function. _WinAPI_FitToBitmap()
;                  does not destroy the original bitmap, you must to destroy it.
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_FitToBitmap($hBitmap, $iWidth, $iHeight, $iMode = 3)

	Local $Ret, $tObj, $hBmp, $hDC, $hDestDC, $hDestSv, $hSrcDC, $hSrcSv

    $tObj = DllStructCreate($tagBITMAP)
	$Ret = DllCall('gdi32.dll', 'int', 'GetObject', 'int', $hBitmap, 'int', DllStructGetSize($tObj), 'ptr', DllStructGetPtr($tObj))
	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	$Ret = DllCall('user32.dll', 'hwnd', 'GetDC', 'hwnd', 0)
	$hDC = $Ret[0]
	$Ret = DllCall('gdi32.dll', 'hwnd', 'CreateCompatibleDC', 'hwnd', $hDC)
	$hDestDC = $Ret[0]
	$Ret = DllCall('gdi32.dll', 'hwnd', 'CreateCompatibleBitmap', 'hwnd', $hDC, 'int', $iWidth, 'int', $iHeight)
	$hBmp = $Ret[0]
	$Ret = DllCall('gdi32.dll', 'hwnd', 'SelectObject', 'hwnd', $hDestDC, 'ptr', $hBmp)
	$hDestSv = $Ret[0]
	$Ret = DllCall('gdi32.dll', 'hwnd', 'CreateCompatibleDC', 'hwnd', $hDC)
	$hSrcDC = $Ret[0]
	$Ret = DllCall('gdi32.dll', 'hwnd', 'SelectObject', 'hwnd', $hSrcDC, 'ptr', $hBitmap)
	$hSrcSv = $Ret[0]
	_WinAPI_SetStretchBltMode($hDestDC, $iMode)
	$Ret = _WinAPI_StretchBlt($hDestDC, 0, 0, $iWidth, $iHeight, $hSrcDC, 0, 0, DllStructGetData($tObj, 'bmWidth'), DllStructGetData($tObj, 'bmHeight'), 0x00CC0020)
	DllCall('user32.dll', 'int', 'ReleaseDC', 'hwnd', 0, 'hwnd', $hDC)
	DllCall('gdi32.dll', 'ptr', 'SelectObject', 'hwnd', $hDestDC, 'ptr', $hDestSv)
	DllCall('gdi32.dll', 'ptr', 'SelectObject', 'hwnd', $hSrcDC, 'ptr', $hSrcSv)
	DllCall('gdi32.dll', 'int', 'DeleteDC', 'hwnd', $hDestDC)
	DllCall('gdi32.dll', 'int', 'DeleteDC', 'hwnd', $hSrcDC)
	If Not $Ret Then
		Return SetError(1, 0, 0)
	EndIf
	Return $hBmp
EndFunc   ;==>_WinAPI_FitToBitmap

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_FormatDriveDlg
; Description....: Opens the Shell's Format dialog.
; Syntax.........: _WinAPI_FormatDriveDlg ( $sDrive [, $iOption [, $hParent]] )
; Parameters.....: $sDrive  - The drive to format, in the format D:, E:, etc.
;                  $iOption - This parameter must be 0 or one of the following values that alter the default format options in the dialog.
;
;                             $SHFMT_OPT_FULL
;                             $SHFMT_OPT_QUICKFORMAT
;                             $SHFMT_OPT_SYSONLY
;
;                  $hParent - Handle of the parent window of the dialog.
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to one of the following constant.
;
;                             $SHFMT_ERROR
;                             $SHFMT_CANCEL
;                             $SHFMT_NOFORMAT
;
; Author.........: Yashied
; Modified.......:
; Remarks........: The format is controlled by the dialog interface. That is, the user must click the OK button to actually begin the
;                  format—the format cannot be started programmatically.
; Related........:
; Link...........: @@MsdnLink@@ SHFormatDrive
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_FormatDriveDlg($sDrive, $iOption = 0, $hParent = 0)

	If Not IsString($sDrive) Then
		Return SetError(-1, 0, 0)
	EndIf
	$sDrive = StringLeft(StringUpper(StringStripWS($sDrive, 1)), 1)
	If Not $sDrive Then
		Return SetError(-1, 0, 0)
	EndIf
	$sDrive = Asc($sDrive) - 65
	If ($sDrive < 0) Or ($sDrive > 25) Then
		Return SetError(-1, 0, 0)
	EndIf

	Local $Ret = DllCall('shell32.dll', 'int', 'SHFormatDrive', 'hwnd', $hParent, 'uint', $sDrive, 'uint', $SHFMT_ID_DEFAULT, 'uint', $iOption)

	If @error Then
		Return SetError(-1, 0, 0)
	Else
		If $Ret[0] < 0 Then
			Return SetError($Ret[0], 0, 0)
		EndIf
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_FormatDriveDlg

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_FrameRect
; Description....: Draws a border around the specified rectangle by using the specified brush.
; Syntax.........: _WinAPI_FrameRect ( $hDC, $tRECT, $hBrush )
; Parameters.....: $hDC    - Handle to the device context in which the border is drawn.
;                  $tRECT  - $tagRECT structure that contains the logical coordinates of the upper-left and lower-right
;                            corners of the rectangle.
;                  $hBrush - Handle to the brush used to draw the border.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ FrameRect
; Example........: Yes
; ===============================================================================================================================

#cs

Func _WinAPI_FrameRect($hDC, $tRECT, $hBrush)

	Local $Ret = DllCall('user32.dll', 'int', 'FrameRect', 'hwnd', $hDC, 'ptr', DllStructGetPtr($tRECT), 'ptr', $hBrush)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_FrameRect

#ce

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_FrameRgn
; Description....: Draws a border around the specified region by using the specified brush.
; Syntax.........: _WinAPI_FrameRgn ( $hDC, $hRgn, $hBrush, $iWidth, $iHeight )
; Parameters.....: $hDC     - Handle to the device context.
;                  $hRgn    - Handle to the region to be enclosed in a border. The region's coordinates are presumed to be in
;                             logical units.
;                  $hBrush  - Handle to the brush to be used to draw the border.
;                  $iWidth  - The width, in logical units, of vertical brush strokes.
;                  $iHeight - The height, in logical units, of horizontal brush strokes.
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ FrameRgn
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_FrameRgn($hDC, $hRgn, $hBrush, $iWidth, $iHeight)

	Local $Ret = DllCall('gdi32.dll', 'int', 'FrameRgn', 'hwnd', $hDC, 'ptr', $hRgn, 'ptr', $hBrush, 'int', $iWidth, 'int', $iHeight)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_FrameRgn

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_FreeCursor
; Description....: Destroys a cursor and frees any memory the cursor occupied.
; Syntax.........: _WinAPI_FreeCursor ( $hCursor )
; Parameters.....: $hCursor - Handle to the cursor to be destroyed. The cursor must not be in use.
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function destroys a nonshared cursor. Do not use this function to destroy a shared cursor. A shared cursor
;                  is valid as long as the module from which it was loaded remains in memory.
; Related........:
; Link...........: @@MsdnLink@@ DestroyCursor
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_FreeCursor($hCursor)

	Local $Ret = DllCall('user32.dll', 'int', 'DestroyCursor', 'ptr', $hCursor)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_FreeCursor

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_FreeHandle
; Description....: Closes an open object handle.
; Syntax.........: _WinAPI_FreeHandle ( $hObject )
; Parameters.....: $hObject - Handle to an open object.
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The _WinAPI_FreeHandle() function closes handles to the following objects:
;
;                  Access token
;                  Communications device
;                  Console input
;                  Console screen buffer
;                  Event
;                  File
;                  File mapping
;                  I/O completion port
;                  Job
;                  Mailslot
;                  Memory resource notification
;                  Mutex
;                  Named pipe
;                  Pipe
;                  Process
;                  Semaphore
;                  Thread
;                  Transaction
;                  Waitable timer
;
; Related........:
; Link...........: @@MsdnLink@@ CloseHandle
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_FreeHandle($hObject)

	Local $Ret = DllCall('kernel32.dll', 'int', 'CloseHandle', 'ptr', $hObject)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_FreeHandle

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_FreeIcon
; Description....: Destroys an icon and frees any memory the icon occupied.
; Syntax.........: _WinAPI_FreeIcon ( $hIcon )
; Parameters.....: $hIcon  - Handle to the icon to be destroyed.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: Do not use this function to destroy a shared icon. A shared icon is valid as long as the module from which it
;                  was loaded remains in memory.
; Related........:
; Link...........: @@MsdnLink@@ DestroyIcon
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_FreeIcon($hIcon)

	Local $Ret = DllCall('user32.dll', 'int', 'DestroyIcon', 'ptr', $hIcon)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_FreeIcon

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_FreeMRUList
; Description....: Frees the handle associated with the most recently used (MRU) list and writes cached data to the registry.
; Syntax.........: _WinAPI_FreeMRUList ( $hMRU )
; Parameters.....: $hMRU   - Handle of the MRU list to free.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: If the MRU list was created using the $MRU_CACHEWRITE flag, calling _WinAPI_FreeMRUList() causes any changes not
;                  yet written to the version of the MRU list stored in registry to be written at this time.
; Related........:
; Link...........: @@MsdnLink@@ FreeMRUList
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_FreeMRUList($hMRU)

	Local $Ret = DllCall('comctl32.dll ', 'int', 'FreeMRUList', 'ptr', $hMRU)

	If (@error) Or ($Ret[0] < 0) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_FreeMRUList

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_FreeObject
; Description....: Deletes a logical pen, brush, font, bitmap, region, or palette.
; Syntax.........: _WinAPI_FreeObject ( $hObject )
; Parameters.....: $hObject - Handle to a logical pen, brush, font, bitmap, region, or palette.
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: Do not delete a drawing object (pen or brush) while it is still selected into a DC. When a pattern brush is deleted,
;                  the bitmap associated with the brush is not deleted. The bitmap must be deleted independently.
; Related........:
; Link...........: @@MsdnLink@@ DeleteObject
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_FreeObject($hObject)

	Local $Ret = DllCall('gdi32.dll', 'int', 'DeleteObject', 'int', $hObject)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_FreeObject

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_FreeResource
; Description....: Decrements (decreases by one) the reference count of a loaded resource.
; Syntax.........: _WinAPI_FreeResource ( $hData )
; Parameters.....: $hData  - Handle of the resource was created by _WinAPI_LoadResource().
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The reference count for a resource is incremented (increased by one) each time an application calls the
;                  _WinAPI_LoadResource() function for the resource. This function is obsolete and is only supported for backward
;                  compatibility with 16-bit Microsoft Windows. For 32-bit Windows applications, it is not necessary to free the
;                  resources loaded using function _WinAPI_LoadResource().
; Related........:
; Link...........: @@MsdnLink@@ FreeResource
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_FreeResource($hData)

	Local $Ret = DllCall('kernel32.dll', 'int', 'FreeResource', 'ptr', $hData)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_FreeResource

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetActiveWindow
; Description....: Retrieves the window handle to the active window attached to the calling process's message queue.
; Syntax.........: _WinAPI_GetActiveWindow ( )
; Parameters.....: None
; Return values..: Success - Handle to the active window attached to the calling process's message queue.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetActiveWindow
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetActiveWindow()

	Local $Ret = DllCall('user32.dll', 'hwnd', 'GetActiveWindow')

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_GetActiveWindow

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetBinaryType
; Description....: Determines whether a file is an executable (.exe) file, and if so, which subsystem runs the executable file.
; Syntax.........: _WinAPI_GetBinaryType ( $sPath )
; Parameters.....: $sPath  - The full path of the file whose executable type is to be determined.
; Return values..: Success - 1 - The file is executable, @extended flag will be contains one of the $SCS_... constant to
;                                indicate the file's executable type.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetBinaryType
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetBinaryType($sPath)

	Local $tData = DllStructCreate('wchar[1024]')
	Local $Ret = DllCall('kernel32.dll', 'int', 'GetBinaryTypeW', 'wstr', $sPath, 'dword*', 0)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	If Not $Ret[0] Then
		$Ret[2] = 0
	EndIf
	Return SetError(0, $Ret[2], $Ret[0])
EndFunc   ;==>_WinAPI_GetBinaryType

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetBitmapDimension
; Description....: Retrieves a dimension for the specified bitmap.
; Syntax.........: _WinAPI_GetBitmapDimension ( $hBitmap )
; Parameters.....: $hBitmap - Handle to the bitmap to retrieve dimension.
; Return values..: Success  - $tagSIZE structure that contains the bitmap dimension.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetBitmapDimension($hBitmap)

    Local $tObj = DllStructCreate($tagBITMAP)
	Local $Ret = DllCall('gdi32.dll', 'int', 'GetObject', 'int', $hBitmap, 'int', DllStructGetSize($tObj), 'ptr', DllStructGetPtr($tObj))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $tSIZE = DllStructCreate($tagSIZE)

	DllStructSetData($tSIZE, 'X', DllStructGetData($tObj, 'bmWidth'))
	DllStructSetData($tSIZE, 'Y', DllStructGetData($tObj, 'bmHeight'))

	Return $tSIZE
EndFunc   ;==>_WinAPI_GetBitmapDimension

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetBkColor
; Description....: Retrieves the current background color for the specified device context.
; Syntax.........: _WinAPI_GetBkColor ( $hDC )
; Parameters.....: $hDC    - Handle to the device context.
; Return values..: Success - The value of the current background color, in RGB.
;                  Failure - (-1) and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetBkColor
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetBkColor($hDC)

	Local $Ret = DllCall('gdi32.dll', 'int', 'GetBkColor', 'hwnd', $hDC)

	If (@error) Or ($Ret[0] = -1) Then
		Return SetError(1, 0, -1)
	EndIf
	Return __IsRGB($Ret[0])
EndFunc   ;==>_WinAPI_GetBkColor

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetBValue
; Description....: Retrieves an intensity value for the blue component of a 32-bit RGB value.
; Syntax.........: _WinAPI_GetBValue ( $iRGB )
; Parameters.....: $iRGB - The color value, in RGB.
; Return values..: The intensity of the blue component of the specified RGB color.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetBValue($iRGB)
	Return BitShift(BitAND(__IsRGB($iRGB), 0xFF0000), 16)
EndFunc   ;==>_WinAPI_GetBValue

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetCaretBlinkTime
; Description....: Returns the time required to invert the caret's pixels.
; Syntax.........: _WinAPI_GetCaretBlinkTime ( )
; Parameters.....: None
; Return values..: Success - The blink time, in milliseconds.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetCaretBlinkTime
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetCaretBlinkTime()

	Local $Ret = DllCall('user32.dll', 'uint', 'GetCaretBlinkTime')

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_GetCaretBlinkTime

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetCaretPos
; Description....: Retrieves the caret's position.
; Syntax.........: _WinAPI_GetCaretPos ( )
; Parameters.....: None
; Return values..: Success - The array that contains the client coordinates of the caret.
;
;                            [0] - x-coordinate of the caret.
;                            [1] - y-coordinate of the caret.
;
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetCaretPos
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetCaretPos()

	Local $tPOINT = DllStructCreate($tagPOINT)
	Local $Ret = DllCall('user32.dll', 'int', 'GetCaretPos', 'ptr', DllStructGetPtr($tagPOINT))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $Result[2]

	For $i = 0 To 1
		$Result[$i] = DllStructGetData($tPOINT, $i + 1)
	Next
	Return $Result
EndFunc   ;==>_WinAPI_GetCaretPos

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetClassLong
; Description....: Retrieves the specified 32-bit (long) value associated with the specified window.
; Syntax.........: _WinAPI_GetClassLong ( $hWnd, $iIndex )
; Parameters.....: $hWnd   - Handle to the window and, indirectly, the class to which the window belongs.
;                  $iIndex - The 32-bit value to retrieve. This parameter can be one of the following values.
;
;                            $GCL_CBCLSEXTRA
;                            $GCL_CBWNDEXTRA
;                            $GCL_HBRBACKGROUND
;                            $GCL_HCURSOR
;                            $GCL_HICON
;                            $GCL_HICONSM
;                            $GCL_HMODULE
;                            $GCL_MENUNAME
;                            $GCL_STYLE
;                            $GCL_WNDPROC
;
; Return values..: Success - The value is the requested 32-bit value.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetClassLong
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetClassLong($hWnd, $iIndex)

	Local $Ret = DllCall('user32.dll', 'int', 'GetClassLong', 'hwnd', $hWnd, 'int', $iIndex)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_GetClassLong

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetCompression
; Description....: Retrieves the current compression state of a file or directory.
; Syntax.........: _WinAPI_GetCompression ( $sPath )
; Parameters.....: $sPath  - Path to file or directory to retrieve compression state.
; Return values..: Success - The current compression state.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ FSCTL_GET_COMPRESSION
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetCompression($sPath)

	Local $hFile = _WinAPI_CreateFileEx($sPath, 3, 0x80000000, 0x01, 0x02000000)

	If Not $hFile Then
		Return SetError(1, 0, 0)
	EndIf

	Local $tData = DllStructCreate('ushort')
	Local $Ret = DllCall('kernel32.dll', 'int', 'DeviceIoControl', 'ptr', $hFile, 'dword', 0x0009003C, 'ptr', 0, 'dword', 0, 'ptr', DllStructGetPtr($tData), 'dword', DllStructGetSize($tData), 'dword*', 0, 'ptr', 0)

	If (@error) Or (Not $Ret[0]) Then
		$Ret = 0
	EndIf
	_WinAPI_FreeHandle($hFile)
	If Not IsArray($Ret) Then
		Return SetError(2, 0, 0)
	EndIf
	Return SetError(0, 0, DllStructGetData($tData, 1))
EndFunc   ;==>_WinAPI_GetCompression

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetCurrentDirectory
; Description....: Retrieves the current directory for the current process.
; Syntax.........: _WinAPI_GetCurrentDirectory ( )
; Parameters.....: None
; Return values..: Success - The absolute path to the current directory.
;                  Failure - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetCurrentDirectory
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetCurrentDirectory()

	Local $tData = DllStructCreate('wchar[1024]')
	Local $Ret = DllCall('kernel32.dll', 'int', 'GetCurrentDirectoryW', 'dword', 1024, 'ptr', DllStructGetPtr($tData))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, '')
	EndIf
	Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_GetCurrentDirectory

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetCurrentHwProfile
; Description....: Retrieves information about the current hardware profile for the local computer.
; Syntax.........: _WinAPI_GetCurrentHwProfile ( )
; Parameters.....: None
; Return values..: Success - $tagHW_PROFILE_INFO structure that contains information about the current hardware profile.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetCurrentHwProfile
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetCurrentHwProfile()

	Local $tHW_PROFILE_INFO = DllStructCreate($tagHW_PROFILE_INFO)
	Local $Ret = DllCall('advapi32.dll', 'int', 'GetCurrentHwProfileW', 'ptr', DllStructGetPtr($tHW_PROFILE_INFO))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $tHW_PROFILE_INFO
EndFunc   ;==>_WinAPI_GetCurrentHwProfile

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetCurrentThemeName
; Description....: Retrieves the name of the current visual styles, color scheme name, and size name.
; Syntax.........: _WinAPI_GetCurrentThemeName ( )
; Parameters.....: None
; Return values..: Success - The array that contains the following information.
;
;                  [0] - The theme path and file name.
;                  [1] - The color scheme name.
;                  [2] - The size name.
;
;                  Failure - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetCurrentThemeName
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetCurrentThemeName()

	Local $tData = DllStructCreate('wchar[1024];wchar[1024];wchar[1024]')
	Local $Ret = DllCall('uxtheme.dll', 'uint', 'GetCurrentThemeName', 'ptr', DllStructGetPtr($tData, 1), 'int', 1024, 'ptr', DllStructGetPtr($tData, 2), 'int', 1024, 'ptr', DllStructGetPtr($tData, 3), 'int', 1024)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf

	Local $Result[3]

	For $i = 0 To 2
		$Result[$i] = DllStructGetData($tData, $i + 1)
	Next
	Return $Result
EndFunc   ;==>_WinAPI_GetCurrentThemeName

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetCursor
; Description....: Retrieves a handle to the current cursor.
; Syntax.........: _WinAPI_GetCursor ( )
; Parameters.....: None
; Return values..: Success - Handle to the current cursor. If there is no cursor, the return value is 0.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetCursor
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetCursor()

	Local $Ret = DllCall('user32.dll', 'ptr', 'GetCursor')

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_GetCursor

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetDateFormat
; Description....: Formats a date as a date string for a locale specified by the locale identifier.
; Syntax.........: _WinAPI_GetDateFormat ( [$LCID [, $tSYSTEMTIME [, $iFlag [, $sFormat]]]] )
; Parameters.....: $LCID        - Locale identifier (LCID constant) that specifies the locale. If this parameter is 0, the function
;                                 will use default locale for the user.
;                  $tSYSTEMTIME - $tagSYSTEMTIME structure that contains the date information to format. If this parameter is 0,
;                                 the function will use the current local system date.
;                  $iFlag       - Flags specifying date format options. This parameter can be one or more of the following values.
;
;                                 $DATE_LONGDATE
;                                 $DATE_SHORTDATE (Default)
;                                 $DATE_USE_ALT_CALENDAR
;
;                                 *Windows Vista or above
;
;                                 $DATE_LTRREADING
;                                 $DATE_RTLREADING
;                                 $DATE_YEARMONTH
;
;                                 *Windows 7 or above
;
;                                 $DATE_AUTOLAYOUT
;
;                  $sFormat     - The string that is used to form the date. For example, "dddd dd, yyyy". If this parameter is 0,
;                                 the function returns the string according to the date format for the specified locale ($LCID).
; Return values..: Success      - The formatted date string.
;                  Failure      - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetDateFormat
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetDateFormat($LCID = 0, $tSYSTEMTIME = 0, $iFlags = 0, $sFormat = '')

	Local $TypeOfFormat = 'wstr'

	If Not $LCID Then
		$LCID = 0x0400
	EndIf
	If Not StringStripWS($sFormat, 3) Then
		$TypeOfFormat = 'ptr'
		$sFormat = 0
	EndIf

	Local $tData = DllStructCreate('wchar[1024]')
	Local $Ret = DllCall('kernel32.dll', 'int', 'GetDateFormatW', 'long', $LCID, 'dword', $iFlags, 'ptr', DllStructGetPtr($tSYSTEMTIME), $TypeOfFormat, $sFormat, 'ptr', DllStructGetPtr($tData), 'int', 1024)

    If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, '')
	EndIf
    Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_GetDateFormat

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetDefaultPrinter
; Description....: Retrieves the printer name of the default printer for the current user on the local computer.
; Syntax.........: _WinAPI_GetDefaultPrinter ( )
; Parameters.....: None
; Return values..: Success - String containing the default printer name.
;                  Failure - Empty string and sets the @error flag to:
;                            1 - Function fails or not found
;                            2 - No default printer
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetDefaultPrinter
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetDefaultPrinter()

	Local $tData = DllStructCreate('wchar[1024]')
	Local $Ret = DllCall('winspool.drv', 'int', 'GetDefaultPrinterW', 'ptr', DllStructGetPtr($tData), 'dword*', 1024)

    If (@error) Or (Not $Ret[0]) Then
		Return SetError(1 + (_WinAPI_GetLastError() = 0x02), 0, '')
	EndIf
    Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_GetDefaultPrinter

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetDeviceDriverBaseName
; Description....: Retrieves the base name of the specified device driver.
; Syntax.........: _WinAPI_GetDeviceDriverBaseName ( $hDriver )
; Parameters.....: $hDriver - The load address of the device driver. This value can be retrieved using the _WinAPI_EnumDeviceDrivers() function.
; Return values..: Success  - The base name of the device driver.
;                  Failure  - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetDeviceDriverBaseName
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetDeviceDriverBaseName($hDriver)

	Local $tData = DllStructCreate('wchar[1024]')
	Local $Ret = DllCall('psapi.dll', 'int', 'GetDeviceDriverBaseNameW', 'ptr', $hDriver, 'ptr', DllStructGetPtr($tData), 'dword', 1024)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, '')
	EndIf
	Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_GetDeviceDriverBaseName

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetDeviceDriverFileName
; Description....: Retrieves the path available for the specified device driver.
; Syntax.........: _WinAPI_GetDeviceDriverFileName ( $hDriver )
; Parameters.....: $hDriver - The load address of the device driver. This value can be retrieved using the _WinAPI_EnumDeviceDrivers() function.
; Return values..: Success  - The path to the device driver.
;                  Failure  - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetDeviceDriverFileName
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetDeviceDriverFileName($hDriver)

	Local $tData = DllStructCreate('wchar[1024]')
	Local $Ret = DllCall('psapi.dll', 'int', 'GetDeviceDriverFileNameW', 'ptr', $hDriver, 'ptr', DllStructGetPtr($tData), 'dword', 1024)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, '')
	EndIf
	Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_GetDeviceDriverFileName

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetDiskFreeSpaceEx
; Description....: Retrieves information about the amount of space that is available on a disk volume.
; Syntax.........: _WinAPI_GetDiskFreeSpaceEx ( $sDrive )
; Parameters.....: $sDrive - The drive to retrieve information, in the format D:, E:, etc.
; Return values..: Success - The array containing the following parameters:
;
;                            [0] - The total number of available free bytes on a disk. If per-user quotas are being used, this value
;                                  may be less than the total number of free bytes on a disk.
;                            [1] - The total number of available bytes on a disk. If per-user quotas are being used, this value
;                                  may be less than the total number of bytes on a disk.
;                            [2] - The total number of free bytes on a disk.
;
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetDiskFreeSpaceEx
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetDiskFreeSpaceEx($sDrive)

	Local $tFreeBytesAvailable = DllStructCreate('int64')
	Local $tTotalNumberOfBytes = DllStructCreate('int64')
	Local $tTotalNumberOfFreeBytes = DllStructCreate('int64')
	Local $Ret = DllCall('kernel32.dll', 'int', 'GetDiskFreeSpaceEx', 'str', $sDrive, 'ptr', DllStructGetPtr($tFreeBytesAvailable), 'ptr', DllStructGetPtr($tTotalNumberOfBytes), 'ptr', DllStructGetPtr($tTotalNumberOfFreeBytes))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $Result[3]

	$Result[0] = DllStructGetData($tFreeBytesAvailable, 1)
	$Result[1] = DllStructGetData($tTotalNumberOfBytes, 1)
	$Result[2] = DllStructGetData($tTotalNumberOfFreeBytes, 1)

	Return $Result
EndFunc   ;==>_WinAPI_GetDiskFreeSpaceEx

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetDriveBusType
; Description....: Retrieves a bus type for the specified drive.
; Syntax.........: _WinAPI_GetDriveBusType ( $sDrive )
; Parameters.....: $sDrive - The drive letter to retrieve information, in the format D:, E:, etc.
; Return values..: Success - The bus type constant ($DRIVE_BUS_TYPE_...).
;                  Failure - (-1) and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function works with the Plug and Play drivers only.
; Related........:
; Link...........: @@MsdnLink@@ IOCTL_STORAGE_QUERY_PROPERTY
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetDriveBusType($sDrive)

	Local $hFile = _WinAPI_CreateFileEx('\\.\' & $sDrive, 3, 0, 0)

	If Not $hFile Then
		Return SetError(1, 0, -1)
	EndIf

	Local $tSTORAGE_PROPERTY_QUERY = DllStructCreate('dword;dword;byte[4]')
	Local $tSTORAGE_DEVICE_DESCRIPTOR = DllStructCreate('ulong;ulong;byte;byte;byte;byte;ulong;ulong;ulong;ulong;dword;ulong;byte[512]')
	Local $Ret = DllCall('kernel32.dll', 'int', 'DeviceIoControl', 'ptr', $hFile, 'dword', 0x002D1400, 'ptr', DllStructGetPtr($tSTORAGE_PROPERTY_QUERY), 'dword', DllStructGetSize($tSTORAGE_PROPERTY_QUERY), 'ptr', DllStructGetPtr($tSTORAGE_DEVICE_DESCRIPTOR), 'dword', DllStructGetSize($tSTORAGE_DEVICE_DESCRIPTOR), 'dword*', 0, 'ptr', 0)

	If (@error) Or (Not $Ret[0]) Then
		$Ret = 0
	EndIf
	_WinAPI_FreeHandle($hFile)
	If Not IsArray($Ret) Then
		Return SetError(2, 0, -1)
	EndIf
	Return SetError(0, 0, DllStructGetData($tSTORAGE_DEVICE_DESCRIPTOR, 11))
EndFunc   ;==>_WinAPI_GetDriveBusType

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetDriveGeometryEx
; Description....: Retrieves extended information about the disk's geometry.
; Syntax.........: _WinAPI_GetDriveGeometryEx ( $iDrive )
; Parameters.....: $iDrive - The drive letter to retrieve information, in the format D:, E:, etc.
; Return values..: Success - $tagDISK_GEOMETRY_EX structure that contains the information about the disk's geometry.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ IOCTL_DISK_GET_DRIVE_GEOMETRY_EX
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetDriveGeometryEx($iDrive)

	Local $hFile = _WinAPI_CreateFileEx('\\.\PhysicalDrive' & $iDrive, 3, 0x80000000, 0x01)

	If Not $hFile Then
		Return SetError(1, 0, 0)
	EndIf

	Local $tDISK_GEOMETRY_EX = DllStructCreate($tagDISK_GEOMETRY_EX)
	Local $Ret = DllCall('kernel32.dll', 'int', 'DeviceIoControl', 'ptr', $hFile, 'dword', 0x000700A0, 'ptr', 0, 'dword', 0, 'ptr', DllStructGetPtr($tDISK_GEOMETRY_EX), 'dword', DllStructGetSize($tDISK_GEOMETRY_EX), 'dword*', 0, 'ptr', 0)

	If (@error) Or (Not $Ret[0]) Then
		$Ret = 0
	EndIf
	_WinAPI_FreeHandle($hFile)
	If Not IsArray($Ret) Then
		Return SetError(2, 0, 0)
	EndIf
	Return SetError(0, 0, $tDISK_GEOMETRY_EX)
EndFunc   ;==>_WinAPI_GetDriveGeometryEx

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetDriveNumber
; Description....: Retrieves a device type, device number, and partition number for the specified drive.
; Syntax.........: _WinAPI_GetDriveNumber ( $sDrive )
; Parameters.....: $sDrive - The drive letter to retrieve information, in the format D:, E:, etc.
; Return values..: Success - $tagSTORAGE_DEVICE_NUMBER structure that contains the relevant information.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ IOCTL_STORAGE_GET_DEVICE_NUMBER
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetDriveNumber($sDrive)

	Local $hFile = _WinAPI_CreateFileEx('\\.\' & $sDrive, 3, 0, 0)

	If Not $hFile Then
		Return SetError(1, 0, 0)
	EndIf

	Local $tSTORAGE_DEVICE_NUMBER = DllStructCreate($tagSTORAGE_DEVICE_NUMBER)
	Local $Ret = DllCall('kernel32.dll', 'int', 'DeviceIoControl', 'ptr', $hFile, 'dword', 0x002D1080, 'ptr', 0, 'dword', 0, 'ptr', DllStructGetPtr($tSTORAGE_DEVICE_NUMBER), 'dword', DllStructGetSize($tSTORAGE_DEVICE_NUMBER), 'dword*', 0, 'ptr', 0)

	If (@error) Or (Not $Ret[0]) Then
		$Ret = 0
	EndIf
	_WinAPI_FreeHandle($hFile)
	If Not IsArray($Ret) Then
		Return SetError(2, 0, 0)
	EndIf
	Return SetError(0, 0, $tSTORAGE_DEVICE_NUMBER)
EndFunc   ;==>_WinAPI_GetDriveNumber

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetDriveType
; Description....: Determines whether a disk drive is a removable, fixed, CD-ROM, RAM disk, or network drive.
; Syntax.........: _WinAPI_GetDriveType ( [$sDrive] )
; Parameters.....: $sDrive - The drive letter to retrieve information, in the format D:, E:, etc.
; Return values..: Success - The type of drive ($DRIVE_...).
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetDriveType
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetDriveType($sDrive = '')

	Local $tDrive, $pDrive = 0

	$sDrive = StringStripWS($sDrive, 3)
	If $sDrive Then
		$tDrive = DllStructCreate('char[' & StringLen($sDrive) + 1 & ']')
		DllStructSetData($tDrive, 1, $sDrive)
		$pDrive = DllStructGetPtr($tDrive)
	EndIf

	Local $Ret = DllCall('kernel32.dll', 'int', 'GetDriveType', 'ptr', $pDrive)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_GetDriveType

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetFontResourceInfo
; Description....: Retrieves the fontname from the specified font resource file.
; Syntax.........: _WinAPI_GetFontResourceInfo ( $sFont [, $fForce] )
; Parameters.....: $sFont  - String that names a font resource file. To retrieve a fontname whose information comes from several
;                            resource files, they must be separated by a "|" . For example, abcxxxxx.pfm | abcxxxxx.pfb.
;                  $fForce - Specifies whether adds a file to the font table, valid values:
;                  |TRUE   - Forced add the specified file to the system font table and remove it after retrieving the fontname.
;                  |FALSE  - Don`t add and remove. (Default)
; Return values..: Success - The name of the font.
;                  Failure - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetFontResourceInfo($sFont, $fForce = 0)

	If $fForce Then
		If Not _WinAPI_AddFontResourceEx($sFont, $FR_NOT_ENUM) Then
			Return SetError(1, 0, '')
		EndIf
	EndIf

	Local $tData = DllStructCreate('wchar[1024]')
	Local $Ret = DllCall('gdi32.dll', 'int', 'GetFontResourceInfoW','wstr', $sFont, 'dword*', 1024, 'ptr', DllStructGetPtr($tData), 'dword', 0x01)

	If (@error) Or (Not $Ret[0]) Then
		$Ret = 0
	EndIf
	If $fForce Then
		_WinAPI_RemoveFontResourceEx($sFont, $FR_NOT_ENUM)
	EndIf
	If Not IsArray($Ret) Then
		Return SetError(1, 0, '')
	EndIf
	Return SetError(0, 0, DllStructGetData($tData, 1))
EndFunc   ;==>_WinAPI_GetFontResourceInfo

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetForegroundWindow
; Description....: Returns a handle to the foreground window.
; Syntax.........: _WinAPI_GetForegroundWindow ( )
; Parameters.....: None
; Return values..: Success - Handle to the foreground window.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetForegroundWindow
; Example........: Yes
; ===============================================================================================================================

#cs

Func _WinAPI_GetForegroundWindow()

	Local $Ret = DllCall('user32.dll', 'hwnd', 'GetForegroundWindow')

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_GetForegroundWindow

#ce

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetGValue
; Description....: Retrieves an intensity value for the green component of a 32-bit RGB value.
; Syntax.........: _WinAPI_GetGValue ( $iRGB )
; Parameters.....: $iRGB - The color value, in RGB.
; Return values..: The intensity of the green component of the specified RGB color.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetGValue($iRGB)
	Return BitShift(BitAND(__IsRGB($iRGB), 0x00FF00), 8)
EndFunc   ;==>_WinAPI_GetGValue

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetHandleInformation
; Description....: Retrieves certain properties of an object handle.
; Syntax.........: _WinAPI_GetHandleInformation ( $hObject )
; Parameters.....: $hObject - Handle to an object whose information is to be retrieved.
; Return values..: Success  - The value that specifies the properties of the object handle ($HANDLE_FLAG_...).
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetHandleInformation
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetHandleInformation($hObject)

	Local $Ret = DllCall('kernel32.dll', 'int', 'GetHandleInformation', 'ptr', $hObject, 'dword*', 0)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[2]
EndFunc   ;==>_WinAPI_GetHandleInformation

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetHGlobalFromStream
; Description....: Retrieves the global memory handle to a stream.
; Syntax.........: _WinAPI_GetHGlobalFromStream ( $hStream )
; Parameters.....: $hStream - Pointer to the stream object previously created by a call to the _WinAPI_CreateStreamOnHGlobal() function.
; Return values..: Success  - Pointer to the current memory handle used by the specified stream object.
;                  Failure  - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function can be called only from within the same process from which the byte array was created.
; Related........:
; Link...........: @@MsdnLink@@ GetHGlobalFromStream
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetHGlobalFromStream($hStream)

	Local $Ret = DllCall('ole32.dll', 'uint', 'GetHGlobalFromStream', 'ptr', $hStream, 'ptr*', 0)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return $Ret[2]
EndFunc   ;==>_WinAPI_GetHGlobalFromStream

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetIconBitmap
; Description....: Retrieves icon color bitmap for the specified icon.
; Syntax.........: _WinAPI_GetIconBitmap ( $hIcon )
; Parameters.....: $hIcon  - Handle to the icon to retrieve bitmap.
; Return values..: Success - Handle to the bitmap.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The calling application must manage this bitmap and delete when it are no longer necessary.
; Related........:
; Link...........: @@MsdnLink@@ GetIconInfo
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetIconBitmap($hIcon)

	Local $tICONINFO = DllStructCreate($tagICONINFO)
	Local $Ret = DllCall('user32.dll', 'int', 'GetIconInfo', 'ptr', $hIcon, 'ptr', DllStructGetPtr($tICONINFO))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	_WinAPI_FreeObject(DllStructGetData($tICONINFO, 4))
	Return SetError(0, 0, DllStructGetData($tICONINFO, 5))
EndFunc   ;==>_WinAPI_GetIconBitmap

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetIconDimension
; Description....: Retrieves a dimension for the specified icon.
; Syntax.........: _WinAPI_GetIconDimension ( $hIcon )
; Parameters.....: $hIcon  - Handle to the icon to retrieve dimension.
; Return values..: Success - $tagSIZE structure that contains the icon dimension.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetIconDimension($hIcon)

	Local $hBitmap = _WinAPI_GetIconBitmap($hIcon)
	Local $tSIZE = _WinAPI_GetBitmapDimension($hBitmap)

	_WinAPI_FreeObject($hBitmap)
	Return SetError(0, 0, $tSIZE)
EndFunc   ;==>_WinAPI_GetIconDimension

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetIconMask
; Description....: Retrieves icon bitmask bitmap for the specified icon.
; Syntax.........: _WinAPI_GetIconMask ( $hIcon )
; Parameters.....: $hIcon  - Handle to the icon to retrieve bitmap.
; Return values..: Success - Handle to the bitmap.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The calling application must manage this bitmap and delete when it are no longer necessary.
; Related........:
; Link...........: @@MsdnLink@@ GetIconInfo
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetIconMask($hIcon)

	Local $tICONINFO = DllStructCreate($tagICONINFO)
	Local $Ret = DllCall('user32.dll', 'int', 'GetIconInfo', 'ptr', $hIcon, 'ptr', DllStructGetPtr($tICONINFO))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	_WinAPI_FreeObject(DllStructGetData($tICONINFO, 5))
	Return SetError(0, 0, DllStructGetData($tICONINFO, 4))
EndFunc   ;==>_WinAPI_GetIconMask

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetIdleTime
; Description....: Retrieves the time that has elapsed since the last input.
; Syntax.........: _WinAPI_GetIdleTime ( )
; Parameters.....: None
; Return values..: Success - The elapsed time, in milliseconds.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetLastInputInfo
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetIdleTime()

	Local $tLASTINPUTINFO = DllStructCreate('uint;dword')

	DllStructSetData($tLASTINPUTINFO, 1, DllStructGetSize($tLASTINPUTINFO))

	Local $Ret = DllCall('user32.dll', 'int', 'GetLastInputInfo', 'ptr', DllStructGetPtr($tLASTINPUTINFO))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return _WinAPI_GetTickCount() - DllStructGetData($tLASTINPUTINFO, 2)
EndFunc   ;==>_WinAPI_GetIdleTime

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetKeyboardLayout
; Description....: Retrieves the active input locale identifier for the specified window.
; Syntax.........: _WinAPI_GetKeyboardLayout ( $hWnd )
; Parameters.....: $hWnd   - Handle to the window to retrieve the input locale identifier.
; Return values..: Success - The input locale identifier.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetKeyboardLayout
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetKeyboardLayout($hWnd)

	Local $Ret

	$Ret = DllCall('user32.dll', 'long', 'GetWindowThreadProcessId', 'hwnd', $hWnd, 'ptr', 0)
	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	$Ret = DllCall('user32.dll', 'long', 'GetKeyboardLayout', 'long', $Ret[0])
	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return BitAND($Ret[0], 0xFFFF)
EndFunc   ;==>_WinAPI_GetKeyboardLayout

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetKeyboardLayoutList
; Description....: Retrieves the all input locale identifiers corresponding to the current set of input locales in the system.
; Syntax.........: _WinAPI_GetKeyboardLayoutList ( )
; Parameters.....: None
; Return values..: Success - The array of input locale identifiers. The zeroth array element contains the number of identifiers.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetKeyboardLayoutList
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetKeyboardLayoutList()

	Local $Ret

	$Ret = DllCall('user32.dll', 'int', 'GetKeyboardLayoutList', 'int', 0, 'ptr', 0)
	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $tData = DllStructCreate('long[' & $Ret[0] & ']')

	$Ret = DllCall('user32.dll', 'int', 'GetKeyboardLayoutList', 'int', $Ret[0], 'ptr', DllStructGetPtr($tData))
	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $List[$Ret[0] + 1] = [$Ret[0]]

	For $i = 1 To $List[0]
		$List[$i] = BitAND(DllStructGetData($tData, 1, $i), 0xFFFF)
	Next
	Return $List
EndFunc   ;==>_WinAPI_GetKeyboardLayoutList

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetKeyboardState
; Description....: Copies the status of the 256 virtual keys to the specified buffer.
; Syntax.........: _WinAPI_GetKeyboardState ( )
; Parameters.....: None
; Return values..: Success - The structure of "byte[256]" that receives the status data for each virtual key.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: An application can call this function to retrieve the current status of all the virtual keys. The status changes
;                  as a process removes keyboard messages from its message queue. The status does not change as keyboard messages are
;                  posted to the process's message queue, nor does it change as keyboard messages are posted to or retrieved from
;                  message queues of other processes.
;
;                  When the function returns, each member of the array contains status data for a virtual key. If the high-order
;                  bit is 1, the key is down; otherwise, it is up. If the key is a toggle key, for example CAPS LOCK, then the
;                  low-order bit is 1 when the key is toggled and is 0 if the key is untoggled. The low-order bit is meaningless for
;                  non-toggle keys. A toggle key is said to be toggled when it is turned on. A toggle key's indicator light (if any)
;                  on the keyboard will be on when the key is toggled, and off when the key is untoggled.
;
;                  To retrieve status information for an individual key, use the _WinAPI_GetKeyState() function. To retrieve the
;                  current state for an individual key regardless of whether the corresponding keyboard message has been retrieved
;                  from the message queue, use the _WinAPI_GetAsyncKeyState() function.
;
; Related........:
; Link...........: @@MsdnLink@@ GetKeyboardState
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetKeyboardState()

	Local $tData = DllStructCreate('byte[256]')
	Local $Ret = DllCall('user32.dll', 'int', 'GetKeyboardState', 'ptr', DllStructGetPtr($tData))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $tData
EndFunc   ;==>_WinAPI_GetKeyboardState

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetKeyboardType
; Description....: Retrieves information about the current keyboard.
; Syntax.........: _WinAPI_GetKeyboardType ( $iType )
; Parameters.....: $iType   - The type of keyboard information to be retrieved, valid values:
;                  |0 - Keyboard type.
;                  |1 - Keyboard subtype (original equipment manufacturer (OEM)-dependent value).
;                  |2 - The number of function keys on the keyboard.
; Return values..: Success  - The value that specifies the requested information. If $iType is 0, return value may be one of the following values.
;                  |1 - IBM PC/XT or compatible (83-key) keyboard.
;                  |2 - Olivetti "ICO" (102-key) keyboard.
;                  |3 - IBM PC/AT (84-key) or similar keyboard.
;                  |4 - IBM enhanced (101- or 102-key) keyboard.
;                  |5 - Nokia 1050 and similar keyboards.
;                  |6 - Nokia 9140 and similar keyboards.
;                  |7 - Japanese keyboard.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: When a single USB keyboard is connected to the computer, this function returns the code 81.
; Related........:
; Link...........: @@MsdnLink@@ GetKeyboardType
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetKeyboardType($iType)

	Local $Ret = DllCall('user32.dll', 'int', 'GetKeyboardType', 'int', $iType)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_GetKeyboardType

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetKeyNameText
; Description....: Retrieves a string that represents the name of a key.
; Syntax.........: _WinAPI_GetKeyNameText ( $lParam )
; Parameters.....: $lParam - Specifies the second parameter of the keyboard message (such as WM_KEYDOWN) to be processed.
; Return values..: Success - String containing the name of the key.
;                  Failure - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The format of the key-name string depends on the current keyboard layout. The keyboard driver maintains a list
;                  of names in the form of character strings for keys with names longer than a single character. The key name
;                  is translated according to the layout of the currently installed keyboard, thus the function may give different
;                  results for different input locales. The name of a character key is the character itself. The names of dead
;                  keys are spelled out in full.
; Related........:
; Link...........: @@MsdnLink@@ GetKeyNameText
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetKeyNameText($lParam)

	Local $tData = DllStructCreate('wchar[128]')
	Local $Ret = DllCall('user32.dll', 'int', 'GetKeyNameTextW', 'long', $lParam, 'ptr', DllStructGetPtr($tData), 'int', 128)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, '')
	EndIf
	Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_GetKeyNameText

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetKeyState
; Description....: Retrieves the status of the specified virtual key.
; Syntax.........: _WinAPI_GetKeyState ( $vkCode )
; Parameters.....: $vkCode - Specifies a virtual key ($VK_...). If the desired virtual key is a letter or digit (A through Z,
;                            a through z, or 0 through 9).
; Return values..: Success - The value that specifies the status of the specified virtual key. If the high-order bit is 1, the key is
;                            down; otherwise, it is up. If the low-order bit is 1, the key is toggled. A key, such as the
;                            CAPS LOCK key, is toggled if it is turned on. The key is off and untoggled if the low-order bit is 0.
;                            A toggle key's indicator light (if any) on the keyboard will be on when the key is toggled, and off
;                            when the key is untoggled.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The key status returned from this function changes as a process reads key messages from its message queue.
;                  The status does not reflect the interrupt-level state associated with the hardware. Use the _WinAPI_GetAsyncKeyState()
;                  function to retrieve that information.
; Related........:
; Link...........: @@MsdnLink@@ GetKeyState
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetKeyState($vkCode)

	Local $Ret = DllCall('user32.dll', 'int', 'GetKeyState', 'int', $vkCode)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_GetKeyState

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetLayeredWindowAttributes
; Description....: Retrieves the opacity and transparency color key of a layered window.
; Syntax.........: _WinAPI_GetLayeredWindowAttributes ( $hWnd )
; Parameters.....: $hWnd   - Handle to the layered window.
; Return values..: Success - The array containing the following parameters:
;
;                            [0] - The transparency color key to be used when composing the layered window. All pixels painted
;                                  by the window in this color will be transparent. This can be NULL if the argument is not needed.
;                            [1] - The Alpha value used to describe the opacity of the layered window. When the variable is 0,
;                                  the window is completely transparent. When the variable is 255, the window is opaque.
;                                  This can be 0 if the argument is not needed.
;                            [2] - The layering flag ($LWA...).
;
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: ProgAndy
; Modified.......: Yashied
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetLayeredWindowAttributes
; Example........: Yes
; ===============================================================================================================================

#cs

Func _WinAPI_GetLayeredWindowAttributes($hWnd)

	Local $Ret = DllCall('user32.dll', 'int', 'GetLayeredWindowAttributes', 'hwnd', $hWnd, 'long*', 0, 'byte*', 0, 'long*', 0)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $Result[3]

	$Result[0] = __IsRGB($Ret[2])
	$Result[1] = $Ret[3]
	$Result[2] = $Ret[4]

	Return $Result
EndFunc   ;==>_WinAPI_GetLayeredWindowAttributes

#ce

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetLocaleInfo
; Description....: Retrieves information about a locale specified by identifier.
; Syntax.........: _WinAPI_GetLocaleInfo ( $LCID, $iType )
; Parameters.....: $LCID   - Locale identifier for which to retrieve information.
;                  $iType  - The one of the locale information constants ($LOCALE_...) to retrieve.
; Return values..: Success - String containing the requested information.
;                  Failure - Empty string and sets the @error flag to non-zero.
; Author.........: WideBoyDixon
; Modified.......: Yashied
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetLocaleInfo
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetLocaleInfo($LCID, $iType)

	Local $tData = DllStructCreate('wchar[1024]')
	Local $Ret = DllCall('kernel32.dll', 'int', 'GetLocaleInfoW', 'long', $LCID, 'int', $iType, 'ptr', DllStructGetPtr($tData), 'int', 1024)

    If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, '')
	EndIf
    Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_GetLocaleInfo

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetModuleFileNameEx
; Description....: Retrieves the fully-qualified path for the file associated with the process.
; Syntax.........: _WinAPI_GetModuleFileNameEx ( [$PID] )
; Parameters.....: $PID    - The PID of the process. Default (0) is the current process.
; Return values..: Success - The fully-qualified path to the file.
;                  Failure - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetModuleFileNameEx
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetModuleFileNameEx($PID = 0)

	If Not $PID Then
		$PID = _WinAPI_GetCurrentProcessID()
		If Not $PID Then
			Return SetError(1, 0, 0)
		EndIf
	EndIf

	Local $hProcess = DllCall('kernel32.dll', 'ptr', 'OpenProcess', 'dword', 0x00000410, 'int', 0, 'dword', $PID)

	If (@error) Or (Not $hProcess[0]) Then
		Return SetError(1, 0, '')
	EndIf

	Local $tPath = DllStructCreate('wchar[1024]')
	Local $Ret = DllCall('psapi.dll', 'int', 'GetModuleFileNameExW', 'ptr', $hProcess[0], 'ptr', 0, 'ptr', DllStructGetPtr($tPath), 'int', 1024)

	If (@error) Or (Not $Ret[0]) Then
		$Ret = 0
	EndIf
	_WinAPI_FreeHandle($hProcess[0])
	If Not IsArray($Ret) Then
		Return SetError(1, 0, '')
	EndIf
	Return SetError(0, 0, DllStructGetData($tPath, 1))
EndFunc   ;==>_WinAPI_GetModuleFileNameEx

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetObjectEx
; Description....: Retrieves information for the specified graphics object.
; Syntax.........: _WinAPI_GetObjectEx ( $hObject )
; Parameters.....: $hObject - Handle to the graphics object of interest. This can be a handle to one of the following: a logical
;                             bitmap, a brush, a font, a palette, or a pen.
; Return values..: Success  - The structure that depends on the graphics object ($hObject) and @extended flag will contain the value
;                             that identifies the object ($OBJ_...). You do not need to create the desired structure, _WinAPI_GetObjectEx()
;                             function itself will create it. The following table shows the structures that will be returns for
;                             each type of graphics object.
;
;                             $OBJ_BITMAP (HBITMAP)
;                             Returns $tagDIBSECTION structure.
;
;                             $OBJ_BRUSH (HBRUSH)
;                             Returns $tagLOGBRUSH structure.
;
;                             $OBJ_FONT (HFONT)
;                             Returns $tagLOGFONT structure.
;
;                             $OBJ_PAL (HPALETTE)
;                             Returns "ushort" structure that specifies the number of entries in the palette.
;
;                             $OBJ_PEN (HPEN)
;                             Returns $tagLOGPEN (12 bytes) or $tagEXTLOGPEN (24 and more bytes) structure.
;
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetObject
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetObjectEx($hObject)

	Local $Ret, $Size, $Struct, $Type, $Entry, $tData = 0

	$Ret = DllCall('gdi32.dll', 'int', 'GetObject', 'int', $hObject, 'int', 0, 'ptr', 0)
	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	$Size = $Ret[0]
	$Type = _WinAPI_GetObjectType($hObject)
	Switch $Type
		Case $OBJ_BITMAP
			$Struct = $tagDIBSECTION
		Case $OBJ_BRUSH
			$Struct = $tagLOGBRUSH
		Case $OBJ_FONT
			$Struct = $tagLOGFONT
		Case $OBJ_PAL
			$Struct = 'ushort'
		Case $OBJ_PEN
			If $Size > 12 Then ; SizeOf(LOGPEN)
				$tData = DllStructCreate($tagEXTLOGPEN)
				$Entry = BitShift($Size - DllStructGetSize($tData), 2)
				If $Entry Then
					$tData = DllStructCreate($tagEXTLOGPEN & ';dword StyleEntry[' & $Entry & ']')
				EndIf
			Else
				$Struct = $tagLOGPEN
			EndIf
		Case Else
			Return SetError(2, 0, 0)
	EndSwitch
	If Not IsDllStruct($tData) Then
		$tData = DllStructCreate($Struct)
	EndIf
	$Ret = DllCall('gdi32.dll', 'int', 'GetObject', 'int', $hObject, 'int', DllStructGetSize($tData), 'ptr', DllStructGetPtr($tData))
	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return SetError(0, $Type, $tData)
EndFunc   ;==>_WinAPI_GetObjectEx

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetObjectType
; Description....: Retrieves the type of the specified object.
; Syntax.........: _WinAPI_GetObjectType ( $hObject )
; Parameters.....: $hObject - Handle to the graphics object.
; Return values..: Success  - The value identifies the object ($OBJ_...).
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetObjectType
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetObjectType($hObject)

	Local $Ret  = DllCall('gdi32.dll', 'dword', 'GetObjectType', 'ptr', $hObject)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_GetObjectType

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetParentProcess
; Description....: Retrieves the PID of the parent process for the specified process.
; Syntax.........: _WinAPI_GetParentProcess ( [$PID] )
; Parameters.....: $PID    - The PID of the process. Default (0) is the current process.
; Return values..: Success - The PID of the parent process.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetParentProcess($PID = 0)

	If Not $PID Then
		$PID = _WinAPI_GetCurrentProcessID()
		If Not $PID Then
			Return SetError(1, 0, 0)
		EndIf
	EndIf

	Local $hSnapshot = DllCall('kernel32.dll', 'ptr', 'CreateToolhelp32Snapshot', 'dword', 0x00000002, 'dword', 0)

	If (@error) Or (Not $hSnapshot[0]) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $tPROCESSENTRY32 = DllStructCreate('dword Size;dword Usage;dword ProcessID;ulong_ptr DefaultHeapID;dword ModuleID;dword Threads;dword ParentProcessID;long PriClassBase;dword Flags;wchar ExeFile[260]')
	Local $pPROCESSENTRY32 = DllStructGetPtr($tPROCESSENTRY32)
	Local $Ret, $Result = 0

	$hSnapshot = $hSnapshot[0]
	DllStructSetData($tPROCESSENTRY32, 'Size', DllStructGetSize($tPROCESSENTRY32))
	$Ret = DllCall('kernel32.dll', 'int', 'Process32FirstW', 'ptr', $hSnapshot, 'ptr', $pPROCESSENTRY32)
	While (Not @error) And ($Ret[0])
		If DllStructGetData($tPROCESSENTRY32, 'ProcessID') = $PID Then
			$Result = DllStructGetData($tPROCESSENTRY32, 'ParentProcessID')
			ExitLoop
		EndIf
		$Ret = DllCall('kernel32.dll', 'int', 'Process32NextW', 'ptr', $hSnapshot, 'ptr', $pPROCESSENTRY32)
	WEnd
	_WinAPI_FreeHandle($hSnapshot)
	If Not $Result Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Result
EndFunc   ;==>_WinAPI_GetParentProcess

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetPerformanceInfo
; Description....: Retrieves the performance information.
; Syntax.........: _WinAPI_GetPerformanceInfo ( )
; Parameters.....: None
; Return values..: Success - The array containing the following information:
;
;                            [0] - The memory that currently committed by the system, in bytes.
;                            [1] - The current maximum memory that can be committed by the system without extending the paging file(s), in bytes.
;                            [2] - The maximum memory that were simultaneously in the committed state since the last system reboot, in bytes.
;                            [3] - The amount of actual physical memory, in bytes.
;                            [4] - The amount of physical memory currently available, in bytes.
;                            [5] - The amount of system cache memory, in bytes.
;                            [6] - The sum of the memory currently in the paged and nonpaged kernel pools, in bytes.
;                            [7] - The memory currently in the paged kernel pool, in bytes.
;                            [8] - The memory currently in the nonpaged kernel pool, in bytes.
;                            [9] - The size of a page, in bytes.
;                           [10] - The current number of open handles.
;                           [11] - The current number of processes.
;                           [12] - The current number of threads.
;
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetPerformanceInfo
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetPerformanceInfo()

	Local $tPI = DllStructCreate('dword;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr;dword;dword;dword')
	Local $Ret = DllCall(@SystemDir & '\psapi.dll', 'int', 'GetPerformanceInfo', 'ptr', DllStructGetPtr($tPI), 'dword', DllStructGetSize($tPI))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $Result[13]

	For $i = 0 To 12
		$Result[$i] = DllStructGetData($tPI, $i + 2)
	Next
	For $i = 0 To 8
		$Result[$i] *= $Result[9]
	Next
	Return $Result
EndFunc   ;==>_WinAPI_GetPerformanceInfo

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetPixel
; Description....: Retrieves the color value of the pixel at the specified coordinates.
; Syntax.........: _WinAPI_GetPixel ( $hDC, $iX, $iY )
; Parameters.....: $hDC    - Handle to the device context.
;                  $iX     - The x-coordinate, in logical units, of the pixel to be examined.
;                  $iY     - The y-coordinate, in logical units, of the pixel to be examined.
; Return values..: Success - The color of the pixel, in RGB.
;                  Failure - (-1) and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetPixel
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetPixel($hDC, $iX, $iY)

	Local $Ret = DllCall('gdi32.dll', 'dword', 'GetPixel', 'hwnd', $hDC, 'int', $iX, 'int', $iY)

	If (@error) Or ($Ret[0] = -1) Then
		Return SetError(1, 0, -1)
	EndIf
	Return __IsRGB($Ret[0])
EndFunc   ;==>_WinAPI_GetPixel

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetPosFromRect
; Description....: Interprets the coordinates of the rectangle as offset and position coordinates.
; Syntax.........: _WinAPI_GetPosFromRect ( $tRECT )
; Parameters.....: $tRECT  - $tagRECT structure that contains the logical coordinates of the rectangle.
; Return values..: Success - The array containing the following parameters:
;
;                            [0] - The x-coordinate of the upper-left corner of the rectangle.
;                            [1] - The y-coordinate of the upper-left corner of the rectangle.
;                            [2] - The width of the rectangle.
;                            [3] - The height of the rectangle.
;
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function is inverse to the _WinAPI_CreateRectEx().
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetPosFromRect($tRECT)

	Local $Result[4]

	For $i = 0 To 3
		$Result[$i] = DllStructGetData($tRECT, $i + 1)
		If @error Then
			Return SetError(1, 0, 0)
		EndIf
	Next
	For $i = 2 To 3
		$Result[$i] -= $Result[$i - 2]
	Next
	Return $Result
EndFunc   ;==>_WinAPI_GetPosFromRect

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetProcAddress
; Description....: Retrieves the address of a function from the specified dynamic-link library (DLL).
; Syntax.........: _WinAPI_GetProcAddress ( $hModule, $sProc )
; Parameters.....: $hModule - Handle to the DLL module that contains the function.
;                  $sProc   - The function name.
; Return values..: Success  - The address of the function.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetProcAddress
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetProcAddress($hModule, $sProc)

	Local $Ret = DllCall('kernel32.dll', 'ptr', 'GetProcAddress', 'ptr', $hModule, 'str', $sProc)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_GetProcAddress

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetProcessCreationTime
; Description....: Retrieves the creation time of the process.
; Syntax.........: _WinAPI_GetProcessCreationTime ( [$PID] )
; Parameters.....: $PID    - The PID of the process. Default (0) is the current process.
; Return values..: Success - $tagFILETIME structure that contains the creation time of the process.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetProcessTimes
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetProcessCreationTime($PID = 0)

	If Not $PID Then
		$PID = _WinAPI_GetCurrentProcessID()
		If Not $PID Then
			Return SetError(1, 0, 0)
		EndIf
	EndIf

	Local $hProcess = DllCall('kernel32.dll', 'ptr', 'OpenProcess', 'dword', 0x00000400, 'int', 0, 'dword', $PID)

	If (@error) Or (Not $hProcess[0]) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $tFILETIME = DllStructCreate('dword;dword')
	Local $Ret = DllCall('kernel32.dll', 'int', 'GetProcessTimes', 'ptr', $hProcess[0], 'ptr', DllStructGetPtr($tFILETIME), 'ptr*', 0, 'ptr*', 0, 'ptr*', 0)

	If (@error) Or (Not $Ret[0]) Then
		$Ret = 0
	EndIf
	_WinAPI_FreeHandle($hProcess[0])
	If Not IsArray($Ret) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $tFILETIME
EndFunc   ;==>_WinAPI_GetProcessCreationTime

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetProcessIoCounters
; Description....: Retrieves accounting information for all I/O operations performed by the specified process.
; Syntax.........: _WinAPI_GetProcessIoCounters ( [$PID] )
; Parameters.....: $PID    - The PID of the process. Default (0) is the current process.
; Return values..: Success - $tagIO_COUNTERS structure that contains the I/O accounting information for the process.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetProcessIoCounters
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetProcessIoCounters($PID = 0)

	If Not $PID Then
		$PID = _WinAPI_GetCurrentProcessID()
		If Not $PID Then
			Return SetError(1, 0, 0)
		EndIf
	EndIf

	Local $hProcess = DllCall('kernel32.dll', 'ptr', 'OpenProcess', 'dword', 0x00000400, 'int', 0, 'dword', $PID)

	If (@error) Or (Not $hProcess[0]) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $tIO_COUNTERS = DllStructCreate($tagIO_COUNTERS)
	Local $Ret = DllCall('kernel32.dll', 'int', 'GetProcessIoCounters', 'ptr', $hProcess[0], 'ptr', DllStructGetPtr($tIO_COUNTERS))

	If (@error) Or (Not $Ret[0]) Then
		$Ret = 0
	EndIf
	_WinAPI_FreeHandle($hProcess[0])
	If Not IsArray($Ret) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $tIO_COUNTERS
EndFunc   ;==>_WinAPI_GetProcessIoCounters

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetProcessMemoryInfo
; Description....: Retrieves information about the memory usage of the specified process.
; Syntax.........: _WinAPI_GetProcessMemoryInfo ( [$PID] )
; Parameters.....: $PID    - The PID of the process. Default (0) is the current process.
; Return values..: Success - $tagPROCESS_MEMORY_COUNTERS structure that contains the information about the memory usage.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetProcessMemoryInfo
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetProcessMemoryInfo($PID = 0)

	If Not $PID Then
		$PID = _WinAPI_GetCurrentProcessID()
		If Not $PID Then
			Return SetError(1, 0, 0)
		EndIf
	EndIf

	Local $hProcess = DllCall('kernel32.dll', 'ptr', 'OpenProcess', 'dword', 0x00000410, 'int', 0, 'dword', $PID)

	If (@error) Or (Not $hProcess[0]) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $tPROCESS_MEMORY_COUNTERS = DllStructCreate($tagPROCESS_MEMORY_COUNTERS)
	Local $Ret = DllCall('psapi.dll', 'int', 'GetProcessMemoryInfo', 'ptr', $hProcess[0], 'ptr', DllStructGetPtr($tPROCESS_MEMORY_COUNTERS), 'int', DllStructGetSize($tPROCESS_MEMORY_COUNTERS))

	If (@error) Or (Not $Ret[0]) Then
		$Ret = 0
	EndIf
	_WinAPI_FreeHandle($hProcess[0])
	If Not IsArray($Ret) Then
		Return SetError(1, 0, 0)
	EndIf
	Return SetError(0, 0, $tPROCESS_MEMORY_COUNTERS)
EndFunc   ;==>_WinAPI_GetProcessMemoryInfo

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetProcessName
; Description....: Retrieves the name for the specified process.
; Syntax.........: _WinAPI_GetProcessName ( [$PID] )
; Parameters.....: $PID    - The PID of the process. Default (0) is the current process.
; Return values..: Success - The process name.
;                  Failure - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetProcessName($PID = 0)

	If Not $PID Then
		$PID = _WinAPI_GetCurrentProcessID()
		If Not $PID Then
			Return SetError(1, 0, '')
		EndIf
	EndIf

	Local $hSnapshot = DllCall('kernel32.dll', 'ptr', 'CreateToolhelp32Snapshot', 'dword', 0x00000002, 'dword', 0)

	If (@error) Or (Not $hSnapshot[0]) Then
		Return SetError(1, 0, '')
	EndIf

	Local $tPROCESSENTRY32 = DllStructCreate('dword Size;dword Usage;dword ProcessID;ulong_ptr DefaultHeapID;dword ModuleID;dword Threads;dword ParentProcessID;long PriClassBase;dword Flags;wchar ExeFile[260]')
	Local $pPROCESSENTRY32 = DllStructGetPtr($tPROCESSENTRY32)
	Local $Ret, $Error = 1

	$hSnapshot = $hSnapshot[0]
	DllStructSetData($tPROCESSENTRY32, 'Size', DllStructGetSize($tPROCESSENTRY32))
	$Ret = DllCall('kernel32.dll', 'int', 'Process32FirstW', 'ptr', $hSnapshot, 'ptr', $pPROCESSENTRY32)
	While (Not @error) And ($Ret[0])
		If DllStructGetData($tPROCESSENTRY32, 'ProcessID') = $PID Then
			$Error = 0
			ExitLoop
		EndIf
		$Ret = DllCall('kernel32.dll', 'int', 'Process32NextW', 'ptr', $hSnapshot, 'ptr', $pPROCESSENTRY32)
	WEnd
	_WinAPI_FreeHandle($hSnapshot)
	If $Error Then
		Return SetError(1, 0, '')
	EndIf
	Return DllStructGetData($tPROCESSENTRY32, 'ExeFile')
EndFunc   ;==>_WinAPI_GetProcessName

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetProfilesDirectory
; Description....: Retrieves the path to the root directory where all user profiles are stored.
; Syntax.........: _WinAPI_GetProfilesDirectory ( )
; Parameters.....: None
; Return values..: Success - The path to the profiles directory.
;                  Failure - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetProfilesDirectory
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetProfilesDirectory()

	Local $tData = DllStructCreate('wchar[1024]')
	Local $Ret = DllCall('userenv.dll', 'int', 'GetProfilesDirectoryW', 'ptr', DllStructGetPtr($tData), 'dword*', 1024)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, '')
	EndIf
	Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_GetProfilesDirectory

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetRgnBox
; Description....: Retrieves the bounding rectangle of the specified region.
; Syntax.........: _WinAPI_GetRgnBox ( $hRgn, ByRef $tRECT )
; Parameters.....: $hRgn   - Handle to the region.
;                  $tRECT  - $tagRECT structure that receives the bounding rectangle in logical units.
; Return values..: Success - The value that specifies the region's complexity. It can be one of the following values.
;
;                            $COMPLEXREGION
;                            $NULLREGION
;                            $SIMPLEREGION
;
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetRgnBox
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetRgnBox($hRgn, ByRef $tRECT)

	Local $Ret = DllCall('gdi32.dll', 'int', 'GetRgnBox', 'ptr', $hRgn, 'ptr', DllStructGetPtr($tRECT))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_GetRgnBox

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetROP2
; Description....: Retrieves the foreground mix mode of the specified device context.
; Syntax.........: _WinAPI_GetROP2 ( $hDC )
; Parameters.....: $hDC    - Handle to the device context.
; Return values..: Success - The value that specifies the foreground mix mode ($R2_...).
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetROP2
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetROP2($hDC)

	Local $Ret = DllCall('gdi32.dll', 'int', 'GetROP2', 'hwnd', $hDC)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_GetROP2

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetRValue
; Description....: Retrieves an intensity value for the red component of a 32-bit RGB value.
; Syntax.........: _WinAPI_GetRValue ( $iRGB )
; Parameters.....: $iRGB - The color value, in RGB.
; Return values..: The intensity of the red component of the specified RGB color.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetRValue($iRGB)
	Return BitAND(__IsRGB($iRGB), 0x0000FF)
EndFunc   ;==>_WinAPI_GetRValue

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetSystemDefaultLCID
; Description....: Returns the locale identifier (LCID) for the system locale.
; Syntax.........: _WinAPI_GetSystemDefaultLCID ( )
; Parameters.....: None
; Return values..: Success - The default LCID for the system.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: WideBoyDixon
; Modified.......: Yashied
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetSystemDefaultLCID
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetSystemDefaultLCID()

    Local $Ret = DllCall('kernel32.dll', 'long', 'GetSystemDefaultLCID')

    If @error Then
		Return SetError(1, 0, 0)
	EndIf
    Return $Ret[0]
EndFunc   ;==>_WinAPI_GetSystemDefaultLCID

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetSystemInfo
; Description....: Retrieves information about the current system.
; Syntax.........: _WinAPI_GetSystemInfo ( )
; Parameters.....: None
; Return values..: Success - The array containing the following information:
;
;                  [0] - The processor architecture of the installed operating system ($PROCESSOR_ARCHITECTURE_...).
;                  [1] - The page size and the granularity of page protection and commitment.
;                  [2] - A pointer to the lowest memory address accessible to applications and dynamic-link libraries (DLLs).
;                  [3] - A pointer to the highest memory address accessible to applications and DLLs.
;                  [4] - A mask representing the set of processors configured into the system. Bit 0 is processor 0; bit 31 is processor 31.
;                  [5] - The number of physical processors in the system.
;                  [6] - An obsolete member that is retained for compatibility ($PROCESSOR_...).
;                  [7] - The granularity for the starting address at which virtual memory can be allocated.
;                  [8] - The architecture-dependent processor level.
;                  [9] - The architecture-dependent processor revision (0x0000xxyy; xx - model; yy - stepping).
;
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetSystemInfo
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetSystemInfo()

	Local $Proc

	If _WinAPI_IsWow64Process() Then
		$Proc = 'GetNativeSystemInfo'
	Else
		$Proc = 'GetSystemInfo'
	EndIf

	Local $tagSYSTEMINFO = DllStructCreate('ushort;ushort;dword;ptr;ptr;dword_ptr;dword;dword;dword;ushort;ushort')
	Local $Ret = DllCall('kernel32.dll', 'none', $Proc, 'ptr', DllStructGetPtr($tagSYSTEMINFO))

	If @error Then
		Return SetError(1, 0, 0)
	EndIf

	Local $Result[10]

	$Result[0] = DllStructGetData($tagSYSTEMINFO, 1)
	For $i = 1 To 9
		$Result[$i] = DllStructGetData($tagSYSTEMINFO, $i + 2)
	Next
	Return $Result
EndFunc   ;==>_WinAPI_GetSystemInfo

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetSystemPowerStatus
; Description....: Retrieves the power status of the system.
; Syntax.........: _WinAPI_GetSystemPowerStatus ( )
; Parameters.....: None
; Return values..: Success - The array containing the following parameters:
;
;                            [0] - The AC power status. This member can be one of the following values.
;                                    0 - Offline
;                                    1 - Online
;                                  255 - Unknown status
;                            [1] - The battery charge status. This member can contain one or more of the following flags.
;                                    0 - The battery is not being charged and the battery capacity is between low and high.
;                                    1 - High - the battery capacity is at more than 66 percent
;                                    2 - Low - the battery capacity is at less than 33 percent
;                                    4 - Critical - the battery capacity is at less than five percent
;                                    8 - Charging
;                                  128 - No system battery
;                                  255 - Unknown status - unable to read the battery flag information
;                            [2] - The percentage of full battery charge remaining. This member can be a value in the range 0 to 100,
;                                  or 255 if status is unknown.
;                            [3] - The number of seconds of battery life remaining, or (–1) if remaining seconds are unknown.
;                            [4] - The number of seconds of battery life when at full charge, or (–1) if full battery
;                                  lifetime is unknown.
;
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetSystemPowerStatus
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetSystemPowerStatus()

	Local $tSYSTEM_POWER_STATUS = DllStructCreate('byte;byte;byte;byte;dword;dword')
	Local $Ret = DllCall('kernel32.dll', 'int', 'GetSystemPowerStatus', 'ptr', DllStructGetPtr($tSYSTEM_POWER_STATUS))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $Result[5]

	$Result[0] = DllStructGetData($tSYSTEM_POWER_STATUS, 1)
	$Result[1] = DllStructGetData($tSYSTEM_POWER_STATUS, 2)
	$Result[2] = DllStructGetData($tSYSTEM_POWER_STATUS, 3)
	$Result[3] = DllStructGetData($tSYSTEM_POWER_STATUS, 5)
	$Result[4] = DllStructGetData($tSYSTEM_POWER_STATUS, 6)

	For $i = 3 To 4
		If _WinAPI_DWordToInt($Result[$i]) = -1 Then
			$Result[$i] = -1
		EndIf
	Next

	Return $Result
EndFunc   ;==>_WinAPI_GetSystemPowerStatus

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetSystemWow64Directory
; Description....: Retrieves the path of the system directory used by WOW64.
; Syntax.........: _WinAPI_GetSystemWow64Directory ( )
; Parameters.....: None
; Return values..: Success - The path of the system directory. This path does not end with a backslash.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This directory is not present on 32-bit Windows.
; Related........:
; Link...........: @@MsdnLink@@ GetSystemWow64Directory
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetSystemWow64Directory()

	Local $tData = DllStructCreate('wchar[1024]')
	Local $Ret = DllCall('kernel32.dll', 'uint', 'GetSystemWow64DirectoryW', 'ptr', DllStructGetPtr($tData), 'uint', 1024)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_GetSystemWow64Directory

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetTempFileName
; Description....: Creates a name for a temporary file.
; Syntax.........: _WinAPI_GetTempFileName ( $sPath [, $sPrefix] )
; Parameters.....: $sPath   - The directory path for the file name. Applications typically specify a period (.) for the current directory.
;                  $sPrefix - The prefix string. The function uses up to the first three characters of this string as the prefix of the
;                             file name.
; Return values..: Success  - The temporary file name.
;                  Failure  - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: Temporary files whose names have been created by this function are not automatically deleted.
; Related........:
; Link...........: @@MsdnLink@@ GetTempFileName
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetTempFileName($sPath, $sPrefix = '')

	Local $tData = DllStructCreate('wchar[1024]')
	Local $Ret = DllCall('kernel32.dll', 'uint', 'GetTempFileNameW', 'wstr', $sPath, 'wstr', $sPrefix, 'uint', 0, 'ptr', DllStructGetPtr($tData))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, '')
	EndIf
	Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_GetTempFileName

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetTextColor
; Description....: Retrieves the current text color for the specified device context.
; Syntax.........: _WinAPI_GetTextColor ( $hDC )
; Parameters.....: $hDC    - Handle to the device context.
; Return values..: Success - The value of the current text color, in RGB.
;                  Failure - (-1) and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetTextColor
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetTextColor($hDC)

	Local $Ret = DllCall('gdi32.dll', 'int', 'GetTextColor', 'hwnd', $hDC)

	If (@error) Or ($Ret[0] = -1) Then
		Return SetError(1, 0, -1)
	EndIf
	Return __IsRGB($Ret[0])
EndFunc   ;==>_WinAPI_GetTextColor

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetTextFace
; Description....: Retrieves the typeface name of the font that is selected into the specified device context.
; Syntax.........: _WinAPI_GetTextFace ( $hDC )
; Parameters.....: $hDC    - Handle to the device context.
; Return values..: Success - The typeface name.
;                  Failure - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetTextFace
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetTextFace($hDC)

	Local $tData = DllStructCreate('wchar[1024]')
	Local $Ret = DllCall('gdi32.dll', 'int', 'GetTextFaceW', 'hwnd', $hDC, 'int', 1024, 'ptr', DllStructGetPtr($tData))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, '')
	EndIf
	Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_GetTextFace

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetTextMetrics
; Description....: Retrieves basic information for the currently selected font.
; Syntax.........: _WinAPI_GetTextMetrics ( $hDC )
; Parameters.....: $hDC    - Handle to the device context.
; Return values..: Success - $tagTEXTMETRIC structure that contains the information about the currently selected font.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetTextMetrics
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetTextMetrics($hDC)

;	Local $tTEXTMETRIC = DllStructCreate($tagTEXTMETRIC)
	Local $tTEXTMETRIC = DllStructCreate('long tmHeight;long tmAscent;long tmDescent;long tmInternalLeading;long tmExternalLeading;long tmAveCharWidth;long tmMaxCharWidth;long tmWeight;long tmOverhang;long tmDigitizedAspectX;long tmDigitizedAspectY;wchar tmFirstChar;wchar tmLastChar;wchar tmDefaultChar;wchar tmBreakChar;byte tmItalic;byte tmUnderlined;byte tmStruckOut;byte tmPitchAndFamily;byte tmCharSet')
	Local $Ret = DllCall('gdi32.dll', 'int', 'GetTextMetrics', 'hwnd', $hDC, 'ptr', DllStructGetPtr($tTEXTMETRIC))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $tTEXTMETRIC
EndFunc   ;==>_WinAPI_GetTextMetrics

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetThemeAppProperties
; Description....: Retrieves the property flags that control how visual styles are applied in the current application.
; Syntax.........: _WinAPI_GetThemeAppProperties ( )
; Parameters.....: None
; Return values..: Success - The property bit flags ($STAP_ALLOW_...) combined with a logical OR operator.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: Individual flags can be extracted from the result by combining the result with the logical
;                  AND of the desired flag.
; Related........:
; Link...........: @@MsdnLink@@ GetThemeAppProperties
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetThemeAppProperties()

	Local $Ret = DllCall('uxtheme.dll', 'int', 'GetThemeAppProperties')

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_GetThemeAppProperties

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetThemeColor
; Description....: Retrieves the value of a color property for the specified window.
; Syntax.........: _WinAPI_GetThemeColor ( $hTheme, $iPartId, $iStateId, $iPropId )
; Parameters.....: $hTheme   - Handle to a window's specified theme data.
;                  $iPartId  - The part that contains the color property.
;                  $iStateId - The state of the part.
;                  $iPropId  - The property to retrieve.
; Return values..: Success   - The received color, in RGB.
;                  Failure   - (-1) and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetThemeColor
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetThemeColor($hTheme, $iPartId, $iStateId, $iPropId)

	Local $Ret = DllCall('uxtheme.dll', 'uint', 'GetThemeColor', 'ptr', $hTheme, 'int', $iPartId, 'int', $iStateId, 'int', $iPropId, 'dword*', 0)

	If @error Then
		Return SetError(1, 0, -1)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], -1)
		EndIf
	EndIf
	Return __IsRGB($Ret[5])
EndFunc   ;==>_WinAPI_GetThemeColor

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetThemeDocumentationProperty
; Description....: Retrieves the value for a theme property from the documentation section of the specified theme file.
; Syntax.........: _WinAPI_GetThemeDocumentationProperty ( $sFile, $sProperty )
; Parameters.....: $sFile     - The name of the theme file that will be opened to query for the property.
;                  $sProperty - The name of the theme property to query. This parameter can be one of the following values.
;
;                               $SZ_THDOCPROP_AUTHOR
;                               $SZ_THDOCPROP_CANONICALNAME
;                               $SZ_THDOCPROP_DISPLAYNAME
;                               $SZ_THDOCPROP_TOOLTIP
;
; Return values..: Success    - The property string value.
;                  Failure    - Empty string and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetThemeDocumentationProperty
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetThemeDocumentationProperty($sFile, $sProperty)

	Local $tData = DllStructCreate('wchar[1024]')
	Local $Ret = DllCall('uxtheme.dll', 'uint', 'GetThemeDocumentationProperty', 'wstr', $sFile, 'wstr', $sProperty, 'ptr', DllStructGetPtr($tData), 'int', 1024)

	If @error Then
		Return SetError(1, 0, '')
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], '')
		EndIf
	EndIf
	Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_GetThemeDocumentationProperty

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetThemeFont
; Description....: Retrieves the value of a font property.
; Syntax.........: _WinAPI_GetThemeFont ( $hTheme, $iPartId, $iStateId, $iPropId )
; Parameters.....: $hTheme   - Handle to a window's specified theme data.
;                  $iPartId  - The part that contains the font property.
;                  $iStateId - The state of the part.
;                  $iPropId  - The property to retrieve.
; Return values..: Success   - $tagLOGFONT structure that contains a font property value.
;                  Failure   - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetThemeFont
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetThemeFont($hTheme, $iPartId, $iStateId, $iPropId)

	Local $tLOGFONT = DllStructCreate($tagLOGFONT)
	Local $Ret = DllCall('uxtheme.dll', 'uint', 'GetThemeFont', 'ptr', $hTheme, 'hwnd', 0, 'int', $iPartId, 'int', $iStateId, 'int', $iPropId, 'ptr', DllStructGetPtr($tLOGFONT))

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return $tLOGFONT
EndFunc   ;==>_WinAPI_GetThemeFont

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetThemeInt
; Description....: Retrieves the value of an int property.
; Syntax.........: _WinAPI_GetThemeInt ( $hTheme, $iPartId, $iStateId, $iPropId )
; Parameters.....: $hTheme   - Handle to a window's specified theme data.
;                  $iPartId  - The part that contains the int property.
;                  $iStateId - The state of the part.
;                  $iPropId  - The property to retrieve.
; Return values..: Success   - The retrieved value.
;                  Failure   - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetThemeInt
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetThemeInt($hTheme, $iPartId, $iStateId, $iPropId)

	Local $Ret = DllCall('uxtheme.dll', 'uint', 'GetThemeInt', 'ptr', $hTheme, 'int', $iPartId, 'int', $iStateId, 'int', $iPropId, 'int*', 0)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return $Ret[5]
EndFunc   ;==>_WinAPI_GetThemeInt

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetThemeMargins
; Description....: Retrieves the value of a MARGINS property.
; Syntax.........: _WinAPI_GetThemeMargins ( $hTheme, $iPartId, $iStateId, $iPropId, $hDC, $tRECT)
; Parameters.....: $hTheme   - Handle to a window's specified theme data.
;                  $iPartId  - The part that contains the MARGINS property.
;                  $iStateId - The state of the part.
;                  $iPropId  - The property to retrieve.
;                  $hDC      - Handle to a device context to select fonts into.
;                  $tRECT    - $tagRECT structure that contains the rectangle that specifies the area to be drawn into.
; Return values..: Success   - $tagMARGINS structure that contains a margins value.
;                  Failure   - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetThemeMargins
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetThemeMargins($hTheme, $iPartId, $iStateId, $iPropId, $hDC, $tRECT)

	Local $tMARGINS = DllStructCreate($tagMARGINS)
	Local $Ret = DllCall('uxtheme.dll', 'uint', 'GetThemeMargins', 'ptr', $hTheme, 'hwnd', $hDC, 'int', $iPartId, 'int', $iStateId, 'int', $iPropId, 'ptr', DllStructGetPtr($tRECT), 'ptr', DllStructGetPtr($tMARGINS))

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return $tMARGINS
EndFunc   ;==>_WinAPI_GetThemeMargins

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetThemePartSize
; Description....: Calculates the original size of the part defined by a visual style.
; Syntax.........: _WinAPI_GetThemePartSize ( $hTheme, $iPartId, $iStateId, $hDC, $tRECT, $iType )
; Parameters.....: $hTheme   - Handle to a window's specified theme data.
;                  $iPartId  - The part part to calculate the size of.
;                  $iStateId - The state of the part.
;                  $hDC      - Handle to a device context to select fonts into.
;                  $tRECT    - $tagRECT structure that contains the rectangle used for the part drawing destination.
;                  $iType    - The type of size to retrieve. This parameter can be one of the following values.
;
;                              $TS_MIN
;                              $TS_TRUE
;                              $TS_DRAW
;
; Return values..: Success   - $tagSIZE structure that contains a dimensions of the specified part.
;                  Failure   - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetThemePartSize
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetThemePartSize($hTheme, $iPartId, $iStateId, $hDC, $tRECT, $iType)

	Local $tSIZE = DllStructCreate($tagSIZE)
	Local $Ret = DllCall('uxtheme.dll', 'uint', 'GetThemePartSize', 'ptr', $hTheme, 'hwnd', $hDC, 'int', $iPartId, 'int', $iStateId, 'ptr', DllStructGetPtr($tRECT), 'int', $iType, 'ptr', DllStructGetPtr($tSIZE))

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return $tSIZE
EndFunc   ;==>_WinAPI_GetThemePartSize

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetThemePosition
; Description....: Retrieves the value of a position property.
; Syntax.........: _WinAPI_GetThemePosition ( $hTheme, $iPartId, $iStateId, $iPropId )
; Parameters.....: $hTheme   - Handle to a window's specified theme data.
;                  $iPartId  - The part that contains the position property.
;                  $iStateId - The state of the part.
;                  $iPropId  - The property to retrieve.
; Return values..: Success   - $tagPOINT structure that contains a position value.
;                  Failure   - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetThemePosition
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetThemePosition($hTheme, $iPartId, $iStateId, $iPropId)

	Local $tPOINT = DllStructCreate($tagPOINT)
	Local $Ret = DllCall('uxtheme.dll', 'uint', 'GetThemePosition', 'ptr', $hTheme, 'int', $iPartId, 'int', $iStateId, 'int', $iPropId, 'ptr', DllStructGetPtr($tPOINT))

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return $tPOINT
EndFunc   ;==>_WinAPI_GetThemePosition

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetThemeRect
; Description....: Retrieves the value of a RECT property.
; Syntax.........: _WinAPI_GetThemeRect ( $hTheme, $iPartId, $iStateId, $iPropId )
; Parameters.....: $hTheme   - Handle to a window's specified theme data.
;                  $iPartId  - The part containing the RECT property.
;                  $iStateId - The state of the part.
;                  $iPropId  - The property to retrieve.
; Return values..: Success   - $tagRECT structure that contains a rectangle.
;                  Failure   - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetThemeRect
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetThemeRect($hTheme, $iPartId, $iStateId, $iPropId)

	Local $tRECT = DllStructCreate($tagRECT)
	Local $Ret = DllCall('uxtheme.dll', 'uint', 'GetThemeRect', 'ptr', $hTheme, 'int', $iPartId, 'int', $iStateId, 'int', $iPropId, 'ptr', DllStructGetPtr($tRECT))

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return $tRECT
EndFunc   ;==>_WinAPI_GetThemeRect

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetTickCount
; Description....: Retrieves the number of milliseconds that have elapsed since the system was started.
; Syntax.........: _WinAPI_GetTickCount ( )
; Parameters.....: None
; Return values..: Success - The number of milliseconds that have elapsed since the system was started.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The time will wrap around to zero if the system is run continuously for 49.7 days. You should check for an
;                  overflow condition when comparing times. To obtain the time elapsed since the computer was started, retrieve the
;                  System Up Time counter in the performance data in the registry key HKEY_PERFORMANCE_DATA.
; Related........:
; Link...........: @@MsdnLink@@ GetTickCount
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetTickCount()

	Local $Ret = DllCall('kernel32.dll', 'dword', 'GetTickCount')

    If @error Then
		Return SetError(1, 0, 0)
	EndIf
    Return $Ret[0]
EndFunc   ;==>_WinAPI_GetTickCount

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetTickCount64
; Description....: Retrieves the number of milliseconds that have elapsed since the system was started.
; Syntax.........: _WinAPI_GetTickCount64 ( )
; Parameters.....: None
; Return values..: Success - The number of milliseconds that have elapsed since the system was started.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function requires Windows Vista or above.
; Related........:
; Link...........: @@MsdnLink@@ GetTickCount64
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetTickCount64()

	Local $Ret = DllCall('kernel32.dll', 'uint64', 'GetTickCount64')

    If @error Then
		Return SetError(1, 0, 0)
	EndIf
    Return $Ret[0]
EndFunc   ;==>_WinAPI_GetTickCount64

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetTimeFormat
; Description....: Formats time as a time string for a locale specified by identifier.
; Syntax.........: _WinAPI_GetTimeFormat ( [$LCID [, $tSYSTEMTIME [, $iFlag [, $sFormat]]]] )
; Parameters.....: $LCID        - Locale identifier (LCID constant) that specifies the locale. If this parameter is 0, the function
;                                 will use default locale for the user.
;                  $tSYSTEMTIME - $tagSYSTEMTIME structure that contains the time information to format. If this parameter is 0,
;                                 the function will use the current local system time.
;                  $iFlag       - Flags specifying time format options. This parameter can be one or more of the following values.
;
;                                 $TIME_FORCE24HOURFORMAT
;                                 $TIME_NOMINUTESORSECONDS
;                                 $TIME_NOSECONDS
;                                 $TIME_NOTIMEMARKER
;
;                  $sFormat     - The string that is used to form the time. For example, "hh:mm:ss tt". If this parameter is 0,
;                                 the function returns the string according to the time format for the specified locale ($LCID).
; Return values..: Success      - The formatted time string.
;                  Failure      - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetTimeFormat
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetTimeFormat($LCID = 0, $tSYSTEMTIME = 0, $iFlags = 0, $sFormat = '')

	Local $TypeOfFormat = 'wstr'

	If Not $LCID Then
		$LCID = 0x0400
	EndIf
	If Not StringStripWS($sFormat, 3) Then
		$TypeOfFormat = 'ptr'
		$sFormat = 0
	EndIf

	Local $tData = DllStructCreate('wchar[1024]')
	Local $Ret = DllCall('kernel32.dll', 'int', 'GetTimeFormatW', 'long', $LCID, 'dword', $iFlags, 'ptr', DllStructGetPtr($tSYSTEMTIME), $TypeOfFormat, $sFormat, 'ptr', DllStructGetPtr($tData), 'int', 1024)

    If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, '')
	EndIf
    Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_GetTimeFormat

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetTopWindow
; Description....: Retrieves a handle to the child window at the top of the Z order.
; Syntax.........: _WinAPI_GetTopWindow ( $hWnd )
; Parameters.....: $hWnd   - Handle to the parent window whose child windows are to be examined. If this parameter is 0, the function
;                            returns a handle to the window at the top of the Z order.
; Return values..: Success - Handle to the child window at the top of the Z order. If the specified window has no child windows,
;                            the return value is 0.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetTopWindow
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetTopWindow($hWnd)

	Local $Ret = DllCall('user32.dll', 'hwnd', 'GetTopWindow', 'hwnd', $hWnd)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_GetTopWindow

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetUpdateRect
; Description....: Retrieves the coordinates of the rectangle that completely encloses the update region of the specified window.
; Syntax.........: _WinAPI_GetUpdateRect ( $hWnd [, $fErase] )
; Parameters.....: $hWnd   - Handle to the window whose update region is to be retrieved.
;                  $fErase - Specifies whether the background in the update region is to be erased, valid values:
;                  |TRUE   - The background is erased. (Default)
;                  |FALSE  - The background remains unchanged.
; Return values..: Success - $tagRECT structure that contains the coordinates of the enclosing rectangle, in device units.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The update rectangle retrieved by the _WinAPI_BeginPaint() function is identical to that retrieved by
;                  _WinAPI_GetUpdateRect()
;
;                  _WinAPI_BeginPaint() automatically validates the update region, so any call to _WinAPI_GetUpdateRect() made
;                   immediately after the call to _WinAPI_BeginPaint() retrieves an empty update region.
; Related........:
; Link...........: @@MsdnLink@@ GetUpdateRect
; Example........: YesNULLREGION
; ===============================================================================================================================

Func _WinAPI_GetUpdateRect($hWnd, $fErase = 1)

	Local $tRECT = DllStructCreate($tagRECT)
	Local $Ret = DllCall('user32.dll', 'int', 'GetUpdateRect', 'hwnd', $hWnd, 'ptr', DllStructGetPtr($tRECT), 'int', $fErase)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $tRECT
EndFunc   ;==>_WinAPI_GetUpdateRect

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetUpdateRgn
; Description....: Retrieves the update region of a window by copying it into the specified region.
; Syntax.........: _WinAPI_GetUpdateRgn ( $hWnd, $hRgn [, $fErase] )
; Parameters.....: $hWnd   - Handle to the window with an update region that is to be retrieved.
;                  $hRgn   - Handle to the region to receive the update region.
;                  $fErase - Specifies whether the background in the update region is to be erased, valid values:
;                  |TRUE   - The background is erased. (Default)
;                  |FALSE  - The background remains unchanged.
; Return values..: Success - The value that indicates the complexity of the resulting region; it can be one of the following values.
;
;                            $COMPLEXREGION
;                            $NULLREGION
;                            $SIMPLEREGION
;
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: _WinAPI_BeginPaint() automatically validates the update region, so any call to _WinAPI_GetUpdateRgn() made
;                  immediately after the call to _WinAPI_BeginPaint() retrieves an empty update region.
; Related........:
; Link...........: @@MsdnLink@@ GetUpdateRgn
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetUpdateRgn($hWnd, $hRgn, $fErase = 1)

	Local $Ret = DllCall('user32.dll', 'int', 'GetUpdateRgn', 'hwnd', $hWnd, 'ptr', $hRgn, 'int', $fErase)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_GetUpdateRgn

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetUserDefaultLCID
; Description....: Returns the locale identifier (LCID) for the user default locale.
; Syntax.........: _WinAPI_GetUserDefaultLCID ( )
; Parameters.....: None
; Return values..: Success - The default LCID for the user.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: WideBoyDixon
; Modified.......: Yashied
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetUserDefaultLCID
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetUserDefaultLCID()

    Local $Ret = DllCall('kernel32.dll', 'long', 'GetUserDefaultLCID')

    If @error Then
		Return SetError(1, 0, 0)
	EndIf
    Return $Ret[0]
EndFunc   ;==>_WinAPI_GetUserDefaultLCID

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetVersion
; Description....: Retrieves version of the current operating system.
; Syntax.........: _WinAPI_GetVersion ( )
; Parameters.....: None
; Return values..: Success - The string containing the current OS version.
;
;                            "6.1" - Windows 7 / Windows Server 2008 R2
;                            "6.0" - Windows Server 2008 / Windows Vista
;                            "5.2" - Windows Server 2003 R2 / Windows Home Server / Windows Server 2003 / Windows XP Professional x64 Edition
;                            "5.1" - Windows XP
;                            "5.0" - Windows 2000
;
;                  Failure - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetVersion()

	Local $tOSVERSIONINFOEX = _WinAPI_GetVersionEx()

	If @error Then
		Return SetError(1, 0, '')
	EndIf
	Return DllStructGetData($tOSVERSIONINFOEX, 'MajorVersion') & '.' & DllStructGetData($tOSVERSIONINFOEX, 'MinorVersion')
EndFunc   ;==>_WinAPI_GetVersion

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetVersionEx
; Description....: Retrieves information about the current operating system.
; Syntax.........: _WinAPI_GetVersionEx ( )
; Parameters.....: None
; Return values..: Success - $tagOSVERSIONINFOEX structure that contains the information about the current operating system.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: When using the GetVersionEx function to determine whether your application is running on a particular version of
;                  the operating system, check for version numbers that are greater than or equal to the desired version numbers.
;                  This ensures that the test succeeds for later versions of the operating system.
; Related........:
; Link...........: @@MsdnLink@@ GetVersionEx
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetVersionEx()

	Local $tOSVERSIONINFOEX = DllStructCreate($tagOSVERSIONINFOEX)

	DllStructSetData($tOSVERSIONINFOEX, 'OSVersionInfoSize', DllStructGetSize($tOSVERSIONINFOEX))

	Local $Ret = DllCall('kernel32.dll', 'int', 'GetVersionExW', 'ptr', DllStructGetPtr($tOSVERSIONINFOEX))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $tOSVERSIONINFOEX
EndFunc   ;==>_WinAPI_GetVersionEx

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetVolumeNameForVolumeMountPoint
; Description....: Retrieves a volume GUID path for the volume that is associated with the specified volume mount point.
; Syntax.........: _WinAPI_GetVolumeNameForVolumeMountPoint ( $sPath )
; Parameters.....: $sPath  - The path of a mounted folder (for example, Y:\MountX\) or a drive letter (for example, X:\).
; Return values..: Success - The volume GUID path. This path is of the form "\\?\Volume{GUID}\" where GUID is a GUID that
;                            identifies the volume. If there is more than one volume GUID path for the volume, only the first one
;                            in the mount manager's cache is returned.
;                  Failure - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetVolumeNameForVolumeMountPoint
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetVolumeNameForVolumeMountPoint($sPath)

	Local $tData = DllStructCreate('wchar[80]')
	Local $Ret = DllCall('kernel32.dll', 'int', 'GetVolumeNameForVolumeMountPointW', 'wstr', $sPath, 'ptr', DllStructGetPtr($tData), 'dword', 80)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, '')
	EndIf
	Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_GetVolumeNameForVolumeMountPoint

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetWindowInfo
; Description....: Retrieves information about the specified window.
; Syntax.........: _WinAPI_GetWindowInfo ( $hWnd )
; Parameters.....: $hWnd   - Handle to the window whose information is to be retrieved.
; Return values..: Success - $tagWINDOWINFO structure that contains the information about the specified window.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetWindowInfo
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetWindowInfo($hWnd)

	Local $tWINDOWINFO = DllStructCreate($tagWINDOWINFO)

	DllStructSetData($tWINDOWINFO, 'Size', DllStructGetSize($tWINDOWINFO))

	Local $Ret = DllCall('user32.dll', 'int', 'GetWindowInfo', 'hwnd', $hWnd, 'ptr', DllStructGetPtr($tWINDOWINFO))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $tWINDOWINFO
EndFunc   ;==>_WinAPI_GetWindowInfo

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetWindowModuleFileName
; Description....: Retrieves the full path and file name of the module associated with the specified window handle.
; Syntax.........: _WinAPI_GetWindowModuleFileName ( $hWnd )
; Parameters.....: $hWnd   - Handle to the window whose module file name will be retrieved.
; Return values..: Success - The full path and file name.
;                  Failure - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ GetWindowModuleFileName
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetWindowModuleFileName($hWnd)

	Local $Result = '', $PID = 0

	_WinAPI_GetWindowThreadProcessId($hWnd, $PID)
	If $PID Then
		$Result = _WinAPI_GetModuleFileNameEx($PID)
	EndIf
	Return SetError(@error, 0, $Result)
EndFunc   ;==>_WinAPI_GetWindowModuleFileName

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetWorkArea
; Description....: Retrieves the size of the work area on the primary display monitor.
; Syntax.........: _WinAPI_GetWorkArea ( )
; Parameters.....: None
; Return values..: Success - $tagRECT structure that contains the screen coordinates of the work area.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SystemParametersInfo
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GetWorkArea()

	Local $tRECT = DllStructCreate($tagRECT)
	Local $Ret = DllCall('user32.dll', 'int', 'SystemParametersInfo', 'uint', 48, 'uint', 0, 'ptr', DllStructGetPtr($tRECT), 'uint', 0)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $tRECT
EndFunc   ;==>_WinAPI_GetWorkArea

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GradientFill
; Description....: Fills rectangle or triangle gradient.
; Syntax.........: _WinAPI_GradientFill ($hDC, $aVertex [, $iStart [, $iEnd [, $fRotate]]] )
; Parameters.....: $hDC     - Handle to the destination device context.
;                  $aVertex - The 2D array ([x1, y1, $rgb1], [x2, y2, $rgb2], ... [xN, yN, $rgbN]) that contains the necessary
;                             gradient vertices. Each vertex in this array contains the following parameters.
;
;                             x   - The x-coordinate, in logical units.
;                             y   - The y-coordinate, in logical units
;                             rgb - The color information at the point of x, y.
;
;                  $iStart  - The index of array to start filling at.
;                  $iEnd    - The index of array to stop filling at.
;                  $fRotate - Specifies whether fills a rectangle from left to right edge (horizontal gradient). $fRotate used
;                             only for the rectangular gradients, for the triangular gradients this parameter will be ignored,
;                             valid values:
;                  |TRUE    - Fills from left to right edge.
;                  |FALSE   - Fills from top to bottom edge. (Default)
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: If the number of vertices defined by using $iStart and $iEnd parameters is 2, _WinAPI_GradientFill() function
;                  fills a rectangle. If the number of vertices is 3, fills a triangle. For the rectangle, the vertices must
;                  specify its upper left and lower right corners. Note that $aVertex array may contain any number of vertices
;                  of the gradient, but only 2 or 3 vertices may be used at the same time from this array.
;                  Otherwise, the function is fails.
;
;                  _WinAPI_GradientFill() function can only fill the rectangle or triangle at one call. Use multiple calls this
;                  function to fill a complex gradients.
; Related........:
; Link...........: @@MsdnLink@@ GdiGradientFill
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_GradientFill($hDC, $aVertex, $iStart = 0, $iEnd = -1, $fRotate = 0)

	If UBound($aVertex, 2) < 3  Then
		Return SetError(2, 0, 0)
	EndIf

	Local $Count, $Fill, $Mode, $Point, $tGradient, $tVertex, $Struct = ''

	If $iStart < 0 Then
		$iStart = 0
	EndIf
	If ($iEnd < 0) Or ($iEnd > UBound($aVertex) - 1) Then
		$iEnd = UBound($aVertex) - 1
	EndIf
	$Point = $iEnd - $iStart + 1
	If $Point > 3 Then
		$iEnd = $iStart + 2
		$Point = 3
	EndIf
	Switch $Point
		Case 2
			$Mode = Number(Not $fRotate)
		Case 3
			$Mode = 2
		Case Else
			Return SetError(1, 0, 0)
	EndSwitch
	For $i = $iStart To $iEnd
		$Struct &= 'ushort[8];'
	Next
	$tVertex = DllStructCreate($Struct)
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	$Count = 1
	$tGradient = DllStructCreate('ulong[' & $Point & ']')
	For $i = $iStart To $iEnd
		DllStructSetData($tGradient, 1, $Count - 1, $Count)
		DllStructSetData($tVertex, $Count, _WinAPI_LoWord($aVertex[$i][0]), 1)
		DllStructSetData($tVertex, $Count, _WinAPI_HiWord($aVertex[$i][0]), 2)
		DllStructSetData($tVertex, $Count, _WinAPI_LoWord($aVertex[$i][1]), 3)
		DllStructSetData($tVertex, $Count, _WinAPI_HiWord($aVertex[$i][1]), 4)
		DllStructSetData($tVertex, $Count, BitShift(_WinAPI_GetRValue($aVertex[$i][2]), -8), 5)
		DllStructSetData($tVertex, $Count, BitShift(_WinAPI_GetGValue($aVertex[$i][2]), -8), 6)
		DllStructSetData($tVertex, $Count, BitShift(_WinAPI_GetBValue($aVertex[$i][2]), -8), 7)
		DllStructSetData($tVertex, $Count, 0, 8)
		$Count += 1
	Next

	Local $Ret = DllCall('gdi32.dll', 'int', 'GdiGradientFill', 'hwnd', $hDC, 'ptr', DllStructGetPtr($tVertex), 'ulong', $Point, 'ptr', DllStructGetPtr($tGradient), 'ulong', 1, 'ulong', $Mode)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_GradientFill

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_HideCaret
; Description....: Creates a new shape for the system caret and assigns ownership of the caret to the specified window.
; Syntax.........: _WinAPI_HideCaret ( $hWnd )
; Parameters.....: $hWnd   - Handle to the window that owns the caret. If this parameter is 0, _WinAPI_HideCaret() searches the
;                            current task for the window that owns the caret.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: _WinAPI_HideCaret() hides the caret only if the specified window owns the caret. If the specified window does
;                  not own the caret, _WinAPI_HideCaret() does nothing and returns 0.
;
;                  Hiding is cumulative. If your application calls _WinAPI_HideCaret() five times in a row, it must also call
;                  _WinAPI_ShowCaret() five times before the caret is displayed.
; Related........:
; Link...........: @@MsdnLink@@ HideCaret
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_HideCaret($hWnd)

	Local $Ret = DllCall('user32.dll', 'int', 'HideCaret', 'hwnd', $hWnd)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_HideCaret

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_HiDWord
; Description....: Returns the high DWORD of a 64-bit (8 bytes) value.
; Syntax.........: _WinAPI_HiDWord ( $iValue )
; Parameters.....: $iValue - 64-bit value.
; Return values..: High DWORD value.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_HiDWord($iValue)

	Local $tInt64, $tQWord

	$tInt64 = DllStructCreate('int64')
	$tQWord = DllStructCreate('dword;dword', DllStructGetPtr($tInt64))
	DllStructSetData($tInt64, 1, $iValue)
	Return DllStructGetData($tQWord, 2)
EndFunc   ;==>_WinAPI_HiDWord

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_InflateRect
; Description....: Increases or decreases the width and height of the specified rectangle.
; Syntax.........: _WinAPI_InflateRect ( ByRef $tRECT, $DX, $DY )
; Parameters.....: $tRECT  - $tagRECT structure that increases or decreases in size.
;                  $DX     - The amount to increase or decrease (negative value) the rectangle width.
;                  $DY     - The amount to increase or decrease (negative value) the rectangle height.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ InflateRect
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_InflateRect(ByRef $tRECT, $DX, $DY)

	Local $Ret = DllCall('user32.dll', 'int', 'InflateRect', 'ptr', DllStructGetPtr($tRECT), 'int', $DX, 'int', $DY)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_InflateRect

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_IntersectRect
; Description....: Creates the intersection of two rectangles.
; Syntax.........: _WinAPI_IntersectRect ( $tRECT1, $tRECT2 )
; Parameters.....: $tRECT1 - $tagRECT structure that contains the first source rectangle.
;                  $tRECT2 - $tagRECT structure that contains the second source rectangle.
; Return values..: Success - $tagRECT structure that contains the intersection of the $tRECT1 and $tRECT2 rectangles.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: If the source rectangles do not intersect, an empty rectangle (in which all coordinates are set to zero) is
;                  placed into the destination rectangle.
; Related........:
; Link...........: @@MsdnLink@@ IntersectRect
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_IntersectRect($tRECT1, $tRECT2)

	Local $tRECT = DllStructCreate($tagRECT)
	Local $Ret = DllCall('user32.dll', 'int', 'IntersectRect', 'ptr', DllStructGetPtr($tRECT), 'ptr', DllStructGetPtr($tRECT1), 'ptr', DllStructGetPtr($tRECT2))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $tRECT
EndFunc   ;==>_WinAPI_IntersectRect

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_IntToDWord
; Description....: Converts a value of type INT to a value of type DWORD.
; Syntax.........: _WinAPI_IntToDWord ( $iValue )
; Parameters.....: $iValue - The value to be converted.
; Return values..: The converted (DWORD) value.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_IntToDWord($iValue)

	Local $tData = DllStructCreate('dword')

	DllStructSetData($tData, 1, $iValue)

	Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_IntToDWord

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_InvalidateRect
; Description....: Adds a rectangle to the specified window's update region.
; Syntax.........: _WinAPI_InvalidateRect ( $hWnd [, $tRECT [, $fErase]] )
; Parameters.....: $hWnd   - Handle to the window whose update region has changed. If this parameter is 0, the system invalidates
;                            and redraws all windows, and sends the WM_ERASEBKGND and WM_NCPAINT messages to the window procedure
;                            before the function returns.
;                  $tRECT  - $tagRECT structure that contains the client coordinates of the rectangle to be added to the update
;                            region. If this parameter is 0, the entire client area is added to the update region.
;                  $fErase - Specifies whether the background within the update region is to be erased when the
;                            update region is processed.
;                  |TRUE   - The background is erased. (Default)
;                  |FALSE  - The background remains unchanged.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ InvalidateRect
; Example........: Yes
; ===============================================================================================================================

#cs

Func _WinAPI_InvalidateRect($hWnd, $tRECT = 0, $fErase = 1)

	Local $Ret = DllCall('user32.dll', 'int', 'InvalidateRect', 'hwnd', $hWnd, 'ptr', DllStructGetPtr($tRECT), 'int', $fErase)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_InvalidateRect

#ce

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_InvalidateRgn
; Description....: Adds a region to the specified window's update region.
; Syntax.........: _WinAPI_InvalidateRgn ( $hWnd [, $hRgn [, $fErase]] )
; Parameters.....: $hWnd   - Handle to the window with an update region that is to be modified.
;                  $hRgn   - Handle to the region to be added to the update region. The region is assumed to have client coordinates.
;                            If this parameter is 0, the entire client area is added to the update region.
;                  $fErase - Specifies whether the background within the update region is to be erased when the
;                            update region is processed.
;                  |TRUE   - The background is erased. (Default)
;                  |FALSE  - The background remains unchanged.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ InvalidateRgn
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_InvalidateRgn($hWnd, $hRgn = 0, $fErase = 1)

	Local $Ret = DllCall('user32.dll', 'int', 'InvalidateRgn', 'hwnd', $hWnd, 'ptr', $hRgn, 'int', $fErase)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_InvalidateRgn

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_InvertRect
; Description....: Inverts a rectangle in a window by performing a logical NOT operation on the color values for each pixel.
; Syntax.........: _WinAPI_InvertRect ( $hDC, $tRECT )
; Parameters.....: $hDC    - Handle to the device context.
;                  $tRECT  - $tagRECT structure that contains the logical coordinates of the rectangle to be inverted.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: On monochrome screens, the _WinAPI_InvertRect() makes white pixels black and black pixels white. On color screens,
;                  the inversion depends on how colors are generated for the screen. Calling _WinAPI_InvertRect() twice for the same
;                  rectangle restores the display to its previous colors.
; Related........:
; Link...........: @@MsdnLink@@ InvertRect
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_InvertRect($hDC, $tRECT)

	Local $Ret = DllCall('user32.dll', 'int', 'InvertRect', 'hwnd', $hDC, 'ptr', DllStructGetPtr($tRECT))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_InvertRect

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_InvertRgn
; Description....: Inverts the colors in the specified region.
; Syntax.........: _WinAPI_InvertRgn ( $hDC, $hRgn )
; Parameters.....: $hDC    - Handle to the device context.
;                  $hRgn   - Handle to the region for which colors are inverted. The region's coordinates are
;                            presumed to be logical coordinates.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: On monochrome screens, the _WinAPI_InvertRgn() function makes white pixels black and black pixels white. On color
;                  screens, this inversion is dependent on the type of technology used to generate the colors for the screen.
; Related........:
; Link...........: @@MsdnLink@@ InvertRgn
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_InvertRgn($hDC, $hRgn)

	Local $Ret = DllCall('gdi32.dll', 'int', 'InvertRgn', 'hwnd', $hDC, 'ptr', $hRgn)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_InvertRgn

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_IsChild
; Description....: Tests whether a window is a child window of a specified parent window.
; Syntax.........: _WinAPI_IsChild ( $hWnd, $hWndParent )
; Parameters.....: $hWnd       - Handle to the window to be tested.
;                  $hWndParent - Handle to the parent window.
; Return values..: Success     - 1 - The window is a child window of the specified parent window.
;                                0 - Otherwise.
;                  Failure     - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ IsChild
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_IsChild($hWnd, $hWndParent)

	Local $Ret = DllCall('user32.dll', 'int', 'IsChild', 'hwnd', $hWndParent, 'hwnd', $hWnd)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_IsChild

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_IsDoorOpen
; Description....: Checks if a CD (DVD) tray is open.
; Syntax.........: _WinAPI_IsDoorOpen ( $sDrive )
; Parameters.....: $sDrive - The drive letter of the CD tray to check, in the format D:, E:, etc.
; Return values..: Success - 1 - CD (DVD) tray is open.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: G.Sandler (CreatoR)
; Modified.......: Yashied
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ IOCTL_SCSI_PASS_THROUGH
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_IsDoorOpen($sDrive)

	If Not (_WinAPI_GetDriveType($sDrive) = $DRIVE_CDROM) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $hFile = _WinAPI_CreateFileEx('\\.\' & $sDrive, 3, 6, 6)

	If Not $hFile Then
		Return SetError(1, 0, 0)
	EndIf

	Local $tSCSI_PASS_THROUGH = DllStructCreate('ushort;ubyte;ubyte;ubyte;ubyte;ubyte;ubyte;ubyte;ubyte[3];uint;uint;uint;uint;ubyte[16];ubyte[240];ubyte[1024]')
	Local $pSCSI_PASS_THROUGH = DllStructGetPtr($tSCSI_PASS_THROUGH)

    DllStructSetData($tSCSI_PASS_THROUGH, 1, 44)
    DllStructSetData($tSCSI_PASS_THROUGH, 2, 0)
    DllStructSetData($tSCSI_PASS_THROUGH, 3, 0)
    DllStructSetData($tSCSI_PASS_THROUGH, 4, 0)
    DllStructSetData($tSCSI_PASS_THROUGH, 5, 0)
    DllStructSetData($tSCSI_PASS_THROUGH, 6, 12)
    DllStructSetData($tSCSI_PASS_THROUGH, 7, 16)
    DllStructSetData($tSCSI_PASS_THROUGH, 8, 1)
;   DllStructSetData($tSCSI_PASS_THROUGH, 9, 0)
    DllStructSetData($tSCSI_PASS_THROUGH, 10, 1024)
    DllStructSetData($tSCSI_PASS_THROUGH, 11, 5)
    DllStructSetData($tSCSI_PASS_THROUGH, 12, 44 + 240)
    DllStructSetData($tSCSI_PASS_THROUGH, 13, 44)
    DllStructSetData($tSCSI_PASS_THROUGH, 14, 0xBD, 1)
    DllStructSetData($tSCSI_PASS_THROUGH, 14, 0, 2)
    DllStructSetData($tSCSI_PASS_THROUGH, 14, 0, 3)
    DllStructSetData($tSCSI_PASS_THROUGH, 14, 0, 4)
    DllStructSetData($tSCSI_PASS_THROUGH, 14, 0, 5)
    DllStructSetData($tSCSI_PASS_THROUGH, 14, 0, 6)
    DllStructSetData($tSCSI_PASS_THROUGH, 14, 0, 7)
    DllStructSetData($tSCSI_PASS_THROUGH, 14, 0, 8)
    DllStructSetData($tSCSI_PASS_THROUGH, 14, 0, 9)
    DllStructSetData($tSCSI_PASS_THROUGH, 14, 8, 10)
    DllStructSetData($tSCSI_PASS_THROUGH, 14, 0, 11)
    DllStructSetData($tSCSI_PASS_THROUGH, 14, 0, 12)
    DllStructSetData($tSCSI_PASS_THROUGH, 14, 0, 13)
    DllStructSetData($tSCSI_PASS_THROUGH, 14, 0, 14)
    DllStructSetData($tSCSI_PASS_THROUGH, 14, 0, 15)
    DllStructSetData($tSCSI_PASS_THROUGH, 14, 0, 16)
    DllStructSetData($tSCSI_PASS_THROUGH, 15, 0, 1)
    DllStructSetData($tSCSI_PASS_THROUGH, 16, 0, 1)

	Local $Ret = DllCall('kernel32.dll', 'int', 'DeviceIoControl', 'ptr', $hFile, 'dword', 0x0004D004, 'ptr', $pSCSI_PASS_THROUGH, 'dword', 44, 'ptr', $pSCSI_PASS_THROUGH, 'dword', DllStructGetSize($tSCSI_PASS_THROUGH), 'dword*', 0, 'ptr', 0)

	If (@error) Or (Not $Ret[0]) Then
		$Ret = 0
	EndIf
	_WinAPI_FreeHandle($hFile)
	If Not IsArray($Ret) Then
		Return SetError(2, 0, 0)
	EndIf
	Return SetError(0, 0, BitAND(DllStructGetData($tSCSI_PASS_THROUGH, 16, 2), 0x10) = 0x10)
EndFunc   ;==>_WinAPI_IsDoorOpen

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_IsHungAppWindow
; Description....: Determines whether the specified application is not responding.
; Syntax.........: _WinAPI_IsHungAppWindow ( $hWnd )
; Parameters.....: $hWnd   - Handle to the window.
; Return values..: Success - 1 - The window stops responding.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: An application is considered to be not responding if it is not waiting for input, is not in startup processing,
;                  and has not called PeekMessage within the internal timeout period of 5 seconds.
; Related........:
; Link...........: @@MsdnLink@@ IsHungAppWindow
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_IsHungAppWindow($hWnd)

	Local $Ret = DllCall('user32.dll', 'int', 'IsHungAppWindow', 'hwnd', $hWnd)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_IsHungAppWindow

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_IsIconic
; Description....: Determines whether the specified window is minimized (iconic).
; Syntax.........: _WinAPI_IsIconic ( $hWnd )
; Parameters.....: $hWnd   - Handle to the window to test.
; Return values..: Success - 1 - The window is iconic.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ IsIconic
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_IsIconic($hWnd)

	Local $Ret = DllCall('user32.dll', 'int', 'IsIconic', 'hwnd', $hWnd)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_IsIconic

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_IsLoadKBLayout
; Description....: Determines whether the specified input locale loaded into the system.
; Syntax.........: _WinAPI_IsLoadKBLayout ( $iLanguage )
; Parameters.....: $iLanguage - The name of the input locale identifier (LCID).
; Return values..: Success    - 1 - The input locale is loaded.
;                               0 - Otherwise.
;                  Failure    - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_IsLoadKBLayout($iLanguage)

	Local $Layout = _WinAPI_GetKeyboardLayoutList()

	If Not IsArray($Layout) Then
		Return SetError(1, 0, 0)
	EndIf
	For $i = 1 To $Layout[0]
		If $Layout[$i] = $iLanguage Then
			Return 1
		EndIf
	Next
	Return 0
EndFunc   ;==>_WinAPI_IsLoadKBLayout

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_IsNetworkAlive
; Description....: Determines whether or not a local system is connected to a network, and identifies the type of network connection.
; Syntax.........: _WinAPI_IsNetworkAlive ( )
; Parameters.....: None
; Return values..: Success - The type of network connection ($NETWORK_ALIVE_...) if a local system is connected to a network.
;                            0 - Is no connection.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: Always check @error flag before checking the return value of this function. If the @error is not 0,
;                  the function has failed and the following values do not apply.
; Related........:
; Link...........: @@MsdnLink@@ IsNetworkAlive
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_IsNetworkAlive()

	Local $Ret = DllCall('sensapi.dll', 'int', 'IsNetworkAlive', 'int*', 0)

	If (@error) Or (Not $Ret[0]) Or (_WinAPI_GetLastError()) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[1]
EndFunc   ;==>_WinAPI_IsNetworkAlive

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_IsPressed
; Description....: Checks whether the key is pressed from the specified range.
; Syntax.........: _WinAPI_IsPressed ( [$iFrom [, $iTo]] )
; Parameters.....: $iFrom  - Specifies a virtual-key code to start checking. The code must be a value in the range 1 to 254.
;                  $iTo    - Specifies a virtual-key code to end checking. The code must be a value in the range 1 to 254 and be
;                            greater than value of the $iFrom parameter.
; Return values..: Success - 1 - The key is pressed.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The key status returned from this function changes as a process reads key messages from its message queue.
;                  The status does not reflect the interrupt-level state associated with the hardware. Use the _WinAPI_GetAsyncKeyState()
;                  function to retrieve that information.
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_IsPressed($iFrom = 0x01, $iTo = 0xFF)

	Local $tData = _WinAPI_GetKeyboardState()

	If @error Then
		Return SetError(1, 0, 0)
	EndIf

	For $i = $iFrom To $iTo
		Switch $i
			Case 0x0A, 0x0B, 0x0E To 0x0F, 0x16, 0x1A, 0x1C To 0x1F, 0x3A To 0x40, 0x5E, 0x88 To 0x8F, 0x97 To 0x9F, 0xB8 To 0xB9, 0xC1 To 0xDA, 0xE0, 0xE8
				ContinueLoop
			Case Else
				If BitAND(DllStructGetData($tData, 1, $i + 1), 0xF0) Then
					Return $i
				EndIf
		EndSwitch
	Next
	Return 0
EndFunc   ;==>_WinAPI_IsPressed

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_IsProcessInJob
; Description....: Determines whether the process is running in the specified job.
; Syntax.........: _WinAPI_IsProcessInJob( $hProcess [, $hJob] )
; Parameters.....: $hProcess - Handle to the process to be tested. The handle must have the $PROCESS_QUERY_INFORMATION or
;                              $PROCESS_QUERY_LIMITED_INFORMATION access right.
;                  $hJob     - Handle to the job. If this parameter is 0, the function tests if the process is running under any job.
; Return values..: Success   - 1 - The process is running in the job.
;                              0 - Otherwise.
;                  Failure   - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: An application cannot obtain a handle to the job object in which it is running unless it has the name of the job
;                  object. However, an application can call the _WinAPI_QueryInformationJobObject() function with 0 to obtain
;                  information about the job object.
; Related........:
; Link...........: @@MsdnLink@@ IsProcessInJob
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_IsProcessInJob($hProcess, $hJob = 0)

	Local $Ret = DllCall('kernel32.dll', 'int', 'IsProcessInJob', 'ptr', $hProcess, 'ptr', $hJob, 'int*', 0)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[3]
EndFunc   ;==>_WinAPI_IsProcessInJob

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_IsProcessorFeaturePresent
; Description....: Determines whether the specified processor feature is supported by the current computer.
; Syntax.........: _WinAPI_IsProcessorFeaturePresent ( $iFeature )
; Parameters.....: $iFeature - The processor feature to be tested. This parameter can be one of the $PF_... constants.
; Return values..: Success   - 1 - The feature is supported.
;                              0 - Otherwise.
;                  Failure   - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ IsProcessorFeaturePresent
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_IsProcessorFeaturePresent($iFeature)

	Local $Ret = DllCall('kernel32.dll', 'int', 'IsProcessorFeaturePresent', 'dword', $iFeature)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_IsProcessorFeaturePresent

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_IsRectEmpty
; Description....: Determines whether the specified rectangle is empty.
; Syntax.........: _WinAPI_IsRectEmpty ( $tRECT )
; Parameters.....: $tRECT  - $tagRECT structure that contains the logical coordinates of the rectangle.
; Return values..: Success - 1 - The rectangle is empty.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: An empty rectangle is one that has no area; that is, the coordinate of the right side is less than or equal
;                  to the coordinate of the left side, or the coordinate of the bottom side is less than or equal to the
;                  coordinate of the top side.
; Related........:
; Link...........: @@MsdnLink@@ IsRectEmpty
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_IsRectEmpty($tRECT)

	Local $Ret = DllCall('user32.dll', 'int', 'IsRectEmpty', 'ptr', DllStructGetPtr($tRECT))

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_IsRectEmpty

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_IsThemeActive
; Description....: Tests if a visual style for the current application is active.
; Syntax.........: _WinAPI_IsThemeActive ( )
; Parameters.....: None
; Return values..: Success - 1 - The visual style is enabled.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ IsThemeActive
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_IsThemeActive()

	Local $Ret = DllCall('uxtheme.dll', 'int', 'IsThemeActive')

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_IsThemeActive

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_IsThemeBackgroundPartiallyTransparent
; Description....: Retrieves whether the background specified by the visual style has transparent pieces or alpha-blended pieces.
; Syntax.........: _WinAPI_IsThemeBackgroundPartiallyTransparent ( $hTheme, $iPartId, $iStateId )
; Parameters.....: $hTheme   - Handle to a window's specified theme data.
;                  $iPartId  - The part.
;                  $iStateId - The state of the part.
; Return values..: Success   - 1 - The theme-specified background has transparent pieces or alpha-blended pieces.
;                              0 - Otherwise.
;                  Failure   - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ IsThemeBackgroundPartiallyTransparent
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_IsThemeBackgroundPartiallyTransparent($hTheme, $iPartId, $iStateId)

	Local $Ret = DllCall('uxtheme.dll', 'int', 'IsThemeBackgroundPartiallyTransparent', 'ptr', $hTheme, 'int', $iPartId, 'int', $iStateId)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_IsThemeBackgroundPartiallyTransparent

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_IsThemePartDefined
; Description....: Retrieves whether a visual style has defined parameters for the specified part.
; Syntax.........: _WinAPI_IsThemePartDefined ( $hTheme, $iPartId )
; Parameters.....: $hTheme  - Handle to a window's specified theme data.
;                  $iPartId - The part.
; Return values..: Success  - 1 - The theme has defined parameters for the specified $iPartId.
;                             0 - Otherwise.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ IsThemePartDefined
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_IsThemePartDefined($hTheme, $iPartId)

	Local $Ret = DllCall('uxtheme.dll', 'int', 'IsThemePartDefined', 'ptr', $hTheme, 'int', $iPartId, 'int', 0)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_IsThemePartDefined

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_IsValidLocale
; Description....: Determines if the specified locale is installed or supported on the operating system.
; Syntax.........: _WinAPI_IsValidLocale ( $LCID [, $iFlag] )
; Parameters.....: $LCID   - Locale identifier of the locale to validate.
;                  $iFlag  - Flag specifying the validity test to apply to the locale identifier. This parameter can have one
;                            of the following values.
;
;                            $LCID_INSTALLED
;                            $LCID_SUPPORTED
;
; Return values..: Success - 1 - The locale identifier passes the specified validity test.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ IsValidLocale
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_IsValidLocale($LCID, $iFlag)

	Local $Ret = DllCall('kernel32.dll', 'int', 'IsValidLocale', 'long', $LCID, 'dword', $iFlag)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_IsValidLocale

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_IsWindowEnabled
; Description....: Determines whether the specified window is enabled for mouse and keyboard input.
; Syntax.........: _WinAPI_IsWindowEnabled ( $hWnd )
; Parameters.....: $hWnd   - Handle to the window to test.
; Return values..: Success - 1 - The window is enabled.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: A child window receives input only if it is both enabled and visible.
; Related........:
; Link...........: @@MsdnLink@@ IsWindowEnabled
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_IsWindowEnabled($hWnd)

	Local $Ret = DllCall('user32.dll', 'int', 'IsWindowEnabled', 'hwnd', $hWnd)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_IsWindowEnabled

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_IsWindowUnicode
; Description....: Determines whether the specified window is a native Unicode window.
; Syntax.........: _WinAPI_IsWindowUnicode ( $hWnd )
; Parameters.....: $hWnd   - Handle to the window to test.
; Return values..: Success - 1 - The window is a native Unicode window.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ IsWindowUnicode
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_IsWindowUnicode($hWnd)

	Local $Ret = DllCall('user32.dll', 'int', 'IsWindowUnicode', 'hwnd', $hWnd)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_IsWindowUnicode

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_IsWow64Process
; Description....: Determines whether the specified process is running under WOW64.
; Syntax.........: _WinAPI_IsWow64Process ( [$PID] )
; Parameters.....: $PID    - The PID of the process. Default (0) is the current process.
; Return values..: Success - 1 - The process is running under WOW64.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ IsWow64Process
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_IsWow64Process($PID = 0)

	If Not $PID Then
		$PID = _WinAPI_GetCurrentProcessID()
		If Not $PID Then
			Return SetError(1, 0, 0)
		EndIf
	EndIf

	Local $hProcess = DllCall('kernel32.dll', 'ptr', 'OpenProcess', 'dword', 0x00000400, 'int', 0, 'dword', $PID)

	If (@error) Or (Not $hProcess[0]) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $Ret = DllCall('kernel32.dll', 'int', 'IsWow64Process', 'ptr', $hProcess[0], 'int*', 0)

	If (@error) Or (Not $Ret[0]) Then
		$Ret = 0
	EndIf
	_WinAPI_FreeHandle($hProcess[0])
	If Not IsArray($Ret) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[2]
EndFunc   ;==>_WinAPI_IsWow64Process

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_IsWritable
; Description....: Determines whether a disk is writable.
; Syntax.........: _WinAPI_IsWritable ( $sDrive )
; Parameters.....: $sDrive - The drive letter of the disk to check, in the format D:, E:, etc.
; Return values..: Success - 1 - The disk is writable.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ IOCTL_DISK_IS_WRITABLE
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_IsWritable($sDrive)

	Local $hFile = _WinAPI_CreateFileEx('\\.\' & $sDrive, 3, 0, 0)

	If Not $hFile Then
		Return SetError(1, 0, 0)
	EndIf

	Local $Ret = DllCall('kernel32.dll', 'int', 'DeviceIoControl', 'ptr', $hFile, 'dword', 0x00070024, 'ptr', 0, 'dword', 0, 'ptr', 0, 'dword', 0, 'dword*', 0, 'ptr', 0)

	If @error Then
		$Ret = 0
	Else
		If Not $Ret[0] Then
			Switch _WinAPI_GetLastError()
				Case 19 ; ERROR_WRITE_PROTECT

				Case Else
					$Ret = 0
			EndSwitch
		EndIf
	EndIf
	_WinAPI_FreeHandle($hFile)
	If Not IsArray($Ret) Then
		Return SetError(2, 0, 0)
	EndIf
	Return SetError(0, 0, $Ret[0])
EndFunc   ;==>_WinAPI_IsWritable

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_IsZoomed
; Description....: Determines whether a window is maximized.
; Syntax.........: _WinAPI_IsZoomed ( $hWnd )
; Parameters.....: $hWnd   - Handle to the window to test.
; Return values..: Success - 1 - The window is zoomed.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ IsZoomed
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_IsZoomed($hWnd)

	Local $Ret = DllCall('user32.dll', 'int', 'IsZoomed', 'hwnd', $hWnd)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_IsZoomed

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_Keybd_Event
; Description....: Synthesizes a keystroke.
; Syntax.........: _WinAPI_Keybd_Event ( $vkCode, $iFlags [, $iScanCode [, $iExtraInfo]] )
; Parameters.....: $vkCode     - The virtual-key code ($VK_...). The code must be a value in the range 1 to 254.
;
;                                0x01 - Left mouse button
;                                0x02 - Right mouse button
;                                0x03 - Control-break processing
;                                0x04 - Middle mouse button (three-button mouse)
;                                0x05 - X1 mouse button
;                                0x06 - X2 mouse button
;
;                                0x08 - BACKSPACE key
;                                0x09 - TAB key
;
;                                0x0C - CLEAR key
;                                0x0D - ENTER key
;
;                                0x10 - SHIFT key
;                                0x11 - CTRL key
;                                0x12 - ALT key
;                                0x13 - PAUSE key
;                                0x14 - CAPS LOCK key
;
;                                0x1B - ESC key
;
;                                0x20 - SPACEBAR key
;                                0x21 - PAGE UP key
;                                0x22 - PAGE DOWN key
;                                0x23 - END key
;                                0x24 - HOME key
;                                0x25 - LEFT ARROW key
;                                0x26 - UP ARROW key
;                                0x27 - RIGHT ARROW key
;                                0x28 - DOWN ARROW key
;                                0x29 - SELECT key
;                                0x2A - PRINT key
;                                0x2B - EXECUTE key
;                                0x2C - PRINT SCREEN key
;                                0x2D - INS key
;                                0x2E - DEL key
;                                0x2F - HELP key
;                                0x30 - 0x39 - (0 - 9) key
;
;                                0x41 - 0x5A - (A - Z) key
;                                0x5B - Left Windows key
;                                0x5C - Right Windows key
;                                0x5D - Applications key
;
;                                0x5F - Computer Sleep key
;                                0x60 - 0x69 - Numeric keypad (0 - 9) key
;                                0x6A - Multiply key
;                                0x6B - Add key
;                                0x6C - Separator key
;                                0x6D - Subtract key
;                                0x6E - Decimal key
;                                0x6F - Divide key
;                                0x70 - 0x87 - (F1 - F24) key
;
;                                0x90 - NUM LOCK key
;                                0x91 - SCROLL LOCK key
;
;                                0xA0 - Left SHIFT key
;                                0xA1 - Right SHIFT key
;                                0xA2 - Left CONTROL key
;                                0xA3 - Right CONTROL key
;                                0xA4 - Left MENU key
;                                0xA5 - Right MENU key
;                                0xA6 - Browser Back key
;                                0xA7 - Browser Forward key
;                                0xA8 - Browser Refresh key
;                                0xA9 - Browser Stop key
;                                0xAA - Browser Search key
;                                0xAB - Browser Favorites key
;                                0xAC - Browser Start and Home key
;                                0xAD - Volume Mute key
;                                0xAE - Volume Down key
;                                0xAF - Volume Up key
;                                0xB0 - Next Track key
;                                0xB1 - Previous Track key
;                                0xB2 - Stop Media key
;                                0xB3 - Play/Pause Media key
;                                0xB4 - Start Mail key
;                                0xB5 - Select Media key
;                                0xB6 - Start Application 1 key
;                                0xB7 - Start Application 2 key
;
;                                0xBA - ';:' key
;                                0xBB - '+' key
;                                0xBC - ',' key
;                                0xBD - '-' key
;                                0xBE - '.' key
;                                0xBF - '/?' key
;                                0xC0 - '`~' key
;
;                                0xDB - '[{' key
;                                0xDC - '\|' key
;                                0xDD - ']}' key
;                                0xDE - 'single-quote/double-quote' key
;
;                                0xE2 - Either the angle bracket key or the backslash key on the RT 102-key keyboard
;
;                                0xE7 - Used to pass Unicode characters as if they were keystrokes
;
;                                0xF6 - Attn key
;                                0xF7 - CrSel key
;                                0xF8 - ExSel key
;                                0xF9 - Erase EOF key
;                                0xFA - Play key
;                                0xFB - Zoom key
;
;                                0xFD - PA1 key
;                                0xFE - Clear key
;
;                  $iFlags     - This parameter can be one or more of the following values.
;
;                                $KEYEVENTF_EXTENDEDKEY
;                                $KEYEVENTF_KEYUP
;
;                  $iScanCode  - The hardware scan code for the key.
;                  $iExtraInfo - The additional value associated with the key stroke.
; Return values..: Success     - 1.
;                  Failure     - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ keybd_event
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_Keybd_Event($vkCode, $iFlags, $iScanCode = 0, $iExtraInfo = 0)
	DllCall('user32.dll', 'int', 'keybd_event', 'int', $vkCode, 'int', $iScanCode, 'int', $iFlags, 'ptr', $iExtraInfo)
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_Keybd_Event

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_KillTimer
; Description....: Destroys the specified timer.
; Syntax.........: _WinAPI_KillTimer ( $hWnd, $iTimerID )
; Parameters.....: $hWnd     - Handle to the window associated with the specified timer. This value must be the same as the
;                              $hWnd value passed to the _WinAPI_SetTimer() function that created the timer.
;                  $iTimerID - The timer identifier which specifies the timer to be destroyed.
; Return values..: Success   - 1.
;                  Failure   - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function does not remove WM_TIMER messages already posted to the message queue.
; Related........:
; Link...........: @@MsdnLink@@ KillTimer
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_KillTimer($hWnd, $iTimerID)

	Local $Ret = DllCall('user32.dll', 'int', 'KillTimer', 'hwnd', $hWnd, 'uint_ptr', $iTimerID)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_KillTimer

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_LoadCursor
; Description....: Loads the specified cursor resource from the executable (.EXE) file.
; Syntax.........: _WinAPI_LoadCursor ( $hInstance, $sName )
; Parameters.....: $hInstance - Handle to an instance of the module whose executable file contains the cursor to be loaded.
;                  $sName     - The name of the cursor resource or resource identifier to be loaded. To use one of the predefined
;                               cursors, the application must set the $hInstance parameter to 0 and the $sName parameter to one
;                               of the following values.
;
;                               $IDC_APPSTARTING
;                               $IDC_HAND
;                               $IDC_ARROW
;                               $IDC_CROSS
;                               $IDC_IBEAM
;                               $IDC_ICON
;                               $IDC_NO
;                               $IDC_SIZE
;                               $IDC_SIZEALL
;                               $IDC_SIZENESW
;                               $IDC_SIZENS
;                               $IDC_SIZENWSE
;                               $IDC_SIZEWE
;                               $IDC_UPARROW
;                               $IDC_WAIT
;
; Return values..: Success    - Handle to the newly loaded cursor.
;                  Failure    - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function loads the cursor resource only if it has not been loaded; otherwise, it retrieves the handle to
;                  the existing resource.
; Related........:
; Link...........: @@MsdnLink@@ LoadCursor
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_LoadCursor($hInstance, $sName)

	Local $TypeOfName = 'ptr'

	If IsString($sName) Then
		$TypeOfName = 'wstr'
	EndIf

	Local $Ret = DllCall('user32.dll', 'ptr', 'LoadCursorW', 'ptr', $hInstance, $TypeOfName, $sName)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_LoadCursor

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_LoadCursorFromFile
; Description....: Creates a cursor based on data contained in a file.
; Syntax.........: _WinAPI_LoadCursorFromFile ( $sFile )
; Parameters.....: $sFile  - The file data to be used to create the cursor. The data in the file must be in either .CUR or .ANI format.
; Return values..: Success - Handle to the new cursor.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ LoadCursorFromFile
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_LoadCursorFromFile($sFile)

	Local $Ret = DllCall('user32.dll', 'ptr', 'LoadCursorFromFileW', 'wstr', $sFile)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_LoadCursorFromFile

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_LoadIconWithScaleDown
; Description....: Loads an icon and scales down a larger image instead of scaling up a smaller image.
; Syntax.........: _WinAPI_LoadIconWithScaleDown ( $hInstance, $sName, $iWidth, $iHeight )
; Parameters.....: $hInstance - Handle to the module of either a DLL or executable (.exe) file that contains the icon to be loaded.
;                  $sName     - The information about the icon to load. If $hInstance is not 0, $sName specifies the icon resource
;                               either by name or ordinal, otherwise, $sName specifies either the name of a standalone icon (.ico)
;                               file or the identifier of a predefined icon to load.
;
;                               $IDI_APPLICATION
;                               $IDI_ASTERISK
;                               $IDI_ERROR
;                               $IDI_EXCLAMATION
;                               $IDI_HAND
;                               $IDI_INFORMATION
;                               $IDI_QUESTION
;                               $IDI_SHIELD
;                               $IDI_WARNING
;                               $IDI_WINLOGO
;
;                  $iWidth    - The desired width, in pixels, of the icon.
;                  $iHeight   - The desired height, in pixels, of the icon.
; Return values..: Success    - The icon handle.
;                  Failure    - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function requires Windows Vista or above.
; Related........:
; Link...........: @@MsdnLink@@ LoadIconWithScaleDown
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_LoadIconWithScaleDown($hInstance, $sName, $iWidth, $iHeight)

	Local $TypeOfName = 'ptr'

	If IsString($sName) Then
		$TypeOfName = 'wstr'
	EndIf

	Local $Ret = DllCall('comctl32.dll ', 'uint', 'LoadIconWithScaleDown', 'ptr', $hInstance, $TypeOfName, $sName, 'int', $iWidth, 'int', $iHeight, 'ptr*', 0)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return $Ret[5]
EndFunc   ;==>_WinAPI_LoadIconWithScaleDown

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_LoadKeyboardLayout
; Description....: Loads a new input locale identifier into the system.
; Syntax.........: _WinAPI_LoadKeyboardLayout ( $iLanguage [, $iFlag] )
; Parameters.....: $iLanguage - The name of the input locale identifier to load (LCID).
;                  $iFlag     - The flag that specifies how the input locale identifier is to be loaded. This parameter can be
;                               one of the following values.
;
;                               $KLF_ACTIVATE
;                               $KLF_NOTELLSHELL
;                               $KLF_REORDER
;                               $KLF_REPLACELANG
;                               $KLF_SUBSTITUTE_OK
;                               $KLF_SETFORPROCESS
;
; Return values..: Success    - The input locale identifier to the locale matched with the requested name.
;                  Failure    - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ LoadKeyboardLayout
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_LoadKeyboardLayout($iLanguage, $iFlag = 0)

	Local $Ret = DllCall('user32.dll', 'long', 'LoadKeyboardLayoutW', 'wstr', '0000' & Hex($iLanguage, 4), 'uint', $iFlag)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_LoadKeyboardLayout

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_LoadMedia
; Description....: Causes media to be loaded in a device.
; Syntax.........: _WinAPI_LoadMedia ( $sDrive )
; Parameters.....: $sDrive - The drive letter of the CD tray to load, in the format D:, E:, etc.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ IOCTL_STORAGE_LOAD_MEDIA
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_LoadMedia($sDrive)

	If Not (_WinAPI_GetDriveType($sDrive) = $DRIVE_CDROM) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $hFile = _WinAPI_CreateFileEx('\\.\' & $sDrive, 3, 0x80000000, 0x01)

	If Not $hFile Then
		Return SetError(1, 0, 0)
	EndIf

	Local $Ret = DllCall('kernel32.dll', 'int', 'DeviceIoControl', 'ptr', $hFile, 'dword', 0x002D480C, 'ptr', 0, 'dword', 0, 'ptr', 0, 'dword', 0, 'dword*', 0, 'ptr', 0)

	If (@error) Or (Not $Ret[0]) Then
		$Ret = 0
	EndIf
	_WinAPI_FreeHandle($hFile)
	If Not IsArray($Ret) Then
		Return SetError(2, 0, 0)
	EndIf
	Return SetError(0, 0, $Ret[0])
EndFunc   ;==>_WinAPI_LoadMedia

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_LoadResource
; Description....: Loads the specified resource into global memory.
; Syntax.........: _WinAPI_LoadResource ( $hInstance, $hResource )
; Parameters.....: $hInstance - Handle to the module whose executable file contains the resource. If this parameter is 0, the system
;                               loads the resource from the module that was used to create the current process.
;                  $hResource - Handle to the resource to be loaded. This handle is returned by the _WinAPI_FindResource()
;                               or _WinAPI_FindResourceEx() function.
; Return values..: Success    - Handle to the data associated with the resource.
;                  Failure    - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: To obtain a pointer to the resource data, call the _WinAPI_LockResource() function.
; Related........:
; Link...........: @@MsdnLink@@ LoadResource
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_LoadResource($hInstance, $hResource)

	Local $Ret = DllCall('kernel32.dll', 'ptr', 'LoadResource', 'ptr', $hInstance, 'ptr', $hResource)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_LoadResource

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_LockDevice
; Description....: Enables or disables the mechanism that ejects media, for those devices possessing that locking capability.
; Syntax.........: _WinAPI_LockDevice ( $sDrive, $fLock )
; Parameters.....: $sDrive - The drive letter of the device to enable or disable, in the format D:, E:, etc.
;                  $fLock  - Specifies whether the device should be disabled, valid values:
;                  |TRUE   - The device is disabled.
;                  |FALSE  - The device is enabled.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Psandu.ro
; Modified.......: Yashied
; Remarks........: This function is valid only for devices that support removable media.
; Related........:
; Link...........: @@MsdnLink@@ IOCTL_STORAGE_MEDIA_REMOVAL
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_LockDevice($sDrive, $fLock)

	Local $hFile = _WinAPI_CreateFileEx('\\.\' & $sDrive, 3, 0xC0000000, 0x03)

	If Not $hFile Then
		Return SetError(1, 0, 0)
	EndIf

	Local $tPREVENT_MEDIA_REMOVAL = DllStructCreate('byte')

	DllStructSetData($tPREVENT_MEDIA_REMOVAL, 1, $fLock)

	Local $Ret = DllCall('kernel32.dll', 'int', 'DeviceIoControl', 'ptr', $hFile, 'dword', 0x002D4804, 'ptr', DllStructGetPtr($tPREVENT_MEDIA_REMOVAL), 'dword', DllStructGetSize($tPREVENT_MEDIA_REMOVAL), 'ptr', 0, 'dword', 0, 'dword*', 0, 'ptr', 0)

	If (@error) Or (Not $Ret[0]) Then
		$Ret = 0
	EndIf
	_WinAPI_FreeHandle($hFile)
	If Not IsArray($Ret) Then
		Return SetError(2, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_LockDevice

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_LockFile
; Description....: Locks the specified file for exclusive access by the calling process.
; Syntax.........: _WinAPI_LockFile ( $hFile, $iOffset, $iLenght )
; Parameters.....: $hFile   - Handle to the file.
;                  $iOffset - The starting byte offset in the file where the lock should begin.
;                  $iLenght - The length of the byte range to be locked.
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: If a process terminates with a portion of a file locked or closes a file that has outstanding locks, the locks are
;                  unlocked by the operating system. However, the time it takes for the operating system to unlock these locks depends
;                  upon available system resources. Therefore, it is recommended that your process explicitly unlock all files it
;                  has locked when it terminates.
; Related........:
; Link...........: @@MsdnLink@@ LockFile
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_LockFile($hFile, $iOffset, $iLenght)

	Local $Ret = DllCall('kernel32.dll', 'int', 'LockFile', 'ptr', $hFile, 'dword', _WinAPI_LoDWord($iOffset), 'dword', _WinAPI_HiDWord($iOffset), 'dword', _WinAPI_LoDWord($iLenght), 'dword', _WinAPI_HiDWord($iLenght))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_LockFile

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_LockResource
; Description....: Locks the specified resource in memory.
; Syntax.........: _WinAPI_LockResource ( $hData )
; Parameters.....: $hData  - Handle to the resource to be locked. The _WinAPI_LoadResource() function returns this handle. Do not
;                            pass any value as a parameter other than a successful return value from the LoadResource function.
; Return values..: Success - Pointer to the first byte of the resource.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The pointer returned by this function is valid until the module containing the resource is unloaded. It is not
;                  necessary to unlock resources because the system automatically deletes them when the process that created
;                  them terminates.
;
;                  Do not try to lock a resource by using the handle returned by the _WinAPI_FindResource() or _WinAPI_FindResourceEx()
;                  function. Such a handle points to random data.
; Related........:
; Link...........: @@MsdnLink@@ LockResource
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_LockResource($hData)

	Local $Ret = DllCall('kernel32.dll', 'ptr', 'LockResource', 'ptr', $hData)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_LockResource

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_LockWorkStation
; Description....: Locks the workstation's display.
; Syntax.........: _WinAPI_LockWorkStation ( )
; Parameters.....: None
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ LockWorkStation
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_LockWorkStation()
	DllCall('user32.dll', 'int', 'LockWorkStation')
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_LockWorkStation

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_LoDWord
; Description....: Returns the low DWORD of a 64-bit (8 bytes) value.
; Syntax.........: _WinAPI_LoDWord ( $iValue )
; Parameters.....: $iValue - 64-bit value.
; Return values..: Low DWORD value.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_LoDWord($iValue)

	Local $tInt64, $tQWord

	$tInt64 = DllStructCreate('int64')
	$tQWord = DllStructCreate('dword;dword', DllStructGetPtr($tInt64))
	DllStructSetData($tInt64, 1, $iValue)
	Return DllStructGetData($tQWord, 1)
EndFunc   ;==>_WinAPI_LoDWord

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_LookupPrivilegeName
; Description....: Retrieves the name that corresponds to the privilege by a specified locally unique identifier (LUID).
; Syntax.........: _WinAPI_LookupPrivilegeName ( $tLUID )
; Parameters.....: $tLUID  - $tagLUID structure that specifies the LUID by which the privilege is known on the target system.
; Return values..: Success - The string that represents the privilege name. For example, "SeSecurityPrivilege".
;                  Failure - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ LookupPrivilegeName
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_LookupPrivilegeName($tLUID)

	Local $tData = DllStructCreate('wchar[128]')
	Local $Ret = DllCall('advapi32.dll', 'int', 'LookupPrivilegeNameW', 'ptr', 0, 'ptr', DllStructGetPtr($tLUID), 'ptr', DllStructGetPtr($tData), 'dword*', 128)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, '')
	EndIf
	Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_LookupPrivilegeName

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_LookupPrivilegeValue
; Description....: Retrieves the locally unique identifier (LUID) to locally represent the specified privilege name.
; Syntax.........: _WinAPI_LookupPrivilegeValue ( $sPrivilege )
; Parameters.....: $sPrivilege - The string that specifies the name of the privilege ($SE_...).
; Return values..: Success     - $tagLUID structure that contains the LUID.
;                  Failure     - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ LookupPrivilegeValue
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_LookupPrivilegeValue($sPrivilege)

	Local $tLUID = DllStructCreate($tagLUID)
	Local $Ret = DllCall('advapi32.dll', 'int', 'LookupPrivilegeValueW', 'ptr', 0, 'wstr', $sPrivilege, 'ptr', DllStructGetPtr($tLUID))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $tLUID
EndFunc   ;==>_WinAPI_LookupPrivilegeValue

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_MessageBoxCheck
; Description....: Displays a message box that gives the user the option of suppressing further occurrences.
; Syntax.........: _WinAPI_MessageBoxCheck ( $iType, $sTitle, $sText, $sRegVal [, $iDefault [, $hParent]] )
; Parameters.....: $iType    - The flags that specify the contents and behavior of the message box.
;
;                              You must specify the buttons to be displayed by setting one and only one of the following flags.
;
;                              $MB_OK
;                              $MB_OKCANCEL
;                              $MB_YESNO
;
;                              You can display an optional icon by setting one and only one of the following flags.
;
;                              $MB_ICONEXCLAMATION
;                              $MB_ICONHAND
;                              $MB_ICONINFORMATION
;                              $MB_ICONQUESTION
;
;                  $sTitle   - The string that contains the title of the message box.
;                  $sText    - The string that contains the message to be displayed.
;                  $sRegVal  - The string that contains a unique string value to associate with this message.
;                  $iDefault - The value that the function returns when the user has opted not to have the message box displayed
;                              again. If the user has not opted to suppress the message box, the message box is displayed and
;                              the function ignores $iDefault.
;                  $hParent  - The window handle to the message box's owner.
; Return values..: Success   - If the user has already chosen to suppress the message box, the function immediately returns the
;                              value assigned to $iDefault, otherwise, returns one of the $ID... constants.
;                  Failure   - (-1) and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function records the message boxes that the user has chosen to suppress under the following registry key.
;
;                  HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\LowRegistry\DontShowMeThisDialogAgain
;
; Related........:
; Link...........: @@MsdnLink@@ SHMessageBoxCheck
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_MessageBoxCheck($iType, $sTitle, $sText, $sRegVal, $iDefault = -1, $hParent = 0)

	Local $Ret = DllCall('shlwapi.dll', 'int', 'SHMessageBoxCheckW', 'hwnd', $hParent, 'wstr', $sText, 'wstr', $sTitle, 'uint', $iType, 'int', $iDefault, 'wstr', $sRegVal)

	If @error Then
		MsgBox(0, '', @error)
		Return SetError(1, 0, -1)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_MessageBoxCheck

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_MoveFileEx
; Description....: Moves a file or directory, notifying the application of its progress through a callback function.
; Syntax.........: _WinAPI_MoveFileEx ( $sExistingFile, $sNewFile [, $iFlags [, $pProgressProc [, $pData] )
; Parameters.....: $sExistingFile - The name of the existing file or directory on the local computer.
;
;                                   If $iFlags specifies $MOVE_FILE_DELAY_UNTIL_REBOOT, the file cannot exist on a remote share
;                                   because delayed operations are performed before the network is available.
;
;                  $sNewFile      - The new name of the file or directory on the local computer.
;
;                                   When moving a file, $sNewFile can be on a different file system or volume. If $sNewFile is
;                                   on another drive, you must set the  $MOVE_FILE_COPY_ALLOWED flag in $iFlags parameter.
;
;                                   When moving a directory, $sExistingFile and $sNewFile  must be on the same drive.
;
;                                   If $iFlags specifies $MOVE_FILE_DELAY_UNTIL_REBOOT and $sNewFile is 0, _WinAPI_MoveFileEx()
;                                   registers $sExistingFile to be deleted when the system restarts. If $sExistingFile refers to
;                                   a directory, the system removes the directory at restart only if the directory is empty.
;
;                  $iFlags        - The move options. This parameter can be one or more of the following values.
;
;                                   $MOVE_FILE_COPY_ALLOWED
;                                   $MOVE_FILE_CREATE_HARDLINK
;                                   $MOVE_FILE_DELAY_UNTIL_REBOOT
;                                   $MOVE_FILE_FAIL_IF_NOT_TRACKABLE
;                                   $MOVE_FILE_REPLACE_EXISTING
;                                   $MOVE_FILE_WRITE_THROUGH
;
;                  $pProgressProc - The address of a callback function that is called each time another portion of the file
;                                   has been moved.
;
;                                   (See MSDN for more information)
;
;                  $pData         - The argument to be passed to the callback function.
; Return values..: Success        - 1.
;                  Failure        - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: If the $iFlags parameter specifies $MOVE_FILE_DELAY_UNTIL_REBOOT, _WinAPI_MoveFileEx() fails if it cannot
;                  access the registry. The function stores the locations of the files to be renamed at restart in the
;                  following registry value:
;
;                  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\PendingFileRenameOperations
;
; Related........:
; Link...........: @@MsdnLink@@ MoveFileWithProgress
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_MoveFileEx($sExistingFile, $sNewFile, $iFlags = 0, $pProgressProc = 0, $pData = 0)

	Local $TypeOfNewFile = 'wstr'

	If Not StringStripWS($sNewFile, 3) Then
		$TypeOfNewFile = 'ptr'
		$sNewFile = 0
	EndIf

	Local $Ret = DllCall('kernel32.dll', 'int', 'MoveFileWithProgressW', 'wstr', $sExistingFile, $TypeOfNewFile, $sNewFile, 'ptr', $pProgressProc, 'ptr', $pData, 'dword', $iFlags)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_MoveFileEx

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_OemToChar
; Description....: Converts a string from the OEM-defined character set into either an ANSI string.
; Syntax.........: _WinAPI_OemToChar ( $sStr )
; Parameters.....: $sStr   - The string of characters from the OEM-defined character set.
; Return values..: Success - The converted string.
;                  Failure - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ OemToChar
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_OemToChar($sStr)

	Local $tData = DllStructCreate('char[' & StringLen($sStr) + 1 & ']')
	Local $Ret = DllCall('user32.dll', 'int', 'OemToChar', 'str', $sStr, 'ptr', DllStructGetPtr($tData))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, '')
	EndIf
	Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_OemToChar

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_OffsetClipRgn
; Description....: Moves the clipping region of a device context by the specified offsets.
; Syntax.........: _WinAPI_OffsetClipRgn ( $hDC, $iXOffset, $iYOffset )
; Parameters.....: $hDC      - Handle to the device context.
;                  $iXOffset - The number of logical units to move left or right.
;                  $iYOffset - The number of logical units to move up or down.
; Return values..: Success   - The value that specifies the new clipping region's complexity; it can be one of the following values.
;
;                              $COMPLEXREGION
;                              $NULLREGION
;                              $SIMPLEREGION
;
;                  Failure   - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ OffsetClipRgn
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_OffsetClipRgn($hDC, $iXOffset, $iYOffset)

	Local $Ret = DllCall('gdi32.dll', 'int', 'OffsetClipRgn', 'hwnd', $hDC, 'int', $iXOffset, 'int', $iYOffset)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_OffsetClipRgn

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_OffsetRect
; Description....: Moves the specified rectangle by the specified offsets.
; Syntax.........: _WinAPI_OffsetRect ( ByRef $tRECT, $DX, $DY )
; Parameters.....: $tRECT  - $tagRECT structure that to be moved.
;                  $DX     - The amount to move the rectangle left (negative value) or right.
;                  $DY     - The amount to move the rectangle up (negative value) or down.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ OffsetRect
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_OffsetRect(ByRef $tRECT, $DX, $DY)

	Local $Ret = DllCall('user32.dll', 'int', 'OffsetRect', 'ptr', DllStructGetPtr($tRECT), 'int', $DX, 'int', $DY)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_OffsetRect

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_OffsetRgn
; Description....: Moves a region by the specified offsets.
; Syntax.........: _WinAPI_OffsetRgn ( $hRgn, $iXOffset, $iYOffset )
; Parameters.....: $hRgn     - Handle to the region to be moved.
;                  $iXOffset - The number of logical units to move left or right.
;                  $iYOffset - The number of logical units to move up or down.
; Return values..: Success   - The value that specifies the new clipping region's complexity; it can be one of the following values.
;
;                              $COMPLEXREGION
;                              $NULLREGION
;                              $SIMPLEREGION
;
;                  Failure   - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ OffsetRgn
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_OffsetRgn($hRgn, $iXOffset, $iYOffset)

	Local $Ret = DllCall('gdi32.dll', 'int', 'OffsetRgn', 'ptr', $hRgn, 'int', $iXOffset, 'int', $iYOffset)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_OffsetRgn

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_OpenIcon
; Description....: Restores a minimized (iconic) window to its previous size and position and activates the window.
; Syntax.........: _WinAPI_OpenIcon ( $hWnd )
; Parameters.....: $hWnd   - Handle to the window to be restored and activated.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ OpenIcon
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_OpenIcon($hWnd)

	Local $Ret = DllCall('user32.dll', 'int', 'OpenIcon', 'hwnd', $hWnd)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_OpenIcon

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_OpenJobObject
; Description....: Opens an existing job object.
; Syntax.........: _WinAPI_OpenJobObject ( $sName [, $iAccess [, $fInheritHandles] )
; Parameters.....: $sName           - The name of the job to be opened. Name comparisons are case sensitive.
;                  $iAccess         - The access to the job object. This parameter can be one or more of the following values.
;
;                                     $JOB_OBJECT_ALL_ACCESS
;                                     $JOB_OBJECT_ASSIGN_PROCESS
;                                     $JOB_OBJECT_QUERY
;                                     $JOB_OBJECT_SET_ATTRIBUTES
;                                     $JOB_OBJECT_SET_SECURITY_ATTRIBUTES
;                                     $JOB_OBJECT_TERMINATE
;
;                  $fInheritHandles - Specifies whether inherites the handle by a processes, valid values:
;                  |TRUE            - The processes created by this process will inherit the handle.
;                  |FALSE           - The processes do not inherit this handle. (Default)
; Return values..: Success          - Handle to the job object.
;                  Failure          - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ OpenJobObject
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_OpenJobObject($sName, $iAccess = 0x001F001F, $fInheritHandles = 0)

	Local $Ret = DllCall('kernel32.dll', 'ptr', 'OpenJobObjectW', 'dword', $iAccess, 'int', $fInheritHandles, 'wstr', $sName)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_OpenJobObject

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_OpenProcessToken
; Description....: Opens the access token associated with a process.
; Syntax.........: _WinAPI_OpenProcessToken ( $iAccess [, $hProcess] )
; Parameters.....: $iAccess  - Access mask that specifies the requested types of access to the access token. This parameter can be
;                              one or more of the following values.
;
;                              $TOKEN_ADJUST_DEFAULT
;                              $TOKEN_ADJUST_GROUPS
;                              $TOKEN_ADJUST_PRIVILEGES
;                              $TOKEN_ADJUST_SESSIONID
;                              $TOKEN_ASSIGN_PRIMARY
;                              $TOKEN_DUPLICATE
;                              $TOKEN_EXECUTE
;                              $TOKEN_IMPERSONATE
;                              $TOKEN_QUERY
;                              $TOKEN_QUERY_SOURCE
;                              $TOKEN_READ
;                              $TOKEN_WRITE
;                              $TOKEN_ALL_ACCESS
;
;                  $hProcess - Handle to the process whose access token is opened. The process must have the
;                              $PROCESS_QUERY_INFORMATION access permission. If this parameter is 0, will use the current process.
; Return values..: Success   - Handle that identifies the newly opened access token.
;                  Failure   - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: Close the access token handle returned through this function by calling _WinAPI_FreeHandle().
; Related........:
; Link...........: @@MsdnLink@@ OpenProcessToken
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_OpenProcessToken($iAccess, $hProcess = 0)

	If Not $hProcess Then
		$hProcess = _WinAPI_GetCurrentProcess()
	EndIf

	Local $Ret = DllCall('advapi32.dll', 'int', 'OpenProcessToken', 'ptr', $hProcess, 'dword', $iAccess, 'ptr*', 0)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[3]
EndFunc   ;==>_WinAPI_OpenProcessToken

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_OpenSemaphore
; Description....: Opens an existing named semaphore object.
; Syntax.........: _WinAPI_OpenSemaphore ( $sSemaphore [, $iAccess] )
; Parameters.....: $sSemaphore - The name of the semaphore to be opened. Name comparisons are case sensitive.
;                  $iAccess    - The access to the semaphore object. The function fails if the security descriptor of the specified
;                                object does not permit the requested access for the calling process. This parameter can be one of
;                                the following values.
;
;                                $SEMAPHORE_ALL_ACCESS
;                                $SEMAPHORE_MODIFY_STATE
;
; Return values..: Success     - The handle to the semaphore object.
;                  Failure     - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The function succeeds only if some process has already created the semaphore by using the _WinAPI_CreateSemaphore()
;                  function. The calling process can use the returned handle in any function that requires a handle to
;                  a semaphore object
; Related........:
; Link...........: @@MsdnLink@@ OpenSemaphore
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_OpenSemaphore($sSemaphore, $iAccess = 0x00100000)

	Local $Ret = DllCall('kernel32.dll', 'ptr', 'OpenSemaphoreW', 'dword', $iAccess, 'int', 0, 'wstr', $sSemaphore)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_OpenSemaphore

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_OpenThemeData
; Description....: Opens the theme data for a window and its associated class.
; Syntax.........: _WinAPI_OpenThemeData ( $hWnd, $sClass )
; Parameters.....: $hWnd   - Handle of the window for which theme data is required.
;                  $sClass - The string that contains a semicolon-separated list of classes. This parameter may contain a list,
;                            not just a single name, to provide the class an opportunity to get the best match between the
;                            class and the current visual style.
; Return values..: Success - The handle to the theme.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ OpenThemeData
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_OpenThemeData($hWnd, $sClass)

	Local $Ret = DllCall('uxtheme.dll', 'ptr', 'OpenThemeData', 'hwnd', $hWnd, 'wstr', $sClass)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_OpenThemeData

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PaintRgn
; Description....: Paints the specified region by using the brush currently selected into the device context.
; Syntax.........: _WinAPI_PaintRgn ( $hDC, $hRgn )
; Parameters.....: $hDC    - Handle to the device context.
;                  $hRgn   - Handle to the region to be filled. The region's coordinates are presumed to be logical coordinates.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ PaintRgn
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PaintRgn($hDC, $hRgn)

	Local $Ret = DllCall('gdi32.dll', 'int', 'PaintRgn', 'hwnd', $hDC, 'ptr', $hRgn)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_PaintRgn

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PatBlt
; Description....: Paints the specified rectangle using the brush that is currently selected into the specified device context.
; Syntax.........: _WinAPI_PatBlt ( $hDC, $iX, $iY, $iWidth, $iHeight, $iRop )
; Parameters.....: $hDC     - Handle to the device context.
;                  $iX      - The x-coordinate, in logical units, of the upper-left corner of the rectangle to be filled.
;                  $iY      - The y-coordinate, in logical units, of the upper-left corner of the rectangle to be filled.
;                  $iWidth  - The width, in logical units, of the rectangle.
;                  $iHeight - The height, in logical units, of the rectangle.
;                  $iRop    - The raster operation code. This code can be one of the following values.
;
;                             $BLACKNESS
;                             $DSTINVERT
;                             $PATCOPY
;                             $PATINVERT
;                             $WHITENESS
;
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ PatBlt
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PatBlt($hDC, $iX, $iY, $iWidth, $iHeight, $iRop)

	Local $Ret  = DllCall('gdi32.dll', 'int', 'PatBlt', 'hwnd', $hDC, 'int', $iX, 'int', $iY, 'int', $iWidth, 'int', $iHeight, 'dword', $iRop)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_PatBlt

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PathCompactPath
; Description....: Truncates a file path to fit within a given pixel width by replacing path components with ellipses.
; Syntax.........: _WinAPI_PathCompactPath ( $hWnd, $sPath [, $iWidth] )
; Parameters.....: $hWnd   - Handle to the window used for font metrics.
;                  $sPath  - The path to be modified.
;                  $iWidth - The width, in pixels, in which the string must fit. If this parameter is (-1), width will be equal to
;                            the width of the window.
; Return values..: Success - The modified path.
;                  Failure - The original $sPath parameter and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function will not compact the path beyond the base file name preceded by ellipses.
; Related........:
; Link...........: @@MsdnLink@@ PathCompactPath
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PathCompactPath($hWnd, $sPath, $iWidth = -1)

	Local $hDC, $hBack, $tPath = DllStructCreate('wchar[' & (StringLen($sPath) + 1) & ']')
	Local $Ret

	If $iWidth < 0 Then
		$iWidth = _WinAPI_GetWindowWidth($hWnd)
	EndIf
	$Ret = DllCall('user32.dll', 'hwnd', 'GetDC', 'hwnd', $hWnd)
	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, $sPath)
	EndIf
	$hDC = $Ret[0]
	$Ret = DllCall('user32.dll', 'ptr', 'SendMessage', 'hwnd', $hWnd, 'uint', 0x0031, 'int', 0, 'int', 0)
	$hBack = _WinAPI_SelectObject($hDC, $Ret[0])
	DllStructSetData($tPath, 1, $sPath)
	$Ret = DllCall('shlwapi.dll', 'int', 'PathCompactPathW', 'hwnd', $hDC, 'ptr', DllStructGetPtr($tPath), 'int', $iWidth)
	If (@error) Or (Not $Ret[0]) Then
		$Ret = 0
	EndIf
	_WinAPI_SelectObject($hDC, $hBack)
	_WinAPI_ReleaseDC($hWnd, $hDC)
	If Not IsArray($Ret) Then
		Return SetError(1, 0, $sPath)
	EndIf
	Return DllStructGetData($tPath, 1)
EndFunc   ;==>_WinAPI_PathCompactPath

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PathFindExtension
; Description....: Searches a path for an extension.
; Syntax.........: _WinAPI_PathFindExtension ( $sPath )
; Parameters.....: $sPath  - The path to search, including the extension being searched for.
; Return values..: Success - The string that contains the extension.
;                  Failure - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ PathFindExtension
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PathFindExtension($sPath)

	Local $tData = DllStructCreate('wchar[1024]')

	DllStructSetData($tData, 1, $sPath)

	Local $Ret = DllCall('shlwapi.dll', 'int', 'PathFindExtensionW', 'ptr', DllStructGetPtr($tData))

	If @error Then
		Return SetError(1, 0, '')
	EndIf

	Local $tResult = DllStructCreate('wchar[1024]', $Ret[0])

	Return DllStructGetData($tResult, 1)
EndFunc   ;==>_WinAPI_PathFindExtension

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PathFindFileName
; Description....: Searches a path for a file name.
; Syntax.........: _WinAPI_PathFindFileName ( $sPath )
; Parameters.....: $sPath  - The path to search.
; Return values..: Success - The string that contains the filename.
;                  Failure - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ PathFindFileName
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PathFindFileName($sPath)

	Local $tData = DllStructCreate('wchar[1024]')

	DllStructSetData($tData, 1, $sPath)

	Local $Ret = DllCall('shlwapi.dll', 'int', 'PathFindFileNameW', 'ptr', DllStructGetPtr($tData))

	If @error Then
		Return SetError(1, 0, '')
	EndIf

	Local $tResult = DllStructCreate('wchar[1024]', $Ret[0])

	Return DllStructGetData($tResult, 1)
EndFunc   ;==>_WinAPI_PathFindFileName

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PathFindNextComponent
; Description....: Parses a path and returns the portion of that path that follows the first backslash.
; Syntax.........: _WinAPI_PathFindNextComponent ( $sPath )
; Parameters.....: $sPath  - The path to parse. Path components are delimited by backslashes. For instance, the path
;                            "c:\path1\path2\file.txt" has four components: c:, path1, path2, and file.txt.
; Return values..: Success - The truncated path.
;                  Failure - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function walks a path string until it encounters a backslash ("\"), ignores everything up to that point
;                  including the backslash, and returns the rest of the path. Therefore, if a path begins with a backslash (such as \path1\path2),
;                  the function simply removes the initial backslash and returns the rest (path1\path2).
; Related........:
; Link...........: @@MsdnLink@@ PathFindNextComponent
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PathFindNextComponent($sPath)

	Local $tData = DllStructCreate('wchar[1024]')

	DllStructSetData($tData, 1, $sPath)

	Local $Ret = DllCall('shlwapi.dll', 'int', 'PathFindNextComponentW', 'ptr', DllStructGetPtr($tData))

	If @error Then
		Return SetError(1, 0, '')
	EndIf
	If Not $Ret[0] Then
		Return ''
	EndIf

	Local $tResult = DllStructCreate('wchar[1024]', $Ret[0])

	Return DllStructGetData($tResult, 1)
EndFunc   ;==>_WinAPI_PathFindNextComponent

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PathFindOnPath
; Description....: Searches for a file.
; Syntax.........: _WinAPI_PathFindOnPath ( $sFile [, $aDirs [, $iStart [, $iEnd]]] )
; Parameters.....: $sFile  - The file name for which to search.
;                  $aDirs  - The array of directories to be searched first. If this parameter is not an array, function attempts to
;                            find the file by searching standard directories such as System32 and the directories specified in the
;                            PATH environment variable.
;                  $iStart - The index of array to start searching at.
;                  $iEnd   - The index of array to stop searching at.
; Return values..: Success - The fully qualified path.
;                  Failure - The original $sFile parameter and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ PathFindOnPath
; Example........: Yes
; ===============================================================================================================================

#cs

Func _WinAPI_PathFindOnPath($sFile, $aDirs = 0, $iStart = 0, $iEnd = -1)

	Local $Count, $tPtrs = 0, $tDirs, $sDirs = ''

	If IsArray($aDirs) Then
		If $iStart < 0 Then
			$iStart = 0
		EndIf
		If ($iEnd < 0) Or ($iEnd > UBound($aDirs) - 1) Then
			$iEnd = UBound($aDirs) - 1
		EndIf
		For $i = $iStart To $iEnd
			$sDirs &= 'wchar[' & (StringLen($aDirs[$i]) + 1) & '];'
		Next
		$tDirs = DllStructCreate($sDirs)
		If Not @error Then
			$tPtrs = DllStructCreate('ptr[' & ($iEnd - $iStart + 2) & ']')
			$Count = 1
			For $i = $iStart To $iEnd
				DLLStructSetData($tDirs, $Count, $aDirs[$i])
				DLLStructSetData($tPtrs, 1, DLLStructGetPtr($tDirs, $Count), $Count)
				$Count += 1
			Next
			DLLStructSetData($tPtrs, 1, Ptr(0), $Count)
		EndIf
	EndIf

	Local $tPath = DllStructCreate('wchar[1024]')

	DllStructSetData($tPath, 1, $sFile)

	Local $Ret = DllCall('shlwapi.dll', 'int', 'PathFindOnPathW', 'ptr', DllStructGetPtr($tPath), 'ptr', DllStructGetPtr($tPtrs))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, $sFile)
	EndIf
	Return DllStructGetData($tPath, 1)
EndFunc   ;==>_WinAPI_PathFindOnPath

#ce

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PathGetArgs
; Description....: Finds the command line arguments within a given path.
; Syntax.........: _WinAPI_PathGetArgs ( $sPath )
; Parameters.....: $sPath  - The path to be searched.
; Return values..: Success - The string that contains the arguments portion of the path if successful.
;                  Failure - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function should not be used on generic command path templates (from users or the registry), but rather
;                  should be used only on templates that the application knows to be well formed.
; Related........:
; Link...........: @@MsdnLink@@ PathGetArgs
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PathGetArgs($sPath)

	Local $tData = DllStructCreate('wchar[1024]')

	DllStructSetData($tData, 1, $sPath)

	Local $Ret = DllCall('shlwapi.dll', 'int', 'PathGetArgsW', 'ptr', DllStructGetPtr($tData))

	If @error Then
		Return SetError(1, 0, '')
	Else
		If Not $Ret[0] Then
			Return ''
		EndIf
	EndIf

	Local $tResult = DllStructCreate('wchar[1024]', $Ret[0])

	Return DllStructGetData($tResult, 1)
EndFunc   ;==>_WinAPI_PathGetArgs

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PathGetCharType
; Description....: Determines the type of character in relation to a path.
; Syntax.........: _WinAPI_PathGetCharType ( $sChar )
; Parameters.....: $sChar  - The character for which to determine the type.
; Return values..: Success - Returns one or more of the following values that define the type of character.
;
;                            $GCT_INVALID
;                            $GCT_LFNCHAR
;                            $GCT_SEPARATOR
;                            $GCT_SHORTCHAR
;                            $GCT_WILD
;
;                  Failure - (-1) and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ PathGetCharType
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PathGetCharType($sChar)

	Local $Ret = DllCall('shlwapi.dll', 'int', 'PathGetCharTypeW', 'dword', AscW($sChar))

	If @error Then
		Return SetError(1, 0, -1)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_PathGetCharType

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PathGetDriveNumber
; Description....: Searches a path for a drive letter within the range of 'A' to 'Z' and returns the corresponding drive number.
; Syntax.........: _WinAPI_PathGetDriveNumber ( $sPath )
; Parameters.....: $sPath  - The path to be searched.
; Return values..: Success - The string that contains the drive letter (A:, B:, etc).
;                  Failure - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ PathGetDriveNumber
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PathGetDriveNumber($sPath)

	Local $Ret = DllCall('shlwapi.dll', 'int', 'PathGetDriveNumberW', 'wstr', $sPath)

	If (@error) Or ($Ret[0] < 0) Then
		Return SetError(1, 0, '')
	EndIf
	Return Chr($Ret[0] + 65) & ':'
EndFunc   ;==>_WinAPI_PathGetDriveNumber

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PathIsExe
; Description....: Determines whether a file is an executable by examining the file extension.
; Syntax.........: _WinAPI_PathIsExe ( $sPath )
; Parameters.....: $sPath  - The path to be searched.
; Return values..: Success - 1 - The file extension is .cmd, .bat, .pif, .scf, .exe, .com, or .scr.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ PathIsExe
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PathIsExe($sPath)

	Local $Ret = DllCall('shell32.dll', 'int', 'PathIsExe', 'wstr', $sPath)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_PathIsExe

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PathIsDirectory
; Description....: Verifies that a path is a valid directory.
; Syntax.........: _WinAPI_PathIsDirectory ( $sPath )
; Parameters.....: $sPath  - The path to verify.
; Return values..: Success - 1 - The path is a valid directory.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ PathIsDirectory
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PathIsDirectory($sPath)

	Local $Ret = DllCall('shlwapi.dll', 'int', 'PathIsDirectoryW', 'wstr', $sPath)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_PathIsDirectory

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PathIsDirectoryEmpty
; Description....: Determines whether a specified path is an empty directory.
; Syntax.........: _WinAPI_PathIsDirectoryEmpty ( $sPath )
; Parameters.....: $sPath  - The path to be tested.
; Return values..: Success - 1 - The path is an empty directory.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ PathIsDirectoryEmpty
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PathIsDirectoryEmpty($sPath)

	Local $Ret = DllCall('shlwapi.dll', 'int', 'PathIsDirectoryEmptyW', 'wstr', $sPath)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_PathIsDirectoryEmpty

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PathIsFileSpec
; Description....: Searches a path for any path-delimiting characters.
; Syntax.........: _WinAPI_PathIsFileSpec ( $sPath )
; Parameters.....: $sPath  - The path to be searched.
; Return values..: Success - 1 - There are no path-delimiting characters (":" or "\") within the path.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ PathIsFileSpec
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PathIsFileSpec($sPath)

	Local $Ret = DllCall('shlwapi.dll', 'int', 'PathIsFileSpecW', 'wstr', $sPath)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_PathIsFileSpec

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PathIsRelative
; Description....: Searches a path and determines if it is relative.
; Syntax.........: _WinAPI_PathIsRelative ( $sPath )
; Parameters.....: $sPath  - The path to be searched.
; Return values..: Success - 1 - The path is relative.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ PathIsRelative
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PathIsRelative($sPath)

	Local $Ret = DllCall('shlwapi.dll', 'int', 'PathIsRelativeW', 'wstr', $sPath)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_PathIsRelative

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PathIsSameRoot
; Description....: Compares two paths to determine if they have a common root component.
; Syntax.........: _WinAPI_PathIsSameRoot ( $sPath1, $sPath2 )
; Parameters.....: $sPath1 - The first path to be compared.
;                  $sPath2 - The second path to be compared.
; Return values..: Success - 1 - Both strings have the same root component.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ PathIsSameRoot
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PathIsSameRoot($sPath1, $sPath2)

	Local $Ret = DllCall('shlwapi.dll', 'int', 'PathIsSameRootW', 'wstr', $sPath1, 'wstr', $sPath2)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_PathIsSameRoot

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PathMatchSpec
; Description....: Searches a string using a Microsoft MS-DOS wild card match type.
; Syntax.........: _WinAPI_PathMatchSpec ( $sPath, $sSpec )
; Parameters.....: $sPath  - The path to be searched.
;                  $sSpec  - The file type for which to search. For example, to test whether $sPath is a .doc file,
;                            $sSpec should be set to "*.doc".
; Return values..: Success - 1 - The string matches.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ PathMatchSpec
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PathMatchSpec($sPath, $sSpec)

	Local $Ret = DllCall('shlwapi.dll', 'int', 'PathMatchSpecW', 'wstr', $sPath, 'wstr', $sSpec)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_PathMatchSpec

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PathRenameExtension
; Description....: Replaces the extension of a file name with a new extension.
; Syntax.........: _WinAPI_PathRenameExtension ( $sPath, $sExt )
; Parameters.....: $sPath  - The path in which to replace the extension.
;                  $sExt   - The string that contains a "." character followed by the new extension.
; Return values..: Success - The path with new extension.
;                  Failure - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: If the file name does not contain an extension, the extension will be attached to the end of the string.
; Related........:
; Link...........: @@MsdnLink@@ PathRenameExtension
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PathRenameExtension($sPath, $sExt)

	Local $tData = DllStructCreate('wchar[1024]')

	DllStructSetData($tData, 1, $sPath)

	Local $Ret = DllCall('shlwapi.dll', 'int', 'PathRenameExtensionW', 'ptr', DllStructGetPtr($tData), 'wstr', $sExt)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, '')
	EndIf
	Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_PathRenameExtension

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PathSearchAndQualify
; Description....: Formats a path to the fully qualified path.
; Syntax.........: _WinAPI_PathSearchAndQualify ( $sPath )
; Parameters.....: $sPath  - The path to be formated.
; Return values..: Success - The formated path.
;                  Failure - The original $sPath parameter and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ PathSearchAndQualify
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PathSearchAndQualify($sPath)

	Local $tPath = DllStructCreate('wchar[1024]')
	Local $Ret = DllCall('shlwapi.dll', 'int', 'PathSearchAndQualifyW', 'wstr', StringStripWS($sPath, 7), 'ptr', DllStructGetPtr($tPath), 'int', 1024)

	If @error Then
		Return SetError(1, 0, $sPath)
	EndIf
	Return DllStructGetData($tPath, 1)
EndFunc   ;==>_WinAPI_PathSearchAndQualify

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PathUnExpandEnvStrings
; Description....: Replaces folder names in a fully-qualified path with their associated environment string.
; Syntax.........: _WinAPI_PathUnExpandEnvStrings ( $sPath )
; Parameters.....: $sPath  - The path to be unexpanded.
; Return values..: Success - The unexpanded string.
;                  Failure - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ PathUnExpandEnvStrings
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PathUnExpandEnvStrings($sPath)

	Local $tData = DllStructCreate('wchar[1024]')
	Local $Ret = DllCall('shlwapi.dll', 'int', 'PathUnExpandEnvStringsW', 'wstr', $sPath, 'ptr', DllStructGetPtr($tData), 'uint', 1024)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, '')
	EndIf
	Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_PathUnExpandEnvStrings

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PathYetAnotherMakeUniqueName
; Description....: Creates a unique filename based on an existing filename.
; Syntax.........: _WinAPI_PathYetAnotherMakeUniqueName ( $sPath )
; Parameters.....: $sPath  - The file name that the unique name will be based on.
; Return values..: Success - 1.
;                  Failure - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ PathYetAnotherMakeUniqueName
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PathYetAnotherMakeUniqueName($sPath)

	Local $tData = DllStructCreate('wchar[1024]')
	Local $Ret = DllCall('shell32.dll', 'int', 'PathYetAnotherMakeUniqueName', 'ptr', DllStructGetPtr($tData), 'wstr', $sPath, 'ptr', 0, 'ptr', 0)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, '')
	EndIf
	Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_PathYetAnotherMakeUniqueName

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PickIconDlg
; Description....: Displays a dialog box that allows the user to choose an icon.
; Syntax.........: _WinAPI_PickIconDlg ( [$sIcon [, $iIndex [, $hParent]]] )
; Parameters.....: $sIcon   - The fully-qualified path of the file that contains the initial icon.
;                  $iIndex  - The index of the initial icon.
;                  $hParent - Handle of the parent window.
; Return values..: Success  - The array containing the following parameters:
;
;                             [0] - The path of the file that contains the selected icon.
;                             [1] - The index of the selected icon.
;
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function also sets the @error flag to 1 if the icon was not selected.
; Related........:
; Link...........: @@MsdnLink@@ PickIconDlg
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PickIconDlg($sIcon = '', $iIndex = 0, $hParent = 0)

	Local $tIcon = DllStructCreate('wchar[1024]'), $tIndex = DllStructCreate('int')
	Local $Ret, $Error = 1, $Result[2] = [$sIcon, $iIndex]

	DllStructSetData($tIcon, 1, $sIcon)
	DllStructSetData($tIndex, 1, $iIndex)
	$Ret = DllCall('shell32.dll', 'int', 'PickIconDlg', 'hwnd', $hParent, 'ptr', DllStructGetPtr($tIcon), 'int', 1024, 'ptr', DllStructGetPtr($tIndex))
	If (Not @error) And ($Ret[0]) Then
		$Ret = DllCall('kernel32.dll', 'int', 'ExpandEnvironmentStringsW', 'wstr', DllStructGetData($tIcon, 1), 'ptr', DllStructGetPtr($tIcon), 'int', 1024)
		If (Not @error) And ($Ret[0]) Then
			$Result[0] = DllStructGetData($tIcon, 1)
			$Result[1] = DllStructGetData($tIndex, 1)
			$Error = 0
		EndIf
	EndIf
	Return SetError($Error, 0, $Result)
EndFunc   ;==>_WinAPI_PickIconDlg

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PlaySound
; Description....: Plays a sound specified by the given file name, resource, or system event.
; Syntax.........: _WinAPI_PlaySound ( $sSound, $iFlags [, $hInstance] )
; Parameters.....: $sSound    - The string that specifies the sound to play. The maximum length is 255 characters. If $sSound is
;                               empty, any currently playing waveform sound is stopped.
;                  $iFlags    - The flags for sound playing. This parameter can be one or more of the following values.
;
;                               $SND_APPLICATION
;                               $SND_ALIAS
;                               $SND_ALIAS_ID
;                               $SND_ASYNC
;                               $SND_FILENAME
;                               $SND_LOOP
;                               $SND_MEMORY
;                               $SND_NODEFAULT
;                               $SND_NOSTOP
;                               $SND_NOWAIT
;                               $SND_PURGE
;                               $SND_RESOURCE
;                               $SND_SYNC
;
;                               Three flags ($SND_ALIAS, $SND_FILENAME, and $SND_RESOURCE) determine whether the name is interpreted
;                               as an alias for a system event, a file name, or a resource identifier. If none of these flags are
;                               specified, _WinAPI_PlaySound() searches the registry or the WIN.INI file for an association with
;                               the specified sound name. If an association is found, the sound event is played. If no association
;                               is found in the registry, the name is interpreted as a file name.
;
;                               If the $SND_ALIAS_ID flag is specified in $iFlags, the $sSound parameter must be one of the
;                               $SND_ALIAS_... values.
;
;                               (See MSDN for more information)
;
;                  $hInstance - Handle to the executable file that contains the resource to be loaded. If $iFlags does not
;                               contain the $SND_RESOURCE, this parameter will be ignored.
; Return values..: Success    - 1.
;                  Failure    - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ PlaySound
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PlaySound($sSound, $iFlags, $hInstance = 0)

	Local $TypeOfSound = 'ptr'


	If Not BitAND($iFlags, $SND_MEMORY) Then
		$sSound = StringStripWS($sSound, 3)
		If Not $sSound Then
			$sSound = 0
		Else
			$TypeOfSound = 'wstr'
			If (BitAND($iFlags, $SND_RESOURCE)) And (StringIsDigit($sSound)) Then
				$sSound = '#' & $sSound
			EndIf
		EndIf
	EndIf

	Local $Ret = DllCall('winmm.dll', 'int', 'PlaySoundW', $TypeOfSound, $sSound, 'ptr', $hInstance, 'dword', $iFlags)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_PlaySound

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_Polygon
; Description....: Draws a polygon consisting of two or more vertices connected by straight lines.
; Syntax.........: _WinAPI_Polygon ( $hDC,  $aPoint [, $iStart [, $iEnd]] )
; Parameters.....: $dDC    - Handle to the device context.
;                  $aPoint - The 2D array ([x1, y1], [x2, y2], ... [xN, yN]) that contains the vertices of the polygon in logical
;                            units. The polygon is closed automatically by drawing a line from the last vertex to the first.
;                  $iStart - The index of array to start creating at.
;                  $iEnd   - The index of array to stop creating at.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The polygon is outlined by using the current pen and filled by using the current brush and polygon fill mode.
; Related........:
; Link...........: @@MsdnLink@@ Polygon
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_Polygon($hDC, $aPoint, $iStart = 0, $iEnd = -1)

	If UBound($aPoint, 2) < 2  Then
		Return SetError(2, 0, 0)
	EndIf

	Local $Count, $tData, $Struct = ''

	If $iStart < 0 Then
		$iStart = 0
	EndIf
	If ($iEnd < 0) Or ($iEnd > UBound($aPoint) - 1) Then
		$iEnd = UBound($aPoint) - 1
	EndIf
	For $i = $iStart To $iEnd
		$Struct &= 'int[2];'
	Next
	$tData = DllStructCreate($Struct)
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	$Count = 1
	For $i = $iStart To $iEnd
		For $j = 0 To 1
			DllStructSetData($tData, $Count, $aPoint[$i][$j], $j + 1)
		Next
		$Count += 1
	Next

	Local $Ret = DllCall('gdi32.dll', 'ptr', 'Polygon', 'hwnd', $hDC, 'ptr', DllStructGetPtr($tData), 'int', $Count - 1)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_Polygon

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PrintWindow
; Description....: Copies a visual window into the specified device context.
; Syntax.........: _WinAPI_PrintWindow ( $hWnd, $hDC [, $fClient] )
; Parameters.....: $hWnd    - Handle to the window that will be copied.
;                  $hDC     - Handle to the device context.
;                  $fClient - Specifies whether copies only the client area of the window, valid values:
;                  |TRUE    - Only the client area of the window is copied to device context.
;                  |FALSE   - The entire window is copied. (Default)
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ PrintWindow
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PrintWindow($hWnd, $hDC, $fClient = 0)

	Local $Ret = DllCall('user32.dll', 'int', 'PrintWindow', 'hwnd', $hWnd, 'hwnd', $hDC, 'uint', $fClient)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_PrintWindow

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PrivateExtractIcon
; Description....: Extracts the icon with the specified dimension from the specified file.
; Syntax.........: _WinAPI_PrivateExtractIcon ( $sIcon, $iIndex, $iWidth, $iHeight )
; Parameters.....: $sIcon   - Path and name of the file from which the icon are to be extracted.
;                  $iIndex  - Index of the icon to extract.
;                  $iWidth  - Horizontal icon size wanted.
;                  $iHeight - Vertical icon size wanted.
; Return values..: Success  - Handle to the extracted icon.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: If the icon with the specified dimension is not found in the file, it will choose the nearest appropriate icon and
;                  change to the specified dimension. When you are finished using the icon, destroy it using the _WinAPI_FreeIcon()
;                  function.
; Related........:
; Link...........: @@MsdnLink@@ PrivateExtractIcons
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PrivateExtractIcon($sIcon, $iIndex, $iWidth, $iHeight)

	Local $Ret = DllCall('user32.dll', 'int', 'PrivateExtractIconsW', 'wstr', $sIcon, 'int', $iIndex, 'int', $iWidth, 'int', $iHeight, 'ptr*', 0, 'ptr*', 0, 'int', 1, 'int', 0)

	If (@error) Or (Not $Ret[0]) Or (Not $Ret[5]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[5]
EndFunc   ;==>_WinAPI_PrivateExtractIcon

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PtInRectEx
; Description....: Determines whether the specified point lies within the specified rectangle.
; Syntax.........: _WinAPI_PtInRectEx ( $iX, $iY, $iLeft, $iTop, $iRight, $iBottom )
; Parameters.....: $iX      - The x-coordinate of the point.
;                  $iY      - The y-coordinate of the point.
;                  $iLeft   - The x-coordinate of the upper-left corner of the rectangle.
;                  $iTop    - The y-coordinate of the upper-left corner of the rectangle.
;                  $iRight  - The x-coordinate of the lower-right corner of the rectangle.
;                  $iBottom - The y-coordinate of the lower-right corner of the rectangle.
; Return values..: Success  - 1 - The specified point lies within the rectangle.
;                             0 - Otherwise.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ PtInRect
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PtInRectEx($iX, $iY, $iLeft, $iTop, $iRight, $iBottom)

	Local $tRECT = DllStructCreate($tagRECT)

	DllStructSetData($tRECT, 1, $iLeft)
	DllStructSetData($tRECT, 2, $iTop)
	DllStructSetData($tRECT, 3, $iRight)
	DllStructSetData($tRECT, 4, $iBottom)

	Local $Ret = DllCall('user32.dll', 'int', 'PtInRect', 'ptr', DllStructGetPtr($tRECT), 'int', $iX, 'int', $iY)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_PtInRectEx

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_PtInRegion
; Description....: Determines whether the specified point is inside the specified region.
; Syntax.........: _WinAPI_PtInRegion ( $hRgn, $iX, $iY )
; Parameters.....: $hRgn   - Handle to the region to be examined.
;                  $iX     - The x-coordinate of the point in logical units.
;                  $iY     - The y-coordinate of the point in logical units.
; Return values..: Success - 1 - The specified point is in the region.
;                            0 - Otherwise.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ PtInRegion
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_PtInRegion($hRgn, $iX, $iY)

	Local $Ret = DllCall('gdi32.dll', 'int', 'PtInRegion', 'ptr', $hRgn, 'int', $iX, 'int', $iY)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_PtInRegion

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_QueryDosDevice
; Description....: Retrieves the current mapping for a particular MS-DOS device name.
; Syntax.........: _WinAPI_QueryDosDevice ( $sDevice )
; Parameters.....: $sDevice - The name of the MS-DOS device.
; Return values..: Success  - The current mapping for the specified device. If the $sDevice parameter is empty string, return array
;                             of all existing MS-DOS device names (for example, "\Device\HarddiskVolume1" or "\Device\Floppy0").
;                             The zeroth array element contains the number of names.
;                  Failure  - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ QueryDosDevice
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_QueryDosDevice($sDevice)

	Local $TypeOfDevice = 'wstr'

	If Not StringStripWS($sDevice, 3) Then
		$TypeOfDevice = 'ptr'
		$sDevice = 0
	EndIf

	Local $tData = DllStructCreate('wchar[' & (32 * 1024 / 2) & ']'), $pData = DllStructGetPtr($tData)
	Local $Ret = DllCall('kernel32.dll', 'dword', 'QueryDosDeviceW', $TypeOfDevice, $sDevice, 'ptr', $pData, 'dword', 16384)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, '')
	EndIf

	Local $Result = _WinAPI_StructToArray($pData)

	If IsString($sDevice) Then
		$Result = $Result[1]
	EndIf
	Return $Result
EndFunc   ;==>_WinAPI_QueryDosDevice

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_QueryInformationJobObject
; Description....: Retrieves limit and job state information from the job object.
; Syntax.........: _WinAPI_QueryInformationJobObject ( $hJob, $iJobObjectInfoClass, ByRef $tJobObjectInfo )
; Parameters.....: $hJob                - Handle to the job whose information is being queried. The handle must have the
;                                         $JOB_OBJECT_QUERY access right. If this value is 0 and the calling process is associated
;                                         with a job, the job associated with the calling process is used.
;                  $iJobObjectInfoClass - The information class for the limits to be queried. This parameter specifies the type
;                                         of $tJobObjectInfo structure, valid values:
;                  |1  - $tagJOBOBJECT_BASIC_ACCOUNTING_INFORMATION
;                  |2  - $tagJOBOBJECT_BASIC_LIMIT_INFORMATION
;                  |3  - $tagJOBOBJECT_BASIC_PROCESS_ID_LIST
;                  |4  - $tagJOBOBJECT_BASIC_UI_RESTRICTIONS
;                  |5  - $tagJOBOBJECT_SECURITY_LIMIT_INFORMATION
;                  |8  - $tagJOBOBJECT_BASIC_AND_IO_ACCOUNTING_INFORMATION
;                  |9  - $tagJOBOBJECT_EXTENDED_LIMIT_INFORMATION
;                  |11 - $tagJOBOBJECT_GROUP_INFORMATION
;                  $tJobObjectInfo      - $tagJOBOBJECT_... structure that retrieves the limit and job state information.
; Return values..: Success              - The length of data (in bytes) written to the structure pointed to by the
;                                         $tJobObjectInfo parameter.
;                  Failure              - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ QueryInformationJobObject
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_QueryInformationJobObject($hJob, $iJobObjectInfoClass, ByRef $tJobObjectInfo)

	Local $Ret = DllCall('kernel32.dll', 'int', 'QueryInformationJobObject', 'ptr', $hJob, 'int', $iJobObjectInfoClass, 'ptr', DllStructGetPtr($tJobObjectInfo), 'dword', DllStructGetSize($tJobObjectInfo), 'dword*', 0)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[5]
EndFunc   ;==>_WinAPI_QueryInformationJobObject

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_QueryPerformanceCounter
; Description....: Retrieves the current value of the high-resolution performance counter.
; Syntax.........: _WinAPI_QueryPerformanceCounter ( )
; Parameters.....: None
; Return values..: Success - The current performance-counter value, in counts.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ QueryPerformanceCounter
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_QueryPerformanceCounter()

	Local $Ret = DllCall('kernel32.dll', 'int', 'QueryPerformanceCounter', 'int64*', 0)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[1]
EndFunc   ;==>_WinAPI_QueryPerformanceCounter

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_QueryPerformanceFrequency
; Description....: Retrieves the frequency of the high-resolution performance counter.
; Syntax.........: _WinAPI_QueryPerformanceFrequency ( )
; Parameters.....: None
; Return values..: Success - The current performance-counter frequency, in counts per second.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ QueryPerformanceFrequency
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_QueryPerformanceFrequency()

	Local $Ret = DllCall('kernel32.dll', 'int', 'QueryPerformanceFrequency', 'int64*', 0)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[1]
EndFunc   ;==>_WinAPI_QueryPerformanceFrequency

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RadialGradientFill
; Description....: Fills radial gradient.
; Syntax.........: _WinAPI_RadialGradientFill($hDC, $iX, $iY, $iRadius, $iRGB1, $iRGB2 [, $iAngleStart [, $iAngleEnd [, $iStep]]] )
; Parameters.....: $hDC         - Handle to the destination device context.
;                  $iX          - The x-coordinate of the central point, in logical units.
;                  $iY          - The y-coordinate of the central point, in logical units.
;                  $iRadius     - The circle radius to filling the gradient.
;                  $iRGB1       - The color information at the central point.
;                  $iRGB2       - The color information at the edges of circle.
;                  $iAngleStart - The angle to start filling at, in degree.
;                  $iAngleEnd   - The angle to end filling at, in degree.
;                  $iStep       - The gradient filling step in degree. The larger value of this parameter, the gradient will be
;                                 better, but it's require more time, and vice versa.
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function does not fills gradient with transparency, and does not use antialiasing.
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RadialGradientFill($hDC, $iX, $iY, $iRadius, $iRGB1, $iRGB2, $iAngleStart = 0, $iAngleEnd = 360, $iStep = 5)

	Local $Val

	If Abs($iAngleStart) > 360 Then
		$iAngleStart = Mod($iAngleStart, 360)
	EndIf
	If Abs($iAngleEnd) > 360 Then
		$iAngleEnd = Mod($iAngleEnd, 360)
	EndIf
	If ($iAngleStart < 0) Or ($iAngleEnd < 0) Then
		$iAngleStart += 360
		$iAngleEnd += 360
	EndIf
	If $iAngleStart > $iAngleEnd Then
		$Val = $iAngleStart
		$iAngleStart = $iAngleEnd
		$iAngleEnd = $Val
	EndIf
	If $iStep < 1 Then
		$iStep = 1
	EndIf

	Local $K = 4 * ATan(1) / 180
	Local $Xp = Round($iX + $iRadius * Cos($K * $iAngleStart))
	Local $Yp = Round($iY + $iRadius * Sin($K * $iAngleStart))
	Local $Xn, $Yn, $An = $iAngleStart
	Local $Vertex[3][3]

	While $An < $iAngleEnd
		$An += $iStep
		If $An > $iAngleEnd Then
			$An = $iAngleEnd
		EndIf
		$Xn = Round($iX + $iRadius * Cos($K * $An))
		$Yn = Round($iY + $iRadius * Sin($K * $An))
		$Vertex[0][0] = $iX
		$Vertex[0][1] = $iY
		$Vertex[0][2] = $iRGB1
		$Vertex[1][0] = $Xp
		$Vertex[1][1] = $Yp
		$Vertex[1][2] = $iRGB2
		$Vertex[2][0] = $Xn
		$Vertex[2][1] = $Yn
		$Vertex[2][2] = $iRGB2
		If Not _WinAPI_GradientFill($hDC, $Vertex, 0, 2) Then
			Return SetError(1, 0, 0)
		EndIf
		$Xp = $Xn
		$Yp = $Yn
	WEnd
	Return 1
EndFunc   ;==>_WinAPI_RadialGradientFill

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_Rectangle
; Description....: Draws a rectangle.
; Syntax.........: _WinAPI_Rectangle ( $hDC, $tRECT )
; Parameters.....: $hDC     - Handle to the device context.
;                  $tRECT   - $tagRECT structure that contains the logical coordinates of the rectangle.
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The rectangle is outlined by using the current pen and filled by using the current brush.
; Related........:
; Link...........: @@MsdnLink@@ Rectangle
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_Rectangle($hDC, $tRECT)

	Local $Ret = DllCall('gdi32.dll', 'int', 'Rectangle', 'hwnd', $hDC, 'int', DllStructGetData($tRECT, 1), 'int', DllStructGetData($tRECT, 2), 'int', DllStructGetData($tRECT, 3), 'int', DllStructGetData($tRECT, 4))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_Rectangle

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RegCloseKey
; Description....: Closes a handle to the specified registry key.
; Syntax.........: _WinAPI_RegCloseKey ( $hKey [, $fFlush] )
; Parameters.....: $hKey   - Handle to the open key to be closed. The handle must have been opened by the _WinAPI_RegCreateKey()
;                            or _WinAPI_RegOpenKey() function.
;                  $fFlush - Specifies whether writes all the attributes of the specified registry key into the registry,
;                            valid values:
;                  |TRUE   - Write changes to disk before close the handle.
;                  |FALSE  - Don`t write. (Default)
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero, @extended flag may contain the nonzero system error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ RegCloseKey
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RegCloseKey($hKey, $fFlush = 0)

	If $fFlush Then
		If Not _WinAPI_RegFlushKey($hKey) Then
			Return SetError(1, @extended, 0)
		EndIf
	EndIf

	Local $Ret = DllCall('advapi32.dll', 'long', 'RegCloseKey', 'ulong_ptr', $hKey)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_RegCloseKey

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RegConnectRegistry
; Description....: Establishes a connection to a predefined registry key on another computer.
; Syntax.........: _WinAPI_RegConnectRegistry ( $sComputer, $hKey )
; Parameters.....: $sComputer - The name of the remote computer. The string has the form as "\\computername". The caller must
;                               have access to the remote computer or the function fails. If this parameter is 0, the local
;                               computer name is used.
;                  $hKey      - The predefined registry handle. This parameter can be one of the following predefined keys
;                               on the remote computer.
;
;                               $HKEY_LOCAL_MACHINE
;                               $HKEY_PERFORMANCE_DATA
;                               $HKEY_USERS
;
; Return values..: Success    - Handle to the key on the remote computer.
;                  Failure    - 0 and sets the @error flag to non-zero, @extended flag may contain the nonzero system error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function requires the Remote Registry service to be running on the remote computer.
;
;                  If the current user does not have proper access to the remote computer, the call to _WinAPI_RegConnectRegistry()
;                  fails. If the computer is joined to a workgroup and the "Force network logons using local accounts to authenticate
;                  as Guest" policy is enabled, the function fails. Note that this policy is enabled by default if the computer is
;                  joined to a workgroup.
;
;                  When a handle returned by _WinAPI_RegConnectRegistry() is no longer needed, it should be closed by
;                  calling _WinAPI_RegCloseKey().
; Related........:
; Link...........: @@MsdnLink@@ RegConnectRegistry
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RegConnectRegistry($sComputer, $hKey)

	Local $Ret = DllCall('advapi32.dll', 'long', 'RegConnectRegistryW', 'wstr', $sComputer, 'ulong_ptr', $hKey, 'ulong_ptr*', 0)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return $Ret[3]
EndFunc   ;==>_WinAPI_RegConnectRegistry

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RegCopyTree
; Description....: Copies the subkeys and values of the source subkey to the destination key.
; Syntax.........: _WinAPI_RegCopyTree ( $hSrcKey, $sSrcSubKey, $hDestKey )
; Parameters.....: $hSrcKey    - Handle to an open registry key, or one of the predefined keys ($HKEY_...).
;                  $sSrcSubKey - The subkey whose subkeys and values are to be copied.
;                  $hDestKey   - Handle to the destination key. This handle is returned by the _WinAPI_RegCreateKey() or _WinAPI_RegOpenKey()
;                                function, or it can be one of the predefined keys ($HKEY_...).
; Return values..: Success     - 1.
;                  Failure     - 0 and sets the @error flag to non-zero, @extended flag may contain the nonzero system error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function does not duplicate the security attributes of the keys and values that it copies. Rather,
;                  all security attributes in the destination key are the default attributes.
; Related........:
; Link...........: @@MsdnLink@@ SHCopyKey
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RegCopyTree($hSrcKey, $sSrcSubKey, $hDestKey)

	Local $Ret = DllCall('shlwapi.dll', 'long', 'SHCopyKeyW', 'ulong_ptr', $hSrcKey, 'wstr', $sSrcSubKey, 'ulong_ptr', $hDestKey, 'dword', 0)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_RegCopyTree

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RegCreateKey
; Description....: Creates the specified registry key.
; Syntax.........: _WinAPI_RegCreateKey ( $hKey [, $sSubKey [, $iDesired [, $iOptions [, $tSecurity]]]] )
; Parameters.....: $hKey      - Handle to an open registry key. If the key already exists, the function opens it. The calling process
;                               must have $KEY_CREATE_SUB_KEY access to the key. This handle is returned by the _WinAPI_RegCreateKey()
;                               or _WinAPI_RegOpenKey() function, or it can be one of the following predefined keys.
;
;                               $HKEY_CLASSES_ROOT
;                               $HKEY_CURRENT_CONFIG
;                               $HKEY_CURRENT_USER
;                               $HKEY_LOCAL_MACHINE
;                               $HKEY_USERS
;
;                  $sSubKey   - The name of a subkey that this function opens or creates. The subkey specified must be a subkey of
;                               the key identified by the $hKey parameter; it can be up to 32 levels deep in the registry tree.
;                  $iDesired  - The mask that specifies the access rights for the key. This parameter can be one or more of
;                               the following values.
;
;                               $KEY_ALL_ACCESS
;                               $KEY_CREATE_LINK
;                               $KEY_CREATE_SUB_KEY
;                               $KEY_ENUMERATE_SUB_KEYS
;                               $KEY_EXECUTE
;                               $KEY_NOTIFY
;                               $KEY_QUERY_VALUE
;                               $KEY_READ
;                               $KEY_SET_VALUE
;                               $KEY_WOW64_32KEY
;                               $KEY_WOW64_64KEY
;                               $KEY_WRITE
;
;                  $iOptions  - This parameter can be one of the following values.
;
;                               $REG_OPTION_BACKUP_RESTORE
;                               $REG_OPTION_CREATE_LINK
;                               $REG_OPTION_NON_VOLATILE
;                               $REG_OPTION_VOLATILE
;
;                  $tSecurity - $tagSECURITY_ATTRIBUTES structure that determines whether the returned handle can be inherited by
;                               child processes. If this parameter is 0, the handle cannot be inherited.
; Return values..: Success    - Handle to the opened or created key, @extended flag will contain one of the following
;                               disposition values.
;
;                               0 (FALSE) - The key existed and was simply opened without being changed.
;                               1 (TRUE)  - The key did not exist and was created.
;
;                  Failure    - 0 and sets the @error flag to non-zero, @extended flag may contain the nonzero system error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: An application cannot create a key that is a direct child of HKEY_USERS or HKEY_LOCAL_MACHINE. An application
;                  can create subkeys in lower levels of the HKEY_USERS or HKEY_LOCAL_MACHINE trees.
;
;                  If the key is not one of the predefined registry keys ($HKEY_...) you must call the _WinAPI_RegCloseKey()
;                  function after finished using the handle.
; Related........:
; Link...........: @@MsdnLink@@ RegCreateKeyEx
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RegCreateKey($hKey, $sSubKey = '', $iDesired = 0xF003F, $iOptions = 0, $tSecurity = 0)

	Local $Ret = DllCall('advapi32.dll', 'long', 'RegCreateKeyExW', 'ulong_ptr', $hKey, 'wstr', $sSubKey, 'dword', 0, 'ptr', 0, 'dword', $iOptions, 'dword', $iDesired, 'ptr', DllStructGetPtr($tSecurity), 'ulong_ptr*', 0, 'dword*', 0)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return SetError(0, Number($Ret[9] = 1), $Ret[8])
EndFunc   ;==>_WinAPI_RegCreateKey

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RegDeleteEmptyKey
; Description....: Deletes an empty key.
; Syntax.........: _WinAPI_RegDeleteEmptyKey ( $hKey [, $sSubKey] )
; Parameters.....: $hKey    - Handle to an open registry key, or any of the following predefined keys.
;
;                             $HKEY_CLASSES_ROOT
;                             $HKEY_CURRENT_CONFIG
;                             $HKEY_CURRENT_USER
;                             $HKEY_LOCAL_MACHINE
;                             $HKEY_USERS
;
;                  $sSubKey - The name of the key to delete.
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero, @extended flag may contain the nonzero system error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SHDeleteEmptyKey
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RegDeleteEmptyKey($hKey, $sSubKey = '')

	Local $Ret = DllCall('shlwapi.dll', 'long', 'SHDeleteEmptyKeyW', 'ulong_ptr', $hKey, 'wstr', $sSubKey)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_RegDeleteEmptyKey

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RegDeleteKey
; Description....: Deletes a subkey and its values.
; Syntax.........: _WinAPI_RegDeleteKey ( $hKey [, $sSubKey] )
; Parameters.....: $hKey    - Handle to an open registry key. The access rights of this key do not affect the delete operation.
;                             This handle is returned by the _WinAPI_RegCreateKey() or _WinAPI_RegOpenKey() function, or it can be
;                             one of the following predefined keys.
;
;                             $HKEY_CLASSES_ROOT
;                             $HKEY_CURRENT_CONFIG
;                             $HKEY_CURRENT_USER
;                             $HKEY_LOCAL_MACHINE
;                             $HKEY_USERS
;
;                  $sSubKey - The name of the key to be deleted. It must be a subkey of the key that $hKey identifies, but it
;                             cannot have subkeys.
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero, @extended flag may contain the nonzero system error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: A deleted key is not removed until the last handle to it is closed.
; Related........:
; Link...........: @@MsdnLink@@ RegDeleteKey
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RegDeleteKey($hKey, $sSubKey = '')

	Local $Ret = DllCall('advapi32.dll', 'long', 'RegDeleteKeyW', 'ulong_ptr', $hKey, 'wstr', $sSubKey)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_RegDeleteKey

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RegDeleteTree
; Description....: Deletes the subkeys and values of the specified key recursively.
; Syntax.........: _WinAPI_RegDeleteTree ( $hKey [, $sSubKey] )
; Parameters.....: $hKey    - Handle to an open registry key, or any of the following predefined keys.
;
;                             $HKEY_CLASSES_ROOT
;                             $HKEY_CURRENT_CONFIG
;                             $HKEY_CURRENT_USER
;                             $HKEY_LOCAL_MACHINE
;                             $HKEY_USERS
;
;                  $sSubKey - The name of the key. This key must be a subkey of the key identified by the $hKey parameter.
;                             If this parameter is not specified, the subkeys and values of $hKey are deleted.
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero, @extended flag may contain the nonzero system error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SHDeleteKey
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RegDeleteTree($hKey, $sSubKey = '')

	Local $Ret = DllCall('shlwapi.dll', 'long', 'SHDeleteKeyW', 'ulong_ptr', $hKey, 'wstr', $sSubKey)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_RegDeleteTree

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RegEnumKey
; Description....: Enumerates the subkeys of the specified open registry key.
; Syntax.........: _WinAPI_RegEnumKey ( $hKey, $iIndex )
; Parameters.....: $hKey   - Handle to an open registry key. The key must have been opened with the $KEY_ENUMERATE_SUB_KEYS access
;                            right. This handle is returned by the _WinAPI_RegCreateKey() or _WinAPI_RegOpenKey() function.
;                            It can also be one of the following predefined keys.
;
;                            $HKEY_CLASSES_ROOT
;                            $HKEY_CURRENT_CONFIG
;                            $HKEY_CURRENT_USER
;                            $HKEY_LOCAL_MACHINE
;                            $HKEY_PERFORMANCE_DATA
;                            $HKEY_USERS
;
;                  $iIndex - The index of the subkey to retrieve. This parameter should be zero for the first call to the _WinAPI_RegEnumKey()
;                            function and then incremented for subsequent calls.
; Return values..: Success - The string that contains the name of the subkey.
;                  Failure - Empty string and sets the @error flag to non-zero, @extended flag may contain the nonzero system error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: To enumerate subkeys, an application should initially call the _WinAPI_RegEnumKey() function with the $iIndex
;                  parameter set to zero. The application should then increment the $iIndex parameter and call _WinAPI_RegEnumKey()
;                  until there are no more subkeys (meaning the @extended flag sets to ERROR_NO_MORE_ITEMS (259)).
;
;                  The application can also set $iIndex to the index of the last subkey on the first call to the function and
;                  decrement the index until the subkey with the index 0 is enumerated. To retrieve the index of the last subkey,
;                  use the _WinAPI_RegQueryInfoKey() function.
;
;                  While an application is using the _WinAPI_RegEnumKey() function, it should not make calls to any registration
;                  functions that might change the key being enumerated.
; Related........:
; Link...........: @@MsdnLink@@ RegEnumKeyEx
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RegEnumKey($hKey, $iIndex)

	Local $tData = DllStructCreate('wchar[256]')
	Local $Ret = DllCall('advapi32.dll', 'long', 'RegEnumKeyExW', 'ulong_ptr', $hKey, 'dword', $iIndex, 'ptr', DllStructGetPtr($tData), 'dword*', 256, 'dword', 0, 'ptr', 0, 'ptr', 0, 'ptr', 0)

	If @error Then
		Return SetError(1, 0, '')
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], '')
		EndIf
	EndIf
	Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_RegEnumKey

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RegEnumValue
; Description....: Enumerates the values for the specified open registry key.
; Syntax.........: _WinAPI_RegEnumValue ( $hKey, $iIndex )
; Parameters.....: $hKey   - Handle to an open registry key. The key must have been opened with the $KEY_QUERY_VALUE access right.
;                            This handle is returned by the _WinAPI_RegCreateKey() or _WinAPI_RegOpenKey() function. It can also
;                            be one of the following predefined keys.
;
;                            $HKEY_CLASSES_ROOT
;                            $HKEY_CURRENT_CONFIG
;                            $HKEY_CURRENT_USER
;                            $HKEY_LOCAL_MACHINE
;                            $HKEY_PERFORMANCE_DATA
;                            $HKEY_USERS
;
;                  $iIndex - The index of the value to be retrieved. This parameter should be zero for the first call to the _WinAPI_RegEnumValue()
;                            function and then be incremented for subsequent calls.
; Return values..: Success - The string that contains the name of the value, @extended flag will contain the code indicating the
;                            type of data ($REG_...) stored in the specified value.
;                  Failure - Empty string and sets the @error flag to non-zero, @extended flag may contain the nonzero system error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: To enumerate values, an application should initially call the _WinAPI_RegEnumValue() function with the $iIndex
;                  parameter set to zero. The application should then increment $iIndex and call the _WinAPI_RegEnumValue() function
;                  until there are no more values (until the @extended flag sets to ERROR_NO_MORE_ITEMS (259)).
;
;                  The application can also set $iIndex to the index of the last value on the first call to the function and
;                  decrement the index until the value with index 0 is enumerated. To retrieve the index of the last value,
;                  use the _WinAPI_RegQueryInfoKey() function.
;
;                  While using _WinAPI_RegEnumValue(), an application should not call any registry functions that might change the
;                  key being queried.
; Related........:
; Link...........: @@MsdnLink@@ RegEnumValue
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RegEnumValue($hKey, $iIndex)

	Local $tData = DllStructCreate('wchar[1024]')
	Local $Ret = DllCall('advapi32.dll', 'long', 'RegEnumValueW', 'ulong_ptr', $hKey, 'dword', $iIndex, 'ptr', DllStructGetPtr($tData), 'dword*', 1024, 'dword', 0, 'dword*', 0, 'ptr', 0, 'ptr', 0)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return SetError(0, $Ret[6], DllStructGetData($tData, 1))
EndFunc   ;==>_WinAPI_RegEnumValue

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RegFlushKey
; Description....: Writes all the attributes of the specified open registry key into the registry.
; Syntax.........: _WinAPI_RegFlushKey ( $hKey )
; Parameters.....: $hKey   - Handle to an open registry key. The key must have been opened with the $KEY_QUERY_VALUE access right.
;                            This handle is returned by the _WinAPI_RegCreateKey() or _WinAPI_RegOpenKey() function. It can also
;                            be one of the following predefined keys.
;
;                            $HKEY_CLASSES_ROOT
;                            $HKEY_CURRENT_CONFIG
;                            $HKEY_CURRENT_USER
;                            $HKEY_LOCAL_MACHINE
;                            $HKEY_PERFORMANCE_DATA
;                            $HKEY_USERS
;
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero, @extended flag may contain the nonzero system error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: The _WinAPI_RegFlushKey() function returns only when all the data for the hive that contains the specified key
;                  has been written to the registry store on disk. The _WinAPI_RegFlushKey() function writes out the data for other
;                  keys in the hive that have been modified since the last lazy flush or system start. After _WinAPI_RegFlushKey()
;                  returns, use _WinAPI_RegCloseKey() to close the handle to the registry key.
; Related........:
; Link...........: @@MsdnLink@@ RegFlushKey
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RegFlushKey($hKey)

	Local $Ret = DllCall('advapi32.dll', 'long', 'RegFlushKey', 'ulong_ptr', $hKey)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_RegFlushKey

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RegisterHotKey
; Description....: Defines a system-wide hot key.
; Syntax.........: _WinAPI_RegisterHotKey ( $hWnd, $ID, $iModifiers, $vkCode )
; Parameters.....: $hWnd       - Handle to the window that will receive WM_HOTKEY messages generated by the hot key. If this parameter
;                                is 0, WM_HOTKEY messages are posted to the message queue of the calling thread and must be processed in
;                                the message loop.
;                  $ID         - Specifies the identifier of the hot key. An application must specify an id value in the range
;                                0x0000 through 0xBFFF.
;                  $iModifiers - Specifies keys that must be pressed in combination with the key specified by the $vkCode parameter
;                                in order to generate the WM_HOTKEY message. The $iModifiers parameter can be a combination of the
;                                following values.
;
;                                $MOD_ALT
;                                $MOD_CONTROL
;                                $MOD_SHIFT
;                                $MOD_WIN
;
;                                *Windows 7 or above
;
;                                $MOD_NOREPEAT
;
;                  $vkCode     - Specifies the virtual-key code of the hot key ($VK_...).
; Return values..: Success     - 1.
;                  Failure     - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: When a key is pressed, the system looks for a match against all hot keys. Upon finding a match, the system posts
;                  the WM_HOTKEY message to the message queue of the window with which the hot key is associated. If the hot key is
;                  not associated with a window, then the WM_HOTKEY message is posted to the thread associated with the hot key.
;
;                  _WinAPI_RegisterHotKey() fails if the keystrokes specified for the hot key have already been registered by
;                  another hot key.
;
;                  In Windows XP and previous versions of Windows, if a hot key already exists with the same $hWnd and $ID parameters,
;                  it is replaced by the new hot key.
;
;                  In Windows Vista and subsequent versions of Windows, if a hot key already exists with the same $hWnd and $ID
;                  parameters, it is maintained along with the new hot key. In these versions of Windows, the application must
;                  explicitly call _WinAPI_UnregisterHotKey() to unregister the old hot key.
; Related........:
; Link...........: @@MsdnLink@@ RegisterHotKey
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RegisterHotKey($hWnd, $ID, $iModifiers, $vkCode)

	Local $Ret = DllCall('user32.dll', 'int', 'RegisterHotKey', 'hwnd', $hWnd, 'int', $ID, 'uint', $iModifiers, 'uint', $vkCode)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_RegisterHotKey

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RegisterShellHookWindow
; Description....: Registers a specified Shell window to receive certain messages for events or notifications.
; Syntax.........: _WinAPI_RegisterShellHookWindow ( $hWnd )
; Parameters.....: $hWnd   - Handle to the window to register for Shell hook messages.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ RegisterShellHookWindow
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RegisterShellHookWindow($hWnd)

	Local $Ret = DllCall('user32.dll', 'int', 'RegisterShellHookWindow', 'hwnd', $hWnd)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_RegisterShellHookWindow

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RegOpenKey
; Description....: Opens the specified registry key.
; Syntax.........: _WinAPI_RegOpenKey ( $hKey [, $sSubKey [, $iDesired]] )
; Parameters.....: $hKey     - Handle to an open registry key. This handle is returned by the _WinAPI_RegCreateKey() or _WinAPI_RegOpenKey()
;                              function, or it can be one of the following predefined keys.
;
;                              $HKEY_CLASSES_ROOT
;                              $HKEY_CURRENT_USER
;                              $HKEY_LOCAL_MACHINE
;                              $HKEY_USERS
;
;                  $sSubKey  - The name of the registry subkey to be opened.
;                  $iDesired - A mask that specifies the desired access rights to the key. The function fails if the security
;                              descriptor of the key does not permit the requested access for the calling process. This parameter
;                              can be one or more of the $KEY_... constants.
; Return values..: Success   - Handle to the opened key.
;                  Failure   - 0 and sets the @error flag to non-zero, @extended flag may contain the nonzero system error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: Unlike the _WinAPI_RegCreateKey() function, the _WinAPI_RegOpenKey() function does not create the specified key
;                  if the key does not exist in the registry.
;
;                  If the key is not one of the predefined registry keys ($HKEY_...) you must call the _WinAPI_RegCloseKey()
;                  function after finished using the handle.
; Related........:
; Link...........: @@MsdnLink@@ RegOpenKeyEx
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RegOpenKey($hKey, $sSubKey = '', $iDesired = 0xF003F)

	Local $Ret = DllCall('advapi32.dll', 'long', 'RegOpenKeyExW', 'ulong_ptr', $hKey, 'wstr', $sSubKey, 'dword', 0, 'dword', $iDesired, 'ulong_ptr*', 0)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return $Ret[5]
EndFunc   ;==>_WinAPI_RegOpenKey

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RegQueryInfoKey
; Description....: Retrieves information about the specified registry key.
; Syntax.........: _WinAPI_RegQueryInfoKey ( $hKey )
; Parameters.....: $hKey   - Handle to an open registry key. The key must have been opened with the $KEY_QUERY_VALUE access right.
;                            This handle is returned by the _WinAPI_RegCreateKey() or _WinAPI_RegOpenKey() function. It can also
;                            be one of the following predefined keys.
;
;                            $HKEY_CLASSES_ROOT
;                            $HKEY_CURRENT_CONFIG
;                            $HKEY_CURRENT_USER
;                            $HKEY_LOCAL_MACHINE
;                            $HKEY_PERFORMANCE_DATA
;                            $HKEY_USERS
;
; Return values..: Success - The array containing the following parameters:
;
;                            [0] - The number of subkeys that are contained by the specified key.
;                            [1] - The size of the key's subkey with the longest name, in characters, not including the terminating null character.
;                            [2] - The number of values that are associated with the key.
;                            [3] - The size of the key's longest value name, in characters. The size does not include the terminating null character.
;                            [4] - The size of the longest data component among the key's values, in bytes.
;
;                  Failure - 0 and sets the @error flag to non-zero, @extended flag may contain the nonzero system error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ RegQueryInfoKey
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RegQueryInfoKey($hKey)

	Local $Ret = DllCall('advapi32.dll', 'long', 'RegQueryInfoKeyW', 'ulong_ptr', $hKey, 'ptr', 0, 'ptr', 0, 'dword', 0, 'dword*', 0, 'dword*', 0, 'ptr', 0, 'dword*', 0, 'dword*', 0, 'dword*', 0, 'ptr', 0, 'ptr', 0)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf

	Local $Result[5]

	$Result[0] = $Ret[5]
	$Result[1] = $Ret[6]
	$Result[2] = $Ret[8]
	$Result[3] = $Ret[9]
	$Result[4] = $Ret[10]

	Return $Result
EndFunc   ;==>_WinAPI_RegQueryInfoKey

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RegQueryLastWriteTime
; Description....: Retrieves information about the last write time to the specified registry key.
; Syntax.........: _WinAPI_RegQueryLastWriteTime ( $hKey )
; Parameters.....: $hKey   - Handle to an open registry key. The key must have been opened with the $KEY_QUERY_VALUE access right.
;                            This handle is returned by the _WinAPI_RegCreateKey() or _WinAPI_RegOpenKey() function. It can also
;                            be one of the following predefined keys.
;
;                            $HKEY_CLASSES_ROOT
;                            $HKEY_CURRENT_CONFIG
;                            $HKEY_CURRENT_USER
;                            $HKEY_LOCAL_MACHINE
;                            $HKEY_PERFORMANCE_DATA
;                            $HKEY_USERS
;
; Return values..: Success - $tagFILETIME structure that contains the last write time.
;                  Failure - 0 and sets the @error flag to non-zero, @extended flag may contain the nonzero system error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ RegQueryInfoKey
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RegQueryLastWriteTime($hKey)

	Local $tFILETIME = DllStructCreate($tagFILETIME)
	Local $Ret = DllCall('advapi32.dll', 'long', 'RegQueryInfoKeyW', 'ulong_ptr', $hKey, 'ptr', 0, 'ptr', 0, 'dword', 0, 'ptr', 0, 'ptr', 0, 'ptr', 0, 'ptr', 0, 'ptr', 0, 'ptr', 0, 'ptr', 0, 'ptr', DllStructGetPtr($tFILETIME))

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return $tFILETIME
EndFunc   ;==>_WinAPI_RegQueryLastWriteTime

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RegQueryValue
; Description....: Retrieves the type and data for the specified value name associated with an open registry key.
; Syntax.........: _WinAPI_RegQueryValue ( $hKey, $sValueName, ByRef $tValueData, $iBytes )
; Parameters.....: $hKey       - Handle to an open registry key. The key must have been opened with the KEY_QUERY_VALUE access right.
;                                This handle is returned by the _WinAPI_RegCreateKey() or _WinAPI_RegOpenKey() function. It can also
;                                be one of the following predefined keys.
;
;                                $HKEY_CLASSES_ROOT
;                                $HKEY_CURRENT_CONFIG
;                                $HKEY_CURRENT_USER
;                                $HKEY_LOCAL_MACHINE
;                                $HKEY_PERFORMANCE_DATA
;                                $HKEY_PERFORMANCE_NLSTEXT
;                                $HKEY_PERFORMANCE_TEXT
;                                $HKEY_USERS
;
;                  $sValueName - The name of the registry value. If $sValueName is empty string, the function retrieves the type and
;                                data for the key's unnamed or default value, if any.
;                  $tValueData - The structure (buffer) that receives the value's data.
; Return values..: Success     - The size of the data copied to $tValueData, in bytes, @extended flag will contain the code indicating
;                                the type of data ($REG_...).
;                  Failure     - 0 and sets the @error flag to non-zero, @extended flag may contain the nonzero system error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: If the data has the REG_SZ, REG_MULTI_SZ or REG_EXPAND_SZ type, returned size includes any terminating null
;                  character or characters unless the data was stored without them.
;
;                  If the buffer specified by $tValueData parameter is not large enough to hold the data, the function returns
;                  ERROR_MORE_DATA (234) and returns the required buffer size. In this case, the contents of the buffer are
;                  undefined.
; Related........:
; Link...........: @@MsdnLink@@ RegQueryValueEx
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RegQueryValue($hKey, $sValueName, ByRef $tValueData)

	Local $Ret = DllCall('advapi32.dll', 'long', 'RegQueryValueExW', 'ulong_ptr', $hKey, 'wstr', $sValueName, 'dword', 0, 'dword*', 0, 'ptr', DllStructGetPtr($tValueData), 'dword*', DllStructGetSize($tValueData))

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return SetError(0, $Ret[4], $Ret[6])
EndFunc   ;==>_WinAPI_RegQueryValue

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RegRestoreKey
; Description....: Reads the registry information in a specified file and copies it over the specified key.
; Syntax.........: _WinAPI_RegRestoreKey ( $hKey, $sFile )
; Parameters.....: $hKey   - Handle to an open registry key. This handle is returned by the _WinAPI_RegCreateKey() or _WinAPI_RegOpenKey()
;                            function. It can also be one of the following predefined keys.
;
;                            $HKEY_CLASSES_ROOT
;                            $HKEY_CURRENT_CONFIG
;                            $HKEY_CURRENT_USER
;                            $HKEY_LOCAL_MACHINE
;                            $HKEY_USERS
;
;                  $sFile  - The name of the file with the registry information. This file is typically created by
;                            using the _WinAPI_RegSaveKey() function.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero, @extended flag may contain the nonzero system error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: There are two different registry hive file formats. Registry hives created on current operating systems typically
;                  cannot be loaded by earlier ones.
;
;                  The new information in the file specified by $sFile overwrites the contents of the key specified by the $hKey
;                  parameter, except for the key name.
;
;                  If any subkeys of the hKey parameter are open, _WinAPI_RegRestoreKey() fails.
; Related........:
; Link...........: @@MsdnLink@@ RegRestoreKey
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RegRestoreKey($hKey, $sFile)

	Local $hToken, $Error = 1, $Ret = 0
	Local $Privileges[2] = [$SE_BACKUP_NAME, $SE_RESTORE_NAME]

	$hToken = _WinAPI_OpenProcessToken(BitOR($TOKEN_ADJUST_PRIVILEGES, $TOKEN_QUERY))
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	_WinAPI_AdjustTokenPrivileges($hToken, $Privileges, 1)
	If Not (@error Or @extended) Then
		$Ret = DllCall('advapi32.dll', 'long', 'RegRestoreKeyW', 'ulong_ptr', $hKey, 'wstr', $sFile, 'dword', 8)
		If @error Then
			$Ret = 0
		Else
			$Ret = $Ret[0]
			If Not $Ret Then
				$Error = 0
			EndIf
		EndIf
	EndIf
	_WinAPI_AdjustTokenPrivileges($hToken, $Privileges, 2)
	_WinAPI_FreeHandle($hToken)
	Return SetError($Error, $Ret, Number(Not $Error))
EndFunc   ;==>_WinAPI_RegRestoreKey

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RegSaveKey
; Description....: Saves the specified key and all of its subkeys and values to a new file, in the standard format.
; Syntax.........: _WinAPI_RegSaveKey ( $hKey, $sFile [, $tSecurity] )
; Parameters.....: $hKey      - Handle to an open registry key.
;                  $sFile     - The name of the file in which the specified key and subkeys are to be saved. If the file already
;                               exists, the function replaces it. The new file has the archive attribute.
;                  $tSecurity - $tagSECURITY_ATTRIBUTES structure that specifies a security descriptor for the new file. If this
;                               parameter is 0, the file gets a default security descriptor.
; Return values..: Success    - 1.
;                  Failure    - 0 and sets the @error flag to non-zero, @extended flag may contain the nonzero system error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: You can use the file created by this function in subsequent calls to the _WinAPI_RegRestoreKey() functions.
; Related........:
; Link...........: @@MsdnLink@@ RegSaveKey
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RegSaveKey($hKey, $sFile, $tSecurity = 0)

	Local $hToken, $Error = 1, $Ret = 0

	$hToken = _WinAPI_OpenProcessToken(BitOR($TOKEN_ADJUST_PRIVILEGES, $TOKEN_QUERY))
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	_WinAPI_AdjustTokenPrivileges($hToken, $SE_BACKUP_NAME, 1)
	If Not (@error Or @extended) Then
		FileDelete($sFile)
		$Ret = DllCall('advapi32.dll', 'long', 'RegSaveKeyW', 'ulong_ptr', $hKey, 'wstr', $sFile, 'ptr', DllStructGetPtr($tSecurity))
		If @error Then
			$Ret = 0
		Else
			$Ret = $Ret[0]
			If Not $Ret Then
				$Error = 0
			EndIf
		EndIf
	EndIf
	_WinAPI_AdjustTokenPrivileges($hToken, $SE_BACKUP_NAME, 2)
	_WinAPI_FreeHandle($hToken)
	Return SetError($Error, $Ret, Number(Not $Error))
EndFunc   ;==>_WinAPI_RegSaveKey

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RegSetValue
; Description....: Sets the data and type of a specified value under a registry key.
; Syntax.........: _WinAPI_RegSetValue ($hKey, $sValueName, $iType, ByRef $tValueData, $iBytes)
; Parameters.....: $hKey       - Handle to an open registry key. The key must have been opened with the $KEY_SET_VALUE access right.
;                                This handle is returned by the _WinAPI_RegCreateKey() or _WinAPI_RegOpenKey() function. It can also
;                                be one of the following predefined keys.
;
;                                $HKEY_CLASSES_ROOT
;                                $HKEY_CURRENT_CONFIG
;                                $HKEY_CURRENT_USER
;                                $HKEY_LOCAL_MACHINE
;                                $HKEY_PERFORMANCE_DATA
;                                $HKEY_USERS
;
;                  $sValueName - The name of the value to be set. If a value with this name is not already present in the key,
;                                the function adds it to the key. If $sValueName is empty string, the function sets the type and
;                                data for the key's unnamed or default value.
;                  $iType      - The type of data. This parameter can be one of the following values.
;
;                                $REG_BINARY
;                                $REG_DWORD
;                                $REG_DWORD_BIG_ENDIAN
;                                $REG_DWORD_LITTLE_ENDIAN
;                                $REG_EXPAND_SZ
;                                $REG_LINK
;                                $REG_MULTI_SZ
;                                $REG_NONE
;                                $REG_QWORD
;                                $REG_QWORD_LITTLE_ENDIAN
;                                $REG_SZ
;
;                  $tValueData - The structure (buffer) that contains the data to be stored. For string-based types, such as REG_SZ,
;                                the string must be null-terminated. With the REG_MULTI_SZ data type, the string must be terminated
;                                with two null characters. A backslash must be preceded by another backslash as an escape character.
;                                For example, specify "C:\\mydir\\myfile" to store the string "C:\mydir\myfile".
;                  $iBytes     - The size of the data, in bytes. If the data has the REG_SZ, REG_MULTI_SZ or REG_EXPAND_SZ type,
;                                this size includes any terminating null character or characters unless the data was stored
;                                without them.
; Return values..: Success     - 1.
;                  Failure     - 0 and sets the @error flag to non-zero, @extended flag may contain the nonzero system error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ RegSetValueEx
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RegSetValue($hKey, $sValueName, $iType, ByRef $tValueData, $iBytes)

	Local $Ret = DllCall('advapi32.dll', 'long', 'RegSetValueExW', 'ulong_ptr', $hKey, 'wstr', $sValueName, 'dword', 0, 'dword', $iType, 'ptr', DllStructGetPtr($tValueData), 'dword', $iBytes)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_RegSetValue

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ReleaseSemaphore
; Description....: Increases the count of the specified semaphore object by a specified amount.
; Syntax.........: _WinAPI_ReleaseSemaphore ( $hSemaphore [, $iIncrease] )
; Parameters.....: $hSemaphore - Handle to the semaphore object. The _WinAPI_CreateSemaphore() or _WinAPI_OpenSemaphore() function
;                                returns this handle.
;                  $iIncrease  - The amount by which the semaphore object's current count is to be increased. The value must be greater
;                                than zero. If the specified amount would cause the semaphore's count to exceed the maximum count that
;                                was specified when the semaphore was created, the count is not changed and the function returns 0.
; Return values..: Success     - The previous count for the semaphore.
;                  Failure     - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The state of a semaphore object is signaled when its count is greater than zero and nonsignaled when its count
;                  is equal to zero. The process that calls the _WinAPI_CreateSemaphore() function specifies the semaphore's initial
;                  count. Each time a waiting process is released because of the semaphore's signaled state, the count of the
;                  semaphore is decreased by one.
; Related........:
; Link...........: @@MsdnLink@@ ReleaseSemaphore
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ReleaseSemaphore($hSemaphore, $iIncrease = 1)

	Local $Ret = DllCall('kernel32.dll', 'int', 'ReleaseSemaphore', 'ptr', $hSemaphore, 'int', $iIncrease, 'int*', 0)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[3]
EndFunc   ;==>_WinAPI_ReleaseSemaphore

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RemoveFontResourceEx
; Description....: Removes the fonts in the specified file from the system font table.
; Syntax.........: _WinAPI_RemoveFontResourceEx ( $sFont [, $iFlag [, $fNotify]] )
; Parameters.....: $sFont   - String that names a font resource file. To remove a font whose information comes from several resource
;                             files, they must be separated by a "|". For example, abcxxxxx.pfm|abcxxxxx.pfb.
;                  $iFlag   - The characteristics of the font to be removed from the system. In order for the font to be removed, the flags
;                             used must be the same as when the font was added with the _WinAPI_AddFontResourceEx() function.
;                  $fNotify - Specifies whether sends a WM_FONTCHANGE message, valid values:
;                  |TRUE    - Send the WM_FONTCHANGE message to all top-level windows after changing the pool of font resources.
;                  |FALSE   - Don`t send. (Default)
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ RemoveFontResourceEx
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RemoveFontResourceEx($sFont, $iFlag = 0, $fNotify = 0)

	Local $Ret = DllCall('gdi32.dll', 'int', 'RemoveFontResourceExW', 'wstr', $sFont, 'dword', $iFlag, 'ptr', 0)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	If $fNotify Then
		DllCall('user32.dll', 'int', 'SendMessage', 'hwnd', 0xFFFF, 'uint', 0x001D, 'int', 0, 'int', 0)
	EndIf
	Return SetError(0, 0, 1)
EndFunc   ;==>_WinAPI_RemoveFontResourceEx

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RestartDlg
; Description....: Displays a dialog box that prompts the user to restart Microsoft Windows.
; Syntax.........: _WinAPI_RestartDlg ( [$sText [, $iFlags [, $hParent]]] )
; Parameters.....: $sText   - The text that displays in the dialog box which prompts the user.
;                  $iFlags  - The flags that specify the type of shutdown.
;
;                             This parameter must include one of the following values.
;
;                             $EWX_LOGOFF
;                             $EWX_POWEROFF
;                             $EWX_REBOOT
;                             $EWX_SHUTDOWN
;
;                             This parameter can optionally include the following values.
;
;                             $EWX_FORCE
;                             $EWX_FORCEIFHUNG
;
;                  $hParent - Handle to the parent window.
; Return values..: Success  - The identifier of the button that was pressed to close the dialog box.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ RestartDialog
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RestartDlg($sText = '', $iFlags = 2, $hParent = 0)

	Local $Ret = DllCall('shell32.dll', 'int', 'RestartDialog', 'hwnd', $hParent, 'wstr', $sText, 'int', $iFlags)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_RestartDlg

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RestoreDC
; Description....: Restores a device context (DC) to the specified state.
; Syntax.........: _WinAPI_RestoreDC ( $hDC, $ID )
; Parameters.....: $hDC    - Handle to the DC.
;                  $ID     - The saved state to be restored. If this parameter is positive, $DC represents a specific instance of the
;                            state to be restored. If this parameter is negative, $DC represents an instance relative to the current
;                            state. For example, (-1) restores the most recently saved state.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ RestoreDC
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RestoreDC($hDC, $ID)

	Local $Ret  = DllCall('gdi32.dll', 'int', 'RestoreDC', 'hwnd', $hDC, 'int', $ID)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_RestoreDC

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RGB
; Description....: Creates a RGB color value based on red, green, and blue components.
; Syntax.........: _WinAPI_RGB ( $iRed, $iGreen, $iBlue )
; Parameters.....: $iRed   - The intensity of the red color.
;                  $iGreen - The intensity of the green color.
;                  $iBlue  - The intensity of the blue color.
; Return values..: The resultant RGB color.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RGB($iRed, $iGreen, $iBlue)
	Return __IsRGB(BitOR(BitShift($iBlue, -16), BitShift($iGreen, -8), $iRed))
EndFunc   ;==>_WinAPI_RGB

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_RoundRect
; Description....: Draws a rectangle with rounded corners.
; Syntax.........: _WinAPI_RoundRect ( $hDC, $tRECT, $iWidth, $iHeight )
; Parameters.....: $hDC     - Handle to the device context.
;                  $tRECT   - $tagRECT structure that contains the logical coordinates of the rectangle.
;                  $iWidth  - The width, in logical coordinates, of the ellipse used to draw the rounded corners.
;                  $iHeight - The height, in logical coordinates, of the ellipse used to draw the rounded corners.
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The rectangle is outlined by using the current pen and filled by using the current brush.
; Related........:
; Link...........: @@MsdnLink@@ RoundRect
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_RoundRect($hDC, $tRECT, $iWidth, $iHeight)

	Local $Ret = DllCall('gdi32.dll', 'int', 'RoundRect', 'hwnd', $hDC, 'int', DllStructGetData($tRECT, 1), 'int', DllStructGetData($tRECT, 2), 'int', DllStructGetData($tRECT, 3), 'int', DllStructGetData($tRECT, 4), 'int', $iWidth, 'int', $iHeight)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_RoundRect

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SaveDC
; Description....: Saves the current state of the specified device context (DC) by copying data describing selected objects and
;                  graphic modes to a context stack.
; Syntax.........: _WinAPI_SaveDC ( $hDC )
; Parameters.....: $hDC    - Handle to the DC whose state is to be saved.
; Return values..: Success - The value identifies the saved state.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SaveDC
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SaveDC($hDC)

	Local $Ret  = DllCall('gdi32.dll', 'ptr', 'SaveDC', 'hwnd', $hDC)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_SaveDC

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SendMessageTimeout
; Description....: Sends the specified message to one of more windows.
; Syntax.........: _WinAPI_SendMessageTimeout ( $hWnd, $iMessage [, $wParam [, $lParam [, $iTimeout [, $iFlags]]]] )
; Parameters.....: $hWnd     - Handle to the window whose window procedure will receive the message.
;                  $iMessage - The message to be sent.
;                  $wParam   - Additional message-specific information.
;                  $lParam   - Additional message-specific information.
;                  $iTimeout - The duration, in milliseconds, of the time-out period. If the message is a broadcast message, each
;                              window can use the full time-out period. Default is 1000.
;                  $iFlags   - The flags that specifies how to send the message. This parameter can be one or more of the
;                              following values.
;
;                              $SMTO_BLOCK
;                              $SMTO_NORMAL
;                              $SMTO_ABORTIFHUNG
;                              $SMTO_NOTIMEOUTIFNOTHUNG
;                              $SMTO_ERRORONEXIT
;
; Return values..: Success   - The result of the message processing, depends on the message sent.
;                  Failure   - (-1) and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function does not provide information about individual windows timing out if $HWND_BROADCAST is used.
;
;                  If times out, function fails. To get extended error information, call _WinAPI_GetLastError(). If _WinAPI_GetLastError()
;                  returns ERROR_TIMEOUT, then the function timed out. This function considers a thread is not responding if it has
;                  not responds within five seconds.
;
;                  The system only does marshalling for system messages (those in the range 0 to (WM_USER-1)). To send other messages
;                  (those >= WM_USER) to another process, you must do custom marshalling.
; Related........:
; Link...........: @@MsdnLink@@ SendMessageTimeout
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SendMessageTimeout($hWnd, $iMessage, $wParam = 0, $lParam = 0, $iTimeout = 1000, $iFlags = 0)

	Local $Ret = DllCall('user32.dll', 'lresult', 'SendMessageTimeoutW', 'hwnd', $hWnd, 'uint', $iMessage, 'wparam', $wParam, 'lparam', $lParam, 'uint', $iFlags, 'uint', $iTimeout, 'dword_ptr*', 0)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, -1)
	EndIf
	Return $Ret[7]
EndFunc   ;==>_WinAPI_SendMessageTimeout

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetActiveWindow
; Description....: Activates the specified window.
; Syntax.........: _WinAPI_SetActiveWindow ( $hWnd )
; Parameters.....: $hWnd   - Handle to the top-level window to be activated.
; Return values..: Success - Handle to the window that was previously active.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SetActiveWindow
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SetActiveWindow($hWnd)

	Local $Ret = DllCall('user32.dll', 'int', 'SetActiveWindow', 'hwnd', $hWnd)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_SetActiveWindow

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetClassLong
; Description....: Replaces the specified 32-bit (long) value into the specified window belongs.
; Syntax.........: _WinAPI_SetClassLong ( $hWnd, $iIndex, $iNewLong )
; Parameters.....: $hWnd     - Handle to the window and, indirectly, the class to which the window belongs.
;                  $iIndex   - The 32-bit value to replace. This parameter can be one of the following values.
;
;                              $GCL_CBCLSEXTRA
;                              $GCL_CBWNDEXTRA
;                              $GCL_HBRBACKGROUND
;                              $GCL_HCURSOR
;                              $GCL_HICON
;                              $GCL_HICONSM
;                              $GCL_HMODULE
;                              $GCL_MENUNAME
;                              $GCL_STYLE
;                              $GCL_WNDPROC
;
;                  $iNewLong - The replacement value.
; Return values..: Success   - The previous value of the specified 32-bit integer. If the value was not previously set, the return value is zero.
;                  Failure   - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SetClassLong
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SetClassLong($hWnd, $iIndex, $iNewLong)

	Local $Ret = DllCall('user32.dll', 'int', 'SetClassLong', 'hwnd', $hWnd, 'int', $iIndex, 'long', $iNewLong)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_SetClassLong

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetCompression
; Description....: Sets the compression state of a file or directory.
; Syntax.........: _WinAPI_SetCompression ( $sPath, $iCompression )
; Parameters.....: $sPath        - Path to file or directory to be compressed.
;                  $iCompression - One of the following compression constants.
;
;                                  $COMPRESSION_FORMAT_NONE
;                                  $COMPRESSION_FORMAT_DEFAULT
;                                  $COMPRESSION_FORMAT_LZNT1
;
; Return values..: Success       - 1.
;                  Failure       - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: If the file system of the volume containing the specified file or directory does not support per-file or
;                  per-directory compression, the function fails. File compression is supported for files of a maximum uncompressed
;                  size of 30 gigabytes.
; Related........:
; Link...........: @@MsdnLink@@ FSCTL_SET_COMPRESSION
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SetCompression($sPath, $iCompression)

	Local $hFile = _WinAPI_CreateFileEx($sPath, 3, 0xC0000000, 0x03, 0x02000000)

	If Not $hFile Then
		Return SetError(1, 0, 0)
	EndIf

	Local $tData = DllStructCreate('ushort')

	DllStructSetData($tData, 1, $iCompression)

	Local $Ret = DllCall('kernel32.dll', 'int', 'DeviceIoControl', 'ptr', $hFile, 'dword', 0x0009C040, 'ptr', DllStructGetPtr($tData), 'dword', DllStructGetSize($tData), 'ptr', 0, 'dword', 0, 'dword*', 0, 'ptr', 0)

	If (@error) Or (Not $Ret[0]) Then
		$Ret = 0
	EndIf
	_WinAPI_FreeHandle($hFile)
	If Not IsArray($Ret) Then
		Return SetError(2, 0, 0)
	EndIf
	Return SetError(0, 0, 1)
EndFunc   ;==>_WinAPI_SetCompression

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetCaretBlinkTime
; Description....: Sets the caret blink time.
; Syntax.........: _WinAPI_SetCaretBlinkTime ( $iDuration )
; Parameters.....: $iDuration - The new blink time, in milliseconds. If this parameter is (-1), caret does not blink.
; Return values..: Success    - The previous blink time, in milliseconds.
;                  Failure    - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The user can set the blink time using the Control Panel. Applications should respect the setting that the user
;                  has chosen. This function should only be used by application that allow the user to set the blink time, such
;                  as a Control Panel applet.
; Related........:
; Link...........: @@MsdnLink@@ SetCaretBlinkTime
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SetCaretBlinkTime($iDuration)

	Local $Prev = _WinAPI_GetCaretBlinkTime()

	If @error Then
		Return SetError(1, 0, 0)
	EndIf

	Local $Ret = DllCall('user32.dll', 'int', 'SetCaretBlinkTime', 'uint', $iDuration)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Prev
EndFunc   ;==>_WinAPI_SetCaretBlinkTime

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetCaretPos
; Description....: Moves the caret to the specified coordinates.
; Syntax.........: _WinAPI_SetCaretPos ( $iX, $iY )
; Parameters.....: $iX     - The new x-coordinate of the caret.
;                  $iY     - The new y-coordinate of the caret.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SetCaretPos
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SetCaretPos($iX, $iY)

	Local $Ret = DllCall('user32.dll', 'int', 'SetCaretPos', 'int', $iX, 'int', $iY)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_SetCaretPos

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetCurrentDirectory
; Description....: Changes the current directory for the current process.
; Syntax.........: _WinAPI_SetCurrentDirectory ( $sDir )
; Parameters.....: $sDir   - The path to the new current directory.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SetCurrentDirectory
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SetCurrentDirectory($sDir)

	Local $Ret = DllCall('kernel32.dll', 'int', 'SetCurrentDirectoryW', 'wstr', $sDir)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_SetCurrentDirectory

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetDefaultPrinter
; Description....: Sets the printer name of the default printer for the current user on the local computer.
; Syntax.........: _WinAPI_SetDefaultPrinter ( $sPrinter )
; Parameters.....: $sPrinter - The default printer name. For a remote printer, the name format is \\server\printername. For a local
;                              printer, the name format is printername. If this parameter is empty string, this function will
;                              select a default printer from one of the installed printers.
; Return values..: Success   - 1.
;                  Failure   - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SetDefaultPrinter
; Example........: Yes
; ===============================================================================================================================

#cs

Func _WinAPI_SetDefaultPrinter($sPrinter)

	Local $Ret = DllCall('winspool.drv', 'int', 'SetDefaultPrinterW', 'wstr', $sPrinter)

    If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
    Return 1
EndFunc   ;==>_WinAPI_SetDefaultPrinter

#ce

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetDCBrushColor
; Description....: Sets the current device context (DC) brush color to the specified color value.
; Syntax.........: _WinAPI_SetDCBrushColor ( $hDC, $iRGB )
; Parameters.....: $hDC    - Handle to the device context.
;                  $iRGB   - The new brush color, in RGB.
; Return values..: Success - The value that specifies the previous DC brush color, in RGB.
;                  Failure - (-1) and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The function returns the previous $DC_BRUSH color, even if the stock brush $DC_BRUSH is not selected in the DC:
;                  however, this will not be used in drawing operations until the stock $DC_BRUSH is selected in the DC.
; Related........:
; Link...........: @@MsdnLink@@ SetDCBrushColor
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SetDCBrushColor($hDC, $iRGB)

	Local $Ret = DllCall('gdi32.dll', 'dword', 'SetDCBrushColor', 'hwnd', $hDC, 'dword', __IsRGB($iRGB))

	If (@error) Or ($Ret[0] = -1) Then
		Return SetError(1, 0, -1)
	EndIf
	Return __IsRGB($Ret[0])
EndFunc   ;==>_WinAPI_SetDCBrushColor

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetDCPenColor
; Description....: Sets the current device context (DC) pen color to the specified color value.
; Syntax.........: _WinAPI_SetDCPenColor ( $hDC, $iRGB )
; Parameters.....: $hDC    - Handle to the device context.
;                  $iRGB   - The new pen color, in RGB.
; Return values..: Success - The value that specifies the previous DC pen color, in RGB.
;                  Failure - (-1) and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The function returns the previous $DC_PEN color, even if the stock pen $DC_PEN is not selected in the DC;
;                  however, this will not be used in drawing operations until the stock $DC_PEN is selected in the DC.
; Related........:
; Link...........: @@MsdnLink@@ SetDCPenColor
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SetDCPenColor($hDC, $iRGB)

	Local $Ret = DllCall('gdi32.dll', 'dword', 'SetDCPenColor', 'hwnd', $hDC, 'dword', __IsRGB($iRGB))

	If (@error) Or ($Ret[0] = -1) Then
		Return SetError(1, 0, -1)
	EndIf
	Return __IsRGB($Ret[0])
EndFunc   ;==>_WinAPI_SetDCPenColor

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetFilePointerEx
; Description....: Moves the file pointer of the specified file.
; Syntax.........: _WinAPI_SetFilePointerEx ( $hFile, $iPos [, $iMethod] )
; Parameters.....: $hFile   - Handle to the file.
;                  $iPos    - The number of bytes to move the file pointer. A positive value moves the pointer forward in the
;                             file and a negative value moves the file pointer backward.
;                  $iMethod - The starting point for the file pointer move. This parameter can be one of the following values.
;
;                             $FILE_BEGIN
;                             $FILE_CURRENT
;                             $FILE_END
;
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SetFilePointerEx
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SetFilePointerEx($hFile, $iPos, $iMethod = 0)

	Local $Ret = DllCall('kernel32.dll', 'int', 'SetFilePointerEx', 'ptr', $hFile, 'int64', $iPos, 'int64*', 0, 'dword', $iMethod)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_SetFilePointerEx

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetForegroundWindow
; Description....: Puts the specified window into the foreground and activates its.
; Syntax.........: _WinAPI_SetForegroundWindow ( $hWnd )
; Parameters.....: $hWnd   - Handle to the window that should be activated and brought to the foreground.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SetForegroundWindow
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SetForegroundWindow($hWnd)

	Local $Ret = DllCall('user32.dll', 'int', 'SetForegroundWindow', 'hwnd', $hWnd)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_SetForegroundWindow

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetHandleInformation
; Description....: Sets certain properties of an object handle.
; Syntax.........: _WinAPI_SetHandleInformation ( $hObject, $iMask, $iFlags )
; Parameters.....: $hObject - Handle to an object whose information is to be set.
;                  $iMask   - The mask that specifies the bit flags to be changed. Use the same constants as that of the $iFlags.
;                  $iFlags  - The flags that specifies properties of the object handle. This parameter can be 0 or one or
;                             more of the following values.
;
;                             $HANDLE_FLAG_INHERIT
;                             $HANDLE_FLAG_PROTECT_FROM_CLOSE
;
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SetHandleInformation
; Example........: Yes
; ===============================================================================================================================

#cs

Func _WinAPI_SetHandleInformation($hObject, $iMask, $iFlags)

	Local $Ret = DllCall('kernel32.dll', 'int', 'SetHandleInformation', 'ptr', $hObject, 'dword', $iMask, 'dword', $iFlags)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_SetHandleInformation

#ce

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetInformationJobObject
; Description....: Sets limits for a job object.
; Syntax.........: _WinAPI_SetInformationJobObject ( $hJob, $iJobObjectInfoClass, $tJobObjectInfo )
; Parameters.....: $hJob                - Handle to the job whose limits are being set. The handle must have the
;                                         $JOB_OBJECT_SET_ATTRIBUTES access right.
;                  $iJobObjectInfoClass - The information class for the limits to be set. This parameter specifies the type
;                                         of $tJobObjectInfo structure, valid values:
;                  |2  - $tagJOBOBJECT_BASIC_LIMIT_INFORMATION
;                  |4  - $tagJOBOBJECT_BASIC_UI_RESTRICTIONS
;                  |5  - $tagJOBOBJECT_SECURITY_LIMIT_INFORMATION
;                  |6  - $tagJOBOBJECT_END_OF_JOB_TIME_INFORMATION
;                  |7  - $tagJOBOBJECT_ASSOCIATE_COMPLETION_PORT
;                  |9  - $tagJOBOBJECT_EXTENDED_LIMIT_INFORMATION
;                  |11 - $tagJOBOBJECT_GROUP_INFORMATION
;                  $tJobObjectInfo      - $tagJOBOBJECT_... structure that sets the limit and job state information.
; Return values..: Success              - 1.
;                  Failure              - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SetInformationJobObject
; Example........: Yes
; ===============================================================================================================================


Func _WinAPI_SetInformationJobObject($hJob, $iJobObjectInfoClass, $tJobObjectInfo)

	Local $Ret = DllCall('kernel32.dll', 'int', 'SetInformationJobObject', 'ptr', $hJob, 'int', $iJobObjectInfoClass, 'ptr', DllStructGetPtr($tJobObjectInfo), 'dword', DllStructGetSize($tJobObjectInfo))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_SetInformationJobObject

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetKeyboardLayout
; Description....: Sets an input locale identifier to the specified window.
; Syntax.........: _WinAPI_SetKeyboardLayout ( $hWnd, $iLanguage )
; Parameters.....: $hWnd      - Handle to the window to set input locale identifier.
;                  $iLanguage - The name of the input locale identifier (LCID).
;
;                               0x0436 - Afrikaans
;                               0x041C - Albanian
;                               0x0401 - Arabic
;                               0x1401 - Arabic Algeria
;                               0x3C01 - Arabic Bahrain
;                               0x0C01 - Arabic Egypt
;                               0x0801 - Arabic Iraq
;                               0x2C01 - Arabic Jordan
;                               0x3401 - Arabic Kuwait
;                               0x3001 - Arabic Lebanon
;                               0x1001 - Arabic Libya
;                               0x1801 - Arabic Morocco
;                               0x2001 - Arabic Oman
;                               0x4001 - Arabic Qatar
;                               0x0401 - Arabic Saudi Arabia
;                               0x2801 - Arabic Syria
;                               0x1C01 - Arabic Tunisia
;                               0x3801 - Arabic U.A.E
;                               0x2401 - Arabic Yemen
;                               0x042B - Armenian
;                               0x044D - Assamese
;                               0x082C - Azeri Cyrillic
;                               0x042C - Azeri Latin
;                               0x042D - Basque
;                               0x0813 - Belgian Dutch
;                               0x080C - Belgian French
;                               0x0445 - Bengali
;                               0x0416 - Portuguese (Brazil)
;                               0x0402 - Bulgarian
;                               0x0455 - Burmese
;                               0x0423 - Byelorussian (Belarusian)
;                               0x0403 - Catalan
;                               0x0C04 - Chinese Hong Kong SAR
;                               0x1404 - Chinese Macau SAR
;                               0x0804 - Chinese Simplified
;                               0x1004 - Chinese Singapore
;                               0x0404 - Chinese Traditional
;                               0x041A - Croatian
;                               0x0405 - Czech
;                               0x0406 - Danish
;                               0x0413 - Dutch
;                               0x0C09 - English Australia
;                               0x2809 - English Belize
;                               0x1009 - English Canadian
;                               0x2409 - English Caribbean
;                               0x1813 - English Ireland
;                               0x2009 - English Jamaica
;                               0x1409 - English New Zealand
;                               0x3409 - English Philippines
;                               0x1C09 - English South Africa
;                               0x2C09 - English Trinidad
;                               0x0809 - English U.K.
;                               0x0409 - English U.S.
;                               0x3009 - English Zimbabwe
;                               0x0425 - Estonian
;                               0x0438 - Faeroese
;                               0x0429 - Farsi
;                               0x040B - Finnish
;                               0x040C - French
;                               0x2C0C - French Cameroon
;                               0x0C0C - French Canadian
;                               0x300C - French Cote d'Ivoire
;                               0x140C - French Luxembourg
;                               0x340C - French Mali
;                               0x180C - French Monaco
;                               0x200C - French Reunion
;                               0x280C - French Senegal
;                               0x1C0C - French West Indies
;                               0x240C - French Congo (DRC)
;                               0x0462 - Frisian Netherlands
;                               0x083C - Gaelic Ireland
;                               0x043C - Gaelic Scotland
;                               0x0456 - Galician
;                               0x0437 - Georgian
;                               0x0407 - German
;                               0x0C07 - German Austria
;                               0x1407 - German Liechtenstein
;                               0x1007 - German Luxembourg
;                               0x0408 - Greek
;                               0x0447 - Gujarati
;                               0x040D - Hebrew
;                               0x0439 - Hindi
;                               0x040E - Hungarian
;                               0x040F - Icelandic
;                               0x0421 - Indonesian
;                               0x0410 - Italian
;                               0x0411 - Japanese
;                               0x044B - Kannada
;                               0x0460 - Kashmiri
;                               0x043F - Kazakh
;                               0x0453 - Khmer
;                               0x0440 - Kirghiz
;                               0x0457 - Konkani
;                               0x0412 - Korean
;                               0x0454 - Lao
;                               0x0426 - Latvian
;                               0x0427 - Lithuanian
;                               0x042F - FYRO Macedonian
;                               0x044C - Malayalam
;                               0x083E - Malay Brunei Darussalam
;                               0x043E - Malaysian
;                               0x043A - Maltese
;                               0x0458 - Manipuri
;                               0x044E - Marathi
;                               0x0450 - Mongolian
;                               0x0461 - Nepali
;                               0x0414 - Norwegian Bokmol
;                               0x0814 - Norwegian Nynorsk
;                               0x0448 - Oriya
;                               0x0415 - Polish
;                               0x0816 - Portuguese
;                               0x0446 - Punjabi
;                               0x0417 - Rhaeto-Romanic
;                               0x0418 - Romanian
;                               0x0818 - Romanian Moldova
;                               0x0419 - Russian
;                               0x0819 - Russian Moldova
;                               0x043B - Sami Lappish
;                               0x044F - Sanskrit
;                               0x0C1A - Serbian Cyrillic
;                               0x081A - Serbian Latin
;                               0x0430 - Sesotho
;                               0x0459 - Sindhi
;                               0x041B - Slovak
;                               0x0424 - Slovenian
;                               0x042E - Sorbian
;                               0x040A - Spanish (Traditional)
;                               0x2C0A - Spanish Argentina
;                               0x400A - Spanish Bolivia
;                               0x340A - Spanish Chile
;                               0x240A - Spanish Colombia
;                               0x140A - Spanish Costa Rica
;                               0x1C0A - Spanish Dominican Republic
;                               0x300A - Spanish Ecuador
;                               0x440A - Spanish El Salvador
;                               0x100A - Spanish Guatemala
;                               0x480A - Spanish Honduras
;                               0x4C0A - Spanish Nicaragua
;                               0x180A - Spanish Panama
;                               0x3C0A - Spanish Paraguay
;                               0x280A - Spanish Peru
;                               0x500A - Spanish Puerto Rico
;                               0x0C0A - Spanish Spain (Modern Sort)
;                               0x380A - Spanish Uruguay
;                               0x200A - Spanish Venezuela
;                               0x0430 - Sutu
;                               0x0441 - Swahili
;                               0x041D - Swedish
;                               0x081D - Swedish Finland
;                               0x100C - Swiss French
;                               0x0807 - Swiss German
;                               0x0810 - Swiss Italian
;                               0x0428 - Tajik
;                               0x0449 - Tamil
;                               0x0444 - Tatar
;                               0x044A - Telugu
;                               0x041E - Thai
;                               0x0451 - Tibetan
;                               0x0431 - Tsonga
;                               0x0432 - Tswana
;                               0x041F - Turkish
;                               0x0442 - Turkmen
;                               0x0422 - Ukrainian
;                               0x0420 - Urdu
;                               0x0843 - Uzbek Cyrillic
;                               0x0443 - Uzbek Latin
;                               0x0433 - Venda
;                               0x042A - Vietnamese
;                               0x0452 - Welsh
;                               0x0434 - Xhosa
;                               0x0435 - Zulu
;
; Return values..: Success    - 1.
;                  Failure    - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: If the input locale identifier corresponding to $iLanguage parameter is not loaded into the system at the time
;                  of function call, _WinAPI_SetKeyboardLayout() is fails.
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SetKeyboardLayout($hWnd, $iLanguage)

	If Not _WinAPI_IsLoadKBLayout($iLanguage) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $hLocale = _WinAPI_LoadKeyboardLayout($iLanguage)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	DllCall('user32.dll', 'none', 'SendMessage', 'hwnd', $hWnd, 'uint', 0x0050, 'uint', 1, 'long', $hLocale)
	Return SetError(0, 0, 1)
EndFunc   ;==>_WinAPI_SetKeyboardLayout

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetKeyboardState
; Description....: Copies a 256-byte array of keyboard key states into the calling process's keyboard input-state table.
; Syntax.........: _WinAPI_SetKeyboardState ( $tState )
; Parameters.....: $tData  - "byte[256]" structure that contains keyboard key states.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function alters the input state of the calling process and not the global input state of the system.
;                  You cannot use this function to set the NUM LOCK, CAPS LOCK, or SCROLL LOCK indicator lights on the
;                  keyboard.
; Related........:
; Link...........: @@MsdnLink@@ SetKeyboardState
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SetKeyboardState($tData)

	Local $Ret = DllCall('user32.dll', 'int', 'SetKeyboardState', 'ptr', DllStructGetPtr($tData))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_SetKeyboardState

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetLayeredWindowAttributes
; Description....: Sets the opacity and transparency color key of a layered window.
; Syntax.........: _WinAPI_SetLayeredWindowAttributes ( $hWnd, $iRGB, $iAlpha, $iFlags )
; Parameters.....: $hWnd   - Handle to the layered window.
;                  $iRGB   - The transparency color key (in RGB) to be used when composing the layered window. All pixels painted
;                            by the window in this color will be transparent.
;                  $iAlpha - Alpha value used to describe the opacity of the layered window. When this parameter is 0, the window
;                            is completely transparent. When this parameter is 255, the window is opaque.
;                  $iFlags - This parameter specifies an action to take, and can be one or more of the following values.
;
;                            $LWA_COLORKEY
;                            $LWA_ALPHA
;
; Return values..: Success - 1
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: ProgAndy
; Modified.......: Yashied
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SetLayeredWindowAttributes
; Example........: Yes
; ===============================================================================================================================

#cs

Func _WinAPI_SetLayeredWindowAttributes($hWnd, $iRGB, $iAlpha, $iFlags)

	Local $Ret = DllCall('user32.dll', 'int', 'SetLayeredWindowAttributes', 'hwnd', $hWnd, 'long', __IsRGB($iRGB), 'byte', $iAlpha, 'long', $iFlags)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_SetLayeredWindowAttributes

#ce

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetLibraryColorMode
; Description....: Sets the color mode for the WinAPIEx library.
; Syntax.........: _WinAPI_SetLibraryColorMode ( $iMode )
; Parameters.....: $iMode - Specifies the color mode, valid values:
;                  |TRUE  - RGB
;                  |FALSE - BGR
; Return values..: None
; Author.........: Yashied
; Modified.......:
; Remarks........: The functions of this library, in which passes or which returns the color values, works with the values in
;                  accordance with the color mode that been set by this function. Initial color mode is RGB.
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SetLibraryColorMode($iMode)
	$__RGB = Not ($iMode = 0)
EndFunc   ;==>_WinAPI_SetLibraryColorMode

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetParent
; Description....: Changes the parent window of the specified child window.
; Syntax.........: _WinAPI_SetParent ( $hWndChild, $hWndParent )
; Parameters.....: $hWndChild  - Handle to the child window.
;                  $hWndParent - Handle to the new parent window. If this parameter is 0, the desktop window becomes the new parent window.
; Return values..: Success     - Handle to the previous parent window.
;                  Failure     - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: An application can use the _WinAPI_SetParent() function to set the parent window of a pop-up, overlapped,
;                  or child window.
; Related........:
; Link...........: @@MsdnLink@@ SetParent
; Example........: Yes
; ===============================================================================================================================

#cs

Func _WinAPI_SetParent($hWndChild, $hWndParent)

	Local $Ret = DllCall('user32.dll', 'hwnd', 'SetParent', 'hwnd', $hWndChild, 'hwnd', $hWndParent)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_SetParent

#ce

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetPixel
; Description....: Sets the pixel at the specified coordinates to the specified color.
; Syntax.........: _WinAPI_SetPixel ( $hDC, $iX, $iY, $iRGB )
; Parameters.....: $hDC    - Handle to the device context.
;                  $iX     - The x-coordinate, in logical units, of the point to be set.
;                  $iY     - The y-coordinate, in logical units, of the point to be set.
;                  $iRGB   - The color to be used to paint the point.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SetPixelV
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SetPixel($hDC, $iX, $iY, $iRGB)

	Local $Ret = DllCall('gdi32.dll', 'int', 'SetPixelV', 'hwnd', $hDC, 'int', $iX, 'int', $iY, 'dword', __IsRGB($iRGB))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_SetPixel

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetROP2
; Description....: Retrieves the foreground mix mode of the specified device context.
; Syntax.........: _WinAPI_SetROP2 ( $hDC, $iMode )
; Parameters.....: $hDC    - Handle to the device context.
;                  $iMode  - The mix mode. This parameter can be one of the following values.
;
;                            $R2_BLACK
;                            $R2_COPYPEN
;                            $R2_LAST
;                            $R2_MASKNOTPEN
;                            $R2_MASKPEN
;                            $R2_MASKPENNOT
;                            $R2_MERGENOTPEN
;                            $R2_MERGEPEN
;                            $R2_MERGEPENNOT
;                            $R2_NOP
;                            $R2_NOT
;                            $R2_NOTCOPYPEN
;                            $R2_NOTMASKPEN
;                            $R2_NOTMERGEPEN
;                            $R2_NOTXORPEN
;                            $R2_WHITE
;                            $R2_XORPEN
;
; Return values..: Success - The value that specifies the previous mix mode.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: Mix modes define how GDI combines source and destination colors when drawing with the current pen. The mix modes
;                  are binary raster operation codes, representing all possible Boolean functions of two variables, using the binary
;                  operations AND, OR, and XOR (exclusive OR), and the unary operation NOT. The mix mode is for raster devices only;
;                  it is not available for vector devices.
; Related........:
; Link...........: @@MsdnLink@@ SetROP2
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SetROP2($hDC, $iMode)

	Local $Ret = DllCall('gdi32.dll', 'int', 'SetROP2', 'hwnd', $hDC, 'int', $iMode)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_SetROP2

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetStretchBltMode
; Description....: Sets the bitmap stretching mode in the specified device context.
; Syntax.........: _WinAPI_SetStretchBltMode ( $hDC, $iMode )
; Parameters.....: $hDC     - Handle to the device context.
;                  $iMode   - The stretching mode. This parameter can be one of the following values.
;
;                             $BLACKONWHITE
;                             $COLORONCOLOR
;                             $HALFTONE
;                             $WHITEONBLACK
;                             $STRETCH_ANDSCANS
;                             $STRETCH_DELETESCANS
;                             $STRETCH_HALFTONE
;                             $STRETCH_ORSCANS
;
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The $BLACKONWHITE ($STRETCH_ANDSCANS) and $WHITEONBLACK ($STRETCH_ORSCANS) modes are typically used to
;                  preserve foreground pixels in monochrome bitmaps. The $COLORONCOLOR ($STRETCH_DELETESCANS) mode is typically
;                  used to preserve color in color bitmaps. The $HALFTONE ($STRETCH_HALFTONE) mode is slower and requires more
;                  processing of the source image than the other three modes; but produces higher quality images.
; Related........:
; Link...........: @@MsdnLink@@ SetStretchBltMode
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SetStretchBltMode($hDC, $iMode)

	Local $Ret  = DllCall('gdi32.dll', 'int', 'SetStretchBltMode', 'hwnd', $hDC, 'int', $iMode)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_SetStretchBltMode

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetSystemCursor
; Description....: Enables an application to customize the system cursors.
; Syntax.........: _WinAPI_SetSystemCursor ( $hCursor, $ID [, $fDuplicate] )
; Parameters.....: $hCursor    - Handle to a cursor.
;                  $ID         - This parameter specifies the system cursor to replace with the contents of $hCursor, and can be
;                                one of the following values.
;
;                                $OCR_APPSTARTING
;                                $OCR_NORMAL
;                                $OCR_CROSS
;                                $OCR_HAND
;                                $OCR_IBEAM
;                                $OCR_NO
;                                $OCR_SIZEALL
;                                $OCR_SIZENESW
;                                $OCR_SIZENS
;                                $OCR_SIZENWSE
;                                $OCR_SIZEWE
;                                $OCR_UP
;                                $OCR_WAIT
;                                $OCR_ICON
;                                $OCR_SIZE
;
;                  $fDuplicate - Specifies whether the cursor should be duplicated, valid values:
;                  |TRUE       - The cursor is duplicated.
;                  |FALSE      - The cursor is not duplicated. (Default)
; Return values..: Success     - 1.
;                  Failure     - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The function replaces the contents of the system cursor specified by ID with the contents of the cursor handled
;                  by $hCursor. The system destroys hcur by calling the _WinAPI_FreeCursor() function. Therefore, $hCursor cannot be
;                  a cursor loaded using the _WinAPI_LoadCursor() function. To specify a cursor loaded from a resource, copy the
;                  cursor using the _WinAPI_DuplicateCursor() function, then pass the copy to _WinAPI_SetSystemCursor().
; Related........:
; Link...........: @@MsdnLink@@ SetSystemCursor
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SetSystemCursor($hCursor, $ID, $fDuplicate = 0)

	If $fDuplicate Then
		$hCursor = _WinAPI_DuplicateCursor($hCursor)
	EndIf

	Local $Ret = DllCall('user32.dll', 'int', 'SetSystemCursor', 'ptr', $hCursor, 'dword', $ID)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_SetSystemCursor

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetThemeAppProperties
; Description....: Sets the flags that determine how visual styles are implemented in the calling application.
; Syntax.........: _WinAPI_SetThemeAppProperties ( $iFlags )
; Parameters.....: $iFlags  - This parameter can be one or more of the following values.
;
;                            $STAP_ALLOW_NONCLIENT
;                            $STAP_ALLOW_CONTROLS
;                            $STAP_ALLOW_WEBCONTENT
;
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: After you set the flags, you must send a WM_THEMECHANGED message for the changes to take effect.
; Related........:
; Link...........: @@MsdnLink@@ SetThemeAppProperties
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SetThemeAppProperties($iFlags)
	DllCall('uxtheme.dll', 'none', 'SetThemeAppProperties', 'dword', $iFlags)
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_SetThemeAppProperties

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetTimer
; Description....: Creates a timer with the specified time-out value.
; Syntax.........: _WinAPI_SetTimer ( $hWnd, $iTimerID, $iElapse, $pTimerFunc )
; Parameters.....: $hWnd       - Handle to the window to be associated with the timer. This window must be owned by the calling
;                                process. If a 0 value for $hWnd is passed in along with an $iTimerID of an existing timer, that
;                                timer will be replaced in the same way that an existing non-zero $hWnd timer will be.
;                  $iTimerID   - The timer identifier. If the $hWnd parameter is 0, and the $iTimerID does not match an existing
;                                timer then it is ignored and a new timer ID is generated. If the $hWnd parameter is not 0 and
;                                the window specified by $hWnd already has a timer with the value $iTimerID, then the existing
;                                timer is replaced by the new timer. When _WinAPI_SetTimer() replaces a timer, the timer is reset.
;                                Therefore, a message will be sent after the current time-out value elapses, but the previously
;                                set time-out value is ignored. If the call is not intended to replace an existing timer,
;                                $iTimerID should be 0 if the $hWnd is 0.
;                  $iElapse    - The time-out value, in milliseconds.
;                  $pTimerFunc - The address of a callback function to be notified when the time-out value elapses. If this
;                                parameter is 0, the system posts a WM_TIMER message to the application queue.
;
;                                (See MSDN for more information)
;
; Return values..: Success     - The timer identifier. An application can pass this value to the _WinAPI_KillTimer() function to
;                                destroy the timer.
;                  Failure     - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The timer identifier, $iTimerID, is specific to the associated window. Another window can have its own timer
;                  which has the same identifier as a timer owned by another window. The timers are distinct.
; Related........:
; Link...........: @@MsdnLink@@ SetTimer
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SetTimer($hWnd, $iTimerID, $iElapse, $pTimerFunc)

	Local $Ret = DllCall('user32.dll', 'uint_ptr', 'SetTimer', 'hwnd', $hWnd, 'uint_ptr', $iTimerID, 'uint', $iElapse, 'ptr', $pTimerFunc)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_SetTimer

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SetVolumeMountPoint
; Description....: Associates a volume with a drive letter or a directory on another volume.
; Syntax.........: _WinAPI_SetVolumeMountPoint ( $sPath, $GUID )
; Parameters.....: $sPath  - The user-mode path to be associated with the volume. This may be a drive letter (for example, X:\)
;                            or a directory on another volume (for example, Y:\MountX).
;                  $GUID   - The volume GUID path for the volume. This string must be of the form "\\?\Volume{GUID}\" where
;                            GUID is a GUID that identifies the volume. The \\?\ turns off path parsing and is ignored as part
;                            of the path.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: It is an error to associate a volume with a directory that has any files or subdirectories in it. This error
;                  occurs for system and hidden directories as well as other directories, and it occurs for system and hidden
;                  files.
; Related........:
; Link...........: @@MsdnLink@@ SetVolumeMountPoint
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SetVolumeMountPoint($sPath, $GUID)

	Local $Ret = DllCall('kernel32.dll', 'int', 'SetVolumeMountPointW', 'wstr', $sPath, 'wstr', $GUID)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_SetVolumeMountPoint

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShellAddToRecentDocs
; Description....: Adds a file to the most recently and frequently item list.
; Syntax.........: _WinAPI_ShellAddToRecentDocs ( $sFile )
; Parameters.....: $sFile  - The name of the file to be added. Set this parameter to empty string to clear all usage data on all items.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SHAddToRecentDocs
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShellAddToRecentDocs($sFile)

	Local $TypeOfFile = 'wstr'

	$sFile = _WinAPI_PathSearchAndQualify($sFile)
	If $sFile Then
		If Not FileExists($sFile) Then
			Return SetError(1, 0, 0)
		EndIf
	Else
		$TypeOfFile = 'ptr'
		$sFile = 0
	EndIf

	Local $Ret = DllCall('shell32.dll', 'none', 'SHAddToRecentDocs', 'uint', 3, $TypeOfFile, $sFile)

	If @error Then
		Return SetError(2, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_ShellAddToRecentDocs

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShellChangeNotify
; Description....: Notifies the system of an event that an application has performed.
; Syntax.........: _WinAPI_ShellChangeNotify ( $iEvent, $iFlags [, $iItem1 [, $iItem2]] )
; Parameters.....: $iEvent - Describes the event that has occurred. Typically, only one event is specified at a time. If more than
;                            one event is specified, the values contained in the $iItem2 and $iItem2 parameters must be the same,
;                            respectively, for all specified events. This parameter can be one or more of the following values.
;
;                            $SHCNE_ALLEVENTS
;                            All events have occurred.
;
;                            $SHCNE_ASSOCCHANGED
;                            A file type association has changed. $SHCNF_IDLIST must be specified in $iFlags.
;                            $iItem1 and $iItem2 are not used and must be 0.
;
;                            $SHCNE_ATTRIBUTES
;                            The attributes of an item or folder have changed. $SHCNF_IDLIST or $SHCNF_PATH must be specified in $iFlags.
;                            $iItem1 contains the item or folder that has changed. $iItem2 is not used and should be 0.
;
;                            $SHCNE_CREATE
;                            A nonfolder item has been created. $SHCNF_IDLIST or $SHCNF_PATH must be specified in $iFlags.
;                            $iItem1 contains the item that was created. $iItem2 is not used and should be 0.
;
;                            $SHCNE_DELETE
;                            A nonfolder item has been deleted. $SHCNF_IDLIST or $SHCNF_PATH must be specified in $iFlags.
;                            $iItem1 contains the item that was deleted. $iItem2 is not used and should be 0.
;
;                            $SHCNE_DRIVEADD
;                            A drive has been added. $SHCNF_IDLIST or $SHCNF_PATH must be specified in $iFlags.
;                            $iItem1 contains the root of the drive that was added. $iItem2 is not used and should be 0.
;
;                            $SHCNE_DRIVEADDGUI
;                            Not used.
;
;                            $SHCNE_DRIVEREMOVED
;                            A drive has been removed. $SHCNF_IDLIST or $SHCNF_PATH must be specified in $iFlags.
;                            $iItem1 contains the root of the drive that was removed. $iItem2 is not used and should be 0.
;
;                            $SHCNE_EXTENDED_EVENT
;                            Not used.
;
;                            $SHCNE_FREESPACE
;                            The amount of free space on a drive has changed. $SHCNF_IDLIST or $SHCNF_PATH must be specified in $iFlags.
;                            $iItem1 contains the root of the drive on which the free space changed. $iItem2 is not used and should be 0.
;
;                            $SHCNE_MEDIAINSERTED
;                            Storage media has been inserted into a drive. $SHCNF_IDLIST or $SHCNF_PATH must be specified in $iFlags.
;                            $iItem1 contains the root of the drive that contains the new media. $iItem2 is not used and should be 0.
;
;                            $SHCNE_MEDIAREMOVED
;                            Storage media has been removed from a drive. $SHCNF_IDLIST or $SHCNF_PATH must be specified in $iFlags.
;                            $iItem1 contains the root of the drive from which the media was removed. $iItem2 is not used and should be 0.
;
;                            $SHCNE_MKDIR
;                            A folder has been created. $SHCNF_IDLIST or $SHCNF_PATH must be specified in $iFlags.
;                            $iItem1 contains the folder that was created. $iItem2 is not used and should be 0.
;
;                            $SHCNE_NETSHARE
;                            A folder on the local computer is being shared via the network. $SHCNF_IDLIST or $SHCNF_PATH must be specified in $iFlags.
;                            $iItem1 contains the folder that is being shared. $iItem2 is not used and should be 0.
;
;                            $SHCNE_NETUNSHARE
;                            A folder on the local computer is no longer being shared via the network. $SHCNF_IDLIST or $SHCNF_PATH must be specified in $iFlags.
;                            $iItem1 contains the folder that is no longer being shared. $iItem2 is not used and should be 0.
;
;                            $SHCNE_RENAMEFOLDER
;                            The name of a folder has changed. $SHCNF_IDLIST or $SHCNF_PATH must be specified in $iFlags.
;                            $iItem1 contains the previous pointer to an item identifier list (PIDL) or name of the folder. $iItem2 contains the new PIDL or name of the folder.
;
;                            $SHCNE_RENAMEITEM
;                            The name of a nonfolder item has changed. $SHCNF_IDLIST or $SHCNF_PATH must be specified in $iFlags.
;                            $iItem1 contains the previous PIDL or name of the item. $iItem2 contains the new PIDL or name of the item.
;
;                            $SHCNE_RMDIR
;                            A folder has been removed. $SHCNF_IDLIST or $SHCNF_PATH must be specified in $iFlags.
;                            $iItem1 contains the folder that was removed. $iItem2 is not used and should be 0.
;
;                            $SHCNE_SERVERDISCONNECT
;                            The computer has disconnected from a server. $SHCNF_IDLIST or $SHCNF_PATH must be specified in $iFlags.
;                            $iItem1 contains the server from which the computer was disconnected. $iItem2 is not used and should be 0.
;
;                            $SHCNE_UPDATEDIR
;                            The contents of an existing folder have changed, but the folder still exists and has not been renamed.
;                            $SHCNF_IDLIST or $SHCNF_PATH must be specified in $iFlags.
;                            $iItem1 contains the folder that has changed. $iItem2 is not used and should be 0. If a folder has been
;                            created, deleted, or renamed, use $SHCNE_MKDIR, $SHCNE_RMDIR, or $SHCNE_RENAMEFOLDER, respectively.
;
;                            $SHCNE_UPDATEIMAGE
;                            An image in the system image list has changed. $SHCNF_DWORD must be specified in $iFlags.
;                            $iItem1 contains the index in the system image list that has changed. $iItem2 is not used and should be 0.
;
;                            $SHCNE_UPDATEITEM
;                            An existing item (a folder or a nonfolder) has changed, but the item still exists and has not been renamed.
;                            $SHCNF_IDLIST or $SHCNF_PATH must be specified in $iFlags.
;                            $iItem1 contains the item that has changed. $iItem2 is not used and should be 0. If a nonfolder item has been
;                            created, deleted, or renamed, use $SHCNE_CREATE, $SHCNE_DELETE, or $SHCNE_RENAMEITEM, respectively, instead.
;
;                            $SHCNE_DISKEVENTS
;                            Specifies a combination of all of the disk event identifiers.
;
;                            $SHCNE_GLOBALEVENTS
;                            Specifies a combination of all of the global event identifiers.
;
;                            $SHCNE_INTERRUPT
;                            The specified event occurred as a result of a system interrupt. As this value modifies other event values,
;                            it cannot be used alone.
;
;                  $iFlags - Flags that indicate the meaning of the $iItem1 and $iItem2 parameters. This parameter must be one
;                            of the following values.
;
;                            $SHCNF_DWORD
;                            The $iItem1 and $iItem2 parameters are DWORD values.
;
;                            $SHCNF_IDLIST
;                            The $iItem1 and $iItem2 parameters are the addresses of ITEMIDLIST structures that represent the item(s)
;                            affected by the change. Each ITEMIDLIST must be relative to the desktop folder.
;
;                            $SHCNF_PATH
;                            The $iItem1 and $iItem2 parameters are the strings that contain the full path names of the items
;                            affected by the change.
;
;                            $SHCNF_PRINTER
;                            The $iItem1 and $iItem2 parameters are the strings that represent the friendly names of the printer(s)
;                            affected by the change.
;
;                            $SHCNF_FLUSH
;                            The function should not return until the notification has been delivered to all affected components.
;                            As this flag modifies other data-type flags, it cannot by used by itself.
;
;                            $SHCNF_FLUSHNOWAIT
;                            The function should begin delivering notifications to all affected components but should return as soon
;                            as the notification process has begun. As this flag modifies other data-type flags, it cannot by used by
;                            itself. This flag includes $SHCNF_FLUSH flag.
;
;                            $SHCNF_NOTIFYRECURSIVE
;                            Notify clients registered for all children.
;
;                  $iItem1 - First event-dependent value.
;                  $iItem2 - Second event-dependent value.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SHChangeNotify
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShellChangeNotify($iEvent, $iFlags, $iItem1 = 0, $iItem2 = 0)

	Local $TypeOfItem1 = 'dword_ptr', $TypeOfItem2 = 'dword_ptr'

	If IsString($iItem1) Then
		$TypeOfItem1 = 'wstr'
	EndIf
	If IsString($iItem2) Then
		$TypeOfItem2 = 'wstr'
	EndIf
	DllCall('shell32.dll', 'none', 'SHChangeNotify', 'long', $iEvent, 'uint', $iFlags, $TypeOfItem1, $iItem1, $TypeOfItem2, $iItem2)
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_ShellChangeNotify

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShellChangeNotifyDeregister
; Description....: Unregisters the client's window.
; Syntax.........: _WinAPI_ShellChangeNotifyDeregister ( $ID )
; Parameters.....: $ID     - The value that specifies the registration ID returned by _WinAPI_ShellChangeNotifyRegister().
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SHChangeNotifyDeregister
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShellChangeNotifyDeregister($ID)

	Local $Ret = DllCall('shell32.dll', 'int', 'SHChangeNotifyDeregister', 'ulong', $ID)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_ShellChangeNotifyDeregister

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShellChangeNotifyRegister
; Description....: Registers a window to receive notifications from the file system or Shell.
; Syntax.........: _WinAPI_ShellChangeNotifyRegister ( $hWnd, $iMsg, $iEvents, $iSources, $aPaths [, $fRecursive] )
; Parameters.....: $hWnd       - Handle to the window that receives the change or notification messages.
;                  $iMsg       - Message to be posted to the window procedure.
;                  $iEvents    - Change notification events for which to receive notification. This parameter can be one or more
;                                of the $SHCNE_... values.
;                  $iSources   - One or more of the following values that indicate the type of events for which to receive
;                                notifications.
;
;                                $SHCNRF_INTERRUPTLEVEL
;                                $SHCNRF_SHELLLEVEL
;                                $SHCNRF_RECURSIVEINTERRUPT
;                                $SHCNRF_NEWDELIVERY
;
;                  $aPaths     - Single path or array of paths for which to receive notifications. These names should be
;                                fully-qualified paths to prevent unexpected results.
;                  $fRecursive - Specifies whether to post notifications for children paths in $aPaths parameter, valid values:
;                  |TRUE       - Notifications would come from the folder's children.
;                  |FALSE      - Notifications would come from the specified folder's only. (Default)
; Return values..: Success     - The registration ID.
;                  Failure     - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: When a change notification event is raised, the message indicated by $iMsg is delivered to the window specified
;                  by the $hWnd parameter. (See example)
;
;                  For performance reasons, multiple notifications can be combined into a single notification. For example,
;                  if a large number of $SHCNE_UPDATEITEM notifications are generated for files in the same folder, they can be
;                  joined into a single $SHCNE_UPDATEDIR notification.
; Related........:
; Link...........: @@MsdnLink@@ SHChangeNotifyRegister
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShellChangeNotifyRegister($hWnd, $iMsg, $iEvents, $iSources, $aPaths, $fRecursive = 0)

	Local $tEntry, $Path = $aPaths, $Struct = ''

	If IsArray($aPaths) Then
		If UBound($aPaths, 2) Then
			Return SetError(1, 0, 0)
		EndIf
	Else
		Dim $aPaths[1] = [$Path]
	EndIf
	For $i = 0 To UBound($aPaths) - 1
		If Not _WinAPI_PathIsDirectory($aPaths[$i]) Then
			Return SetError(1, 0, 0)
		EndIf
	Next
	For $i = 0 To UBound($aPaths) - 1
		$Struct &= 'ptr;int;'
	Next
	$tEntry = DllStructCreate($Struct)
	For $i = 0 To UBound($aPaths) - 1
		$aPaths[$i] = _WinAPI_ShellILCreateFromPath(_WinAPI_PathSearchAndQualify($aPaths[$i]))
		DllStructSetData($tEntry, 2 * $i + 1, $aPaths[$i])
		DllStructSetData($tEntry, 2 * $i + 2, $fRecursive)
	Next

	Local $Ret = DllCall('shell32.dll', 'ulong', 'SHChangeNotifyRegister', 'hwnd', $hWnd, 'int', $iSources, 'long', $iEvents, 'uint', $iMsg, 'int', UBound($aPaths), 'ptr', DllStructGetPtr($tEntry))

	If (Not @error) And ($Ret[0]) Then
		$Ret = $Ret[0]
	Else
		$Ret = 0
	EndIf
	For $i = 0 To UBound($aPaths) - 1
		_WinAPI_CoTaskMemFree($aPaths[$i])
	Next
	Return SetError(Number($Ret = 0), 0, $Ret)
EndFunc   ;==>_WinAPI_ShellChangeNotifyRegister

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShellEmptyRecycleBin
; Description....: Empties the Recycle Bin on the specified drive.
; Syntax.........: _WinAPI_ShellEmptyRecycleBin ( $sRoot [, $iFlags [, $hParent]] )
; Parameters.....: $sRoot   - The string that contains the path of the root drive on which the Recycle Bin is located. This string
;                             can be formatted with the drive, folder, and subfolder names, for example "c:\windows\system\".
;                             If this parameter is empty string, all Recycle Bins on all drives will be emptied.
;                  $iFlags  - This parameter can be one or more of the following values.
;
;                             $SHERB_NOCONFIRMATION
;                             $SHERB_NOPROGRESSUI
;                             $SHERB_NOSOUND
;                             $SHERB_NO_UI
;
;                  $hParent - Handle to the parent window of any dialog boxes that might be displayed during the operation.
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SHEmptyRecycleBin
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShellEmptyRecycleBin($sRoot, $iFlags = 0, $hParent = 0)

	Local $Ret = DllCall('shell32.dll', 'uint', 'SHEmptyRecycleBinW', 'hwnd', $hParent, 'wstr', $sRoot, 'dword', $iFlags)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_ShellEmptyRecycleBin

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShellExtractAssociatedIcon
; Description....: Returns a handle to the icon that associated with the specified file's.
; Syntax.........: _WinAPI_ShellExtractAssociatedIcon ( $sFile [, $fSmall] )
; Parameters.....: $sFile  - The full path and file name of the file that contains the icon, or its extension, such as ".txt".
;                  $fSmall - Specifies whether extracts a small icon, valid values:
;                  |TRUE   - Extracts a small icon.
;                  |FALSE  - Extracts a large icon. (Default)
; Return values..: Success - The icon handle.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShellExtractAssociatedIcon($sFile, $fSmall = 0)

	Local $Flag = BitOR($SHGFI_ICON, $SHGFI_USEFILEATTRIBUTES)

	If $fSmall Then
		$Flag = BitOR($Flag, $SHGFI_SMALLICON)
	EndIf

	Local $tSHFILEINFO = DllStructCreate($tagSHFILEINFO)

	If Not _WinAPI_ShellGetFileInfo($sFile, $Flag, 0, $tSHFILEINFO) Then
		Return SetError(1, 0, 0)
	EndIf
	Return DllStructGetData($tSHFILEINFO, 'hIcon')
EndFunc   ;==>_WinAPI_ShellExtractAssociatedIcon

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShellExtractIcons
; Description....: Extracts the icon with the specified dimension from the specified file.
; Syntax.........: _WinAPI_ShellExtractIcons ( $sIcon, $iIndex, $iWidth, $iHeight )
; Parameters.....: $sIcon   - Path and name of the file from which the icon are to be extracted.
;                  $iIndex  - Index of the icon to extract.
;                  $iWidth  - Horizontal icon size wanted.
;                  $iHeight - Vertical icon size wanted.
; Return values..: Success  - Handle to the extracted icon.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: If the icon with the specified dimension is not found in the file, it will choose the nearest appropriate icon and
;                  change to the specified dimension. When you are finished using the icon, destroy it using the _WinAPI_FreeIcon()
;                  function.
; Related........:
; Link...........: @@MsdnLink@@ SHExtractIcons
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShellExtractIcons($sIcon, $iIndex, $iWidth, $iHeight)

	Local $Ret = DllCall('shell32.dll', 'int', 'SHExtractIconsW', 'wstr', $sIcon, 'int', $iIndex, 'int', $iWidth, 'int', $iHeight, 'ptr*', 0, 'ptr*', 0, 'int', 1, 'int', 0)

	If (@error) Or (Not $Ret[0]) Or (Not $Ret[5]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[5]
EndFunc   ;==>_WinAPI_ShellExtractIcons

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShellFileOperation
; Description....: Copies, moves, renames, or deletes a file system object.
; Syntax.........: _WinAPI_ShellFileOperation ( $sFrom, $sTo, $iFunc, $iFlags [, $sTitle [, $hParent]] )
; Parameters.....: $sFrom   - Single string or array of string that contains the source file name(s). These names should be
;                             fully-qualified paths to prevent unexpected results.
;                  $sTo     - Single string or array of string that contains the destination file or directory name(s) (if used).
;                             These names should be fully-qualified paths to prevent unexpected results.
;                  $iFunc   - A value that indicates which operation to perform. This parameter can be one of the following values.
;
;                             $FO_COPY
;                             $FO_DELETE
;                             $FO_MOVE
;                             $FO_RENAME
;
;                  $iFlags  - Flags that control the file operation. This parameter can be one of the following values.
;
;                             $FOF_ALLOWUNDO
;                             $FOF_CONFIRMMOUSE
;                             $FOF_FILESONLY
;                             $FOF_MULTIDESTFILES
;                             $FOF_NOCONFIRMATION
;                             $FOF_NOCONFIRMMKDIR
;                             $FOF_NO_CONNECTED_ELEMENTS
;                             $FOF_NOCOPYSECURITYATTRIBS
;                             $FOF_NOERRORUI
;                             $FOF_NORECURSEREPARSE
;                             $FOF_NORECURSION
;                             $FOF_RENAMEONCOLLISION
;                             $FOF_SILENT
;                             $FOF_SIMPLEPROGRESS
;                             $FOF_WANTMAPPINGHANDLE
;                             $FOF_WANTNUKEWARNING
;                             $FOF_NO_UI
;
;                  $sTitle  - The title of a progress dialog box. This parameter is used only if $iFlags includes the $FOF_SIMPLEPROGRESS flag.
;                  $hParent - Handle to the dialog box to display information about the status of the file operation.
; Return values..: Success  - $tagSHFILEOPSTRUCT structure that contains the additional information.
;                  Failure  - 0 and sets the @error flag to the one of the following values.
;
;                              -1 - AutoIt inherent error.
;                             113 - The source and destination files are the same file.
;                             114 - Multiple file paths were specified in the source buffer, but only one destination file path.
;                             115 - Rename operation was specified but the destination path is a different directory. Use the move operation instead.
;                             116 - The source is a root directory, which cannot be moved or renamed.
;                             117 - The operation was cancelled by the user, or silently cancelled if the appropriate flags were supplied to _WinAPI_ShellFileOperation().
;                             118 - The destination is a subtree of the source.
;                             120 - Security settings denied access to the source.
;                             121 - The source or destination path exceeded or would exceed MAX_PATH.
;                             122 - The operation involved multiple destination paths, which can fail in the case of a move operation.
;                             124 - The path in the source or destination or both was invalid.
;                             125 - The source and destination have the same parent folder.
;                             126 - The destination path is an existing file.
;                             128 - The destination path is an existing folder.
;                             129 - The name of the file exceeds MAX_PATH.
;                             130 - The destination is a read-only CD-ROM, possibly unformatted.
;                             131 - The destination is a read-only DVD, possibly unformatted.
;                             132 - The destination is a writable CD-ROM, possibly unformatted.
;                             133 - The file involved in the operation is too large for the destination media or file system.
;                             134 - The source is a read-only CD-ROM, possibly unformatted.
;                             135 - The source is a read-only DVD, possibly unformatted.
;                             136 - The source is a writable CD-ROM, possibly unformatted.
;                             183 - MAX_PATH was exceeded during the operation.
;                            1026 - An unknown error occurred. This is typically due to an invalid path in the source or destination.
;                           65536 - An unspecified error occurred on the destination.
;                           65652 - Destination is a root directory and cannot be renamed.
;
; Author.........: Yashied
; Modified.......:
; Remarks........: You should use fully-qualified path names with this function. Using it with relative path names is not thread safe.
; Related........:
; Link...........: @@MsdnLink@@ SHFileOperation
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShellFileOperation($sFrom, $sTo, $iFunc, $iFlags, $sTitle = '', $hParent = 0)

	Local $tFrom, $tTo, $Data

	If Not IsArray($sFrom) Then
		$Data = $sFrom
		Dim $sFrom[1] = [$Data]
	EndIf
	$tFrom = _WinAPI_ArrayToStruct($sFrom)
	If @error Then
		Return SetError(-1, 0, 0)
	EndIf
	If Not IsArray($sTo) Then
		$Data = $sTo
		Dim $sTo[1] = [$Data]
	EndIf
	$tTo = _WinAPI_ArrayToStruct($sTo)
	If @error Then
		Return SetError(-1, 0, 0)
	EndIf

	Local $tSHFILEOPSTRUCT = DllStructCreate($tagSHFILEOPSTRUCT)

	DllStructSetData($tSHFILEOPSTRUCT, 'hWnd', $hParent)
	DllStructSetData($tSHFILEOPSTRUCT, 'Func', $iFunc)
	DllStructSetData($tSHFILEOPSTRUCT, 'From', DllStructGetPtr($tFrom))
	DllStructSetData($tSHFILEOPSTRUCT, 'To', DllStructGetPtr($tTo))
	DllStructSetData($tSHFILEOPSTRUCT, 'Flags', $iFlags)
	DllStructSetData($tSHFILEOPSTRUCT, 'ProgressTitle', $sTitle)

	Local $Ret = DllCall('shell32.dll', 'int', 'SHFileOperationW', 'ptr', DllStructGetPtr($tSHFILEOPSTRUCT))

	If @error Then
		Return SetError(-1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError($Ret[0], 0, 0)
		EndIf
	EndIf
	Return $tSHFILEOPSTRUCT
EndFunc   ;==>_WinAPI_ShellFileOperation

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShellGetFileInfo
; Description....: Retrieves information about an object in the file system.
; Syntax.........: _WinAPI_ShellGetFileInfo ( $sPath, $iFlags, $iAttributes, ByRef $tSHFILEINFO )
; Parameters.....: $sPath       - String that contains the absolute or relative path and file name. This string can use either
;                                 short (the 8.3 form) or long file names.
;
;                                 If the $iFlags parameter includes the $SHGFI_PIDL flag, this parameter must be the address of an
;                                 ITEMIDLIST (PIDL) structure that contains the list of item identifiers that uniquely identifies the
;                                 file within the Shell's namespace. The pointer to an item identifier list (PIDL) must be a fully
;                                 qualified PIDL. Relative PIDLs are not allowed.
;
;                                 If the $iFlags parameter includes the $SHGFI_USEFILEATTRIBUTES flag, this parameter does not have
;                                 to be a valid file name. The function will proceed as if the file exists with the specified name and
;                                 with the file attributes passed in the $iAttributes parameter. This allows you to obtain information
;                                 about a file type by passing just the extension for $sPath and passing $FILE_ATTRIBUTE_NORMAL
;                                 in $iAttributes.
;
;                  $iFlags      - The flags that specify the file information to retrieve. This parameter can be a combination of the
;                                 following values.
;
;                                 $SHGFI_ATTR_SPECIFIED
;                                 $SHGFI_ATTRIBUTES
;                                 $SHGFI_DISPLAYNAME
;                                 $SHGFI_EXETYPE
;                                 $SHGFI_ICON
;                                 $SHGFI_ICONLOCATION
;                                 $SHGFI_LARGEICON
;                                 $SHGFI_LINKOVERLAY
;                                 $SHGFI_OPENICON
;                                 $SHGFI_OVERLAYINDEX
;                                 $SHGFI_PIDL
;                                 $SHGFI_SELECTED
;                                 $SHGFI_SHELLICONSIZE
;                                 $SHGFI_SMALLICON
;                                 $SHGFI_SYSICONINDEX
;                                 $SHGFI_TYPENAME
;                                 $SHGFI_USEFILEATTRIBUTES
;
;                  $iAttributes - A combination of one or more file attribute flags ($FILE_ATTRIBUTE_...).
;                  $tSHFILEINFO - $tagSHFILEINFO structure to receive the file information.
; Return values..: Success      - If $iFlags contains the $SHGFI_EXETYPE flag, return type of the executable file. If $iFlags contains the
;                                 $SHGFI_SYSICONINDEX flag, return handle to the system image list. Otherwise - 1.
;                  Failure      - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: If this function returns an icon handle in the hIcon member of the $tagSHFILEINFO structure, you are responsible
;                  for freeing it with _WinAPI_FreeIcon() when you no longer need it.
; Related........:
; Link...........: @@MsdnLink@@ SHGetFileInfo
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShellGetFileInfo($sPath, $iFlags, $iAttributes, ByRef $tSHFILEINFO)

	Local $Ret = DllCall('shell32.dll', 'dword_ptr', 'SHGetFileInfoW', 'wstr', $sPath, 'dword', $iAttributes, 'ptr', DllStructGetPtr($tSHFILEINFO), 'uint', DllStructGetSize($tSHFILEINFO), 'uint', $iFlags)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_ShellGetFileInfo

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShellGetKnownFolderPath
; Description....: Retrieves the full path of a known folder identified.
; Syntax.........: _WinAPI_ShellGetKnownFolderPath ( $GUID [, $iFlags [, $hToken]] )
; Parameters.....: $GUID   - The GUID ($FOLDERID_...) that identifies the standard folders registered with the system.
;                  $iFlags - The flags that specify special retrieval options. This parameter can be one or more of the following values.
;
;                            $KF_FLAG_CREATE
;                            $KF_FLAG_DONT_VERIFY
;                            $KF_FLAG_DONT_UNEXPAND
;                            $KF_FLAG_NO_ALIAS
;                            $KF_FLAG_INIT
;                            $KF_FLAG_DEFAULT_PATH
;                            $KF_FLAG_NOT_PARENT_RELATIVE
;                            $KF_FLAG_SIMPLE_IDLIST
;
;                            *Windows 7 or above
;
;                            $KF_FLAG_ALIAS_ONLY
;
;                  $hToken - The access token that represents a particular user. If this parameter is 0, the function requests
;                            the known folder for the current user. Assigning the $hToken parameter a value of (-1) indicates the
;                            Default User. Note that access to the Default User folders requires administrator privileges.
; Return values..: Success - The path of the known folder.
;                  Failure - Empty string and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function requires Windows Vista or above.
; Related........:
; Link...........: @@MsdnLink@@ SHGetKnownFolderPath
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShellGetKnownFolderPath($GUID, $iFlags = 0, $hToken = 0)

	Local $Ret, $Result, $tGUID, $tData

	$tGUID = DllStructCreate($tagGUID)
	$Ret = DllCall('ole32.dll', 'uint', 'CLSIDFromString', 'wstr', $GUID, 'ptr', DllStructGetPtr($tGUID))
	If (@error) Or ($Ret[0]) Then
		Return SetError(1, 0, '')
	EndIf
	$Ret  = DllCall('shell32.dll', 'uint', 'SHGetKnownFolderPath', 'ptr', DllStructGetPtr($tGUID), 'dword', $iFlags, 'ptr', $hToken, 'ptr*', 0)
	If @error Then
		Return SetError(1, 0, '')
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], '')
		EndIf
	EndIf
	$tData = DllStructCreate('wchar[' & (_WinAPI_StrLen($Ret[4]) + 1) & ']', $Ret[4])
	$Result = DllStructGetData($tData, 1)
	_WinAPI_CoTaskMemFree($Ret[4])
	Return $Result
EndFunc   ;==>_WinAPI_ShellGetKnownFolderPath

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShellGetPathFromIDList
; Description....: Converts an item identifier list to a file system path.
; Syntax.........: _WinAPI_ShellGetPathFromIDList ( $PIDL )
; Parameters.....: $PIDL   - The address of an item identifier list that specifies a file or directory location relative to the
;                            root of the namespace (the desktop).
; Return values..: Success - The file system path.
;                  Failure - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SHGetPathFromIDList
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShellGetPathFromIDList($PIDL)

	Local $tData = DllStructCreate('wchar[1024]')
	Local $Ret = DllCall('shell32.dll', 'int', 'SHGetPathFromIDListW', 'ptr', $PIDL, 'ptr', DllStructGetPtr($tData))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, '')
	EndIf
	Return DllStructGetData($tData, 1)
EndFunc   ;==>_WinAPI_ShellGetPathFromIDList

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShellGetSettings
; Description....: Retrieves Shell state settings.
; Syntax.........: _WinAPI_ShellGetSettings ( $iFlags )
; Parameters.....: $iFlags - The flags that indicate which settings should be retrieved. This parameter can be one or
;                            more of the following values (use ONLY this flags).
;
;                            $SSF_SHOWALLOBJECTS
;                            $SSF_SHOWEXTENSIONS
;                            $SSF_SHOWCOMPCOLOR
;                            $SSF_SHOWSYSFILES
;                            $SSF_DOUBLECLICKINWEBVIEW
;                            $SSF_DESKTOPHTML
;                            $SSF_WIN95CLASSIC
;                            $SSF_DONTPRETTYPATH
;                            $SSF_MAPNETDRVBUTTON
;                            $SSF_SHOWINFOTIP
;                            $SSF_HIDEICONS
;                            $SSF_NOCONFIRMRECYCLE
;                            $SSF_WEBVIEW
;                            $SSF_SHOWSUPERHIDDEN
;                            $SSF_SEPPROCESS
;                            $SSF_NONETCRAWLING
;                            $SSF_STARTPANELON
;
;                            *Windows Vista or above
;
;                            $SSF_AUTOCHECKSELECT
;                            $SSF_ICONSONLY
;                            $SSF_SHOWTYPEOVERLAY
;
; Return values..: Success - The value that contains a combination of flags specified in the $iFlags parameter. If flag is set,
;                            appropriate setting is enabled, otherwise disabled. The function checks only flags that were
;                            specified in the $iFlags parameter.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SHGetSetSettings
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShellGetSettings($iFlags)

	Local $tSHELLSTATE = DllStructCreate('uint[8]')

	DllCall('shell32.dll', 'none', 'SHGetSetSettings', 'ptr', DllStructGetPtr($tSHELLSTATE), 'dword', $iFlags, 'int', 0)
	If @error Then
		Return SetError(1, 0, 0)
	EndIf

	Local $Val1 = DllStructGetData($tSHELLSTATE, 1, 1)
	Local $Val2 = DllStructGetData($tSHELLSTATE, 1, 8)
	Local $Result = 0

	If BitAND($Val1, 0x00000001) Then
		$Result += $SSF_SHOWALLOBJECTS
	EndIf
	If BitAND($Val1, 0x00000002) Then
		$Result += $SSF_SHOWEXTENSIONS
	EndIf
	If BitAND($Val1, 0x00000004) Then
		$Result += $SSF_NOCONFIRMRECYCLE
	EndIf
	If BitAND($Val1, 0x00000008) Then
		$Result += $SSF_SHOWSYSFILES
	EndIf
	If BitAND($Val1, 0x00000010) Then
		$Result += $SSF_SHOWCOMPCOLOR
	EndIf
	If BitAND($Val1, 0x00000020) Then
		$Result += $SSF_DOUBLECLICKINWEBVIEW
	EndIf
	If BitAND($Val1, 0x00000040) Then
		$Result += $SSF_DESKTOPHTML
	EndIf
	If BitAND($Val1, 0x00000080) Then
		$Result += $SSF_WIN95CLASSIC
	EndIf
	If BitAND($Val1, 0x00000100) Then
		$Result += $SSF_DONTPRETTYPATH
	EndIf
	If BitAND($Val1, 0x00000400) Then
		$Result += $SSF_MAPNETDRVBUTTON
	EndIf
	If BitAND($Val1, 0x00000800) Then
		$Result += $SSF_SHOWINFOTIP
	EndIf
	If BitAND($Val1, 0x00001000) Then
		$Result += $SSF_HIDEICONS
	EndIf
	If BitAND($Val1, 0x00002000) Then
		$Result += $SSF_WEBVIEW
	EndIf
	If BitAND($Val1, 0x00008000) Then
		$Result += $SSF_SHOWSUPERHIDDEN
	EndIf
	If BitAND($Val1, 0x00010000) Then
		$Result += $SSF_NONETCRAWLING
	EndIf
	If BitAND($Val2, 0x00000001) Then
		$Result += $SSF_SEPPROCESS
	EndIf
	If BitAND($Val2, 0x00000002) Then
		$Result += $SSF_STARTPANELON
	EndIf
	If BitAND($Val2, 0x00000008) Then
		$Result += $SSF_AUTOCHECKSELECT
	EndIf
	If BitAND($Val2, 0x00000010) Then
		$Result += $SSF_ICONSONLY
	EndIf
	If BitAND($Val2, 0x00000020) Then
		$Result += $SSF_SHOWTYPEOVERLAY
	EndIf
	Return $Result
EndFunc   ;==>_WinAPI_ShellGetSettings

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShellGetSpecialFolderLocation
; Description....: Retrieves a PIDL structure of a special folder.
; Syntax.........: _WinAPI_ShellGetSpecialFolderLocation ( $CSIDL )
; Parameters.....: $CSIDL  - The CSIDL ($CSIDL_...) that identifies the folder of interest.
; Return values..: Success - The PIDL specifying the folder's location relative to the root of the namespace (the desktop).
;                  Failure - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: To free the returned PIDL, call the _WinAPI_CoTaskMemFree() function.
; Related........:
; Link...........: @@MsdnLink@@ SHGetSpecialFolderLocation
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShellGetSpecialFolderLocation($CSIDL)

	Local $Ret = DllCall('shell32.dll', 'uint', 'SHGetSpecialFolderLocation', 'hwnd', 0, 'int', $CSIDL, 'ptr*', 0)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return $Ret[3]
EndFunc   ;==>_WinAPI_ShellGetSpecialFolderLocation

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShellGetSpecialFolderPath
; Description....: Retrieves the path of a special folder.
; Syntax.........: _WinAPI_ShellGetSpecialFolderPath ( $CSIDL [, $fCreate] )
; Parameters.....: $CSIDL   - The CSIDL ($CSIDL_...) that identifies the folder of interest.
;                  $fCreate - Specifies whether the folder should be created if it does not already exist, valid values:
;                  |TRUE    - The folder is created.
;                  |FALSE   - The folder is not created. (Default)
; Return values..: Success  - The full path of a special folder.
;                  Failure  - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SHGetSpecialFolderPath
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShellGetSpecialFolderPath($CSIDL, $fCreate = 0)

	Local $tPath = DllStructCreate('wchar[1024]')
	Local $Ret = DllCall('shell32.dll', 'int', 'SHGetSpecialFolderPathW', 'hwnd', 0, 'ptr', DllStructGetPtr($tPath), 'int', $CSIDL, 'int', $fCreate)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, '')
	EndIf
	Return DllStructGetData($tPath, 1)
EndFunc   ;==>_WinAPI_ShellGetSpecialFolderPath

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShellGetStockIconInfo
; Description....: Retrieves information about system-defined Shell icons.
; Syntax.........: _WinAPI_ShellGetStockIconInfo ( $SIID, $iFlags )
; Parameters.....: $SIID   - One of the $SIID_... constants that specifies which icon should be retrieved.
;                  $iFlags - The flags that specify which information is requested. This parameter can be a combination of the
;                            following values.
;
;                            $SHGSI_ICONLOCATION
;                            $SHGSI_ICON
;                            $SHGSI_SYSICONINDEX
;                            $SHGSI_LINKOVERLAY
;                            $SHGSI_SELECTED
;                            $SHGSI_LARGEICON
;                            $SHGSI_SMALLICON
;                            $SHGSI_SHELLICONSIZE
;
; Return values..: Success - $tagSHSTOCKICONINFO structure that contains the requested information.
;                  Failure - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: If this function returns an icon handle in the "hIcon" member of the $tagSHSTOCKICONINFO structure, you are
;                  responsible for freeing the icon with _WinAPI_FreeIcon() when you no longer need it.
;
;                  This function requires Windows Vista or above.
; Related........:
; Link...........: @@MsdnLink@@ SHGetStockIconInfo
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShellGetStockIconInfo($SIID, $iFlags)

	Local $tSHSTOCKICONINFO = DllStructCreate($tagSHSTOCKICONINFO)

	DllStructSetData($tSHSTOCKICONINFO, 'Size', DllStructGetSize($tSHSTOCKICONINFO))

	Local $Ret = DllCall('shell32.dll', 'uint', 'SHGetStockIconInfo', 'int', $SIID, 'uint', $iFlags, 'ptr', DllStructGetPtr($tSHSTOCKICONINFO))

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return $tSHSTOCKICONINFO
EndFunc   ;==>_WinAPI_ShellGetStockIconInfo

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShellILCreateFromPath
; Description....: Retrieves a file's perceived type based on its extension.
; Syntax.........: _WinAPI_ShellILCreateFromPath ( $sPath )
; Parameters.....: $sPath  - The path to be converted.
; Return values..: Success - The path in $sPath expressed as a PIDL.
;                  Failure - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: To free the returned PIDL, call the _WinAPI_CoTaskMemFree() function.
; Related........:
; Link...........: @@MsdnLink@@ SHILCreateFromPath
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShellILCreateFromPath($sPath)

	Local $Ret = DllCall('shell32.dll', 'uint', 'SHILCreateFromPath', 'wstr', $sPath, 'ptr*', 0, 'dword*', 0)

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return $Ret[2]
EndFunc   ;==>_WinAPI_ShellILCreateFromPath

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShellNotifyIcon
; Description....: Sends a message to the taskbar's status area.
; Syntax.........: _WinAPI_ShellNotifyIcon ( $iMessage, $tNOTIFYICONDATA )
; Parameters.....: $iMessage        - The variable that specifies the action to be taken. It can have one of the following values.
;
;                                     $NIM_ADD
;                                     $NIM_MODIFY
;                                     $NIM_DELETE
;                                     $NIM_SETFOCUS
;                                     $NIM_SETVERSION
;
;                  $tNOTIFYICONDATA - $tagNOTIFYICONDATA structure. The content and size of this structure depends on the value
;                                     of the $iMessage and version of the operating system.
; Return values..: Success          - 1.
;                  Failure          - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ Shell_NotifyIcon
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShellNotifyIcon($iMessage, $tNOTIFYICONDATA)

	Local $Ret = DllCall('shell32.dll', 'int', 'Shell_NotifyIconW', 'dword', $iMessage, 'ptr', DllStructGetPtr($tNOTIFYICONDATA))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_ShellNotifyIcon

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShellObjectProperties
; Description....: Invokes the Properties context menu command on a Shell object.
; Syntax.........: _WinAPI_ShellObjectProperties ( $sPath [, $iType [, $sProperty [, $hParent]]] )
; Parameters.....: $sPath     - The object name.
;                  $iType     - The value that specifies the type of object.
;
;                               $SHOP_PRINTERNAME
;                               $SHOP_FILEPATH
;                               $SHOP_VOLUMEGUID
;
;                  $sProperty - The name of the property sheet page to be opened initially.
;                  $hParent   - Handle of the parent window of the dialog box.
; Return values..: Success    - 1.
;                  Failure    - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SHObjectProperties
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShellObjectProperties($sPath, $iType = 2, $sProperty = '', $hParent = 0)

	Local $TypeOfProperty = 'wstr'

	If Not StringStripWS($sProperty, 3) Then
		$TypeOfProperty = 'ptr'
		$sProperty = 0
	EndIf

	Local $Ret = DllCall('shell32.dll', 'int', 'SHObjectProperties', 'hwnd', $hParent, 'dword', $iType, 'wstr', $sPath, $TypeOfProperty, $sProperty)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_ShellObjectProperties

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShellOpenWithDlg
; Description....: Displays the Open With dialog box.
; Syntax.........: _WinAPI_ShellOpenWithDlg ( $sFile [, $iFlags [, $hParent]] )
; Parameters.....: $sFile   - The file name.
;                  $iFlags  - The characteristics of the Open With dialog box. This parameter can be one or more of the following values.
;
;                             $OAIF_ALLOW_REGISTRATION
;                             $OAIF_REGISTER_EXT
;                             $OAIF_EXEC
;                             $OAIF_FORCE_REGISTRATION
;                             $OAIF_HIDE_REGISTRATION
;                             $OAIF_URL_PROTOCOL
;
;                  $hParent - Handle of the parent window.
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function requires Windows Vista or above.
; Related........:
; Link...........: @@MsdnLink@@ SHOpenWithDialog
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShellOpenWithDlg($sFile, $iFlags = 0, $hParent = 0)

	Local $tData = DllStructCreate('wchar[1024]')
	Local $tOPENASINFO = DllStructCreate('ptr;ptr;dword')

	DllStructSetData($tData, 1, $sFile)
	DllStructSetData($tOPENASINFO, 1, DllStructGetPtr($tData))
	DllStructSetData($tOPENASINFO, 2, 0)
	DllStructSetData($tOPENASINFO, 3, $iFlags)

	Local $Ret = DllCall('shell32.dll', 'uint', 'SHOpenWithDialog', 'hwnd', $hParent, 'ptr', DllStructGetPtr($tOPENASINFO))

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_ShellOpenWithDlg

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShellQueryRecycleBin
; Description....: Retrieves the size of the Recycle Bin and the number of items in it, for a specified drive.
; Syntax.........: _WinAPI_ShellQueryRecycleBin ( $sRoot )
; Parameters.....: $sRoot  - The string that contains the path of the root drive on which the Recycle Bin is located. This string
;                            can be formatted with the drive, folder, and subfolder names, for example "c:\windows\system\".
;                            If this parameter is empty string, information is retrieved for all Recycle Bins on all drives.
; Return values..: Success - The array that contains the following information.
;
;                            [0] - The total size of all the objects in the specified Recycle Bin, in bytes.
;                            [1] - The total number of items in the specified Recycle Bin.
;
;                  Failure - 0 and sets the @error flag to non-zero, @extended flag may contain a COM error code.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SHQueryRecycleBin
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShellQueryRecycleBin($sRoot)

	Local $tSHQUERYRBINFO = DllStructCreate('align 1;dword;int64;int64')

	DllStructSetData($tSHQUERYRBINFO, 1, DllStructGetSize($tSHQUERYRBINFO))

	Local $Ret = DllCall('shell32.dll', 'uint', 'SHQueryRecycleBinW', 'wstr', $sRoot, 'ptr', DllStructGetPtr($tSHQUERYRBINFO))

	If @error Then
		Return SetError(1, 0, 0)
	Else
		If $Ret[0] Then
			Return SetError(1, $Ret[0], 0)
		EndIf
	EndIf

	Local $Result[2]

	$Result[0] = DllStructGetData($tSHQUERYRBINFO, 2)
	$Result[1] = DllStructGetData($tSHQUERYRBINFO, 3)

	Return $Result
EndFunc   ;==>_WinAPI_ShellQueryRecycleBin

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShellSetSettings
; Description....: Sets Shell state settings.
; Syntax.........: _WinAPI_ShellSetSettings ( $iFlags, $fSet )
; Parameters.....: $iFlags - The flags that indicate which settings should be set. This parameter can be one or
;                            more of the following values (use ONLY this flags).
;
;                            $SSF_SHOWALLOBJECTS
;                            $SSF_SHOWEXTENSIONS
;                            $SSF_SHOWCOMPCOLOR
;                            $SSF_SHOWSYSFILES
;                            $SSF_DOUBLECLICKINWEBVIEW
;                            $SSF_DESKTOPHTML
;                            $SSF_WIN95CLASSIC
;                            $SSF_DONTPRETTYPATH
;                            $SSF_MAPNETDRVBUTTON
;                            $SSF_SHOWINFOTIP
;                            $SSF_HIDEICONS
;                            $SSF_NOCONFIRMRECYCLE
;                            $SSF_WEBVIEW
;                            $SSF_SHOWSUPERHIDDEN
;                            $SSF_SEPPROCESS
;                            $SSF_NONETCRAWLING
;                            $SSF_STARTPANELON
;
;                            *Windows Vista or above
;
;                            $SSF_AUTOCHECKSELECT
;                            $SSF_ICONSONLY
;                            $SSF_SHOWTYPEOVERLAY
;
;                  $fSet   - Specifies whether a settings ($SSF_...) is enable or disable, valid values:
;                  |TRUE   - Enable.
;                  |FALSE  - Disable.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SHGetSetSettings
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShellSetSettings($iFlags, $fSet)

	Local $Val1 = 0, $Val2 = 0

	If $fSet Then
		If BitAND($iFlags, $SSF_SHOWALLOBJECTS) Then
			$Val1 += 0x00000001
		EndIf
		If BitAND($iFlags, $SSF_SHOWEXTENSIONS) Then
			$Val1 += 0x00000002
		EndIf
		If BitAND($iFlags, $SSF_NOCONFIRMRECYCLE) Then
			$Val1 += 0x00000004
		EndIf
		If BitAND($iFlags, $SSF_SHOWSYSFILES) Then
			$Val1 += 0x00000008
		EndIf
		If BitAND($iFlags, $SSF_SHOWCOMPCOLOR) Then
			$Val1 += 0x00000010
		EndIf
		If BitAND($iFlags, $SSF_DOUBLECLICKINWEBVIEW) Then
			$Val1 += 0x00000020
		EndIf
		If BitAND($iFlags, $SSF_DESKTOPHTML) Then
			$Val1 += 0x00000040
		EndIf
		If BitAND($iFlags, $SSF_WIN95CLASSIC) Then
			$Val1 += 0x00000080
		EndIf
		If BitAND($iFlags, $SSF_DONTPRETTYPATH) Then
			$Val1 += 0x00000100
		EndIf
		If BitAND($iFlags, $SSF_MAPNETDRVBUTTON) Then
			$Val1 += 0x00000400
		EndIf
		If BitAND($iFlags, $SSF_SHOWINFOTIP) Then
			$Val1 += 0x00000800
		EndIf
		If BitAND($iFlags, $SSF_HIDEICONS) Then
			$Val1 += 0x00001000
		EndIf
		If BitAND($iFlags, $SSF_WEBVIEW) Then
			$Val1 += 0x00002000
		EndIf
		If BitAND($iFlags, $SSF_SHOWSUPERHIDDEN) Then
			$Val1 += 0x00008000
		EndIf
		If BitAND($iFlags, $SSF_NONETCRAWLING) Then
			$Val1 += 0x00010000
		EndIf
		If BitAND($iFlags, $SSF_SEPPROCESS) Then
			$Val2 += 0x00000001
		EndIf
		If BitAND($iFlags, $SSF_STARTPANELON) Then
			$Val2 += 0x00000002
		EndIf
		If BitAND($iFlags, $SSF_AUTOCHECKSELECT) Then
			$Val2 += 0x00000008
		EndIf
		If BitAND($iFlags, $SSF_ICONSONLY) Then
			$Val2 += 0x00000010
		EndIf
		If BitAND($iFlags, $SSF_SHOWTYPEOVERLAY) Then
			$Val2 += 0x00000020
		EndIf
	EndIf

	Local $tSHELLSTATE = DllStructCreate('uint[8]')

	DllStructSetData($tSHELLSTATE, 1, $Val1, 1)
	DllStructSetData($tSHELLSTATE, 1, $Val2, 8)
	DllCall('shell32.dll', 'none', 'SHGetSetSettings', 'ptr', DllStructGetPtr($tSHELLSTATE), 'dword', $iFlags, 'int', 1)
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_ShellSetSettings

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShowCaret
; Description....: Makes the caret visible on the screen at the caret's current position.
; Syntax.........: _WinAPI_ShowCaret ( $hWnd )
; Parameters.....: $hWnd   - Handle to the window that owns the caret. If this parameter is 0, _WinAPI_ShowCaret() searches the
;                            current task for the window that owns the caret.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: _WinAPI_ShowCaret() shows the caret only if the specified window owns the caret, the caret has a shape,
;                  and the caret has not been hidden two or more times in a row. If one or more of these conditions is not met,
;                  _WinAPI_ShowCaret() does nothing and returns 0.
;
;                  Hiding is cumulative. If your application calls _WinAPI_HideCaret() five times in a row, it must also call
;                  _WinAPI_ShowCaret() five times before the caret reappears.
; Related........:
; Link...........: @@MsdnLink@@ ShowCaret
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShowCaret($hWnd)

	Local $Ret = DllCall('user32.dll', 'int', 'ShowCaret', 'hwnd', $hWnd)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_ShowCaret

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShowLastError
; Description....: Shows the last error code and message.
; Syntax.........: _WinAPI_ShowLastError ( )
; Parameters.....: None
; Return values..: None
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShowLastError()
	MsgBox(0, _WinAPI_GetLastError(), _WinAPI_GetLastErrorMessage())
EndFunc   ;==>_WinAPI_ShowLastError

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShowOwnedPopups
; Description....: Shows or hides all pop-up windows owned by the specified window.
; Syntax.........: _WinAPI_ShowOwnedPopups ( $hWnd , $fShow )
; Parameters.....: $hWnd   - Handle to the window that owns the pop-up windows to be shown or hidden.
;                  $fShow  - Specifies whether pop-up windows are to be shown or hidden.
;                  |TRUE   - All hidden pop-up windows are shown.
;                  |FALSE  - All visible pop-up windows are hidden.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function shows only windows hidden by a previous call to _WinAPI_ShowOwnedPopups().
; Related........:
; Link...........: @@MsdnLink@@ ShowOwnedPopups
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShowOwnedPopups($hWnd, $fShow)

	Local $Ret = DllCall('user32.dll', 'int', 'ShowOwnedPopups', 'hwnd', $hWnd, 'int', $fShow)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_ShowOwnedPopups

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShutdownDlg()
; Description....: Displays a Windows Shutdown dialog box.
; Syntax.........: _WinAPI_ShutdownDlg ( )
; Parameters.....: None
; Return values..: None
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShutdownDlg()

	Local $oShell = ObjCreate('Shell.Application')

	If Not @error Then
		$oShell.ShutdownWindows()
	EndIf
EndFunc   ;==>_WinAPI_ShutdownDlg

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SizeofResource
; Description....: Returns the size, in bytes, of the specified resource.
; Syntax.........: _WinAPI_SizeofResource ( $hInstance, $hResource )
; Parameters.....: $hInstance - Handle to the module whose executable file contains the resource.
;                  $hResource - Handle to the resource. This handle must be created by using the _WinAPI_FindResource() or _WinAPI_FindResourceEx()
;                               function.
; Return values..: Success    - The number of bytes in the resource.
;                  Failure    - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SizeofResource
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SizeofResource($hInstance, $hResource)

	Local $Ret = DllCall('kernel32.dll', 'dword', 'SizeofResource', 'ptr', $hInstance, 'ptr', $hResource)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_SizeofResource

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_StretchBlt
; Description....: Copies a bitmap from a source rectangle into a destination rectangle, stretching or compressing the bitmap
;                  to fit the dimensions of the destination rectangle, if necessary.
; Syntax.........: _WinAPI_StretchBlt ( $hDestDC, $iXDest, $iYDest, $iWidthDest, $iHeightDest, $hSrcDC, $iXSrc, $iYSrc, $iWidthSrc, $iHeightSrc, $iRop )
; Parameters.....: $hDestDC     - Handle to the destination device context.
;                  $iXDest      - The x-coordinate, in logical units, of the upper-left corner of the destination rectangle.
;                  $iYDest      - The y-coordinate, in logical units, of the upper-left corner of the destination rectangle.
;                  $iWidthDest  - The width, in logical units, of the destination rectangle.
;                  $iHeightDest - The height, in logical units, of the destination rectangle.
;                  $hSrcDC      - Handle to the source device context.
;                  $iXSrc       - The x-coordinate, in logical units, of the upper-left corner of the source rectangle.
;                  $iYSrc       - The y-coordinate, in logical units, of the upper-left corner of the source rectangle.
;                  $iWidthSrc   - The width, in logical units, of the source rectangle.
;                  $iHeightSrc  - The height, in logical units, of the source rectangle.
;                  $iRop        - The raster-operation code. These codes define how the color data for the source rectangle is
;                                 to be combined with the color data for the destination rectangle to achieve the final color.
;                                 This parameter must be 0 or one of the following values.
;
;                                 $BLACKNESS
;                                 $CAPTUREBLT
;                                 $DSTINVERT
;                                 $MERGECOPY
;                                 $MERGEPAINT
;                                 $NOMIRRORBITMAP
;                                 $NOTSRCCOPY
;                                 $NOTSRCERASE
;                                 $PATCOPY
;                                 $PATINVERT
;                                 $PATPAINT
;                                 $SRCAND
;                                 $SRCCOPY
;                                 $SRCERASE
;                                 $SRCINVERT
;                                 $SRCPAINT
;                                 $WHITENESS
;
; Return values..: Success      - 1.
;                  Failure      - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The system stretches or compresses the bitmap according to the stretching mode currently set in the
;                  destination device context.
; Related........:
; Link...........: @@MsdnLink@@ StretchBlt
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_StretchBlt($hDestDC, $iXDest, $iYDest, $iWidthDest, $iHeightDest, $hSrcDC, $iXSrc, $iYSrc, $iWidthSrc, $iHeightSrc, $iRop)

	Local $Ret  = DllCall('gdi32.dll', 'int', 'StretchBlt', 'hwnd', $hDestDC, 'int', $iXDest, 'int', $iYDest, 'int', $iWidthDest, 'int', $iHeightDest, 'hwnd', $hSrcDC, 'int', $iXSrc, 'int', $iYSrc, 'int', $iWidthSrc, 'int', $iHeightSrc, 'dword', $iRop)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_StretchBlt

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_StrLen
; Description....: Returns the length of the specified string.
; Syntax.........: _WinAPI_StrLen ( $hString [, $fUnicode] )
; Parameters.....: $hString  - Pointer to a null-terminated string.
;                  $fUnicode - Specifies whether a string is Unicode or ASCII code of a character, valid values:
;                  |TRUE     - Unicode. (Default)
;                  |FALSE    - ASCII.
; Return values..: Success   - The length of the string, in TCHAR values (not including the null-terminating character).
;                  Failure   - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ lstrlen
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_StrLen($hString, $fUnicode = 1)

	Local $W = ''

	If $fUnicode Then
		$W = 'W'
	EndIf

	Local $Ret = DllCall('kernel32.dll', 'int', 'lstrlen' & $W, 'ptr', $hString)

	If @error  Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_StrLen

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_StructToArray
; Description....: Converts the structure to the array of strings.
; Syntax.........: _WinAPI_StructToArray ( $pStruct [, $iItems] )
; Parameters.....: $pStruct - The pointer to the structure to convert. This structure should be same as for _WinAPI_ArrayToStruct().
;                  $iItems  - The number of strings that contains the structure. If this parameter is 0, the end of the structure
;                             determined by a double null-terminated character ("... ;{0};{0}").
; Return values..: Success  - The array of strings. The zeroth array element contains the number of strings.
;                  Failure  - 0 and sets the @error flag to one of the following values:
;                  |1 - $pStruct is not a correct pointer.
;                  |2 - Failed to allocate the memory.
;                  |3 - Size of the structure exceeds the allowable size (32 Kb).
; Author.........: Yashied
; Modified.......:
; Remarks........: This function works for Unicode strings only.
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_StructToArray($pStruct, $iItems = 0)

	Local $tData, $Count = 0, $Index = 1, $Lenght = 32 * 1024 / 2, $Struct = ''
	Local $Result[101] = [1, 0]

	$tData = DllStructCreate('wchar[' & $Lenght & ']', $pStruct)
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	While 1
		If Not AscW(DllStructGetData($tData, 1, $Index)) Then
			$Count += 1
			If $Count > 1 Then
				ExitLoop
			EndIf
			$Result[0] += 1
			If ($iItems) And ($Result[0] > $iItems) Then
				ExitLoop
			EndIf
			If $Result[0] > UBound($Result) - 1 Then
				ReDim $Result[$Result[0] + 100]
			EndIf
			$Result[$Result[0]] = 0
		Else
			$Result[$Result[0]] += 1
			$Count = 0
		EndIf
		$Index += 1
		If $Index > $Lenght Then
			Return SetError(2, 0, 0)
		EndIf
	WEnd
	ReDim $Result[$Result[0]]
	$Result[0] -= 1
	For $i = 1 To $Result[0]
		$Struct &= 'wchar[' & ($Result[$i] + 1) & '];'
	Next
	$tData = DllStructCreate($Struct, $pStruct)
	If @error Then
		Return SetError(3, 0, 0)
	EndIf
	For $i = 1 To $Result[0]
		$Result[$i] = DllStructGetData($tData, $i)
	Next
	Return $Result
EndFunc   ;==>_WinAPI_StructToArray

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SubtractRect
; Description....: Determines the coordinates of a rectangle formed by subtracting one rectangle from another.
; Syntax.........: _WinAPI_SubtractRect ( $tRECT1, $tRECT2 )
; Parameters.....: $tRECT1 - $tagRECT structure from which the function subtracts the rectangle specified by $tRECT2.
;                  $tRECT2 - $tagRECT structure that the function subtracts from the rectangle specified by $tRECT1.
; Return values..: Success - $tagRECT structure that contains the rectangle determined by subtracting the rectangle specified
;                            by $tRECT2 from the rectangle specified by $tRECT1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The function only subtracts the rectangle specified by $tRECT2 from the rectangle specified by $tRECT1 when the
;                  rectangles intersect completely in either the x- or y-direction. For example, if $tRECT1 has the coordinates
;                  (10, 10, 100, 100) and $tRECT2 has the coordinates (50, 50, 150, 150), the function returns the rectangle with
;                  the coordinates (10, 10, 100, 100). If $tRECT1 has the coordinates (10, 10, 100, 100) and $tRECT2 has the
;                  coordinates (50, 10, 150, 150), however, the function returns the rectangle with the coordinates (10, 10, 50, 100).
;                  In other words, the resulting rectangle is the bounding box of the geometric difference.
; Related........:
; Link...........: @@MsdnLink@@ SubtractRect
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SubtractRect($tRECT1, $tRECT2)

	Local $tRECT = DllStructCreate($tagRECT)
	Local $Ret = DllCall('user32.dll', 'int', 'SubtractRect', 'ptr', DllStructGetPtr($tRECT), 'ptr', DllStructGetPtr($tRECT1), 'ptr', DllStructGetPtr($tRECT2))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $tRECT
EndFunc   ;==>_WinAPI_SubtractRect

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SwitchColor
; Description....: Converts a color from BGR to RGB and vice versa.
; Syntax.........: _WinAPI_SwitchColor ( $iColor )
; Parameters.....: $iColor - The color to conversion.
; Return values..: Converted color (RGB or BGR - depends on the $iColor value, BGR > RGB > BGR etc).
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SwitchColor($iColor)
	Return BitOR(BitAND($iColor, 0x00FF00), BitShift(BitAND($iColor, 0x0000FF), -16), BitShift(BitAND($iColor, 0xFF0000), 16))
EndFunc   ;==>_WinAPI_SwitchColor

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_SwitchToThisWindow
; Description....: Switches the focus to a specified window and bring it to the foreground.
; Syntax.........: _WinAPI_SwitchToThisWindow ( $hWnd [, $fAltTab] )
; Parameters.....: $hWnd    - Handle to the window being switched to.
;                  $fAltTab - Specifies whether switches to using the Alt/Ctl+Tab key sequence, valid values:
;                  |TRUE    - The window is being switched to using the Alt/Ctl+Tab key sequence.
;                  |FALSE   - Otherwise. (Default)
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ SwitchToThisWindow
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_SwitchToThisWindow($hWnd, $fAltTab = 0)
	DllCall('user32.dll', 'none', 'SwitchToThisWindow', 'hwnd', $hWnd, 'int', $fAltTab)
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_SwitchToThisWindow

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_TextOut
; Description....: Writes a string at the specified location, using the currently selected font, background color, and text color.
; Syntax.........: _WinAPI_TextOut ( $hDC, $iX, $iY, $sText )
; Parameters.....: $hDC    - Handle to the device context.
;                  $iX     - The x-coordinate, in logical coordinates, of the reference point that the system uses to align the string.
;                  $iY     - The y-coordinate, in logical coordinates, of the reference point that the system uses to align the string.
;                  $sText  - The string to be drawn.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: This function using the currently selected font, background color, and text color.
; Related........:
; Link...........: @@MsdnLink@@ TextOut
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_TextOut($hDC, $iX, $iY, $sText)

	Local $Ret = DllCall('gdi32.dll', 'int', 'TextOutW', 'hwnd', $hDC, 'int', $iX, 'int', $iY, 'wstr', $sText, 'int', StringLen($sText))

	If (@error) Or (Not $Ret[0]) Then
		MsgBox(0, '', @error)
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_TextOut

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_TransparentBlt
; Description....: Performs a bit-block transfer of the color data corresponding to a rectangle of pixels.
; Syntax.........: _WinAPI_TransparentBlt ( $hDestDC, $iXDest, $iYDest, $iWidthDest, $iHeightDest, $hSrcDC, $iXSrc, $iYSrc, $iWidthSrc, $iHeightSrc, $iRGB )
; Parameters.....: $hDestDC     - Handle to the destination device context.
;                  $iXDest      - The x-coordinate, in logical units, of the upper-left corner of the destination rectangle.
;                  $iYDest      - The y-coordinate, in logical units, of the upper-left corner of the destination rectangle.
;                  $iWidthDest  - The width, in logical units, of the destination rectangle.
;                  $iHeightDest - The height, in logical units, of the destination rectangle.
;                  $hSrcDC      - Handle to the source device context.
;                  $iXSrc       - The x-coordinate, in logical units, of the upper-left corner of the source rectangle.
;                  $iYSrc       - The y-coordinate, in logical units, of the upper-left corner of the source rectangle.
;                  $iWidthSrc   - The width, in logical units, of the source rectangle.
;                  $iHeightSrc  - The height, in logical units, of the source rectangle.
;                  $iRGB        - The RGB color in the source bitmap to treat as transparent.
; Return values..: Success      - 1.
;                  Failure      - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: If the source and destination rectangles are not the same size, the source bitmap is stretched to match the
;                  destination rectangle. When the _WinAPI_SetStretchBltMode() function is used, the stretching modes of
;                  $BLACKONWHITE and $WHITEONBLACK are converted to $COLORONCOLOR for the _WinAPI_TransparentBlt() function.
;
;                  This function supports all formats of source bitmaps. However, for 32 bpp bitmaps, it just copies the alpha
;                  value over. Use _WinAPI_AlphaBlend() to specify 32 bits-per-pixel bitmaps with transparency.
; Related........:
; Link...........: @@MsdnLink@@ GdiTransparentBlt
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_TransparentBlt($hDestDC, $iXDest, $iYDest, $iWidthDest, $iHeightDest, $hSrcDC, $iXSrc, $iYSrc, $iWidthSrc, $iHeightSrc, $iRGB)

	Local $Ret  = DllCall('gdi32.dll', 'int', 'GdiTransparentBlt', 'hwnd', $hDestDC, 'int', $iXDest, 'int', $iYDest, 'int', $iWidthDest, 'int', $iHeightDest, 'hwnd', $hSrcDC, 'int', $iXSrc, 'int', $iYSrc, 'int', $iWidthSrc, 'int', $iHeightSrc, 'dword', __IsRGB($iRGB))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_TransparentBlt

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_UnionRect
; Description....: Creates the union of two rectangles.
; Syntax.........: _WinAPI_UnionRect ( $tRECT1, $tRECT2 )
; Parameters.....: $tRECT1 - $tagRECT structure that contains the first source rectangle.
;                  $tRECT2 - $tagRECT structure that contains the second source rectangle.
; Return values..: Success - $tagRECT structure that contains the union of the $tRECT1 and $tRECT2 rectangles.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: The union is the smallest rectangle that contains both source rectangles. The system ignores the
;                  dimensions of an empty rectangle that is, a rectangle in which all coordinates are set to zero, so that
;                  it has no height or no width.
; Related........:
; Link...........: @@MsdnLink@@ UnionRect
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_UnionRect($tRECT1, $tRECT2)

	Local $tRECT = DllStructCreate($tagRECT)
	Local $Ret = DllCall('user32.dll', 'int', 'UnionRect', 'ptr', DllStructGetPtr($tRECT), 'ptr', DllStructGetPtr($tRECT1), 'ptr', DllStructGetPtr($tRECT2))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $tRECT
EndFunc   ;==>_WinAPI_UnionRect

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_UnionStruct
; Description....: Creates the structure of two structures.
; Syntax.........: _WinAPI_UnionStruct (ByRef $tStruct1, ByRef $tStruct2)
; Parameters.....: $tStruct1 - The structure that contains the first source data.
;                  $tStruct2 - The structure that contains the second source data.
; Return values..: Success   - "byte[n]" structure that contains the union data of the $tStruct1 and $tStruct2.
;                  Failure   - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_UnionStruct(ByRef $tStruct1, ByRef $tStruct2)

	Local $Size1 = DllStructGetSize($tStruct1)
	Local $Size2 = DllStructGetSize($tStruct2)

	If (Not $Size1) Or (Not $Size2) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $tData, $tResult, $Size, $Count = 1

	$tResult = DllStructCreate('byte[' & ($Size1 + $Size2) & ']')
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	For $i = 1 To 2
		$Size = Eval('Size' & $i)
		$tData = DllStructCreate('byte[' & $Size & ']', DllStructGetPtr(Eval('tStruct' & $i)))
		If @error Then
			Return SetError(1, 0, 0)
		EndIf
		For $j = 1 To $Size
			DllStructSetData($tResult, 1, DllStructGetData($tData, 1, $j), $Count)
			If @error Then
				Return SetError(1, 0, 0)
			EndIf
			$Count += 1
		Next
	Next
	Return $tResult
EndFunc   ;==>_WinAPI_UnionStruct

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_UniqueHardwaeID
; Description....: Generates a unique hardware identifier (ID) for local computer.
; Syntax.........: _WinAPI_UniqueHardwaeID ( [$iFlags] )
; Parameters.....: $iFlags - The flags that specifies what information would be used to generate ID. This parameter can be one
;                            or more of the following values.
;
;                            $UHID_MB
;                            Uses information about your motherboard. This flag is used by default regardless of whether specified or not.
;
;                            $UHID_BIOS
;                            Uses information from BIOS.
;
;                            $UHID_CPU
;                            Uses information about your processor(s). Note that $UHID_CPU flag reduces the function speed.
;
;                            $UHID_HDD
;                            Uses information about the installed hard drives. Any change in the configuration disks will change ID
;                            returned by this function. Taken into account only non-removable disks with an ATA or SATA interfaces.
;
;                            $UHID_All
;                            The sum of all the above flags.
;
; Return values..: Success - The string representation of the ID. @extended returns the value that contains a combination of flags
;                            specified in the $iFlags parameter. If flag is set, appropriate information is received successfully,
;                            otherwise fails. The function checks only flags that were specified in the $iFlags parameter.
;                  Failure - Empty string and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_UniqueHardwaeID($iFlags = 0)

	Local $oService = ObjGet('winmgmts:\\.\root\cimv2')

	If Not IsObj($oService) Then
		Return SetError(1, 0, '')
	EndIf

	Local $tSPQ, $tSDD, $oItems, $hFile, $Hash, $Ret, $Str, $Hw = '', $Result = 0

	$oItems = $oService.ExecQuery('SELECT * FROM Win32_ComputerSystemProduct')
	If Not IsObj($oItems) Then
		Return SetError(2, 0, '')
	EndIf
	For $Property In $oItems
		$Hw &= $Property.IdentifyingNumber
		$Hw &= $Property.Name
		$Hw &= $Property.SKUNumber
		$Hw &= $Property.UUID
		$Hw &= $Property.Vendor
		$Hw &= $Property.Version
	Next
	$Hw = StringStripWS($Hw, 8)
	If Not $Hw Then
		Return SetError(3, 0, '')
	EndIf
	If BitAND($iFlags, $UHID_BIOS) Then
		$oItems = $oService.ExecQuery('SELECT * FROM Win32_BIOS')
		If Not IsObj($oItems) Then
			Return SetError(2, 0, '')
		EndIf
		$Str = ''
		For $Property In $oItems
			$Str &= $Property.IdentificationCode
			$Str &= $Property.Manufacturer
			$Str &= $Property.Name
			$Str &= $Property.SerialNumber
			$Str &= $Property.SMBIOSMajorVersion
			$Str &= $Property.SMBIOSMinorVersion
;			$Str &= $Property.Version
		Next
		$Str = StringStripWS($Str, 8)
		If $Str Then
			$Result += $UHID_BIOS
			$Hw &= $Str
		EndIf
	EndIf
	If BitAND($iFlags, $UHID_CPU) Then
		$oItems = $oService.ExecQuery('SELECT * FROM Win32_Processor')
		If Not IsObj($oItems) Then
			Return SetError(2, 0, '')
		EndIf
		$Str = ''
		For $Property In $oItems
			$Str &= $Property.Architecture
			$Str &= $Property.Family
			$Str &= $Property.Level
			$Str &= $Property.Manufacturer
			$Str &= $Property.Name
			$Str &= $Property.ProcessorId
			$Str &= $Property.Revision
			$Str &= $Property.Version
		Next
		$Str = StringStripWS($Str, 8)
		If $Str Then
			$Result += $UHID_CPU
			$Hw &= $Str
		EndIf
	EndIf
	If BitAND($iFlags, $UHID_HDD) Then
		$oItems = $oService.ExecQuery('SELECT * FROM Win32_PhysicalMedia')
		If Not IsObj($oItems) Then
			Return SetError(2, 0, '')
		EndIf
		$Str = ''
		$tSPQ = DllStructCreate('dword;dword;byte[4]')
		$tSDD = DllStructCreate('ulong;ulong;byte;byte;byte;byte;ulong;ulong;ulong;ulong;dword;ulong;byte[512]')
		For $Property In $oItems
			$hFile = _WinAPI_CreateFileEx($Property.Tag, 3, 0, 0)
			If Not $hFile Then
				ContinueLoop
			EndIf
			_WinAPI_DeviceIoControl($hFile, 0x002D1400, DllStructGetPtr($tSPQ), DllStructGetSize($tSPQ), DllStructGetPtr($tSDD), DllStructGetSize($tSDD))
			If (Not @error) And (Not DllStructGetData($tSDD, 5)) Then
				Switch DllStructGetData($tSDD, 11)
					Case 0x03, 0x0B ; $DRIVE_BUS_TYPE_ATA, $DRIVE_BUS_TYPE_SATA
						$Str &= $Property.SerialNumber
				EndSwitch
			EndIf
			_WinAPI_CloseHandle($hFile)
		Next
		$Str = StringStripWS($Str, 8)
		If $Str Then
			$Result += $UHID_HDD
			$Hw &= $Str
		EndIf
	EndIf
	$Hash = StringTrimLeft(__MD5($Hw), 2)
	If Not $Hash Then
		Return SetError(4, 0, '')
	EndIf
	Return SetError(0, $Result, '{' & StringMid($Hash, 1, 8) & '-' & StringMid($Hash, 9, 4) & '-' & StringMid($Hash, 13, 4) & '-' & StringMid($Hash, 17, 4) & '-' & StringMid($Hash, 21, 12) & '}')
EndFunc   ;==>_WinAPI_UniqueHardwaeID

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_UnloadKeyboardLayout
; Description....: Unloads an input locale identifier.
; Syntax.........: _WinAPI_UnloadKeyboardLayout ( $hLocale )
; Parameters.....: $hLocale - The input locale identifier to be unloaded.
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: _WinAPI_UnloadKeyboardLayout() cannot unload the system default input locale identifier if it is the only
;                  keyboard layout loaded. You must first load another input locale identifier before unloading the default input
;                  locale identifier.
; Related........:
; Link...........: @@MsdnLink@@ UnloadKeyboardLayout
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_UnloadKeyboardLayout($hLocale)

	Local $Ret = DllCall('user32.dll', 'int', 'UnloadKeyboardLayout', 'long', $hLocale)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_UnloadKeyboardLayout

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_UnlockFile
; Description....: Unlocks a region in an open file.
; Syntax.........: _WinAPI_UnlockFile ( $hFile, $iOffset, $iLenght )
; Parameters.....: $hFile   - Handle to the file that contains a region locked with _WinAPI_LockFile() function.
;                  $iOffset - The starting byte offset in the file where the locked region begins.
;                  $iLenght - The length of the byte range to be unlocked.
; Return values..: Success  - 1.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: Unlocking a region of a file releases a previously acquired lock on the file. The region to unlock must correspond
;                  exactly to an existing locked region. Two adjacent regions of a file cannot be locked separately and then unlocked
;                  using a single region that spans both locked regions.
; Related........:
; Link...........: @@MsdnLink@@ UnlockFile
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_UnlockFile($hFile, $iOffset, $iLenght)

	Local $Ret = DllCall('kernel32.dll', 'int', 'UnlockFile', 'ptr', $hFile, 'dword', _WinAPI_LoDWord($iOffset), 'dword', _WinAPI_HiDWord($iOffset), 'dword', _WinAPI_LoDWord($iLenght), 'dword', _WinAPI_HiDWord($iLenght))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_UnlockFile

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_UnregisterHotKey
; Description....: Frees a hot key previously registered by the calling thread.
; Syntax.........: _WinAPI_UnregisterHotKey ( $hWnd, $ID )
; Parameters.....: $hWnd   - Handle to the window associated with the hot key to be freed. This parameter should be 0 if the
;                            hot key is not associated with a window.
;                  $ID     - Specifies the identifier of the hot key to be freed.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ UnregisterHotKey
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_UnregisterHotKey($hWnd, $ID)

	Local $Ret = DllCall('user32.dll', 'int', 'UnregisterHotKey', 'hwnd', $hWnd, 'int', $ID)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_UnregisterHotKey

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_UpdateLayeredWindowEx
; Description....: Updates a bitmap translucency of a layered window.
; Syntax.........: _WinAPI_UpdateLayeredWindowEx ( $hWnd, $hBitmap [, $iOpacity [, $fDelete]] )
; Parameters.....: $hWnd     - Handle to a layered window. A layered window is created by specifying $WS_EX_LAYERED when its creating.
;                  $hBitmap  - Handle to the bitmap that will be set in the layered window.
;                  $iOpacity - The alpha transparency value to be used on the entire source bitmap.
;                  $fDelete  - Specifies whether deletes a bitmap after updated the window.
;                  |TRUE     - Bitmap will be deleted if function succeeds.
;                  |FALSE    - Don't deleted, you must release the bitmap when you are finished using it. (Default)
; Return values..: Success   - 1.
;                  Failure   - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: For best drawing performance by the layered window and any underlying windows, the layered window should be
;                  as small as possible.
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_UpdateLayeredWindowEx($hWnd, $hBitmap, $iOpacity = 255, $fDelete = 0)

	Local $Ret, $tSIZE, $tPOINT, $tBLENDFUNCTION, $hDC, $hDestDC, $hDestSv

	$Ret = DllCall('user32.dll', 'hwnd', 'GetDC', 'hwnd', $hWnd)
	$hDC = $Ret[0]
	$Ret = DllCall('gdi32.dll', 'hwnd', 'CreateCompatibleDC', 'hwnd', $hDC)
	$hDestDC = $Ret[0]
	$Ret = DllCall('gdi32.dll', 'hwnd', 'SelectObject', 'hwnd', $hDestDC, 'ptr', $hBitmap)
	$hDestSv = $Ret[0]
	$tSIZE = _WinAPI_GetBitmapDimension($hBitmap)
	$tPOINT = DllStructCreate($tagPOINT)
	$tBLENDFUNCTION = DllStructCreate($tagBLENDFUNCTION)
	DllStructSetData($tBLENDFUNCTION, 'Alpha', $iOpacity)
	DllStructSetData($tBLENDFUNCTION, 'Format', 1)
	$Ret = DllCall('user32.dll', 'int', 'UpdateLayeredWindow', 'hwnd', $hWnd, 'hwnd', $hDC, 'ptr', 0, 'ptr', DllStructGetPtr($tSIZE), 'hwnd', $hDestDC, 'ptr', DllStructGetPtr($tPOINT), 'dword', 0, 'ptr', DllStructGetPtr($tBLENDFUNCTION), 'dword', 0x02)
	DllCall('user32.dll', 'int', 'ReleaseDC', 'hwnd', $hWnd, 'hwnd', $hDC)
	DllCall('gdi32.dll', 'ptr', 'SelectObject', 'hwnd', $hDestDC, 'ptr', $hDestSv)
	DllCall('gdi32.dll', 'int', 'DeleteDC', 'hwnd', $hDestDC)
	If Not $Ret Then
		Return SetError(1, 0, 0)
	EndIf
	If $fDelete Then
		_WinAPI_FreeObject($hBitmap)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_UpdateLayeredWindowEx

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ValidateRect
; Description....: Removes a rectangle from the current update region of the specified window.
; Syntax.........: _WinAPI_ValidateRect ( $hWnd [, $tRECT] )
; Parameters.....: $hWnd   - Handle to the window whose update region is to be modified. If this parameter is 0, the system
;                            invalidates and redraws all windows and sends the WM_ERASEBKGND and WM_NCPAINT messages to the window
;                            procedure before the function returns.
;                  $tRECT  - $tagRECT structure that contains the client coordinates of the rectangle to be removed from the
;                            update region. If this parameter is 0, the entire client area is removed.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ ValidateRect
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ValidateRect($hWnd, $tRECT = 0)

	Local $Ret = DllCall('user32.dll', 'int', 'ValidateRect', 'hwnd', $hWnd, 'ptr', DllStructGetPtr($tRECT))

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_ValidateRect

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ValidateRgn
; Description....: Removes a region from the current update region of the specified window.
; Syntax.........: _WinAPI_ValidateRect ( $hWnd [, $hRgn] )
; Parameters.....: $hWnd   - Handle to the window whose update region is to be modified.
;                  $hRgn   - Handle to a region that defines the area to be removed from the update region. If this parameter is 0,
;                            the entire client area is removed.
; Return values..: Success - 1.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ ValidateRgn
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ValidateRgn($hWnd, $hRgn = 0)

	Local $Ret = DllCall('user32.dll', 'int', 'ValidateRgn', 'hwnd', $hWnd, 'ptr', $hRgn)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_WinAPI_ValidateRgn

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_WindowFromDC
; Description....: Retrieves a handle to the window associated with the specified display device context (DC).
; Syntax.........: _WinAPI_WindowFromDC ( $hDC )
; Parameters.....: $hDC    - Handle to the device context from which a handle to the associated window is to be retrieved.
; Return values..: Success - Handle to the window associated with the specified DC. If no window is associated with the specified
;                            DC, the return value is 0.
;                  Failure - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........:
; Link...........: @@MsdnLink@@ WindowFromDC
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_WindowFromDC($hDC)

	Local $Ret = DllCall('user32.dll', 'hwnd', 'WindowFromDC', 'hwnd', $hDC)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_WinAPI_WindowFromDC

#EndRegion Public Functions

#Region Internal Functions

Func __EnumLocalesProc($pLocale)

	Local $tLocale, $Lenght = _WinAPI_StrLen($pLocale)

	If Not $Lenght Then
		$__Data = 0
		Return 0
	EndIf
	$__Data[0] += 1
	If $__Data[0] > UBound($__Data) - 1 Then
		ReDim $__Data[$__Data[0] + 100]
	EndIf
	$tLocale = DllStructCreate('wchar[' & ($Lenght + 1) & ']', $pLocale)
	$__Data[$__Data[0]] = Dec(DllStructGetData($tLocale, 1))
	Return 1
EndFunc   ;==>__EnumLocalesProc

Func __EnumResLanguagesProc($hModule, $iType, $iName, $iLanguage, $lParam)
	$__Data[0] += 1
	If $__Data[0] > UBound($__Data) - 1 Then
		ReDim $__Data[$__Data[0] + 100]
	EndIf
	$__Data[$__Data[0]] = $iLanguage
	Return 1
EndFunc   ;==>__EnumResLanguagesProc

Func __EnumResNamesProc($hModule, $iType, $iName, $lParam)

	Local $sName, $tName, $Lenght = _WinAPI_StrLen($iName)

	If $Lenght Then
		$tName = DllStructCreate('wchar[' & ($Lenght + 1) & ']', $iName)
		$sName = DllStructGetData($tName, 1)
	Else
		$sName = Number($iName)
	EndIf
	$__Data[0] += 1
	If $__Data[0] > UBound($__Data) - 1 Then
		ReDim $__Data[$__Data[0] + 100]
	EndIf
	$__Data[$__Data[0]] = $sName
	Return 1
EndFunc   ;==>__EnumResNamesProc

Func __EnumResTypesProc($hModule, $iType, $lParam)

	Local $sType, $tType, $Lenght = _WinAPI_StrLen($iType)

	If $Lenght Then
		$tType = DllStructCreate('wchar[' & ($Lenght + 1) & ']', $iType)
		$sType = DllStructGetData($tType, 1)
	Else
		$sType = Number($iType)
	EndIf
	$__Data[0] += 1
	If $__Data[0] > UBound($__Data) - 1 Then
		ReDim $__Data[$__Data[0] + 100]
	EndIf
	$__Data[$__Data[0]] = $sType
	Return 1
EndFunc   ;==>__EnumResTypesProc

Func __EnumWindowsProc($hWnd, $fVisible)
	If ($fVisible) And (Not _WinAPI_IsWindowVisible($hWnd)) Then
		Return 1
	EndIf
	$__Data[0][0] += 1
	If $__Data[0][0] > UBound($__Data) - 1 Then
		ReDim $__Data[$__Data[0][0] + 100][2]
	EndIf
	$__Data[$__Data[0][0]][0] = $hWnd
	$__Data[$__Data[0][0]][1] = _WinAPI_GetClassName($hWnd)
	Return 1
EndFunc   ;==>__EnumWindowsProc

Func __MD5($sData)

	Local $Ret, $hProv, $hHash, $tData, $Error = 1

	$hProv = DllCall('advapi32.dll', 'int', 'CryptAcquireContextW', 'ptr*', 0, 'ptr', 0, 'ptr', 0, 'dword', 3, 'dword', 0xF0000000)
	If (@error) Or (Not $hProv[0]) Then
		Return ''
	EndIf
	Do
		$hHash = DllCall('advapi32.dll', 'int', 'CryptCreateHash', 'ptr', $hProv[1], 'uint', 0x00008003, 'ptr', 0, 'dword', 0, 'ptr*', 0)
		If (@error) Or (Not $hProv[0]) Then
			$hHash = 0
			ExitLoop
		EndIf
		$hHash = $hHash[5]
		$tData = DllStructCreate('byte[' & BinaryLen($sData) & ']')
		DllStructSetData($tData, 1, $sData)
		$Ret = DllCall('advapi32.dll', 'int', 'CryptHashData', 'ptr', $hHash, 'ptr', DllStructGetPtr($tData), 'dword', DllStructGetSize($tData), 'dword', 1)
		If (@error) Or (Not $Ret[0]) Then
			ExitLoop
		EndIf
		$tData = DllStructCreate('byte[16]')
		$Ret = DllCall('advapi32.dll', 'int', 'CryptGetHashParam', 'ptr', $hHash, 'dword', 2, 'ptr', DllStructGetPtr($tData), 'dword*', 16, 'dword', 0)
		If (@error) Or (Not $Ret[0]) Then
			ExitLoop
		EndIf
		$Error = 0
	Until 1
	If $hHash Then
		DllCall('advapi32.dll', 'int', 'CryptDestroyHash', 'ptr', $hHash)
	EndIf
	If $Error Then
		Return ''
	EndIf
	Return DllStructGetData($tData, 1)
EndFunc   ;==>__MD5

Func __IsRGB($iColor)
	If $__RGB Then
		$iColor = _WinAPI_SwitchColor($iColor)
	EndIf
	Return $iColor
EndFunc   ;==>__IsRGB

#EndRegion Internal Functions
