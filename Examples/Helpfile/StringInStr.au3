Local $result = StringInStr("I am a String", "RING")
MsgBox(0, "搜索结果:", $result)

Local $location = StringInStr("How much wood could a woodchuck chuck is a woodchuck could chuck wood?", "wood", 0, 3) ; 搜索第三个匹配的子串
MsgBox(0, "搜索结果:", $location)