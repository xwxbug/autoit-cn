Func _UpdateProgress($Percentage)
	ProgressSet($percent, $percent & "%")
	If _IsPressed("77") Then Return 0 ; F8退出
	Return 1 ; 从1开始
endfunc   ;==>_UpdateProgress

Func _UpdateProgress($Percentage)
	GUICtrlSetData($ProgressBarCtrl, $percent)
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Return -1 ; _FTP_DownloadProgress以-1退出, 所以稍后可退出应用
		Case $Btn_Cancel
			Return 0 ;仅取消, 无指定返回值
	EndSwitch
	Return 1 ; 否则继续下载
endfunc   ;==>_UpdateProgress



