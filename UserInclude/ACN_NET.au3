#include-once
#include <ie.au3>
;======================================================
;
; 函数名称:		_Thunder($url,$Filename,$Path,$comment,$ReferUrl,$startmode,$Orgin,$OrginThread)
; 详细信息:		调用迅雷下载
; $Url:			下载地址
; $Filename:	保存的文件名
; $Path:		保存的路径
; $comment:		下载任务注释
; $ReferUrl:	引用的URL
; $startmode:	开始模式,True(立即)/False(手动)
; $Orgin:		只从原始地址下载(True/False)
; $OrginThread: 从原始地址下载线程数
; 返回值 :		失败返回0,成功返回1
; 作者:			thesnow(rundll32@126.com)
;
;======================================================
Func _Thunder($Url, $Filename = "", $Path = "", $comment = "", $ReferUrl = "", $startmode = True, $Orgin = False, $OrginThread = 10)
	$obj = ObjCreate("ThunderAgent.Agent")
	If IsObj($obj) = 0 Then Return 0
	$obj.AddTask($Url, $Filename, $Path, $comment, $ReferUrl, $startmode, $Orgin, $OrginThread);添加下载任务
	$obj.CommitTasks() ;提交任务.
	Return 1
EndFunc   ;==>_Thunder

;======================================================
;
; 函数名称:		_Flashget($url,$Path,$flashgetpath)
; 详细信息:		调用网际快车下载
; $url:			下载地址
; $Path:		保存的路径
; $flashgetpath:网际快车的路径
; 返回值 :		失败返回0(网际快车未安装),成功返回1
; 作者:			thesnow(rundll32@126.com)
;
;======================================================
Func _Flashget($Url, $Path = "", $flashgetpath = "")
	If $flashgetpath = "" Then
		$flashgetpath = RegRead("HKEY_CURRENT_USER\Software\FlashGetX\General", "AppPath")
		If $flashgetpath = "" Then
			$flashgetpath = RegRead("HKEY_CURRENT_USER\Software\FlashGet\General", "AppPath")
		EndIf
		If $flashgetpath = "" Then Return 0
	EndIf
	ShellExecute($flashgetpath, $Url & " " & $Path)
	Return 1
EndFunc   ;==>_Flashget


;======================================================
;
; 函数名称:        _CMD_SetLocalIP("连接名称","IP地址",["子网掩码"],["默认网关"],["DNS"])
; 详细信息:        设置IP地址.
; $ConName:        连接名称
; $IpADD:          IP地址
; $SubMask:        子网掩码
; $GateWay:        默认网关
; $ConDNS:         DNS(域名解析)
; 作者:            thesnow(rundll32@126.com)
;
;======================================================
Func _CMD_SetLocalIP($ConName, $IpADD, $SubMask, $GateWay, $ConDNS)
	If $SubMask = "" Then $SubMask = "255.255.255.0"
	If $ConName = "" And $IpADD <> "" Then
		RunWait(@ComSpec & ' /C netsh -c interface ip set address "本地连接" static ' & $IpADD & " " & $SubMask & " " & $GateWay, "", @SW_HIDE)
	EndIf
	If $ConName <> "" And $IpADD <> "" Then
		RunWait(@ComSpec & ' /C netsh -c interface ip set address ' & '"' & $ConName & '"' & ' static ' & $IpADD & " " & $SubMask & " " & $GateWay, "", @SW_HIDE)
	EndIf
	If $ConDNS <> "" Then
		RunWait(@ComSpec & ' /C netsh -c interface ip set dns ' & '"' & $ConName & '"' & ' static ' & $ConDNS & ' primary', "", @SW_HIDE)
	EndIf
EndFunc   ;==>_CMD_SetLocalIP


