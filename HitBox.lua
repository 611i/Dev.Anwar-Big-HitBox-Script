--// بداية سكربت Dev.Anwar بنظام مفتاح متغير كل 48 ساعة + طلب مفتاح ثنائي اللغة

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer

-- المفاتيح المتغيرة كل 48 ساعة (كل يومين)
local keys = {
    "anwar12233",
    "Anwar1lol1",
    "anwar00011",
    "000anwar1011"
}

local function getCurrentKey()
    local currentTime = os.time()
    local period = math.floor(currentTime / (48*60*60)) -- 48 ساعة بالثواني
    local index = (period % #keys) + 1
    return keys[index]
end

-- رابط المفتاح للنسخ
local keyLink = "https://direct-link.net/1376498/WRpu4mqGF3OM"

-- تخزين حالة التفعيل محلياً (لا يتم حفظه بالخادم)
local activated = false

-- إنشاء واجهة طلب المفتاح
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "DevAnwar_KeyGui"
screenGui.ResetOnSpawn = false

local overlay = Instance.new("Frame", screenGui)
overlay.Size = UDim2.new(1,0,1,0)
overlay.BackgroundColor3 = Color3.fromRGB(20,20,20)
overlay.BackgroundTransparency = 0.85
overlay.BorderSizePixel = 0
overlay.AnchorPoint = Vector2.new(0,0)
overlay.Position = UDim2.new(0,0,0,0)

local titleLabel = Instance.new("TextLabel", overlay)
titleLabel.Size = UDim2.new(1,0,0,60)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "ادخل مفتاح التفعيل / Enter Activation Key"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 28
titleLabel.TextColor3 = Color3.fromRGB(0,255,127)
titleLabel.TextWrapped = true
titleLabel.TextYAlignment = Enum.TextYAlignment.Center
titleLabel.Position = UDim2.new(0,0,0,20)

local inputBox = Instance.new("TextBox", overlay)
inputBox.Size = UDim2.new(0.6,0,0,40)
inputBox.Position = UDim2.new(0.2,0,0,100)
inputBox.ClearTextOnFocus = false
inputBox.Font = Enum.Font.Gotham
inputBox.PlaceholderText = "اكتب المفتاح هنا / Type key here"
inputBox.TextSize = 20
inputBox.TextColor3 = Color3.new(1,1,1)
inputBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
inputBox.BorderSizePixel = 0
inputBox.Text = ""

local errorLabel = Instance.new("TextLabel", overlay)
errorLabel.Size = UDim2.new(1,0,0,30)
errorLabel.Position = UDim2.new(0,0,0,150)
errorLabel.BackgroundTransparency = 1
errorLabel.TextColor3 = Color3.fromRGB(255,50,50)
errorLabel.Font = Enum.Font.Gotham
errorLabel.TextSize = 18
errorLabel.Text = ""
errorLabel.TextWrapped = true
errorLabel.TextYAlignment = Enum.TextYAlignment.Center

local copyButton = Instance.new("TextButton", overlay)
copyButton.Size = UDim2.new(0.3,0,0,40)
copyButton.Position = UDim2.new(0.35,0,0,200)
copyButton.BackgroundColor3 = Color3.fromRGB(0,120,0)
copyButton.TextColor3 = Color3.new(1,1,1)
copyButton.Font = Enum.Font.GothamBold
copyButton.TextSize = 20
copyButton.Text = "نسخ رابط المفتاح / Copy Key Link"

local function closeKeyGui()
    screenGui.Enabled = false
    overlay.Visible = false
end

local function showKeyGui()
    screenGui.Enabled = true
    overlay.Visible = true
end

-- تأكيد المفتاح
local function checkKey(input)
    local currentKey = getCurrentKey()
    if input == currentKey then
        activated = true
        closeKeyGui()
        openButton.Visible = true
        frame.Visible = false -- نخليها مقفولة لحين يفتحها المستخدم
    else
        errorLabel.Text = "مفتاح غير صحيح، حاول مرة أخرى.\nInvalid key, try again."
        wait(2)
        errorLabel.Text = ""
    end
end

copyButton.MouseButton1Click:Connect(function()
    -- نسخ الرابط للكيبورد
    pcall(function()
        setclipboard(keyLink)
    end)
    copyButton.Text = "تم النسخ! / Copied!"
    wait(2)
    copyButton.Text = "نسخ رابط المفتاح / Copy Key Link"
end)

inputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        checkKey(inputBox.Text)
        inputBox.Text = ""
    end
end)

-- الآن ندمج القائمة الأصلية الخاصة بك (مخفية في البداية)
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
openButton.Visible = false

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

local tiktokLabel = Instance.new("TextLabel", frame)
tiktokLabel.Position = UDim2.new(0.05, 0, 0.75, 0)
tiktokLabel.Size = UDim2.new(0.9, 0, 0.15, 0)
tiktokLabel.BackgroundTransparency = 1
tiktokLabel.Text = "TikTok
