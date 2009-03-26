$result = StringCompare("MEL", "mel")
MsgBox(0, "StringCompare Result (mode 0):", $result)

$result = StringCompare("MEL", "mel", 1)
MsgBox(0, "StringCompare Result (mode 1):", $result)

$result = StringCompare("MEL", "mel", 2)
MsgBox(0, "StringCompare Result (mode 2):", $result)
