--// سكربت Dev.Anwar HitBox نسخة 1.4 محدثة
--// تم حل مشكلة بقاء الهيت بوكس بعد موت اللاعب
--// تمت إضافة زر Team Check داخل القائمة
--// Team Check يكون OFF افتراضياً

local KEY = "lol"

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

local function loadHitboxScript()
    local headSize = 20
    local hitboxEnabled = false
    local teamCheck = false -- افتراضياً طافي
    local deadPlayers = {}

    local function resetHitbox(player)
        local char = player and player.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Size = Vector3.new(2, 2, 1)
                hrp.Transparency = 0
                hrp.Material = Enum.Material.Plastic
                hrp.BrickColor = BrickColor.new("Medium stone grey")
                hrp.CanCollide = true
            end
        end
    end

    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(char)
            deadPlayers[player] = nil
            local hum = char:WaitForChild("Humanoid", 5)
            if hum then
                hum.Died:Connect(function()
                    resetHitbox(player)
                    deadPlayers[player] = true
                end)
            end
        end)
    end)

    for _, player in ipairs(Players:GetPlayers()) do
        player.CharacterAdded:Connect(function(char)
            deadPlayers[player] = nil
            local hum = char:WaitForChild("Humanoid", 5)
            if hum then
                hum.Died:Connect(function()
                    resetHitbox(player)
                    deadPlayers[player] = true
                end)
            end
        end)
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DevAnwar_GUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game.CoreGui

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
    frame.Size = UDim2.new(0, 300, 0, 260)
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
    updateLabel.Text = "📌 تحديث / Version 1.4 - Team Check افتراضي طافي + تحديث فوري"
    updateLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
    updateLabel.Font = Enum.Font.Gotham
    updateLabel.TextSize = 14
    updateLabel.TextXAlignment = Enum.TextXAlignment.Center

    local toggle = Instance.new("TextButton", frame)
    toggle.Position = UDim2.new(0.05, 0, 0.2, 0)
    toggle.Size = UDim2.new(0.9, 0, 0.13, 0)
    toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    toggle.TextColor3 = Color3.new(1, 1, 1)
    toggle.Text = "HitBox: OFF"
    toggle.Font = Enum.Font.Gotham
    toggle.TextSize = 16

    local teamToggle = Instance.new("TextButton", frame)
    teamToggle.Position = UDim2.new(0.05, 0, 0.35, 0)
    teamToggle.Size = UDim2.new(0.9, 0, 0.1, 0)
    teamToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    teamToggle.TextColor3 = Color3.new(1, 1, 1)
    teamToggle.Text = "Team Check: OFF"
    teamToggle.Font = Enum.Font.Gotham
    teamToggle.TextSize = 14

    local sliderLabel = Instance.new("TextLabel", frame)
    sliderLabel.Position = UDim2.new(0.05, 0, 0.48, 0)
    sliderLabel.Size = UDim2.new(0.9, 0, 0.1, 0)
    sliderLabel.BackgroundTransparency = 1
    sliderLabel.Text = "Size: 20"
    sliderLabel.TextColor3 = Color3.new(1, 1, 1)
    sliderLabel.Font = Enum.Font.Gotham
    sliderLabel.TextSize = 14

    local slider = Instance.new("TextBox", frame)
    slider.Position = UDim2.new(0.05, 0, 0.59, 0)
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

    local tiktokLabel = Instance.new("TextLabel", frame)
    tiktokLabel.Position = UDim2.new(0.05, 0, 0.75, 0)
    tiktokLabel.Size = UDim2.new(0.9, 0, 0.15, 0)
    tiktokLabel.BackgroundTransparency = 1
    tiktokLabel.Text = "TikTok: hf4_l@"
    tiktokLabel.TextColor3 = Color3.new(1, 1, 1)
    tiktokLabel.Font = Enum.Font.Gotham
    tiktokLabel.TextSize = 16
    tiktokLabel.TextXAlignment = Enum.TextXAlignment.Left

    toggle.MouseButton1Click:Connect(function()
        hitboxEnabled = not hitboxEnabled
        toggle.Text = "HitBox: " .. (hitboxEnabled and "ON" or "OFF")
        if not hitboxEnabled then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= localPlayer then
                    resetHitbox(player)
                end
            end
        end
    end)

    teamToggle.MouseButton1Click:Connect(function()
        teamCheck = not teamCheck
        teamToggle.Text = "Team Check: " .. (teamCheck and "ON" or "OFF")
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer then
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    if teamCheck and player.Team == localPlayer.Team then
                        resetHitbox(player)
                    elseif hitboxEnabled then
                        hrp.Size = Vector3.new(headSize, headSize, headSize)
                        hrp.Transparency = 0.8
                        hrp.BrickColor = BrickColor.new("Lime green")
                        hrp.Material = Enum.Material.Neon
                        hrp.CanCollide = false
                    end
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
            if player ~= localPlayer and not deadPlayers[player] then
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChild("Humanoid")
                if hrp and hum and hum.Health > 0 then
                    if not teamCheck or player.Team ~= myTeam then
                        hrp.Size = Vector3.new(headSize, headSize, headSize)
                        hrp.Transparency = 0.8
                        hrp.BrickColor = BrickColor.new("Lime green")
                        hrp.Material = Enum.Material.Neon
                        hrp.CanCollide = false
                    end
                end
            end
        end
    end)
