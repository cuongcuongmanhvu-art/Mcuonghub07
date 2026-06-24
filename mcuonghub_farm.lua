-- [[ MCUONGHUB ULTIMATE HUB V4 - UI LIBRARY STYLE ]] --
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- Khởi tạo Cửa sổ Menu chính
local Window = Fluent:CreateWindow({
    Title = "⚡ mcuonghub HUB v4 ⚡",
    SubTitle = "by cuongcuongmanhvu-art",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 420),
    Acrylic = true, -- Làm mờ nền phía sau menu (nhìn rất sang)
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Bấm nút Ctrl trái để ẩn/hiện menu nhanh
})

-- Cấu hình các biến trạng thái
_G.isGodMode = false
_G.isAutoHarvest = false
_G.isAutoPlant = false
_G.isAutoSellToken = false
_G.isAutoUpPet = false
_G.isAutoOpenBooth = false

-- ==================== TẠO CÁC BẢNG MENU CHỌN (TABS) ==================== --
local Tabs = {
    MainFarm = Window:AddTab({ Title = "🌱 Tự Động Farm", Icon = "home" }),
    Economy = Window:AddTab({ Title = "💰 Kinh Tế & Pet", Icon = "dollar-sign" }),
    PlayerMod = Window:AddTab({ Title = "⚡ Nhân Vật", Icon = "user" })
}

-- ----------------------------------------------------------------------------
-- [TAB 1: TỰ ĐỘNG FARM]
-- ----------------------------------------------------------------------------
Tabs.MainFarm:AddParagraph({
    Title = "Hệ Thống Trồng Trọt",
    Content = "Bật các tính năng bên dưới để tự động hóa khu vườn của bạn."
})

Tabs.MainFarm:AddToggle("ToggleGodMode", {
    Title = "🛡️ Bất Tử Nước (Khóa 100%)",
    Default = false,
    Callback = function(Value) _G.isGodMode = Value end
})

Tabs.MainFarm:AddToggle("ToggleAutoPlant", {
    Title = "🌱 Auto Gieo Hạt (Trồng Cây)",
    Default = false,
    Callback = function(Value) _G.isAutoPlant = Value end
})

Tabs.MainFarm:AddToggle("ToggleAutoHarvest", {
    Title = "🤖 Auto Thu Hoạch Cây Chín",
    Default = false,
    Callback = function(Value) _G.isAutoHarvest = Value end
})

-- ----------------------------------------------------------------------------
-- [TAB 2: KINH TẾ & PET]
-- ----------------------------------------------------------------------------
Tabs.Economy:AddParagraph({
    Title = "Giao Thương & Nâng Cấp",
    Content = "Treo máy bán nông sản và tự động nâng cấp trợ thủ."
})

Tabs.Economy:AddToggle("ToggleSellToken", {
    Title = "🪙 Auto Bán Đồ Đổi Token",
    Default = false,
    Callback = function(Value) _G.isAutoSellToken = Value end
})

Tabs.Economy:AddToggle("ToggleUpPet", {
    Title = "🐾 Auto Nâng Cấp Cấp Độ Pet",
    Default = false,
    Callback = function(Value) _G.isAutoUpPet = Value end
})

Tabs.Economy:AddToggle("ToggleOpenBooth", {
    Title = "🎪 Auto Chiếm & Mở Quầy Hàng",
    Default = false,
    Callback = function(Value) _G.isAutoOpenBooth = Value end
})

-- ----------------------------------------------------------------------------
-- [TAB 3: NHÂN VẬT]
-- ----------------------------------------------------------------------------
Tabs.PlayerMod:AddSlider("SliderSpeed", {
    Title = "⚡ Tốc Độ Chạy (WalkSpeed)",
    Description = "Kéo để thay đổi tốc độ di chuyển nhân vật",
    Default = 16, Min = 16, Max = 200, Rounding = 0,
    Callback = function(Value)
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end
})

