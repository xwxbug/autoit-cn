
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GuiConstantsEx.au3>
#include <GuiSlider.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>

Opt('MustDeclareVars', 1)

$Debug_S = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作

Global $hSlider, $edit

_Main()

Func _Main()
	Local $hGUI

	; 创建界面
	$hGUI = GUICreate("(UDF Created) Slider Create", 400, 296)
	$hSlider = _GUICtrlSlider_Create($hGUI, 2, 2, 396, 20, BitOR($TBS_TOOLTIPS, $TBS_AUTOTICKS))
	$edit = GUICtrlCreateEdit("", 2, 24, 396, 270, BitOR($WS_VSCROLL, $ES_AUTOVSCROLL))
	GUISetState()

	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
	#forceref $hWnd, $iMsg, $iwParam
	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $hWndSlider
	$hWndSlider = $hSlider
	If Not IsHWnd($hSlider) Then $hWndSlider = GUICtrlGetHandle($hSlider)

	$tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	$hWndFrom = HWnd( DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $hWndSlider
			Switch $iCode
				Case $NM_RELEASEDCAPTURE ; 控件释放鼠标捕捉
					memowrite("$NM_RELEASEDCAPTURE" & @LF)
					memowrite("-->hWndFrom:" & @TAB & $hWndFrom) & @LF)
					memowrite("-->IDFrom:" & @TAB & $iIDFrom) & @LF)
					memowrite("-->Code:" & @TAB & $iCode) & @LF)
					; 无返回值
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
endfunc   ;==>WM_NOTIFY

Func memowrite($s_text)
	GUICtrlSetData($edit, $s_text & @CRLF, 1)
endfunc   ;==>memowrite