;======================================================
;
; 函数名称:		_API_Get_NetworkAdapterMAC ($sIP)
; 详细信息:		根据API得到MAC.
; thesnow备注:	此函数是采用发送ARP方式,如果有错误的路由绑定或交换机绑定.可能得到错误的MAC.
; $sIP:         IP地址
; 作者:         jiexunpc
;
;======================================================
Func _API_Get_NetworkAdapterMAC($sIP)
	Local $MAC, $MACSize
	Local $i, $s, $r, $iIP

	$MAC = DllStructCreate("byte[6]")
	$MACSize = DllStructCreate("int")

	DllStructSetData($MACSize, 1, 6)
	$r = DllCall("Ws2_32.dll", "int", "inet_addr", "str", $sIP)
	$iIP = $r[0]
	$r = DllCall("iphlpapi.dll", "int", "SendARP", "int", $iIP, "int", 0, "ptr", DllStructGetPtr($MAC), "ptr", DllStructGetPtr($MACSize))
	$s = ""
	For $i = 0 To 5
		If $i Then $s = $s & ":"
		$s = $s & Hex(DllStructGetData($MAC, 1, $i + 1), 2)
	Next
	Return $s
EndFunc   ;==>_API_Get_NetworkAdapterMAC


;======================================================
;
; 函数名称:        _NetworkGetInternetIP
; 详细信息:        得到公网IP地址.
; 作者:            pcbar
;
;======================================================
Func _NetworkGetInternetIP()
	;by pcbar
	$oie = _IECreate("http://www.net.cn/static/customercare/yourIP.asp", 0, 0, 1, -1)
	$sText = _IEBodyReadText($oie)
	$ttext = StringRegExp($sText, '((2[0-4]\d|25[0-5]|[01]?\d\d?)\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)', 2)
	_IEQuit($oie)
	If IsArray($ttext) Then
		Return $ttext[0]
	Else
		SetError(1)
		Return 0
	EndIf
EndFunc   ;==>_NetworkGetInternetIP


;======================================================
;
; 函数名称:        _NetworkAdapterInfo()
; 详细信息:        获得网卡信息
; 返回值说明:
; 以二维数组方式返回.例如 $info=_NetworkAdapterInfo()
; $info[0][0]=网卡数量
; $info[1][0]第一块网卡的标志1
; $info[2][0]第二块网卡的标志2
; $info[1][1]第一块网卡的网卡名称
; $info[2][1]第二块网卡的网卡名称
; $info[1][2]第一块网卡的默认网关
; $info[1][3]第一块网卡的DNS主机名称(本机名称)
; $info[1][4]第一块网卡的IP地址
; $info[1][5]第一块网卡的主DNS
; $info[1][6]第一块网卡的次DNS
; $info[1][7]第一块网卡的子网掩码
; $info[1][8]第一块网卡的MAC地址
; $info[1][9]第一块网卡的连接名称
; 注意，此UDF不会获取已经禁用的网卡。
; 如果有需要，请删除' WHERE IPEnabled != 0'和' WHERE NetConnectionStatus >0'
; 作者:            thesnow(rundll32@126.com)
;
;======================================================
Func _NetworkAdapterInfo()
	Local $colItems = ""
	Local $objWMIService
	Local $NetworkAdapterID = 0
	Local $NetworkAdapterName = ""
	Local $NetworkAdapterGateway = ""
	Local $NetworkAdapterHostName = ""
	Local $NetworkAdapterIPaddress = ""
	Local $NetworkAdapterDNS1 = ""
	Local $NetworkAdapterDNS2 = ""
	Local $NetworkAdapterSubnet = ""
	Local $NetworkAdapterMAC = ""
	Local $NetworkAdapterNetConnectionID = ""
	Local $NetworkAdapterInfo[10][10] ;最高10块网卡.
	$NetworkAdapterInfo[0][0] = 0
	$objWMIService = ObjGet("winmgmts:\\localhost\root\CIMV2")
	$colItems = $objWMIService.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled != 0", "WQL", 0x10 + 0x20)
	$colItem2 = $objWMIService.ExecQuery('SELECT * FROM Win32_NetworkAdapter WHERE NetConnectionStatus >0', "WQL", 0x10 + 0x20)
	If IsObj($colItems) Then
		For $objItem In $colItems
			$NetworkAdapterName = $objItem.Description
			$NetworkAdapterGateway = $objItem.DefaultIPGateway(0)
			$NetworkAdapterHostName = $objItem.DNSHostName
			$NetworkAdapterIPaddress = $objItem.IPAddress(0)
			$NetworkAdapterDNS1 = $objItem.DNSServerSearchOrder(0)
			$NetworkAdapterDNS2 = $objItem.DNSServerSearchOrder(1)
			$NetworkAdapterSubnet = $objItem.IPSubnet(0)
			$NetworkAdapterMAC = $objItem.MACAddress
			$NetworkAdapterID += 1
			$NetworkAdapterInfo[0][0] = $NetworkAdapterID
			$NetworkAdapterInfo[$NetworkAdapterID][0] = $NetworkAdapterID
			$NetworkAdapterInfo[$NetworkAdapterID][1] = $NetworkAdapterName
			$NetworkAdapterInfo[$NetworkAdapterID][2] = $NetworkAdapterGateway
			$NetworkAdapterInfo[$NetworkAdapterID][3] = $NetworkAdapterHostName
			$NetworkAdapterInfo[$NetworkAdapterID][4] = $NetworkAdapterIPaddress
			$NetworkAdapterInfo[$NetworkAdapterID][5] = $NetworkAdapterDNS1
			$NetworkAdapterInfo[$NetworkAdapterID][6] = $NetworkAdapterDNS2
			$NetworkAdapterInfo[$NetworkAdapterID][7] = $NetworkAdapterSubnet
			$NetworkAdapterInfo[$NetworkAdapterID][8] = $NetworkAdapterMAC
		Next
	Else
		Return $NetworkAdapterInfo
	EndIf

	If IsObj($colItem2) Then
		$NetworkAdapterID = 0
		For $objItem2s In $colItem2
			$NetworkAdapterNetConnectionID = $objItem2s.NetConnectionID
			$NetworkAdapterID += 1
			$NetworkAdapterInfo[$NetworkAdapterID][9] = $NetworkAdapterNetConnectionID
		Next
		Return $NetworkAdapterInfo
	Else
		Return $NetworkAdapterInfo
	EndIf
