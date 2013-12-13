#include <WinAPIRes.au3>
#include <APIResConstants.au3>
#include <MsgBoxConstants.au3>

Global Const $sExe = @TempDir & '\MyProg.exe'

Global Const $tagICONRESDIR = 'byte Width;byte Height;byte ColorCount;byte Reserved;ushort Planes;ushort BitCount;dword BytesInRes;ushort IconId;'
Global Const $tagNEWHEADER = 'ushort Reserved;ushort ResType;ushort ResCount;' ; & $tagICONRESDIR[ResCount]

; Select icon to update resource
Local $sIcon = FileOpenDialog('Select File', @ScriptDir & '\Extras', 'Icon Files (*.ico)', 1 + 2, 'Script.ico')
If Not $sIcon Then
	Exit
EndIf

; Create simple executable file (MyProg.exe) in which will be added icon
If Not FileCopy(@ScriptDir & '\Extras\MyProg.exe', $sExe) Then
	If MsgBox(BitOR($MB_OKCANCEL, $MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Unable to copy MyProg.exe or file already exist in the current directory.') <> 1 Then
		Exit
	EndIf
	FileCopy(@ScriptDir & '\Extras\MyProg.exe', $sExe, 1)
EndIf

Global $Error = 1
Do
	; Begin update resources
	Local $hUpdate = _WinAPI_BeginUpdateResource($sExe)
	If @error Then
		ExitLoop
	EndIf
	; Read .ico file as raw binary data into the structure
	Local $tIcon = DllStructCreate('ushort Reserved;ushort Type;ushort Count;byte[' & (FileGetSize($sIcon) - 6) & ']')
	Local $pIcon = DllStructGetPtr($tIcon)
	Local $hFile = _WinAPI_CreateFile($sIcon, 2, 2)
	If Not $hFile Then
		ExitLoop
	EndIf
	Local $Bytes = 0
	_WinAPI_ReadFile($hFile, $pIcon, DllStructGetSize($tIcon), $Bytes)
	_WinAPI_CloseHandle($hFile)
	If Not $Bytes Then
		ExitLoop
	EndIf
	; Add all icons from .ico file into the RT_ICON resources identified as 400, 401, etc., and fill group icons structure
	Local $Count = DllStructGetData($tIcon, 'Count')
	Local $tDir = DllStructCreate($tagNEWHEADER & 'byte[' & (14 * $Count) & ']')
	Local $pDir = DllStructGetPtr($tDir)
	DllStructSetData($tDir, 'Reserved', 0)
	DllStructSetData($tDir, 'ResType', 1)
	DllStructSetData($tDir, 'ResCount', $Count)
	Local $tInfo, $iSize, $tData, $ID = 400
	For $i = 1 To $Count
		$tInfo = DllStructCreate('byte Width;byte Heigth;byte Colors;byte Reserved;ushort Planes;ushort BPP;dword Size;dword Offset', $pIcon + 6 + 16 * ($i - 1))
		$iSize = DllStructGetData($tInfo, 'Size')
		If Not _WinAPI_UpdateResource($hUpdate, $RT_ICON, $ID, 0, $pIcon + DllStructGetData($tInfo, 'Offset'), $iSize) Then
			ExitLoop 2
		EndIf
		$tData = DllStructCreate($tagICONRESDIR, $pDir + 6 + 14 * ($i - 1))
		DllStructSetData($tData, 'Width', DllStructGetData($tInfo, 'Width'))
		DllStructSetData($tData, 'Height', DllStructGetData($tInfo, 'Heigth'))
		DllStructSetData($tData, 'ColorCount', DllStructGetData($tInfo, 'Colors'))
		DllStructSetData($tData, 'Reserved', 0)
		DllStructSetData($tData, 'Planes', DllStructGetData($tInfo, 'Planes'))
		DllStructSetData($tData, 'BitCount', DllStructGetData($tInfo, 'BPP'))
		DllStructSetData($tData, 'BytesInRes', $iSize)
		DllStructSetData($tData, 'IconId', $ID)
		$ID += 1
	Next
	; Add new RT_GROUP_ICON resource named as "MAINICON"
	If Not _WinAPI_UpdateResource($hUpdate, $RT_GROUP_ICON, 'MAINICON', 0, $pDir, DllStructGetSize($tDir)) Then
		ExitLoop
	EndIf
	$Error = 0
Until 1

; Save or discard changes of the resources within an executable file
If Not _WinAPI_EndUpdateResource($hUpdate, $Error) Then
	$Error = 1
EndIf

; Show message if an error occurred
If $Error Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Unable to change resources.')
EndIf
