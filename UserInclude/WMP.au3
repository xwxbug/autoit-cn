#cs
	_wmpcreate($show, $left, $top, $width = 100, $height = 100)
	$show:     1 = shows controls
	2 = hides controls
	
	Return: The object for the control
#ce

Func _wmpcreate($show, $left, $top, $width = 100, $height = 100)
	Local $oWMP = ObjCreate("WMPlayer.OCX")
	If $oWMP = 0 Then Return 0
	$oWMP.settings.autoStart = "False"
	If $show = 1 Then
		GUICtrlCreateObj($oWMP, $left, $top, $width, $height)
	EndIf
	Return $oWMP
EndFunc   ;==>_wmpcreate
#cs
	_wmploadmedia( $object, $URL, $autostart = 1 )
	$object:    Object returned from the _wmpcreate()
	$URL:        Path or URL of the media
	$autostart:    1 = yes
	0 = no
	
	Return: None
#ce
Func _wmploadmedia($object, $URL, $autostart = 1)
	$object.URL = $URL
	If $autostart = 1 And $object.controls.isAvailable("play") Then $object.controls.play()
EndFunc   ;==>_wmploadmedia
#cs
	_wmpsetvalue( $object, $setting, $para=1 )
	$object:    Object returned from the _wmpcreate()
	$setting:    "play"
	"stop"
	"pause"
	"invisible" (Hides all)
	"control"    (Shows controls)
	"nocontrol"    (Hides controls)
	"fullscreen"
	"step"        (frames to step before freezing)
	"fastforward"
	"fastreverse"
	"volume"    (0 To 100)
	"rate"        (-10 To 10)
	"playcount"
	
	Return: None
#ce
Func _wmpsetvalue($object, $setting, $para = 1)
	Select
		Case $setting = "play"
			If $object.controls.isAvailable("play") Then $object.controls.play()
		Case $setting = "stop"
			If $object.controls.isAvailable("stop") Then $object.controls.stop()
		Case $setting = "pause"
			If $object.controls.isAvailable("pause") Then $object.controls.pause()
		Case $setting = "invisible"
			$object.uiMode = "invisible"
		Case $setting = "controls"
			$object.uiMode = "mini"
		Case $setting = "nocontrols"
			$object.uiMode = "none"
		Case $setting = "fullscreen"
			$object.fullscreen = "true"
		Case $setting = "step"
			If $object.controls.isAvailable("step") Then $object.controls.step($para)
		Case $setting = "fastForward"
			If $object.controls.isAvailable("fastForward") Then $object.controls.fastForward()
		Case $setting = "fastReverse"
			If $object.controls.isAvailable("fastReverse") Then $object.controls.fastReverse()
		Case $setting = "volume"
			$object.settings.volume = $para
		Case $setting = "rate"
			$object.settings.rate = $para
		Case $setting = "playcount"
			$object.settings.playCount = $para
	EndSelect
EndFunc   ;==>_wmpsetvalue