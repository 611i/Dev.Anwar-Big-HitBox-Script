local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

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