EndFunc   ;==>_NetworkAdapterInfo

;======================================================
;
; 函数名称:		_WMI_SetNetworkAdapterInfo($HostName, $IpAdd, $SubMask, $GateWay, $DNS1, $DNS2, $IPX)
; 详细信息:		设置IP地址.
; $HostName:	计算机名称
; $IpAdd:		IP地址
; $SubMask:		子网掩码
; $GateWay:		默认网关
; $DNS1:		主DNS(域名解析)
; $DNS2:		次DNS(域名解析)
; $IPX:			IPX虚拟网络号
; 作者:			thesnow(rundll32@126.com)
;
;======================================================

Func _WMI_SetNetworkAdapterInfo($HostName, $IpADD, $SubMask, $GateWay, $DNS1, $DNS2, $IPX)
	Dim $SetDns[2], $SetIPAddress[1], $SetSubnetmask[1], $SetGateway[1]
	$SetDns[0] = $DNS1
	$SetDns[1] = $DNS2
	$SetIPAddress[0] = $IpADD
	$SetSubnetmask[0] = $SubMask
	$SetGateway[0] = $GateWay
	$objWMIService = ObjGet("winmgmts:\\localhost\root\CIMV2")
	$colItems = $objWMIService.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled = TRUE", "WQL", 0x10 + 0x20)
	$colComputers = $objWMIService.ExecQuery("Select * from Win32_ComputerSystem")
	$objNetworkSettings = $objWMIService.Get("Win32_NetworkAdapterConfiguration")
	For $objNetAdapter In $colComputers
		$objNetAdapter.Rename($HostName)
	Next
	If IsObj($colItems) Then
		For $objNetAdapter In $colItems
			$objNetAdapter.EnableStatic($SetIPAddress, $SetSubnetmask)
			$objNetAdapter.SetGateways($SetGateway)
			$objNetAdapter.SetDNSServerSearchOrder($SetDns)
		Next
	EndIf
	$objNetworkSettings.SetIPXVirtualNetworkNumber($IPX)
EndFunc   ;==>_WMI_SetNetworkAdapterInfo

;===============================================================================
;
; Function Name:    _FTPOpen()
; Description:      打开一个FTP会话.
; Parameter(s):     $s_Agent      	- 任意名字. ( 例如 "myftp" )
;                   $l_AccessType 	- 连接方式(
;									- 0,使用IE的连接设置,
;									- 1,直接连接到服务器,
;									- 3,通过代理服务器进行连接)
;                   $s_ProxyName  	- 代理服务器名.
;                   $s_ProxyBypass	- 代理服务器地址.
;                   $l_Flags       	- 特殊标记(一般为0).
; Requirement(s):   DllCall, wininet.dll
; Return Value(s):  成功 - 返回一个标识符.
;                   失败 - 返回0并设置@ERROR = -1
; Author(s):        Wouter van Kesteren.
;
;===============================================================================

