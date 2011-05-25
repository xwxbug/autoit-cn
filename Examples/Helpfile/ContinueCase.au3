Local $msg = ""
Local $szName = InputBox(Default, "请输入一个单词", "", " M", Default, Default, Default, Default, 10)
Switch @error
	Case 2
		$msg = "超时"
		ContinueCase
	Case 1; 继续上一Case事件
		$msg &= "取消"
	Case 0
		Switch $szName
			Case "a", "e", "i", "o", "u"
				$msg = "这是元音字母"
			Case "QP"
				$msg = "数学"
			Case "Q" To "QZ"
				$msg = "自然科学"
			Case Else
				$msg = "其它"
		EndSwitch
	Case Else
	$msg = "出现了非常可怕的错误."
EndSwitch

MsgBox(0, Default, $msg)
