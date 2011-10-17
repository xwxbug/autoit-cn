 #include <WinAPI.au3> 
 
 Opt ( ' MustDeclareVars ',  1 ) 
 
 Global  $Dirs [ 3 ] = [ @DesktopDir , @WindowsDir , @SystemDir ] 
 
 MsgBox ( 0 , ' _WinAPI_PathFindOnPath ', ' Searching for Notepad.exe => ' & _WinAPI_PathFindOnPath ( ' Notepad.exe ', $Dirs ) & @CRLF & _ 
 ' Searching for Web => ' & _WinAPI_PathFindOnPath ( ' Web ', $Dirs ) & @CRLF & _ 
 ' Searching for My File.txt => ' & _WinAPI_PathFindOnPath ( ' My File.txt ', $Dirs )) 
 
