-- [[ CUONGHUB ULTRA PREMIUM V10.5 - THE MEGA UPDATE 2026 ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "⚡ cuonghub Mega Premium v10.5 ⚡",
   LoadingTitle = "⚡ Đang nạp DANH SÁCH TỐI THƯỢNG (Full Cây & Pet) ⚡",
   LoadingSubtitle = "by cuongcuongmanhvu-art",
   ConfigurationSaving = { Enabled = true, FolderName = "cuonghub_v10_5", FileName = "MegaConfig" },
   KeySystem = false
})

-- ==================== KHO DỮ LIỆU ĐẦY ĐỦ 100% (BẢN UPDATE CỰC LỚN) ==================== --

-- 1. DANH SÁCH TOÀN BỘ CÂY TRỒNG, QUẢ, HẠT GIỐNG VÀ CÁC BIẾN THỂ ĐỘT BIẾN
local ALL_CROPS_LIST = {
   "All", 
   -- Cây Phổ Thông (Common)
   "Tomato", "Potato", "Carrot", "Pumpkin", "Watermelon", "Sunflower", "Strawberry", "Blueberry", "Corn", "Wheat", "Cabbage", "Eggplant", "Broccoli", "Sugarcane", "Pineapple", "Grape",
   -- Cây Cao Cấp & Cây Ăn Quả (Rare/Epic)
   "Apple Tree", "Orange Tree", "Banana Tree", "Coconut Tree", "Dragon Fruit", "Cactus Fruit", "Chili Pepper", "Golden Apple", "Glow Berry", "Magic Mushroom", "Crystal Flower",
   -- Cây Vàng (Golden Variants)
   "Golden Tomato", "Golden Potato", "Golden Carrot", "Golden Pumpkin", "Golden Watermelon", "Golden Tree", "Golden Sunflower", "Golden Corn",
   -- Cây Đột Biến & Siêu Cấp (Mutated / Mythical / Dark Matter)
   "Mutated Tomato", "Mutated Pumpkin", "Mutated Carrot", "Mutated Watermelon", "Rainbow Tree", "Dark Matter Plant", "Void Flower", "Galaxy Tree", "Infinity Seed"
}

-- 2. DANH SÁCH TOÀN BỘ PET TRONG GAME (TỪ THƯỜNG, ĐỘT BIẾN, TIẾN HÓA ĐẾN THẦN THOẠI)
local ALL_PETS_LIST = {
   -- Dòng Thú Nuôi Cơ Bản (Common / Uncommon)
   "Dog", "Cat", "Rabbit", "Fox", "Bear", "Deer", "Wolf", "Pig", "Cow", "Sheep", "Chicken", "Duck", "Mouse", "Squirrel", "Raccoon", "Owl",
   -- Dòng Thú Cưng Quý Hiếm (Rare / Epic)
   "Lion", "Tiger", "Leopard", "Elephant", "Gorilla", "Panda", "Koala", "Sloth", "Penguin", "Polar Bear", "Crocodile", "Shark", "Orca", "Dolphin",
   -- Dòng Siêu Cấp & Thần Thoại (Legendary / Mythical)
   "Dragon", "Pegasus", "Slime King", "Golden Phoenix", "Unicorn", "Cerberus", "Kraken", "Leviathan", "Phoenix", "Griffin", "Hydra", "Minotaur", "Chimera",
   -- Dòng Vô Cực & Vũ Trụ (Void / Galaxy / Shadow)
   "Shadow Bunny", "Void Demon", "Galaxy Dragon", "Nebula Cat", "Astral Wolf", "Cosmic Bear", "Star Slime", "Dark Matter Dog",
   -- Dòng Công Nghệ & Nguyên Tố (Cyber / Elemental)
   "Cyber Cat", "Cyber Dog", "Robo Robo", "Lava Hound", "Frost Yeti", "Glow Squid", "Golden Tree Spirit", "Storm Eagle", "Earth Golem", "Aqua Mermaid"
}

-- HỆ THỐNG BIẾN TOÀN CỤC CHỨC NĂNG
_G.isAutoOpenBooth = false
_G.selectedPetToSell = "Dog"
_G.petSellPriceToken = 100
_G.isAutoSellCrops = false
_G.selectedCropToSell = "All"
_G.cropSellAmount = 1
_G.isAutoReconnect = true
_G.isAntiAfk = true

-- ==================== DANH SÁCH MENU TABS HẦM HỐ ==================== --
local TabMarket = Window:CreateTab("🎪 Chợ Gian Hàng", 4430451143)
local TabCrops = Window:CreateTab("📦 Kho Trái Cây", 4430451143)
local TabSystem = Window:CreateTab("⚙️ Hệ Thống VIP", 4430451143)

-- ----------------------------------------------------------------------------
-- [TAB 1: GIAN HÀNG & TREO BÁN FULL PET]
-- ----------------------------------------------------------------------------
TabMarket:CreateSection("🎪 Quản Lý Gian Hàng (Booth)")
TabMarket:CreateToggle({ Name = "⚡ Auto Tranh & Chiếm Gian Hàng (Claim Booth)", CurrentValue = false, Flag = "ToggleAutoBooth", Callback = function(Value) _G.isAutoOpenBooth = Value end })

TabMarket:CreateSection("🐾 Treo Bán Tất Cả Các Con Pet")
local DropdownPetMarket = TabMarket:CreateDropdown({
   Name = "🐕 Chọn Con Pet Muốn Bán",
   Options = ALL_PETS_LIST, CurrentOption = {"Dog"}, MultipleOptions = false, Flag = "PetMarketSelect",
   Callback = function(Option) _G.selectedPetToSell = Option[1] end,
})

