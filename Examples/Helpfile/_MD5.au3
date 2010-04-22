#include <ACN_HASH.au3>

; Method 1
$Hash = _MD5('The quick brown fox jumps over the lazy dog')
MsgBox(0, 'Method 1 Result', $Hash)

; Method 2
$MD5CTX = _MD5Init()
_MD5Input($MD5CTX, 'The quick brown fox ')
_MD5Input($MD5CTX, 'jumps over the lazy dog')
$Hash = _MD5Result($MD5CTX)
MsgBox(0, 'Method 2 Result', $Hash)
