ProgressOn("Progress Meter", "Increments every second", "0 percent")
For $i = 10 to 100 step 10
	sleep(1000)
	ProgressSet( $i, $i & " percent")
Next
ProgressSet(100 , "Done", "Complete")
sleep(500)
ProgressOff()
