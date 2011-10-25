#Include <WinAPIEx.au3>
#Include <WindowsConstants.au3>

Opt('MustDeclareVars ', 1)

Global $Data = _WinAPI_GetPerformanceInfo()
Local $perfinfo = ' Physical Memory (MB)' & @TAB & @CRLF & _
		' --------------------' & @CRLF & _
		' Total:' & @TAB & Floor($Data[3] / 1024 / 1024) & @CRLF & _
		' Available:' & @TAB & Floor($Data[4] / 1024 / 1024) & @CRLF & _
		' Cached:' & @TAB & Floor($Data[5] / 1024 / 1024) & @CRLF & _
		' Free:' & @TAB & Floor($Data[6] / 1024 / 1024) & @CRLF & _
		@CRLF & _
		' Kernel Memory (MB)' & @CRLF & _
		' --------------------' & @CRLF & _
		' Paged:' & @TAB & Floor($Data[7] / 1024 / 1024) & @CRLF & _
		' Nonpaged:' & @TAB & Floor($Data[8] / 1024 / 1024) & @CRLF & _
		@CRLF & _
		' System' & @CRLF & _
		' --------------------' & @CRLF & _
		' Handles:' & @TAB & $Data[10] & @CRLF & _
		' Processes:' & @TAB & $Data[11] & @CRLF & _
		' Threads:' & @TAB & $Data[12]
msgbox('', 'Performance Info ', $perfinfo)

