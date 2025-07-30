local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

local headSize = 20
local hitboxEnabled = false
local teamCheck = true

-- جدول المحظورين (تقدر تعدل فيه بسهولة)
local BlockedUsers = {
    ["Noob123"] = true,
    ["ToxicPlayer"] = true,
}

local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "DevAnwar_GUI"
screenGui.ResetOnSpawn = false

local openButton = Instance.new("TextButton", screenGui)
openButton.Size = UDim2.new(0, 60, 0, 60)
openButton.Position = UDim2.new(0, 20, 0.5, -30)
openButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
openButton.TextColor3 = Color3.new(1, 1, 1)
openButton.Text = "Dev.\nAnwar"
openButton.Font = Enum.Font.GothamBold
openButton.TextSize = 12
openButton.BorderSizePixel = 0
openButton.AutoButtonColor = true
openButton.Draggable = true
Instance.new("UICorner", openButton).CornerRadius = UDim.new(1, 0)

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 320, 0, 360) -- مساحة أكبر شوي للقائمة والأزرار
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.Visible = false
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

-- عنوان رئيسي
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "made by: Anwar🇮🇶"
title.TextColor3 = Color3.fromRGB(0, 255, 127)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

-- تحديث النسخة
local updateLabel = Instance.new("TextLabel", frame)
updateLabel.Size = UDim2.new(1, 0, 0, 20)
updateLabel.Position = UDim2.new(0, 0, 0.95, 0)
updateLabel.BackgroundTransparency = 1
updateLabel.Text = "Version 1.1 - تم تحديث السكربت"
updateLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
updateLabel.Font = Enum.Font.Gotham
updateLabel.TextSize = 14
updateLabel.TextXAlignment = Enum.TextXAlignment.Center

-- زر تفعيل الهيت بوكس
local toggle = Instance.new("TextButton", frame)
toggle.Position = UDim2.new(0.05, 0, 0.12, 0)
toggle.Size = UDim2.new(0.9, 0, 0.13, 0)
toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.Text = "HitBox: OFF"
toggle.Font = Enum.Font.Gotham
toggle.TextSize = 16
toggle.AutoButtonColor = true
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 6)

-- عرض حجم الهيت بوكس
local sliderLabel = Instance.new("TextLabel", frame)
sliderLabel.Position = UDim2.new(0.05, 0, 0.28, 0)
sliderLabel.Size = UDim2.new(0.9, 0, 0.1, 0)
sliderLabel.BackgroundTransparency = 1
sliderLabel.Text = "Size: 20"
sliderLabel.TextColor3 = Color3.new(1, 1, 1)
sliderLabel.Font = Enum.Font.Gotham
sliderLabel.TextSize = 14
sliderLabel.TextXAlignment = Enum.TextXAlignment.Left

-- سلايدر الحجم (صندوق نص)
local slider = Instance.new("TextBox", frame)
slider.Position = UDim2.new(0.05, 0, 0.38, 0)
slider.Size = UDim2.new(0.9, 0, 0.12, 0)
slider.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
slider.TextColor3 = Color3.new(1, 1, 1)
slider.Text = tostring(headSize)
slider.Font = Enum.Font.Gotham
slider.TextSize = 14
slider.ClearTextOnFocus = false
Instance.new("UICorner", slider).CornerRadius = UDim.new(0, 6)

-- تيك توك
local tiktokLabel = Instance.new("TextLabel", frame)
tiktokLabel.Position = UDim2.new(0.05, 0, 0.52, 0)
tiktokLabel.Size = UDim2.new(0.9, 0, 0.1, 0)
tiktokLabel.BackgroundTransparency = 1
tiktokLabel.Text = "TikTok: hf4_l@"
tiktokLabel.TextColor3 = Color3.new(1, 1, 1)
tiktokLabel.Font = Enum.Font.Gotham
tiktokLabel.TextSize = 16
tiktokLabel.TextXAlignment = Enum.TextXAlignment.Left

-- عنوان قائمة المحظورين
local blockedLabel = Instance.new("TextLabel", frame)
blockedLabel.Size = UDim2.new(1, 0, 0, 20)
blockedLabel.Position = UDim2.new(0, 0, 0.63, 0)
blockedLabel.BackgroundTransparency = 1
blockedLabel.Text = "🚫 قائمة المحظورين"
blockedLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
blockedLabel.Font = Enum.Font.GothamBold
blockedLabel.TextSize = 16
blockedLabel.TextXAlignment = Enum.TextXAlignment.Center

-- صندوق قائمة المحظورين مع التمرير والأزرار الأنيقة
local blockedList = Instance.new("ScrollingFrame", frame)
blockedList.Size = UDim2.new(0.9, 0, 0.32, 0)
blockedList.Position = UDim2.new(0.05, 0, 0.68, 0)
blockedList.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
blockedList.BorderSizePixel = 0
blockedList.ScrollBarThickness = 6
blockedList.VerticalScrollBarInset = Enum.ScrollBarInset.Always -- scrollbar ظاهر دايمًا
Instance.new("UICorner", blockedList).CornerRadius = UDim.new(0, 6)

