#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 如果本地计算机为Windows域的成员获取数据
; *****************************************************************************
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

; 获取ADSystemInfo
Global $aInfo[10][2] = [[""],["distinguished name of the local computer"],["DNS name of the local computer domain"], _
		["short name of the local computer domain"],["DNS name of the local computer forest"],["Is local computer domain in native mode (TRUE) or mixed mode (FALSE)"], _
		["name of the NTDS-DSA object for the DC that owns the primary domain controller role in the local computer domain"], _
		["name of the NTDS-DSA object for the DC that owns the schema role in the local computer forest"],["site name of the local computer"], _
		["distinguished name of the current user"]]

Global $aTemp = _AD_GetSystemInfo()
For $iCount = 1 To $aTemp[0]
	$aInfo[$iCount][1] = $aTemp[$iCount]
Next
$aInfo[0][0] = $aTemp[0]
_arraydisplay($aInfo, "Active Directory Functions")

; 关闭Active Directory连接
_AD_Close()

