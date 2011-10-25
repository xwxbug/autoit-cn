#Include <Services.au3>
$Service = "ALG"
$ResetPeriod = 1
$RebootMsg = "System is going to reboot now."
$Command = @SystemDir & "\alg.exe /?"
Dim $aiActions[3][2] = [[$SC_ACTION_RUN_COMMAND, 1],[$SC_ACTION_RESTART, 1],[$SC_ACTION_REBOOT, 1]]
$iResult = _Service_SetFailureActions($Service, $ResetPeriod, $RebootMsg, $Command, $aiActions)
msgbox(0, "", $iResult & @CRLF & @error)

