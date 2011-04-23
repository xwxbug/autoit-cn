#include <ACN_POP3.au3>
#include <array.au3>

If _ACN_POP3Connect("AnnExampleUser@freenet.de", "0815") Then
	$a = _ACN_POP3Info()
	_ArrayDisplay($a)
	_ACN_POP3Quit()
	_ACN_POP3Disconnect()
EndIf
