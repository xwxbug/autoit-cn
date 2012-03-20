Example()

Func Example()
	; 定义一个字符串
	Local Const $sString = "Hello - 你好"

	; 建立临时变量，以便存储转换结果.
	Local $sBinary, $sConverted
;----------------------------------------------------------------------
	; 将 UTF-8 格式的字符串转换为 ANSI 格式的二进制数据.	
	$sBinary = StringToBinary($sString)

	; 将 ANSI 格式的二进制数据转换为字符串.
	$sConverted = BinaryToString($sBinary)

	; 显示转换结果.
	DisplayResults($sString, $sBinary, $sConverted, "ANSI")
;----------------------------------------------------------------------
	; 将 UTF-8 格式的字符串转换为 UTF16-LE 格式的二进制数据.	
	$sBinary = StringToBinary($sString, 2)

	; 将 UTF16-LE 格式的二进制数据转换为字符串.
	$sConverted = BinaryToString($sBinary, 2)

	; 显示转换结果.
	DisplayResults($sString, $sBinary, $sConverted, "UTF16-LE")
;----------------------------------------------------------------------
	; 将 UTF-8 格式的字符串转换为 UTF16-BE 格式的二进制数据.	
	$sBinary = StringToBinary($sString, 3)

	; 将 UTF16-BE 格式的二进制数据转换为字符串.
	$sConverted = BinaryToString($sBinary, 3)

	; 显示转换结果.
	DisplayResults($sString, $sBinary, $sConverted, "UTF16-BE")
;----------------------------------------------------------------------
	; 将 UTF-8 格式的字符串转换为 UTF-8 格式的二进制数据.
	$sBinary = StringToBinary($sString, 4)

	; 将 UTF-8 格式的二进制数据转换为字符串.
	$sConverted = BinaryToString($sBinary, 4)

	; 显示转换结果.
	DisplayResults($sString, $sBinary, $sConverted, "UTF8")
EndFunc   ;==>Example

Func DisplayResults($sOriginal, $sBinary, $sConverted, $sConversionType)
	MsgBox(4096, "", "字符串：" & $sOriginal & @CRLF & @CRLF & "字符串转换为二进制:" & @CRLF & $sBinary & @CRLF & @CRLF & "二进制转换为" & $sConversionType & ":" & @CRLF & $sConverted)
EndFunc   ;==>DisplayResults
