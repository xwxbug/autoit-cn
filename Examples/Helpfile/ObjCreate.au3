; Example 1
;
; Counting the number of open shell windows

$oShell = ObjCreate("shell.application")	; Get the Windows Shell Object
$oShellWindows=$oShell.windows			; Get the collection of open shell Windows

if Isobj($oShellWindows) then

  $string=""					; String for displaying purposes

  for $Window in $oShellWindows  		; Count all existing shell windows
	$String = $String & $Window.LocationName & @CRLF
  next

  Msgbox(0,"Shell Windows","You have the following shell windows:" & @CRLF & @CRLF & $String);

endif
exit


; Example 2
;
; Open the MediaPlayer on a REMOTE computer
$oRemoteMedia = ObjCreate("MediaPlayer.MediaPlayer.1","name-of-remote-computer")

If not @error then
	Msgbox(0,"Remote ObjCreate Test","ObjCreate() of a remote Mediaplayer Object successful !")
	$oRemoteMedia.Open( @WindowsDir & "\media\Windows XP Startup.wav")		; Play sound if file is present
Else
	Msgbox(0,"Remote ObjCreate Test","Failed to open remote Object. Error code: " & hex(@error,8))
Endif


