--[[
    NAME: Mcuonghubv2
    DESCRIPTION: Auto Booth & Auto Sell for Grow a Garden
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer

-- CẤU HÌNH GIAO DIỆN (UI)
local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "Mcuonghubv2"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 280, 0, 320)
Main.Position = UDim2.new(0.5, -140, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.BorderSizePixel = 0

local Title = Instance.new("TextLabel", Main)
Title.Text = "MCƯƠNG HUB V2"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.TextColor3 = Color3.fromRGB(0, 255, 127)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20

-- Ô NHẬP TÊN PET
local PetInput = Instance.new("TextBox", Main)
PetInput.PlaceholderText = "Nhập tên Pet (để trống = bán hết)"
PetInput.Size = UDim2.new(1, -20, 0, 35)
PetInput.Position = UDim2.new(0, 10, 0, 55)
PetInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
PetInput.TextColor3 = Color3.new(1, 1, 1)

-- Ô NHẬP GIÁ TOKEN
local TokenInput = Instance.new("TextBox", Main)
TokenInput.PlaceholderText = "Nhập số Token..."
TokenInput.Size = UDim2.new(1, -20, 0, 35)
TokenInput.Position = UDim2.new(0, 10, 0, 100)
TokenInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TokenInput.TextColor3 = Color3.new(1, 1, 1)

-- NÚT AUTO TRANH HÀNG
local BoothBtn = Instance.new("TextButton", Main)
BoothBtn.Text = "Auto Tranh Gian Hàng: OFF"
BoothBtn.Size = UDim2.new(1, -20, 0, 45)
BoothBtn.Position = UDim2.new(0, 10, 0, 150)
BoothBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
BoothBtn.TextColor3 = Color3.new(1, 1, 1)

-- NÚT AUTO BÁN PET
local SellBtn = Instance.new("TextButton", Main)
SellBtn.Text = "Auto Treo Bán: OFF"
SellBtn.Size = UDim2.new(1, -20, 0, 45)
SellBtn.Position = UDim2.new(0, 10, 0, 210)
SellBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
SellBtn.TextColor3 = Color3.new(1, 1, 1)

-- LOGIC HOẠT ĐỘNG
local activeBooth = false
local activeSell = false

-- Hàm tranh hàng (Cần chỉnh sửa Remote cho đúng game)
local function claimBoothLogic()
    local Booths = workspace:FindFirstChild("Booths") -- Kiểm tra lại đường dẫn workspace
    if Booths then
        for _, b in pairs(Booths:GetChildren()) do
            if b:FindFirstChild("Owner") and b.Owner.Value == nil then
                -- Lệnh can thiệp: Thay 'ClaimEvent' bằng tên thật của game
                -- ReplicatedStorage.Remotes.ClaimEvent:FireServer(b)
                print("Mcuonghubv2: Đang cố gắng chiếm hàng " .. b.Name)
                break
            end
        end
    end
end

-- Hàm bán tất cả pet (Cần chỉnh sửa Remote cho đúng game)
local function sellAllPetsLogic()
    local price = tonumber(TokenInput.Text) or 100
    local targetPet = PetInput.Text
    
    -- Giả định inventory nằm trong Player hoặc ReplicatedStorage
    -- Cần thay thế logic này bằng cách lấy danh sách Pet thật của game
    print("Mcuonghubv2: Đang treo bán pet với giá " .. price .. " Tokens")
    -- Lệnh can thiệp ví dụ:
    -- ReplicatedStorage.Remotes.SellEvent:FireServer(targetPet, price)
end

-- ĐIỀU KHIỂN NÚT BẤM
BoothBtn.MouseButton1Click:Connect(function()
    activeBooth = not activeBooth
    BoothBtn.Text = "Auto Tranh Gian Hàng: " .. (activeBooth and "ON" or "OFF")
    BoothBtn.BackgroundColor3 = activeBooth and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
end)

SellBtn.MouseButton1Click:Connect(function()
    activeSell = not activeSell
    SellBtn.Text = "Auto Treo Bán: " .. (activeSell and "ON" or "OFF")
    SellBtn.BackgroundColor3 = activeSell and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
end)

-- VÒNG LẶP HỆ THỐNG
task.spawn(function()
    while task.wait(3) do -- Quét mỗi 3 giây để tránh giật lag
        if activeBooth then
            claimBoothLogic()
        end
        if activeSell then
            sellAllPetsLogic()
        end
    end
end)
