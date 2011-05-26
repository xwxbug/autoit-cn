; 二进制(Binary) ANSI 到 字符串(String) 
$buffer = StringToBinary("Hello - 你好")
MsgBox(4096, "String() 描述" , $buffer)
$buffer = BinaryToString($buffer)
MsgBox(4096, "BinaryToString() ANSI 描述" , $buffer)

; 二进制 UTF16-LE 转换 字符串.注:LE代表Little Encode(小编码) 
$buffer = StringToBinary("Hello - 你好", 2)
MsgBox(4096, "String() 描述" , $buffer)
$buffer = BinaryToString($buffer, 2)
MsgBox(4096, "BinaryToString() UTF16-LE 描述" , $buffer)

; 二进制 UTF16-BE 转换 字符串.注:BE代表Big Encode(大编码) 
$buffer = StringToBinary("Hello - 你好", 3)
MsgBox(4096, "String() 描述" , $buffer)
$buffer = BinaryToString($buffer, 3)
MsgBox(4096, "BinaryToString() UTF16-BE 描述" , $buffer)

; 二进制 UTF8 转换 字符串 
$buffer = StringToBinary("Hello - 你好", 4)
MsgBox(4096, "String() 描述" , $buffer)
$buffer = BinaryToString($buffer, 4)
MsgBox(4096, "BinaryToString() UTF8 描述" , $buffer)
