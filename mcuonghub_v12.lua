--[[
    MCUONGHUB HUB V5: THE NEXT GEN
    Style: Speed Hub (Modern UI)
    Features: Auto Claim, Auto Sell, Pet Dropdown Selection
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer

-- 1. XÓA UI CŨ
if Player.PlayerGui:FindFirstChild("McuonghubV5") then
    Player.PlayerGui.McuonghubV5:Destroy()
end

-- 2. TẠO GIAO DIỆN CHÍNH
local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "McuonghubV5"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 500, 0, 350)
Main.Position = UDim2.new(0.5, -250, 0.4, -175)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- HEADER (Tiêu đề giống ảnh bạn gửi)
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Header.BorderSizePixel = 0
Instance.new("UICorner", Header)

local Title = Instance.new("TextLabel", Header)
Title.Text = "⚡ mcuonghub HUB v5: THE NEXT GEN ⚡"
Title.Size = UDim2.new(1, 0, 1, 0)
Title.TextColor3 = Color3.fromRGB(255, 180, 50)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.BackgroundTransparency = 1

-- TABS NAVIGATION
local TabFrame = Instance.new("Frame", Main)
TabFrame.Size = UDim2.new(1, -20, 0, 40)
TabFrame.Position = UDim2.new(0, 10, 0, 50)
TabFrame.BackgroundTransparency = 1

local UIList = Instance.new("UIListLayout", TabFrame)
UIList.FillDirection = Enum.FillDirection.Horizontal
UIList.Padding = UDim.new(0, 10)

local function CreateTab(name, icon)
    local btn = Instance.new("TextButton", TabFrame)
    btn.Text = icon .. " " .. name
    btn.Size = UDim2.new(0, 110, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", btn)
    return btn
end

local TabTrade = CreateTab("Giao Thương", "💰")
local TabPet = CreateTab("Thú Cưng", "🐾")

-- CONTAINER CHỨA NỘI DUNG
local Container = Instance.new("ScrollingFrame", Main)
Container.Size = UDim2.new(1, -20, 1, -110)
Container.Position = UDim2.new(0, 10, 0, 100)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 2

local UIListCont = Instance.new("UIListLayout", Container)
UIListCont.Padding = UDim.new(0, 10)

-- BIẾN LOGIC
_G.SelectedPet = "Chưa chọn"
_G.AutoClaim = false
_G.AutoSell = false
_G.SellPrice = 1000

-- DROPDOWN (CHỌN LOẠI PET)
local DropdownFrame = Instance.new("Frame", Container)
DropdownFrame.Size = UDim2.new(1, 0, 0, 45)
DropdownFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", DropdownFrame)

local DropTitle = Instance.new("TextLabel", DropdownFrame)
DropTitle.Text = "🎯 Chọn Loại Pet Muốn Bán: " .. _G.SelectedPet
DropTitle.Size = UDim2.new(1, -10, 1, 0)
DropTitle.Position = UDim2.new(0, 10, 0, 0)
DropTitle.TextColor3 = Color3.new(1,1,1)
DropTitle.TextXAlignment = Enum.TextXAlignment.Left
DropTitle.BackgroundTransparency = 1

local DropBtn = Instance.new("TextButton", DropdownFrame)
DropBtn.Text = "▼"
DropBtn.Size = UDim2.new(0, 40, 1, 0)
DropBtn.Position = UDim2.new(1, -40, 0, 0)
DropBtn.BackgroundTransparency = 1
DropBtn.TextColor3 = Color3.new(1,1,1)

local ItemList = Instance.new("Frame", Container)
ItemList.Size = UDim2.new(1, 0, 0, 0)
ItemList.ClipsDescendants = true
ItemList.Visible = false
ItemList.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

local UIListItems = Instance.new("UIListLayout", ItemList)

-- Hàm cập nhật danh sách Pet tự động
local function UpdatePetList()
    for _, child in pairs(ItemList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end

    -- Tìm thư mục Pet của game (thường nằm trong Player hoặc ReplicatedStorage)
    local petPath = Player:FindFirstChild("Pets") or Player:FindFirstChild("Inventory")
    local pets = {}
    
    if petPath then
        for _, p in pairs(petPath:GetChildren()) do table.insert(pets, p.Name) end
    else
        -- Nếu không tìm thấy, tạo danh sách mẫu
        pets = {"Dog", "Cat", "Dragon", "Unicorn", "Tomato Pet"}
    end

    for _, name in pairs(pets) do
        local pBtn = Instance.new("TextButton", ItemList)
        pBtn.Text = name
        pBtn.Size = UDim2.new(1, 0, 0, 35)
        pBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        pBtn.TextColor3 = Color3.new(0.8, 0.8, 0.8)
        pBtn.MouseButton1Click:Connect(function()
            _G.SelectedPet = name
            DropTitle.Text = "🎯 Chọn Loại Pet Muốn Bán: " .. name
            ItemList.Visible = false
            ItemList.Size = UDim2.new(1, 0, 0, 0)
        end)
    end
end

DropBtn.MouseButton1Click:Connect(function()
    UpdatePetList()
    ItemList.Visible = not ItemList.Visible
    ItemList.Size = ItemList.Visible and UDim2.new(1, 0, 0, 120) or UDim2.new(1, 0, 0, 0)
end)

-- INPUT GIÁ
local PriceInput = Instance.new("TextBox", Container)
PriceInput.PlaceholderText = "Nhập số Token muốn bán (VD: 5000)..."
PriceInput.Size = UDim2.new(1, 0, 0, 40)
PriceInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
PriceInput.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", PriceInput)
PriceInput.FocusLost:Connect(function() _G.SellPrice = tonumber(PriceInput.Text) or 1000 end)

-- TOGGLE
local function CreateToggle(name, callback)
    local btn = Instance.new("TextButton", Container)
    btn.Text = name .. ": OFF"
    btn.Size = UDim2.new(1, 0, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", btn)

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = name .. ": " .. (state and "ON" or "OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
        callback(state)
    end)
end

CreateToggle("Auto Tranh Gian Hàng", function(s) _G.AutoClaim = s end)
CreateToggle("Auto Treo Bán Pet Đã Chọn", function(s) _G.AutoSell = s end)

-- LOGIC TREO MÁY
task.spawn(function()
    while task.wait(2) do
        if _G.AutoClaim then
            local Booths = workspace:FindFirstChild("Booths")
            if Booths then
                for _, b in pairs(Booths:GetChildren()) do
                    if b:FindFirstChild("Owner") and b.Owner.Value == "" then
                        local r = ReplicatedStorage:FindFirstChild("ClaimBooth", true)
                        if r then r:FireServer(b) end
                        break
                    end
                end
            end
        end

        if _G.AutoSell and _G.SelectedPet ~= "Chưa chọn" then
            local r = ReplicatedStorage:FindFirstChild("ListPet", true)
            if r then r:FireServer(_G.SelectedPet, _G.SellPrice) end
        end
    end
end)
