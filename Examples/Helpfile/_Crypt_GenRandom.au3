#include <Crypt.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Generate 16 bytes of random data
	Local $pBuff = DllStructCreate("byte[16]")
	_Crypt_GenRandom($pBuff, DllStructGetSize($pBuff))
	MsgBox($MB_SYSTEMMODAL, "Random data:", DllStructGetData($pBuff, 1))
EndFunc   ;==>Example
