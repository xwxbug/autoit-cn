ProgressOn("进度条", "Increments every second", "0 %")
For $i = 10 to 100 step 10
	sleep(1000)
	ProgressSet( $i, $i & " %")
Next
ProgressSet(100 , "完成", "Complete")
sleep(500)
ProgressOff()
