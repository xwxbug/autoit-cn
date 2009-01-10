#cs
Audio.au3
Designed by Gary Frost, RazerM, and a little help from Volly
Version info: 1.0.0.0
History:
1.0.0.0 - first release

-------------------------------------------
Items to add: 
  1. Mute for master volume.
  2. Mute for input Microphone
  3. Mute for Wave
  4. Balance on Master, Wave, Microphone
-------------------------------------------
The following code is a proposed replacement for sound.au3. Current functions work 
as expected following testing on XP pc. No test have been performed on other operating systems.
-------------------------------------------

Functions:
_SoundOpen ( $hFile [, $sAlias ] )            - Opens a sound file for use with other _Sound functions.
_SoundClose($sSnd_id)                         - Closes a sound previously opened with _SoundOpen.
_SoundPlay ( $sSnd_id [, $fWait ] )           - Play a sound file.
_SoundStop ( $sSnd_id )                       - Stop a playing sound.
_SoundPause($sSnd_id)                         - Pause a playing sound.
_SoundResume ( $sSnd_id )                     - Resume a paused sound.
_SoundLength ( $sSnd_id [, $iMode ] )         - Returns the length of the soundfile.
_SoundSeek ( $sSnd_id, $iHour, $iMin, $iSec ) - Seeks the sound to the specified position 
_SoundStatus ( $sSnd_id )                     - Returns the status of the sound
_SoundPos ( $sSnd_id [, $iMode ] )            - Returns the current position of the sound.
_SoundSetMasterVolume($iVolume)               - Sets the Master Volume. Does not control an application's volume
_SoundGetMasterVolume                         - Gets the Master Volume level
_SoundSetMicrophoneVolume                     - Sets the Microphone input volume
_SoundGetMicrophoneVolume                     - Gets the Microphone volume level
_SoundGetPhoneVolume                          - Gets the Phone volume on the modem
_SoundSetVolumeCD                             - Sets the Volume level on the CDRom
_SoundSetMasterWaveVolume                     - Sets the Master Wave Volume level

#ce

#region
Const $MMSYSERR_NOERROR = 0
Const $WAVERR_BASE = 32
Const $WAVERR_BADFORMAT = ($WAVERR_BASE + 0)
Const $MAXPNAMELEN = 32

Const $MIXERLINE_COMPONENTTYPE_DST_FIRST = 0
Const $MIXER_GETLINEINFOF_COMPONENTTYPE = 3
Const $MIXERLINE_COMPONENTTYPE_DST_UNDEFINED = ($MIXERLINE_COMPONENTTYPE_DST_FIRST + 0)
Const $MIXERLINE_COMPONENTTYPE_DST_DIGITAL = ($MIXERLINE_COMPONENTTYPE_DST_FIRST + 1)
Const $MIXERLINE_COMPONENTTYPE_DST_LINE = ($MIXERLINE_COMPONENTTYPE_DST_FIRST + 2)
Const $MIXERLINE_COMPONENTTYPE_DST_MONITOR = ($MIXERLINE_COMPONENTTYPE_DST_FIRST + 3)
Const $MIXERLINE_COMPONENTTYPE_DST_SPEAKERS= ($MIXERLINE_COMPONENTTYPE_DST_FIRST + 4)
Const $MIXERLINE_COMPONENTTYPE_DST_HEADPHONES = ($MIXERLINE_COMPONENTTYPE_DST_FIRST + 5)
Const $MIXERLINE_COMPONENTTYPE_DST_TELEPHONE = ($MIXERLINE_COMPONENTTYPE_DST_FIRST + 6)
Const $MIXERLINE_COMPONENTTYPE_DST_WAVEIN = ($MIXERLINE_COMPONENTTYPE_DST_FIRST + 7)
Const $MIXERLINE_COMPONENTTYPE_DST_VOICEIN = ($MIXERLINE_COMPONENTTYPE_DST_FIRST + 8)
Const $MIXERLINE_COMPONENTTYPE_DST_LAST = ($MIXERLINE_COMPONENTTYPE_DST_FIRST + 8)

Const $MIXERLINE_COMPONENTTYPE_SRC_FIRST = 0x1000
Const $MIXERLINE_COMPONENTTYPE_SRC_UNDEFINED = ($MIXERLINE_COMPONENTTYPE_SRC_FIRST + 0)
Const $MIXERLINE_COMPONENTTYPE_SRC_DIGITAL = ($MIXERLINE_COMPONENTTYPE_SRC_FIRST + 1)
Const $MIXERLINE_COMPONENTTYPE_SRC_LINE = ($MIXERLINE_COMPONENTTYPE_SRC_FIRST + 2)
Const $MIXERLINE_COMPONENTTYPE_SRC_MICROPHONE= ($MIXERLINE_COMPONENTTYPE_SRC_FIRST + 3)
Const $MIXERLINE_COMPONENTTYPE_SRC_SYNTHESIZER = ($MIXERLINE_COMPONENTTYPE_SRC_FIRST + 4)
Const $MIXERLINE_COMPONENTTYPE_SRC_COMPACTDISC = ($MIXERLINE_COMPONENTTYPE_SRC_FIRST + 5)
Const $MIXERLINE_COMPONENTTYPE_SRC_TELEPHONE = ($MIXERLINE_COMPONENTTYPE_SRC_FIRST + 6)
Const $MIXERLINE_COMPONENTTYPE_SRC_PCSPEAKER = ($MIXERLINE_COMPONENTTYPE_SRC_FIRST + 7)
Const $MIXERLINE_COMPONENTTYPE_SRC_WAVEOUT = ($MIXERLINE_COMPONENTTYPE_SRC_FIRST + 8)
Const $MIXERLINE_COMPONENTTYPE_SRC_AUXILIARY = ($MIXERLINE_COMPONENTTYPE_SRC_FIRST + 9)
Const $MIXERLINE_COMPONENTTYPE_SRC_ANALOG = ($MIXERLINE_COMPONENTTYPE_SRC_FIRST + 10)
Const $MIXERLINE_COMPONENTTYPE_SRC_LAST = ($MIXERLINE_COMPONENTTYPE_SRC_FIRST + 10)

