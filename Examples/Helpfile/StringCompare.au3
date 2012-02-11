Local $result = StringCompare("MELÓN", "melón")
MsgBox(4096, "StringCompare Result (mode 0):", $result)

$result = StringCompare("MELÓN", "melón", 1)
MsgBox(4096, "StringCompare Result (mode 1):", $result)

$result = StringCompare("MELÓN", "melón", 2)
MsgBox(4096, "StringCompare Result (mode 2):", $result)
