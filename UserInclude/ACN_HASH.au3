#include-once
;======================================================
;
; 函数名称:		_Base64Decode
; 详细信息:		Base64解码
; 返回值 :		
; 作者:			Ward(Taiwan)
;
;======================================================
Func _Base64Decode($Data)
	Local $Opcode = "0xC81000005356578365F800E8500000003EFFFFFF3F3435363738393A3B3C3DFFFFFF00FFFFFF000102030405060708090A0B0C0D0E0F10111213141516171819FFFFFFFFFFFF1A1B1C1D1E1F202122232425262728292A2B2C2D2E2F303132338F45F08B7D0C8B5D0831D2E9910000008365FC00837DFC047D548A034384C0750383EA033C3D75094A803B3D75014AB00084C0751A837DFC047D0D8B75FCC64435F400FF45FCEBED6A018F45F8EB1F3C2B72193C7A77150FB6F083EE2B0375F08A068B75FC884435F4FF45FCEBA68D75F4668B06C0E002C0EC0408E08807668B4601C0E004C0EC0208E08847018A4602C0E00624C00A46038847028D7F038D5203837DF8000F8465FFFFFF89D05F5E5BC9C21000"
	
	Local $CodeBuffer = DllStructCreate("byte[" & BinaryLen($Opcode) & "]")
	DllStructSetData($CodeBuffer, 1, $Opcode)

	Local $Ouput = DllStructCreate("byte[" & BinaryLen($Data) & "]")
	Local $Ret = DllCall("user32.dll", "int", "CallWindowProc", "ptr", DllStructGetPtr($CodeBuffer), _
													"str", $Data, _
													"ptr", DllStructGetPtr($Ouput), _
													"int", 0, _
													"int", 0)

	Return BinaryMid(DllStructGetData($Ouput, 1), 1, $Ret[0])
EndFunc
;======================================================
;
; 函数名称:		_Base64Encode
; 详细信息:		Base64编码
; 返回值 :		
; 作者:			Ward(Taiwan)
;
;======================================================
Func _Base64Encode($Data, $LineBreak = 76)
	Local $Opcode = "0x5589E5FF7514535657E8410000004142434445464748494A4B4C4D4E4F505152535455565758595A6162636465666768696A6B6C6D6E6F707172737475767778797A303132333435363738392B2F005A8B5D088B7D108B4D0CE98F0000000FB633C1EE0201D68A06880731C083F901760C0FB6430125F0000000C1E8040FB63383E603C1E60409C601D68A0688470183F90176210FB6430225C0000000C1E8060FB6730183E60FC1E60209C601D68A06884702EB04C647023D83F90276100FB6730283E63F01D68A06884703EB04C647033D8D5B038D7F0483E903836DFC04750C8B45148945FC66B80D0A66AB85C90F8F69FFFFFFC607005F5E5BC9C21000"

	Local $CodeBuffer = DllStructCreate("byte[" & BinaryLen($Opcode) & "]")
	DllStructSetData($CodeBuffer, 1, $Opcode)

	$Data = Binary($Data)
	Local $Input = DllStructCreate("byte[" & BinaryLen($Data) & "]")
	DllStructSetData($Input, 1, $Data)

	$LineBreak = Floor($LineBreak / 4) * 4
	Local $OputputSize = Ceiling(BinaryLen($Data) * 4 / 3) 
	$OputputSize = $OputputSize + Ceiling($OputputSize / $LineBreak) * 2 + 4

	Local $Ouput = DllStructCreate("char[" & $OputputSize & "]")
	DllCall("user32.dll", "none", "CallWindowProc", "ptr", DllStructGetPtr($CodeBuffer), _
													"ptr", DllStructGetPtr($Input), _
													"int", BinaryLen($Data), _
													"ptr", DllStructGetPtr($Ouput), _
													"uint", $LineBreak)
	Return DllStructGetData($Ouput, 1)
