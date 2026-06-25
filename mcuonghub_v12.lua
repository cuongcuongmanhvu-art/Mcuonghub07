-- [[ GROW A GARDEN 2 - ADVANCED AUTOMATION SUITE ]] --
-- Cảnh báo: Sử dụng script này có thể ảnh hưởng đến trải nghiệm game của người khác.

local Services = {
    Players = game:GetService("Players"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    RunService = game:GetService("RunService"),
    VirtualUser = game:GetService("VirtualUser")
}

local LocalPlayer = Services.Players.LocalPlayer
local Config = {
    AutoFarm = true,
    AutoWater = true,
    AutoSell = true,
    SelectedSeed = "Sunflower", -- Thay đổi loại hạt giống tại đây
    Delay = 0.5
}

-- [[ HỆ THỐNG CAN THIỆP TRỰC TIẾP (REMOTE INTERVENTION) ]] --
local API = {
    -- Tìm kiếm các RemoteEvents phổ biến trong GAG 2
    PlantEvent = Services.ReplicatedStorage:FindFirstChild("PlantSeed") or Services.ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("Plant"),
    HarvestEvent = Services.ReplicatedStorage:FindFirstChild("HarvestPlant") or Services.ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("Harvest"),
    SellEvent = Services.ReplicatedStorage:FindFirstChild("SellItems")
}

-- [[ HÀM XỬ LÝ LOGIC CHÍNH ]] --
local function GetGardenPlots()
    -- Trả về danh sách các ô đất của người chơi
    local plots = workspace:FindFirstChild("Plots")
    local myPlot = nil
    for _, plot in pairs(plots:GetChildren()) do
        if plot:FindFirstChild("Owner") and plot.Owner.Value == LocalPlayer.Name then
            myPlot = plot
            break
        end
    end
    return myPlot
end

local function ExecuteGardenCycle()
    local myPlot = GetGardenPlots()
    if not myPlot then return end

    for _, tile in pairs(myPlot:GetChildren()) do
        if not Config.AutoFarm then break end
        
        -- Logic: Thu hoạch nếu cây đã chín
        if tile:FindFirstChild("Stage") and tile.Stage.Value >= 3 then
            API.HarvestEvent:FireServer(tile)
            task.wait(Config.Delay)
        end
        
        -- Logic: Gieo hạt nếu đất trống
        if tile:FindFirstChild("IsOccupied") and tile.IsOccupied.Value == false then
            API.PlantEvent:FireServer(tile, Config.SelectedSeed)
            task.wait(Config.Delay)
        end
    end
end

-- [[ HỆ THỐNG ANTI-AFK ]] --
LocalPlayer.Idled:Connect(function()
    Services.VirtualUser:CaptureController()
    Services.VirtualUser:ClickButton2(Vector2.new(0,0))
end)

-- [[ KHỞI CHẠY VÒNG LẶP ĐIỀU KHIỂN ]] --
task.spawn(function()
    print("--- GAG 2 SCRIPT ACTIVATED ---")
    while true do
        if Config.AutoFarm then
            pcall(ExecuteGardenCycle)
        end
        
        if Config.AutoSell then
            -- Tự động gọi lệnh bán nếu kho đầy (giả lập)
            API.SellEvent:FireServer()
        end
        
        task.wait(1)
    end
end)

-- [[ UI CAN THIỆP NHANH (CONSOLE STYLE) ]] --
print("Commands: Config.AutoFarm = boolean | Config.SelectedSeed = string")
