-- [[ CUONGHUB PREMIUM V8.5 - STEAL A BRAINROT (FAKE BUY UPDATE) ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "⚡ cuonghub Super Premium v8.5: Steal A Brainrot ⚡",
   LoadingTitle = "Đang tích hợp module Mua Đồ Giả (Fake Purchase)...",
   LoadingSubtitle = "by cuongcuongmanhvu-art",
   ConfigurationSaving = { Enabled = true, FolderName = "cuonghub_brainrot", FileName = "Config" },
   KeySystem = false
})

-- BIẾN TOÀN CỤC (VARIABLES)
_G.fakeRobuxAmount = 999999
_G.selectedItemToFakeBuy = "Super VIP Gamepass"
_G.isAutoSteal = false
_G.isKillAura = false
_G.isAutoCollect = false
_G.selectedPlayer = ""
_G.walkSpeedValue = 16

-- ==================== KHỞI TẠO TABS GIAO DIỆN ==================== --
local TabRobux = Window:CreateTab("💵 Fake Robux & Shop", 4430451143)
local TabMain = Window:CreateTab("⚡ Auto Steal", 4430451143)
local TabCombat = Window:CreateTab("⚔️ Combat Troll", 4430451143)
local TabTp = Window:CreateTab("🌍 Teleport", 4430451143)
local TabMisc = Window:CreateTab("⚙️ Hệ Thống VIP", 4430451143)

-- ----------------------------------------------------------------------------
-- [TAB 1: FAKE ROBUX & FAKE PURCHASE]
-- ----------------------------------------------------------------------------
TabRobux:CreateSection("💵 Cấu Hình Số Lượng Robux Giả")

TabRobux:CreateInput({
   Name = "🔢 Nhập Số Robux Muốn Hack (Hiển Thị)",
   PlaceholderText = "Ví dụ: 999999...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text) _G.fakeRobuxAmount = tonumber(Text) or 999999 end,
})

TabRobux:CreateButton({
   Name = "💵 KÍCH HOẠT FAKE ROBUX MÀN HÌNH",
   Callback = function()
      pcall(function()
         local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
         local found = false
         for _, v in pairs(playerGui:GetDescendants()) do
            if v:IsA("TextLabel") and (string.find(string.lower(v.Text), "robux") or string.find(string.lower(v.Name), "robux") or string.find(string.lower(v.Name), "money")) then
               v.Text = "💵 " .. tostring(_G.fakeRobuxAmount) .. " Robux"
               found = true
            end
         end
         if found then
            Rayfield:Notify({Title = "cuonghub Success", Content = "Đã chỉnh sửa hiển thị thành " .. _G.fakeRobuxAmount .. " Robux!", Duration = 3})
         else
            Rayfield:Notify({Title = "cuonghub Info", Content = "Đã ép buộc đồng bộ giao diện hiển thị tiền!", Duration = 3})
         end
      end)
   end,
})

TabRobux:CreateSection("🛒 Tính Năng Mua Đồ Giả (Fake Purchase)")

TabRobux:CreateDropdown({
   Name = "🎁 Chọn Vật Phẩm Muốn Mua Giả",
   Options = {"Super VIP Gamepass", "X100 Brainrot Multiplier", "Godly Weapon Skin", "Infinite Robux Generator Item", "Admin Commands Access"},
   CurrentOption = {"Super VIP Gamepass"},
   MultipleOptions = false,
   Flag = "FakeBuySelect",
   Callback = function(Option) _G.selectedItemToFakeBuy = Option[1] end,
})

TabRobux:CreateButton({
   Name = "🛍️ THỰC HIỆN MUA (Hiện Hoạt Ảnh Khống)",
   Callback = function()
      pcall(function()
         -- 1. Trừ số dư Robux Fake trên màn hình để trông như thật
         _G.fakeRobuxAmount = math.max(0, _G.fakeRobuxAmount - 5000)
         local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
         for _, v in pairs(playerGui:GetDescendants()) do
            if v:IsA("TextLabel") and (string.find(string.lower(v.Text), "robux") or string.find(string.lower(v.Name), "robux")) then
               v.Text = "💵 " .. tostring(_G.fakeRobuxAmount) .. " Robux"
            end
         end

         -- 2. Tạo hiệu ứng thông báo mua thành công giả lập của hệ thống
         Rayfield:Notify({
            Title = "🎉 PURCHASE SUCCESSFUL! 🎉",
            Content = "Bạn đã mua thành công [" .. _G.selectedItemToFakeBuy .. "] với giá 5,000 Robux!",
            Duration = 6
         })

         -- 3. Tạo hiệu ứng pháo hoa giấy (Confetti) rơi quanh màn hình để quay video cực đẹp
         local char = game.Players.LocalPlayer.Character
         if char and char:FindFirstChild("HumanoidRootPart") then
            local p = Instance.new("ParticleEmitter", char.HumanoidRootPart)
            p.Texture = "rbxassetid://241595067" -- ID hạt giấy màu sắc
            p.Rate = 150
            p.Speed = NumberRange.new(10, 25)
            p.Lifetime = NumberRange.new(1.5, 2.5)
            task.wait(2)
            p:Destroy()
         end
      end)
   end,
})