TabMarket:CreateInput({
   Name = "🔍 Gõ Từ Khóa Để Tìm Kiếm Pet Nhanh", PlaceholderText = "Ví dụ: Void, Cyber, Gold...", RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      local match = {}
      for _, v in pairs(ALL_PETS_LIST) do if string.find(string.lower(v), string.lower(Text)) then table.insert(match, v) end end
      if #match > 0 then DropdownPetMarket:Set(match) end
   end,
})

TabMarket:CreateInput({ Name = "🪙 Nhập Số Token Định Giá Bán Pet", PlaceholderText = "Ví dụ: 1000...", RemoveTextAfterFocusLost = false, Callback = function(Text) _G.petSellPriceToken = tonumber(Text) or 100 end })
TabMarket:CreateToggle({ Name = "🚀 Kích Hoạt Auto Treo Bán Pet Lên Quầy", CurrentValue = false, Flag = "ToggleSellPet", Callback = function(Value) _G.isAutoSellPet = Value end })

-- ----------------------------------------------------------------------------
-- [TAB 2: BÁN TRÁI CÂY / NÔNG SẢN SIÊU ĐẦY ĐỦ]
-- ----------------------------------------------------------------------------
TabCrops:CreateSection("🍎 Quản Lý Kho Nông Sản")
local DropdownCrops = TabCrops:CreateDropdown({
   Name = "🍎 Chọn Loại Trái Cây Muốn Bán",
   Options = ALL_CROPS_LIST, CurrentOption = {"All"}, MultipleOptions = false, Flag = "CropSelect",
   Callback = function(Option) _G.selectedCropToSell = Option[1] end,
})

TabCrops:CreateInput({
   Name = "🔍 Gõ Từ Khóa Tìm Trái Cây", PlaceholderText = "Ví dụ: Mutated, Golden...", RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      local match = {}
      for _, v in pairs(ALL_CROPS_LIST) do if string.find(string.lower(v), string.lower(Text)) then table.insert(match, v) end end
      if #match > 0 then DropdownCrops:Set(match) end
   end,
})

TabCrops:CreateInput({ Name = "🔢 Nhập Số Lượng Trái Cây Muốn Bán", PlaceholderText = "Ví dụ: 100...", RemoveTextAfterFocusLost = false, Callback = function(Text) _G.cropSellAmount = tonumber(Text) or 1 end })
TabCrops:CreateToggle({ Name = "💰 Kích Hoạt Auto Bán Trái Cây Lấy Tiền/Token", CurrentValue = false, Flag = "ToggleSellCrops", Callback = function(Value) _G.isAutoSellCrops = Value end })

-- ----------------------------------------------------------------------------
-- [TAB 3: TIỆN ÍCH VIP TREO MÁY]
-- ----------------------------------------------------------------------------
TabSystem:CreateSection("⚙️ Cấu Hình Treo Máy Xuyên Đêm")
TabSystem:CreateToggle({ Name = "🔄 Auto Reconnect (Tự Kết Nối Lại)", CurrentValue = true, Flag = "ToggleReconnect", Callback = function(Value) _G.isAutoReconnect = Value end })
TabSystem:CreateToggle({ Name = "🛡️ Anti-AFK (Chống Bị Kick Hoạt Động)", CurrentValue = true, Flag = "ToggleAntiAfk", Callback = function(Value) _G.isAntiAfk = Value end })

-- ==================== ENGINE LUỒNG NGẦM TỰ ĐỘNG ==================== --
task.spawn(function()
   while task.wait(0.5) do
      local ReplicatedStorage = game:GetService("ReplicatedStorage")
      local Events = ReplicatedStorage:FindFirstChild("Events") or ReplicatedStorage
      pcall(function()
         if _G.isAutoOpenBooth then
            local claimRemote = Events:FindFirstChild("ClaimBooth") or Events:FindFirstChild("RentBooth") or Events:FindFirstChild("TakeBooth")
            if claimRemote then claimRemote:FireServer() end
         end
         if _G.isAutoSellPet then
            local petMarketRemote = Events:FindFirstChild("AddPetToBooth") or Events:FindFirstChild("SellPetForToken") or Events:FindFirstChild("ListPetMarket")
            if petMarketRemote then petMarketRemote:FireServer(_G.selectedPetToSell, _G.petSellPriceToken) end
         end
         if _G.isAutoSellCrops then
            local sellRemote = Events:FindFirstChild("SellCrops") or Events:FindFirstChild("SellItem") or Events:FindFirstChild("SellAll") or Events:FindFirstChild("Sell")
            if sellRemote then sellRemote:FireServer(_G.selectedCropToSell, _G.cropSellAmount) end
         end
      end)
   end
end)

local VirtualUser = game:GetService("VirtualUser")
game.Players.LocalPlayer.Idled:Connect(function() if _G.isAntiAfk then VirtualUser:CaptureController() VirtualUser:ClickButton2(Vector2.new(0,0)) end end)
game:GetService("GuiService").ErrorMessageChanged:Connect(function() if _G.isAutoReconnect then task.wait(5) game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer) end end)

Rayfield:Notify({Title = "cuonghub v10.5 Loaded", Content = "Đã nạp thành công bộ cơ sở dữ liệu khổng lồ!", Duration = 5})
