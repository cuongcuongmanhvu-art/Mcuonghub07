-- [[ CUONGHUB PREMIUM V11 - COMPATIBILITY FIX ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "⚡ cuonghub Premium v11 (Fix Lỗi Không Hoạt Động) ⚡",
   LoadingTitle = "Đang vá lỗi luồng gửi lệnh FireServer...",
   LoadingSubtitle = "by cuongcuongmanhvu-art",
   ConfigurationSaving = { Enabled = false }
})

_G.isAutoOpenBooth = false
_G.selectedPetToSell = "Dog"
_G.petSellPriceToken = 100
_G.isAutoSellCrops = false
_G.selectedCropToSell = "All"
_G.isAntiAfk = true

local TabMarket = Window:CreateTab("🎪 Chợ Gian Hàng", 4430451143)
local TabCrops = Window:CreateTab("📦 Kho Trái Cây", 4430451143)

TabMarket:CreateToggle({ Name = "⚡ Auto Tranh Gian Hàng (Claim Booth)", CurrentValue = false, Callback = function(Value) _G.isAutoOpenBooth = Value end })
TabMarket:CreateInput({ Name = "🪙 Giá Bán Pet", PlaceholderText = "100...", Callback = function(Text) _G.petSellPriceToken = tonumber(Text) or 100 end })
TabMarket:CreateToggle({ Name = "🚀 Auto Treo Bán Pet", CurrentValue = false, Callback = function(Value) _G.isAutoSellPet = Value end })

TabCrops:CreateToggle({ Name = "💰 Auto Bán Trái Cây", CurrentValue = false, Callback = function(Value) _G.isAutoSellCrops = Value end })

-- ==================== ENGINE PHÁC THẢO TỰ ĐỘNG DÒ REMOTE KHÔNG LO BỊ ĐỔI TÊN ==================== --
task.spawn(function()
   while task.wait(0.5) do
      pcall(function()
         local ReplicatedStorage = game:GetService("ReplicatedStorage")
         
         -- Tự động tìm thư mục chứa Lệnh của game Grow a Garden
         local RemoteFolder = ReplicatedStorage:FindFirstChild("Events") 
            or ReplicatedStorage:FindFirstChild("Remotes") 
            or ReplicatedStorage:FindFirstChild("Network") 
            or ReplicatedStorage

         -- 1. XỬ LÝ CHIẾM BOOTH
         if _G.isAutoOpenBooth then
            local boothEvent = RemoteFolder:FindFirstChild("ClaimBooth") or RemoteFolder:FindFirstChild("RentBooth") or RemoteFolder:FindFirstChild("Claim")
            if boothEvent and boothEvent:IsA("RemoteEvent") then 
               boothEvent:FireServer() 
            end
         end

         -- 2. XỬ LÝ BÁN PET
         if _G.isAutoSellPet then
            local petEvent = RemoteFolder:FindFirstChild("AddPetToBooth") or RemoteFolder:FindFirstChild("SellPet") or RemoteFolder:FindFirstChild("ListPet")
            if petEvent and petEvent:IsA("RemoteEvent") then 
               petEvent:FireServer(_G.selectedPetToSell, _G.petSellPriceToken) 
            end
         end

         -- 3. XỬ LÝ BÁN NÔNG SẢN
         if _G.isAutoSellCrops then
            local sellEvent = RemoteFolder:FindFirstChild("SellCrops") or RemoteFolder:FindFirstChild("SellAll") or RemoteFolder:FindFirstChild("Sell")
            if sellEvent and sellEvent:IsA("RemoteEvent") then 
               sellEvent:FireServer(_G.selectedCropToSell, 1) 
            end
         end
      end)
   end
end)

-- Chống AFK
game.Players.LocalPlayer.Idled:Connect(function() game:GetService("VirtualUser"):CaptureController() game:GetService("VirtualUser"):ClickButton2(Vector2.new(0,0)) end)
