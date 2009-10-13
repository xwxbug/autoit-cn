-----------------------------------------------------------------------
-- Basic Calculator for SciTE
-- Kein-Hong Man <khman@users.sf.net> (version information below)
-- small correction by mozers
-- This program is hereby placed into PUBLIC DOMAIN
-----------------------------------------------------------------------
-- This script can be installed to a shortcut using properties:
--     command.name.8.*=Calculator
--     command.subsystem.8.*=3
--     command.8.*=Calculator
--     command.save.before.8.*=2
-- If you use extman, you can do it in Lua like this:
--     scite_Command('Calculator|Calculator|Ctrl+8')
-----------------------------------------------------------------------
-- * This is a *basic* calculator, it does not have a lot of commands.
-- * If switching to monospace is a hassle, see instructions on how to
--   automatically start the calculator in monospace in Calculator().
-- * If you don't want the notice at the bottom, please comment it out.
-- * To change key mappings, see HandleChar(c) and table KeyMap.
-- * If you find a bug, please fix it, add credits, upload.
-----------------------------------------------------------------------

------------------------------------------------------------------------
-- constants and primitives
------------------------------------------------------------------------
local VERSION, REVDATE = "0.5", "20060904"
local SIG = "SciTECalculatorPD"
local string = string

local MSG = {
-- [[ NOTE: comment out if you don't want the message shown
  Notice = [[
+-----------------------------------------------------------+
| SciTE Basic Calculator by <khman@users.sf.net> ########   |
| Use by pressing keys as you would in a normal calculator, |
| or double-click the "buttons". Press 'H' for help.        |
+-----------------------------------------------------------+
]],
--]]
  -- Notice = "",
  Header = [[
+------------------------------------------------+
| SciTE Basic Calculator                ver. ### |
+------------------------------------------------+
]],
  LCDTop = [[
|/-\/---\/--------------------------------------\|
]],
  Width = 36,           -- width of numerical display area
  CaretPos = 251,       -- fixed location where data entry point is
  LCDBot = [[
|\-/\---/\--------------------------------------/|
]],
  Keypad = [[
|------------------------------------------------|
| +-----+-----+-----+-----+  +----+-----+------+ |
| | Hex | Dec | Oct | Bin |  | <- |  C  |  AC  | |
| +-----+-----+-----+-----+  +----+-----+------+ |
| +----+ +-----+-----+-----+ +-----+-----+-----+ |
| | MC | |  7  |  8  |  9  | |  /  | Mod | And | |
| +----+ +-----+-----+-----+ +-----+-----+-----+ |
| | MR | |  4  |  5  |  6  | |  *  | Or  | Xor | |
| +----+ +-----+-----+-----+ +-----+-----+-----+ |
| | MS | |  1  |  2  |  3  | |  -  | Lsh | Not | |
| +----+ +-----+-----+-----+ +-----+-----+-----+ |
| | M+ | |  0  | +/- |  .  | |  +  |  =  | Int | |
| +----+ +-----+-----+-----+ +-----+-----+-----+ |
| +----+ +-----+-----+-----+ +-----+-----+-----+ |
| | PI | |  A  |  B  |  C  | |  D  |  E  |  F  | |
| +----+ +-----+-----+-----+ +-----+-----+-----+ |
+------------------------------------------------+
]],
  Help = [[

               Help for SciTE Basic Calculator
               -------------------------------

The following keys are recognized by the calculator:

    [Space]      All clear (AC)
    X            Cancel number (C)
    Z, \         Delete last character (<-)
    [Enter], =   Evaluate (=)
    1-9, A-F     Digits, hexadecimal digits
    .            Decimal point
    /, *, -, +   Basic operations
    Q, R, S, T   Memory operations (MC, MR, MS, M+)
    I            Truncate fractional portion (Int)
    H            Toggle help screen
    [, ]         Switch radix

This calculator is not meant for heavy-duty work. Non-decimal
bases and some operations can only work with 32 bit signed
integers. There is no support for scientific notation entry.

This script has been declared by the author to be public domain
code. Author information can be found in the Lua sources.
See http://lua-users.org/wiki/SciteScripts for more scripts.

Press H again to return to the calculator display...]],
}

