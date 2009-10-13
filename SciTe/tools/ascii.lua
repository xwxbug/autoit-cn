-- Трассировка выделенного текста в коды ASCII
-- Автор: gansA <gans_a@newmail.ru>
-----------------------------------------------
local str = editor:GetSelText()

if string.len(str) > 0 then
    print('>char HEX  DEC')
    for i = 1, string.len(str) do
        local strS = string.sub(str,i,i)
        local strD = string.byte(strS,1)
        local strH = string.format("%02X", strD)
        print(' ['..strS..']  '..strH..'   '..strD)
    end
end
