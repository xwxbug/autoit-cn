$var = WinList()

For $i = 1 to $var[0][0]
  ; Only display visble windows that have a title
  If $var[$i][0] <> "" AND IsVisible($var[$i][1]) Then
    MsgBox(0, "详细信息", "标题=" & $var[$i][0] & @LF & "句柄=" & $var[$i][1])
  EndIf
Next

Func IsVisible($handle)
  If BitAnd( WinGetState($handle), 2 ) Then 
    Return 1
  Else
    Return 0
  EndIf

EndFunc
