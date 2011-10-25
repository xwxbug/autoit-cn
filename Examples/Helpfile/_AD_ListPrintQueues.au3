#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

; *****************************************************************************
; 示例1 - 获取AD树中全部打印序列的列表
; *****************************************************************************
Global $aPrintQueues = _AD_ListPrintQueues()
If @error > 0 Then
	msgbox(16, "Active Directory Functions", "Could not find any print queues!")
	Exit
Else
	_ArrayDisplay($aPrintQueues, "AD - All print queues")
EndIf

; *****************************************************************************
; 示例2 - 获取指定延迟服务器中全部打印序列的列表
; *****************************************************************************
Global $sSpoolServer = StringSplit($aPrintQueues[1][1], ".")
$aPrintQueues = _AD_ListPrintQueues($sSpoolServer[1])
If @error > 0 Then
	msgbox(16, "Active Directory Functions", "Could not find any print queues for server'" & $sSpoolServer[1] & "'")
	Exit
Else
	_ArrayDisplay($aPrintQueues, "Active Directory Functions - All print queues for spool server'" & $sSpoolServer[1] & "'")
EndIf

; *****************************************************************************
; 示例3 - 列举首个打印序列的所用属性
; *****************************************************************************
Global $aPrinterDetails = _AD_GetObjectProperties($aPrintQueues[1][2])
_ArrayDisplay($aPrinterDetails, "Active Directory Functions - All properties for  print queue'" & $aPrintQueues[1][2] & "'")

; 关闭Active Directory连接
_AD_Close()

