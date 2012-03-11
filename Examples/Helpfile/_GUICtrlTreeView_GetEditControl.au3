#include <GUIConstantsEx.au3>
#include <GuiTreeView.au3>
#include <GuiImageList.au3>
#include <WindowsConstants.au3>

$Debug_TV = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

Global $hTreeView

_Main()

Func _Main()

	Local $hGui, $hItem[6], $hImage
	Local $iStyle = BitOR($TVS_EDITLABELS, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS, $TVS_CHECKBOXES)

	$hGui = GUICreate("TreeView Get Edit Control", 400, 300)

	$hTreeView = _GUICtrlTreeView_Create($hGui, 2, 2, 396, 268, $iStyle, $WS_EX_CLIENTEDGE)
	GUISetState()

	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	$hImage = _GUIImageList_Create(16, 16, 5, 3)
	_GUIImageList_AddIcon($hImage, "shell32.dll", 110)
	_GUIImageList_AddIcon($hImage, "shell32.dll", 131)
	_GUIImageList_AddIcon($hImage, "shell32.dll", 165)
	_GUIImageList_AddIcon($hImage, "shell32.dll", 168)
	_GUIImageList_AddIcon($hImage, "shell32.dll", 137)
	_GUIImageList_AddIcon($hImage, "shell32.dll", 146)
	_GUICtrlTreeView_SetNormalImageList($hTreeView, $hImage)

	For $x = 0 To _GUIImageList_GetImageCount($hImage) - 1
		$hItem[$x] = _GUICtrlTreeView_Add($hTreeView, 0, StringFormat("[%02d] New Item", $x + 1), $x, $x)
	Next

	; 编辑首个项目的标签
	_GUICtrlTreeView_EditText($hTreeView, $hItem[0])
	Sleep(1000)
	_GUICtrlTreeView_EndEdit($hTreeView)

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
	#forceref $hWnd, $iMsg, $iwParam
	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $hWndTreeview
	$hWndTreeview = $hTreeView
	If Not IsHWnd($hTreeView) Then $hWndTreeview = GUICtrlGetHandle($hTreeView)

	$tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $hWndTreeview
			Switch $iCode
				Case $NM_CLICK ; 用户在控件中点击了鼠标左键
					_DebugPrint("$NM_CLICK" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode)
;~ 					Return 1 ; 非零值以不允许进行默认处理
					Return 0 ; 零则允许进行默认处理
				Case $NM_DBLCLK ; 用户在控件中双击了鼠标左键
					_DebugPrint("$NM_DBLCLK" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode)
;~ 					Return 1 ; 非零值以不允许进行默认处理
					Return 0 ; 零则允许进行默认处理
				Case $NM_RCLICK ; 用户在控件中点击了鼠标右键
					_DebugPrint("$NM_RCLICK" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode)
;~ 					Return 1 ; 非零值以不允许进行默认处理
					Return 0 ; 零则允许进行默认处理
				Case $NM_RDBLCLK ; 用户在控件中点击了鼠标右键
					_DebugPrint("$NM_RDBLCLK" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode)
;~ 					Return 1 ; 非零值以不允许进行默认处理
					Return 0 ; 零则允许进行默认处理
				Case $NM_KILLFOCUS ; 控件失去了输入焦点
					_DebugPrint("$NM_KILLFOCUS" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode)
					; 没有返回值
				Case $NM_RETURN ; 控件有输入焦点且用户按下了此键
					_DebugPrint("$NM_RETURN" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode)
;~ 					Return 1 ; 非零值以不允许进行默认处理
					Return 0 ; 零则允许进行默认处理
