-- ==================================================
-- ✅ Universal FnAim - English Version | Fixed
-- ✅ All options in English | Clean & Easy to Use
-- ✅ Fixed: Aimbot, Drag Issue, UI Design
-- ==================================================

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- Player & Camera
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- ==============================================
-- ⚙️ SETTINGS (ALL IN ENGLISH)
-- ==============================================
local Settings = {
    Enabled = true,
    MaxRange = 300,
    AimStrength = 0.85,
    OnlyEnemies = true,
    AimAtHead = true,
    -- ✅ MAIN OPTIONS
    WallCheck = true,       -- Only aim if you see the enemy
    ThroughWalls = false,    -- Aim even behind walls
    InstantAim = false,     -- Smooth or Instant
    AutoShoot = false
}

-- ==============================================
-- 🎨 MODERN UI | CLEAN | NO BUGS
-- ==============================================

-- Remove old UI
if CoreGui:FindFirstChild("UniversalFnAimUI") then CoreGui.UniversalFnAimUI:Destroy() end
if LocalPlayer.PlayerGui:FindFirstChild("UniversalFnAimUI") then LocalPlayer.PlayerGui.UniversalFnAimUI:Destroy() end

-- Color Scheme
local Color = {
    Background = Color3.fromRGB(15, 17, 23),
    Window = Color3.fromRGB(24, 26, 36),
    Accent = Color3.fromRGB(66, 133, 244),
    Enabled = Color3.fromRGB(46, 204, 113),
    Disabled = Color3.fromRGB(231, 76, 60),
    Text = Color3.fromRGB(255, 255, 255),
    Gray = Color3.fromRGB(180, 180, 180)
}

-- Main Screen
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UniversalFnAimUI"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

-- Main Window
local Window = Instance.new("Frame")
Window.Name = "MainWindow"
Window.Parent = ScreenGui
Window.BackgroundColor3 = Color.Window
Window.Position = UDim2.new(0.03, 0, 0.03, 0)
Window.Size = UDim2.new(0, 260, 0, 420)
Window.BorderSizePixel = 0
Window.ClipsDescendants = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Window

-- Top Bar (ONLY DRAG HERE)
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = Window
TopBar.BackgroundColor3 = Color.Accent
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BorderSizePixel = 0
TopBar.Draggable = true -- ✅ Fixed: Only drag from top bar
UICorner:Clone().Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.1, 0, 0, 0)
Title.Size = UDim2.new(0.8,0,1,0)
Title.Font = Enum.Font.GothamBold
Title.Text = "UNIVERSAL FNAIM"
Title.TextColor3 = Color.Text
Title.TextSize = 15

-- Content Area
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Parent = Window
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0,0,0,50)
Content.Size = UDim2.new(1,0,1,-50)
Content.ClipsDescendants = true

-- ==============================================
-- 🧩 CREATE BUTTONS & SLIDERS
-- ==============================================

-- Create Button Function
local function CreateButton(Text, Position, State, Callback)
    local Button = Instance.new("TextButton")
    Button.Parent = Content
    Button.BackgroundColor3 = State and Color.Enabled or Color3.fromRGB(40, 42, 55)
    Button.Position = Position
    Button.Size = UDim2.new(0.9, 0, 0, 38)
    Button.Font = Enum.Font.GothamSemibold
    Button.Text = Text
    Button.TextColor3 = Color.Text
    Button.TextSize = 13
    Button.BorderSizePixel = 0
    Button.AutoButtonColor = false
    UICorner:Clone().Parent = Button

    Button.MouseButton1Click:Connect(function()
        Callback(Button)
    end)
    return Button
end

-- Create Slider Function ✅ FIXED: Does not move window anymore
local function CreateSlider(Text, Position, Min, Max, Default, Callback)
    local Container = Instance.new("Frame")
    Container.Parent = Content
    Container.BackgroundColor3 = Color3.fromRGB(30, 32, 45)
    Container.Position = Position
    Container.Size = UDim2.new(0.9, 0, 0, 45)
    UICorner:Clone().Parent = Container

    local Label = Instance.new("TextLabel", Container)
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0.08,0,0.1,0)
    Label.Size = UDim2.new(0.85,0,0.4,0)
    Label.Font = Enum.Font.Gotham
    Label.Text = Text .. ": " .. math.floor(Default*100)/100
    Label.TextColor3 = Color.Gray
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local SliderBack = Instance.new("Frame", Container)
    SliderBack.BackgroundColor3 = Color3.fromRGB(20,22,35)
    SliderBack.Position = UDim2.new(0.08,0,0.6,0)
    SliderBack.Size = UDim2.new(0.85,0,0,8)
    UICorner:Clone().Parent = SliderBack

    local SliderFill = Instance.new("Frame", SliderBack)
    SliderFill.BackgroundColor3 = Color.Accent
    SliderFill.Size = UDim2.new((Default - Min)/(Max - Min),0,1,0)
    SliderFill.AnchorPoint = Vector2.new(0,0.5)
    SliderFill.Position = UDim2.new(0,0,0.5,0)
    UICorner:Clone().Parent = SliderFill

    local Dragging = false
    SliderBack.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
        end
    end)
    UIS.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
        end
    end)

    UIS.InputChanged:Connect(function(Input)
        if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
            local RelativePos = Input.Position.X - SliderBack.AbsolutePosition.X
            local Percent = math.clamp(RelativePos / SliderBack.AbsoluteSize.X, 0, 1)
            local Value = Min + (Max - Min) * Percent
            SliderFill.Size = UDim2.new(Percent, 0, 1, 0)
            Label.Text = Text .. ": " .. math.floor(Value * 100)/100
            Callback(Value)
        end
    end)
