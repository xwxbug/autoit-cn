#include <ACN_HASH.au3>

; Method 1
$Hash = _SHA1('The quick brown fox jumps over the lazy dog')
msgbox(0, 'Method 1 Result', $Hash)

; Method 2
$SHA1CTX = _SHA1Init()
_SHA1Input($SHA1CTX, 'The quick brown fox')
_SHA1Input($SHA1CTX, 'jumps over the lazy dog')
$Hash = _SHA1Result($SHA1CTX)
msgbox(0, 'Method 2 Result', $Hash)
