local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local TELEGRAM_URL = "https://t.me/furizanscript"
local CORRECT_KEY = "furik"

-- GUI setup
local gui = Instance.new("ScreenGui", playerGui)
gui.Name = "FurikFinalGUI"
gui.ResetOnSpawn = false

local bg = Instance.new("Frame", gui)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
bg.BackgroundTransparency = 0.5

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 460, 0, 300)
frame.Position = UDim2.new(0.5, -230, 0.05, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

frame.BackgroundTransparency = 1
TweenService:Create(frame, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 5)
title.Text = "Ключ доступа"
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1

local info = Instance.new("TextLabel", frame)
info.Size = UDim2.new(1, -40, 0, 40)
info.Position = UDim2.new(0, 20, 0, 60)
info.Text = "Найди ключ в Telegram:"
info.Font = Enum.Font.Gotham
info.TextSize = 16
info.TextColor3 = Color3.fromRGB(200, 200, 200)
info.BackgroundTransparency = 1
info.TextWrapped = true
info.TextXAlignment = Enum.TextXAlignment.Left

local copyButton = Instance.new("TextButton", frame)
copyButton.Size = UDim2.new(1, -40, 0, 36)
copyButton.Position = UDim2.new(0, 20, 0, 105)
copyButton.Text = "Скопировать ссылку"
copyButton.Font = Enum.Font.GothamBold
copyButton.TextSize = 16
copyButton.TextColor3 = Color3.new(1,1,1)
copyButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Instance.new("UICorner", copyButton).CornerRadius = UDim.new(0, 10)

local keyBox = Instance.new("TextBox", frame)
keyBox.Size = UDim2.new(1, -40, 0, 42)
keyBox.Position = UDim2.new(0, 20, 0, 155)
keyBox.PlaceholderText = "Введите ключ..."
keyBox.Text = ""
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 18
keyBox.TextColor3 = Color3.new(1, 1, 1)
keyBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 10)

local submit = Instance.new("TextButton", frame)
submit.Size = UDim2.new(1, -40, 0, 42)
submit.Position = UDim2.new(0, 20, 0, 210)
submit.Text = "Продолжить"
submit.Font = Enum.Font.GothamBold
submit.TextSize = 18
submit.TextColor3 = Color3.new(1, 1, 1)
submit.BackgroundColor3 = Color3.fromRGB(40, 130, 90)
Instance.new("UICorner", submit).CornerRadius = UDim.new(0, 10)

-- Sounds
local clickSound = Instance.new("Sound", SoundService)
clickSound.SoundId = "rbxassetid://12221967" -- Click
clickSound.Volume = 1

copyButton.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard(TELEGRAM_URL)
		clickSound:Play()
		copyButton.Text = "Скопировано!"
		wait(1.5)
		copyButton.Text = "Скопировать ссылку"
	end
end)

local function makeDraggable(button)
	local dragging, offset
	button.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			offset = input.Position - button.AbsolutePosition
		end
	end)
	button.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			button.Position = UDim2.new(0, input.Position.X - offset.X, 0, input.Position.Y - offset.Y)
		end
	end)
end

local function showButtons()
	gui:ClearAllChildren()

	local x10 = Instance.new("TextButton", gui)
	x10.Size = UDim2.new(0, 160, 0, 60)
	x10.Position = UDim2.new(0.4, -180, 0.45, 0)
	x10.Text = "x10 Инвентарь"
	x10.Font = Enum.Font.GothamBlack
	x10.TextColor3 = Color3.fromRGB(255, 255, 255)
	x10.TextScaled = true
	x10.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	Instance.new("UICorner", x10).CornerRadius = UDim.new(0, 12)

	local itemInput = Instance.new("TextBox", gui)
	itemInput.Size = UDim2.new(0, 160, 0, 60)
	itemInput.Position = UDim2.new(0.6, 20, 0.45, 0)
	itemInput.PlaceholderText = "Название предмета"
	itemInput.Text = ""
	itemInput.Font = Enum.Font.Gotham
	itemInput.TextScaled = true
	itemInput.TextColor3 = Color3.new(1, 1, 1)
	itemInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Instance.new("UICorner", itemInput).CornerRadius = UDim.new(0, 12)

	local confirmBtn = Instance.new("TextButton", gui)
	confirmBtn.Size = UDim2.new(0, 160, 0, 40)
	confirmBtn.Position = UDim2.new(0.6, 20, 0.55, 70)
	confirmBtn.Text = "Добавить"
	confirmBtn.Font = Enum.Font.GothamBold
	confirmBtn.TextColor3 = Color3.new(1,1,1)
	confirmBtn.TextScaled = true
	confirmBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
	Instance.new("UICorner", confirmBtn).CornerRadius = UDim.new(0, 10)

	makeDraggable(x10)
	makeDraggable(itemInput)
	makeDraggable(confirmBtn)

	x10.MouseButton1Click:Connect(function()
		clickSound:Play()
		local backpack = player:FindFirstChild("Backpack")
		if backpack then
			for _, tool in pairs(backpack:GetChildren()) do
				if tool:IsA("Tool") then
					for i = 1, 9 do
						tool:Clone().Parent = backpack
					end
				end
			end
		end
	end)

	confirmBtn.MouseButton1Click:Connect(function()
		clickSound:Play()
		local itemName = itemInput.Text
		if itemName and itemName ~= "" then
			local tool = Instance.new("Tool")
			tool.Name = itemName
			tool.RequiresHandle = false
			tool.CanBeDropped = false
			tool.Parent = player:FindFirstChild("Backpack")
		end
	end)
end

submit.MouseButton1Click:Connect(function()
	clickSound:Play()
	if keyBox.Text:lower() == CORRECT_KEY then
		showButtons()
	else
		player:Kick("Неверный ключ.")
	end
end)

