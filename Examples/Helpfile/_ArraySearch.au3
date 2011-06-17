#include <Array.au3>

;===============================================================================
; 示例 1 (使用一维数组)
;===============================================================================
Local $avArray[6] = [ _
"String0, SubString0", _
"String1, SubString1", _
"String2, SubString2", _
"String3, SubString3", _
"String4, SubString4", _
"String5, SubString5"]

_ArrayDisplay($avArray, "一维数组")

$sSearch = InputBox("一维数组搜索演示", "请输入要搜索的值。")
If @error Then Exit

$iIndex = _ArraySearch($avArray, $sSearch, 0, 0, 0, 1)
If @error Then
	MsgBox(0, "没有找到匹配结果", "“" & $sSearch & "”搜索完毕，没有结果可显示。")
Else
	MsgBox(0, "搜索成功", "“" & $sSearch & "”搜索完毕，位于数组中第“" & $iIndex & "”个索引中。")
EndIf

;===============================================================================
; 示例 2 (使用二维数组)
;===============================================================================
Local $avArray[6][2] = [ _
["String0", "SubString0"], _
["String1", "SubString1"], _
["String2", "SubString2"], _
["String3", "SubString3"], _
["String4", "SubString4"], _
["String5", "SubString5"]]

_ArrayDisplay($avArray, "二维数组")

$sSearch = InputBox("二维数组搜索演示", "请输入要搜索的值。")
If @error Then Exit

$sColumn = InputBox("二维数组搜索演示", "请输入搜索的方向：" & @CRLF & "从开始到结束进行搜索输入“1”" & @CRLF & "从结束到开始进行搜索输入“0”")
If @error Then Exit
$sColumn = Int($sColumn)

$iIndex = _ArraySearch($avArray, $sSearch, 0, 0, 0, 1, $sColumn)
If @error Then
    MsgBox(0, "没有找到匹配结果", "“" & $sSearch & "”搜索完毕，没有结果可显示。")
Else
	MsgBox(0, "搜索成功", "“" & $sSearch & "”搜索完毕，位于数组中第“" & $iIndex & "”个索引中。")
EndIf
