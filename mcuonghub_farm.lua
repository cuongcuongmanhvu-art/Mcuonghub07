-- [[ MENU HACK GROW A GARDEN BY MCUONGHUB - VERSION ULTIMATE 2026 ]] --
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("McuongHubGarden") then CoreGui.McuongHubGarden:Destroy() end

-- Giao diện Cyberpunk mở rộng (Tăng chiều cao lên 480 để chứa thêm nút)
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "McuongHubGarden"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 260, 0, 480) 
MainFrame.Position = UDim2.new(0, 30, 0, 100)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
MainFrame.BorderSizePixel = 2
MainFrame.Active = true
MainFrame.Draggable = true

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "⚡ mcuonghub ULTIMATE v3 ⚡"
Title.TextSize = 15
Title.Font = Enum.Font.Code
Title.TextColor3 = Color3.fromRGB(0, 255, 0)
Title.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Title.BorderColor3 = Color3.fromRGB(0, 255, 0)

-- Cấu hình trạng thái bật/tắt Hack
_G.isGodMode = false
_G.isAutoHarvest = false
_G.isAutoPlant = false
_G.isAutoSellToken = false
_G.isAutoUpPet = false
_G.isAutoOpenBooth = false
_G.isSpeedHack = false
_G.isInfJump = false

local function createButton(text, yPos, callback)
    local Btn = Instance.new("TextButton", MainFrame)
    Btn.Size = UDim2.new(1, -20, 0, 28)
    Btn.Position = UDim2.new(0, 10, 0, yPos)
    Btn.Text = text
    Btn.Font = Enum.Font.SourceSansBold
    Btn.TextSize = 13
    Btn.TextColor3 = Color3.fromRGB(0, 255, 0)
    Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Btn.BorderColor3 = Color3.fromRGB(0, 255, 0)
    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

local function toggleColor(btn, state)
    btn.BackgroundColor3 = state and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(30, 30, 30)
end

--- ==================== CÁC NÚT BẤM CHỨC NĂNG ==================== ---

-- 1. Bất Tử Nước
local godBtn; godBtn = createButton("🛡️ Bất Tử Nước: OFF", 50, function()
    _G.isGodMode = not _G.isGodMode
    godBtn.Text = _G.isGodMode and "🛡️ Bất Tử Nước: ON" or "🛡️ Bất Tử Nước: OFF"
    toggleColor(godBtn, _G.isGodMode)
end)

-- 2. Auto Gieo Hạt
local plantBtn; plantBtn = createButton("🌱 Auto Gieo Hạt: OFF", 90, function()
    _G.isAutoPlant = not _G.isAutoPlant
    plantBtn.Text = _G.isAutoPlant and "🌱 Auto Gieo Hạt: ON" or "🌱 Auto Gieo Hạt: OFF"
    toggleColor(plantBtn, _G.isAutoPlant)
end)

-- 3. Auto Thu Hoạch
local harvestBtn; harvestBtn = createButton("🤖 Auto Thu Hoạch: OFF", 130, function()
    _G.isAutoHarvest = not _G.isAutoHarvest
    harvestBtn.Text = _G.isAutoHarvest and "🤖 Auto Thu Hoạch: ON" or "🤖 Auto Thu Hoạch: OFF"
    toggleColor(harvestBtn, _G.isAutoHarvest)
end)

-- 4. [NEW] Auto Bán Đồ Sang Token Grow
local tokenBtn; tokenBtn = createButton("🪙 Auto Bán Đồ Sang Token: OFF", 170, function()
    _G.isAutoSellToken = not _G.isAutoSellToken
    tokenBtn.Text = _G.isAutoSellToken and "🪙 Auto Bán Đồ Sang Token: ON" or "🪙 Auto Bán Đồ Sang Token: OFF"
    toggleColor(tokenBtn, _G.isAutoSellToken)
end)

-- 5. [NEW] Auto Nâng Cấp Pet (Up Pet)
local petBtn; petBtn = createButton("🐾 Auto Up Pet Liên Tục: OFF", 210, function()
    _G.isAutoUpPet = not _G.isAutoUpPet
    petBtn.Text = _G.isAutoUpPet and "🐾 Auto Up Pet Liên Tục: ON" or "🐾 Auto Up Pet Liên Tục: OFF"
    toggleColor(petBtn, _G.isAutoUpPet)
end)

