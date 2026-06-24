-- [[ MCUONGHUB ULTIMATE HUB V5.2 - ADVANCED INPUT & RECONNECT ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Khởi tạo Cửa sổ chính
local Window = Rayfield:CreateWindow({
   Name = "⚡ mcuonghub HUB v5.2: INPUT EDITION ⚡",
   LoadingTitle = "Đang cấu hình hộp nhập số lượng...",
   LoadingSubtitle = "by cuongcuongmanhvu-art",
   ConfigurationSaving = { Enabled = true, FolderName = "mcuonghub_v5", FileName = "GrowAGarden" },
   KeySystem = false
})

-- Biến lưu trữ cấu hình
_G.isAutoPlant = false
_G.selectedPlant = "Tomato"

_G.isAutoSellToken = false
_G.selectedCropToSell = "All"
_G.selectedCurrency = "Token"
_G.amountToSell = 1 -- Số lượng nông sản cần bán (Mặc định là 1)

_G.isAutoUpPet = false
_G.selectedPetToUp = "Pet Thường"
_G.tokenInputAmount = 100 -- Số lượng token cần dùng để up pet (Mặc định)

_G.isAutoOpenBooth = false
_G.isAntiAFK = true
_G.isAutoReconnect = true

-- ==================== CÁC TAB CHỨC NĂNG CHUYÊN NGHIỆP ==================== --
local TabFarm = Window:CreateTab("🌱 Trồng Trọt", 4430451143)
local TabEco = Window:CreateTab("💰 Giao Thương", 4430451143)
local TabPet = Window:CreateTab("🐾 Thú Cưng", 4430451143)
local TabMisc = Window:CreateTab("⚙️ Hệ Thống", 4430451143)

-- ----------------------------------------------------------------------------
-- [TAB 1: DANH MỤC TRỒNG TRỌT]
-- ----------------------------------------------------------------------------
TabFarm:CreateSection("Cấu Hình Trồng Cây")

TabFarm:CreateDropdown({
   Name = "🎯 Chọn Loại Cây Muốn Trồng",
   Options = {"Tomato", "Potato", "Carrot", "Pumpkin", "Watermelon", "Golden Tree"},
   CurrentOption = {"Tomato"},
   MultipleOptions = false,
   Flag = "PlantSelect",
   Callback = function(Option) _G.selectedPlant = Option[1] end,
})

TabFarm:CreateToggle({
   Name = "🌱 Kích Hoạt Auto Gieo Hạt",
   CurrentValue = false,
   Flag = "TogglePlant",
   Callback = function(Value) _G.isAutoPlant = Value end,
})

TabFarm:CreateToggle({
   Name = "🤖 Auto Thu Hoạch",
   CurrentValue = false,
   Flag = "ToggleHarvest",
   Callback = function(Value) _G.isAutoHarvest = Value end,
})

TabFarm:CreateToggle({
   Name = "🛡️ Bất Tử Nước",
   CurrentValue = false,
   Flag = "ToggleWater",
   Callback = function(Value) _G.isGodMode = Value end,
})

-- ----------------------------------------------------------------------------
-- [TAB 2: DANH MỤC GIAO THƯƠNG (CÓ HỘP NHẬP SỐ LƯỢNG BÁN)]
-- ----------------------------------------------------------------------------
TabEco:CreateSection("Cấu Hình Bán Nông Sản")

TabEco:CreateDropdown({
   Name = "📦 Chọn Vật Phẩm Muốn Bán",
   Options = {"All", "Tomato", "Potato", "Carrot", "Pumpkin", "Watermelon"},
   CurrentOption = {"All"},
   MultipleOptions = false,
   Flag = "CropSellSelect",
   Callback = function(Option) _G.selectedCropToSell = Option[1] end,
})

TabEco:CreateDropdown({
   Name = "🪙 Chọn Loại Tiền Nhận Được",
   Options = {"Token", "Coins"},
   CurrentOption = {"Token"},
   MultipleOptions = false,
   Flag = "CurrencySelect",
   Callback = function(Option) _G.selectedCurrency = Option[1] end,
})

-- [MỚI CHUYÊN NGHIỆP] - Ô nhập số lượng vật phẩm muốn bán
TabEco:CreateInput({
   Name = "🔢 Nhập Số Lượng Vật Phẩm Muốn Bán",
   PlaceholderText = "Ví dụ: 10, 50, 100...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      local num = tonumber(Text)
      if num then
         _G.amountToSell = num
         Rayfield:Notify({Title = "Hệ Thống", Content = "Đã đặt số lượng bán: " .. num, Duration = 2})
      end
   end,
})

TabEco:CreateToggle({
   Name = "💰 Kích Hoạt Auto Treo Bán Đồ",
   CurrentValue = false,
   Flag = "ToggleSell",
   Callback = function(Value) _G.isAutoSellToken = Value end,
})

TabEco:CreateSection("Quầy Hàng Chợ Đêm")

TabEco:CreateToggle({
   Name = "🎪 Auto Chiếm & Mở Quầy Hàng (Booth)",
   CurrentValue = false,
   Flag = "ToggleBooth",
   Callback = function(Value) _G.isAutoOpenBooth = Value end,
})

-- ----------------------------------------------------------------------------
-- [TAB 3: DANH MỤC THÚ CƯNG (CÓ HỘP NHẬP SỐ TOKEN)]
-- ----------------------------------------------------------------------------
TabPet:CreateSection("Nâng Cấp Thú Cưng")

TabPet:CreateDropdown({
   Name = "🐾 Chọn Loại Pet Cần Up",
   Options = {"Pet Thường (Dog/Cat)", "Pet Hiếm (Rare)", "Pet Huyền Thoại (Legendary)", "All Pets"},
   CurrentOption = {"Pet Thường (Dog/Cat)"},
   MultipleOptions = false,
   Flag = "PetSelect",
   Callback = function(Option) _G.selectedPetToUp = Option[1] end,
})

-- [MỚI CHUYÊN NGHIỆP] - Ô nhập số lượng Token giới hạn để Up Pet
TabPet:CreateInput({
   Name = "🪙 Nhập Số Token Yêu Cầu Để Up Pet",
   PlaceholderText = "Nhập số lượng token cần dùng...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      local num = tonumber(Text)
      if num then
         _G.tokenInputAmount = num
         Rayfield:Notify({Title = "Hệ Thống", Content = "Đã đặt mức Token giới hạn: " .. num, Duration = 2})
      end
   end,
})

TabPet:CreateToggle({
   Name = "⚡ Auto Up Cấp Tự Động khi Đủ Token",
   CurrentValue = false,
   Flag = "ToggleUpPet",
   Callback = function(Value) _G.isAutoUpPet = Value end,
})

-- ----------------------------------------------------------------------------
-- [TAB 4: HỆ THỐNG / KẾT NỐI LẠI]
-- ----------------------------------------------------------------------------
TabMisc:CreateSection("Tiện Ích Treo Máy")

TabMisc:CreateToggle({
   Name = "🔄 Tự Động Kết Nối Lại Khi Bị Văng (Auto Reconnect)",
   CurrentValue = true,
   Flag = "ToggleReconnect",
   Callback = function(Value) _G.isAutoReconnect = Value end,
})

TabMisc:CreateSlider({
   Name = "⚡ Tốc Độ Chạy (WalkSpeed)",
   Min = 16, Max = 250, DefaultValue = 16, Color = Color3.fromRGB(0, 255, 0),
   Increment = 1, ValueName = "Speed",
   Callback = function(Value)
      if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

-- ==================== VÒNG LẶP HỆ THỐNG LUỒNG NGẦM (LOOP ENGINE) ==================== --
task.spawn(function()
   while task.wait(0.5) do
      local ReplicatedStorage = game:GetService("ReplicatedStorage")
      local Garden = workspace:FindFirstChild("Plots") or workspace:FindFirstChild("Garden") or workspace:FindFirstChild("PlayerPlots")
      
      -- Vòng lặp Farm cây
      pcall(function()
         if Garden then
            for _, plot in pairs(Garden:GetChildren()) do
               if _G.isGodMode and plot:FindFirstChild("Water") then plot.Water.Value = 100 end
               if _G.isAutoPlant and plot:FindFirstChild("Stage") and plot.Stage.Value == 0 then
                  local plantRemote = ReplicatedStorage:FindFirstChild("Plant") or ReplicatedStorage:FindFirstChild("PlantSeed")
                  if plantRemote then plantRemote:FireServer(plot, _G.selectedPlant) end 
               end
               if _G.isAutoHarvest and plot:FindFirstChild("Stage") and (plot.Stage.Value == 4 or plot.Stage.Value == "Ripe") then
                  local harvestRemote = ReplicatedStorage:FindFirstChild("Harvest") or plot:FindFirstChild("HarvestEvent")
                  if harvestRemote then harvestRemote:FireServer(plot) end
               end
            end
         end
      end)
      
      -- Xử lý Kinh tế truyền tham số nhập từ Input
      pcall(function()
         if _G.isAutoSellToken then
            local sellRemote
            if _G.selectedCurrency == "Token" then
               sellRemote = ReplicatedStorage:FindFirstChild("SellToken") or ReplicatedStorage:FindFirstChild("TokenSell")
            else
               sellRemote = ReplicatedStorage:FindFirstChild("Sell") or ReplicatedStorage:FindFirstChild("SellAll")
            end
            -- Truyền loại nông sản VÀ số lượng đã nhập vào Server
            if sellRemote then sellRemote:FireServer(_G.selectedCropToSell, _G.amountToSell) end
         end

         -- Xử lý Up Pet (Chỉ gửi lệnh nếu số Token của bạn lớn hơn hoặc bằng số bạn nhập)
         if _G.isAutoUpPet then
            local stats = game.Players.LocalPlayer:FindFirstChild("leaderstats")
            local currentTokens = stats and (stats:FindFirstChild("Tokens") or stats:FindFirstChild("Token")) and (stats:FindFirstChild("Tokens").Value or stats:FindFirstChild("Token").Value) or 0
            
            if currentTokens >= _G.tokenInputAmount then
               local petRemote = ReplicatedStorage:FindFirstChild("UpgradePet") or ReplicatedStorage:FindFirstChild("PetUpgrade")
               if petRemote then petRemote:FireServer(_G.selectedPetToUp, _G.tokenInputAmount) end
            end
         end

         -- Auto Mở quầy
         if _G.isAutoOpenBooth then
            local boothRemote = ReplicatedStorage:FindFirstChild("OpenBooth") or ReplicatedStorage:FindFirstChild("ClaimBooth")
            if boothRemote then boothRemote:FireServer() end
         end
      end)
   end
end)

-- HỆ THỐNG AUTO RECONNECT
pcall(function()
   game:GetService("GuiService").ErrorMessageChanged:Connect(function()
      if _G.isAutoReconnect then
         Rayfield:Notify({Title = "Mất Kết Nối!", Content = "Đang tự động kết nối lại sau 5 giây...", Duration = 5})
         task.wait(5)
         game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
      end
   end)
end)

-- CHỐNG AFK KICK
pcall(function()
   local VirtualUser = game:GetService("VirtualUser")
   game.Players.LocalPlayer.Idled:Connect(function()
      VirtualUser:CaptureController()
      VirtualUser:ClickButton2(Vector2.new(0,0))
   end)
end)

Rayfield:Notify({Title = "mcuonghub v5.2 Loaded", Content = "Đã tích hợp ô nhập số lượng Token & Nông sản thành công!", Duration = 5})
