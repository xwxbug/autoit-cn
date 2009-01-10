#include <NamedPipes.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>
#include <GuiConstantsEx.au3>

Opt("MustDeclareVars", 1)

; ===============================================================================================================================
; Description ...: This is the server side of the pipe demo
; Author ........: Paul Campbell (PaulIA)
; Notes .........:
; ===============================================================================================================================

; ===============================================================================================================================
; Global constants
; ===============================================================================================================================

Global Const $DEBUGGING = False
Global Const $BUFSIZE   = 4096
Global Const $PIPE_NAME = "\\.\\pipe\\AutoIt3"
Global Const $TIMEOUT   = 5000
Global Const $WAIT_TIMEOUT = 258
Global Const $ERROR_IO_PENDING = 997
Global Const $ERROR_PIPE_CONNECTED = 535

; ===============================================================================================================================
; Global variables
; ===============================================================================================================================

Global $hEvent, $iMemo, $pOverlap, $tOverlap, $hPipe, $hReadPipe, $iState, $iToWrite

; ===============================================================================================================================
; Main
; ===============================================================================================================================

CreateGUI()
InitPipe()
MsgLoop()

; ===============================================================================================================================
; Creates a GUI for the server
; ===============================================================================================================================
Func CreateGUI()
  Local $hGUI

  $hGUI  = GUICreate("Pipe Server", 500, 400, -1, -1, $WS_SIZEBOX)
  $iMemo = GUICtrlCreateEdit("", 0, 0, _WinAPI_GetClientWidth($hGUI), _WinAPI_GetClientHeight($hGUI))
  GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
  GUISetState()
EndFunc

; ===============================================================================================================================
; This function creates an instance of a named pipe
; ===============================================================================================================================
Func InitPipe()
  ; Create an event object for the instance
  $tOverlap = DllStructCreate($tagOVERLAPPED)
  $pOverlap = DllStructGetPtr($tOverlap)
  $hEvent   = _WinAPI_CreateEvent()
  if $hEvent = 0 then
    LogError("InitPipe ..........: API_CreateEvent failed")
    Return
  endif
  DllStructSetData($tOverlap, "hEvent", $hEvent)

  ; Create a named pipe
  $hPipe = _NamedPipes_CreateNamedPipe($PIPE_NAME,  _ ; Pipe name
                                 2         ,  _ ; The pipe is bi-directional
                                 2         ,  _ ; Overlapped mode is enabled
                                 0         ,  _ ; No security ACL flags
                                 1         ,  _ ; Data is written to the pipe as a stream of messages
                                 1         ,  _ ; Data is read from the pipe as a stream of messages
                                 0         ,  _ ; Blocking mode is enabled
                                 1         ,  _ ; Maximum number of instances
                                 $BUFSIZE  ,  _ ; Output buffer size
                                 $BUFSIZE  ,  _ ; Input buffer size
                                 $TIMEOUT  ,  _ ; Client time out
                                 0         )    ; Default security attributes
  if $hPipe = -1 then
    LogError("InitPipe ..........: _NamedPipes_CreateNamedPipe failed")
  else
    ; Connect pipe instance to client
    ConnectClient()
  endif
EndFunc

; ===============================================================================================================================
; This function loops waiting for a connection event or the GUI to close
; ===============================================================================================================================
Func MsgLoop()
  Local $iEvent

  do
    $iEvent = _WinAPI_WaitForSingleObject($hEvent, 0)
    if $iEvent < 0 then
      LogError("MsgLoop ...........: _WinAPI_WaitForSingleObject failed")
      Exit
    endif
    if $iEvent = $WAIT_TIMEOUT then ContinueLoop
    Debug("MsgLoop ...........: Instance signaled")

    Switch $iState
      case 0
        CheckConnect()
      case 1
        ReadRequest()
      case 2
        CheckPending()
      case 3
        RelayOutput()
    EndSwitch
  until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc

; ===============================================================================================================================
; Checks to see if the pending client connection has finished
; ===============================================================================================================================
Func CheckConnect()
  Local $iBytes

  ; Was the operation successful?
  if not _WinAPI_GetOverlappedResult($hPipe, $pOverlap, $iBytes, False) then
    LogError("CheckConnect ......: Connection failed")
    ReconnectClient()
  else
    LogMsg("CheckConnect ......: Connected")
    $iState = 1
  endif
EndFunc

; ===============================================================================================================================
; This function reads a request message from the client
; ===============================================================================================================================
Func ReadRequest()
  Local $pBuffer, $tBuffer, $iRead, $bSuccess, $iToWrite

  $tBuffer = DllStructCreate("char Text[" & $BUFSIZE & "]")
  $pBuffer = DllStructGetPtr($tBuffer)
  $bSuccess = _WinAPI_ReadFile($hPipe, $pBuffer, $BUFSIZE, $iRead, $pOverlap)

  if $bSuccess and ($iRead <> 0) then
    ; The read operation completed successfully
    Debug("ReadRequest .......: Read success")
  else
    ; Wait for read Buffer to complete
    if not _WinAPI_GetOverlappedResult($hPipe, $pOverlap, $iRead, True) then
      LogError("ReadRequest .......: _WinAPI_GetOverlappedResult failed")
      ReconnectClient()
      Return
    else
      ; Read the command from the pipe
      $bSuccess = _WinAPI_ReadFile($hPipe, $pBuffer, $BUFSIZE, $iRead, $pOverlap)
      if not $bSuccess or ($iRead = 0) then
        LogError("ReadRequest .......: _WinAPI_ReadFile failed")
        ReconnectClient()
        Return
      endif
    endif
  endif

  ; Execute the console command
  if not ExecuteCmd(DllStructGetData($tBuffer, "Text")) then
    ReconnectClient()
    Return
  endif

  ; Relay console output back to the client
  $iState = 3
EndFunc

; ===============================================================================================================================
; This function relays the console output back to the client
; ===============================================================================================================================
Func CheckPending()
  Local $bSuccess, $iWritten

  $bSuccess = _WinAPI_GetOverlappedResult($hPipe, $pOverlap, $iWritten, False)
  if not $bSuccess or ($iWritten <> $iToWrite) then
    Debug("CheckPending ......: Write reconnecting")
    ReconnectClient()
  else
    Debug("CheckPending ......: Write complete")
    $iState = 3
  endif
EndFunc

; ===============================================================================================================================
; This function relays the console output back to the client
; ===============================================================================================================================
Func RelayOutput()
  Local $pBuffer, $tBuffer, $sLine, $iRead, $bSuccess, $iWritten

  $tBuffer = DllStructCreate("char Text[" & $BUFSIZE & "]")
  $pBuffer = DllStructGetPtr($tBuffer)
  ; Read data from console pipe
  _WinAPI_ReadFile($hReadPipe, $pBuffer, $BUFSIZE, $iRead)
  if $iRead = 0 then
    LogMsg("RelayOutput .......: Write done")
    _WinAPI_CloseHandle($hReadPipe)
    _WinAPI_FlushFileBuffers($hPipe)
    ReconnectClient()
    Return
  endif

  ; Get the data and strip out the extra carriage returns
  $sLine    = StringLeft(DllStructGetData($tBuffer, "Text"), $iRead)
  $sLine    = StringReplace($sLine, @CR & @CR, @CR)
  $iToWrite = StringLen($sLine)
  DllStructSetData($tBuffer, "Text", $sLine)
  ; Relay the data back to the client
  $bSuccess = _WinAPI_WriteFile($hPipe, $pBuffer, $iToWrite, $iWritten, $pOverlap)
  if $bSuccess and ($iWritten = $iToWrite) then
    Debug("RelayOutput .......: Write success")
  else
    if not $bSuccess and (@Error = $ERROR_IO_PENDING) then
      Debug("RelayOutput .......: Write pending")
      $iState = 2
    else
      ; An error occurred, disconnect from the client
      LogError("RelayOutput .......: Write failed")
      ReconnectClient()
    endif
  endif
EndFunc

