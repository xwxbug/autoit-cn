#include <GuiConstantsEx.au3>
#include <GuiIPAddress.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>

Opt("MustDeclareVars", 1)

$Debug_IP = False ; 检查传递给函数的类名, 设置为真且使用另一控件的句柄观察其工作

Global $hIPAddress, $edit

_Main()

Func _Main()
	Local $hgui

	$hgui = GUICreate("IP Address Control Create Example", 400, 215)
	$hIPAddress = _GUICtrlIpAddress_Create($hgui, 10, 5, 380, 20)
	$edit = GUICtrlCreateEdit("", 10, 30, 380, 180, BitOR($WS_VSCROLL, $ES_AUTOVSCROLL))
	GUISetState(@SW_SHOW)

	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	_GUICtrlIpAddress_Set($hIPAddress, "24.168.2.128")

	; 等待用户关闭界面
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR
	Local $tInfo

	$tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	$hWndFrom = HWnd( DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $hIPAddress
			Switch $iCode
				Case $IPN_FIELDCHANGED ; 当用户改变控件的一个区域或移动到另一区域时发送
					$tInfo = DllStructCreate($tagNMIPADDRESS, $ilParam)
					memowrite("$IPN_FIELDCHANGED" & @LF)
					memowrite("-->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memowrite("-->IDFrom:" & @TAB & DllStructGetData($tInfo, "IDFrom") & @LF)
					memowrite("-->Code:" & @TAB & DllStructGetData($tInfo, "Code") & @LF)
					memowrite("-->Field:" & @TAB & DllStructGetData($tInfo, "Field") & @LF)
					memowrite("-->Value:" & @TAB & DllStructGetData($tInfo, "Value"))
					; 返回值被忽略
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
endfunc   ;==>WM_NOTIFY

Func memowrite($s_text)
	GUICtrlSetData($edit, $s_text & @CRLF, 1)
endfunc   ;==>memowrite

