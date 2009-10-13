-- ASCII Table for SciTE; khman 20050812; public domain
-- http://lua-users.org/wiki/SciteAsciiTable
-------------------------------------------------------
local Ctrl = false -- set to true if ASCII<32 appear as valid chars
scite.Open("")
local hl = "    +----------------+\n"
editor:AddText("ASCII Table:\n"..hl.."Hex |0123456789ABCDEF|\n"..hl)
local start = Ctrl and 0 or 32
for x = start, 240, 16 do
    editor:AddText(string.format(" %02X |", x))
    for y = x, x+15 do editor:AddText(string.char(y)) end
    editor:AddText("|\n")
end
editor:AddText(hl)
if not Ctrl then
    editor:AddText(
        "\nControl Characters:\n"..
        " 00: NUL SOH STX ETX\n 04: EOT ENQ ACK BEL\n"..
        " 08: BS  HT  LF  VT\n 0C: FF  CR  SO  SI\n"..
        " 10: DLE DC1 DC2 DC3\n 14: DC4 NAK SYN ETB\n"..
        " 18: CAN EM  SUB ESC\n 1C: FS  GS  RS  US\n"
    )
end
