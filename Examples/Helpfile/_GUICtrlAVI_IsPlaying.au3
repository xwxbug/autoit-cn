#include <GUIConstantsEx.au3>
#include <GuiAVI.au3>
#include <WindowsConstants.au3>

$Debug_AVI = False ; 检查传递给 AVI 函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

Global $hAVI, $iMemo

_Main()

Func _Main()
	Local $Wow64 = ""
	If @AutoItX64 Then $Wow64 = "\Wow6432Node"
	Local $hGUI, $sFile = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE" & $Wow64 & "\AutoIt v3\AutoIt", "InstallDir") & "\Examples\GUI\SampleAVI.avi"
	Local $btn_StartStop

	; 创建 GUI
	$hGUI = GUICreate("(External) AVI Open", 300, 200)
	$hAVI = _GUICtrlAVI_Create($hGUI, "", -1, 10, 10)
	$btn_StartStop = GUICtrlCreateButton("Start", 50, 10, 75, 25)
	$iMemo = GUICtrlCreateEdit("", 10, 50, 276, 144, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 播放 AutoIt AVI 实例
	_GUICtrlAVI_Open($hAVI, $sFile)

	; 循环直到用户退出
	While 1
		Switch GUIGetMsg()
			Case $btn_StartStop
				If GUICtrlRead($btn_StartStop) = "Start" Then
					_GUICtrlAVI_Play($hAVI)
					GUICtrlSetData($btn_StartStop, "Stop")
				Else
					_GUICtrlAVI_Stop($hAVI)
					GUICtrlSetData($btn_StartStop, "Start")
				EndIf
				MemoWrite("Is Playing: " & _GUICtrlAVI_IsPlaying($hAVI))

			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	; 关闭 AVI 剪辑
	_GUICtrlAVI_Close($hAVI)


	GUIDelete()
EndFunc   ;==>_Main

; 写入一行到 memo 控件
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