-- translate keypresses to calculator commands
local KeyMap = {
  ["\n"] = "=", [" "] = "AC", X = "CN",
  Z = "<-", ["\\"] = "<-",
  Q = "MC", R = "MR", S = "MS", T = "M+",
  I = "Int", ["["] = "RL", ["]"] = "RR",
}

-- fixed button set: [line]={{ColStart,ColEnd,Id}...}
local BUTTONS = {
  [8] = {{4,8,"Hex"},{10,14,"Dec"},{16,20,"Oct"},{22,26,"Bin"},
         {31,34,"<-"},{36,40,"CN"},{42,47,"AC"},},
  [11] = {{4,7,"MC"},{11,15,"7"},{17,21,"8"},{23,27,"9"},
          {31,35,"/"},{37,41,"Mod"},{43,47,"And"},},
  [13] = {{4,7,"MR"},{11,15,"4"},{17,21,"5"},{23,27,"6"},
          {31,35,"*"},{37,41,"Or"},{43,47,"Xor"},},
  [15] = {{4,7,"MS"},{11,15,"1"},{17,21,"2"},{23,27,"3"},
          {31,35,"-"},{37,41,"Lsh"},{43,47,"Not"},},
  [17] = {{4,7,"M+"},{11,15,"0"},{17,21,"+/-"},{23,27,"."},
          {31,35,"+"},{37,41,"="},{43,47,"Int"},},
  [20] = {{4,7,"PI"},{11,15,"A"},{17,21,"B"},{23,27,"C"},
          {31,35,"D"},{37,41,"E"},{43,47,"F"},},
}

------------------------------------------------------------------------
-- simple check for extman, partially emulate if okay to do so
------------------------------------------------------------------------
local function Error(msg) _ALERT(">"..SIG..": "..msg) end   -- error msg

--[[
if (OnDoubleClick or OnChar) and not scite_Command then
  Error("There is a handler conflict, please use extman")
else
  -- simple way to add a handler only, can't remove like extman does
  if not scite_OnDoubleClick then
    local _OnDC
    scite_OnDoubleClick = function(f) _OnDC = f end
    OnDoubleClick = function(c) if _OnDC then return _OnDC(c) end end
  end
  if not scite_OnChar then
    local _OnCh
    scite_OnChar = function(f) _OnCh = f end
    OnChar = function(c) if _OnCh then return _OnCh(c) end end
  end
end
]]--

------------------------------------------------------------------------
-- preprocessing
------------------------------------------------------------------------
MSG.Notice = string.gsub(MSG.Notice, "########", REVDATE)
MSG.Header = string.gsub(MSG.Header, "###", VERSION)

