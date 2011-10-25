


相关 _IEFormElementGetValue, _IEFormElementGetCollection, _IEFormElementGetObjByName, _IEFormElementOptionSelect, _IEFormElementCheckboxSelect, _IEFormElementRadioSelect

示例
; *******************************************************
; 示例1 - 打开带有表单示例的浏览器, 设置表单文本元素的值
; *******************************************************
#include  <IE.au3>
$oIE = _IE_Example(" form ")
$oForm = _IEFormGetObjByName($oIE, "示例Form ")
$oText = _IEFormElementGetObjByName($oForm, "text Example ")
_IEFormElementSetValue($oText, "Hey! This works! ")

; *******************************************************
; 示例2 - 获取指定表单元素的引用并设置其值. 此例中, 向Google搜索引擎提交查询.
; *******************************************************
#include  <IE.au3>
$oIE = _IECreate(" http://www.google.com ")
$oForm = _IEFormGetObjByName($oIE, "f ")
$oQuery = _IEFormElementGetObjByName($oForm, "q ")
_IEFormElementSetValue($oQuery, "AutoIt IE.au3 ")
_IEFormSubmit($oForm)

; *******************************************************
; 示例3 - 登录到Hotmail
; *******************************************************
#include  <IE.au3>
; 创建浏览器窗口并浏览hotmail
$oIE = _IECreate(" http://www.hotmail.com ")

; 获取登录表单和用户名, 密码及登入区的指针
$o_form = _IEFormGetObjByName($oIE, "f1 ")
$o_login = _IEFormElementGetObjByName($o_form, "login ")
$o_password = _IEFormElementGetObjByName($o_form, "passwd ")
$o_signin = _IEFormElementGetObjByName($o_form, "SI ")

$username = " your username here "
$password = " your password here "

; 设置字段值并提交
_IEFormElementSetValue($o_login, $username)
_IEFormElementSetValue($o_password, $password)
_IEAction($o_signin, "click ")

; *******************************************************
; 示例 4 - 设置<INPUT TYPE=FILE>元素的值(安全限制阻止使用_IEFormElementSetValue)
; *******************************************************
#include  <IE.au3>

$oIE = _IE_Example(" form ")
$oForm = _IEFormGetObjByName($oIE, "ExampleForm ")
$oInputFile = _IEFormElementGetObjByName($oForm, "fileExample ")

; 将输入焦点分配到字段并发送文本串
_IEAction($oInputFile, "focus ")
Send(" C:\myfile.txt ")

; *******************************************************
; 示例5 - 设置<INPUT TYPE=FILE>元素的值, 与前例相同, 但隐藏窗体(安全限制阻止使用_IEFormElementSetValue)
; *******************************************************
#include  <IE.au3>

$oIE = _IE_Example(" form ")

; 隐藏浏览器窗口演示向不可见窗口发送文本
_IEAction($oIE, "invisible ")

$oForm = _IEFormGetObjByName($oIE, "ExampleForm ")
$oInputFile = _IEFormElementGetObjByName($oForm, "fileExample ")

; 将输入焦点分配到字段并发送文本串
_IEAction($oInputFile, "focus ")
$hIE = _IEPropertyGet($oIE, "hwnd ")
ControlSend($hIE, "", "[CLASS:Internet Explorer_Server; INSTANCE:1]", "C:\myfile.txt ")

msgbox(0, "Success", "Value set to C:\myfile.txt ")
_IEAction($oIE, "visible ")

