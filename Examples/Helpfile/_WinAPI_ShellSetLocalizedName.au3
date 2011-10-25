#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

If _WinAPI_GetVersion() ' 6.0 ' Then
	msgbox(16, 'Error ', 'Require Windows Vista or later.')
	Exit
EndIf

Global Const $sDll = @ScriptDir & ' \Resources.dll '
Global Const $sDir = @ScriptDir & ' \Temporary Folder '

If Not FileExists($sDll) Then
	msgbox(16, 'Error ', $sDll & ' not found.')
	Exit
EndIf

If Not DirCreate($sDir) Then
	msgbox(16, 'Error ', 'Unable to create folder.')
	Exit
EndIf

_WinAPI_ShellOpenFolderAndSelectItems($sDir)
msgbox(0x00040040, '', 'Press OK to set localized name for "'& _WinAPI_PathStripPath($sDir) & ' " .')
_WinAPI_ShellSetLocalizedName($sDir, $sDll, 6000)
msgbox(0x00040040, '', 'Press OK to remove localized name.')
_WinAPI_ShellRemoveLocalizedName($sDir)
msgbox(0x00040040, '', 'Press OK to exit.')

DirRemove($sDir, 1)

