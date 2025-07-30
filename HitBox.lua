-- نظام تفعيل بمفتاح + صلاحية 48 ساعة
local KEY = "anwar12233"
local EXPIRY = 48 * 60 * 60 -- 48 ساعة بالثواني
local KEY_FILE = "DevAnwar_KeyTime.txt"

local function saveTime()
    if writefile then
        writefile(KEY_FILE, tostring(os.time()))
    end
end

local function isKeyActive()
    if isfile and readfile and isfile(KEY_FILE) then
        local last = tonumber(readfile(KEY_FILE))
        return last and (os.time() - last < EXPIRY)
    end
    return false
end

local function getRemainingTime()
    if isfile and readfile and isfile(KEY_FILE) then
        local last = tonumber(readfile(KEY_FILE))
        if last then
            local left = EXPIRY - (os.time() - last)
            if left < 0 then return 0 end
            return left
        end
    end
    return 0
end

local function formatTime(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    return string.format("%02d:%02d", hours, minutes)
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- انتظار وجود LocalPlayer و Character
local function waitForLocalPlayer()
    local player = Players.LocalPlayer
    while not player do
        wait()
        player = Players.LocalPlayer
    end
    while not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") do
        wait()
    end
    return player
end

local function loadHitboxScript()
    local localPlayer = waitForLocalPlayer()

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
    frame.Size = UDim2.new(0, 300, 0, 240)
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

    local timeLeftLabel = Instance.new("TextLabel", frame)
    timeLeftLabel.Position = UDim2.new(0.05, 0, 0.7, 0)
    timeLeftLabel.Size = UDim2.new(0.9, 0, 0.1, 0)
    timeLeftLabel.BackgroundTransparency = 1
    timeLeftLabel.Text = "⏳ الوقت المتبقي: " .. formatTime(getRemainingTime())
    timeLeftLabel.TextColor3 = Color3.fromRGB(255,255,255)
    timeLeftLabel.Font = Enum.Font.Gotham
    timeLeftLabel.TextSize = 14

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

    openButton.MouseButton1Click:Connect(function()
        frame.Visible = not frame.Visible
    end)

    slider:GetPropertyChangedSignal("Text"):Connect(function()
        local value = tonumber(slider.Text)
        if value and value >= 1 and value <= 100 then
            headSize = value
            sliderLabel.Text = "Size: " .. value
        end
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
                end
            end
        end

        timeLeftLabel.Text = "⏳ الوقت المتبقي: " .. formatTime(getRemainingTime())
    end)
end

-- واجهة التحقق من المفتاح
if isKeyActive() then
    loadHitboxScript()
else
    local gui = Instance.new("ScreenGui", game.CoreGui)
    gui.Name = "DevAnwar_KeyGUI"
    gui.ResetOnSpawn = false

    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0, 320, 0, 240)
    main.Position = UDim2.new(0.5, -160, 0.5, -120)
    main.BackgroundColor3 = Color3.fromRGB(10,10,10)
    main.Active = true
    main.Draggable = true
    Instance.new("UICorner", main).CornerRadius = UDim.new(0,8)

    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundTransparency = 1
    title.Text = "ادخل المفتاح لتفعيل سكربت HitBox\nEnter Key to Activate HitBox"
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextWrapped = true

    local box = Instance.new("TextBox", main)
    box.PlaceholderText = "اكتب المفتاح هنا / Enter Key Here"
    box.Size = UDim2.new(0.9, 0, 0, 35)
    box.Position = UDim2.new(0.05, 0, 0.35, 0)
    box.BackgroundColor3 = Color3.fromRGB(30,30,30)
    box.TextColor3 = Color3.new(1,1,1)
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    box.ClearTextOnFocus = false

    local checkButton = Instance.new("TextButton", main)
    checkButton.Text = "✅ تأكيد / Confirm"
    checkButton.Size = UDim2.new(0.9, 0, 0, 35)
    checkButton.Position = UDim2.new(0.05, 0, 0.7, 0)
    checkButton.BackgroundColor3 = Color3.fromRGB(20,100,20)
    checkButton.TextColor3 = Color3.new(1,1,1)
    checkButton.Font = Enum.Font.GothamBold
    checkButton.TextSize = 16

    local copyButton = Instance.new("TextButton", main)
    copyButton.Text = "📋 نسخ رابط المفتاح"
    copyButton.Size = UDim2.new(0.9, 0, 0, 35)
    copyButton.Position = UDim2.new(0.05, 0, 0.58, 0)
    copyButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
    copyButton.TextColor3 = Color3.new(1,1,1)
    copyButton.Font = Enum.Font.Gotham
    copyButton.TextSize = 14

    copyButton.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard("https://direct-link.net/1376498/WRpu4mqGF3OM")
            copyButton.Text = "✔️ تم النسخ!"
        else
            copyButton.Text = "❌ نسخ غير مدعوم"
        end
    end)

    local function validateKey()
        if box.Text:lower() == KEY:lower() then
            saveTime()
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
end