Const $MIXER_GETLINEINFOF_SOURCE = 1

Const $MIXER_GETLINEINFOF_DESTINATION = 0
Const $MIXER_GETLINEINFOF_LINEID = 2
Const $MIXERCONTROL_CT_SC_LIST_SINGLE = 0x00000000
Const $MIXERCONTROL_CT_CLASS_LIST = 0x70000000
Const $MIXERCONTROL_CT_SC_LIST_MULTIPLE = 0x01000000
Const $MIXERCONTROL_CT_UNITS_BOOLEAN = 0x00010000
Const $MIXERCONTROL_CT_CLASS_MASK = 0xF0000000
Const $MIXERCONTROL_CONTROLTYPE_MULTIPLESELECT = BitOR($MIXERCONTROL_CT_CLASS_LIST, $MIXERCONTROL_CT_SC_LIST_MULTIPLE, $MIXERCONTROL_CT_UNITS_BOOLEAN)
Const $MIXERCONTROL_CONTROLTYPE_MIXER = ($MIXERCONTROL_CONTROLTYPE_MULTIPLESELECT + 1)
Const $MIXERCONTROL_CONTROLTYPE_SINGLESELECT = BitOR($MIXERCONTROL_CT_CLASS_LIST, $MIXERCONTROL_CT_SC_LIST_SINGLE, $MIXERCONTROL_CT_UNITS_BOOLEAN)
Const $MIXERCONTROL_CONTROLTYPE_MUX = ($MIXERCONTROL_CONTROLTYPE_SINGLESELECT + 1)
Const $MIXER_GETCONTROLDETAILSF_VALUE = 0
Const $MIXER_SETCONTROLDETAILSF_VALUE = 0
Const $MIXERCONTROL_CONTROLF_UNIFORM = 1
Const $MIXERCONTROL_CONTROLF_MULTIPLE = 2

Const $MIXERCONTROL_CT_SC_METER_POLLED = 0
Const $MIXERCONTROL_CT_CLASS_METER = 0x10000000
Const $MIXERCONTROL_CT_UNITS_SIGNED = 0x20000
Const $MIXERCONTROL_CT_UNITS_UNSIGNED = 0x30000
Const $MIXERCONTROL_CT_CLASS_FADER = 0x50000000
Const $MIXERCONTROL_CT_CLASS_NUMBER = 0x30000000
Const $MIXERCONTROL_CONTROLTYPE_FADER = BitOR($MIXERCONTROL_CT_CLASS_FADER, $MIXERCONTROL_CT_UNITS_UNSIGNED)
Const $MIXERCONTROL_CONTROLTYPE_VOLUME= ($MIXERCONTROL_CONTROLTYPE_FADER + 1)
Const $MIXERCONTROL_CONTROLTYPE_UNSIGNEDMETER = BitOR($MIXERCONTROL_CT_CLASS_METER, $MIXERCONTROL_CT_SC_METER_POLLED, $MIXERCONTROL_CT_UNITS_UNSIGNED)
Const $MIXERCONTROL_CONTROLTYPE_UNSIGNED = BitOR($MIXERCONTROL_CT_CLASS_NUMBER, $MIXERCONTROL_CT_UNITS_UNSIGNED)
Const $MIXERCONTROL_CONTROLTYPE_SIGNED = BitOR($MIXERCONTROL_CT_CLASS_NUMBER, $MIXERCONTROL_CT_UNITS_SIGNED)

Const $MIXER_OBJECTF_WAVEIN = 0x20000000
Const $MIXER_SHORT_NAME_CHARS = 16
Const $MIXER_LONG_NAME_CHARS = 64
Const $MIXER_GETLINECONTROLSF_ALL = 0
Const $MIXER_GETLINECONTROLSF_ONEBYID = 1
Const $MIXER_GETLINECONTROLSF_ONEBYTYPE = 2
Const $MIXER_OBJECTF_HANDLE = 0x80000000
Const $MIXER_OBJECTF_MIXER = 0
Const $MIXER_OBJECTF_HMIXER = BitOR($MIXER_OBJECTF_HANDLE, $MIXER_OBJECTF_MIXER)
Const $MIXER_GETCONTROLDETAILSF_LISTTEXT = 1
Const $CALLBACK_NULL = 0
Const $WAVE_MAPPED = 4

