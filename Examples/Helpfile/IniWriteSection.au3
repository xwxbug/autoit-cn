; INI文件写入演示，文件将会在桌面创建.
$sIni = @DesktopDir & "\AutoIt-Test.ini"

; 将数据写入到标准INI文件的一个字段.
$sData = "Key1=Value1" & @LF & "Key2=Value2" & @LF & "Key3=Value3"
IniWriteSection($sIni, "Section1", $sData)

;创建一个新的字段，并将数组数据写入.
$aData1 = IniReadSection($sIni, "Section1")	; 读取刚刚写入的内容.
For $i = 1 To UBound($aData1) - 1
	$aData1[$i][1] &= "-" & $i	; 更改某些数据
Next
IniWriteSection($sIni, "Section2", $aData1)	; 写入新的数据

; 创建一个自定义的二维数组，并将数组数据写入.
Dim $aData2[3][2] = [ [ "FirstKey", "FirstValue" ], [ "SecondKey", "SecondValue" ], [ "ThirdKey", "ThirdValue" ] ]
;定义数组元素索引，由索引0开始写入.
IniWriteSection($sIni, "Section3", $aData2, 0)