EndFunc
;======================================================
;
; 函数名称:		_CRC32
; 详细信息:		CRC32编码
; 返回值 :		
; 作者:			Ward(Taiwan)
;
;======================================================
Func _CRC32($Data, $CRC32 = -1)
	If @AutoItX64 Then
		Local $Opcode = '0x554889E54881EC2004000048894D10488955184489452044894D28C745F800000000EB468B45F88945ECC745FC08000000EB1E8B45EC83E00184C0740D8B45ECD1E83345288945ECEB03D16DEC836DFC01837DFC007FDC8B45F848988B55EC899485E0FBFFFF8345F801817DF8FF0000007EB1488B4510488945F0C745F800000000EB318B452089C2C1EA088B45F84898480345F00FB6000FB6C033452025FF00000089C08B8485E0FBFFFF31D08945208345F8018B45F84898483B451872C48B4520F7D0C9C3'
	Else
		Local $Opcode = '0xC8000400538B5514B9000100008D41FF516A0859D1E8730231D0E2F85989848DFCFBFFFFE2E78B5D088B4D0C8B451085DB7416E3148A1330C20FB6D2C1E80833849500FCFFFF43E2ECF7D05BC9C21000'
	EndIf
	Local $CodeBuffer = DllStructCreate("byte[" & BinaryLen($Opcode) & "]")
	DllStructSetData($CodeBuffer, 1, $Opcode)

	Local $Input = DllStructCreate("byte[" & BinaryLen($Data) & "]")
	DllStructSetData($Input, 1, $Data)

	Local $Ret = DllCall("user32.dll", "uint", "CallWindowProc", "ptr", DllStructGetPtr($CodeBuffer), _
													"ptr", DllStructGetPtr($Input), _
													"int", BinaryLen($Data), _
													"uint", $CRC32, _
													"int", 0)

	$Input = 0
	$CodeBuffer = 0

	Return $Ret[0]
EndFunc

;======================================================
;
; 函数名称:		_RC4
; 详细信息:		RC4编码
; 返回值 :		
; 作者:			Ward(Taiwan)
;
;======================================================

Func _RC4($Data, $Key)
	Local $Opcode = "0xC81001006A006A005356578B551031C989C84989D7F2AE484829C88945F085C00F84DC000000B90001000088C82C0188840DEFFEFFFFE2F38365F4008365FC00817DFC000100007D478B45FC31D2F775F0920345100FB6008B4DFC0FB68C0DF0FEFFFF01C80345F425FF0000008945F48B75FC8A8435F0FEFFFF8B7DF486843DF0FEFFFF888435F0FEFFFFFF45FCEBB08D9DF0FEFFFF31FF89FA39550C76638B85ECFEFFFF4025FF0000008985ECFEFFFF89D80385ECFEFFFF0FB6000385E8FEFFFF25FF0000008985E8FEFFFF89DE03B5ECFEFFFF8A0689DF03BDE8FEFFFF860788060FB60E0FB60701C181E1FF0000008A840DF0FEFFFF8B750801D6300642EB985F5E5BC9C21000"
	Local $CodeBuffer = DllStructCreate("byte[" & BinaryLen($Opcode) & "]")
	DllStructSetData($CodeBuffer, 1, $Opcode)
	If Not IsBinary($Data) Then $Data=StringToBinary($Data,1)
	Local $Buffer = DllStructCreate("byte[" & BinaryLen($Data) & "]")
	DllStructSetData($Buffer, 1, $Data)

	DllCall("user32.dll", "none", "CallWindowProc", "ptr", DllStructGetPtr($CodeBuffer), _
													"ptr", DllStructGetPtr($Buffer), _
													"int", BinaryLen($Data), _
													"str", $Key, _
													"int", 0)

	Local $Ret = DllStructGetData($Buffer, 1)
	$Buffer = 0
	$CodeBuffer = 0
	Return $Ret
EndFunc

;======================================================
;
; 函数名称:		_XXTEA_Encrypt
; 详细信息:		_XXTEA编码
; 返回值 :		
; 作者:			Ward(Taiwan)
;
;======================================================
Func _XXTEA_Encrypt($Data, $Key)
	$Data = Binary($Data)
	Local $DataLen = BinaryLen($Data)
	If $DataLen = 0 Then 
		Return ""
	ElseIf $DataLen < 8 Then
		$DataLen = 8
	EndIf	
	
	Local $Opcode = '0x83EC14B83400000099538B5C2420558B6C242056578B7C9DFCF7FB89C683C606C74424180000000085F68D76FF0F8EEA000000896C24288D4BFF8D549D00894C2410895424148974242081442418B979379E8B4C2418C1E90281E103000000894C241C31F6397424107E568B5424288BCF8B6CB204C1E9058D14AD0000000033CA8BD58BC7C1EA03C1E00433D003CA8B5424188BDE81E303000000335C241C8B4424308B1C9833D533DF03D333CA8B542428010CB28B0CB2463974241089CF7FAA8B5424288BCF8B2AC1E9058D14AD0000000033CA8BD58BC7C1EA03C1E00433D003CA8B5424188BDE81E303000000335C241C8B4424308B1C9833D533DF03D3FF4C242033CA8B542414014AFC8B4AFC8B54242089CF420F8F2DFFFFFF5F31C05E5D5B83C414C21000'
	Local $CodeBuffer = DllStructCreate("byte[" & BinaryLen($Opcode) & "]")
	DllStructSetData($CodeBuffer, 1, $Opcode)

	Local $V = DllStructCreate("byte[" & Ceiling($DataLen / 4) * 4 & "]")
	DllStructSetData($V, 1, $Data)

	Local $K = DllStructCreate("byte[16]")
	DllStructSetData($K, 1, $Key)

	DllCall("user32.dll", "none", "CallWindowProc", "ptr", DllStructGetPtr($CodeBuffer), _
													"ptr", DllStructGetPtr($V), _
													"int", Ceiling($DataLen / 4), _
													"ptr", DllStructGetPtr($K), _
													"int", 0)

	Local $Ret = DllStructGetData($V, 1)
	$CodeBuffer = 0
	$V = 0
	$K = 0
	Return $Ret