Const $wMid = 1
Const $wPid = 2
Const $vDriverVersion = 3
Const $szPname = 4
Const $dwFormats = 5
Const $wChannels = 6
Const $wReserved1 = 7
Const $AWICAPS_SIZEOF = $wReserved1 + 1

;mixer
Const $fdwSupport = 5
Const $cDestinations = 6
Const $AMXCAPS_SIZEOF = $cDestinations + 2 ;leave room for num cells

;line struct
Const $cbStruct = 1
Const $dwDestination = 2
Const $dwSource = 3
Const $dwLineID = 4
Const $fdwLine = 5
Const $dwUser = 6
Const $dwComponentType = 7
Const $cChannels = 8
Const $cConnections = 9
Const $cControls = 10
Const $szShortName = 11
Const $szName = 12
Const $dwType = 13
Const $dwDeviceID = 14
Const $wMMid = 15
Const $wMPid = 16
Const $vMDriverVersion = 17
Const $szMPname = 18
$AMXLINE_SIZEOF = $szMPname + 2

Const $cbCStruct = 1
Const $dwCLineID = 2
Const $dwControlID = 3
Const $dwControlType = 4
Const $cCControls = 5
Const $cbmxctrl = 6
Const $pamxctrl = 7
Const $MXXTRLS_SIZEOF = $pamxctrl + 2

Const $lst_destname = 1
Const $lst_dwComponentType = 2
Const $lst_ctrid = 3

Const $MIX_HMXOBJ = 1
Const $MIX_DEVNAME = 2
Const $MIX_CAPCDEST = 3
Const $MIX_RECNAME = 4
Const $MIX_CCONNECTIONS = 5
Const $MIX_INCCONTROLS = 6
Const $MIX_DWLINEID = 7
Const $MIX_INCHANNELS = 8
Const $MIX_INMULTIITEMS = 9
Const $MIX_INCTRLID = 10
Const $MIX_OUTCHANNELS = 11
Const $MIX_OUTMULTIEMS = 12
Const $MIX_OUTCTRLID = 13
Const $MIX_LAST = $MIX_OUTCTRLID + 1
Const $AMIX_SIZEOF = $MIX_LAST + 1
Dim $mxline[$AMXLINE_SIZEOF]
Dim $mixers[1][$AMIX_SIZEOF]
Dim $mxInList[2][4]
$mixernames = ""
$FormSelectInput = 0
$TV_SelectInput = 0
$CMB_DevName = 0
$CKB_EnableLinefocus = 0
$defaultmixer = 0
$lastlinesrc = -1
$curmixer = $defaultmixer
;===============================================================================
#endregion


;===============================================================================
;
; Function Name:   _SoundOpen
; Description::    Opens a sound file for use with other _Sound functions
; Parameter(s):    $hFile - The sound file, $sAlias[optianal] - a name such as sound1,
;				   if you do not specify one it is randomly generated
; Requirement(s):  AutoIt 3.2 ++
; Return Value(s): string(the sound id) - Success, 0 - Failure
;				   @extended <> 0 - open failed, @error = 2 - File doesn't exist,
;				   @error = 3 - alias contains whitespace
; Author(s):       RazerM
;
;===============================================================================
;
Func _SoundOpen($hFile, $sAlias = "")
	;Declare variables
	Local $sSnd_id, $iCurrentPos, $iRet, $asAlias
	;check for file
	If Not FileExists($hFile) Then Return SetError(2, 0, 0)
	;search for whitespace by character
	$asAlias = StringSplit($sAlias, "")
	For $iCurrentPos = 1 To $asAlias[0]
		If StringIsSpace($asAlias[$iCurrentPos]) Then Return SetError(3, 0, 0)
	Next
	;create random alias if one is not supplied
	If $sAlias = "" Then
		$sSnd_id = RandomStr(10)
	Else
		$sSnd_id = $sAlias
	EndIf
	;open file
	$iRet = mciSendString("open " & FileGetShortName($hFile) & " alias " & FileGetShortName($sSnd_id))
	Return SetError(0, $iRet, $sSnd_id)
EndFunc   ;==>_SoundOpen

;===============================================================================
;
; Function Name:   _SoundClose
; Description::    Closes a sound
; Parameter(s):    $sSnd_id - Sound ID returned by _SoundOpen
; Requirement(s):  AutoIt 3.2 ++
; Return Value(s): 1 - Success, 0 and @error = 1 - Failure
; Author(s):       RazerM
;
;===============================================================================
;
Func _SoundClose($sSnd_id)
	If mciSendString("close " & FileGetShortName($sSnd_id)) = 0 Then
		Return 1
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_SoundClose

