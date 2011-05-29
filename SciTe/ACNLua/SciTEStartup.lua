--------------------------------------------------------------------------------
-- SciTE 启动脚本.
--------------------------------------------------------------------------------

-- 所有需要载入的文件的列表.
LoadLuaFileList = { }

--------------------------------------------------------------------------------
-- LoadLuaFile(文件, 目录)
--
-- 辅助函数,帮助简单的载入Lua文件.
--
-- 参数:
--	文件 - 要载入的Lua文件名.
--	目录 - 如果指定,就在指定的目录中查找文件.默认情况下,
-- 		 这个目录为 $(SciTEDefaultHome)\ACNLua.
--------------------------------------------------------------------------------
function LoadLuaFile(file, directory)
	if directory == nil then
		directory = props["SciteDefaultHome"] .. "\\ACNLua\\"
	end
	table.insert(LoadLuaFileList, directory .. file)
	dofile(directory .. file)
end	-- LoadLuaFile()

-- 载入所有 Lua 文件.
LoadLuaFile("Class.lua")				-- 总是首先载入.
LoadLuaFile("Common.lua")				-- 总是次要载入.
LoadLuaFile("AutoItPixmap.lua")			-- AU3图形映射表.用于工具提示显示的图标.
LoadLuaFile("AutoHScroll.lua")			-- 自动滚动
LoadLuaFile("AutoItAutoComplete.lua")	-- AU3自动完成单词
LoadLuaFile("AutoItIndentFix.lua")		-- AU3缩进修正
LoadLuaFile("SmartAutoCompleteHide.lua")-- 只能自动完成隐藏
LoadLuaFile("Tools.lua")				-- 一些AU3使用的工具
LoadLuaFile("AutoItTools.lua")			-- 一些AU3使用的工具
LoadLuaFile("AutoItGotoDefinition.lua")	-- AU3跳转定义

-- 开始事件(调用OnStartup()).
EventClass:BeginEvents()
