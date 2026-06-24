-- [[ MCUONGHUB SPEED HUB EDITION - RAYFIELD UI LIBRARY ]] --
-- Tối ưu hóa hệ thống chống phát hiện (Bypass Check)
if getgenv and not getgenv().mcuonghub_loaded then
    getgenv().mcuonghub_loaded = true
else
    print("mcuonghub: Script đang chạy rồi!")
end

-- Tải Thư viện Rayfield UI (Phong cách chuẩn Speed Hub)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Khởi tạo Cửa sổ chính giống Speed Hub nhưng mượt hơn
local Window = Rayfield:CreateWindow({
   Name = "⚡ SPEED HUB: mcuonghub Edition ⚡",
   LoadingTitle = "Loading mcuonghub System...",
   LoadingSubtitle = "by cuongcuongmanhvu-art",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "mcuonghub_configs", -- Lưu cấu hình vào thư mục riêng trong máy
      FileName = "GrowAGarden_Config"
   },
   Discord = {
      Enabled = false,
      Invite = "",
      RememberJoins = true
   },
   KeySystem = false -- Tắt hệ thống Key cho bạn sài nhanh không bị vướng
})

-- Các biến trạng thái chức năng
_G.isGodMode = false
_G.isAutoHarvest = false
_G.isAutoPlant = false
_G.isAutoSellToken = false
_G.isAutoUpPet = false
_G.isAutoOpenBooth = false

-- ==================== CÁC TAB CHỨC NĂNG (GIỐNG SPEED HUB) ==================== --
local TabMain = Window:CreateTab("🌱 Main Farm", 4430451143) -- Tab Auto Farm
local TabEco = Window:CreateTab("💰 Kinh Tế & Pet", 4430451143) -- Tab Đổi đồ, Up Pet
local TabLocal = Window:CreateTab("⚡ Nhân Vật", 4430451143) -- Tab Hack người chạy nhảy

-- ----------------------------------------------------------------------------
-- [TAB 1: MAIN FARM]
-- ----------------------------------------------------------------------------
local SectionFarm = TabMain:CreateSection("Hệ Thống Trồng Trọt Tự Động")

TabMain:CreateToggle({
   Name = "🛡️ Bất Tử Nước (Khóa 100%)",
   CurrentValue = false,
   Flag = "WaterToggle", 
   Callback = function(Value) _G.isGodMode = Value end,
})

TabMain:CreateToggle({
   Name = "🌱 Auto Gieo Hạt (Trồng Cây)",
   CurrentValue = false,
   Flag = "PlantToggle",
   Callback = function(Value) _G.isAutoPlant = Value end,
})

TabMain:CreateToggle({
   Name = "🤖 Auto Thu Hoạch Cây Chín",
   CurrentValue = false,
   Flag = "HarvestToggle",
   Callback = function(Value) _G.isAutoHarvest = Value end,
})

-- ----------------------------------------------------------------------------
-- [TAB 2: KINH TẾ & PET]
-- ----------------------------------------------------------------------------
local SectionEco = TabEco:CreateSection("Tự Động Giao Thương")

TabEco:CreateToggle({
   Name = "🪙 Auto Bán Đồ Đổi Token",
   CurrentValue = false,
   Flag = "SellTokenToggle",
   Callback = function(Value) _G.isAutoSellToken = Value end,
})

TabEco:CreateToggle({
   Name = "🐾 Auto Nâng Cấp Cấp Độ Pet",
   CurrentValue = false,
   Flag = "UpPetToggle",
   Callback = function(Value) _G.isAutoUpPet = Value end,
})

TabEco:CreateToggle({
   Name = "🎪 Auto Chiếm & Mở Quầy Hàng",
   CurrentValue = false,
   Flag = "OpenBoothToggle",
   Callback = function(Value) _G.isAutoOpenBooth = Value end,
})

-- ----------------------------------------------------------------------------
-- [TAB 3: NHÂN VẬT (CẢI TIẾN THANH KÉO SLIDER MƯỢT HƠN)]
-- ----------------------------------------------------------------------------
local SectionPlayer = TabLocal:CreateSection("Mod Thông Số Nhân Vật")

TabLocal:CreateSlider({
   Name = "⚡ Tốc Độ Chạy (WalkSpeed)",
   Min = 16, Max = 250, DefaultValue = 16, Color = Color3.fromRGB(0, 255, 0),
   Increment = 1, ValueName = "Speed",
   Callback = function(Value)
      if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

TabLocal:CreateSlider({
   Name = "🦘 Sức Nhảy (JumpPower)",
   Min = 50, Max = 350, DefaultValue = 50, Color = Color3.fromRGB(0, 255, 0),
   Increment = 1, ValueName = "Jump",
   Callback = function(Value)
      if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
         game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
      end
   end,
})

TabLocal:CreateButton({
   Name = "➕ Nhận +1000 Điểm (Test)",
   Callback = function()
      local stats = game.Players.LocalPlayer:FindFirstChild("leaderstats")
      if stats then
         local score = stats:FindFirstChild("Score") or stats:FindFirstChild("Coins") or stats:FindFirstChild("Tokens")
         if score then score.Value = score.Value + 1000 end
      end
   end,
})

-- ==================== VÒNG LẶP HỆ THỐNG LUỒNG NGẦM TỐI ƯU ==================== --
task.spawn(function()
   while task.wait(0.5) do -- Giảm thời gian trễ xuống 0.5 giây để hack chạy nhanh mượt hơn
      local ReplicatedStorage = game:GetService("ReplicatedStorage")
      local Garden = workspace:FindFirstChild("Plots") or workspace:FindFirstChild("Garden") or workspace:FindFirstChild("PlayerPlots")
      
      if _G.isGodMode or _G.isAutoPlant or _G.isAutoHarvest then
         pcall(function()
            if Garden then
               for _, plot in pairs(Garden:GetChildren()) do
                  if _G.isGodMode and plot:FindFirstChild("Water") then plot.Water.Value = 100 end
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
         end)
      end
      
      -- Xử lý Kinh tế (Bọc pcall để chống báo lỗi đỏ màn hình)
      pcall(function()
         if _G.isAutoSellToken then
            local tokenRemote = ReplicatedStorage:FindFirstChild("SellToken") or ReplicatedStorage:FindFirstChild("TokenSell") or ReplicatedStorage:FindFirstChild("SellAllTokens")
            if tokenRemote then tokenRemote:FireServer() else
               local generalSell = ReplicatedStorage:FindFirstChild("Sell") or ReplicatedStorage:FindFirstChild("SellAll")
               if generalSell then generalSell:FireServer("Token") end
            end
         end
         if _G.isAutoUpPet then
            local petRemote = ReplicatedStorage:FindFirstStorage("UpgradePet") or ReplicatedStorage:FindFirstChild("PetUpgrade") or ReplicatedStorage:FindFirstChild("LevelUpPet")
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
      end)
   end
end)

-- CHỐNG AFK KICK BẰNG VIRTUAL USER
pcall(function()
   local VirtualUser = game:GetService("VirtualUser")
   game.Players.LocalPlayer.Idled:Connect(function()
      VirtualUser:CaptureController()
      VirtualUser:ClickButton2(Vector2.new(0,0))
   end)
end)

-- Gửi thông báo hoàn tất xịn sò góc phải màn hình
Rayfield:Notify({
   Title = "mcuonghub Speed Hub",
   Content = "Hệ thống giao diện cải tiến đã tải thành công!",
   Duration = 4.5,
   Image = 4430451143,
})