-- 6. [NEW] Auto Mở Quầy Hàng (Chợ Đêm/Booth)
local boothBtn; boothBtn = createButton("🎪 Auto Mở Quầy Hàng: OFF", 250, function()
    _G.isAutoOpenBooth = not _G.isAutoOpenBooth
    boothBtn.Text = _G.isAutoOpenBooth and "🎪 Auto Mở Quầy Hàng: ON" or "🎪 Auto Mở Quầy Hàng: OFF"
    toggleColor(boothBtn, _G.isAutoOpenBooth)
end)

-- 7. Tăng Tốc Độ Chạy
local speedBtn; speedBtn = createButton("⚡ Chạy Siêu Tốc: OFF", 290, function()
    _G.isSpeedHack = not _G.isSpeedHack
    speedBtn.Text = _G.isSpeedHack and "⚡ Chạy Siêu Tốc: ON" or "⚡ Chạy Siêu Tốc: OFF"
    toggleColor(speedBtn, _G.isSpeedHack)
    LocalPlayer.Character.Humanoid.WalkSpeed = _G.isSpeedHack and 100 or 16
end)

-- 8. Nhảy Vô Hạn
local jumpBtn; jumpBtn = createButton("🦘 Nhảy Vô Hạn: OFF", 330, function()
    _G.isInfJump = not _G.isInfJump
    jumpBtn.Text = _G.isInfJump and "🦘 Nhảy Vô Hạn: ON" or "🦘 Nhảy Vô Hạn: OFF"
    toggleColor(jumpBtn, _G.isInfJump)
end)

-- 9. Nút Cộng Điểm Test
createButton("➕ Cộng +1000 Điểm", 370, function()
    local stats = LocalPlayer:FindFirstChild("leaderstats")
    if stats then
        local score = stats:FindFirstChild("Score") or stats:FindFirstChild("Coins") or stats:FindFirstChild("Tokens")
        if score then score.Value = score.Value + 1000 end
    end
end)

-- Nhảy vô hạn hệ thống
game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.isInfJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

--- ==================== VÒNG LẶP HỆ THỐNG AUTO (LOOP) ==================== ---
task.spawn(function()
    while task.wait(1) do
        if not ScreenGui or not ScreenGui.Parent then break end
        
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local Garden = workspace:FindFirstChild("Plots") or workspace:FindFirstChild("Garden") or workspace:FindFirstChild("PlayerPlots")
        
        -- Vòng lặp nông trại (Nước, Trồng, Thu Hoạch)
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
        
        -- [MỚI V3] - Auto Bán Nông Sản Đổi Thành Token Grow
        if _G.isAutoSellToken then
            local tokenRemote = ReplicatedStorage:FindFirstChild("SellToken") or ReplicatedStorage:FindFirstChild("TokenSell") or ReplicatedStorage:FindFirstChild("SellAllTokens")
            if tokenRemote then 
                tokenRemote:FireServer() 
            else
                -- Phương án dự phòng nếu game dùng chung Remote Sell nhưng truyền tham số
                local generalSell = ReplicatedStorage:FindFirstChild("Sell") or ReplicatedStorage:FindFirstChild("SellAll")
                if generalSell then generalSell:FireServer("Token") end
            end
        end

        -- [MỚI V3] - Auto Nâng Cấp Pet (Up Pet) liên tục khi đủ tiền/token
        if _G.isAutoUpPet then
            local petRemote = ReplicatedStorage:FindFirstChild("UpgradePet") or ReplicatedStorage:FindFirstChild("PetUpgrade") or ReplicatedStorage:FindFirstChild("LevelUpPet")
            if petRemote then petRemote:FireServer() end
        end

        -- [MỚI V3] - Auto Mở Quầy Hàng (Booth/Shop) để bán cho người chơi khác
        if _G.isAutoOpenBooth then
            local boothRemote = ReplicatedStorage:FindFirstChild("OpenBooth") or ReplicatedStorage:FindFirstChild("ClaimBooth") or ReplicatedStorage:FindFirstChild("OpenShop")
            if boothRemote then 
                -- Tự động tìm quầy hàng trống gần nhất hoặc quầy của mình để kích hoạt
                local booths = workspace:FindFirstChild("Booths") or workspace:FindFirstChild("Shops")
                if booths then
                    for _, booth in pairs(booths:GetChildren()) do
                        boothRemote:FireServer(booth)
                    end
                else
                    boothRemote:FireServer()
                end
            end
        end
    end
end)

-- CHỐNG TREO MÁY (ANTI-AFK)
local VirtualUser = game:GetService("VirtualUser")
Players.LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new(0,0))
end)