;===============================================================================
;
; Function Name:   _SoundPlay
; Description::    Plays a sound from the current position (beginning is the default)
; Parameter(s):    $sSnd_id - Sound ID returned by _SoundOpen or sound file
;				   $fWait - If set to 1 the script will wait for the sound to finish before continuing
;						 - If set to 0 the script will continue while the sound is playing
; Requirement(s):  AutoIt 3.2 ++
; Return Value(s): 1 - Success, 0 - Failure
;				   @error = 2 - $fWait is invalid, @error = 1 - play failed
; Author(s):       RazerM
;
;===============================================================================
;
Func _SoundPlay($sSnd_id, $fWait = 0)
	;Declare variables
	Local $iRet
	;validate $fWait
	If $fWait <> 0 And $fWait <> 1 Then Return SetError(2, 0, 0)
	;if sound has finished, seek to start
	If _SoundPos($sSnd_id, 2) = _SoundLength($sSnd_id, 2) Then mciSendString("seek " & FileGetShortName($sSnd_id) & " to start")
	;If $fWait = 1 then pass wait to mci
	If $fWait = 1 Then
		$iRet = mciSendString("play " & FileGetShortName($sSnd_id) & " wait")
	Else
		$iRet = mciSendString("play " & FileGetShortName($sSnd_id))
	EndIf
	;return
	If $iRet = 0 Then
		Return 1
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_SoundPlay

;===============================================================================
;
; Function Name: _SoundStop
; Description::    Stops the sound
; Parameter(s):    $sSnd_id - Sound ID returned by _SoundOpen or sound file
; Requirement(s):  AutoIt 3.2 ++
; Return Value(s): 1 - Success, 0 and @error = 1 - Failure,
; Author(s):       RazerM
;
;===============================================================================
;
Func _SoundStop($sSnd_id)
	;Declare variables
	Local $iRet, $iRet2
	;seek to start
	$iRet = mciSendString("seek " & FileGetShortName($sSnd_id) & " to start")
	;stop
	$iRet2 = mciSendString("stop " & FileGetShortName($sSnd_id))
	;return
	If $iRet = 0 And $iRet2 = 0 Then
		Return 1
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_SoundStop

;===============================================================================
;
; Function Name:   _SoundPause
; Description::    Pauses the sound
; Parameter(s):    $sSnd_id - Sound ID returned by _SoundOpen or sound file
; Requirement(s):  AutoIt 3.2 ++
; Return Value(s): 1 - Success, 0 and @error = 1 - Failure,
; Author(s):       RazerM
;
;===============================================================================
;
Func _SoundPause($sSnd_id)
	;Declare variables
	Local $iRet
	;pause sound
	$iRet = mciSendString("pause " & FileGetShortName($sSnd_id))
	;return
	If $iRet = 0 Then
		Return 1
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_SoundPause

;===============================================================================
;
; Function Name:   _SoundResume
; Description::    Resumes the sound after being paused
; Parameter(s):    $sSnd_id - Sound ID returned by _SoundOpen or sound file
; Requirement(s):  AutoIt 3.2 ++
; Return Value(s): 1 - Success, 0 and @error = 1 - Failure,
; Author(s):       RazerM
;
;===============================================================================
;
Func _SoundResume($sSnd_id)
	;Declare variables
	Local $iRet
	;resume sound
	$iRet = mciSendString("resume " & FileGetShortName($sSnd_id))
	;return
	If $iRet = 0 Then
		Return 1
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_SoundResume

;===============================================================================
;
; Function Name:   _SoundLength
; Description::    Returns the length of the sound in the format hh:mm:ss
; Parameter(s):    $sSnd_id - Sound ID returned by _SoundOpen or sound file,
;				   $iMode = 1 - hh:mm:ss, $iMode = 2 - milliseconds
; Requirement(s):  AutoIt 3.2 ++
; Return Value(s): Length of the sound - Success, 0 and @error = 1 - $iMode is invalid
; Author(s):       RazerM
;
;===============================================================================
;
Func _SoundLength($sSnd_id, $iMode = 1)
	;Declare variables
	Local $iSnd_len_ms, $iSnd_len_min, $iSnd_len_hour, $iSnd_len_sec, $sSnd_len_format
	;validate $iMode
	If $iMode <> 1 And $iMode <> 2 Then Return SetError(1, 0, 0)
	;tell mci to use time in milliseconds
	mciSendString("set " & FileGetShortName($sSnd_id) & " time format miliseconds")
	;recieve length of sound
	$iSnd_len_ms = mciSendString("status " & FileGetShortName($sSnd_id) & " length")
	;assign modified data to variables
	$iSnd_len_min = Int($iSnd_len_ms / 60000)
	$iSnd_len_hour = Int($iSnd_len_min / 60)
	$iSnd_len_sec = Int(Int($iSnd_len_ms / 1000) - ($iSnd_len_min * 60))
	;assign formatted data to $sSnd_len_format
	$sSnd_len_format = StringFormat("%02i:%02i:%02i", $iSnd_len_hour, $iSnd_len_min, $iSnd_len_sec)
	;return correct variable
	If $iMode = 1 Then Return $sSnd_len_format
	If $iMode = 2 Then Return $iSnd_len_ms
EndFunc   ;==>_SoundLength

;===============================================================================
;
; Function Name:   _SoundSeek
; Description::    Seeks the sound to a specified time
; Parameter(s):    $sSnd_id - Sound ID returned by _SoundOpen (must NOT be a file), $iHour, $iMin, $iSec
; Requirement(s):  AutoIt 3.2 ++
; Return Value(s): 1 - Success, 0 and @error = 1 - Failure,
; Author(s):       RazerM
;
;===============================================================================
;
Func _SoundSeek($sSnd_id, $iHour, $iMin, $iSec)
	;Declare variables
	Local $iMs = 0
	Local $iRet
	;prepare mci to recieve time in milliseconds
	mciSendString("set " & FileGetShortName($sSnd_id) & " time format miliseconds")
	;modify the $iHour, $iMin and $iSec parameters to be in milliseconds
	;and add to $iMs
	$iMs += $iSec * 1000
	$iMs += $iMin * 60 * 1000
	$iMs += $iHour * 60 * 60 * 1000
	; seek sound to time ($iMs)
	$iRet = mciSendString("seek " & FileGetShortName($sSnd_id) & " to " & $iMs)
	;return
	If $iRet = 0 Then
		Return 1
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_SoundSeek

