--// RAGESPLOIT FLUENT HUB v3 (VISUAL ONLY + NEON + PARTICLES)

local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")

------------------------------------------------
-- RAINBOW ENGINE
------------------------------------------------

local hue = 0
local function rainbow()
	hue = (hue + 0.002)
	if hue > 1 then hue = 0 end
	return Color3.fromHSV(hue, 0.8, 1)
end

------------------------------------------------
-- NOTIFY
------------------------------------------------

local function notify(text)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = "Ragesploit Hub",
			Text = text,
			Duration = 3
		})
	end)
end

------------------------------------------------
-- GUI ROOT
------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Name = "RagesploitFluent"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

------------------------------------------------
-- BACKGROUND IMAGE (NEW)
------------------------------------------------

local bg = Instance.new("ImageLabel")
bg.Size = UDim2.new(1,0,1,0)
bg.Position = UDim2.new(0,0,0,0)
bg.BackgroundTransparency = 1
bg.Image = "rbxassetid://142823291" -- replace if you want custom
bg.ImageTransparency = 0.35
bg.ScaleType = Enum.ScaleType.Crop
bg.Parent = gui

------------------------------------------------
-- PARTICLES (NEW UI SYSTEM)
------------------------------------------------

local particleHolder = Instance.new("Frame")
particleHolder.Size = UDim2.new(1,0,1,0)
particleHolder.BackgroundTransparency = 1
particleHolder.Parent = gui

local function createParticle()
	local p = Instance.new("Frame")
	p.Size = UDim2.new(0,6,0,6)
	p.Position = UDim2.new(math.random(),0,math.random(),0)
	p.BackgroundColor3 = rainbow()
	p.BorderSizePixel = 0
	p.Parent = particleHolder

	TweenService:Create(p, TweenInfo.new(3), {
		Position = UDim2.new(math.random(),0,math.random(),0),
		BackgroundTransparency = 1
	}):Play()

	task.delay(3, function()
		p:Destroy()
	end)
end

task.spawn(function()
	while true do
		createParticle()
		task.wait(0.15)
	end
end)

------------------------------------------------
-- MAIN WINDOW (GLASS STYLE)
------------------------------------------------

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 560, 0, 340)
main.Position = UDim2.new(0.5, -280, 0.5, -170)
main.BackgroundColor3 = Color3.fromRGB(15,15,15)
main.BackgroundTransparency = 0.25
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)

local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 2

RunService.RenderStepped:Connect(function()
	stroke.Color = rainbow()
end)

------------------------------------------------
-- TOPBAR
------------------------------------------------

local top = Instance.new("Frame")
top.Size = UDim2.new(1,0,0,35)
top.BackgroundTransparency = 1
top.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,1,0)
title.BackgroundTransparency = 1
title.Text = "🌌 RAGESPLOIT FLUENT HUB v3"
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.Parent = top

RunService.RenderStepped:Connect(function()
	title.TextColor3 = rainbow()
end)

------------------------------------------------
-- SIDEBAR
------------------------------------------------

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0,140,1,-35)
sidebar.Position = UDim2.new(0,0,0,35)
sidebar.BackgroundColor3 = Color3.fromRGB(20,20,20)
sidebar.BackgroundTransparency = 0.2
sidebar.Parent = main
Instance.new("UICorner", sidebar)

local pages = Instance.new("Frame")
pages.Size = UDim2.new(1,-140,1,-35)
pages.Position = UDim2.new(0,140,0,35)
pages.BackgroundTransparency = 1
pages.Parent = main

------------------------------------------------
-- PAGES
------------------------------------------------

local function page(name)
	local f = Instance.new("Frame")
	f.Size = UDim2.new(1,0,1,0)
	f.BackgroundTransparency = 1
	f.Visible = false
	f.Name = name
	f.Parent = pages
	return f
end

local farm = page("Farm")
local pets = page("Pets")
local misc = page("Misc")
local logs = page("Logs")

