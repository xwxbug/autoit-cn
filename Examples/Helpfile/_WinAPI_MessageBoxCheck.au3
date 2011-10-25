#Include <WinAPIEx.au3>

Opt('MustDeclareVars ', 1)

Global $hForm, $Msg, $Slider, $Pic, $tSIZE, $hBitmap

$Result = _WinAPI_MessageBoxCheck(64, 'MyProg ', '_WinAPI_MessageBoxCheck() ', 'MyProg')

msgbox('', 'Info ', 'Return:' & $Result)

