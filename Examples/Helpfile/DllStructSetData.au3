;=========================================================
;	创建数据结构
;	struct {
;		int				var1;
;		unsigned char	var2;
;		unsigned int	var3;
;		char			var4[128];
;	}
;=========================================================
Local $str = "int;byte;uint;char[128]"
Local $a = DllStructCreate($str)
If @error Then
	MsgBox(4096,"","DllStructCreate 发生错误" & @error);
	Exit
EndIf

;=========================================================
;	设置数据结构中的数据
;	struct.var1	= -1;
;	struct.var2	= 255;
;	struct.var3	= INT_MAX; -1 将自动确定类型(unsigned int)
;	strcpy(struct.var4,"Hello");
;	struct.var4[0]	= 'h';
;=========================================================
DllStructSetData($a, 1, -1)
DllStructSetData($a, 2, 255)
DllStructSetData($a, 3, -1)
DllStructSetData($a, 4, "Hello")
DllStructSetData($a, 4, Asc("h"), 1)

;=========================================================
;	显示数据结构的信息
;=========================================================
MsgBox(4096,"DllStruct","数据结构大小: " & DllStructGetSize($a) & @CRLF & _
		"数据结构指针: " & DllStructGetPtr($a) & @CRLF & _
		"Data:" & @CRLF & _
		DllStructGetData($a, 1) & @CRLF & _
		DllStructGetData($a, 2) & @CRLF & _
		DllStructGetData($a, 3) & @CRLF & _
		DllStructGetData($a, 4))

;=========================================================
;	释放为数据结构分配的内存
;=========================================================
$a = 0