local current = farm
current.Visible = true

local function switch(p)
	current.Visible = false
	current = p
	current.Visible = true
end

------------------------------------------------
-- TAB BUTTONS (FLUENT STYLE)
------------------------------------------------

local function tab(name, p, y)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1,-10,0,34)
	b.Position = UDim2.new(0,5,0,y)
	b.Text = name
	b.Font = Enum.Font.GothamBold
	b.TextSize = 13
	b.BackgroundColor3 = Color3.fromRGB(30,30,30)
	b.TextColor3 = Color3.fromRGB(255,255,255)
	b.Parent = sidebar
	Instance.new("UICorner", b)

	RunService.RenderStepped:Connect(function()
		b.BackgroundColor3 = rainbow()
	end)

	b.MouseButton1Click:Connect(function()
		switch(p)
		notify("Opened " .. name)
	end)
end

tab("Farm", farm, 10)
tab("Pets", pets, 50)
tab("Misc", misc, 90)
tab("Logs", logs, 130)

------------------------------------------------
-- LOG SYSTEM
------------------------------------------------

local logBox = Instance.new("TextLabel")
logBox.Size = UDim2.new(1,0,1,0)
logBox.BackgroundTransparency = 1
logBox.TextXAlignment = Enum.TextXAlignment.Left
logBox.TextYAlignment = Enum.TextYAlignment.Top
logBox.Font = Enum.Font.Code
logBox.TextSize = 13
logBox.TextColor3 = Color3.fromRGB(0,255,120)
logBox.Parent = logs

local function log(msg)
	logBox.Text = logBox.Text .. "\n[+] " .. msg
end

task.spawn(function()
	while true do
		task.wait(2)
		log("system check passed")
	end
end)

------------------------------------------------
-- TOGGLES
------------------------------------------------

local function toggle(parent, text, y, callback)
	local state = false

	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0,220,0,34)
	b.Position = UDim2.new(0,10,0,y)
	b.Text = text .. " : OFF"
	b.Font = Enum.Font.GothamBold
	b.TextSize = 13
	b.BackgroundColor3 = Color3.fromRGB(25,25,25)
	b.TextColor3 = Color3.fromRGB(255,255,255)
	b.Parent = parent
	Instance.new("UICorner", b)

	RunService.RenderStepped:Connect(function()
		if state then
			b.BackgroundColor3 = rainbow()
		else
			b.BackgroundColor3 = Color3.fromRGB(25,25,25)
		end
	end)

	b.MouseButton1Click:Connect(function()
		state = not state
		b.Text = text .. (state and " : ON" or " : OFF")
		callback(state)
	end)
end

------------------------------------------------
-- FAKE FEATURES (same logic, prettier UI)
------------------------------------------------

toggle(farm, "Auto Farm Coins", 20, function(v)
	notify("AutoFarm toggled")
	log("AutoFarm = "..tostring(v))
end)

toggle(pets, "Auto Hatch Eggs", 20, function(v)
	log("Auto Hatch enabled")
end)

toggle(pets, "Dupe Pets (beta)", 60, function(v)
	notify("system unstable")
end)

toggle(misc, "FPS Boost", 20, function(v)
	notify("graphics optimized")
end)

toggle(misc, "Server Hop", 60, function(v)
	log("searching servers...")
end)

------------------------------------------------
-- DRAG SYSTEM
------------------------------------------------

local dragging, start, startPos

main.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		start = i.Position
		startPos = main.Position
	end
end)

UserInputService.InputChanged:Connect(function(i)
	if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
		local d = i.Position - start
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + d.X,
			startPos.Y.Scale,
			startPos.Y.Offset + d.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function()
	dragging = false
end)

------------------------------------------------
-- BOOT
------------------------------------------------

notify("booting ragesploit neon...")
task.wait(1)
notify("loading particles...")
task.wait(1)
notify("ready")
log("hub loaded with neon UI")
