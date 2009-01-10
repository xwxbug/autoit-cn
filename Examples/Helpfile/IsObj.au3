$oShell = ObjCreate("shell.application")
if not IsObj($oShell) then
	Msgbox(0,"Error","$oShell is not an Object.")
else
	Msgbox(0,"Error","Successfully created Object $oShell.")
endif
