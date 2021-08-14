local pngImage = require('png')
local biTop = require('funcs')

local images = { "images/yj.png", "images/katyou.png", "images/ikisugi.png", "images/gban.png", "images/fcoh.png" , "images/77.png" , "images/bnkn.png" , "images/dokata.png" , "images/kbtit.png" , "images/nikuoja.png" }
-- Mirror: 0=None 1=Left right 2=Up down 3=All
local mirror = { 0, 3, 0, 0, 0, 0, 0, 0, 0, 0 }
local roted = { true, false, true, true, true, true, true, true, true, true }
local speed = 3

local cols = { 0xF0F0F0, 0xF2B233, 0xE57FD8, 0x99B2F2, 0xDEDE6C, 0x7FCC19, 0xF2B2CC, 0x4C4C4C, 0x999999, 0x4C99B2, 0xB266E5, 0xB266E5, 0x7F664C, 0x57A64E, 0xCC4C4C, 0x191919 };
local colsNums = { colors.white, colors.orange, colors.magenta, colors.magenta, colors.yellow, colors.yellow, colors.pink, colors.gray, colors.lightGray, colors.cyan, colors.purple, colors.blue, colors.brown, colors.green, colors.red, colors.black };

local current = 1

local w, h = term.getSize()
term.setBackgroundColour(colors.white)
term.setTextColour(colors.black)

if not (term.isColour()) then
    cols = { 0xF0F0F0, 0x191919 }
    colsNums = { colors.white, colors.black }
end

local function colorVector(color)
    return { biTop.rshift(color, 16), math.floor(biTop.band(biTop.rshift(color, 8), 0xFF)), math.floor(biTop.band(color, 0xFF)) }
end

local function distance(r1, g1, b1, r2, g2, b2)
    dis = math.sqrt((r1 - r2) ^ 2 + (g1 - g2) ^ 2 + (b1 - b2) ^ 2)
    return math.abs(dis)
end

local function mostNerColor(r, g, b)
    mostdis = -1
    mostValue = 0
    for i = 1, #cols do
        rgb = colorVector(cols[i])
        dis = distance(r, g, b, rgb[1], rgb[2], rgb[3])
        if (mostdis == -1) or (mostdis > dis) then
            mostValue = i
            mostdis = dis
        end
    end
    return colsNums[mostValue]
end

local function clear()
    for _ = 0, h do
        print('')
    end
end

local function update()
    term.setBackgroundColour(colors.white)
    clear()
    img = pngImage(images[current])
    local bw = #img.pixels / w
    local bh = #img.pixels[1] / h

    aw = w
    ah = h
    if (roted[current]) then
        aw = h
        ah = w
        bw = #img.pixels / h
        bh = #img.pixels[1] / w
    end

    for x = 0, aw do
        for y = 0, ah do
            if not (bw == nil) and not (img.width == nil) and not (bh == nil) and not (img.height == nil) then
                xw = math.min(math.max(math.floor(bw * x), 1), #img.pixels)
                yh = math.min(math.max(math.floor(bh * y), 1), #img.pixels[xw])

                pixel = img.pixels[xw][yh]
                col = mostNerColor(pixel.R, pixel.G, pixel.B)

                thx = x
                thy = y
                mir = mirror[current]

                if (mir == 1) then
                    thx = w - thx
                    thy = thy
                elseif (mir == 2) then
                    thx = thx
                    thy = h - thy
                elseif (mir == 3) then
                    thx = w - thx
                    thy = h - thy
                end

                if (roted[current]) then
                    bf = thx
                    thx = thy
                    thy = bf
                end

                term.setCursorPos(thx, thy)

                term.setBackgroundColour(col)
                term.write(" ")
            end
        end
    end

    term.setBackgroundColour(colors.white)
end

local function nextImage()
    current = current + 1;
    if (current > #images) then
        current = 1
    end
    update()
end

local function backImage()
    current = current - 1;
    if (current < 1) then
        current = #images - 1
    end
    update()
end

clear()
update()

while true do
    --[[    local _, key = os.pullEvent("key")
        if key == keys.left then
            backImage()
        elseif key == keys.right then
            nextImage()
        end]]

    os.sleep(speed)
    nextImage()
end