;===============================================================================
;
; Function Name:   _SoundStatus
; Description::    All devices can return the "not ready", "paused", "playing", and "stopped" values.
;				   Some devices can return the additional "open", "parked", "recording", and "seeking" values.(MSDN)
; Parameter(s):    $sSnd_id - Sound ID returned by _SoundOpen or sound file
; Requirement(s):  AutoIt 3.2 ++
; Return Value(s): Sound Status
; Author(s):       RazerM
;
;===============================================================================
;
Func _SoundStatus($sSnd_id)
	;return status
	Return mciSendString("status " & FileGetShortName($sSnd_id) & " mode")
EndFunc   ;==>_SoundStatus

;===============================================================================
;
; Function Name:   _SoundPos
; Description::    Returns the current position of the song
; Parameter(s):    $sSnd_id - Sound ID returned by _SoundOpen or sound file,
;				   $iMode = 1 - hh:mm:ss, $iMode = 2 - milliseconds
; Requirement(s):  AutoIt 3.2 ++
; Return Value(s): Current Position - Success, @error = 1 - $iMode is invalid
; Author(s):       RazerM
;
;===============================================================================
;
Func _SoundPos($sSnd_id, $iMode = 1)
	;Declare variables
	Local $iSnd_pos_ms, $iSnd_pos_min, $iSnd_pos_hour, $iSnd_pos_sec, $sSnd_pos_format
	;validate $iMode
	If $iMode <> 1 And $iMode <> 2 Then Return SetError(1, 0, 0)
	;tell mci to use time in milliseconds
	mciSendString("set " & FileGetShortName($sSnd_id) & " time format miliseconds")
	;receive position of sound
	$iSnd_pos_ms = mciSendString("status " & FileGetShortName($sSnd_id) & " position")
	;modify data and assign to variables
	$iSnd_pos_min = Int($iSnd_pos_ms / 60000)
	$iSnd_pos_hour = Int($iSnd_pos_min / 60)
	$iSnd_pos_sec = Int(Int($iSnd_pos_ms / 1000) - ($iSnd_pos_min * 60))
	;assign formatted data to $sSnd_pos_format
	$sSnd_pos_format = StringFormat("%02i:%02i:%02i", $iSnd_pos_hour, $iSnd_pos_min, $iSnd_pos_sec)
	;return correct variable
	If $iMode = 1 Then Return $sSnd_pos_format
	If $iMode = 2 Then Return $iSnd_pos_ms
EndFunc   ;==>_SoundPos

;===============================================================================
;
; Function Name:   _SoundSetMasterVolume
; Description::    Sets the Master Volume. Does not control an application's volume
; Parameter(s):    $$iVolume - % to set
; Requirement(s):  AutoIt 3.2 ++
; Return Value(s): 1 - Success, 0 - Failure
; Author(s):       Volly
; Example:         _SoundSetMasterVolume(100)
;
;===============================================================================
;
func _SoundSetMasterVolume($iVolume)
_SetMixerVolume($MIXERLINE_COMPONENTTYPE_DST_SPEAKERS, $iVolume)
If @error Then 
	SetExtended(0)
	Return(@extended)
else	
	SetExtended(1)
	Return(@extended)
endif
EndFunc

;===============================================================================
;
; Function Name:   _SoundGetMasterVolume
; Description::    Gets the Master Volume level
; Parameter(s):    none
; Requirement(s):  AutoIt 3.2 ++
; Return Value(s): 1 to 100 - Success, -1 - Failure
; Author(s):       Volly
; Example:         _SoundGetMasterVolume()
;
;===============================================================================
;
func _SoundGetMasterVolume()
$percent = _GetMixerVolume($MIXERLINE_COMPONENTTYPE_DST_SPEAKERS)
If @error Then 
	SetExtended(-1)
	Return(@extended)
else	
	SetExtended($percent)
	Return(@extended)
endif
EndFunc

;===============================================================================
;
; Function Name:   _SoundSetMicrophoneVolume
; Description::    Sets the Microphone input volume
; Parameter(s):    $iVolume - % to set
; Requirement(s):  AutoIt 3.2 ++
; Return Value(s): 1 - Success, 0 and @error = 1 - Failure
; Author(s):       Volly
; Example:         _SoundSetMicrophoneVolume(50)
;
;===============================================================================
;
func _SoundSetMicrophoneVolume($iVolume)
_SetMixerVolume($MIXERLINE_COMPONENTTYPE_SRC_MICROPHONE, $iVolume)
If @error Then 
	Exit
else	
SetExtended(1)
	Return(@extended)
endif
EndFunc

