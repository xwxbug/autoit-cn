#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#Include <WinINet.au3>

Global $iMemo

_Main()

Func _Main()
	Local $hGUI

	; 创建界面
	$hGUI = GUICreate(" _WinINet_FtpFindFile ", 600, 400)

	; 创建memo控件
	$iMemo = GUICtrlCreateEdit("", 2, 2, 596, 396, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New ")
	GUISetState()

	; 初始化WinINet
	_WinINet_Startup()

	; 设置变量
	Global $sServerName = ""
	Global $iServerPort = 21
	Global $sUsername = Default
	Global $sPassword = Default

	Global $sDirectory = " / "
	Global $sFilenameFilter = " * "

	; 创建句柄
	Global $hInternetOpen = _WinINet_InternetOpen(" AutoIt/" & @AutoItVersion)
	Global $hInternetConnect = _WinINet_InternetConnect($hInternetOpen, $INTERNET_SERVICE_FTP, $sServerName, $iServerPort, 0, $sUsername, $sPassword)

	; 枚举目录文件
	If _WinINet_FtpSetCurrentDirectory($hInternetConnect, $sDirectory) Then
		Global $avFtpFile = _WinINet_FtpFindFirstFile($hInternetConnect, $sFilenameFilter)
		While Not @error
			MemoWrite( DllStructGetData($avFtpFile[1], "FileName "))
			_WinINet_InternetFindNextFile($avFtpFile[0], DllStructGetPtr($avFtpFile[1]))
		WEnd
	EndIf

	; 清空
	_WinINet_InternetCloseHandle($hInternetConnect)
	_WinINet_InternetCloseHandle($hInternetOpen)
	_WinINet_Shutdown()

	; 循环至用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
endfunc   ;==>_Main

; 向memo控件写入信息
Func MemoWrite($sMessage = "")
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
endfunc   ;==>MemoWrite

