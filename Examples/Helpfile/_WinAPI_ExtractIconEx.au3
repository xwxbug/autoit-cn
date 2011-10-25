#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
Opt('MustDeclareVars', 1)

#include <WinAPI.au3>
msgbox(4096, "ExtractIconEx", "# of Icons in file shell32.dll:" & _WinAPI_ExtractIconEx("shell32.dll", -1, 0, 0, 0))