;===============================================================================
;
; Function Name:   _SoundGetMicrophoneVolume
; Description::    Gets the Microphone volume level
; Parameter(s):    none
; Requirement(s):  AutoIt 3.2 ++
; Return Value(s): 1 to 100 - Success, -1 - Failure
; Author(s):       Volly
; Example:         _SoundGetMicrophoneVolume()
;
;===============================================================================
;
func _SoundGetMicrophoneVolume()
$percent = _GetMixerVolume($MIXERLINE_COMPONENTTYPE_SRC_MICROPHONE)
If @error Then 
	SetExtended(-1)
	Return(@extended)
else	
	SetExtended($percent)
	Return(@extended)
endif
EndFunc

;===============================================================================
;
; Function Name:   _SoundGetPhoneVolume
; Description::    Gets the Phone volume on the modem
; Parameter(s):    none
; Requirement(s):  AutoIt 3.2 ++
; Return Value(s): 1 to 100 - Success, -1 - Failure
; Author(s):       Volly
; Example:         _SoundGetPhoneVolume()
; Notes: 		   Some modems may not report volume levels. You will need to test.
;
;===============================================================================
;
func _SoundGetPhoneVolume()
$percent = _GetMixerVolume($MIXERLINE_COMPONENTTYPE_SRC_TELEPHONE)
If @error Then 
	SetExtended(-10)
	Return(@extended)
else	
	SetExtended($percent)
	Return(@extended)
endif
EndFunc

;===============================================================================
;
; Function Name:   _SoundSetVolumeCD
; Description::    Sets the Volume level on the CDRom
; Parameter(s):    $iVolume - % to set
; Requirement(s):  AutoIt 3.2 ++
; Return Value(s): 1 to 100 - Success, -1 - Failure
; Author(s):       Volly
; Example:         _SoundSetVolumeCD(45)
;
;===============================================================================
func _SoundSetVolumeCD($iVolume)
_SetMixerVolume($MIXERLINE_COMPONENTTYPE_SRC_COMPACTDISC, $iVolume)
If @error Then 
	Exit
else	
SetExtended(1)
	Return(@extended)
endif
EndFunc

;===============================================================================
;
; Function Name:   _SoundSetMasterWaveVolume
; Description::    Sets the Master Wave Volume level. 
; Parameter(s):    $iVolume - % to set
; Requirement(s):  AutoIt 3.2 ++
; Return Value(s): 1 to 100 - Success, -1 - Failure
; Author(s):       Volly
; Example:         _SoundSetMasterWaveVolume(60)
;
;===============================================================================
func _SoundSetMasterWaveVolume($iVolume)
_SetMixerVolume($MIXERLINE_COMPONENTTYPE_SRC_WAVEOUT, $iVolume)
If @error Then 
	Exit
else	
SetExtended(1)
	Return(@extended)
endif
EndFunc

;===============================================================================
;
; Internal Functions
;
;===============================================================================
Func mciSendString($string)
	Local $iRet
	$iRet = DllCall("winmm.dll", "int", "mciSendStringA", "str", $string, "str", "", "int", 65534, "hwnd", 0)
	If Not @error Then Return $iRet[2]
EndFunc   ;==>mciSendString

Func RandomStr($len)
	Local $string
	For $iCurrentPos = 1 To $len
		$string &= Chr(Random(97, 122, 1))
	Next
	Return $string
EndFunc   ;==>RandomStr

Func _SetMixerVolume($MixerDevice, $percent)
	;default mixer is always 0 (so far) which is last audio device installed or prefered deviced selected by user
	SetExtended(10)
	$curmixer = 0
	Const $MM_MIXM_CONTROL_CHANGE = 0x3D1
	Const $CALLBACK_WINDOW = 0x10000
	OpenAllMixers($mixers)
	If @error Then Exit
	$hmxobj = MixerOpen($curmixer, 0, $MM_MIXM_CONTROL_CHANGE, BitOR($CALLBACK_WINDOW, $MIXER_OBJECTF_MIXER))
	GetMXWaveoutID($mixers, $curmixer, $MixerDevice)
	_SetVolume($mixers, $curmixer, $percent)
	MixerClose($hmxobj)
	CloseAllMixers($mixers)
	SetExtended(1)
	Return(@extended)
EndFunc   ;==>_SetMixerVolume

Func _GetMixerVolume($MixerDevice)
	;default mixer is always 0 (so far) which is last audio device installed or prefered deviced selected by user
	$curmixer = 0
	Const $MM_MIXM_CONTROL_CHANGE = 0x3D1
	Const $CALLBACK_WINDOW = 0x10000
	OpenAllMixers($mixers)
	If @error Then Exit
	$hmxobj = MixerOpen($curmixer, 0, $MM_MIXM_CONTROL_CHANGE, BitOR($CALLBACK_WINDOW, $MIXER_OBJECTF_MIXER))
	GetMXWaveoutID($mixers, $curmixer, $MixerDevice)
	$savevolume = GetSetOutVolume($mixers, $curmixer, 0, 0)
	$savevolume = BitAND($savevolume / 0xFFFF * 100, 0xffff)

	MixerClose($hmxobj)
	CloseAllMixers($mixers)
	Return $savevolume
EndFunc   ;==>_GetMixerVolume

