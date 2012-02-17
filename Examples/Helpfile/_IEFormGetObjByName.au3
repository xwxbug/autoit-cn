; *******************************************************
; 示例 1 - 根据名称获取到指定表单的引用.  这里, 提交查询
;				到谷歌搜索引擎.  注意表单名称和表单
;				元素可以查看 HTML 源代码找到
; *******************************************************

#include <IE.au3>

Local $oIE = _IECreate("http://www.google.com")
Local $oForm = _IEFormGetObjByName($oIE, "f")
Local $oQuery = _IEFormElementGetObjByName($oForm, "q")
_IEFormElementSetValue($oQuery, "AutoIt IE.au3")
_IEFormSubmit($oForm)
