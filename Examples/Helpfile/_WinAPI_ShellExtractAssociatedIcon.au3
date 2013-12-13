#include <WinAPIShellEx.au3>
#include <WindowsConstants.au3>
#include <GUIListView.au3>
#include <GUIImageList.au3>
#include <GUIConstantsEx.au3>

Local $hIcon, $Key, $Count = 1, $First = False
Local $tSHFILEINFO = DllStructCreate($tagSHFILEINFO)
Local $Ext[101] = [0]

RegRead('HKCR\.x', '')

While 1
	$Key = RegEnumKey('HKCR', $Count)
	If @error Then
		ExitLoop
	EndIf
	If StringLeft($Key, 1) = '.' Then
		RegRead('HKCR\' & $Key, '')
		If Abs(@error) <> 1 Then
			$Ext[0] += 1
			If $Ext[0] > UBound($Ext) - 1 Then
				ReDim $Ext[UBound($Ext) + 100]
			EndIf
			$Ext[$Ext[0]] = $Key
		EndIf
		$First = 1
	Else
		If $First Then
			ExitLoop
		EndIf
	EndIf
	$Count += 1
WEnd

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 280, 391)

Local $ListView = GUICtrlCreateListView('', 10, 10, 260, 344, BitOR($LVS_DEFAULT, $LVS_NOCOLUMNHEADER), $WS_EX_CLIENTEDGE)
_GUICtrlListView_SetExtendedListViewStyle($ListView, BitOR($LVS_EX_DOUBLEBUFFER, $LVS_EX_INFOTIP))
_GUICtrlListView_InsertColumn($ListView, 0, '', 238)
Local $hImageList = _GUIImageList_Create(16, 16, 5, 1)
_GUICtrlListView_SetImageList($ListView, $hImageList, 1)
Local $Button = GUICtrlCreateButton('OK', 105, 361, 70, 23)

For $i = 1 To $Ext[0]
	$hIcon = _WinAPI_ShellExtractAssociatedIcon($Ext[$i], 1)
	_GUIImageList_ReplaceIcon($hImageList, -1, $hIcon)
	_GUICtrlListView_AddItem($ListView, $Ext[$i], $i - 1)
	_WinAPI_DestroyIcon($hIcon)
Next

GUISetState()

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE, $Button
			ExitLoop
	EndSwitch
WEnd