-- ----------------------------------------------------------------------------
-- [TAB 2, 3, 4 & 5: CÁC CHỨC NĂNG CÀY CUỐC & TROLL]
-- ----------------------------------------------------------------------------
TabMain:CreateSection("Tự Động Đi Trộm Cướp")
TabMain:CreateToggle({ Name = "🤖 Auto Steal (Trộm Quầy Người Khác)", CurrentValue = false, Flag = "ToggleSteal", Callback = function(Value) _G.isAutoSteal = Value end })
TabMain:CreateToggle({ Name = "🪙 Auto Collect Coins / Drops (Hút Đồ Rơi)", CurrentValue = false, Flag = "ToggleCollect", Callback = function(Value) _G.isAutoCollect = Value end })

TabCombat:CreateSection("Bảo Vệ & Tấn Công")
TabCombat:CreateToggle({ Name = "⚔️ Kill Aura (Tự Động Đấm Người Gần Bên)", CurrentValue = false, Flag = "ToggleKillAura", Callback = function(Value) _G.isKillAura = Value end })

TabTp:CreateSection("Dịch Chuyển")
local PlayerList = {}
for _, v in pairs(game.Players:GetPlayers()) do if v ~= game.Players.LocalPlayer then table.insert(PlayerList, v.Name) end end
local DropdownPlayers = TabTp:CreateDropdown({ Name = "👤 Chọn Mục Tiêu", Options = PlayerList, CurrentOption = {""}, MultipleOptions = false, Flag = "TpPlayer", Callback = function(Option) _G.selectedPlayer = Option[1] end })
TabTp:CreateButton({ Name = "⚡ Bay Đến Chỗ Người Này", Callback = function() local target = game.Players:FindFirstChild(_G.selectedPlayer) if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame end end })

TabMisc:CreateSection("Thông Số VIP")
TabMisc:CreateSlider({ Name = "⚡ Tốc Độ Chạy (WalkSpeed)", Min = 16, Max = 300, DefaultValue = 16, Increment = 1, Callback = function(Value) _G.walkSpeedValue = Value if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value end end })

-- ==================== VÒNG LẶP ENGINE LIÊN TỤC ==================== --
task.spawn(function()
   while task.wait(0.2) do
      local MyChar = game.Players.LocalPlayer.Character
      local MyRoot = MyChar and MyChar:FindFirstChild("HumanoidRootPart")
      local ReplicatedStorage = game:GetService("ReplicatedStorage")

      pcall(function()
         if MyChar and MyChar:FindFirstChild("Humanoid") and _G.walkSpeedValue then
            MyChar.Humanoid.WalkSpeed = _G.walkSpeedValue
         end

         if _G.isAutoSteal and MyRoot then
            local remotes = ReplicatedStorage:FindFirstChild("Remotes") or ReplicatedStorage
            local stealEvent = remotes:FindFirstChild("Steal") or remotes:FindFirstChild("StealRobux")
            if stealEvent then
               for _, v in pairs(workspace:GetChildren()) do
                  if string.find(string.lower(v.Name), "tycoon") or v:FindFirstChild("Owner") then stealEvent:FireServer(v) end
               end
            end
         end

         if _G.isAutoCollect and MyRoot then
            for _, v in pairs(workspace:GetChildren()) do
               if v:IsA("Part") and (v.Name == "Coin" or v.Name == "Robux" or v.Name == "Drop") then v.CFrame = MyRoot.CFrame end
            end
         end

         if _G.isKillAura and MyRoot then
            for _, p in pairs(game.Players:GetPlayers()) do
               if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                  if (MyRoot.Position - p.Character.HumanoidRootPart.Position).Magnitude < 15 then
                     local hitRemote = ReplicatedStorage:FindFirstChild("Hit") or ReplicatedStorage:FindFirstChild("Punch")
                     if hitRemote then hitRemote:FireServer(p.Character) end
                  end
               end
            end
         end
      end)
   end
end)

game.Players.LocalPlayer.Idled:Connect(function() game:GetService("VirtualUser"):CaptureController() game:GetService("VirtualUser"):ClickButton2(Vector2.new(0,0)) end)
Rayfield:Notify({Title = "cuonghub v8.5 Loaded", Content = "Hệ thống Mua Đồ Giả (Fake Purchase) đã sẵn sàng!", Duration = 5})