Func _SetVolume(ByRef $mixers, ByRef $curmixer, ByRef $percent)
	$x = Mod($percent * 0xffff, 100)
	$percent = BitAND($percent * 0xffff / 100, 0xffff)
	$percent = $percent + $x
	GetSetOutVolume($mixers, $curmixer, $percent) ;this will also trigger callback routine
EndFunc   ;==>_SetVolume

Func GetSetOutVolume($mixers, $index, $vol = 0, $doset = 1)
	Local $i, $x, $arraysize, $channels, $mtiems
	Const $MIXERCONTROLDETAILS_UNSIGNED_SIZEOF = 4
	Local $mixercontroldetails = DllStructCreate( _
			"dword;" & _	;DWORD cbStruct
	"dword;" & _	;DWORD dwControlID
	"dword;" & _	;DWORD cChannels;
	"dword;" & _	;HWND  hwndOwner  DWORD cMultipleItems;
	"dword;" & _	;DWORD  cbDetails;
	"dword") 	;LPVOID paDetails;
	If @error Then Return False
	$mitems = $mixers[$index][$MIX_OUTMULTIEMS]
	$channels = $mixers[$index][$MIX_OUTCHANNELS]
	$arraysize = $channels
	If $mitems Then $arraysize = $channels * $mitems
	Local $plistbool = DllStructCreate("dword[" & $arraysize + 1 & "]") ;give me one mroe than needed
	If @error Then Return False
	$hmxobj = $mixers[$index][$MIX_HMXOBJ]
	$mxcd = $mixercontroldetails
	DllStructSetData($mxcd, $cbStruct, DllStructGetSize($mxcd))
	DllStructSetData($mxcd, 2, $mixers[$index][$MIX_OUTCTRLID])
	DllStructSetData($mxcd, 3, $mixers[$index][$MIX_OUTCHANNELS])
	DllStructSetData($mxcd, 4, $mixers[$index][$MIX_OUTMULTIEMS])
	DllStructSetData($mxcd, 5, $MIXERCONTROLDETAILS_UNSIGNED_SIZEOF) ;cbDetails to sizeof one unsigned struct
	DllStructSetData($mxcd, 6, DllStructGetPtr($plistbool)) ;paDetails set ptr
	$ret = DllCall("winmm.dll", "long", "mixerGetControlDetails", "hwnd", $hmxobj, "ptr", DllStructGetPtr($mxcd), "long", BitOR($MIXER_OBJECTF_HMIXER, $MIXER_GETCONTROLDETAILSF_VALUE))
	If @error Then Return False
	If $ret[0] = $MMSYSERR_NOERROR Then
		$x = DllStructGetData($plistbool, 1, 1) 	;just return right channel
		For $i = 1 To $arraysize
			DllStructSetData($plistbool, 1, $vol, $i) ;set left right to same value
		Next ;i
		If $doset Then $ret = DllCall("winmm.dll", "long", "mixerSetControlDetails", "hwnd", $hmxobj, "ptr", DllStructGetPtr($mxcd), "long", BitOR($MIXER_OBJECTF_HMIXER, $MIXER_SETCONTROLDETAILSF_VALUE))
		Return $x
	EndIf
	Return False
EndFunc   ;==>GetSetOutVolume

Func GetMXWaveoutID(ByRef $mixers, $index, $linetype)
	Local $mitems, $chans, $hmxobj, $x, $ret, $lineid
	;local structures are nuked on exit...so i have read..LOL
	Local $mixercontrol = DllStructCreate( _
			"dword;" & _ ; DWORD cbStruct;
	"dword;" & _ ;   DWORD dwControlID;
	"dword;" & _ ;   DWORD dwControlType;
	"dword;" & _ ;   DWORD fdwControl;
	"dword;" & _ ;   DWORD cMultipleItems;
	"char[16];" & _ ;szShortName[MIXER_SHORT_NAME_CHARS];
	"char[64];" & _ ;szName[MIXER_LONG_NAME_CHARS];
	"dword;" & _	;lMinimum
	"dword;" & _	;lMaximum
	"dword[4];" & _ ;dwReserved[4];
	"dword;" & _ 	;cSteps
	"dword[5]") ;   DWORD dwReserved[6];
	If @error Then Return False
	Local $mixerlinecontrols = DllStructCreate( _
			"dword;" & _ ;	  cbStruct;
	"dword;" & _ ;    DWORD dwLineID;
	"dword;" & _ ;    DWORD dwControlID     DWORD dwControlType;
	"dword;" & _ ;    DWORD  cControls;
	"dword;" & _ ;    DWORD cbmxctrl;
	"ptr") ;    	  LPMIXERCONTROL pamxctrl;
	If @error Then Return False
	$hmxobj = $mixers[$index][$MIX_HMXOBJ]
	zeroline($mxline)
	$mxline[$dwLineID] = BitOR($index, 0xFFFF0000)
	$mxline[$dwComponentType] = $linetype
	MixerGetLineInfo($hmxobj, $mxline, $MIXER_GETLINEINFOF_COMPONENTTYPE)
	$lineid = $mxline[$dwLineID]
	DllStructSetData($mixerlinecontrols, $cbStruct, DllStructGetSize($mixerlinecontrols))
	DllStructSetData($mixerlinecontrols, 2, $lineid)
	DllStructSetData($mixerlinecontrols, 3, $MIXERCONTROL_CONTROLTYPE_VOLUME)
	DllStructSetData($mixerlinecontrols, 4, 1)
	DllStructSetData($mixerlinecontrols, 5, DllStructGetSize($mixercontrol))
	DllStructSetData($mixerlinecontrols, 6, DllStructGetPtr($mixercontrol))
	$ret = DllCall("winmm.dll", "long", "mixerGetLineControls", "hwnd", $hmxobj, "ptr", DllStructGetPtr($mixerlinecontrols), "long", BitOR($MIXER_OBJECTF_HMIXER, $MIXER_GETLINECONTROLSF_ONEBYTYPE))
	If $ret[0] <> $MMSYSERR_NOERROR Then Return False
	$chans = $mxline[$cChannels]
	$x = DllStructGetData($mixercontrol, 4) ;fwControl
	If BitAND($x, $MIXERCONTROL_CONTROLF_UNIFORM) Then $chans = 1
	$mitems = 0
	If BitAND($x, $MIXERCONTROL_CONTROLF_MULTIPLE) Then $mitems = DllStructGetData($mixercontrol, 5)
	$x = DllStructGetData($mixercontrol, 3) ;fwControl
	If BitAND($x, $MIXERCONTROL_CT_CLASS_FADER) Then
		$mixers[$index][$MIX_OUTCHANNELS] = $chans
		$mixers[$index][$MIX_OUTMULTIEMS] = $mitems
		$mixers[$index][$MIX_OUTCTRLID] = DllStructGetData($mixercontrol, 2)
		Return True
	EndIf
	Return False
