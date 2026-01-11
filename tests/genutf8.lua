-- Lua-Version von genutf8.pl
-- Create test comparison data using a different UTF-8 implementation.

-- The generated utf8.dat file must have the following MD5 sum:
--       cff03b039d850f370a7362f3313e5268
local filename = "utf8.dat"

-- Funktion zur Generierung der Codepoints (unter Ausschluss der Surrogates D800-DFFF)
local function generate_utf8_data()
    local chunks = {}

    -- Bereich 1: 0 bis D7FF
    for i = 0, 0xD7FF do
        table.insert(chunks, utf8.char(i))
    end

    -- Bereich 2: E000 bis 10FFFF (Supplementary Codepoints)
    for i = 0xE000, 0x10FFFF do
        table.insert(chunks, utf8.char(i))
    end

    return table.concat(chunks)
end

local data = generate_utf8_data()

-- Datei im Binärmodus schreiben, um CRLF-Konvertierungen unter Windows zu vermeiden
local file, err = io.open(filename, "wb")
if not file then
    error("Konnte " .. filename .. " nicht öffnen: " .. err)
end

file:write(data)
file:close()

print("Datei " .. filename .. " erfolgreich erstellt.")
