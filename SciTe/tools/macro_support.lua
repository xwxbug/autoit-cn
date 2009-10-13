--[[
Macros support for SciTE
Version 2.3.2
Author: VladVRO
---------------------------------------------------
Description:
macros recording, storing and playing support
(Поддержка записи и воспроизведения макросов)

Using:
add next line into SciTEGlobal.properties:
 ext.lua.startup.script=$(SciteDefaultHome)\macro_support.lua
or if you already have startup script than add next line in it:
 dofile ("macro_support.lua")

and next lines into SciTEUser.properties:
 command.name.40.*=Macro Load From Selection
 command.40.*=MacroLoadFromSelection
 command.mode.40.*=subsystem:lua,savebefore:no

 command.name.41.*=Macro Fill To Buffer
 command.41.*=MacroFillToBuffer
 command.mode.41.*=subsystem:lua,savebefore:no

 command.name.42.*=Macro Fill To Buffer (LUA code)
 command.42.*=MacroFillToBuffer LUA
 command.mode.42.*=subsystem:lua,savebefore:no
---------------------------------------------------
]]
require 'shell'

scite.Perform("macroenable:1")

-- pattern for macro name
local macro_name_pattern = "([a-zA-Z0-9_%-%+%.%(%)]+)"

-- global tables
local glb_macro_buf = {}
local glb_macros_table = {}
local glb_macros_name_table = {}

-- working state
local is_load_from_file = false

-- position in list for new recorded macro
--  -1 - last position
--  default = 1
local function macro_new_record_position()
  local position =  props['macro.new.record.position']
  if position == "" then
    return 1
  else
    return tonumber(position)
  end
end

-- path to file with macros
local function macro_file_path()
  local path = props['macro.file.path']
  if path == "" then
    path = props['scite.userhome']
    if path == "" then path = props['SciteDefaultHome'] end
    path = path.."\\SciTE.macro"
  end
  return path
end


function OnMacro(cmd, msg)
  if cmd == "macro:run" then
    if msg == "<clean list>" then
      scite.Perform("currentmacro:")
      while table.getn(glb_macros_name_table) > 0 do
        glb_macros_table[glb_macros_name_table[1]] = nil
        table.remove(glb_macros_name_table,1)
      end
    else
      local macro = glb_macros_table[msg]
      if macro then
        scite.SendEditor(SCI_AUTOCCANCEL)
        editor:BeginUndoAction()
        for _,val in pairs(macro) do
          local c,lp,wp = unpack(val)
          if IFACE_FUNCTIONS_USE_WP[c] then
            scite.SendEditor(c,wp,lp)
          else
            scite.SendEditor(c,lp,0)
          end
        end
        editor:EndUndoAction()
      end
    end
  elseif cmd == "macro:record" then
    for c,wp,_,lp in string.gfind(msg, "(%d+);(%d+);(%d+);(.*)") do
      table.insert(glb_macro_buf, {tonumber(c),lp,wp})
    end
  elseif cmd == "macro:startrecord" then
    props['macro-recording'] = '1'
    table_clear(glb_macro_buf)
    -- visualization
    if props['style.*.33.normal'] == "" then props['style.*.33.normal'] = props['style.*.33'] end
    if props['macro.recording.numfield.style'] ~= "" then
      props["style.*.33"] = props['macro.recording.numfield.style']
      scite.Perform("reloadproperties:")
    end
  elseif cmd == "macro:stoprecord" then
    props['macro-recording'] = ''
    local name = MacroAddToList(glb_macro_buf, nil, macro_new_record_position())
    if name then
      scite.Perform("currentmacro:"..name)
    end
    table_clear(glb_macro_buf)
    -- visualization
    if props['macro.recording.numfield.style'] ~= "" then
      props['style.*.33'] = props['style.*.33.normal']
      scite.Perform("reloadproperties:")
    end
    -- autosave
    if name and props['macro.autosave'] == "1" then
      MacroSaveToFile(macro_file_path())
    end
  elseif cmd == "macro:getlist" then
    if table.getn(glb_macros_name_table) > 0 then
      local list = ""
      for _,name in pairs(glb_macros_name_table) do
        list = list..name..";"
      end
      list = list.."<clean list>"
      local old_sep = editor.AutoCSeparator
      editor.AutoCSeparator = string.byte(';')
      scite.Perform("macrolist:"..list)
      editor.AutoCSeparator = old_sep
    else
      print("> no macros yet!")
    end
  end
