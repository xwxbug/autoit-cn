#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include  <AD.au3>

; Open Connection to the Active Directory
_AD_Open()

; *****************************************************************************
; 示例1 - 获取活动目录中所有域控制器的列表
; *****************************************************************************
Global $aDC = _AD_ListDomainControllers()
_arraydisplay($aDC, "Active Directory Functions - All Domain Controllers, distinguished name, DNS host name, and the site name")

; *****************************************************************************
; 示例2 - 获取地址名的列表
; *****************************************************************************
_ArraySort($aDC, 0, 1, 0, 3)
Global $aSite = _ArrayUnique($aDC, 4, 1)
_arraydisplay($aSite, "Active Directory Functions - All Site Names")

; 关闭Active Directory连接
_AD_Close()