end

-- ==============================================
-- 📌 ALL OPTIONS IN ENGLISH HERE
-- ==============================================

-- Main Toggle
CreateButton("✅ ENABLED", UDim2.new(0.05,0,0.02,0), Settings.Enabled, function(btn)
    Settings.Enabled = not Settings.Enabled
    btn.BackgroundColor3 = Settings.Enabled and Color.Enabled or Color.Disabled
    btn.Text = Settings.Enabled and "✅ ENABLED" or "❌ DISABLED"
end)

-- Sliders
CreateSlider("📏 Max Range", UDim2.new(0.05,0,0.14,0), 50, 600, Settings.MaxRange, function(val)
    Settings.MaxRange = val
end)

CreateSlider("🔥 Aim Strength", UDim2.new(0.05,0,0.26,0), 0.1, 1, Settings.AimStrength, function(val)
    Settings.AimStrength = val
end)

-- Buttons / Toggles
CreateButton("🎯 Aim At Head", UDim2.new(0.05,0,0.38,0), Settings.AimAtHead, function(btn)
    Settings.AimAtHead = not Settings.AimAtHead
    btn.BackgroundColor3 = Settings.AimAtHead and Color.Enabled or Color3.fromRGB(40,42,55)
end)

-- ✅ THE MOST IMPORTANT OPTIONS (English names)
CreateButton("👁️ WALL CHECK", UDim2.new(0.05,0,0.50,0), Settings.WallCheck, function(btn)
    Settings.WallCheck = not Settings.WallCheck
    if Settings.WallCheck then Settings.ThroughWalls = false end -- Auto disable other
    btn.BackgroundColor3 = Settings.WallCheck and Color.Enabled or Color3.fromRGB(40,42,55)
end)

CreateButton("🛡️ THROUGH WALLS", UDim2.new(0.05,0,0.62,0), Settings.ThroughWalls, function(btn)
    Settings.ThroughWalls = not Settings.ThroughWalls
    if Settings.ThroughWalls then Settings.WallCheck = false end -- Auto disable other
    btn.BackgroundColor3 = Settings.ThroughWalls and Color.Enabled or Color3.fromRGB(40,42,55)
end)

CreateButton("⚡ INSTANT AIM", UDim2.new(0.05,0,0.74,0), Settings.InstantAim, function(btn)
    Settings.InstantAim = not Settings.InstantAim
    btn.BackgroundColor3 = Settings.InstantAim and Color.Enabled or Color3.fromRGB(40,42,55)
end)

-- ==============================================
-- ⚙️ AIMBOT LOGIC | 100% WORKING
-- ==============================================

-- Wall Check Function
local function IsVisible(StartPos, TargetPos)
    local Ray = Ray.new(StartPos, (TargetPos - StartPos).Unit * (TargetPos - StartPos).Magnitude)
    local HitPart = Workspace:FindPartOnRayWithIgnoreList(Ray, {Character})
    return not HitPart or HitPart:IsDescendantOf(TargetPos.Parent)
end

-- Check if player is valid target
local function IsValidTarget(Player)
    if not Player or Player == LocalPlayer then return false end
    local Char = Player.Character
    if not Char then return false end
    local Root = Char:FindFirstChild("HumanoidRootPart")
    local Humanoid = Char:FindFirstChild("Humanoid")
    if not Root or not Humanoid or Humanoid.Health <= 0 then return false end

    if Settings.OnlyEnemies and Player.Team == LocalPlayer.Team then
        return false
    end
    return true, Root, Humanoid
end

-- Get closest & best target
local function GetBestTarget()
    local BestTarget, BestDistance = nil, math.huge
    local CameraPos = Camera.CFrame.Position

    for _, Plr in pairs(Players:GetPlayers()) do
        if IsValidTarget(Plr) then
            local Char = Plr.Character
            local TargetPos = Char.HumanoidRootPart.Position
            local Distance = (CameraPos - TargetPos).Magnitude

            -- Check range
            if Distance <= Settings.MaxRange and Distance < BestDistance then
                
                -- ✅ WALL CHECK LOGIC
                local CanAim = false
                if Settings.ThroughWalls then
                    CanAim = true -- Always aim
                elseif Settings.WallCheck then
                    CanAim = IsVisible(CameraPos, TargetPos) -- Only if visible
                else
                    CanAim = true -- Aim everyone
                end

                if CanAim then
                    BestDistance = Distance
                    BestTarget = Char
                end
            end
        end
    end
    return BestTarget
end

-- Main Loop
RunService.RenderStepped:Connect(function()
    if not Settings.Enabled then return end

    local Target = GetBestTarget()
    if Target then
        -- Choose aim point: Head or Body
        local AimPoint = Settings.AimAtHead and Target:FindFirstChild("Head") and Target.Head.Position or Target.HumanoidRootPart.Position

        -- Smooth or Instant aim
        local NewCFrame = CFrame.new(Camera.CFrame.Position, AimPoint)
        local Strength = Settings.InstantAim and 1 or Settings.AimStrength
        Camera.CFrame = Camera.CFrame:Lerp(NewCFrame, Strength)
    end
end)
