#Include <WinAPIEx.au3>
#Include <Memory.au3>

Opt('MustDeclareVars ', 1)

Global $tPAGESETUPDLG, $Result

;创建PAGESETUPDLG结构并设置所有初始边界值为10.00 mm
$tPAGESETUPDLG = DllStructCreate($tagPAGESETUPDLG)
DllStructSetData($tPAGESETUPDLG, 'Size ', DllStructGetSize($tPAGESETUPDLG))
DllStructSetData($tPAGESETUPDLG, 'Flags ', BitOR($PSD_INHUNDREDTHSOFMILLIMETERS, $PSD_MARGINS))
DllStructSetData($tPAGESETUPDLG, 'MarginLeft ', 10 * 100)
DllStructSetData($tPAGESETUPDLG, 'MarginTop ', 10 * 100)
DllStructSetData($tPAGESETUPDLG, 'MarginRight ', 10 * 100)
DllStructSetData($tPAGESETUPDLG, 'MarginBottom ', 10 * 100)

; 创建页面设置对话框
If Not _WinAPI_PageSetupDlg($tPAGESETUPDLG) Then
	Exit
EndIf

; 显示结果
$Result = ' Paper width:' & DllStructGetData($tPAGESETUPDLG, 'PaperWidth') / 100 & ' mm' & @CRLF
$Result &= ' Paper height:' & DllStructGetData($tPAGESETUPDLG, 'PaperHeight') / 100 & ' mm' & @CRLF
$Result &= ' Margin left:' & DllStructGetData($tPAGESETUPDLG, 'MarginLeft') / 100 & ' mm' & @CRLF
$Result &= ' Margin top:' & DllStructGetData($tPAGESETUPDLG, 'MarginTop') / 100 & ' mm' & @CRLF
$Result &= ' Margin right:' & DllStructGetData($tPAGESETUPDLG, 'MarginRight') / 100 & ' mm' & @CRLF
$Result &= ' Margin bottom:' & DllStructGetData($tPAGESETUPDLG, 'MarginBottom') / 100 & ' mm' & @CRLF
msgbox(16, 'Page Setup Info ', $Result)

; 释放包含DEVMODE和DEVNAMES结构的全局内存对象
_MemGlobalFree( DllStructGetData($tPAGESETUPDLG, 'hDevMode'))
_MemGlobalFree( DllStructGetData($tPAGESETUPDLG, 'hDevNames'))

