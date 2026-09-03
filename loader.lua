-- [[ FahriRoundopHUB - HOOKED! [TRAIT] EDITION ]] --
local BaseURL = "https://raw.githubusercontent.com/FahriSetiawan69/Hooked/main/"
local StarterGui = game:GetService("StarterGui")

-- 1. Notifikasi Loading
StarterGui:SetCore("SendNotification", {
    Title = "FahriRoundopHUB",
    Text = "Hooked! Script Loading...",
    Duration = 4
})

-- 2. Logika Pemanggilan HomeGui
local function StartHub()
    local targetURL = BaseURL .. "HomeGui.lua"
    local success, content = pcall(function()
        return game:HttpGet(targetURL)
    end)

    if success and content then
        local func, err = loadstring(content)
        if func then
            print("[FR-HUB] Hooked! HomeGui Terdeteksi! Menjalankan...")
            func()
        else
            warn("[FR-HUB] Error Compile: " .. tostring(err))
        end
    else
        warn("[FR-HUB] HTTP 404: File tidak ditemukan di " .. targetURL)
    end
end

task.spawn(StartHub)