; ===============================================================================================================================
; This function is called to start an overlapped connection operation
; ===============================================================================================================================
Func ConnectClient()
  $iState = 0
  ; Start an overlapped connection
  if _NamedPipes_ConnectNamedPipe($hPipe, $pOverlap) then
    LogError("ConnectClient .....: ConnectNamedPipe 1 failed")
  else
    Switch @Error
      ; The overlapped connection is in progress
      case $ERROR_IO_PENDING
        Debug("ConnectClient .....: Pending")
      ; Client is already connected, so signal an event
      case $ERROR_PIPE_CONNECTED
        LogMsg("ConnectClient .....: Connected")
        $iState = 1
        if not _WinAPI_SetEvent(DllStructGetData($tOverlap, "hEvent")) then
          LogError("ConnectClient .....: SetEvent failed")
        endif
      ; Error occurred during the connection event
      case else
        LogError("ConnectClient .....: ConnectNamedPipe 2 failed")
    EndSwitch
  endif
EndFunc

; ===============================================================================================================================
; Dumps debug information to the screen
; ===============================================================================================================================
Func Debug($sMessage)
  if $DEBUGGING then LogMsg($sMessage)
EndFunc

; ===============================================================================================================================
; Executes a command and returns the results
; ===============================================================================================================================
Func ExecuteCmd($sCmd)
  Local $tProcess, $tSecurity, $tStartup, $hWritePipe

  ; Set up security attributes
  $tSecurity = DllStructCreate($tagSECURITY_ATTRIBUTES)
  DllStructSetData($tSecurity, "Length"       , DllStructGetSize($tSecurity))
  DllStructSetData($tSecurity, "InheritHandle", True)

  ; Create a pipe for the child process's STDOUT
  if not _NamedPipes_CreatePipe($hReadPipe, $hWritePipe, $tSecurity) then
    LogError("ExecuteCmd ........: _NamedPipes_CreatePipe failed")
    Return False
  endif

  ; Create child process
  $tProcess = DllStructCreate($tagPROCESS_INFORMATION)
  $tStartup = DllStructCreate($tagSTARTUPINFO)
  DllStructSetData($tStartup, "Size"     , DllStructGetSize($tStartup))
  DllStructSetData($tStartup, "Flags"    , BitOR($STARTF_USESTDHANDLES, $STARTF_USESHOWWINDOW))
  DllStructSetData($tStartup, "StdOutput", $hWritePipe)
  DllStructSetData($tStartup, "StdError" , $hWritePipe)
  if not _WinAPI_CreateProcess("", $sCmd, 0, 0, True, 0, 0, "", DllStructGetPtr($tStartup), DllStructGetPtr($tProcess)) then
    LogError("ExecuteCmd ........: _WinAPI_CreateProcess failed")
    _WinAPI_CloseHandle($hReadPipe )
    _WinAPI_CloseHandle($hWritePipe)
    Return False
  endif
  _WinAPI_CloseHandle(DllStructGetData($tProcess, "hProcess"))
  _WinAPI_CloseHandle(DllStructGetData($tProcess, "hThread" ))

  ; Close the write end of the pipe so that we can read from the read end
  _WinAPI_CloseHandle($hWritePipe)

  LogMsg("ExecuteCommand ....: " & $sCmd)
  Return True
EndFunc

; ===============================================================================================================================
; Logs an error message to the display
; ===============================================================================================================================
Func LogError($sMessage)
  $sMessage &= " (" & _WinAPI_GetLastErrorMessage() & ")"
  ConsoleWrite($sMessage & @LF)
EndFunc

; ===============================================================================================================================
; Logs a message to the display
; ===============================================================================================================================
Func LogMsg($sMessage)
  GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc

; ===============================================================================================================================
; This function is called when an error occurs or when the client closes its handle to the pipe
; ===============================================================================================================================
Func ReconnectClient()
  ; Disconnect the pipe instance
  if not _NamedPipes_DisconnectNamedPipe($hPipe) then
    LogError("ReconnectClient ...: DisonnectNamedPipe failed")
    Return
  endif

  ; Connect to a new client
  ConnectClient()
EndFunc