Func _FTPOpen($s_Agent, $l_AccessType = 1, $s_ProxyName = '', $s_ProxyBypass = '', $l_Flags = 0)
	
	Local $ai_InternetOpen = DllCall('wininet.dll', 'long', 'InternetOpen', 'str', $s_Agent, 'long', $l_AccessType, 'str', $s_ProxyName, 'str', $s_ProxyBypass, 'long', $l_Flags)
	If @error OR $ai_InternetOpen[0] = 0 Then
		SetError(-1)
		Return 0
	EndIf
		
	Return $ai_InternetOpen[0]
	
EndFunc ;==> _FTPOpen()

;===============================================================================
;
; Function Name:    _FTPConnect()
; Description:      连接到一个FTP服务器.
; Parameter(s):     $l_InternetSession	- 由_FTPOpen()返回的会话标识符.
;                   $s_ServerName 		- 服务器地址或IP.
;                   $s_Username  		- 用户名.
;                   $s_Password			- 密码.
;                   $i_ServerPort  		- 服务器端口 ( 0 默认的是21端口 )
;					$l_Service			- 服务器类型(
;										- 1,FTP.
;										- 3,HTTP)
;					$l_Flags			- 特殊标志.
;					$l_Context			- 上下文ID.
; Requirement(s):   DllCall, wininet.dll
; Return Value(s):  成功 - 返回一个标识符.
;                   失败 - 返回0并设置@ERROR = -1
; Author(s):        Wouter van Kesteren
;
;===============================================================================

Func _FTPConnect($l_InternetSession, $s_ServerName, $s_Username, $s_Password, $i_ServerPort = 0, $l_Service = 1, $l_Flags = 0, $l_Context = 0)
	
	Local $ai_InternetConnect = DllCall('wininet.dll', 'long', 'InternetConnect', 'long', $l_InternetSession, 'str', $s_ServerName, 'int', $i_ServerPort, 'str', $s_Username, 'str', $s_Password, 'long', $l_Service, 'long', $l_Flags, 'long', $l_Context)
	If @error OR $ai_InternetConnect[0] = 0 Then
		SetError(-1)
		Return 0
	EndIf
			
	Return $ai_InternetConnect[0]
	
EndFunc ;==> _FTPConnect()

;===============================================================================
;
; Function Name:    _FTPPutFile()
; Description:      上传一个文件到FTP服务器.
; Parameter(s):     $l_FTPSession	- 由_FTPConnect()返回的会话标识符.
;                   $s_LocalFile 	- 本地文件.
;                   $s_RemoteFile  	- 远程文件.
;                   $l_Flags		- 特殊标志.
;                   $l_Context  	- 上下文ID.
; Requirement(s):   DllCall, wininet.dll
; Return Value(s):  成功 - 返回1
;                   失败 - 返回0并设置@ERROR = -1
; Author(s):        Wouter van Kesteren
;
;===============================================================================

Func _FTPPutFile($l_FTPSession, $s_LocalFile, $s_RemoteFile, $l_Flags = 0, $l_Context = 0)

	Local $ai_FTPPutFile = DllCall('wininet.dll', 'int', 'FtpPutFile', 'long', $l_FTPSession, 'str', $s_LocalFile, 'str', $s_RemoteFile, 'long', $l_Flags, 'long', $l_Context)
	If @error OR $ai_FTPPutFile[0] = 0 Then
		SetError(-1)
		Return 0
	EndIf
	
	Return $ai_FTPPutFile[0]
	
EndFunc ;==> _FTPPutFile()

;===============================================================================
;
; Function Name:    _FTPDelFile()
; Description:      从FTP服务器上删除一个文件.
; Parameter(s):     $l_FTPSession	- 由_FTPConnect()返回的会话标识符.
;                   $s_RemoteFile  	- 远程文件.
; Requirement(s):   DllCall, wininet.dll
; Return Value(s):  成功 - 返回1
;                   失败 - 返回0并设置@ERROR = -1
; Author(s):        Wouter van Kesteren
;
;===============================================================================