local layout = Instance.new("UIListLayout", blockedList)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 6)

-- دالة لإضافة عنصر محظور مع زر حذف
local function addBlockedUser(name)
    local entry = Instance.new("Frame", blockedList)
    entry.Size = UDim2.new(1, -10, 0, 28)
    entry.BackgroundColor3 = Color3.fromRGB(45, 0, 0)
    entry.BorderSizePixel = 0
    entry.Position = UDim2.new(0, 5, 0, 0)
    Instance.new("UICorner", entry).CornerRadius = UDim.new(0, 5)

    local nameLabel = Instance.new("TextLabel", entry)
    nameLabel.Size = UDim2.new(0.8, 0, 1, 0)
    nameLabel.Position = UDim2.new(0, 5, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 16
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.TextYAlignment = Enum.TextYAlignment.Center

    local removeBtn = Instance.new("TextButton", entry)
    removeBtn.Size = UDim2.new(0.15, 0, 0.7, 0)
    removeBtn.Position = UDim2.new(0.82, 0, 0.15, 0)
    removeBtn.BackgroundColor3 = Color3.fromRGB(180, 20, 20)
    removeBtn.TextColor3 = Color3.new(1, 1, 1)
    removeBtn.Text = "❌"
    removeBtn.Font = Enum.Font.GothamBold
    removeBtn.TextSize = 20
    removeBtn.AutoButtonColor = true
    removeBtn.ClipsDescendants = true
    removeBtn.MouseButton1Click:Connect(function()
        BlockedUsers[name] = nil
        entry:Destroy()
    end)

    -- تأثير تغيير اللون لما تمرر الماوس على العنصر
    entry.MouseEnter:Connect(function()
        entry.BackgroundColor3 = Color3.fromRGB(70, 0, 0)
    end)
    entry.MouseLeave:Connect(function()
        entry.BackgroundColor3 = Color3.fromRGB(45, 0, 0)
    end)
end

for name, _ in pairs(BlockedUsers) do
    addBlockedUser(name)
end

local closeButton = Instance.new("TextButton", frame)
closeButton.Position = UDim2.new(1, -25, 0, 0)
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
closeButton.MouseButton1Click:Connect(function()
    frame.Visible = false
end)

local minimizeButton = Instance.new("TextButton", frame)
minimizeButton.Position = UDim2.new(1, -50, 0, 0)
minimizeButton.Size = UDim2.new(0, 25, 0, 25)
minimizeButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.Text = "-"
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 18
minimizeButton.MouseButton1Click:Connect(function()
    frame.Visible = false
end)

toggle.MouseButton1Click:Connect(function()
    hitboxEnabled = not hitboxEnabled
    toggle.Text = "HitBox: " .. (hitboxEnabled and "ON" or "OFF")

    if not hitboxEnabled then  
        for _, player in ipairs(Players:GetPlayers()) do  
            if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then  
                local part = player.Character.HumanoidRootPart  
                part.Size = Vector3.new(2, 2, 1)  
                part.Transparency = 0  
                part.Material = Enum.Material.Plastic  
                part.BrickColor = BrickColor.new("Medium stone grey")  
                part.CanCollide = true  
            end  
        end  
    end
end)

slider:GetPropertyChangedSignal("Text"):Connect(function()
    local value = tonumber(slider.Text)
    if value and value >= 1 and value <= 100 then
        headSize = value
        sliderLabel.Text = "Size: " .. value
    end
end)

openButton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

RunService.RenderStepped:Connect(function()
    if not hitboxEnabled or not localPlayer then return end

    local myTeam = localPlayer.Team  

    for _, player in ipairs(Players:GetPlayers()) do  
        if player ~= localPlayer then  
            local char = player.Character  
            local hrp = char and char:FindFirstChild("HumanoidRootPart")  

            if hrp and char:IsDescendantOf(game) then  
                if not teamCheck or player.Team ~= myTeam then  
                    hrp.Size = Vector3.new(headSize, headSize, headSize)  
                    hrp.Transparency = 0.8  
                    hrp.BrickColor = BrickColor.new("Lime green")  
                    hrp.Material = Enum.Material.Neon  
                    hrp.CanCollide = false  
                end  
            elseif hrp then  
                hrp.Size = Vector3.new(2, 2, 1)  
                hrp.Transparency = 1  
                hrp.BrickColor = BrickColor.new("Medium stone grey")  
                hrp.Material = Enum.Material.Plastic  
                hrp.CanCollide = true  
            end  
        end  
    end
end)
