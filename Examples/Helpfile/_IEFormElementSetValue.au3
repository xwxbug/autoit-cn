; *******************************************************
; Example 1 - Open a browser with the form example, set the value of a text form element
; *******************************************************

#include <IE.au3>

Local $oIE = _IE_Example("form")
Local $oForm = _IEFormGetObjByName($oIE, "ExampleForm")
Local $oText = _IEFormElementGetObjByName($oForm, "textExample")
_IEFormElementSetValue($oText, "Hey! This works!")

; *******************************************************
; Example 2 - Get a reference to a specific form element and set its value.
;				In this case, submit a query to the Google search engine
; *******************************************************

#include <IE.au3>

$oIE = _IECreate("http://www.google.com")
$oForm = _IEFormGetObjByName($oIE, "f")
Local $oQuery = _IEFormElementGetObjByName($oForm, "q")
_IEFormElementSetValue($oQuery, "AutoIt IE.au3")
_IEFormSubmit($oForm)

; *******************************************************
; Example 3 - Login to Hotmail
; *******************************************************

#include <IE.au3>

; Create a browser window and navigate to hotmail
$oIE = _IECreate("http://www.hotmail.com")

; get pointers to the login form and username, password and signin fields
Local $o_form = _IEFormGetObjByName($oIE, "f1")
Local $o_login = _IEFormElementGetObjByName($o_form, "login")
Local $o_password = _IEFormElementGetObjByName($o_form, "passwd")
Local $o_signin = _IEFormElementGetObjByName($o_form, "SI")

Local $username = "your username here"
Local $password = "your password here"

; Set field values and submit the form
_IEFormElementSetValue($o_login, $username)
_IEFormElementSetValue($o_password, $password)
_IEAction($o_signin, "click")

; *******************************************************
; Example 4 - Set the value of an INPUT TYPE=FILE element
;				(security restrictions prevent using _IEFormElementSetValue)
; *******************************************************

#include <IE.au3>

$oIE = _IE_Example("form")
$oForm = _IEFormGetObjByName($oIE, "ExampleForm")
Local $oInputFile = _IEFormElementGetObjByName($oForm, "fileExample")

; Assign input focus to the field and then send the text string
_IEAction($oInputFile, "focus")
Send("C:\myfile.txt")

; *******************************************************
; Example 5 - Set the value of an INPUT TYPE=FILE element
;				Same as previous example, but with invisible window
;				(security restrictions prevent using _IEFormElementSetValue)
; *******************************************************
;
#include <IE.au3>

$oIE = _IE_Example("form")

; Hide the browser window to demonstrate sending text to invisible window
_IEAction($oIE, "invisible")

$oForm = _IEFormGetObjByName($oIE, "ExampleForm")
$oInputFile = _IEFormElementGetObjByName($oForm, "fileExample")

; Assign input focus to the field and then send the text string
_IEAction($oInputFile, "focus")
Local $hIE = _IEPropertyGet($oIE, "hwnd")
ControlSend($hIE, "", "[CLASS:Internet Explorer_Server; INSTANCE:1]", "C:\myfile.txt")

MsgBox(0, "Success", "Value set to C:\myfile.txt")
_IEAction($oIE, "visible")
