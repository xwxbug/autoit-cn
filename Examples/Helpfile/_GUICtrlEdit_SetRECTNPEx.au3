#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include  <GuiEdit.au3>
#include  <GuiStatusBar.au3>
#include  <GuiConstantsEx.au3>
#include  <WindowsConstants.au3>

Opt('MustDeclareVars ', 1)

$Debug_Ed = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作

_Main()

Func _Main()
	Local $StatusBar, $hEdit, $hGUI
	Local $sFile = RegRead('HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt ', 'InstallDir') & ' \include\changelog.txt '
	Local $aPartRightSide[6] = [50, 130, 210, 290, 378, -1], $tRect

	; 创建界面
	$hGUI = GUICreate('Edit Set RECTNPEx ', 400, 300)
	$hEdit = GUICtrlCreateEdit('', 2, 2, 394, 268, BitOR($ES_WANTRETURN, $WS_VSCROLL))
	$StatusBar = _GUICtrlStatusBar_Create($hGUI, $aPartRightSide)
	_GUICtrlStatusBar_SetIcon($StatusBar, 5, 97, 'shell32.dll')
	_GUICtrlStatusBar_SetText($StatusBar, 'Rect')
	GUISetState()

	; 获取矩形
	$tRect = _GUICtrlEdit_GetRECTEx($hEdit)
	DllStructSetData($tRect, 'Left ', DllStructGetData($tRect, 'Left') + 10)
	DllStructSetData($tRect, 'Top ', DllStructGetData($tRect, 'Top') + 10)
	DllStructSetData($tRect, 'Right ', DllStructGetData($tRect, 'Right') - 10)
	DllStructSetData($tRect, 'Bottom ', DllStructGetData($tRect, 'Bottom') - 10)

	; 添加文本
	_GUICtrlEdit_AppendText($hEdit, FileRead($sFile))
	_GUICtrlEdit_LineScroll($hEdit, 0, _GUICtrlEdit_GetLineCount($hEdit) * - 1)

	; 设置矩形
	_GUICtrlEdit_SetRECTNPEx($hEdit, $tRect)

	; 获取矩形
	$aRect = _GUICtrlEdit_GetRECTEx($hEdit)
	_GUICtrlStatusBar_SetText($StatusBar, 'Left:' & DllStructGetData($tRect, 'Left'), 1)
	_GUICtrlStatusBar_SetText($StatusBar, 'Topt:' & DllStructGetData($tRect, 'Top'), 2)
	_GUICtrlStatusBar_SetText($StatusBar, 'Right:' & DllStructGetData($tRect, 'Right'), 3)
	_GUICtrlStatusBar_SetText($StatusBar, 'Bottom:' & DllStructGetData($tRect, 'Bottom'), 4)

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
endfunc   ;==>_Main

