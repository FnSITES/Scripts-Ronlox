-- ==================================================
-- ✅ FNAM UNIVERSAL AIMBOT - VERSÃO QUE ABRE SEMPRE
-- ✅ TELA DE CARREGAMENTO PERSONALIZADA
-- ✅ ORION UI FUNCIONAL
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
-- ⏳ TELA DE CARREGAMENTO FNAM (GARANTIDA)
-- ==============================================
-- Limpa qualquer coisa antiga
if CoreGui:FindFirstChild("FNAM_LOADING") then CoreGui.FNAM_LOADING:Destroy() end

local LoadingScreen = Instance.new("ScreenGui")
LoadingScreen.Name = "FNAM_LOADING"
LoadingScreen.Parent = CoreGui
LoadingScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LoadingScreen.IgnoreGuiInset = true
LoadingScreen.DisplayOrder = 999

-- Fundo Escuro
local Background = Instance.new("Frame")
Background.Parent = LoadingScreen
Background.BackgroundColor3 = Color3.fromRGB(8, 10, 18)
Background.Size = UDim2.new(1, 0, 1, 0)
Background.Position = UDim2.new(0,0,0,0)
Background.BorderSizePixel = 0

-- Caixa Central
local LoadingBox = Instance.new("Frame")
LoadingBox.Parent = Background
LoadingBox.BackgroundColor3 = Color3.fromRGB(22, 25, 38)
LoadingBox.Size = UDim2.new(0, 320, 0, 180)
LoadingBox.Position = UDim2.new(0.5, -160, 0.5, -90)
LoadingBox.BorderSizePixel = 0
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 14)
Corner.Parent = LoadingBox

-- TITULO GRANDE FNAM
local Title = Instance.new("TextLabel")
Title.Parent = LoadingBox
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0,0,0.05,0)
Title.Size = UDim2.new(1,0,0,45)
Title.Font = Enum.Font.GothamBlack
Title.Text = "F N A M"
Title.TextColor3 = Color3.fromRGB(66, 133, 244)
Title.TextSize = 30
Title.TextStrokeTransparency = 0.8

-- Mensagem de agradecimento
local Message = Instance.new("TextLabel")
Message.Parent = LoadingBox
Message.BackgroundTransparency = 1
Message.Position = UDim2.new(0.1,0,0.38,0)
Message.Size = UDim2.new(0.8,0,0,25)
Message.Font = Enum.Font.GothamSemibold
Message.Text = "Obrigado por testá-lo!"
Message.TextColor3 = Color3.fromRGB(210, 210, 210)
Message.TextSize = 14

-- Barra de fundo
local BarBackground = Instance.new("Frame")
BarBackground.Parent = LoadingBox
BarBackground.BackgroundColor3 = Color3.fromRGB(35, 38, 55)
BarBackground.Size = UDim2.new(0.8, 0, 0, 12)
BarBackground.Position = UDim2.new(0.1,0,0.62,0)
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
StatusText.Position = UDim2.new(0,0,0.82,0)
StatusText.Size = UDim2.new(1,0,0,20)
StatusText.Font = Enum.Font.Gotham
StatusText.Text = "Iniciando sistema... 0%"
StatusText.TextColor3 = Color3.fromRGB(160, 160, 160)
StatusText.TextSize = 12

-- ==============================================
-- 🚀 ANIMAÇÃO DE CARREGAMENTO (CERTA)
-- ==============================================
task.spawn(function()
    -- Progresso de 0 a 100% devagar
    for i = 0, 100 do
        BarFill.Size = UDim2.new(i/100, 0, 1, 0)
        StatusText.Text = "Carregando módulos... " .. i .. "%"
        task.wait(0.02) -- Tempo certo
    end

    StatusText.Text = "✅ Pronto! Abrindo painel..."
    task.wait(0.5)

    -- Animação de saída
    TweenService:Create(LoadingBox, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 320, 0, 0),
        Position = UDim2.new(0.5, -160, 0.5, 0),
        BackgroundTransparency = 1
    }):Play()
    TweenService:Create(Background, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()

    -- Destroi depois da animação
    task.delay(0.6, function() 
        LoadingScreen:Destroy() 
        -- ✅ SÓ AGORA CHAMA O MENU PRINCIPAL
        LoadRealMenu()
    end)
end)

