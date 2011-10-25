#include  <WinAPIEx.au3>

Global $width = @DesktopWidth, $height = @DesktopHeight

_WinAPI_ChangeScreenResEx(1, 800, 600, -1, -1)
Sleep(5000)
_WinAPI_ChangeScreenResEx(2, $width, $height, -1, -1)

