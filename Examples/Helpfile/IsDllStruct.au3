Local $struct = DllStructCreate("char[256]")
Local $x = IsDllStruct($struct)
if $x then msgbox(32,"",'$struct' & ' 是一个自定义数据结构')