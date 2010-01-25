#include <Array.au3>

Local $avArray = StringSplit("a,b,c,d,e,f,g,h,i", ",")
_ArrayToClip($avArray, 1)
MsgBox(0, "返回数组内容", ClipGet())
