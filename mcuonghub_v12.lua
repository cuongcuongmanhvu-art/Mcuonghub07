--[[
    MCUONGHUB HUB V5: THE NEXT GEN
    UI Style: Speed Hub / Modern Dark
    Game: Grow a Garden
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer

-- 1. XÓA UI CŨ
if Player.PlayerGui:FindFirstChild("McuonghubV5") then Player.PlayerGui.McuonghubV5:Destroy() end

local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "McuonghubV5"

-- MAIN FRAME
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 550, 0, 380)
Main.Position = UDim2.new(0.5, -275, 0.4, -190)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
local MainCorner = Instance.new("UICorner", Main)
MainCorner.CornerRadius = UDim.new(0, 12)

-- TOP BAR (Giống ảnh)
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", TopBar)
Title.Text = "⚡ mcuonghub HUB v5: THE NEXT GEN ⚡"
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 180, 50)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

-- TAB CONTAINER (Giống ảnh)
local TabBar = Instance.new("Frame", Main)
TabBar.Size = UDim2.new(1, -20, 0, 45)
TabBar.Position = UDim2.new(0, 10, 0, 55)
TabBar.BackgroundTransparency = 1

local UIListTab = Instance.new("UIListLayout", TabBar)
UIListTab.FillDirection = Enum.FillDirection.Horizontal
UIListTab.Padding = UDim.new(0, 10)

local function CreateTab(name, icon, isSelected)
    local btn = Instance.new("TextButton", TabBar)
    btn.Text = icon .. " " .. name
    btn.Size = UDim2.new(0, 120, 1, 0)
    btn.BackgroundColor3 = isSelected and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(35, 35, 35)
    btn.TextColor3 = isSelected and Color3.new(1, 1, 1) or Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 20) -- Bo tròn cực mạnh giống ảnh
    return btn
end

local TabFarm = CreateTab("Trồng Trọt", "🌱", true)
local TabTrade = CreateTab("Giao Thương", "💰", false)
local TabPet = CreateTab("Thú Cưng", "🐾", false)

-- CONTENT AREA
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -30, 1, -120)
Content.Position = UDim2.new(0, 15, 0, 110)
Content.BackgroundTransparency = 1

-- DROPDOWN (Giống ảnh bạn gửi)
local function CreateDropdown(title, items, callback)
    local DropFrame = Instance.new("Frame", Content)
    DropFrame.Size = UDim2.new(1, 0, 0, 45)
    DropFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    local c = Instance.new("UICorner", DropFrame)

    local dTitle = Instance.new("TextLabel", DropFrame)
    dTitle.Text = "🎯 " .. title
    dTitle.Size = UDim2.new(1, -50, 1, 0)
    dTitle.Position = UDim2.new(0, 10, 0, 0)
    dTitle.TextColor3 = Color3.new(1, 1, 1)
    dTitle.TextXAlignment = Enum.TextXAlignment.Left
    dTitle.BackgroundTransparency = 1

    local arrow = Instance.new("TextLabel", DropFrame)
    arrow.Text = "∧"
    arrow.Size = UDim2.new(0, 40, 1, 0)
    arrow.Position = UDim2.new(1, -40, 0, 0)
    arrow.TextColor3 = Color3.new(1,1,1)
    arrow.BackgroundTransparency = 1

    local itemHolder = Instance.new("Frame", Content)
    itemHolder.Size = UDim2.new(1, 0, 0, 0)
    itemHolder.ClipsDescendants = true
    itemHolder.Visible = false
    itemHolder.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    local uil = Instance.new("UIListLayout", itemHolder)

    DropFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            itemHolder.Visible = not itemHolder.Visible
            itemHolder.Size = itemHolder.Visible and UDim2.new(1, 0, 0, #items * 35) or UDim2.new(1, 0, 0, 0)
        end
    end)

    for _, itemName in pairs(items) do
        local iBtn = Instance.new("TextButton", itemHolder)
        iBtn.Text = itemName
        iBtn.Size = UDim2.new(1, 0, 0, 35)
        iBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        iBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        iBtn.BorderSizePixel = 0
        iBtn.MouseButton1Click:Connect(function()
            dTitle.Text = "🎯 " .. title .. ": " .. itemName
            itemHolder.Visible = false
            itemHolder.Size = UDim2.new(1, 0, 0, 0)
            callback(itemName)
        end)
    end
end

-- BIẾN LOGIC
_G.SelectedPlant = "Tomato"
_G.SelectedPet = "Chưa chọn"
_G.Price = 1000
_G.AutoClaim = false
_G.AutoSell = false

-- THIẾT LẬP NỘI DUNG (TAB TRỒNG TRỌT)
CreateDropdown("Chọn Loại Cây Muốn Trồng", {"Tomato", "Potato", "Carrot", "Onion"}, function(v) _G.SelectedPlant = v end)

-- THIẾT LẬP NỘI DUNG (TAB GIAO THƯƠNG)
local function CreateToggle(name, callback)
    local btn = Instance.new("TextButton", Content)
    btn.Text = name .. ": OFF"
    btn.Size = UDim2.new(1, 0, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", btn)
    local s = false
    btn.MouseButton1Click:Connect(function()
        s = not s
        btn.Text = name .. ": " .. (s and "ON" or "OFF")
        btn.BackgroundColor3 = s and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
        callback(s)
    end)
end

CreateToggle("Auto Tranh Gian Hàng", function(s) _G.AutoClaim = s end)
CreateToggle("Auto Treo Bán Pet", function(s) _G.AutoSell = s end)

-- LOGIC FIX HOẠT ĐỘNG TRONG GAME
task.spawn(function()
    while task.wait(1.5) do
        if _G.AutoClaim then
            -- Quét Booths trong Grow a Garden
            local Booths = workspace:FindFirstChild("Booths") or workspace:FindFirstChild("Stalls")
            if Booths then
                for _, b in pairs(Booths:GetChildren()) do
                    if b:FindFirstChild("Owner") and b.Owner.Value == "" then
                        -- Tự động tìm lệnh Claim
                        local r = ReplicatedStorage:FindFirstChild("ClaimBooth", true) or ReplicatedStorage:FindFirstChild("Claim", true)
                        if r then 
                            r:FireServer(b) 
                            -- Teleport tới để tránh lỗi khoảng cách
                            Player.Character.HumanoidRootPart.CFrame = b.PrimaryPart.CFrame * CFrame.new(0, 3, 0)
                        end
                        break
                    end
                end
            end
        end

        if _G.AutoSell and _G.SelectedPet ~= "Chưa chọn" then
            -- Tự động tìm lệnh ListPet
            local r = ReplicatedStorage:FindFirstChild("ListPet", true) or ReplicatedStorage:FindFirstChild("SellPet", true)
            if r then r:FireServer(_G.SelectedPet, _G.Price) end
        end
    end
end)
