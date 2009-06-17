#NoTrayIcon
#Region ;**** 参数创建于 AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=lemon.ico
#AutoIt3Wrapper_useansi=n
#AutoIt3Wrapper_outfile=..\..\AllFile\Extras\AutoUpdateIt\AutoUpdateIt.exe
#AutoIt3Wrapper_Res_Comment=http://www.autoit.net.cn
#AutoIt3Wrapper_Res_Description=AutoIt v3
#AutoIt3Wrapper_res_field=QQ|133333542
#AutoIt3Wrapper_Res_Fileversion=3.3.1.1
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_useupx=n
#AutoIt3Wrapper_Run_AU3Check=y
#EndRegion ;**** 参数创建于 AutoIt3Wrapper_GUI ****
;
; =======================================================================
; AutoUpdateIt
; 原作: Rob Saunders
; 修改: JPM/strik3r0475
; 再修改: thesnow@www.autoit.net.cn
; 命令行选项:
;  - AutoUpdateIt.au3 [/release | /beta | /prebeta] [/silent] [/noproxy]
;    - /release		下载正式版本
;    - /beta		下载测试版本
;    - /prebeta   	下载预测试版本
;    - /silent		静默安装
;    - /noproxy   	使用直接连接(不使用 IE 代理)
;
; History:
;  - 1.50 - Rewrote the code to new Inet... functions (InetClose, InetGetInfo) (by Prog@ndy)
;  - 1.41 - Added error message when dowload is not working (by JPM)
;  - 1.40 - Fixed a bug where the updater crashed if AU3 was not already installed (by erebus)
;         - Fixed some display bugs, occured if AU3 was not already installed (by erebus)
;         - Re-added the installation paths on the GUI; tiny but useful (by erebus)
;         - Added the /noproxy command line switch to allow direct internet access (by erebus)
;         - Added a menu option to disable/enable the use of IE's proxy (by erebus)
;  - 1.37 - Change Alpha to Pre-Beta (by JPM)
;  - 1.36 - Display current Beta (by strik3r0475)
;  - 1.35 - Fixed some display bugs
;  - 1.34 - Display Alpha release if available
;         - Command line parameters added /alpha to check for latest alpha
;  - 1.33 - Added Retry/Cancel msgbox when cannot connect to receive update file
;         - Added Progress bar for non-WinXP users
;  - 1.32 - Changed _CompareVersions again (integer comparison now)
;  - 1.31 - Rewrote _ClipPath again
;  - 1.30 - Rewrote a few UDFs (_CompareVersions, _ClipPath)
;         - Underscored all UDF names
;         - Removed a misplaced 'Then' screwing up command line options
;  - 1.21 - Stupid bug fixed (ignored version check for /beta command)
;         - CompareVersions function works properly now (was seeing 3.0.103.173 as newer than 3.1.0.1)
;  - 1.20 - Command line parameters added
;           - /release to check for latest public release
;           - /beta to check for latest beta
;           - /silent to install silently (you will lose your compiler and file settings)
;  - 1.11 - Starts the download when you press one of the download
;           buttons, resulting in pre-downloading while you choose
;           where to save the file
;         - Default name for Beta download includes full version string
;         - Deletes "au3_update.dat" from temp files after loading data
;  - 1.10 - Displays release date
;         - Changed layout of buttons / groups
;         - Slightly modified error message when server inaccessible
;  - 1.00 - "Release" / given a version number
;
; Forum Threads:
;  - http://www.autoitscript.com/forum/index.ph...view=getnewpost
;  - http://www.autoitscript.com/forum/index.ph...view=getnewpost
;
; =======================================================================
#Include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>

; ========================================
; 				声明变量
; ========================================
Global Const $s_Title = '自动更新'
;Global Const $s_Version = '1.41'
Global Const $s_Version= FileGetVersion(@ScriptFullPath)
Global Const $s_DatFile = 'http://www.autoitscript.com/autoit3/files/beta/update.dat'
Global Const $b_Download_UpdateDat = 1
Global Const $s_DatFile_Local = @TempDir & '\au3_update.dat'
Global Const $s_Au3UpReg = 'HKCU\Software\AutoIt v3\AutoUpdateIt'
Global $i_DownSize, $s_DownPath, $s_DownTemp, $s_DownFolder
Global $i_DatFileLoaded, $i_ValidAu3Path, $i_DnInitiated
Global $s_AutoUpdate, $i_SilentInstall
Global $s_CurrDate
Global $s_ReleaseVer, $s_ReleaseFile, $i_ReleaseSize, $i_ReleaseDate, $s_ReleasePage
Global $s_LatestBetaVer, $s_BetaFile, $i_BetaSize, $i_BetaDate, $s_BetaPage, $s_CurrBetaVer, $s_CurrBetaDate
Global $s_PreBetaVer, $s_PreBetaFile, $i_PreBetaSize, $i_PreBetaDate, $s_PreBetaPage
Global $s_CurrVer, $s_DownSize, $gui_Main, $me_Mn_Help, $me_Mn_Proxy, $me_Mn_VisitSite, $me_Mn_About
Global $lb_separator, $gr_Instal_Details, $gr_Mn_Release, $lb_Mn_ReleaseVer, $lb_Mn_ReleaseDate
Global $gr_Mn_Beta, $lb_Mn_BetaVer, $lb_Mn_BetaDate, $gr_Mn_PreBeta, $lb_Mn_PreBetaVer, $lb_Mn_PreBetaDate
Global $ra_Mn_DoneNotify, $ra_Mn_DoneRun, $bt_Mn_Close, $bt_Mn_ReleaseDl, $lb_Mn_ReleaseSize
Global $lb_Mn_ReleasePage, $bt_Mn_BetaDl, $lb_Mn_BetaSize, $lb_Mn_BetaPage, $bt_Mn_PreBetaDl
Global $lb_Mn_PreBetaSize, $lb_Mn_PreBetaPage, $a_DownButtons, $lb_Mn_DwnToTtl
Global $lb_Mn_DwnToTxt, $pg_Mn_Progress, $bt_Mn_OpenFile, $bt_Mn_OpenFolder, $a_DownDisplay
Global $lb_Mn_Progress, $gui_About, $lb_Ab_VisitSite, $bt_Ab_Close, $a_GMsg
Global $i_Res, $pos, $i_ReleaseSizeKB, $i_BetaSizeKB, $i_PreBetaSizeKB, $i_DnPercent
Global $s_DnBytes, $s_DnSize,$i_Response, $tmp, $s_DefFileName, $len
Global $i_ProgOn, $i_StatusPercent

