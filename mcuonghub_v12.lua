--[[
    MCUONGHUB V2 - GROW A GARDEN
    Giao diện: Speed Hub Style
    Tính năng: Auto Claim, Auto Sell All, Pet Selection
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Player = Players.LocalPlayer

-- XÓA UI CŨ ĐỂ TRÁNH LỖI
if Player.PlayerGui:FindFirstChild("Mcuonghubv2") then
    Player.PlayerGui.Mcuonghubv2:Destroy()
end

-- TẠO GIAO DIỆN CHÍNH
local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "Mcuonghubv2"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.4, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 10)

-- THANH SIDEBAR (BÊN TRÁI)
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 140, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Sidebar.BorderSizePixel = 0
local SidebarCorner = Instance.new("UICorner", Sidebar)

local HubTitle = Instance.new("TextLabel", Sidebar)
HubTitle.Text = "MCUONG V2"
HubTitle.Size = UDim2.new(1, 0, 0, 60)
HubTitle.TextColor3 = Color3.fromRGB(0, 255, 150)
HubTitle.Font = Enum.Font.SourceSansBold
HubTitle.TextSize = 22
HubTitle.BackgroundTransparency = 1

-- KHU VỰC NỘI DUNG (BÊN PHẢI)
local Content = Instance.new("Frame", MainFrame)
Content.Position = UDim2.new(0, 150, 0, 10)
Content.Size = UDim2.new(1, -160, 1, -20)
Content.BackgroundTransparency = 1

local ScrollingFrame = Instance.new("ScrollingFrame", Content)
ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.ScrollBarThickness = 4
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1.5, 0)

local UIListLayout = Instance.new("UIListLayout", ScrollingFrame)
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- BIẾN CẤU HÌNH
_G.Config = {
    AutoClaim = false,
    AutoSell = false,
    TargetPet = "",
    Price = 100
}

-- HÀM TẠO NÚT BẤM (TOGGLE)
local function CreateToggle(name, callback)
    local Button = Instance.new("TextButton", ScrollingFrame)
    Button.Text = name .. ": OFF"
    Button.Size = UDim2.new(1, -10, 0, 40)
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.Font = Enum.Font.SourceSansBold
    Button.TextSize = 16
    Instance.new("UICorner", Button)

    local enabled = false
    Button.MouseButton1Click:Connect(function()
        enabled = not enabled
        Button.Text = name .. ": " .. (enabled and "ON" or "OFF")
        Button.BackgroundColor3 = enabled and Color3.fromRGB(0, 150, 70) or Color3.fromRGB(40, 40, 40)
        callback(enabled)
    end)
end

-- HÀM TẠO Ô NHẬP (INPUT)
local function CreateInput(placeholder, callback)
    local Input = Instance.new("TextBox", ScrollingFrame)
    Input.PlaceholderText = placeholder
    Input.Size = UDim2.new(1, -10, 0, 40)
    Input.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Input.TextColor3 = Color3.new(1, 1, 1)
    Input.Font = Enum.Font.SourceSans
    Input.TextSize = 14
    Instance.new("UICorner", Input)

    Input.FocusLost:Connect(function()
        callback(Input.Text)
    end)
end

-- GIAO DIỆN CHỨC NĂNG
CreateInput("Nhập tên Pet cần bán (để trống = bán hết)", function(t) _G.Config.TargetPet = t end)
CreateInput("Nhập giá Token (Ví dụ: 1000)", function(t) _G.Config.Price = tonumber(t) or 100 end)

CreateToggle("Auto Tranh Gian Hàng", function(s) _G.Config.AutoClaim = s end)
CreateToggle("Auto Treo Bán Pet", function(s) _G.Config.AutoSell = s end)

-- HỆ THỐNG CAN THIỆP (LOGIC)
task.spawn(function()
    while task.wait(1.5) do
        -- 1. TỰ ĐỘNG TRANH HÀNG
        if _G.Config.AutoClaim then
            local Booths = workspace:FindFirstChild("Booths") or workspace:FindFirstChild("Stalls")
            if Booths then
                for _, b in pairs(Booths:GetChildren()) do
                    -- Tìm gian hàng chưa có chủ
                    local owner = b:FindFirstChild("Owner")
                    if owner and (owner.Value == nil or owner.Value == "") then
                        -- Quét tìm Remote Claim
                        for _, r in pairs(ReplicatedStorage:GetDescendants()) do
                            if r:IsA("RemoteEvent") and (r.Name:lower():find("claim") or r.Name:lower():find("booth")) then
                                r:FireServer(b)
                                break
                            end
                        end
                    end
                end
            end
        end

        -- 2. TỰ ĐỘNG TREO BÁN
        if _G.Config.AutoSell then
            -- Quét tìm Remote Bán
            local sellRemote = nil
            for _, r in pairs(ReplicatedStorage:GetDescendants()) do
                if r:IsA("RemoteEvent") and (r.Name:lower():find("list") or r.Name:lower():find("sell")) then
                    sellRemote = r
                    break
                end
            end

            if sellRemote then
                -- Nếu nhập tên pet cụ thể
                if _G.Config.TargetPet ~= "" then
                    sellRemote:FireServer(_G.Config.TargetPet, _G.Config.Price)
                else
                    -- Nếu không nhập tên, cố gắng quét Inventory (Logic này tùy game)
                    -- Giả lập gửi lệnh bán phổ biến
                    sellRemote:FireServer("All", _G.Config.Price)
                end
            end
        end
    end
end)

print("Mcuonghubv2 đã được kích hoạt!")