end

local function str_to_macro_name(str)
  for a in string.gfind(str, macro_name_pattern) do
    return a
  end
end

function MacroAddToList(macro, name, pos)
  if table.getn(macro) > 0 then
    if not name then
      local i = table.getn(glb_macros_name_table)
      repeat
        i = i + 1
        name = "record"..i
      until glb_macros_table[name] == nil or i > 9999
      if not is_load_from_file and props["macro.fill.name.dialog"] == "1"
        and shell and shell.inputbox
      then
        name = shell.inputbox(
          scite.GetTranslation("Macro Name"),
          scite.GetTranslation("Enter macro name").." \n("..
          scite.GetTranslation("usable chars").." A...z0-9_-+.())",
          name,
          function(str, char)
            return str ~= '' and (char == nil or char:match(macro_name_pattern))
          end
        )
        if not name then
          return
        end
      end
    end
    if not glb_macros_table[name] or table.getn(glb_macros_name_table) == 0 then
      if pos then
        table.insert(glb_macros_name_table, pos, name)
      else
        table.insert(glb_macros_name_table, name)
      end
    end
    glb_macros_table[name] = table_icopy({},macro)
    return name
  end
end

local function macro_to_string(mode)
  local text = ""
  local iface_num2name = {}
  for name,num in pairs(IFACE_FUNCTIONS) do
    iface_num2name[num] = name
  end
  if mode == "LUA" then
    mode = true
  else
    mode = false
  end
  for _,name in pairs(glb_macros_name_table) do
    macro = glb_macros_table[name]
    if macro then
      text = text.."\n--- "..name.." ---\n"
      for _,val in pairs(macro) do
        local c,lp,wp = unpack(val)
        if string.len(lp) > 0 then
          for _,v in pairs(MACRO_CONVERT_CHARS) do
            lp = string.gsub(lp,unpack(v))
          end
          lp = "'"..lp.."'"
        end
        if mode then
          if IFACE_FUNCTIONS_USE_WP[c] then
            if string.len(lp) > 0 then
              wp = wp..", "
            end
          else
            wp = ""
          end
          text = text.."editor:"..ifnil(iface_num2name[c],c).."("..wp..lp..")\n"
        else
          text = text..ifnil(iface_num2name[c],c)..";"..wp..";"..lp.."\n"
        end
      end
    end
  end
  return text
end

local function macro_load(text)
  local macro = {}
  local name = nil
  local text = text.."\n"
  for str in string.gfind(text, "([^\n]*)[\n]") do
    if string.sub(str, 1, 3) == "---" then
      MacroAddToList(macro, name)
      macro = {}
      name = str_to_macro_name(string.sub(str, 4))
    else
      str = string.gsub(str, "\r", "")
      for fnc,wp,lp in string.gfind(str, "(%w+);(%d+);(.*)") do
        local c = IFACE_FUNCTIONS[fnc]
        if c then
          if string.len(lp) > 0 then
            lp = dostring("return "..lp)
          end
          table.insert(macro, {c,lp,wp})
        else
          print("> undefined function "..fnc)
          return false
        end
      end
    end
  end
  MacroAddToList(macro, name)
end


MACRO_CONVERT_CHARS = {
  {"\\", "\\\\"},
  {"\'", "\\\'"},
  {"\r", "\\r"},
  {"\n", "\\n"},
}

