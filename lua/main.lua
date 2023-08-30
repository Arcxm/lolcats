local color_reset = "\x1B[0m"
local freq = 0.1

RGB = {}

function RGB:new(r, g, b)
    self = { r = r, g = g, b = b }
    self.__index = self
    return setmetatable(self, RGB)
end

local function rainbow(frequency, i)
    local r = math.floor(math.sin(frequency * i) * 127 + 128)
    local g = math.floor(math.sin(frequency * i + 2 * math.pi / 3) * 127 + 128)
    local b = math.floor(math.sin(frequency * i + 4 * math.pi / 3) * 127 + 128)

    return RGB:new(r, g, b)
end

local function putc_with_rgb(c, color)
    io.write("\x1B[38;2;" .. color.r .. ";" .. color.g .. ";" .. color.b .. "m" .. c .. color_reset)
end

if #arg > 0 then
    local input = arg[1]

    for i = 1, input:len() do
        local c = input:sub(i, i)
        putc_with_rgb(c, rainbow(freq, i))
    end
end