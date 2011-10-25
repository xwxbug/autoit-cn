#Include <WinAPIEx.au3>
#Include <Memory.au3>

Opt('MustDeclareVars ', 1)

Global $tPRINTDLG, $tDEVNAMES, $hDevNames, $pDevNames, $Result

;创建PAGEDLG结构并设置数量, 起始页和停止页的初始值
$tPRINTDLG = DllStructCreate($tagPRINTDLG)
DllStructSetData($tPRINTDLG, 'Size ', DllStructGetSize($tPRINTDLG))
DllStructSetData($tPRINTDLG, 'Flags ', $PD_PAGENUMS)
DllStructSetData($tPRINTDLG, 'FromPage ', 2)
DllStructSetData($tPRINTDLG, 'ToPage ', 3)
DllStructSetData($tPRINTDLG, 'MinPage ', 1)
DllStructSetData($tPRINTDLG, 'MaxPage ', 9)
DllStructSetData($tPRINTDLG, 'Copies ', 4)

; 创建打印对话框
If Not _WinAPI_PrintDlg($tPRINTDLG) Then
	Exit
EndIf

; 显示结果
$hDevNames = DllStructGetData($tPRINTDLG, 'hDevNames')
$pDevNames = _MemGlobalLock($hDevNames)
$tDEVNAMES = DllStructCreate($tagDEVNAMES, $pDevNames)
$Result = ' Printer:' & _WinAPI_GetString($pDevNames + 2 * DllStructGetData($tDEVNAMES, 'DeviceOffset')) & @CR
If DllStructGetData($tDEVNAMES, 'Default') Then
	$Result &= ' (Default)' & @CR
Else
	$Result &= @CR
EndIf
$Result &= ' First page:' & DllStructGetData($tPRINTDLG, 'FromPage')
$Result &= ' Last page:' & DllStructGetData($tPRINTDLG, 'ToPage')
$Result &= ' Copies:' & DllStructGetData($tPRINTDLG, 'Copies')
msgbox(64, 'Print ', $Result)

; 释放包含DEVMODE和DEVNAMES结构的全局内存对象
_MemGlobalFree( DllStructGetData($tPRINTDLG, 'hDevMode'))
_MemGlobalFree($hDevNames))