Global $i_InetGetHandle

; ========================================
; 			读取注册表设置
; ========================================
Global $s_DefDownDir = RegRead($s_Au3UpReg, 'DownloadDir')
If @error Then
	$s_DefDownDir = @DesktopDir
EndIf
Global $s_Au3Path = RegRead64('HKLM\Software\AutoIt v3\AutoIt', 'InstallDir')
If Not @error And FileExists($s_Au3Path & '\AutoIt3.exe') Then
	$s_CurrVer = FileGetVersion($s_Au3Path & "\AutoIt3.exe")
	$s_CurrDate = _FriendlyDate(FileGetTime($s_Au3Path & "\AutoIt3.exe", 0, 1))
Else
	$s_Au3Path = '安装路径没有找到'
	$s_CurrVer = '没有找到'
	$s_CurrDate = '没有找到'
EndIf
Global $s_BetaPath = RegRead64('HKLM\Software\AutoIt v3\AutoIt', 'betaInstallDir')
If Not @error And FileExists($s_BetaPath & '\AutoIt3.exe') Then
	$s_CurrBetaVer = FileGetVersion($s_BetaPath & "\AutoIt3.exe")
	$s_CurrBetaDate = _FriendlyDate(FileGetTime($s_BetaPath & "\AutoIt3.exe", 0, 1))
Else
	$s_BetaPath = '安装路径没有找到'
	$s_CurrBetaVer = '没有找到'
	$s_CurrBetaDate = '没有找到'
EndIf
; ========================================
; 			命令行方式检查程序更新
; ========================================
If _StringInArray($CmdLine, '/noproxy') Then HttpSetProxy(1)
If _StringInArray($CmdLine, '/release') Or _StringInArray($CmdLine, '/beta') Or _StringInArray($CmdLine, '/prebeta') Then
	Opt('TrayIconHide', 0)
	_Status('更新检查中...')
	InetGet($s_DatFile, $s_DatFile_Local, 1 )
	If @error<>0 Then
		_Status('不能连接到站点', '请检查您的网络连接')
		Sleep(4000)
		Exit
	EndIf
	_LoadUpdateData()
	If _StringInArray($CmdLine, '/release') And _CompareVersions($s_ReleaseVer, $s_CurrVer) Then
		$s_AutoUpdate = $s_ReleaseFile
		$s_DownTemp = @TempDir & '\autoit-v3-setup.exe'
		$i_DownSize = $i_ReleaseSize
	ElseIf _StringInArray($CmdLine, '/beta') And _CompareVersions($s_LatestBetaVer, $s_CurrVer) Then
		$s_AutoUpdate = $s_BetaFile
		$s_DownTemp = @TempDir & '\autoit-v' & $s_LatestBetaVer & '.exe'
		$i_DownSize = $i_BetaSize
	ElseIf _StringInArray($CmdLine, '/prebeta') And _CompareVersions($s_PreBetaVer, $s_CurrVer) Then
		$s_AutoUpdate = $s_PreBetaFile
		$s_DownTemp = @TempDir & '\autoit-v' & $s_PreBetaVer & '.exe'
		$i_DownSize = $i_PreBetaSize
	EndIf
	If $s_AutoUpdate Then
		$i_InetGetHandle = InetGet($s_AutoUpdate, $s_DownTemp, 1, 1)
		$s_DownSize = Round($i_DownSize / 1024) & ' KB'
		Do
			_Status('下载更新中', '', InetGetInfo($i_InetGetHandle, 0), $i_DownSize)
		Until InetGetInfo($i_InetGetHandle, 2)
		_Status('下载完成', '启动安装程序')
		InetClose($i_InetGetHandle)
		$i_InetGetHandle=-1
		Sleep(1000)
		If _StringInArray($CmdLine, '/silent') Then
			_Start('"' & $s_DownTemp & '" /S')
		Else
			_Start('"' & $s_DownTemp & '"')
		EndIf
	Else
		_Status('没有发现新版本')
		Sleep(1000)
	EndIf
	Exit
