#Include <GUIConstantsEx.au3>
#Include <Memory.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

Global Const $sJpg = @TempDir & '\~Tech.jpg'

Global $hForm, $Msg, $Button, $hFile, $hInstance, $hResource, $hData, $pData, $tData, $hWave, $pWave, $Size

; Load Resources.dll to memory
$hInstance = _WinAPI_LoadLibrary(@ScriptDir & '\Extras\Resources.dll')

; Load JPEG resource from Resources.dll library
$hResource = _WinAPI_FindResource($hInstance, 1, 'JPEG')
$Size = _WinAPI_SizeofResource($hInstance, $hResource)
$hData = _WinAPI_LoadResource($hInstance, $hResource)
$pData = _WinAPI_LockResource($hData)

; Save resource to .jpg file
$hFile = FileOpen($sJpg, 2 + 16)
$tData = DllStructCreate('byte[' & $Size & ']', $pData)
FileWrite($hFile, DllStructGetData($tData, 1))
FileClose($hFile)

; Load SOUND resource from Resources.dll library
$hResource = _WinAPI_FindResource($hInstance, 1, 'SOUND')
$Size = _WinAPI_SizeofResource($hInstance, $hResource)
$hData = _WinAPI_LoadResource($hInstance, $hResource)
$pData = _WinAPI_LockResource($hData)

; Copy WAV to memory for use later
$hWave = _MemGlobalAlloc($Size, 2)
$pWave = _MemGlobalLock($hWave)
_MemMoveMemory($pData, $pWave, $Size)
;_MemGlobalUnlock($hWave)

; Unload Resources.dll from memory
_WinAPI_FreeLibrary($hInstance)

; Create GUI
$hForm = GUICreate('MyGUI', 350, 350)
GUICtrlCreatePic($sJpg, 0, 0, 350, 350)
GUICtrlSetState(-1, $GUI_DISABLE)
$Button = GUICtrlCreateButton('Play Sound', 125, 316, 100, 23)
GUISetState()

While 1
	$Msg = GUIGetMsg()
	Switch $Msg
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $Button
			_WinAPI_PlaySound($pWave, BitOR($SND_ASYNC, $SND_MEMORY, $SND_NOWAIT))
	EndSwitch
WEnd

FileDelete($sJpg)