;~ 				Case $NM_SETCURSOR ; 控件正设置光标以响应 WM_SETCURSOR 消息
;~ 					Local $tinfo = DllStructCreate($tagNMMOUSE, $ilParam)
;~ 					$hWndFrom = HWnd(DllStructGetData($tinfo, "hWndFrom"))
;~ 					$iIDFrom = DllStructGetData($tinfo, "IDFrom")
;~ 					$iCode = DllStructGetData($tinfo, "Code")
;~ 					_DebugPrint("$NM_SETCURSOR" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
;~ 							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
;~ 							"-->Code:" & @TAB & $iCode & @LF & _
;~ 							"-->ItemSpec:" & @TAB & DllStructGetData($tinfo, "ItemSpec") & @LF & _
;~ 							"-->ItemData:" & @TAB & DllStructGetData($tinfo, "ItemData") & @LF & _
;~ 							"-->X:" & @TAB & DllStructGetData($tinfo, "X") & @LF & _
;~ 							"-->Y:" & @TAB & DllStructGetData($tinfo, "Y") & @LF & _
;~ 							"-->HitInfo:" & @TAB & DllStructGetData($tinfo, "HitInfo"))
;~ 					Return 0 ; 启用控件设置光标
;~ 					Return 1 ; 非零值以阻止控件设置光标
				Case $NM_SETFOCUS ; 控件接收到输入焦点
					_DebugPrint("$NM_SETFOCUS" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode)
					; 没有返回值
				Case $TVN_BEGINDRAGA, $TVN_BEGINDRAGW
					_DebugPrint("$TVN_BEGINDRAG")
				Case $TVN_BEGINLABELEDITA, $TVN_BEGINLABELEDITW
					_DebugPrint("$TVN_BEGINLABELEDIT")
					MsgBox(4160, "信息", "Edit Control Handle: 0x" & Hex(_GUICtrlTreeView_GetEditControl($hTreeView)) & @CRLF & _
							"IsPtr = " & IsPtr(_GUICtrlTreeView_GetEditControl($hTreeView)) & " IsHWnd = " & IsHWnd(_GUICtrlTreeView_GetEditControl($hTreeView)))
				Case $TVN_BEGINRDRAGA, $TVN_BEGINRDRAGW
					_DebugPrint("$TVN_BEGINRDRAG")
				Case $TVN_DELETEITEMA, $TVN_DELETEITEMW
					_DebugPrint("$TVN_DELETEITEM")
				Case $TVN_ENDLABELEDITA, $TVN_ENDLABELEDITW
					_DebugPrint("$TVN_ENDLABELEDIT")
					Local $tInfo = DllStructCreate($tagNMHDR & ";" & $tagTVITEMEX, $ilParam)
					If DllStructGetData($tInfo, "Text") <> 0 Then
						Local $tBuffer = DllStructCreate("char Text[" & DllStructGetData($tInfo, "TextMax") & "]", DllStructGetData($tInfo, "Text"))
						_GUICtrlTreeView_SetText($hTreeView, _GUICtrlTreeView_GetSelection($hTreeView), DllStructGetData($tBuffer, "Text"))
					EndIf
				Case $TVN_GETDISPINFOA, $TVN_GETDISPINFOW
					_DebugPrint("$TVN_GETDISPINFO")
				Case $TVN_GETINFOTIPA, $TVN_GETINFOTIPW
					_DebugPrint("$TVN_GETINFOTIP")
				Case $TVN_ITEMEXPANDEDA, $TVN_ITEMEXPANDEDW
					_DebugPrint("$TVN_ITEMEXPANDED")
				Case $TVN_ITEMEXPANDINGA, $TVN_ITEMEXPANDINGW
					_DebugPrint("$TVN_ITEMEXPANDING")
				Case $TVN_KEYDOWN
					_DebugPrint("$TVN_KEYDOWN")
				Case $TVN_SELCHANGEDA, $TVN_SELCHANGEDW
					_DebugPrint("$TVN_SELCHANGED")
				Case $TVN_SELCHANGINGA, $TVN_SELCHANGINGW
					_DebugPrint("$TVN_SELCHANGING")
				Case $TVN_SETDISPINFOA, $TVN_SETDISPINFOW
					_DebugPrint("$TVN_SETDISPINFO")
				Case $TVN_SINGLEEXPAND
					_DebugPrint("$TVN_SINGLEEXPAND")
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

Func _DebugPrint($s_text, $line = @ScriptLineNumber)
	ConsoleWrite( _
			"!===========================================================" & @LF & _
			"+======================================================" & @LF & _
			"-->Line(" & StringFormat("%04d", $line) & "):" & @TAB & $s_text & @LF & _
			"+======================================================" & @LF)
EndFunc   ;==>_DebugPrint
