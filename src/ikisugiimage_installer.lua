local function get(sUrl)
    local ok, err = http.checkURL(sUrl)
    if not ok then
        printError(err or "Invalid URL.")
        return
    end

    write("Connecting to " .. sUrl .. "... ")

    local response = http.get(sUrl, nil, true)
    if not response then
        print("Failed.")
        return nil
    end

    print("Success.")

    local sResponse = response.readAll()
    response.close()
    return sResponse or ""
end

local function download(url, name, path)
    local sFile = name
    local sPath = shell.resolve(path .. sFile)
    if fs.exists(sPath) then
        print("File already exists")
        return
    end

    local res = get(url)
    if not res then
        return
    end

    local file, err = fs.open(sPath, "wb")
    if not file then
        printError("Cannot save file: " .. err)
        return
    end

    file.write(res)
    file.close()

    print("Downloaded as " .. sFile)
end

download("https://raw.githubusercontent.com/MORIMORI0317/IkisugiImage/main/src/ikisugiimage.lua", "ikisugiimage.lua", "./")
download("https://raw.githubusercontent.com/AlberTajuelo/bitop-lua/master/src/bitop/funcs.lua", "funcs.lua", "./")
download("https://raw.githubusercontent.com/Didericis/png-lua/master/png.lua", "png.lua", "./")
download("https://raw.githubusercontent.com/Didericis/png-lua/master/deflatelua.lua", "deflatelua.lua", "./")


download("https://github.com/MORIMORI0317/IkisugiImage/raw/main/src/images/fcoh.png", "fcoh.png", "./images/")
download("https://github.com/MORIMORI0317/IkisugiImage/raw/main/src/images/gban.png", "gban.png", "./images/")
download("https://github.com/MORIMORI0317/IkisugiImage/raw/main/src/images/ikisugi.png", "ikisugi.png", "./images/")
download("https://github.com/MORIMORI0317/IkisugiImage/raw/main/src/images/katyou.png", "katyou.png", "./images/")
download("https://github.com/MORIMORI0317/IkisugiImage/raw/main/src/images/yj.png", "yj.png", "./images/")
download("https://github.com/MORIMORI0317/IkisugiImage/raw/main/src/images/77.png", "77.png", "./images/")
download("https://github.com/MORIMORI0317/IkisugiImage/raw/main/src/images/bnkn.png", "bnkn.png", "./images/")
download("https://github.com/MORIMORI0317/IkisugiImage/raw/main/src/images/dokata.png", "dokata.png", "./images/")
download("https://github.com/MORIMORI0317/IkisugiImage/raw/main/src/images/kbtit.png", "kbtit.png", "./images/")
download("https://github.com/MORIMORI0317/IkisugiImage/raw/main/src/images/nikuoja.png", "nikuoja.png", "./images/")