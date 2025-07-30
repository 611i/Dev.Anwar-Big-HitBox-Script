-- Dev.Anwar 🇮🇶 | TikTok: @hf4_l
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local localPlayer = Players.LocalPlayer
local allowedUserId = 2637565684 -- غيرها لليوزر حقك
local webhookURL = "https://discord.com/api/webhooks/1400087388478509117/xgmAnyGPRki8zfSxANO9NzpRPlXo02K5WreHFU4C9bIR6LYm04NZ7s6Bb4KkpWrvIqy1"

-- المحظورين (بـ UserId)
local BlockedUsers = {
    [123456789] = true,
    [987654321] = true,
}

-- طرد المحظور
if BlockedUsers[localPlayer.UserId] then
    localPlayer:Kick("🚫 تم حظرك من استخدام هذا السكربت بواسطة Dev.Anwar.")
    return
end

-- إرسال Webhook
pcall(function()
    HttpService:PostAsync(webhookURL, HttpService:JSONEncode({
        content = "🎮 اللاعب دخل السكربت: **" .. localPlayer.Name .. "** | UserId: `" .. localPlayer.UserId .. "`"
    }), Enum.HttpContentType.ApplicationJson)
end)

------------------------
-- GUI للجميع
------------------------

local guiParent = localPlayer:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui", guiParent)
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
frame.Size = UDim2.new(0, 300, 0, 210)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.Visible = false
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "made by: Anwar🇮🇶"
title.TextColor3 = Color3.fromRGB(0, 255, 127)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local updateLabel = Instance.new("TextLabel", frame)
updateLabel.Size = UDim2.new(1, 0, 0, 20)
updateLabel.Position = UDim2.new(0, 0, 0.9, 0)
updateLabel.BackgroundTransparency = 1
updateLabel.Text = "Version 1.1 - تم تحديث السكربت"
updateLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
updateLabel.Font = Enum.Font.Gotham
updateLabel.TextSize = 14
updateLabel.TextXAlignment = Enum.TextXAlignment.Center

local toggle = Instance.new("TextButton", frame)
toggle.Position = UDim2.new(0.05, 0, 0.25, 0)
toggle.Size = UDim2.new(0.9, 0, 0.15, 0)
toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.Text = "HitBox: OFF"
toggle.Font = Enum.Font.Gotham
toggle.TextSize = 16

local sliderLabel = Instance.new("TextLabel", frame)
sliderLabel.Position = UDim2.new(0.05, 0, 0.43, 0)
sliderLabel.Size = UDim2.new(0.9, 0, 0.1, 0)
sliderLabel.BackgroundTransparency = 1
sliderLabel.Text = "Size: 20"
sliderLabel.TextColor3 = Color3.new(1, 1, 1)
sliderLabel.Font = Enum.Font.Gotham
sliderLabel.TextSize = 14

local slider = Instance.new("TextBox", frame)
slider.Position = UDim2.new(0.05, 0, 0.55, 0)
slider.Size = UDim2.new(0.9, 0, 0.13, 0)
slider.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
slider.TextColor3 = Color3.new(1, 1, 1)
slider.Text = "20"
slider.Font = Enum.Font.Gotham
slider.TextSize = 14
slider.ClearTextOnFocus = false

openButton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- Hitbox Variables
local headSize = 20
local hitboxEnabled = false

toggle.MouseButton1Click:Connect(function()
    hitboxEnabled = not hitboxEnabled
    toggle.Text = "HitBox: " .. (hitboxEnabled and "ON" or "OFF")
end)

slider:GetPropertyChangedSignal("Text"):Connect(function()
    local value = tonumber(slider.Text)
    if value and value >= 1 and value <= 100 then
        headSize = value
        sliderLabel.Text = "Size: " .. value
    end
end)

-- تشغيل الهيت بوكس
RunService.RenderStepped:Connect(function()
    if not hitboxEnabled then return end
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Size = Vector3.new(headSize, headSize, headSize)
                hrp.Transparency = 0.8
                hrp.BrickColor = BrickColor.White()
                hrp.Material = Enum.Material.Neon
                hrp.CanCollide = false
            end
        end
    end
end)

-----------------------------
-- لوحة الحظر (لك أنت فقط)
-----------------------------
if localPlayer.UserId == allowedUserId then
    local controlGui = Instance.new("ScreenGui", guiParent)
    controlGui.Name = "ControlPanel_DevAnwar"

    local panel = Instance.new("Frame", controlGui)
    panel.Size = UDim2.new(0, 250, 0, 100)
    panel.Position = UDim2.new(0.5, -125, 0, 60)
    panel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    panel.BorderSizePixel = 0
    panel.Active = true
    panel.Draggable = true

    local label = Instance.new("TextLabel", panel)
    label.Size = UDim2.new(1, 0, 0, 30)
    label.BackgroundTransparency = 1
    label.Text = "🛡️ قائمة الحظر Dev.Anwar"
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16

    local note = Instance.new("TextLabel", panel)
    note.Size = UDim2.new(1, -10, 0, 60)
    note.Position = UDim2.new(0, 5, 0, 35)
    note.BackgroundTransparency = 1
    note.Text = "انسخ اسم اللاعب واحفظه يدويًا في BlockedUsers"
    note.TextColor3 = Color3.fromRGB(0, 255, 127)
    note.Font = Enum.Font.Gotham
    note.TextSize = 14
    note.TextWrapped = true
end
