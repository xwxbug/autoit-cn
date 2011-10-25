#include <GuiConstantsEx.au3>
#include <String.au3>

Opt(" MustDeclareVars ", 1)

_Main()

Func _Main()
	Local $WinMain, $EditText, $InputPass, $InputLevel, $UpDownLevel, $EncryptButton, $DecryptButton, $string
	; 界面和字符串
	$WinMain = GUICreate('Encryption tool ', 400, 400)
	; 创建窗体
	$EditText = GUICtrlCreateEdit('', 5, 5, 380, 350)
	; 创建主编辑控件
	$InputPass = GUICtrlCreateInput('', 5, 360, 100, 20, 0x21)
	; 使用模糊/居中的编辑框创建密码箱
	$InputLevel = GUICtrlCreateInput(1, 110, 360, 50, 20, 0x2001)
	$UpDownLevel = GUICtrlSetLimit( GUICtrlCreateUpdown($InputLevel), 10, 1)
	; 这两项通过使用上下确定加密等级
	$EncryptButton = GUICtrlCreateButton('Encrypt ', 170, 360, 105, 35)
	; 加密按钮
	$DecryptButton = GUICtrlCreateButton('Decrypt ', 285, 360, 105, 35)
	; 解密按钮
	GUICtrlCreateLabel('Password ', 5, 385)
	GUICtrlCreateLabel('Level ', 110, 385)
	; 简单文本标签以便明确
	GUISetState()
	; 显示窗体

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $EncryptButton
				GUISetState(@SW_DISABLE, $WinMain) ; 停止所有改变
				$string = GUICtrlRead($EditText) ; 稍后保存编辑框
				GUICtrlSetData($EditText, 'Please wait while the text is Encrypted/Decrypted.') ; 友好信息
				GUICtrlSetData($EditText, _StringEncrypt(1, $string, GUICtrlRead($InputPass), GUICtrlRead($InputLevel)))
				; 调用加密. 以加密的字符串设置编辑框的数据
				; 加密以1/0开始用来告知加密/解密
				; 由稍后保存在编辑框的字符串加密
				; 然后读取密码框和等级框
				GUISetState(@SW_ENABLE, $WinMain) ; 使窗体返回
			Case $DecryptButton
				GUISetState(@SW_DISABLE, $WinMain) ; 停止所有改变
				$string = GUICtrlRead($EditText) ; 稍后保存编辑框
				GUICtrlSetData($EditText, 'Please wait while the text is Encrypted/Decrypted.') ; 友好信息
				GUICtrlSetData($EditText, _StringEncrypt(0, $string, GUICtrlRead($InputPass), GUICtrlRead($InputLevel)))
				; 调用加密. 以加密的字符串设置编辑框的数据
				; 加密以1/0开始用来告知加密/解密
				; 由稍后保存在编辑框的字符串加密
				; 然后读取密码框和等级框
				GUISetState(@SW_ENABLE, $WinMain) ; 使窗体返回
		EndSwitch
	WEnd ; 继续循环直到窗口关闭
	Exit
endfunc   ;==>_Main

