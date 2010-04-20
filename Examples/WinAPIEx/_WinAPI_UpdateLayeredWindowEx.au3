#Include <GDIPlus.au3>
#Include <Misc.au3>
#Include <WinAPIEx.au3>
#Include <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

Global $sPng = RegRead('HKLM\SOFTWARE\AutoIt v3\AutoIt', 'InstallDir') & '\Examples\GUI\Torus.png'
Global $hForm, $hImage, $hBitmap, $Opacity = 10, $Step = 1

_GDIPlus_Startup()
$hImage = _GDIPlus_ImageLoadFromFile($sPng)
$hForm = GUICreate('MyGUI', _GDIPlus_ImageGetWidth($hImage), _GDIPlus_ImageGetHeight($hImage), -1, -1, -1, BitOR($WS_EX_TOPMOST, $WS_EX_LAYERED))
$hBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
_GDIPlus_ImageDispose($hImage)
_GDIPlus_Shutdown()
GUISetState()

Do
	_WinAPI_UpdateLayeredWindowEx($hForm, $hBitmap, $Opacity)
	$Opacity += $Step
	If ($Opacity = 10) Or ($Opacity = 255) Then
		$Step = -$Step
		Sleep(200)
	EndIf
	Sleep(10)
Until _IsPressed('1B')

_WinAPI_FreeObject($hBitmap)
