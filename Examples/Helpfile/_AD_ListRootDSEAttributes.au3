#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
; *****************************************************************************
; 获取所有RootDSE属性的列表
; *****************************************************************************
#include  <AD.au3>

; 打开Active Directory连接
_AD_Open()

; 获取所有RootDSE属性加描述的列表
Global $aRootDSE[23][2] = [[""],["configurationNamingContext"],["currentTime"],["defaultNamingContext"], _
		["dnsHostName"],["domainControllerFunctionality"],["domainFunctionality"],["dsServiceName"],["forestFunctionality"], _
		["highestCommittedUSN"],["isGlobalCatalogReady"],["isSynchronized"],["LDAPServiceName"],["namingContexts"], _
		["rootDomainNamingContext"],["schemaNamingContext"],["serverName"],["subschemaSubentry"],["supportedCapabilities"], _
		["supportedControl"],["supportedLDAPPolicies"],["supportedLDAPVersion"],["supportedSASLMechanisms"]]
Global $aTemp = _AD_ListRootDSEAttributes()
Global $iCount
For $iCount = 1 To $aTemp[0]
	$aRootDSE[$iCount][1] = $aTemp[$iCount]
Next
$aRootDSE[0][0] = $aTemp[0]
_arraydisplay($aRootDSE, "Active Directory Functions", -1, 0, "<")

; 关闭Active Directory连接
_AD_Close()

