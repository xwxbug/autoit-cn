#include <WinApiEx.au3>

Opt('MustDeclareVars ', 1)

msgbox('', 'Info ', 'Internet connected:' & ( _WinAPI_IsNetworkAlive() > 0))