Tabs.PlayerMod:AddSlider("SliderJump", {
    Title = "🦘 Sức Nhảy (JumpPower)",
    Description = "Kéo để nhảy cao hơn",
    Default = 50, Min = 50, Max = 300, Rounding = 0,
    Callback = function(Value)
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
        end
    end
})

Tabs.PlayerMod:AddButton({
    Title = "➕ Nhận +1000 Điểm Thử Nghiệm",
    Description = "Bấm để test cộng chỉ số hệ thống",
    Callback = function()
        local stats = game.Players.LocalPlayer:FindFirstChild("leaderstats")
        if stats then
            local score = stats:FindFirstChild("Score") or stats:FindFirstChild("Coins") or stats:FindFirstChild("Tokens")
            if score then score.Value = score.Value + 1000 end
        end
    end
})

-- ==================== VÒNG LẶP HỆ THỐNG LUỒNG NGẦM ==================== --
task.spawn(function()
    while task.wait(1) do
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local Garden = workspace:FindFirstChild("Plots") or workspace:FindFirstChild("Garden") or workspace:FindFirstChild("PlayerPlots")
        
        -- Xử lý Farm cây
        if Garden then
            for _, plot in pairs(Garden:GetChildren()) do
                if _G.isGodMode and plot:FindFirstChild("Water") then pcall(function() plot.Water.Value = 100 end) end
                if _G.isAutoPlant and plot:FindFirstChild("Stage") and plot.Stage.Value == 0 then
                    local plantRemote = ReplicatedStorage:FindFirstChild("Plant") or ReplicatedStorage:FindFirstChild("PlantSeed")
                    if plantRemote then plantRemote:FireServer(plot, "Tomato") end 
                end
                if _G.isAutoHarvest and plot:FindFirstChild("Stage") and (plot.Stage.Value == 4 or plot.Stage.Value == "Ripe") then
                    local harvestRemote = ReplicatedStorage:FindFirstChild("Harvest") or plot:FindFirstChild("HarvestEvent")
                    if harvestRemote then harvestRemote:FireServer(plot) end
                end
            end
        end
        
        -- Xử lý Kinh tế
        if _G.isAutoSellToken then
            local tokenRemote = ReplicatedStorage:FindFirstChild("SellToken") or ReplicatedStorage:FindFirstChild("TokenSell") or ReplicatedStorage:FindFirstChild("SellAllTokens")
            if tokenRemote then tokenRemote:FireServer() else
                local generalSell = ReplicatedStorage:FindFirstChild("Sell") or ReplicatedStorage:FindFirstChild("SellAll")
                if generalSell then generalSell:FireServer("Token") end
            end
        end
        if _G.isAutoUpPet then
            local petRemote = ReplicatedStorage:FindFirstChild("UpgradePet") or ReplicatedStorage:FindFirstChild("PetUpgrade") or ReplicatedStorage:FindFirstChild("LevelUpPet")
            if petRemote then petRemote:FireServer() end
        end
        if _G.isAutoOpenBooth then
            local boothRemote = ReplicatedStorage:FindFirstChild("OpenBooth") or ReplicatedStorage:FindFirstChild("ClaimBooth") or ReplicatedStorage:FindFirstChild("OpenShop")
            if boothRemote then 
                local booths = workspace:FindFirstChild("Booths") or workspace:FindFirstChild("Shops")
                if booths then
                    for _, booth in pairs(booths:GetChildren()) do boothRemote:FireServer(booth) end
                else boothRemote:FireServer() end
            end
        end
    end
end)

-- CHỐNG TREO MÁY (ANTI-AFK TRÁNH BỊ KICK)
local VirtualUser = game:GetService("VirtualUser")
game.Players.LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new(0,0))
end)

-- Thông báo góc màn hình khi hack load thành công
Fluent:Notify({
    Title = "mcuonghub v4",
    Content = "Script đã kích hoạt thành công bảng chọn!",
    Duration = 5
})
