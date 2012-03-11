#include <GUIConstantsEx.au3>
#include <GuiAVI.au3>

$Debug_AVI = False ; 检查传递给 AVI 函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

Global $hAVI

_Main()

Func _Main()
	Local $Wow64 = ""
	If @AutoItX64 Then $Wow64 = "\Wow6432Node"
	Local $hGUI, $sFile = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE" & $Wow64 & "\AutoIt v3\AutoIt", "InstallDir") & "\Examples\GUI\SampleAVI.avi"

	; 创建 GUI
	$hGUI = GUICreate("(External) AVI Destroy", 300, 100)
	$hAVI = _GUICtrlAVI_Create($hGUI, "", -1, 10, 10)
	GUISetState()

	; 播放 AutoIt AVI 实例
	_GUICtrlAVI_Open($hAVI, $sFile)

	; 播放 AutoIt AVI 实例
	_GUICtrlAVI_Play($hAVI)

	Sleep(3000)

	; 3 秒后停止 AVI 剪辑
	_GUICtrlAVI_Stop($hAVI)

	; 关闭 AVI 剪辑
	_GUICtrlAVI_Close($hAVI)

	MsgBox(4160, "信息", "Destroy AVI Control")
	_GUICtrlAVI_Destroy($hAVI)

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE



	GUIDelete()
EndFunc   ;==>_Main
