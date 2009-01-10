#cs ----------------------------------------------------------------------------
 功能: 按所指定的文件名(或扩展名)设置Listview中项目的对应扩展名图标
 用法：_SetIconByFileName(目标 ListviewItem或ListView,文件名 或 文件扩展名)
 说明：当文件为EXE或DLL文件时必须指定文件完整路径，且应在调用前判断文件是否存在
 作者: AC
   QQ: 402090001
#ce ----------------------------------------------------------------------------
#include-once
#cs
;#include <GUIConstants.au3>
;Local $BS_ICON=0x0040
$AForm1 = GUICreate("AForm1", 633, 447, 193, 125)
$ListView1 = GUICtrlCreateListView(" ", 16, 16, 585, 214)
GUICtrlSendMsg(-1, 0x101E, 0, 300)
GUICtrlSetImage(-1, "shell32.dll",22)
Dim $I[7] = ["*.ini","*.BAT","*.bmp",@WindowsDir & "\explorer.exe","*.com","*.vbs",".htm"]
For $J = 0 To 6
	GUICtrlCreateListViewItem($I[$J],$ListView1)
	_SetIconByFileName(-1, $I[$J])
Next
$Button1 = GUICtrlCreateButton("...", 24, 320, 33, 33, $BS_ICON)
;~ _SetIconByFileName(-1, $I[3])
GUISetState(@SW_SHOW)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
WEnd
#ce
Func _SetIconByFileName($DisplayCrtl, $FileName)
	If StringRight($FileName, 4) <> ".exe" And StringRight($FileName, 4) <> ".dll" Then
		$var = RegRead("HKCR\" & StringRight($FileName, 4), "")
		$var1 = RegRead("HKCR\" & $var & "\DefaultIcon", "")
		If StringInStr($var1, ",") = 0 Then
			Return GUICtrlSetImage($DisplayCrtl, $var1, 0)
		Else
			$var2 = StringSplit($var1, ",")
			Return GUICtrlSetImage($DisplayCrtl, $var2[1], $var2[2])
		EndIf
	Else
		Return GUICtrlSetImage($DisplayCrtl, $FileName, 0)
	EndIf
EndFunc   ;==>_SetIconByFileName
