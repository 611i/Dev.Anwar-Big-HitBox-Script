-- Dev.Anwar 🇮🇶 | TikTok: @hf4_l
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local localPlayer = Players.LocalPlayer

local allowedUser = "ms7976559ff"
local webhookURL = "https://discord.com/api/webhooks/1400087388478509117/xgmAnyGPRki8zfSxANO9NzpRPlXo02K5WreHFU4C9bIR6LYm04NZ7s6Bb4KkpWrvIqy1"

-- جدول المحظورين (حدثه يدويًا)
local BlockedUsers = {
    ["Noob123"] = true,
    ["ToxicPlayer"] = true,
}

-- جدول المستخدمين المعروفين (تحدثه يدويًا لو تحب)
local KnownUsers = {
    "ms7976559ff",
    "Player1",
    "Player2",
    "Player3",
}

-- طرد اللاعب لو محظور
if BlockedUsers[localPlayer.Name] then
    localPlayer:Kick("🚫 تم حظرك من استخدام هذا السكربت بواسطة Dev.Anwar.")
    return
end

-- إرسال اسم اللاعب إلى Webhook ديسكورد (بكل تشغيل)
pcall(function()
    HttpService:PostAsync(webhookURL, HttpService:JSONEncode({
        content = "اللاعب شغل السكربت: **" .. localPlayer.Name .. "**"
    }), Enum.HttpContentType.ApplicationJson)
end)

-- عرض قائمة التحكم الخاصة فقط لصاحب السكربت
if localPlayer.Name == allowedUser then

    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.Name = "DevAnwar_Control"

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 420, 0, 320)
    MainFrame.Position = UDim2.new(0.5, -210, 0.5, -160)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true

    local Title = Instance.new("TextLabel", MainFrame)
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.BackgroundTransparency = 1
    Title.Text = "🛠️ لوحة التحكم Dev.Anwar"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18

    local Scroller = Instance.new("ScrollingFrame", MainFrame)
    Scroller.Size = UDim2.new(1, -10, 1, -50)
    Scroller.Position = UDim2.new(0, 5, 0, 40)
    Scroller.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Scroller.BorderSizePixel = 0
    Scroller.CanvasSize = UDim2.new(0, 0, 0, (#KnownUsers) * 40)
    Scroller.ScrollBarThickness = 6

    for i, name in ipairs(KnownUsers) do
        local entry = Instance.new("Frame", Scroller)
        entry.Size = UDim2.new(1, -10, 0, 35)
        entry.Position = UDim2.new(0, 5, 0, (i - 1) * 35)
        entry.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        entry.BorderSizePixel = 0

        local nameLabel = Instance.new("TextLabel", entry)
        nameLabel.Size = UDim2.new(0.6, 0, 1, 0)
        nameLabel.Position = UDim2.new(0, 5, 0, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = name
        nameLabel.TextColor3 = Color3.new(1, 1, 1)
        nameLabel.Font = Enum.Font.SourceSansBold
        nameLabel.TextSize = 16
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left

        local blockButton = Instance.new("TextButton", entry)
        blockButton.Size = UDim2.new(0.18, 0, 0.7, 0)
        blockButton.Position = UDim2.new(0.65, 0, 0.15, 0)
        blockButton.Text = "🚫 إيقاف"
        blockButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        blockButton.TextColor3 = Color3.new(1, 1, 1)
        blockButton.Font = Enum.Font.Gotham
        blockButton.TextSize = 14
        blockButton.MouseButton1Click:Connect(function()
            setclipboard('["'..name..'"] = true') -- ينسخ كود الحظر عشان تحدثه يدويًا
            print("📌 انسخ هذا الاسم وأضفه داخل BlockedUsers لحظره: " .. name)
        end)

        local allowButton = Instance.new("TextButton", entry)
        allowButton.Size = UDim2.new(0.18, 0, 0.7, 0)
        allowButton.Position = UDim2.new(0.83, 0, 0.15, 0)
        allowButton.Text = "✅ تشغيل"
        allowButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        allowButton.TextColor3 = Color3.new(1, 1, 1)
        allowButton.Font = Enum.Font.Gotham
        allowButton.TextSize = 14
        allowButton.MouseButton1Click:Connect(function()
            print("✅ تم السماح لـ " .. name .. " (تأكد من إزالة اسمه من BlockedUsers)")
        end)
    end
end

-- =======================
--   سكربت الهيت بوكس الأساسي
-- =======================

local headSize = 20
local hitboxEnabled = false
local teamCheck = true

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
slider.Size = UDim2.new(0.9
