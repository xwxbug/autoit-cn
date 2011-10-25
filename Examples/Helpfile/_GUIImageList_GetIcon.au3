#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GuiConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <WinAPI.au3>
#include <GuiImageList.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>

Opt('MustDeclareVars', 1)

$Debug_SB = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄查看其运行

Global $hStatus, $iMemo, $edit

_Main()

Func _Main()

	Local $hGUI, $hIcons[2], $hImage
	Local $aParts[4] = [75, 150, 300, 400]

	; 创建界面
	$hGUI = GUICreate("ImageList Get/Destroy Icon", 400, 300)
	$hStatus = _GUICtrlStatusBar_Create($hGUI)

	; 创建显示图标句柄的memo控件
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 70, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	; 创建显示操作信息的控件
	$edit = GUICtrlCreateEdit("", 2, 74, 396, 197, BitOR($WS_VSCROLL, $ES_AUTOVSCROLL))
	GUISetState()

	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	; 设置分段
	_GUICtrlStatusBar_SetParts($hStatus, $aParts)
	_GUICtrlStatusBar_SetText($hStatus, "Part 1")
	_GUICtrlStatusBar_SetText($hStatus, "Part 2", 1)

	; 加载图像
	$hImage = _GUIImageList_Create(11, 11)
	_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($hStatus, 0xFF0000, 11, 11))
	_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($hStatus, 0x00FF00, 11, 11))
	_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($hStatus, 0x0000FF, 11, 11))

	; 设置图标
	$hIcons[0] = _GUIImageList_GetIcon($hImage, 1)
	$hIcons[1] = _GUIImageList_GetIcon($hImage, 2)
	_GUICtrlStatusBar_SetIcon($hStatus, 0, $hIcons[0])
	_GUICtrlStatusBar_SetIcon($hStatus, 1, $hIcons[1])

	; 显示图标句柄
	MemoWrite("Part 1 icon handle .: 0x" & Hex($hIcons[0]))
	MemoWrite("Part 2 icon handle .: 0x" & Hex($hIcons[1]))

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	; 释放图标
	MsgBox(4096, "Information", "Icon 1 Destroyed?" & _GUIImageList_DestroyIcon($hIcons[0]))
	MsgBox(4096, "Information", "Icon 2 Destroyed?" & _GUIImageList_DestroyIcon($hIcons[1]))
	GUIDelete()
endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
	#forceref $hWnd, $iMsg, $iwParam, $ilParam
	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $tinfo

	$tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	$hWndFrom = HWnd( DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $hStatus
			Switch $iCode
				Case $NM_CLICK ; 在控件中点击鼠标左键
					$tinfo = DllStructCreate($tagNMMOUSE, $ilParam)
					$hWndFrom = HWnd( DllStructGetData($tinfo, "hWndFrom"))
					$iIDFrom = DllStructGetData($tinfo, "IDFrom")
					$iCode = DllStructGetData($tinfo, "Code")
					memout("$NM_CLICK" & @LF)
					memout("-->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memout("-->IDFrom:" & @TAB & $iIDFrom & @LF)
					memout("-->Code:" & @TAB & $iCode & @LF)
					memout("-->ItemSpec:" & @TAB & DllStructGetData($tinfo, "$ItemSpec") & @LF)
					memout("-->ItemData:" & @TAB & DllStructGetData($tinfo, "ItemData") & @LF)
					memout("-->X:" & @TAB & DllStructGetData($tinfo, "X") & @LF)
					memout("-->Y:" & @TAB & DllStructGetData($tinfo, "Y") & @LF)
					memout("-->HitInfo:" & @TAB & DllStructGetData($tinfo, "HitInfo") & @LF)
					Return True ; 表示鼠标已处于控制且由系统挂起默认操作
;~          Return FALSE ;允许默认点击操作
				Case $NM_DBLCLK ; 在控件中双击鼠标左键
					$tinfo = DllStructCreate($tagNMMOUSE, $ilParam)
					$hWndFrom = HWnd( DllStructGetData($tinfo, "hWndFrom"))
					$iIDFrom = DllStructGetData($tinfo, "IDFrom")
					$iCode = DllStructGetData($tinfo, "Code")
					memout("$NM_DBLCLK" & @LF)
					memout("-->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memout("-->IDFrom:" & @TAB & $iIDFrom & @LF)
					memout("-->Code:" & @TAB & $iCode & @LF)
					memout("-->ItemSpec:" & @TAB & DllStructGetData($tinfo, "$ItemSpec") & @LF)
					memout("-->ItemData:" & @TAB & DllStructGetData($tinfo, "ItemData") & @LF)
					memout("-->X:" & @TAB & DllStructGetData($tinfo, "X") & @LF)
					memout("-->Y:" & @TAB & DllStructGetData($tinfo, "Y") & @LF)
					memout("-->HitInfo:" & @TAB & DllStructGetData($tinfo, "HitInfo") & @LF)
					Return True ; 表示鼠标已处于控制且由系统挂起默认操作
;~          Return FALSE ;允许默认点击操作.
				Case $NM_RCLICK ; 在控件中单击鼠标右键
					$tinfo = DllStructCreate($tagNMMOUSE, $ilParam)
					$hWndFrom = HWnd( DllStructGetData($tinfo, "hWndFrom"))
					$iIDFrom = DllStructGetData($tinfo, "IDFrom")
					$iCode = DllStructGetData($tinfo, "Code")
					memout("$NM_RCLICK" & @LF)
					memout("-->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memout("-->IDFrom:" & @TAB & $iIDFrom & @LF)
					memout("-->Code:" & @TAB & $iCode & @LF)
					memout("-->ItemSpec:" & @TAB & DllStructGetData($tinfo, "$ItemSpec") & @LF)
					memout("-->ItemData:" & @TAB & DllStructGetData($tinfo, "ItemData") & @LF)
					memout("-->X:" & @TAB & DllStructGetData($tinfo, "X") & @LF)
					memout("-->Y:" & @TAB & DllStructGetData($tinfo, "Y") & @LF)
					memout("-->HitInfo:" & @TAB & DllStructGetData($tinfo, "HitInfo") & @LF)
					Return True ; 表示鼠标已处于控制且由系统挂起默认操作
;~          Return FALSE ;允许默认点击操作.
				Case $NM_RDBLCLK ; 在控件中双击鼠标右键
					$tinfo = DllStructCreate($tagNMMOUSE, $ilParam)
					$hWndFrom = HWnd( DllStructGetData($tinfo, "hWndFrom"))
					$iIDFrom = DllStructGetData($tinfo, "IDFrom")
					$iCode = DllStructGetData($tinfo, "Code")
					memout("$NM_RDBLCLK" & @LF)
					memout("-->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memout("-->IDFrom:" & @TAB & $iIDFrom & @LF)
					memout("-->Code:" & @TAB & $iCode & @LF)
					memout("-->ItemSpec:" & @TAB & DllStructGetData($tinfo, "$ItemSpec") & @LF)
					memout("-->ItemData:" & @TAB & DllStructGetData($tinfo, "ItemData") & @LF)
					memout("-->X:" & @TAB & DllStructGetData($tinfo, "X") & @LF)
					memout("-->Y:" & @TAB & DllStructGetData($tinfo, "Y") & @LF)
					memout("-->HitInfo:" & @TAB & DllStructGetData($tinfo, "HitInfo") & @LF)
					Return True ; 表示鼠标已处于控制且由系统挂起默认操作
;~          Return FALSE ;允许默认点击操作.
				Case $SBN_SIMPLEMODECHANGE ; 简单模式改变
					memout("$SBN_SIMPLEMODECHANGE" & @LF)
					memout("-->hWndFrom:" & @TAB & $hWndFrom & @LF)
					memout("-->IDFrom:" & @TAB & $iIDFrom & @LF)
					memout("-->Code:" & @TAB & $iCode & @LF)
					; 无返回值
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
endfunc   ;==>WM_NOTIFY

Func memout($s_text)
	GUICtrlSetData($edit, $s_text & @CRLF, 1)
endfunc   ;==>memout