EndIf
; ========================================
; 				GUI - 主界面
; ========================================
Opt("GuiResizeMode", $GUI_DOCKALL)
$gui_Main = GUICreate($s_Title, 350, 310 + 20)
$me_Mn_Help = GUICtrlCreateMenu('帮助[&H]')
$me_Mn_Proxy = GUICtrlCreateMenuItem('关闭 IE 的代理服务器', $me_Mn_Help)
$me_Mn_VisitSite = GUICtrlCreateMenuItem('登录 AutoIt3 官方网站[&V]', $me_Mn_Help)
$snow_Mn_VisitSite = GUICtrlCreateMenuItem('登录 AutoIt3 中文论坛[&C]', $me_Mn_Help)
$me_Mn_About = GUICtrlCreateMenuItem('关于[&A]', $me_Mn_Help)
$lb_separator = GUICtrlCreateLabel('', 0, 0, 350, 2, $SS_SUNKEN)
$gr_Instal_Details = GUICtrlCreateGroup('本地安装程序信息:', 5, 5, 340, 70)
GUICtrlCreateLabel('正式版本: ' & $s_CurrVer, 15, 25, 160, 15)
GUICtrlCreateLabel('日期: ' & $s_CurrDate, 15, 40, 160, 15)
GUICtrlCreateLabel('路径: ' & $s_Au3Path, 15, 55, 160, 15)
GUICtrlSetFont(-1, 6)
GUICtrlCreateLabel('测试版本: ' & $s_CurrBetaVer, 190, 25, 150, 15)
GUICtrlCreateLabel('日期: ' & $s_CurrBetaDate, 190, 40, 150, 15)
GUICtrlCreateLabel('路径: ' & $s_BetaPath, 190, 55, 150, 15)
GUICtrlSetFont(-1, 6)
$gr_Mn_Release = GUICtrlCreateGroup('最新正式发布版本', 5, 85, 165, 60)
$lb_Mn_ReleaseVer = GUICtrlCreateLabel('版本: 载入中...', 15, 105, 145, 15)
$lb_Mn_ReleaseDate = GUICtrlCreateLabel('日期: 载入中...', 15, 120, 145, 15)
$gr_Mn_Beta = GUICtrlCreateGroup('最新发布测试版本', 180, 85, 165, 60)
$lb_Mn_BetaVer = GUICtrlCreateLabel('版本: 载入中...', 190, 105, 145, 15)
$lb_Mn_BetaDate = GUICtrlCreateLabel('日期: 载入中...', 190, 120, 145, 15)
$gr_Mn_PreBeta = GUICtrlCreateGroup('最新发布汉化版本', 180 + 175, 85, 165, 60)
$lb_Mn_PreBetaVer = GUICtrlCreateLabel('版本: 载入中...', 190 + 175, 105, 145, 15)
$lb_Mn_PreBetaDate = GUICtrlCreateLabel('日期: 载入中...', 190 + 175, 120, 145, 15)
GUIStartGroup()
$ra_Mn_DoneNotify = GUICtrlCreateRadio('下载完成后什么都不做[&N]', 5, 155, 340, 15)
$ra_Mn_DoneRun = GUICtrlCreateRadio('下载完成后自动安装[&A]', 5, 175, 340, 15)
; Check default done option
If RegRead($s_Au3UpReg, 'DoneOption') = '运行[&R]' Then
	GUICtrlSetState($ra_Mn_DoneRun, $GUI_CHECKED)
Else
	GUICtrlSetState($ra_Mn_DoneNotify, $GUI_CHECKED)
EndIf
$bt_Mn_Close = GUICtrlCreateButton('关闭[&C]', 10, 275, 330, 25)
; ========================================
; 控件设置 - 下载按钮
; ========================================
$bt_Mn_ReleaseDl = GUICtrlCreateButton('下载正式版本[&R]', 5, 195, 165, 30)
GUICtrlSetState(-1, $GUI_DISABLE)
$lb_Mn_ReleaseSize = GUICtrlCreateLabel('大小: 载入中...', 5, 230, 165, 15, $SS_CENTER)
$lb_Mn_ReleasePage = GUICtrlCreateLabel('登录下载页', 5, 245, 165, 15, $SS_CENTER)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetFont(-1, 9, 400, 4)
GUICtrlSetColor(-1, 0x0000ff)
GUICtrlSetCursor(-1, 0)
$bt_Mn_BetaDl = GUICtrlCreateButton('下载测试版本[&B]', 180, 195, 165, 30)
GUICtrlSetState(-1, $GUI_DISABLE)
$lb_Mn_BetaSize = GUICtrlCreateLabel('大小: 载入中...', 180, 230, 165, 15, $SS_CENTER)
$lb_Mn_BetaPage = GUICtrlCreateLabel('登录下载页', 180, 245, 165, 15, $SS_CENTER)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetFont(-1, 9, 400, 4)
GUICtrlSetColor(-1, 0x0000ff)
GUICtrlSetCursor(-1, 0)
$bt_Mn_PreBetaDl = GUICtrlCreateButton('下载预测试版本[&P]', 180 + 175, 195, 165, 30)
GUICtrlSetState(-1, $GUI_DISABLE)
$lb_Mn_PreBetaSize = GUICtrlCreateLabel('大小: 载入中...', 180 + 175, 230, 165, 15, $SS_CENTER)
$lb_Mn_PreBetaPage = GUICtrlCreateLabel('登录下载页', 180 + 175, 245, 165, 15, $SS_CENTER)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetFont(-1, 9, 400, 4)
GUICtrlSetColor(-1, 0x0000ff)
GUICtrlSetCursor(-1, 0)
$a_DownButtons = StringSplit($bt_Mn_ReleaseDl & '.' & _
		$lb_Mn_ReleaseSize & '.' & _
		$lb_Mn_ReleasePage & '.' & _
		$bt_Mn_BetaDl & '.' & _
		$lb_Mn_BetaSize & '.' & _
		$lb_Mn_BetaPage & '.' & _
		$bt_Mn_PreBetaDl & '.' & _
		$lb_Mn_PreBetaSize & '.' & _
		$lb_Mn_PreBetaPage, '.')
