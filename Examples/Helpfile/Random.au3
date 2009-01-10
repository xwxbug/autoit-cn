;Flip of coin
If Random() < 0.5 Then  ; Returns a value between 0 and 1.
	$msg = "Heads. 50% Win"
Else
	$msg = "Tails. 50% Loss"
Endif
MsgBox(0,"Coin toss", $msg )


;Roll of a die
msgBox(0, "Roll of die", "You rolled a " & Random(1, 6, 1) )

$StockPrice = 98
;In the middle of a stock market simulation game
$StockPriceChange = Random(-10, 10, 1)  ; generate an integer between -10 and 10
$StockPrice = $StockPrice + $StockPriceChange
If $StockPriceChange < 0 Then
	MsgBox(4096, "Stock Change", "Your stock dropped to $" & $StockPrice)
ElseIf $StockPriceChange > 0 Then
	MsgBox(4096, "Stock Change", "Your stock rose to $" & $StockPrice)
Else
	MsgBox(4096, "Stock Change", "Your stock stayed at $" & $StockPrice)
Endif


;Random letter
If Random() < 0.5 Then
	;Capitals
	$Letter = Chr(Random(Asc("A"), Asc("Z"), 1))
Else
	;Lower case
	$Letter = Chr(Random(Asc("a"), Asc("z"), 1))
Endif
