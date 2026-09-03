-- [[ FahriRoundopHUB - Hooked! [TRAIT] Official Home UI ]] --
local CoreGui = game:GetService("CoreGui")
local BaseURL = "https://raw.githubusercontent.com/FahriSetiawan69/Hooked/main/"

-- 1. ANTI-DUPLICATE (Pembersihan agar tidak bentrok)
if CoreGui:FindFirstChild("FR_Hooked_MobileToggle") then CoreGui.FR_Hooked_MobileToggle:Destroy() end
if CoreGui:FindFirstChild("Fluent") then CoreGui.Fluent:Destroy() end

-- Global Fluent Library
_G.Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- 2. WINDOW SETUP
local Window = _G.Fluent:CreateWindow({
    Title = "FahriRoundopHUB",
    SubTitle = "Hooked! [TRAIT] Edition",
    TabWidth = 160, 
    Size = UDim2.fromOffset(450, 300),
    Acrylic = true, 
    Theme = "Dark", 
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- 3. MOBILE TOGGLE SYNC (Tombol melayang untuk Delta Mobile)
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "FR_Hooked_MobileToggle"
ScreenGui.Enabled = false

local ToggleButton = Instance.new("ImageButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 48, 0, 48)
ToggleButton.Position = UDim2.new(0.02, 0, 0.45, 0)
ToggleButton.Image = "rbxassetid://4483345998"
ToggleButton.Draggable = true
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 12)

local OriginalMinimize = Window.Minimize
Window.Minimize = function(self)
    OriginalMinimize(self)
    ScreenGui.Enabled = Window.Minimized 
end

ToggleButton.MouseButton1Click:Connect(function() Window:Minimize() end)

-- 4. TABS SETUP
local Tabs = {
    Main = Window:AddTab({ Title = "Combat / Main", Icon = "crosshair" }),
    Visuals = Window:AddTab({ Title = "Visuals & ESP", Icon = "eye" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- 5. FEATURES IMPLEMENTATION (Modular Architecture)

-- --- FITUR 1: SILENT AIM / PREDICTION HOOK ---
Tabs.Main:AddToggle("SilentAimToggle", {
    Title = "Silent Aim (Auto Hook)", 
    Default = false,
    Description = "Mengarahkan kail secara otomatis ke target."
}):OnChanged(function(v)
    local success, err = pcall(function()
        loadstring(game:HttpGet(BaseURL .. "Features/SilentAim.lua"))()
        if _G.Hooked_SilentAim then 
            _G.Hooked_SilentAim:Toggle(v) 
        end
    end)
    
    if not success then
        warn("[FR-HUB] Gagal memuat SilentAim: " .. tostring(err))
    end
end)

-- --- FITUR 2: PLAYER ESP ---
Tabs.Visuals:AddToggle("ESPToggle", {
    Title = "Player ESP", 
    Default = false,
    Description = "Menampilkan posisi pemain lain melalui tembok."
}):OnChanged(function(v)
    local success, err = pcall(function()
        loadstring(game:HttpGet(BaseURL .. "Features/ESP.lua"))()
        if _G.Hooked_ESP then 
            _G.Hooked_ESP:Toggle(v) 
        end
    end)
    
    if not success then
        warn("[FR-HUB] Gagal memuat ESP: " .. tostring(err))
    end
end)

-- 6. CLEANUP (Saat GUI di-close)
CoreGui.ChildRemoved:Connect(function(child)
    if child.Name == "Fluent" then
        ScreenGui:Destroy()
        _G.Hooked_SilentAim = nil
        _G.Hooked_ESP = nil
        _G.Fluent = nil
    end
end)

-- Notifikasi Pemuatan Berhasil
_G.Fluent:Notify({
    Title = "Hooked! Hub Loaded",
    Content = "Script siap digunakan di Delta Mobile.",
    Duration = 5
})

Window:SelectTab(1)
