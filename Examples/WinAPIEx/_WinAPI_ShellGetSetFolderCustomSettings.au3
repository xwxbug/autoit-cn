#Include <APIConstants.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

Global $tSHFCS, $tIcon, $aIcon, $sPath

; Select folder
$sPath = FileSelectFolder('Select Folder', '', 0, @ScriptDir)
If Not $sPath Then
	Exit
EndIf

; Select icon
$aIcon = _WinAPI_PickIconDlg()
If Not IsArray($aIcon) Then
	Exit
EndIf

; Set icon to selected folder
$tSHFCS = DllStructCreate($tagSHFOLDERCUSTOMSETTINGS)
DllStructSetData($tSHFCS, 'Size', DllStructGetSize($tSHFCS))
DllStructSetData($tSHFCS, 'Mask', $FCSM_ICONFILE)
DllStructSetData($tSHFCS, 'IconFile', _WinAPI_CreateString($aIcon[0], $tIcon))
DllStructSetData($tSHFCS, 'SizeIF', 260)
DllStructSetData($tSHFCS, 'IconIndex', $aIcon[1])

_WinAPI_ShellGetSetFolderCustomSettings($sPath, $FCS_FORCEWRITE, $tSHFCS)