------------------------------------------------------------------------
-- calculator functions
-- * outline of how this calculator should run, may be buggy!
-- -------------------------------------------------------------
-- Command     InputEnd   Operator  Display   Operand   Accu
-- -------------------------------------------------------------
-- AC          false      nil       ""        nil       nil
-- CN          false      -         ""        -         -
-- <- (1)      -          -         del char  -         -
-- /*-+ (2)    true       set       eval?     disp      eval?
-- Mod (2)     true       set       eval?     disp      eval?
-- =           true       set?      eval?     disp?     nil
-- -------------------------------------------------------------
-- And,Or,Xor, (see next line)
-- Lsh (2)(3)  true       set       eval?     disp      eval?
-- Not (3)     true       -         not       -
-- -------------------------------------------------------------
-- Hex,... (4) true       -         convert   -
-- RL,RR (4)   true       -         convert   -
-- -------------------------------------------------------------
-- (1) if InputEnd then clear display buffer
-- (2) evaluate last operator if one present, set Op/Oper too;
--     for Mod, integers only, using math.mod
-- (3) valid for 32-bit signed and unsigned integer values only;
--     Lsh allows bigger range in dec mode
-- (4) check for range of 32-bit int
-- -------------------------------------------------------------
-- Command     InputEnd   Operator  Display   Operand
-- -------------------------------------------------------------
-- 0-9 (1)(5)  -          -         add char  -
-- A-F (1)(6)  -          -         add char  -
-- . (1)(7)    -          -         add char  -
-- +/- (8)     -          -         eval      -
-- PI (9)      true       -         replace   -
-- Int (9)     true       -         eval      -
-- -------------------------------------------------------------
-- MC          -          -         -         -
-- MR (10)     true       -         replace   -
-- MS,M+       -          -         (read)    -
-- -------------------------------------------------------------
-- (5) limit range to 32-bit int if bin/oct, block some if bin/oct,
--     check and ignore zeros that does nothing
-- (6) hex mode only, limit range to 32-bit int
-- (7) dec mode only, only one allowed, may need "0." prefix
-- (8) perform 2s complement negation in hex/oct/bin
-- (9) dec mode only
-- (10) nothing happens if no memory present or if memory is a
--      non-integer in hex/oct/bin modes
-- -------------------------------------------------------------
-- * primitive tests:
--   (a) 2 = =          2       (d) 2 + = =             4,6
--   (b) 2 + 3 + 4 =    5,9     (e) 2 + 3 = 4 =         5,7
--   (c) 2 + * 3 =      6       (f) 2 + 3 + = + =       5,10,20
------------------------------------------------------------------------

-- radix stuff, tables for switching calculator radix
local Radix = {
  Name = { [16]="Hex", [10]="Dec", [8]="Oct", [2]="Bin", },
  Left = { [16]=2, [10]=16, [8]=10, [2]=8, },
  Right = { [16]=10, [10]=8, [8]=2, [2]=16, },
  Value = { Hex=16, Dec=10, Oct=8, Bin=2, },
}
-- lookup tables for matching commands
local Cmd = {
  Radix = { Hex=true, Dec=true, Oct=true, Bin=true, RL=true, RR=true, },
  Math = { ["/"]=true, ["*"]=true, ["-"]=true, ["+"]=true, Mod=true, },
  Logic = { And=true, Or=true, Xor=true, Lsh=true, },
  Memory = { ["MC"]=true, ["MR"]=true, ["MS"]=true, ["M+"]=true, },
}

-- soft/hard initialization function
local function CalcInit(AC)
  buffer.Disp = ""
  buffer.InputEnd = false
  buffer.Op = nil
  buffer.Oper = nil
  buffer.Acc = nil
  if not AC then        -- if AC, soft reset, otherwise hard
    buffer.Mem = nil
    buffer.Radix = 10
  end
end

local function Calculate(c)
  local ULONG_MAX, LONG_MAX, LONG_MIN =         -- for hex/oct/bin
    4294967295, 2147483647, -2147483648
  --------------------------------------------------------------------
  local v = buffer.Disp or ""                   -- current state
  local vl = string.len(v)
  local rd = buffer.Radix
  local vn                                      -- true value of v
  if v == "" or v == "Error" then vn = 0 else vn = tonumber(v, rd) end
  --------------------------------------------------------------------
  -- clear buffer if new user input after InputEnd
  --------------------------------------------------------------------
  local function CheckInputEnd()
    if buffer.InputEnd then
      buffer.InputEnd = false; buffer.Disp = ""
      v = ""; vl = 0; vn = 0
    end
  end
  --------------------------------------------------------------------
  -- checks whether a number is in range for non-dec usage
  --------------------------------------------------------------------
  local function Is32Int(n)
    if math.floor(n) == n and
       n <= ULONG_MAX and n >= LONG_MIN then return true end
  end
  --------------------------------------------------------------------
  -- converts a number into a suitable string according to radix
  --------------------------------------------------------------------
  local function ToString(n)
    local Digits = "0123456789ABCDEF"
    local r, v = buffer.Radix, ""
    if r == 10 then return tostring(n)  -- decimal conversion
    elseif n < 0 then                   -- convert 2s complement value
      if not Is32Int(n) then
        Error("Number out of range in non-decimal mode") return "Error"
      end
      n = ULONG_MAX + 1 + n
    end
    while n > 0 do                      -- non-decimal conversion
      local n2 = math.floor(n / r)
      local dig = n - n2 * r + 1
      v, n = string.sub(Digits, dig, dig)..v, n2
    end
    return v
  end
  --------------------------------------------------------------------
  -- bitwise not
  --------------------------------------------------------------------
  local function BitNot(n)
    local mult, sum = 1, 0
    for i = 1, 32 do
      local b = (math.mod(n, 2) == 1) and 0 or 1
      sum = sum + b * mult
      mult = mult * 2
      n = math.floor(n / 2)
    end
    return sum
  end
  --------------------------------------------------------------------
  -- bitwise and/or/xor
  --------------------------------------------------------------------
  local function BitwiseOp(n1, n2, op)
    local Logic = {
      And = function(b1, b2) return (b1 + b2 == 2) and 1 or 0 end,
      Or = function(b1, b2) return (b1 + b2 > 0) and 1 or 0 end,
      Xor = function(b1, b2) return (b1 ~= b2) and 1 or 0 end,
    }
    local LogicOp = Logic[op]
    local mult, sum = 1, 0
    for i = 1, 32 do
      local b1, b2 = math.mod(n1, 2), math.mod(n2, 2)
      sum = sum + LogicOp(b1, b2) * mult
      mult = mult * 2
      n1, n2 = math.floor(n1 / 2), math.floor(n2 / 2)
    end
    return sum
  end
  --------------------------------------------------------------------
  -- perform binary operator actions
  --------------------------------------------------------------------
  local function Evaluate()
    local oldvn, acc, op, oper = vn, buffer.Acc, buffer.Op, buffer.Oper
    ----------------------------------------------------------------
    local function SetError() vn = 0; buffer.Disp = "Error" end
    local function IsInt(n) return math.floor(n) == n end
    local function Overflow() return vn == 1/0 or vn == -1/0 end
    ----------------------------------------------------------------
    if op == "+" then vn = acc + oper           -- add/sub/mul
    elseif op == "-" then vn = acc - oper
    elseif op == "*" then vn = acc * oper
    ----------------------------------------------------------------
    elseif op == "/" then                       -- handling for /
      if oper == 0 then SetError() return end
      vn = acc / oper
    ----------------------------------------------------------------
    elseif op == "Mod" then                     -- handling for Mod
      if oper == 0 then SetError() return end
      if not IsInt(acc) or not IsInt(oper) then SetError() return end
      vn = math.mod(acc, oper)
    ----------------------------------------------------------------
    elseif op == "And" or op == "Or" or op == "Xor" then    -- logic
      if not Is32Int(acc) or not Is32Int(oper) then return end
      vn = BitwiseOp(acc, oper, op)
    ----------------------------------------------------------------
    elseif op == "Lsh" then
      if not IsInt(oper) or oper < 0 then SetError() return end
      if oper <= 32 then                -- do long way for small oper
        vn = acc
        for i = 1, oper do
          vn = vn * 2; if Overflow() then break end
        end
      else                              -- otherwise, do log style
        vn = math.exp(math.log(acc) + math.log(2) * oper)
      end
    else
      Error("Unknown binary operator '"..op.."'encountered") return
    end
    ----------------------------------------------------------------
    if rd == 10 then                            -- post dec checks
      if Overflow() then SetError() return end  -- bork on overflow
    else                                        -- post non-dec checks
      vn = math.floor(vn)
      if not Is32Int(vn) then                   -- if non-dec, block 'em
        vn = oldvn; return
      end
    end
    ----------------------------------------------------------------
    buffer.Disp = ToString(vn)                  -- finally, set result
  end
  --------------------------------------------------------------------
  -- implementation of commands and operations
  -- * testing order of c may be important, beware!
  --------------------------------------------------------------------
  if v == "Error" and c ~= "AC" then return end -- block for error
  --------------------------------------------------------------------
  if c == "AC" then                             -- all clear
    CalcInit(true)
  --------------------------------------------------------------------
  elseif c == "CN" then                         -- cancel number
    buffer.InputEnd = false; buffer.Disp = ""
  --------------------------------------------------------------------
  elseif c == "<-" then                         -- backspace
    CheckInputEnd()
    if vl > 0 then buffer.Disp = string.sub(v, 1, -2) end
  --------------------------------------------------------------------
  elseif Cmd.Radix[c] then
    if not Is32Int(vn) then return end
    if c == "RL" then rd2 = Radix.Left[rd]      -- rotate radix
    elseif c == "RR" then rd2 = Radix.Right[rd]
    else rd2 = Radix.Value[c]                   -- select radix
    end
    buffer.Radix = rd2                          -- convert to new radix
    buffer.Disp = ToString(vn)
    buffer.InputEnd = true
  --------------------------------------------------------------------
  elseif Cmd.Memory[c] then
    local m = buffer.Mem
    if c == "MC" then                           -- memory clear
      buffer.Mem = nil
    elseif c == "MR" then                       -- memory read
      if not m then return end
      if rd ~= 10 and not Is32Int(m) then return end
      buffer.Disp = ToString(m)
      buffer.InputEnd = true
    elseif c == "MS" then                       -- memory set
      buffer.Mem = vn
    else-- c == "M+" then                       -- memory add
      buffer.Mem = (m or 0) + vn
    end
  --------------------------------------------------------------------
  elseif (c == "PI" or c == "Int") and rd == 10 then
    if c == "PI" then
      buffer.Disp = math.pi                     -- Pi
    else
      buffer.Disp = math.floor(vn)              -- Integer
    end
    buffer.InputEnd = true
  --------------------------------------------------------------------
  elseif c == "Not" then                        -- logical not
    if not Is32Int(vn) then return end
    if vn < 0 then vn = ULONG_MAX + 1 + vn end
    buffer.Disp = ToString(BitNot(vn))
    buffer.InputEnd = true
  --------------------------------------------------------------------
  elseif c == "=" then                          -- evaluate
    if buffer.Acc then                          -- if acc, got op
      if not buffer.InputEnd then               -- pick up rterm
        buffer.Oper = vn
      end
    else                                        -- if not acc, after =
      buffer.Acc = vn                           -- pick up lterm
    end
    if buffer.Op then Evaluate() end            -- evaluate previous
    buffer.Acc = nil
    buffer.InputEnd = true
  --------------------------------------------------------------------
  elseif Cmd.Math[c] or Cmd.Logic[c] then       -- logical/math ops
    if buffer.Acc then                          -- if acc, always op
      if not buffer.InputEnd then               -- pick up rterm
        buffer.Oper = vn
        Evaluate()                              -- evaluate previous
      end
    end
    buffer.Acc = vn; buffer.Op = c; buffer.Oper = vn
    buffer.InputEnd = true
  --------------------------------------------------------------------
  elseif string.find(c, "%x") then              -- digits
    if rd ~= 10 then                            -- constraints
      if rd == 2 and string.find(c, "[^01]") then return
      elseif rd == 8 and string.find(c, "[^0-7]") then return
      end
      if not Is32Int(vn * rd + tonumber(c, rd)) then return end
    elseif rd == 10 then
      if string.find(c, "[A-F]") then return end
      if (v == "" or v == "0") and c == "0" then return end
    end
    if vl < MSG.Width then
      CheckInputEnd()
      buffer.Disp = v..c
    end
  --------------------------------------------------------------------
  elseif c == "." and rd == 10 then             -- decimal point
    if string.find(v, "%.") then return end
    CheckInputEnd()
    if v == "" then c = "0." end
    buffer.Disp = v..c
  --------------------------------------------------------------------
  elseif c == "+/-" then                        -- negation
    if rd == 10 then
      if v == "" or v == "0" then return end    -- do using string ops
      if string.sub(v, 1, 1) == "-" then
        buffer.Disp = string.sub(v, 2)
      else
        buffer.Disp = "-"..v
      end
    else
      -- in non-decimal, 32-bit 2s complement negation performed
      if vn > 0 then buffer.Disp = ToString(ULONG_MAX + 1 - vn) end
    end
  --------------------------------------------------------------------
  end
end

------------------------------------------------------------------------
-- display functions (performs complete refreshes)
------------------------------------------------------------------------
local function Refresh()
  local function DispMem()              -- display memory store status
    return buffer.Mem and "M" or " "
  end
  local function DispRadix()            -- display number radix
    return Radix.Name[buffer.Radix] or "  "
  end
  local function DispValue()            -- display calculation value
    local v = buffer.Disp
    if not v or v == "" then v = "0" end
    return string.rep(" ", MSG.Width - string.len(v))..v
  end
  editor:ClearAll()
  if buffer.Help then                   -- draws the help screen
    editor:AddText(MSG.Help) return
  end
  editor:AddText(                       -- draws the calculator display
    MSG.Header..MSG.LCDTop..
    "||"..DispMem().."||"..DispRadix().."|| "..DispValue().." ||\n"..
    MSG.LCDBot..MSG.Keypad.."\n"..MSG.Notice
  )
  editor:GotoPos(MSG.CaretPos)          -- position caret on LCD screen
end

------------------------------------------------------------------------
-- handle incoming events
------------------------------------------------------------------------

local function HandleClick()
  if not buffer[SIG] then return end    -- verify buffer signature
  if buffer.Help then return true end   -- ignore clicks if help screen
  local pos = editor.CurrentPos
  local ln = editor:LineFromPosition(pos)
  local col = editor.Column[pos]
  local tln = BUTTONS[ln]               -- check for button click
  if tln then
    for i,b in ipairs(tln) do
      if col >= b[1] and col <= b[2] then Calculate(b[3]) end
    end
  end
  Refresh()
  return true
end

local function HandleChar(c)
  if not buffer[SIG] then return end    -- verify buffer signature
  c = string.upper(c)
  local i = string.find("0123456789ABCDEF./*-+\n= XZ\\QRSTIH[]", c, 1, 1)
  if i then                             -- interpret valid keys
    if c == "H" then                    -- handle help screen
      buffer.Help = not buffer.Help
      Refresh() return true
    end
    Calculate(KeyMap[c] or c)           -- translate keys & calc
  end
  Refresh()
  return true
end

------------------------------------------------------------------------
-- calculator initialization (opens a new file and set up handlers)
------------------------------------------------------------------------
function Calculator()
--~   scite_OnDoubleClick(HandleClick)      -- set up handlers
--~   scite_OnChar(HandleChar)
  props["default.file.ext"] = ".vbs"
  scite.Open("")                        -- create a new buffer
  buffer[SIG] = true;
  buffer.Help = false
  CalcInit()                            -- initialize calculator
  Refresh()                             -- display calculator
  --------------------------------------------------------------------
  -- uncomment if you normally use proportional fonts; get the
  -- script from: http://lua-users.org/wiki/SciteMakeMonospace
  --------------------------------------------------------------------
  --MakeMonospace()
end

-- Добавляем свой обработчик события OnDoubleClick
local old_OnDoubleClick = OnDoubleClick
function OnDoubleClick(shift, ctrl, alt)
	local result
	if old_OnDoubleClick then result = old_OnDoubleClick(shift, ctrl, alt) end
	if HandleClick() then return true end
	return result
end

-- Добавляем свой обработчик события OnChar
local old_OnChar = OnChar
function OnChar(char)
	local result
	if old_OnChar then result = old_OnChar(char) end
	if HandleChar(char) then return true end
	return result
end

-- end of script
