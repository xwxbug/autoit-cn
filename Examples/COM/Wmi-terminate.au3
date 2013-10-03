; WMI Example
;
; Kill a process
;
; Derived from a KiXtart script ENDPROC by Conrad Wheeler
; See also: http://www.kixtart.org/ubbthreads/showflat.php?Cat=&Number=82164

Func EndProc($proc, $strComputer = ".")
	Local $oWMI = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\" & $strComputer & "\root\cimv2")
	Local $oProcessColl = $oWMI.ExecQuery("Select * from Win32_Process where Name= " & '"' & $proc & '"')

	For $Process In $oProcessColl
		$Process = $Process.Terminate
	Next
EndFunc   ;==>EndProc

; Example usage

EndProc("iexplore.exe") ; Kills all instances of the Internet Explorer :-)
