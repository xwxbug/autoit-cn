#Include <WinAPIEx.au3>
#Include <Memory.au3>

Opt('MustDeclareVars ', 1)

Global $tPRINTDLGEX, $tPRINTPAGERANGE, $tDEVNAMES, $hDevNames, $pDevNames, $Result
Global $Page[2]

;创建PRINTDLGEX结构并设置数量, 起始页和停止页的初始值
$tPRINTPAGERANGE = DllStructCreate($tagPRINTPAGERANGE)
DllStructSetData($tPRINTPAGERANGE, 'FromPage ', 2)
DllStructSetData($tPRINTPAGERANGE, 'ToPage ', 3)
$tPRINTDLGEX = DllStructCreate($tagPRINTDLGEX)
DllStructSetData($tPRINTDLGEX, 'Size ', DllStructGetSize($tPRINTDLGEX))
DllStructSetData($tPRINTDLGEX, 'hOwner ', WinGetHandle( AutoItWinGetTitle()))
DllStructSetData($tPRINTDLGEX, 'Flags ', BitOR($PD_PAGENUMS, $PD_NOCURRENTPAGE, $PD_NOSELECTION))
DllStructSetData($tPRINTDLGEX, 'NumPageRanges ', 1)
DllStructSetData($tPRINTDLGEX, 'MaxPageRanges ', 1)
DllStructSetData($tPRINTDLGEX, 'PageRanges ', DllStructGetPtr($tPRINTDLGEX))
DllStructSetData($tPRINTDLGEX, 'MinPage ', 1)
DllStructSetData($tPRINTDLGEX, 'MaxPage ', 9)
DllStructSetData($tPRINTDLGEX, 'Copies ', 4)
DllStructSetData($tPRINTDLGEX, 'StartPage ', -1)

; 创建打印对话框
If Not _WinAPI_PrintDlg($tPRINTDLGEX) Then
	Exit
EndIf

Switch @extended
	Case $PD_RESULT_PRINT
		; 用户点击"Print"(打印)按钮
	Case $PD_RESULT_APPLY
		; 用户点击"Apply"(应用)按钮且稍后点击"Cancel"(取消)按钮
	Case $PD_RESULT_CANCEL
		Exit
EndSwitch

; 显示结果
$hDevNames = DllStructGetData($tPRINTDLGEX, 'hDevNames')
$pDevNames = _MemGlobalLock($hDevNames)
$tDEVNAMES = DllStructCreate($tagDEVNAMES, $pDevNames)
$Result = ' Printer:' & _WinAPI_GetString($pDevNames + 2 * DllStructGetData($tDEVNAMES, 'DeviceOffset')) & @CR
If DllStructGetData($tDEVNAMES, 'Default') Then
	$Result &= ' (Default)' & @CR
Else
	$Result &= @CR
EndIf
If BitAND( DllStructGetData($tPRINTDLGEX, 'Flags'), $PD_PAGENUMS) Then
	$Page[0] = DllStructGetData($tPRINTPAGERANGE, 'FromPage')
	$Page[1] = DllStructGetData($tPRINTPAGERANGE, 'ToPage')
Else
	$Page[0] = DllStructGetData($tPRINTDLGEX, 'MinPage')
	$Page[1] = DllStructGetData($tPRINTDLGEX, 'MaxPage')
EndIf
$Result &= ' First page:' & $Page[0] & @CR
$Result &= ' Last page:' & $Page[0] & @CR
$Result &= ' Copies:' & DllStructGetData($tPRINTDLGEX, 'Copies')
msgbox(64, 'Print ', $Result)

; 释放包含DEVMODE和DEVNAMES结构的全局内存对象
_MemGlobalFree( DllStructGetData($tPRINTDLGEX, 'hDevMode'))
_MemGlobalFree($hDevNames))