EndFunc   ;==>GetMXWaveoutID

Func zeroline(ByRef $line)
	Local $i
	For $i = 0 To UBound($line) - 1
		$line[$i] = 0
	Next ;i
EndFunc   ;==>zeroline

Func MixerGetLineInfo($hmxobj, ByRef $line, $flag)
	Local $mixerline = DllStructCreate ("dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;char[16];char[64];dword;dword;short;short;dword;char[32]")
	If @error Then
		SetError(1)
		Return False
	EndIf
	Local $i
	For $i = 1 To UBound($line) - 1
		DllStructSetData($mixerline, $i, $line[$i])
	Next ;i
	DllStructSetData($mixerline, $cbStruct, DllStructGetSize($mixerline))
	$ret = DllCall("winmm.dll", "long", "mixerGetLineInfo", "hwnd", $hmxobj, "ptr", DllStructGetPtr($mixerline), "int", $flag)
	If @error Then
		SetError(1)
		Return False
	EndIf
	For $i = 1 To $szMPname
		$line[$i] = DllStructGetData($mixerline, $i)
	Next ;i
	If $ret[0] = $MMSYSERR_NOERROR Then Return True
	SetError(1)
	Return False
EndFunc   ;==>MixerGetLineInfo


;On Exit: MIX_HMXOBJ set to return value from mixeropn...check for @error
Func OpenAllMixers(ByRef $mixers)
	Local $i, $mxnumdevs, $hmxobj
	$mxnumdevs = mixerGetNumDevs()
	If $mxnumdevs Then
		ReDim $mixers[$mxnumdevs + 1][$AMIX_SIZEOF]
		For $i = 0 To $mxnumdevs - 1
			$hmxobj = MixerOpen($i, 0, 0, $MIXER_OBJECTF_MIXER)
			If @error Then
				SetError(1)
				Return False
			EndIf
			$mixers[$i][$MIX_HMXOBJ] = $hmxobj
		Next ;i
	EndIf
	$mixers[0][0] = $mxnumdevs
EndFunc   ;==>OpenAllMixers

;On ENtry: mixer id and flag(s) , if no id passed then the preffered id is used (0) ditto for flag
;on exit: mixer handle
Func MixerOpen($uMxid = 0, $hwnd = 0, $instance = 0, $fdwOpen = 0)
	Local $x, $h_struct
	$h_struct = DllStructCreate("udword") ;since a local will be deleted on exit of function
	If @error Then
		SetError(1)
		Return False
	EndIf
	$ret = DllCall("winmm.dll", "long", "mixerOpen", "ptr", DllStructGetPtr($h_struct), "int", $uMxid, "int", $hwnd, "int", $instance, "int", $fdwOpen)
	If Not @error Then
		If $ret[0] <> $MMSYSERR_NOERROR Then Return -1
		$x = DllStructGetData($h_struct, 1)
		Return $x
	EndIf
	SetError(1)
	Return False
EndFunc   ;==>MixerOpen

Func CloseAllMixers($mixers)
	Local $i, $cnt
	$cnt = $mixers[0][0]
	For $i = 0 To $cnt - 1
		MixerClose($mixers[$i][$MIX_HMXOBJ])
	Next ;i
EndFunc   ;==>CloseAllMixers

;On Entry: mixer handle
Func MixerClose($hmxobj)
	$ret = DllCall("winmm.dll", "long", "mixerClose", "long", $hmxobj)
	If Not @error Then Return True
	Return False
EndFunc   ;==>MixerClose

Func mixerGetNumDevs()
	$ret = DllCall("winmm.dll", "long", "mixerGetNumDevs")
	If Not @error Then Return $ret[0]
	SetError(1)
	Return False
EndFunc   ;==>mixerGetNumDevs