--[[
    MCUONGHUB HUB V5: THE NEXT GEN
    Bản quyền thuộc về Mcuonghub
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer

-- 1. TẠO GIAO DIỆN CHUẨN SPEED HUB
if Player.PlayerGui:FindFirstChild("McuonghubV5") then Player.PlayerGui.McuonghubV5:Destroy() end
local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui); ScreenGui.Name = "McuonghubV5"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 520, 0, 360)
Main.Position = UDim2.new(0.5, -260, 0.4, -180)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)

-- HEADER
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
Instance.new("UICorner", Header)

local Title = Instance.new("TextLabel", Header)
Title.Text = "⚡ mcuonghub HUB v5: THE NEXT GEN ⚡"
Title.Size = UDim2.new(1, -50, 1, 0)
Title.TextColor3 = Color3.fromRGB(255, 170, 0)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.BackgroundTransparency = 1

-- THANH TABS (Giống ảnh bạn gửi)
local TabFrame = Instance.new("Frame", Main)
TabFrame.Size = UDim2.new(1, -20, 0, 40)
TabFrame.Position = UDim2.new(0, 10, 0, 55)
TabFrame.BackgroundTransparency = 1

local UIList = Instance.new("UIListLayout", TabFrame)
UIList.FillDirection = Enum.FillDirection.Horizontal
UIList.Padding = UDim.new(0, 8)

-- BIẾN ĐIỀU KHIỂN
_G.AutoClaim = false
_G.AutoSell = false
_G.SelectedPet = "Chọn Pet..."
_G.Price = 1000

local function CreateTab(name, icon)
    local b = Instance.new("TextButton", TabFrame)
    b.Text = icon .. " " .. name
    b.Size = UDim2.new(0, 110, 1, 0)
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", b)
    return b
end

local Tab1 = CreateTab("Trồng Trọt", "🌱")
local Tab2 = CreateTab("Giao Thương", "💰")

-- NỘI DUNG TABS
local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, -20, 1, -120)
Container.Position = UDim2.new(0, 10, 0, 105)
Container.BackgroundTransparency = 1

local UIListCont = Instance.new("UIListLayout", Container)
UIListCont.Padding = UDim.new(0, 10)

-- DROPDOWN (CHỌN PET)
local Dropdown = Instance.new("TextButton", Container)
Dropdown.Text = "🎯 " .. _G.SelectedPet .. " ▽"
Dropdown.Size = UDim2.new(1, 0, 0, 45)
Dropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Dropdown.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Dropdown)

local PetList = Instance.new("ScrollingFrame", Container)
PetList.Size = UDim2.new(1, 0, 0, 0) -- Ẩn ban đầu
PetList.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
PetList.Visible = false
Instance.new("UIListLayout", PetList)

Dropdown.MouseButton1Click:Connect(function()
    PetList.Visible = not PetList.Visible
    PetList.Size = PetList.Visible and UDim2.new(1, 0, 0, 120) or UDim2.new(1, 0, 0, 0)
    
    -- Quét Pet thật trong game
    for _, v in pairs(PetList:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    local pets = {"Dog", "Cat", "Dragon", "Tomato", "Potato", "Carrot"} -- Danh sách mẫu
    for _, name in pairs(pets) do
        local p = Instance.new("TextButton", PetList)
        p.Text = name; p.Size = UDim2.new(1, 0, 0, 35); p.BackgroundColor3 = Color3.fromRGB(45, 45, 45); p.TextColor3 = Color3.new(1,1,1)
        p.MouseButton1Click:Connect(function()
            _G.SelectedPet = name
            Dropdown.Text = "🎯 " .. name .. " ▽"
            PetList.Visible = false
            PetList.Size = UDim2.new(1, 0, 0, 0)
        end)
    end
end)

-- INPUT GIÁ
local PriceInput = Instance.new("TextBox", Container)
PriceInput.PlaceholderText = "Nhập giá Token..."
PriceInput.Size = UDim2.new(1, 0, 0, 45)
PriceInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
PriceInput.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", PriceInput)
PriceInput.FocusLost:Connect(function() _G.Price = tonumber(PriceInput.Text) or 1000 end)

-- TOGGLES
local function CreateToggle(name, callback)
    local t = Instance.new("TextButton", Container)
    t.Text = name .. ": OFF"
    t.Size = UDim2.new(1, 0, 0, 45); t.BackgroundColor3 = Color3.fromRGB(180, 50, 50); t.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", t)
    local s = false
    t.MouseButton1Click:Connect(function()
        s = not s
        t.Text = name .. ": " .. (s and "ON" or "OFF")
        t.BackgroundColor3 = s and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
        callback(s)
    end)
end

CreateToggle("Auto Tranh Hàng", function(s) _G.AutoClaim = s end)
CreateToggle("Auto Bán Pet Đã Chọn", function(s) _G.AutoSell = s end)

-- LOGIC FIX HOẠT ĐỘNG
task.spawn(function()
    while task.wait(1.5) do
        if _G.AutoClaim then
            -- Tự động tìm gian hàng trống trong Grow a Garden
            for _, b in pairs(workspace:GetDescendants()) do
                if (b.Name:find("Booth") or b.Name:find("Stall")) and b:FindFirstChild("Owner") then
                    if b.Owner.Value == "" or b.Owner.Value == nil then
                        -- Gửi lệnh chiếm
                        for _, r in pairs(ReplicatedStorage:GetDescendants()) do
                            if r:IsA("RemoteEvent") and (r.Name:find("Claim") or r.Name:find("Booth")) then
                                r:FireServer(b)
                                break
                            end
                        end
                    end
                end
            end
        end

        if _G.AutoSell and _G.SelectedPet ~= "Chọn Pet..." then
            -- Gửi lệnh bán Pet
            for _, r in pairs(ReplicatedStorage:GetDescendants()) do
                if r:IsA("RemoteEvent") and (r.Name:find("Sell") or r.Name:find("List") or r.Name:find("Post")) then
                    r:FireServer(_G.SelectedPet, _G.Price)
                end
            end
        end
    end
end)
