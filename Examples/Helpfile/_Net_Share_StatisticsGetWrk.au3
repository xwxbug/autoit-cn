
#include  <GuiConstantsEx.au3>
#include  <NetShare.au3>
#include  <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $aInfo

	; 创建界面
	$hGUI = GUICreate("NetShare", 400, 300)

	; 创建memo控件
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 获取工作站统计信息
	$aInfo = _Net_Share_StatisticsGetWrk(@ComputerName)
	MemoWrite("NetStatisticsGetWrk")
	MemoWrite("Statistics started ......:" & $aInfo[0])
	MemoWrite("Bytes received ..........:" & $aInfo[1])
	MemoWrite("SMBs received ...........:" & $aInfo[2])
	MemoWrite("Paging I/O bytes ........:" & $aInfo[3])
	MemoWrite("Non-paging I/O bytes ....:" & $aInfo[4])
	MemoWrite("Cache I/O bytes ..... ...:" & $aInfo[5])
	MemoWrite("Disk I/O bytes ..........:" & $aInfo[6])
	MemoWrite("Bytes transmitted .......:" & $aInfo[7])
	MemoWrite("SMBs transmitted ........:" & $aInfo[8])
	MemoWrite("Paging I/O bytes ........:" & $aInfo[9])
	MemoWrite("Non-paging I/O bytes ....:" & $aInfo[10])
	MemoWrite("Cache I/O bytes .........:" & $aInfo[11])
	MemoWrite("Disk I/O bytes ..........:" & $aInfo[12])
	MemoWrite("Failed ops begin ........:" & $aInfo[13])
	MemoWrite("Failed ops completed ....:" & $aInfo[14])
	MemoWrite("Read operations .........:" & $aInfo[15])
	MemoWrite("Random access reads .....:" & $aInfo[16])
	MemoWrite("Read requests sent ......:" & $aInfo[17])
	MemoWrite("Read requests big .......:" & $aInfo[18])
	MemoWrite("Read requests small .....:" & $aInfo[19])
	MemoWrite("Write operations ........:" & $aInfo[20])
	MemoWrite("Random access writes ....:" & $aInfo[21])
	MemoWrite("Write requests sent .....:" & $aInfo[22])
	MemoWrite("Write requests big ......:" & $aInfo[23])
	MemoWrite("Write requests small ....:" & $aInfo[24])
	MemoWrite("Denied raw reads ........:" & $aInfo[25])
	MemoWrite("Denied raw writes .......:" & $aInfo[26])
	MemoWrite("Network errors ..........:" & $aInfo[27])
	MemoWrite("Sessions established ....:" & $aInfo[28])
	MemoWrite("Failed sessions .........:" & $aInfo[29])
	MemoWrite("Failed connections ......:" & $aInfo[30])
	MemoWrite("PCNET connections .......:" & $aInfo[31])
	MemoWrite("NetShare 20 connections .:" & $aInfo[32])
	MemoWrite("NetShare 21 connections .:" & $aInfo[33])
	MemoWrite("WinNT connections .......:" & $aInfo[34])
	MemoWrite("Disconnects .............:" & $aInfo[35])
	MemoWrite("Sessions expired ........:" & $aInfo[36])
	MemoWrite("Connections made ........:" & $aInfo[37])
	MemoWrite("Connections failed ......:" & $aInfo[38])
	MemoWrite("Incomplete requests .....:" & $aInfo[39])

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

