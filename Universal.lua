
-- ==================================================
-- ✅ FNAM UNIVERSAL AIMBOT
-- ✅ TELA DE CARREGAMENTO PERSONALIZADA
-- ✅ ORION UI | 100% FUNCIONAL
-- ✅ TUDO EM INGLÊS
-- ==================================================

-- 🔹 SERVIÇOS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- ==============================================
-- ⏳ TELA DE CARREGAMENTO FNAM (PERSONALIZADA)
-- ==============================================
local LoadingScreen = Instance.new("ScreenGui")
LoadingScreen.Name = "FNAM_Loading"
LoadingScreen.Parent = CoreGui
LoadingScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LoadingScreen.IgnoreGuiInset = true

-- Fundo Escuro
local Background = Instance.new("Frame")
Background.Parent = LoadingScreen
Background.BackgroundColor3 = Color3.fromRGB(10, 12, 20)
Background.Size = UDim2.new(1, 0, 1, 0)
Background.Position = UDim2.new(0,0,0,0)

-- Caixa Central
local LoadingBox = Instance.new("Frame")
LoadingBox.Parent = Background
LoadingBox.BackgroundColor3 = Color3.fromRGB(25, 28, 40)
LoadingBox.Size = UDim2.new(0, 320, 0, 180)
LoadingBox.Position = UDim2.new(0.5, -160, 0.5, -90)
LoadingBox.BorderSizePixel = 0
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = LoadingBox

-- TITULO GRANDE FNAM
local Title = Instance.new("TextLabel")
Title.Parent = LoadingBox
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0,0,0.05,0)
Title.Size = UDim2.new(1,0,0,40)
Title.Font = Enum.Font.GothamBlack
Title.Text = "F N A M"
Title.TextColor3 = Color3.fromRGB(66, 133, 244)
Title.TextSize = 28

-- Mensagem de agradecimento
local Message = Instance.new("TextLabel")
Message.Parent = LoadingBox
Message.BackgroundTransparency = 1
Message.Position = UDim2.new(0.1,0,0.35,0)
Message.Size = UDim2.new(0.8,0,0,30)
Message.Font = Enum.Font.GothamSemibold
Message.Text = "Obrigado por testá-lo!"
Message.TextColor3 = Color3.fromRGB(200, 200, 200)
Message.TextSize = 14

-- Barra de fundo
local BarBackground = Instance.new("Frame")
BarBackground.Parent = LoadingBox
BarBackground.BackgroundColor3 = Color3.fromRGB(40, 44, 60)
BarBackground.Size = UDim2.new(0.8, 0, 0, 12)
BarBackground.Position = UDim2.new(0.1,0,0.6,0)
BarBackground.BorderSizePixel = 0
Corner:Clone().Parent = BarBackground

-- Barra de progresso (que enche)
local BarFill = Instance.new("Frame")
BarFill.Parent = BarBackground
BarFill.BackgroundColor3 = Color3.fromRGB(66, 133, 244)
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.Position = UDim2.new(0,0,0,0)
BarFill.BorderSizePixel = 0
Corner:Clone().Parent = BarFill

-- Texto de status
local StatusText = Instance.new("TextLabel")
StatusText.Parent = LoadingBox
StatusText.BackgroundTransparency = 1
StatusText.Position = UDim2.new(0,0,0.8,0)
StatusText.Size = UDim2.new(1,0,0,20)
StatusText.Font = Enum.Font.Gotham
StatusText.Text = "Carregando... 0%"
StatusText.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusText.TextSize = 12

