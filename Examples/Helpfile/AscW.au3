$code = AscW("A")
MsgBox(0, "大写字母A的UNICODE代码为:", $code)
MsgBox(32,"注意","其实这个函数还是有缺陷,UNICODE是两个字节来表示一个字符的,但是西欧字符在AUTOIT中还是使用一个字节.")