IFACE_FUNCTIONS = {
  ["AddText"] = 2001,
  ["AppendText"] = 2282,
  ["BackTab"] = 2328,
  ["Cancel"] = 2325,
  ["CharLeft"] = 2304,
  ["CharLeftExtend"] = 2305,
  ["CharLeftRectExtend"] = 2428,
  ["CharRight"] = 2306,
  ["CharRightExtend"] = 2307,
  ["CharRightRectExtend"] = 2429,
  ["Clear"] = 2180,
  ["ClearAll"] = 2004,
  ["Copy"] = 2178,
  ["CopyRange"] = 2419,
  ["Cut"] = 2177,
  ["DelLineLeft"] = 2395,
  ["DelLineRight"] = 2396,
  ["DelWordLeft"] = 2335,
  ["DelWordRight"] = 2336,
  ["DeleteBack"] = 2326,
  ["DeleteBackNotLine"] = 2344,
  ["DocumentEnd"] = 2318,
  ["DocumentEndExtend"] = 2319,
  ["DocumentStart"] = 2316,
  ["DocumentStartExtend"] = 2317,
  ["EditToggleOvertype"] = 2324,
  ["FormFeed"] = 2330,
  ["GotoLine"] = 2024,
  ["GotoPos"] = 2025,
  ["Home"] = 2312,
  ["HomeDisplay"] = 2345,
  ["HomeDisplayExtend"] = 2346,
  ["HomeExtend"] = 2313,
  ["HomeRectExtend"] = 2430,
  ["HomeWrap"] = 2349,
  ["HomeWrapExtend"] = 2450,
  ["InsertText"] = 2003,
  ["LineCopy"] = 2455,
  ["LineCut"] = 2337,
  ["LineDelete"] = 2338,
  ["LineDown"] = 2300,
  ["LineDownExtend"] = 2301,
  ["LineDownRectExtend"] = 2426,
  ["LineDuplicate"] = 2404,
  ["LineEnd"] = 2314,
  ["LineEndDisplay"] = 2347,
  ["LineEndDisplayExtend"] = 2348,
  ["LineEndExtend"] = 2315,
  ["LineEndRectExtend"] = 2432,
  ["LineEndWrap"] = 2451,
  ["LineEndWrapExtend"] = 2452,
  ["LineScrollDown"] = 2342,
  ["LineScrollUp"] = 2343,
  ["LineTranspose"] = 2339,
  ["LineUp"] = 2302,
  ["LineUpExtend"] = 2303,
  ["LineUpRectExtend"] = 2427,
  ["LinesJoin"] = 2288,
  ["LinesSplit"] = 2289,
  ["LoadLexerLibrary"] = 4007,
  ["LowerCase"] = 2340,
  ["MarkerAdd"] = 2043,
  ["MarkerAddSet"] = 2466,
  ["MarkerDefine"] = 2040,
  ["MarkerDefinePixmap"] = 2049,
  ["MarkerDelete"] = 2044,
  ["MarkerDeleteAll"] = 2045,
  ["MarkerDeleteHandle"] = 2018,
  ["MarkerGet"] = 2046,
  ["MarkerLineFromHandle"] = 2017,
  ["MarkerNext"] = 2047,
  ["MarkerPrevious"] = 2048,
  ["MoveCaretInsideView"] = 2401,
  ["NewLine"] = 2329,
  ["Null"] = 2172,
  ["PageDown"] = 2322,
  ["PageDownExtend"] = 2323,
  ["PageDownRectExtend"] = 2434,
  ["PageUp"] = 2320,
  ["PageUpExtend"] = 2321,
  ["PageUpRectExtend"] = 2433,
  ["ParaDown"] = 2413,
  ["ParaDownExtend"] = 2414,
  ["ParaUp"] = 2415,
  ["ParaUpExtend"] = 2416,
  ["Paste"] = 2179,
  ["ReplaceSel"] = 2170,
  ["ReplaceTarget"] = 2194,
  ["ReplaceTargetRE"] = 2195,
  ["ScrollCaret"] = 2169,
  ["SearchAnchor"] = 2366,
  ["SearchInTarget"] = 2197,
  ["SearchNext"] = 2367,
  ["SearchPrev"] = 2368,
  ["SelectAll"] = 2013,
  ["SelectionDuplicate"] = 2469,
  ["SetCharsDefault"] = 2444,
  ["SetSavePoint"] = 2014,
  ["SetSel"] = 2160,
  ["SetText"] = 2181,
  ["StutteredPageDown"] = 2437,
  ["StutteredPageDownExtend"] = 2438,
  ["StutteredPageUp"] = 2435,
  ["StutteredPageUpExtend"] = 2436,
  ["Tab"] = 2327,
  ["TargetFromSelection"] = 2287,
  ["UpperCase"] = 2341,
  ["VCHome"] = 2331,
  ["VCHomeExtend"] = 2332,
  ["VCHomeRectExtend"] = 2431,
  ["VCHomeWrap"] = 2453,
  ["VCHomeWrapExtend"] = 2454,
  ["WordLeft"] = 2308,
  ["WordLeftEnd"] = 2439,
  ["WordLeftEndExtend"] = 2440,
  ["WordLeftExtend"] = 2309,
  ["WordPartLeft"] = 2390,
  ["WordPartLeftExtend"] = 2391,
  ["WordPartRight"] = 2392,
  ["WordPartRightExtend"] = 2393,
  ["WordRight"] = 2310,
  ["WordRightEnd"] = 2441,
  ["WordRightEndExtend"] = 2442,
  ["WordRightExtend"] = 2311,
  ["WordStartPosition"] = 2266,
}

