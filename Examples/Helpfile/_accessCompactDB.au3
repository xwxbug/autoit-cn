;===============================================================================
; 例子:        示例 1
; 函数名称:   _accessCompactDB()
; 描述:       压缩数据库文件(*. mdb)
; 语法:       _accessCompactDB($adSource)
; 参数:       $adSource - 打开数据库文件的完整路径
;===============================================================================
#AutoIt3Wrapper_UseX64 = n
#include <Access.au3>

$adSource = @ScriptDir & "\DB1.mdb"
_accessCompactDB($adSource)
;===============================================================================
; 例子:        示例 2
; 函数名称:   _accessCompactDB()
; 描述:       压缩数据库文件(*. mdb)
; 语法:       _accessCompactDB($adSource)
; 参数:       $adSource - 打开数据库文件的完整路径
;===============================================================================
#AutoIt3Wrapper_UseX64 = n
$adSource = @ScriptDir & "\DB1.mdb"
_accessCompactDB($adSource)

Func _accessCompactDB($adSource)
   If FileExists($adSource) Then
      $adDest = @TempDir & "\Temp.mdb"
      $obj = "JRO.JetEngine"
      If FileExists($adDest) Then FileDelete($adDest)
      If NOT IsObj($obj) Then
         $oMDB = ObjCreate($obj)
      Else
         $oMDB = ObjGet($obj)
      EndIf
      If IsObj($oMDB) Then
         $oMDB.CompactDatabase("Provider = " & _adoProvider() & "Data Source = " & $adSource, _
               "Provider = " & _adoProvider() & "Data Source = " & $adDest)
         SetError(0)
      Else
         Return SetError(1)
      EndIf
      FileMove($adDest, $adSource, 1)
   EndIf
EndFunc   ;<===>_accessCompactDB()

Func _adoProvider()
   Local $oProvider = "Microsoft.Jet.OLEDB.4.0; "
   Local $objCheck = ObjCreate("Access.application")
   If IsObj($objCheck) Then
      Local $oVersion = $objCheck.Version
      If StringLeft($oVersion, 2) == "12" Then $oProvider="Microsoft.ACE.OLEDB.12.0; "
   EndIf
   Return $oProvider
EndFunc
