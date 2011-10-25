#include <Array.au3>

Local $avArray = StringSplit(" a , b , c , d , e , f , g , h , i ", ", ")
_ArrayToClip($avArray, 1)
msgbox(0, "_ArrayToClip() Test ", ClipGet())