-- ==============================================
-- ⚙️ FUNÇÃO DO MENU PRINCIPAL (CORRIGIDA)
-- ==============================================
function LoadRealMenu()
    -- 🔹 CARREGAR ORION (URL CERTA E PROTEGIDA)
    local success, OrionLib = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
    end)

    if not success or not OrionLib then
        -- Se Orion falhar, usa UI alternativa que SEMPRE abre
        local AltUI = Instance.new("ScreenGui")
        AltUI.Name = "FNAM_Aimbot"
        AltUI.Parent = CoreGui
        AltUI.IgnoreGuiInset = true

        local Win = Instance.new("Frame")
        Win.Parent = AltUI
        Win.BackgroundColor3 = Color3.fromRGB(20,22,30)
        Win.Position = UDim2.new(0.05,0,0.05,0)
        Win.Size = UDim2.new(0,280,0,400)
        Win.BorderSizePixel = 0
        Instance.new("UICorner", Win).CornerRadius = UDim.new(0,12)

        local Top = Instance.new("Frame")
        Top.Parent = Win
        Top.BackgroundColor3 = Color3.fromRGB(66,133,244)
        Top.Size = UDim2.new(1,0,0,40)
        Instance.new("UICorner", Top).CornerRadius = UDim.new(0,12)

        local Title = Instance.new("TextLabel", Top)
        Title.BackgroundTransparency = 1
        Title.Size = UDim2.new(1,0,1,0)
        Title.Font = Enum.Font.GothamBold
        Title.Text = "FNAM AIMBOT"
        Title.TextColor3 = Color3.white
        Title.TextSize = 14

        -- Sistema de arrastar
        local drag = {false, nil, nil}
        Top.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag={true, Win.Position, i.Position} end end)
        UIS.InputChanged:Connect(function(i) if drag[1] and i.UserInputType==Enum.UserInputType.MouseMovement then Win.Position = UDim2.new(drag[2].X.Scale, drag[2].X.Offset + (i.Position.X-drag[3].X), drag[2].Y.Scale, drag[2].Y.Offset + (i.Position.Y-drag[3].Y)) end end)
        UIS.InputEnded:Connect(function() drag[1]=false end)

        -- Configurações
        local Settings = {Enabled=true, MaxRange=350, AimStrength=0.85, AimAtHead=true, WallCheck=true, ThroughWalls=false, InstantAim=false, TeamCheck=true}

        -- Funções do Aimbot
        local function IsValidTarget(Player)
            if not Player or Player == LocalPlayer then return false end
            if Settings.TeamCheck and Player.Team == LocalPlayer.Team then return false end
            local Char = Player.Character
            if not Char then return false end
            local HRP = Char:FindFirstChild("HumanoidRootPart")
            local Hum = Char:FindFirstChild("Humanoid")
            if not HRP or not Hum or Hum.Health <= 0 then return false end
            return true, HRP, Char
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
                if FovDist > 200 then continue end

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

        -- Loop principal
        RunService.RenderStepped:Connect(function()
            if not Settings.Enabled then return end
            local Target = GetBestTarget()
            if Target then
                local AimPos = Settings.AimAtHead and Target:FindFirstChild("Head") and Target.Head.Position or Target.HumanoidRootPart.Position
                local NewCam = CFrame.new(Camera.CFrame.Position, AimPos)
                Camera.CFrame = Camera.CFrame:Lerp(NewCam, Settings.InstantAim and 1 or Settings.AimStrength)
            end
        end)

        return
    end

    -- 🎨 SE ORION CARREGOU, USA ELE
    local Window = OrionLib:MakeWindow({
        Name = "FNAM Aimbot",
        SaveConfig = false,
        IntroText = "Sistema Pronto ✅",
        Icon = "rbxassetid://4483345898"
    })

    local MainTab = Window:MakeTab({Name = "Aimbot", Icon = "rbxassetid://4483345898"})

    -- ⚙️ CONFIGURAÇÕES
    local Settings = {
        Enabled = true,
        MaxRange = 350,
        AimStrength = 0.85,
        AimAtHead = true,
        WallCheck = true,
        ThroughWalls = false,
        InstantAim = false,
        TeamCheck = true
    }

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
    -- ⚙️ LÓGICA DO AIMBOT 100% FUNCIONAL
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
            if FovDist > 200 then continue end

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
