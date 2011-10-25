#include <GuiConstantsEx.au3>
#include <GuiAVI.au3>
#include <WindowsConstants.au3>

Opt('MustDeclareVars ', 1)

$Debug_AVI = False ; 检查传递给AVI函数的类名, 设置为真并使用另一控件的句柄查看如何工作

Global $hAVI, $iMemo

_Example1()
_Example2()

Func _Example1()
	Local $hGUI, $sFile = RegRead(" HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt ", "InstallDir ") & " \Examples\GUI\SampleAVI.avi "

	; 创建界面
	$hGUI = GUICreate(" (External 1) AVI Create ", 300, 240)
	$iMemo = GUICtrlCreateEdit("", 5, 80, 290, 150, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New ")
	$hAVI = _GUICtrlAVI_Create($hGUI, $sFile, -1, 10, 10)
	GUISetState()

	GUIRegisterMsg($WM_COMMAND, "WM_COMMAND ")

	; 播放示例AutoIt AVI
	_GUICtrlAVI_Play($hAVI)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	; 关闭AVI片段
	_GUICtrlAVI_Close($hAVI)

	GUIDelete()

endfunc   ;==>_Example1

Func _Example2()
	Local $hGUI

	; 创建界面
	$hGUI = GUICreate(" (External 2) AVI Create ", 300, 240)
	$hAVI = _GUICtrlAVI_Create($hGUI, @SystemDir & " \Shell32.dll ", 150, 10, 10)
	$iMemo = GUICtrlCreateEdit("", 5, 80, 290, 150, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New ")

	GUISetState()

	GUIRegisterMsg($WM_COMMAND, "WM_COMMAND ")

	; 播放示例AutoIt AVI
	_GUICtrlAVI_Play($hAVI)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	; 关闭AVI片段
	_GUICtrlAVI_Close($hAVI)

	GUIDelete()

endfunc   ;==>_Example2

Func WM_COMMAND($hWnd, $iMsg, $iwParam, $ilParam)
	Local $hWndFrom, $iIDFrom, $iCode
	$hWndFrom = $ilParam
	$iIDFrom = BitAND($iwParam, 0xFFFF) ; Low Word
	$iCode = BitShift($iwParam, 16) ; Hi Word
	Switch $hWndFrom
		Case $hAVI
			Switch $iCode
				Case $ACN_START ; 注意相关AVI剪辑已开始播放的动画控件的主窗体
					MemoWrite(" $ACN_START ")
					MemoWrite(" --> hWndFrom:" & @TAB & $hWndFrom)
					MemoWrite(" -->IDFrom:" & @TAB & $iIDFrom)
					MemoWrite(" -->Code:" & @TAB & $iCode)
					; 无返回值
				Case $ACN_STOP ; 注意相关AVI剪辑已停止播放的动画控件的主窗体
					MemoWrite(" $ACN_STOP ")
					MemoWrite(" --> hWndFrom:" & @TAB & $hWndFrom)
					MemoWrite(" -->IDFrom:" & @TAB & $iIDFrom)
					MemoWrite(" -->Code:" & @TAB & $iCode)
					; 无返回值
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
endfunc   ;==>WM_COMMAND

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

