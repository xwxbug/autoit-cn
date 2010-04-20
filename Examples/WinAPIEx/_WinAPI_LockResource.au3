#Include <AVIConstants.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

Global Const $sAvi = @TempDir & '\150.avi'

Global $hForm, $hFile, $hInstance, $hResource, $hData, $pData, $tData, $Size

; Load AVI (150) resource from shell32.dll library
$hInstance = _WinAPI_LoadLibrary(@SystemDir & '\shell32.dll')
$hResource = _WinAPI_FindResource($hInstance, 150, 'AVI')
$Size = _WinAPI_SizeofResource($hInstance, $hResource)
$hData = _WinAPI_LoadResource($hInstance, $hResource)
$pData = _WinAPI_LockResource($hData)

; Save resource to .avi file
$hFile = FileOpen($sAvi, 2 + 16)
$tData = DllStructCreate('byte[' & $Size & ']', $pData)
FileWrite($hFile, DllStructGetData($tData, 1))
FileClose($hFile)

; Unload shell32.dll from memory
_WinAPI_FreeLibrary($hInstance)

; Create GUI
$hForm = GUICreate('MyGUI', 140, 140)
GUICtrlCreateAvi($sAvi, -1, 30, 45, 80, 50, $ACS_AUTOPLAY)
GUISetState()

Do
Until GUIGetMsg() = -3

FileDelete($sAvi)