Func _FTPDelFile($l_FTPSession, $s_RemoteFile)
	
	Local $ai_FTPPutFile = DllCall('wininet.dll', 'int', 'FtpDeleteFile', 'long', $l_FTPSession, 'str', $s_RemoteFile)
	If @error OR $ai_FTPPutFile[0] = 0 Then
		SetError(-1)
		Return 0
	EndIf
	
	Return $ai_FTPPutFile[0]
	
EndFunc ;==> _FTPDelFile()

;===============================================================================
;
; Function Name:    _FTPRenameFile()
; Description:      重命名FTP服务器上的文件.
; Parameter(s):     $l_FTPSession	- 由_FTPConnect()返回的会话标识符.
;                   $s_Existing 	- 原文件名.
;                   $s_New  		- 新文件名.
; Requirement(s):   DllCall, wininet.dll
; Return Value(s):  成功 - 返回1
;                   失败 - 返回0并设置@ERROR = -1
; Author(s):        Wouter van Kesteren
;
;===============================================================================

Func _FTPRenameFile($l_FTPSession, $s_Existing, $s_New)
	
	Local $ai_FTPRenameFile = DllCall('wininet.dll', 'int', 'FtpRenameFile', 'long', $l_FTPSession, 'str', $s_Existing, 'str', $s_New)
	If @error OR $ai_FTPRenameFile[0] = 0 Then
		SetError(-1)
		Return 0
	EndIf
	
	Return $ai_FTPRenameFile[0]
	
EndFunc ;==> _FTPRenameFile()

;===============================================================================
;
; Function Name:    _FTPMakeDir()
; Description:      在FTP服务器上新建一个目录.
; Parameter(s):     $l_FTPSession	- 由_FTPConnect()返回的会话标识符.
;                   $s_Remote 		- 要创建的目录名.
; Requirement(s):   DllCall, wininet.dll
; Return Value(s):  成功 - 返回1
;                   失败 - 返回0并设置@ERROR = -1
; Author(s):        Wouter van Kesteren
;
;===============================================================================

Func _FTPMakeDir($l_FTPSession, $s_Remote)
	
	Local $ai_FTPMakeDir = DllCall('wininet.dll', 'int', 'FtpCreateDirectory', 'long', $l_FTPSession, 'str', $s_Remote)
	If @error OR $ai_FTPMakeDir[0] = 0 Then
		SetError(-1)
		Return 0
	EndIf
	
	Return $ai_FTPMakeDir[0]
	
EndFunc ;==> _FTPMakeDir()

;===============================================================================
;
; Function Name:    _FTPDelDir()
; Description:      删除FTP服务器上的一个目录.
; Parameter(s):     $l_FTPSession	- 由_FTPConnect()返回的会话标识符.
;                   $s_Remote 		- 要删除的目录名.
; Requirement(s):   DllCall, wininet.dll
; Return Value(s):  成功 - 返回1
;                   失败 - 返回0并设置@ERROR = -1
; Author(s):        Wouter van Kesteren
;
;===============================================================================

Func _FTPDelDir($l_FTPSession, $s_Remote)
	
	Local $ai_FTPDelDir = DllCall('wininet.dll', 'int', 'FtpRemoveDirectory', 'long', $l_FTPSession, 'str', $s_Remote)
	If @error OR $ai_FTPDelDir[0] = 0 Then
		SetError(-1)
		Return 0
	EndIf
		
	Return $ai_FTPDelDir[0]
	
EndFunc ;==> _FTPDelDir()

;===============================================================================
;
; Function Name:    _FTPClose()
; Description:      关闭FTP会话.
; Parameter(s):     $l_InternetSession	- 由_FTPOpen()返回的会话标识符.
; Requirement(s):   DllCall, wininet.dll
; Return Value(s):  成功 - 返回1
;                   失败 - 返回0并设置@ERROR = -1
; Author(s):        Wouter van Kesteren
;
;===============================================================================

Func _FTPClose($l_InternetSession)
	
	Local $ai_InternetCloseHandle = DllCall('wininet.dll', 'int', 'InternetCloseHandle', 'long', $l_InternetSession)
	If @error OR $ai_InternetCloseHandle[0] = 0 Then
		SetError(-1)
		Return 0
	EndIf
	
	Return $ai_InternetCloseHandle[0]
	
EndFunc ;==> _FTPClose()