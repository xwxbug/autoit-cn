ProgressOn("进度条", "每秒递增", "0 %")
For $i = 10 To 100 Step 10
	Sleep(1000)
	ProgressSet( $i, $i & " %")
Next
ProgressSet(100 , "完成", "全部完成")
Sleep(500)
ProgressOff()