; ========================================
; 			控件设置 - 下载显示
; ========================================
$lb_Mn_DwnToTtl = GUICtrlCreateLabel('下载到:', 5, 195, 290, 15, $SS_LEFTNOWORDWRAP)
$lb_Mn_DwnToTxt = GUICtrlCreateLabel('', 5, 210, 290, 15, $SS_LEFTNOWORDWRAP)
$pg_Mn_Progress = GUICtrlCreateProgress(5, 225, 340, 20)
$lb_Mn_Progress = GUICtrlCreateLabel('', 5, 250, 290, 15)
$bt_Mn_OpenFile = GUICtrlCreateButton('打开[&O]', 75, 275, 75, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
$bt_Mn_OpenFolder = GUICtrlCreateButton('打开文件夹[&F]', 155, 275, 95, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
$a_DownDisplay = StringSplit($lb_Mn_DwnToTtl & '.' & _
		$lb_Mn_DwnToTxt & '.' & _
		$pg_Mn_Progress & '.' & _
		$lb_Mn_Progress & '.' & _
		$bt_Mn_OpenFile & '.' & _
		$bt_Mn_OpenFolder, '.')
_GuiCtrlGroupSetState($a_DownDisplay, $GUI_HIDE)
; ========================================
; GUI - 关于
; ========================================
$gui_About = GUICreate('关于', 360, 140, -1, -1, BitOR($WS_CAPTION, $WS_SYSMENU), -1, $gui_Main)
GUICtrlCreateLabel($s_Title & ' v' & $s_Version & ' - AutoIt3 程序更新' & @LF & _
		@LF & _
		'	这个程序通过修改原先的更新文件才得以实现. ' & @CR & _
		'	感谢我们拥有一个这么强大的脚本软件。' & @CR & @CR & _
		'	请多支持我们论坛哦！', 5, 5, 310, 86)
$lb_Ab_VisitSite = GUICtrlCreateLabel('登录AutoIt官方网站', 5, 90, 145, 15)
GUICtrlSetFont(-1, 9, 400, 4)
GUICtrlSetColor(-1, 0x0000ff)
GUICtrlSetCursor(-1, 0)
GUICtrlSetTip(-1, 'http://www.autoitscript.com')
$lb_Ab_ContactAuthor = GUICtrlCreateLabel('登录Autoit中文论坛', 5, 110, 145, 15)
GUICtrlSetFont(-1, 9, 400, 4)
GUICtrlSetColor(-1, 0x0000ff)
GUICtrlSetCursor(-1, 0)
GUICtrlSetTip(-1, 'http://www.autoit.net.cn')
$bt_Ab_Close = GUICtrlCreateButton('关闭[&C]', 220, 90, 100, 30)
; ========================================
; 应用程序开始
; ========================================
; 显示主窗口
If _StringInArray($CmdLine, '/noproxy') Then GUICtrlSetState($me_Mn_Proxy, $GUI_CHECKED)
GUISetState(@SW_SHOW, $gui_Main)
; 下载更新文件
If $b_Download_UpdateDat Then
	$i_InetGetHandle = InetGet($s_DatFile, $s_DatFile_Local, 1, 1)
Else
	FileCopy(@ScriptDir & '\update.dat', $s_DatFile_Local) ; to test locally
EndIf
; Harness GUI Events
While 1
	$a_GMsg = GUIGetMsg(1)
	If Not $i_DatFileLoaded And  InetGetInfo($i_InetGetHandle,2) Then
		If InetGetInfo($i_InetGetHandle,3) = False And $b_Download_UpdateDat Then
			$i_Res = MsgBox(5 + 16 + 8192, '出错啦!', '无法连接到官方服务器.' & @LF & _
					'请尝试下列操作:' & @LF & _
					' - 确认电脑已经连接到因特网' & @LF & _
					' - 防火墙不要禁止本程序连接到因特网' & @CRLF & _
					' - 登录 官方网站或者中文论坛 进行软件下载' & @LF & _
					' - 确认官方或者中文论坛还没有倒闭	ε|^_^|з')
			If $i_Res = 4 Then
				$i_InetGetHandle = InetGet($s_DatFile, $s_DatFile_Local, 1, 1)
			Else
				Exit
			EndIf
		Else
			_LoadUpdateData()
			If $s_PreBetaVer <> '' Then
				If _CompareVersions(StringTrimRight($s_PreBetaVer, 1), $s_LatestBetaVer) > 0 Then
					$pos = WinGetPos($s_Title)
					WinMove($s_Title, "", $pos[0], $pos[1], $pos[2] + 175, $pos[3])
					GUICtrlSetPos($lb_separator, 0, 0, 350 + 175, 2)
					GUICtrlSetPos($gr_Instal_Details, 5, 5, 340 + 175, 75)
					GUICtrlSetPos($bt_Mn_Close, 10, 275, 330 + 175, 25)
					GUICtrlSetPos($lb_Mn_DwnToTtl, 5, 195, 290 + 175, 15)
					GUICtrlSetPos($lb_Mn_DwnToTxt, 5, 210, 290 + 175, 15)
					GUICtrlSetPos($pg_Mn_Progress, 5, 225, 340 + 175, 20)
					GUICtrlSetPos($lb_Mn_Progress, 5, 250, 290 + 175, 15)
					GUICtrlSetPos($bt_Mn_OpenFile, 105 + 175, 275, 75, 25)
					GUICtrlSetPos($bt_Mn_OpenFolder, 185 + 175, 275, 75, 25)
				Else
					$s_PreBetaVer = ''
				EndIf
			EndIf
			$i_ReleaseSizeKB = Round($i_ReleaseSize / 1024)
			$i_BetaSizeKB = Round($i_BetaSize / 1024)
			$i_PreBetaSizeKB = Round($i_PreBetaSize / 1024)
			If _CompareVersions($s_ReleaseVer, $s_CurrVer) Then
				GUICtrlSetData($gr_Mn_Release, '最新正式版本 *新版本*')
				GUICtrlSetColor($gr_Mn_Release, 0x0000ff)
			EndIf
			GUICtrlSetData($lb_Mn_ReleaseVer, '版本: ' & $s_ReleaseVer)
			If _CompareVersions($s_LatestBetaVer, $s_CurrBetaVer) Then
				GUICtrlSetData($gr_Mn_Beta, '最新测试版本 *新版本*')
				GUICtrlSetColor($gr_Mn_Beta, 0x0000ff)
			EndIf
			GUICtrlSetData($lb_Mn_BetaVer, '版本: ' & $s_LatestBetaVer)
			If _CompareVersions($s_PreBetaVer, $s_CurrVer) Then
				GUICtrlSetData($gr_Mn_PreBeta, '最新预测试版本 *新版本*')
				GUICtrlSetColor($gr_Mn_PreBeta, 0x0000ff)
			EndIf
			GUICtrlSetData($lb_Mn_PreBetaVer, '版本: ' & $s_PreBetaVer)
			GUICtrlSetData($lb_Mn_ReleaseDate, '日期: ' & _FriendlyDate($i_ReleaseDate))
			GUICtrlSetData($lb_Mn_BetaDate, '日期: ' & _FriendlyDate($i_BetaDate))
			GUICtrlSetData($lb_Mn_PreBetaDate, '日期: ' & _FriendlyDate($i_PreBetaDate))
			GUICtrlSetData($lb_Mn_ReleaseSize, '大小: ' & $i_ReleaseSizeKB & ' KB')
			GUICtrlSetData($lb_Mn_BetaSize, '大小: ' & $i_BetaSizeKB & ' KB')
			GUICtrlSetData($lb_Mn_PreBetaSize, '大小: ' & $i_PreBetaSizeKB & ' KB')
			GUICtrlSetTip($lb_Mn_ReleasePage, $s_ReleasePage)
			GUICtrlSetTip($lb_Mn_BetaPage, $s_BetaPage)
			GUICtrlSetTip($lb_Mn_PreBetaPage, $s_PreBetaPage)
			GUICtrlSetState($bt_Mn_ReleaseDl, $GUI_ENABLE)
			GUICtrlSetState($bt_Mn_BetaDl, $GUI_ENABLE)
			GUICtrlSetState($bt_Mn_PreBetaDl, $GUI_ENABLE)
			GUICtrlSetState($lb_Mn_ReleasePage, $GUI_ENABLE)
			GUICtrlSetState($lb_Mn_BetaPage, $GUI_ENABLE)
			GUICtrlSetState($lb_Mn_PreBetaPage, $GUI_ENABLE)
			$i_DatFileLoaded = 1
		EndIf
	EndIf
	If $i_DnInitiated Then
		If Not InetGetInfo($i_InetGetHandle, 2) Then
			$i_DnPercent = Int(InetGetInfo($i_InetGetHandle, 0) / $i_DownSize * 100)
			$s_DnBytes = Round(InetGetInfo($i_InetGetHandle, 0) / 1024) & ' KB'
			$s_DnSize = Round($i_DownSize / 1024) & ' KB'
			GUICtrlSetData($pg_Mn_Progress, $i_DnPercent)
			GUICtrlSetData($lb_Mn_Progress, '下载进度: ' & $i_DnPercent & '% (' & $s_DnBytes & ' of ' & $s_DnSize & ')')
		Else
			GUICtrlSetData($pg_Mn_Progress, 100)
			InetClose($i_InetGetHandle)
			If Not FileMove($s_DownTemp, $s_DownPath, 1) Then
				MsgBox(16 + 8192, '错误', '移动文件错误.')
				GUICtrlSetData($lb_Mn_Progress, '错误')
			Else
				If GUICtrlRead($ra_Mn_DoneRun) = $GUI_CHECKED Then
					_Start('"' & $s_DownPath & '"')
					Exit
				Else
					GUICtrlSetData($lb_Mn_Progress, '下载完成!')
					GUICtrlSetData($bt_Mn_Close, '关闭[&C]')
					GUICtrlSetState($bt_Mn_OpenFile, $GUI_ENABLE)
					GUICtrlSetState($bt_Mn_OpenFolder, $GUI_ENABLE)
					$i_Response = MsgBox(4 + 64 + 256 + 8192, $s_Title, '下载完成!' & @LF & _
							'你需要现在安装吗?')
					If $i_Response = 6 Then
						_Start('"' & $s_DownPath & '"')
						Exit
					EndIf
				EndIf
			EndIf
			$i_DnInitiated = 0
		EndIf
	EndIf
	If $a_GMsg[1] = $gui_Main Then
		Select
			; Radio buttons
			Case $a_GMsg[0] = $ra_Mn_DoneRun
				RegWrite($s_Au3UpReg, 'DoneOption', 'REG_SZ', 'Run')
			Case $a_GMsg[0] = $ra_Mn_DoneNotify
				RegWrite($s_Au3UpReg, 'DoneOption', 'REG_SZ', 'Notify')
				; Download buttons
			Case $a_GMsg[0] = $bt_Mn_ReleaseDl
				$YesNo=MsgBox(36,"注意!","官方版本和汉化版本并不兼容,可能会造成功能紊乱.是否继续下载?")
				if $YesNo=6 Then
					$tmp = StringInStr($s_ReleaseFile, '/', 0, -1)
					$s_DefFileName = StringTrimLeft($s_ReleaseFile, $tmp)
					$i_DownSize = $i_ReleaseSize
					ShellExecute("http://www.autoitscript.com/autoit3/docs/history.htm")
					_DownloadFile($s_ReleaseFile, 'autoit-v3-setup.exe')
				EndIf
			Case $a_GMsg[0] = $bt_Mn_BetaDl
				$YesNo=MsgBox(36,"注意!","官方版本和汉化版本并不兼容,可能会造成功能紊乱.是否继续下载?")
				if $YesNo=6 Then
					$tmp = StringInStr($s_BetaFile, '/', 0, -1)
					$s_DefFileName = StringTrimLeft($s_BetaFile, $tmp)
					$i_DownSize = $i_BetaSize
					_DownloadFile($s_BetaFile, 'autoit-v' & $s_LatestBetaVer & '.exe')
				EndIf
			Case $a_GMsg[0] = $bt_Mn_PreBetaDl
				$tmp = StringInStr($s_PreBetaFile, '/', 0, -1)
				$s_DefFileName = StringTrimLeft($s_PreBetaFile, $tmp)
				$i_DownSize = $i_PreBetaSize
				_DownloadFile($s_PreBetaFile, 'autoit-v' & $s_PreBetaVer & '.exe')
				; Download page "hyperlinks"
			Case $a_GMsg[0] = $lb_Mn_ReleasePage
				_Start($s_ReleasePage)
			Case $a_GMsg[0] = $lb_Mn_BetaPage
				_Start($s_BetaPage)
			Case $a_GMsg[0] = $lb_Mn_PreBetaPage
				_Start($s_PreBetaPage)
				; Open buttons
			Case $a_GMsg[0] = $bt_Mn_OpenFile
				_Start('"' & $s_DownPath & '"')
				Exit
			Case $a_GMsg[0] = $bt_Mn_OpenFolder
				_Start('"' & EnvGet('windir') & '\explorer.exe" /select,"' & $s_DownPath & '"')
				Exit
				; Menu items
			Case $a_GMsg[0] = $me_Mn_Proxy
				If BitAND(GUICtrlRead($me_Mn_Proxy), $GUI_CHECKED) = $GUI_CHECKED Then
					GUICtrlSetState($me_Mn_Proxy, $GUI_UNCHECKED)
					HttpSetProxy(0)
				Else
					GUICtrlSetState($me_Mn_Proxy, $GUI_CHECKED)
					HttpSetProxy(1)
				EndIf
			Case $a_GMsg[0] = $me_Mn_VisitSite
				_Start('http://www.autoitscript.com')
			Case $a_GMsg[0] = $snow_Mn_VisitSite
				_Start('http://www.autoit.net.cn')
			Case $a_GMsg[0] = $me_Mn_About
				GUISetState(@SW_SHOW, $gui_About)
				; Close buttons
			Case $a_GMsg[0] = $bt_Mn_Close
				_CancelDownload()
			Case $a_GMsg[0] = $GUI_EVENT_CLOSE
				_CancelDownload(1)
		EndSelect
	ElseIf $a_GMsg[1] = $gui_About Then
		Select
			Case $a_GMsg[0] = $lb_Ab_VisitSite
				_Start('http://www.autoitscript.com')
			Case $a_GMsg[0] = $lb_Ab_ContactAuthor
				_Start('http://www.autoit.net.cn')
			Case $a_GMsg[0] = $GUI_EVENT_CLOSE Or $a_GMsg[0] = $bt_Ab_Close
				GUISetState(@SW_HIDE, $gui_About)
		EndSelect
	EndIf
WEnd


; ========================================
; Function Declarations
; ========================================
; App. specific functions
Func _DownloadFile($s_DownUrl, $s_DownName)
	$s_DownTemp = @TempDir & '\' & $s_DownName

	$len = InetGetSize($s_DownUrl)
	If @error Then
		MsgBox(16 + 8192, 'Error', 'Cannot acces when trying to download.' & @CRLF & @CRLF & $s_DownUrl)
		Return
	EndIf

	$i_InetGetHandle = InetGet($s_DownUrl, $s_DownTemp, 1, 1)
	$s_DownPath = FileSaveDialog('另存为', $s_DefDownDir, '可执行文件 (*.exe)', 16, $s_DownName)
	If Not @error Then
		If Not (StringRight($s_DownPath, 4) = '.exe') Then
			$s_DownPath = $s_DownPath & '.exe'
		EndIf
		$tmp = StringInStr($s_DownPath, '\', 0, -1)
		$s_DownFolder = StringLeft($s_DownPath, $tmp)
		RegWrite($s_Au3UpReg, 'DownloadDir', 'REG_SZ', $s_DownFolder)
		GUICtrlSetData($lb_Mn_DwnToTxt, _ClipPath($s_DownPath, 55))
		GUICtrlSetData($lb_Mn_Progress, '下载进度: 计算中...')
		_GuiCtrlGroupSetState($a_DownButtons, $GUI_HIDE)
		_GuiCtrlGroupSetState($a_DownButtons, $GUI_DISABLE)
		_GuiCtrlGroupSetState($a_DownDisplay, $GUI_SHOW)
		If $s_PreBetaVer <> '' Then
			GUICtrlSetPos($bt_Mn_Close, 265 + 175, 275, 75, 25)
		Else
			GUICtrlSetPos($bt_Mn_Close, 265, 275, 75, 25)
		EndIf
		GUICtrlSetData($bt_Mn_Close, '取消')
		$i_DnInitiated = 1
	Else
		InetClose($i_InetGetHandle)
		FileDelete($s_DownTemp)
	EndIf
EndFunc   ;==>_DownloadFile


Func _CancelDownload($i_Flag = 0)
	If $i_DnInitiated Then
		$i_Response = MsgBox(4 + 64 + 256 + 8192, $s_Title, '注意:您选择了取消下载.' & @LF & _
				'您已经下载的部分会被删除.' & @LF & _
				'是否真的要取消下载?')
		If $i_Response = 6 Then
			$i_DnInitiated = 0
			InetClose($i_InetGetHandle)
			FileDelete($s_DownTemp)
			If $i_Flag = 1 Then
				Exit
			EndIf
			_GuiCtrlGroupSetState($a_DownDisplay, $GUI_HIDE)
			GUICtrlSetData($bt_Mn_Close, '关闭[&C]')
			If $s_PreBetaVer <> '' Then
				GUICtrlSetPos($bt_Mn_Close, 10, 275, 330 + 175, 25)
			Else
				GUICtrlSetPos($bt_Mn_Close, 10, 275, 330, 25)
			EndIf
			GUICtrlSetData($pg_Mn_Progress, 0)
			_GuiCtrlGroupSetState($a_DownButtons, $GUI_SHOW)
			_GuiCtrlGroupSetState($a_DownButtons, $GUI_ENABLE)
		EndIf
	Else
		Exit
	EndIf
EndFunc   ;==>_CancelDownload


Func _LoadUpdateData()
	$s_ReleaseVer = IniRead($s_DatFile_Local, 'AutoIt', 'version', '错误读取文件')
	$s_ReleaseFile = IniRead($s_DatFile_Local, 'AutoIt', 'setup', '')
	$s_ReleasePage = IniRead($s_DatFile_Local, 'AutoIt', 'index', 'http://www.autoitscript.com')
	$i_ReleaseSize = IniRead($s_DatFile_Local, 'AutoIt', 'filesize', 0)
	$i_ReleaseDate = IniRead($s_DatFile_Local, 'AutoIt', 'filetime', 0)
	$s_LatestBetaVer = IniRead($s_DatFile_Local, 'AutoItBeta', 'version', '错误读取文件')
	$s_BetaFile = IniRead($s_DatFile_Local, 'AutoItBeta', 'setup', '')
	$s_BetaPage = IniRead($s_DatFile_Local, 'AutoItBeta', 'index', 'http://www.autoitscript.com')
	$i_BetaSize = IniRead($s_DatFile_Local, 'AutoItBeta', 'filesize', 0)
	$i_BetaDate = IniRead($s_DatFile_Local, 'AutoItBeta', 'filetime', 0)
	$s_PreBetaVer = IniRead($s_DatFile_Local, 'AutoItPreBeta', 'version', '')
	$s_PreBetaFile = IniRead($s_DatFile_Local, 'AutoItPreBeta', 'setup', '')
	$s_PreBetaPage = IniRead($s_DatFile_Local, 'AutoItPreBeta', 'index', 'http://www.autoitscript.com')
	$i_PreBetaSize = IniRead($s_DatFile_Local, 'AutoItPreBeta', 'filesize', 0)
	$i_PreBetaDate = IniRead($s_DatFile_Local, 'AutoItPreBeta', 'filetime', 0)
	FileDelete($s_DatFile_Local)
EndFunc   ;==>_LoadUpdateData


; Utility functions
Func _Start($s_StartPath)
	Local $s_StartStr
	If @OSTYPE = 'WIN32_NT'  Then
		$s_StartStr = @ComSpec & ' /c start "" '
	Else
		$s_StartStr = @ComSpec & ' /c start '
	EndIf
	Run($s_StartStr & $s_StartPath, '', @SW_HIDE)
EndFunc   ;==>_Start


Func _GuiCtrlGroupSetState(ByRef $a_GroupArray, $i_State)
	For $i = 1 To $a_GroupArray[0]
		GUICtrlSetState($a_GroupArray[$i], $i_State)
	Next
EndFunc   ;==>_GuiCtrlGroupSetState


Func _ClipPath($s_Path, $i_ClipLen)
	Local $i_Half, $s_Left, $s_Right
	If StringLen($s_Path) > $i_ClipLen Then
		$i_Half = Int($i_ClipLen / 2)
		$s_Left = StringLeft($s_Path, $i_Half)
		$s_Right = StringRight($s_Path, $i_Half)
		$s_Path = $s_Left & '...' & $s_Right
	EndIf
	Return $s_Path
EndFunc   ;==>_ClipPath


Func _NumSuffix($i_Num)
	Local $s_Num
	Switch Int($i_Num)
		Case 1, 21, 31
			$s_Num = Int($i_Num) & ' 日'
		Case 2, 22
			$s_Num = Int($i_Num) & ' 日'
		Case 3, 23
			$s_Num = Int($i_Num) & ' 日'
		Case Else
			$s_Num = Int($i_Num) & ' 日'
	EndSwitch
	Return $s_Num
EndFunc   ;==>_NumSuffix


Func _FriendlyDate($s_Date)
	Local $a_Months = StringSplit('1月,2月,3月,4月,5月,6月,7月,8月,9月,10月,11月,12月', ',')
	Local $s_Year, $s_Month, $s_Day
	$s_Year = StringLeft($s_Date, 4)
	$s_Month = StringMid($s_Date, 5, 2)
	$s_Month = $a_Months[Int(StringMid($s_Date, 5, 2))]
	$s_Day = StringMid($s_Date, 7, 2)
	$s_Day = _NumSuffix(StringMid($s_Date, 7, 2))
	Return $s_Month & ' ' & $s_Day & ', ' & $s_Year
EndFunc   ;==>_FriendlyDate


Func _StringInArray($a_Array, $s_String)
	Local $i_ArrayLen = UBound($a_Array) - 1
	For $i = 0 To $i_ArrayLen
		If $a_Array[$i] = $s_String Then
			Return $i
		EndIf
	Next
	SetError(1)
	Return 0
EndFunc   ;==>_StringInArray


Func _CompareVersions($s_Vers1, $s_Vers2, $i_ReturnFlag = 0)
	Local $v_Return
	If $s_Vers1 = '' Then Return 0
	Local $i, $i_Vers1, $i_Vers2, $i_Top
	Local $a_Vers1 = StringSplit($s_Vers1, '.')
	Local $a_Vers2 = StringSplit($s_Vers2, '.')
	$i_Top = $a_Vers1[0]
	If $a_Vers1[0] < $a_Vers2[0] Then
		$i_Top = $a_Vers2[0]
	EndIf
	For $i = 1 To $i_Top
		$i_Vers1 = 0
		$i_Vers2 = 0
		If $i <= $a_Vers1[0] Then
			$i_Vers1 = Number($a_Vers1[$i])
		EndIf
		If $i <= $a_Vers2[0] Then
			$i_Vers2 = Number($a_Vers2[$i])
		EndIf
		If $i_Vers1 > $i_Vers2 Then
			$v_Return = 1
			ExitLoop
		ElseIf $i_Vers1 < $i_Vers2 Then
			$v_Return = 0
			ExitLoop
		Else
			$v_Return = -1
		EndIf
	Next
	If $i_ReturnFlag Then
		Select
			Case $v_Return = -1
				SetError(1)
				Return 0
			Case $v_Return = 1
				Return $s_Vers1
			Case $v_Return = 0
				Return $s_Vers2
		EndSelect
	ElseIf $v_Return = -1 Then
		SetError(1)
		Return 0
	Else
		Return $v_Return
	EndIf
EndFunc   ;==>_CompareVersions


Func _Status($s_MainText, $s_SubText = '', $i_BytesRead = -1, $i_DownSize = -1)
	Local $s_DownStatus
	If @OSVersion = "WIN_XP"  Or @OSVersion = "WIN_2000"  Or @OSVersion = "WIN_2003"  Then
		If $s_SubText <> '' Then
			$s_SubText = @LF & $s_SubText
		EndIf
		If $i_BytesRead = -1 Then
			TrayTip($s_Title, $s_MainText & $s_SubText, 10, 16)
		Else
			$s_DownStatus = Round($i_BytesRead / 1024) & ' of ' & Round($i_DownSize / 1024) & ' KB'
			TrayTip($s_Title, $s_MainText & $s_SubText & @LF & $s_DownStatus, 10, 16)
		EndIf
	Else
		If Not $i_ProgOn Then
			ProgressOn($s_Title, $s_MainText, $s_SubText, -1, -1, 2 + 16)
			$i_ProgOn = 1
		Else
			If $i_BytesRead = -1 Then
				ProgressSet($i_StatusPercent, $s_SubText, $s_MainText)
			Else
				$s_DownStatus = '已下载:' & Round($i_BytesRead / 1024) & ' 总:' & Round($i_DownSize / 1024) & ' KB'
				$i_StatusPercent = Round($i_BytesRead / $i_DownSize * 100)
				ProgressSet($i_StatusPercent, $s_DownStatus, $s_MainText)
			EndIf
		EndIf
	EndIf
EndFunc   ;==>_Status


Func RegRead64($sKeyname, $sValue)
		Local $res = RegRead($sKeyname, $sValue)
		If @error And @AutoItX64 Then
			$sKeyname = StringReplace($sKeyname, "HKEY_LOCAL_MACHINE", "HKLM")
			$sKeyname = StringReplace($sKeyname, "HKLM\SOFTWARE\", "HKLM\SOFTWARE\Wow6432Node\")
			$res = RegRead($sKeyname, $sValue)
			If @error Then
				SetError(1)
				Return ""
			EndIf
		EndIf

	SetError(0)
	Return $res
EndFunc