IFACE_FUNCTIONS_USE_WP = {
  [IFACE_FUNCTIONS["CopyRange"]] = true,
  [IFACE_FUNCTIONS["GotoLine"]] = true,
  [IFACE_FUNCTIONS["GotoPos"]] = true,
  [IFACE_FUNCTIONS["InsertText"]] = true,
  [IFACE_FUNCTIONS["LinesSplit"]] = true,
  [IFACE_FUNCTIONS["MarkerAdd"]] = true,
  [IFACE_FUNCTIONS["MarkerAddSet"]] = true,
  [IFACE_FUNCTIONS["MarkerDefine"]] = true,
  [IFACE_FUNCTIONS["MarkerDefinePixmap"]] = true,
  [IFACE_FUNCTIONS["MarkerDelete"]] = true,
  [IFACE_FUNCTIONS["MarkerDeleteAll"]] = true,
  [IFACE_FUNCTIONS["MarkerDeleteHandle"]] = true,
  [IFACE_FUNCTIONS["MarkerGet"]] = true,
  [IFACE_FUNCTIONS["MarkerLineFromHandle"]] = true,
  [IFACE_FUNCTIONS["MarkerNext"]] = true,
  [IFACE_FUNCTIONS["MarkerPrevious"]] = true,
  [IFACE_FUNCTIONS["SearchNext"]] = true,
  [IFACE_FUNCTIONS["SearchPrev"]] = true,
  [IFACE_FUNCTIONS["SetSel"]] = true,
}


----------------------------------------------------------
-- io functions

function MacroFillToBuffer(mode)
  editor:append(macro_to_string(mode))
end

function MacroLoadFromSelection()
  macro_load(editor:GetSelText())
  -- autosave
  if props['macro.autosave'] == "1" then
    MacroSaveToFile(macro_file_path())
  end
end

function MacroLoadFromFile(filename)
  is_load_from_file = true
  local fl = io.open(filename)
  if fl ~= nil then
    fl:seek("set")
    macro_load(fl:read("*a"))
    fl:close()
  end
  is_load_from_file = false
end

function MacroSaveToFile(filename)
  io.output(filename)
  io.write(macro_to_string())
  io.close()
end


----------------------------------------------------------
-- common functions

function table_clear(tbl)
  while table.getn(tbl) > 0 do table.remove(tbl) end
end

function table_icopy(tbl,from_tbl)
  for _,v in pairs(from_tbl) do table.insert(tbl,v) end
  return tbl
end

function ifnil(Val, defVal)
  if (Val == nil) then
    return defVal;
  else
    return Val;
  end
end


----------------------------------------------------------
-- load macros at startup
if props['macro.load.on.startup'] == "1" then
  MacroLoadFromFile(macro_file_path())
end
