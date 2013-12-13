#include <WinAPISys.au3>
#include <WinAPIvkeysConstants.au3>

Local $OnOff[2] = ['OFF', 'ON']

ConsoleWrite('NumLock: ' & $OnOff[BitAND(_WinAPI_GetKeyState($VK_NUMLOCK), 1)] & @CRLF)
Sleep(1500)
Send('{NUMLOCK toggle}')
ConsoleWrite('NumLock: ' & $OnOff[BitAND(_WinAPI_GetKeyState($VK_NUMLOCK), 1)] & @CRLF)
Sleep(1500)
Send('{NUMLOCK toggle}')
ConsoleWrite('NumLock: ' & $OnOff[BitAND(_WinAPI_GetKeyState($VK_NUMLOCK), 1)] & @CRLF)