EndFunc
;======================================================
;
; 函数名称:		_XXTEA_Decrypt
; 详细信息:		_XXTEA解码
; 返回值 :		
; 作者:			Ward(Taiwan)
;
;======================================================
Func _XXTEA_Decrypt($Data, $Key)
	$Data = Binary($Data)
	Local $DataLen = BinaryLen($Data)
	If $DataLen = 0 Then Return ""

	Local $Opcode = '0x83EC10B83400000099538B5C241C55568B742420578B3EF7FB69D0B979379E81C256DA4CB5895424180F84DD000000897424248D4BFF8D149E894C2410895424148B4C2418C1E90281E103000000894C241C8B742410837C2410007E528B5424248B6CB2FC8BCD8BD7C1E905C1E20233CA8BD78BC5C1EA03C1E00433D003CA8B5424188BDE81E3030000008B44242C33D7335C241C8B1C9833DD03D333CA8B542424290CB28B0CB24E89CF85F67FAE8B5424148B6AFC8BCD8BD7C1E905C1E20233CA8BD78BC5C1EA03C1E00433D003CA8B5424188BDE81E3030000008B44242C33D7335C241C8B1C9833DD03D333CA8B542424290A8B0A89CF814424184786C861837C2418000F8535FFFFFF5F31C05E5D5B83C410C21000'
	Local $CodeBuffer = DllStructCreate("byte[" & BinaryLen($Opcode) & "]")
	DllStructSetData($CodeBuffer, 1, $Opcode)

	Local $V = DllStructCreate("byte[" & Ceiling($DataLen / 4) * 4 & "]")
	DllStructSetData($V, 1, $Data)

	Local $K = DllStructCreate("byte[16]")
	DllStructSetData($K, 1, $Key)

	DllCall("user32.dll", "none", "CallWindowProc", "ptr", DllStructGetPtr($CodeBuffer), _
													"ptr", DllStructGetPtr($V), _
													"int", Ceiling($DataLen / 4), _
													"ptr", DllStructGetPtr($K), _
													"int", 0)

	Local $Ret = DllStructGetData($V, 1)
	$CodeBuffer = 0
	$V = 0
	$K = 0
	Return $Ret
EndFunc
;======================================================
;
; 函数名称:		_XXTEA_Encrypt_Pad
; 详细信息:		_XXTEA编码算法
; 返回值 :		
; 作者:			Ward(Taiwan)
;
;======================================================
Func _XXTEA_Encrypt_Pad($Data, $Key)
	$Data = Binary($Data)
	Local $DataLen = BinaryLen($Data), $DataPad

	Switch(Mod($DataLen, 4))
	Case 0
		$DataPad = Binary("0x80000000")
	Case 1 
		$DataPad = Binary("0x800000")
	Case 2 
		$DataPad = Binary("0x8000")
	Case 3 
		$DataPad = Binary("0x80")
	EndSwitch
	Return _XXTEA_Encrypt($Data & $DataPad, $Key)
EndFunc
;======================================================
;
; 函数名称:		_XXTEA_Decrypt_Pad
; 详细信息:		_XXTEA解码算法
; 返回值 :		
; 作者:			Ward(Taiwan)
;
;======================================================
Func _XXTEA_Decrypt_Pad($Data, $Key)
	$Data = _XXTEA_Decrypt($Data, $Key)
	Local $DataLen = BinaryLen($Data), $i
	For $i = $DataLen To $DataLen - 8 Step -1
		If BinaryMid($Data, $i, 1) = Binary("0x80") Then
			$Data = BinaryMid($Data, 1, $i - 1)
			ExitLoop			
		EndIf		
	Next	
	Return $Data
EndFunc