end

-- واجهة المفتاح
local gui = Instance.new("ScreenGui")
gui.Name = "DevAnwar_KeyGUI"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 340, 0, 260)
main.Position = UDim2.new(0.5, -170, 0.5, -130)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "🔐 ادخل المفتاح لتفعيل HitBox\nEnter Key to Activate HitBox"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextWrapped = true

-- 📢 الملاحظة الجديدة
local note = Instance.new("TextLabel", main)
note.Size = UDim2.new(1, 0, 0, 30)
note.Position = UDim2.new(0, 0, 0, 40)
note.BackgroundTransparency = 1
note.TextColor3 = Color3.fromRGB(255, 200, 0)
note.Font = Enum.Font.GothamBold
note.TextSize = 14
note.TextWrapped = true
note.Text = "📢 سوف يتم الغاء نظام المفتاح من الرابط أو سيكون فقط في الديسكورد: https://discord.gg/ypjdng9N"

local box = Instance.new("TextBox", main)
box.PlaceholderText = "اكتب المفتاح هنا / Enter Key Here"
box.Size = UDim2.new(0.9, 0, 0, 35)
box.Position = UDim2.new(0.05, 0, 0.35, 0)
box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
box.TextColor3 = Color3.new(1, 1, 1)
box.Font = Enum.Font.Gotham
box.TextSize = 14
box.ClearTextOnFocus = false

local checkButton = Instance.new("TextButton", main)
checkButton.Text = "✅ تأكيد / Confirm"
checkButton.Size = UDim2.new(0.9, 0, 0, 35)
checkButton.Position = UDim2.new(0.05, 0, 0.7, 0)
checkButton.BackgroundColor3 = Color3.fromRGB(20, 100, 20)
checkButton.TextColor3 = Color3.new(1, 1, 1)
checkButton.Font = Enum.Font.GothamBold
checkButton.TextSize = 16

local copyKey = Instance.new("TextButton", main)
copyKey.Text = "📋 نسخ رابط الموقع"
copyKey.Size = UDim2.new(0.43, 0, 0, 35)
copyKey.Position = UDim2.new(0.05, 0, 0.58, 0)
copyKey.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
copyKey.TextColor3 = Color3.new(1, 1, 1)
copyKey.Font = Enum.Font.Gotham
copyKey.TextSize = 14

local copyDiscord = Instance.new("TextButton", main)
copyDiscord.Text = "📎 رابط الديسكورد"
copyDiscord.Size = UDim2.new(0.43, 0, 0, 35)
copyDiscord.Position = UDim2.new(0.52, 0, 0.58, 0)
copyDiscord.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
copyDiscord.TextColor3 = Color3.new(1, 1, 1)
copyDiscord.Font = Enum.Font.Gotham
copyDiscord.TextSize = 14

copyKey.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://direct-link.net/1376498/WRpu4mqGF3OM")
        copyKey.Text = "✔️ تم النسخ!"
    end
end)

copyDiscord.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://discord.gg/ypjdng9N")
        copyDiscord.Text = "✔️ تم النسخ!"
    end
end)

local function validateKey()
    if box.Text:lower() == KEY:lower() then
        gui:Destroy()
        loadHitboxScript()
    else
        box.Text = ""
        box.PlaceholderText = "❌ مفتاح غير صحيح / Wrong Key"
    end
end

checkButton.MouseButton1Click:Connect(validateKey)
box.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        validateKey()
    end
end)