-- 🚀 ANIMAÇÃO DO CARREGAMENTO
task.spawn(function()
    -- Progresso de 0 a 100%
    for i = 0, 100 do
        BarFill.Size = UDim2.new(i/100, 0, 1, 0)
        StatusText.Text = "Carregando... " .. i .. "%"
        task.wait(0.025) -- Tempo para encher devagar
    end

    -- Ao chegar 100%
    StatusText.Text = "✅ Carregado com sucesso!"
    TweenService:Create(LoadingBox, TweenInfo.new(0.5), {
        Size = UDim2.new(0, 320, 0, 0),
        Position = UDim2.new(0.5, -160, 0.5, 0),
        BackgroundTransparency = 1
    }):Play()
    TweenService:Create(Background, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()

    -- Destroi tela de carregamento
    task.delay(0.6, function() LoadingScreen:Destroy() end)

    -- ✅ SÓ AGORA CARREGA O HACK DE VERDADE
    LoadMainHack()
end)

-- ==============================================
-- ⚙️ FUNÇÃO PRINCIPAL (SÓ ABRE DEPOIS DO CARREGAMENTO)
-- ==============================================
function LoadMainHack()
    -- 🔹 CARREGAR ORION UI (FUNCIONAL)
    local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
    if not OrionLib then return end

    -- ⚙️ CONFIGURAÇÕES (TODAS EM INGLÊS)
    local Settings = {
        Enabled = true,
        MaxRange = 350,
        AimStrength = 0.85,
        AimAtHead = true,
        WallCheck = true,       -- Only aim if visible
        ThroughWalls = false,   -- Aim through walls
        InstantAim = false,     -- Smooth or Fast
        TeamCheck = true,       -- Ignore teammates
        FOV = 200               -- Aim area size
    }

    -- 🎨 CRIAR MENU
    local Window = OrionLib:MakeWindow({
        Name = "FNAM Aimbot",
        SaveConfig = false,
        IntroText = "Sistema Ativado",
        Icon = "rbxassetid://4483345898"
    })

    -- ABA PRINCIPAL
    local MainTab = Window:MakeTab({
        Name = "Aimbot",
        Icon = "rbxassetid://4483345898"
    })

    -- 📌 OPÇÕES
    MainTab:AddSection({Name = "MAIN SETTINGS"})

    MainTab:AddToggle({
        Name = "Enable Aimbot",
        Default = Settings.Enabled,
        Callback = function(v) Settings.Enabled = v end
    })

    MainTab:AddSlider({
        Name = "Max Range",
        Min = 50, Max = 800, Default = Settings.MaxRange,
        Color = Color3.fromRGB(59, 130, 246),
        Callback = function(v) Settings.MaxRange = v end
    })

    MainTab:AddSlider({
        Name = "Aim Strength",
        Min = 0.1, Max = 1, Default = Settings.AimStrength,
        Color = Color3.fromRGB(34, 197, 94),
        Callback = function(v) Settings.AimStrength = v end
    })

    MainTab:AddSlider({
        Name = "FOV Size",
        Min = 50, Max = 400, Default = Settings.FOV,
        Color = Color3.fromRGB(239, 68, 68),
        Callback = function(v) Settings.FOV = v end
    })

    MainTab:AddSection({Name = "WALL SYSTEM"})

    MainTab:AddToggle({
        Name = "Aim At Head",
        Default = Settings.AimAtHead,
        Callback = function(v) Settings.AimAtHead = v end
    })

    MainTab:AddToggle({
        Name = "Wall Check",
        Default = Settings.WallCheck,
        Callback = function(v)
            Settings.WallCheck = v
            if v then Settings.ThroughWalls = false end
        end
    })

    MainTab:AddToggle({
        Name = "Through Walls",
        Default = Settings.ThroughWalls,
        Callback = function(v)
            Settings.ThroughWalls = v
            if v then Settings.WallCheck = false end
        end
    })

    MainTab:AddToggle({
        Name = "Instant Aim",
        Default = Settings.InstantAim,
        Callback = function(v) Settings.InstantAim = v end
    })

    MainTab:AddToggle({
        Name = "Team Check",
        Default = Settings.TeamCheck,
        Callback = function(v) Settings.TeamCheck = v end
    })

    -- ==============================================
    -- ⚙️ LÓGICA DO AIMBOT (FUNCIONAL)
    -- ==============================================
    local function IsValidTarget(Player)
        if not Player or Player == LocalPlayer then return false end
        if Settings.TeamCheck and Player.Team == LocalPlayer.Team then return false end
        local Character = Player.Character
        if not Character then return false end
        local HRP = Character:FindFirstChild("HumanoidRootPart")
        local Hum = Character:FindFirstChild("Humanoid")
        if not HRP or not Hum or Hum.Health <= 0 then return false end
        return true, HRP, Character
    end

    local function IsVisible(From, ToPos)
        local Ray = Ray.new(From, (ToPos - From).Unit * (ToPos - From).Magnitude)
        local Hit = Workspace:FindPartOnRayWithIgnoreList(Ray, {LocalPlayer.Character})
        return not Hit or Hit:IsDescendantOf(ToPos.Parent)
    end

    local function GetBestTarget()
        local Best, BestDist = nil, math.huge
        local CamPos = Camera.CFrame.Position
        local Center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

        for _, Plr in pairs(Players:GetPlayers()) do
            local Ok, HRP, Char = IsValidTarget(Plr)
            if not Ok then continue end

            local Dist = (CamPos - HRP.Position).Magnitude
            if Dist > Settings.MaxRange then continue end

            local ScreenPos, OnScreen = Camera:WorldToViewportPoint(HRP.Position)
            if not OnScreen then continue end
            local FovDist = (Vector2.new(ScreenPos.X, ScreenPos.Y) - Center).Magnitude
            if FovDist > Settings.FOV then continue end

            local Can = false
            if Settings.ThroughWalls then Can = true
            elseif Settings.WallCheck then Can = IsVisible(CamPos, HRP.Position)
            else Can = true end

            if Can and Dist < BestDist then
                BestDist = Dist
                Best = Char
            end
        end
        return Best
    end

    -- LOOP PRINCIPAL
    RunService.RenderStepped:Connect(function()
        if not Settings.Enabled then return end
        local Target = GetBestTarget()
        if Target then
            local AimPos = Settings.AimAtHead and Target:FindFirstChild("Head") and Target.Head.Position or Target.HumanoidRootPart.Position
            local NewCam = CFrame.new(Camera.CFrame.Position, AimPos)
            Camera.CFrame = Camera.CFrame:Lerp(NewCam, Settings.InstantAim and 1 or Settings.AimStrength)
        end
    end)

    OrionLib:Init()
end
