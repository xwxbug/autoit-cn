#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include  <String.au3>
#include  <Array.au3>

_Main()

Func _Main()
	Local $aArray1 = _StringBetween('[18][20][3][5][500][60] ', '[ ', ']')
	_ArrayDisplay($aArray1, 'Default Search')
endfunc   ;==>_Main

